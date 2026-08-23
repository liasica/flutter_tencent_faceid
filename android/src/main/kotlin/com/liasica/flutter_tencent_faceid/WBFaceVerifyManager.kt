package com.liasica.flutter_tencent_faceid

import android.app.Activity
import android.os.Bundle
import com.tencent.cloud.huiyansdkface.facelight.api.WbCloudFaceContant
import com.tencent.cloud.huiyansdkface.facelight.api.WbCloudFaceVerifySdk
import com.tencent.cloud.huiyansdkface.facelight.api.listeners.WbCloudFaceVerifyLoginListener
import com.tencent.cloud.huiyansdkface.facelight.api.result.WbFaceError
import com.tencent.cloud.huiyansdkface.facelight.process.FaceVerifyStatus
import io.flutter.Log
import io.flutter.plugin.common.MethodChannel

class WBFaceVerifyManager {
    companion object {
        const val LOG_TAG = "[WBFaceVerifyManager]"

        fun start(activity: Activity, arguments: Map<*, *>?, result: MethodChannel.Result) {
            try {
                arguments?.let {
                    val appId = arguments["appId"] as? String
                    val userId = arguments["userId"] as? String
                    val nonce = arguments["nonce"] as? String
                    val sign = arguments["sign"] as? String
                    val orderNo = arguments["orderNo"] as? String
                    val licence = arguments["licence"] as? String
                    val version = arguments["version"] as? String
                    val faceId = arguments["faceId"] as? String

                    // 人脸识别参数配置
                    val inputData = WbCloudFaceVerifySdk.InputData(
                        faceId,
                        orderNo,
                        appId,
                        version,
                        nonce,
                        userId,
                        sign,
                        FaceVerifyStatus.Mode.GRADE,
                        licence,
                    )

                    val data = Bundle()

                    // 设置选择的比对类型：默认为权威库网纹图片比对，设置权威数据源对比
                    data.putString(WbCloudFaceContant.COMPARE_TYPE, WbCloudFaceContant.ID_CARD)

                    // 是否需要录制上传视频：默认不需要，此处设置为需要
                    data.putBoolean(WbCloudFaceContant.VIDEO_UPLOAD, true)

                    // 是否对录制视频进行检查：默认不检查，此处设置不检查
                    data.putBoolean(WbCloudFaceContant.VIDEO_CHECK, false)

                    // 设置是否打开语音提示：默认关闭，此处设置为开启
                    data.putBoolean(WbCloudFaceContant.PLAY_VOICE, true)

                    data.putSerializable(WbCloudFaceContant.INPUT_DATA, inputData)

                    WbCloudFaceVerifySdk.getInstance().initSdk(activity, data, object : WbCloudFaceVerifyLoginListener {
                        override fun onLoginSuccess() {
                            WbCloudFaceVerifySdk.getInstance().startWbFaceVerifySdk(activity) { faceVerifyResult ->
                                if (faceVerifyResult == null) {
                                    result.success(null)
                                } else {
                                    result.success(
                                        mapOf(
                                            "isSuccess" to faceVerifyResult.isSuccess,
                                            "sign" to faceVerifyResult.sign,
                                            "liveRate" to faceVerifyResult.liveRate,
                                            "similarity" to faceVerifyResult.similarity,
                                            "error" to faceVerifyResult.error?.toString(),
                                        )
                                    )
                                }

                                // 释放资源
                                WbCloudFaceVerifySdk.getInstance().release()
                            }
                        }

                        override fun onLoginFailed(error: WbFaceError?) {
                            // 释放资源
                            WbCloudFaceVerifySdk.getInstance().release()

                            Log.e(LOG_TAG, "onLoginFailed")
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
