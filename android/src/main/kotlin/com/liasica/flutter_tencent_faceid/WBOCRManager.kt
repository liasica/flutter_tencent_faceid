package com.liasica.flutter_tencent_faceid

import android.app.Activity
import android.os.Bundle
import com.tencent.cloud.huiyansdkocr.WbCloudOcrSDK
import com.tencent.cloud.huiyansdkocr.WbCloudOcrSDK.InputData
import com.tencent.cloud.huiyansdkocr.net.resultmodel.EXIDCardResult
import com.tencent.cloud.huiyansdkocr.tools.WbCloudOcrConfig
import io.flutter.Log
import io.flutter.plugin.common.MethodChannel
import java.io.File


class WBOCRManager {
    companion object {
        private const val LOG_TAG = "[WBOCRManager]"

        fun start(activity: Activity, arguments: Map<*, *>?, result: MethodChannel.Result) {
            try {
                arguments?.let {
                    val appId = arguments["appId"] as? String
                    val userId = arguments["userId"] as? String
                    val nonce = arguments["nonce"] as? String
                    val sign = arguments["sign"] as? String
                    val orderNo = arguments["orderNo"] as? String
                    val version = arguments["version"] as? String

                    WbCloudOcrConfig.getInstance().isRetCrop = true
                    WbCloudOcrConfig.getInstance().isRetPhoto = true

                    // OCR参数配置
                    val data = Bundle()
                    val inputData = InputData(
                        orderNo,
                        appId,
                        version,
                        nonce,
                        userId,
                        sign,
                    )
                    data.putSerializable(WbCloudOcrSDK.INPUT_DATA, inputData)

                    // 设置超时时间 60s
                    data.putLong(WbCloudOcrSDK.SCAN_TIME, 60000)

                    WbCloudOcrSDK.getInstance().init(activity, WbCloudOcrSDK.WBOCRTYPEMODE.WBOCRSDKTypeContinus, data, object : WbCloudOcrSDK.OcrLoginListener {
                        // 登录成功，调起OCR
                        override fun onLoginSuccess() {
                            Log.i(LOG_TAG, "onLoginSuccess")

                            WbCloudOcrSDK.getInstance().startActivityForOcr(activity) { _, _, parcel ->
                                Log.i(LOG_TAG, "onFinish")
                                if (parcel != null) {
                                    val exidCardResult = parcel as EXIDCardResult
                                    result.success(mapOf(
                                        "idcard" to exidCardResult.cardNum,
                                        "name" to exidCardResult.name,
                                        "sex" to exidCardResult.sex,
                                        "nation" to exidCardResult.nation,
                                        "address" to exidCardResult.address,
                                        "birth" to exidCardResult.birth,
                                        "authority" to exidCardResult.office,
                                        "validDate" to exidCardResult.validDate,
                                        "frontWarning" to exidCardResult.frontWarning,
                                        "backWarning" to exidCardResult.backWarning,
                                        "frontClarity" to exidCardResult.frontClarity,
                                        "backClarity" to exidCardResult.backClarity,
                                        "frontCode" to exidCardResult.frontCode,
                                        "frontMsg" to exidCardResult.frontMsg,
                                        "backCode" to exidCardResult.backCode,
                                        "backMsg" to exidCardResult.backMsg,
                                        "frontCrop" to exidCardResult.frontCropSrc?.let {
                                            Utils.convertImageFileToBase64(File(it))
                                        },
                                        "backCrop" to exidCardResult.backCropSrc?.let {
                                            Utils.convertImageFileToBase64(File(it))
                                        },
                                    ))
                                } else {
                                    result.success(null)
                                }
                            }
                        }

                        // 登录失败
                        override fun onLoginFailed(errorCode: String?, errorMsg: String?) {
                            Log.e(LOG_TAG, "onLoginFailed: $errorCode")
                            result.success(null)
                        }
                    })
                }
            } catch (e: Exception) {
                Log.e(LOG_TAG, e.toString())
                result.success(null)
            }
        }
    }
}
