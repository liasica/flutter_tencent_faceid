//
//  WBOCRManager.swift
//  flutter_tencent_faceid
//
//  Created by liasica on 2024/1/15.
//

import Flutter
import WBOCRService

public class WBOCRManager {
    static let LOG_TAG = "[WBOCRManager]"
    
    static var version: String {
        let version = WBOCRService.shared().sdkVersion
        print(LOG_TAG, "SDK Version:", WBOCRService.shared().sdkVersion)
        return version
    }
    
    static public func start(_ result: @escaping FlutterResult,
                             appId: String,
                             userId: String,
                             sign: String,
                             orderNo: String,
                             nonce: String,
                             version: String) {
        DispatchQueue.main.async {
            let config = WBOCRConfig.shared()
            config.retCrop = true
            config.timeoutInterval = 60
            
            WBOCRService.shared().initSDK(
                withSDKType: WBOCRCardType.WBOCRSDKTypeIDCardContinuous,
                appId: appId,
                nonce: nonce,
                userId: userId,
                sign: sign,
                orderNo: orderNo,
                version: version,
                succeed: {
                    print(LOG_TAG, "initSDK 成功，开始调起OCR")
                    WBOCRService.shared().start { resultModel, _ in
                        if let res = resultModel as? WBIDCardInfoModel {
                            result([
                                "idcard": res.idcard,
                                "name": res.name,
                                "sex": res.sex,
                                "nation": res.nation,
                                "address": res.address,
                                "birth": res.birth,
                                "authority": res.authority,
                                "validDate": res.validDate,
                                "frontWarning": res.frontWarning,
                                "backWarning": res.backWarning,
                                "frontClarity": res.frontClarity,
                                "backClarity": res.backClarity,
                                "frontCode": res.frontCode,
                                "frontMsg": res.frontMsg,
                                "backCode": res.backCode,
                                "backMsg": res.backMsg,
                                "frontCrop": res.frontCrop,
                                "backCrop": res.backCrop,
                            ])
                        } else {
                            result(nil)
                        }
                    } failed: { _, _ in
                        print(LOG_TAG, "startOCRService failed")
                        result(nil)
                    }
                },
                failed: { _, _ in
                    print(LOG_TAG, "initSDK 失败")
                    result(nil)
                }
            )
        }
    }
    
    private static func failure(_ result: @escaping FlutterResult, error: Error) {
        let err = error as NSError
        result(FlutterError(code: err.domain, message:  err.userInfo.first?.value as? String ?? err.userInfo.description, details: nil))
    }
}
