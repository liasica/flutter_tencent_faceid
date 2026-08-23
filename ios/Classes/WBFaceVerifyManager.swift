//
//  WBFaceVerify.swift
//  flutter_tencent_faceid
//
//  Created by liasica on 2024/1/16.
//

import Flutter
import TencentCloudHuiyanSDKFace

// MARK: - WBFaceVerifyCustomerServiceDelegate
public class WBFaceVerifyDelegate : NSObject, WBFaceVerifyCustomerServiceDelegate {
    var result: FlutterResult?

    public func wbfaceVerifyCustomerServiceDidFinished(with faceVerifyResult: WBFaceVerifyResult) {
        let error = faceVerifyResult.error
        let data: Dictionary<String, Any?> = [
            "isSuccess": faceVerifyResult.isSuccess,
            "sign": faceVerifyResult.sign,
            "liveRate": faceVerifyResult.liveRate,
            "similarity": faceVerifyResult.similarity,
            "error": error?.description,
            "errorDomain": error?.domain,
            "errorCode": error.map { String($0.code) },
            "errorDescription": error?.desc,
            "errorReason": error?.reason,
        ]

        result?(data)
    }
    
}

// MARK: - WBFaceVerifyManager
public class WBFaceVerifyManager : NSObject {
    
    let LOG_TAG = "[WBFaceVerify]"
    
    var result: FlutterResult
    
    init(_ result: @escaping FlutterResult) {
        self.result = result
    }
    
    deinit {
        
    }
    
    public func start(userId: String,
                      nonce: String,
                      sign: String,
                      appId: String,
                      orderNo: String,
                      licence: String,
                      version: String,
                      faceId: String,
                      optimalDomain: String
    ) {
        DispatchQueue.main.async {
            
            let config = WBFaceVerifySDKConfig()
            config.recordVideo = true
            config.isIpv6 = false
            config.useAdvanceCompare = false
            config.mute = false
            config.useWindowSecene = true
            config.optimalDomain = optimalDomain

            // 设置bundlePath
            config.bundlePath = config.bundlePath + "/Frameworks/flutter_tencent_faceid.framework"
            
            if let faceTrackerBundleDirPath = config.faceTrackerBundleDirPath {
                config.faceTrackerBundleDirPath = faceTrackerBundleDirPath + "/Frameworks/flutter_tencent_faceid.framework"
            }
            
            WBFaceVerifyCustomerService.sharedInstance().initSDK(withUserId: userId,
                                                                 nonce: nonce,
                                                                 sign: sign,
                                                                 appid: appId,
                                                                 orderNo: orderNo,
                                                                 apiVersion: version,
                                                                 licence: licence,
                                                                 faceId: faceId,
                                                                 sdkConfig: config) {
                
                if (!WBFaceVerifyCustomerService.sharedInstance().startWbFaceVeirifySdk()) {
                    self.failure(
                        "WBFaceVerify",
                        "sdk_start_failed",
                        "人脸识别 SDK 拉起失败",
                        "startWbFaceVeirifySdk 返回 false"
                    )
                }
            } failure: { error in
                self.failure(error.domain, String(error.code), error.desc, error.reason)
            }
            
        }
    }
    
    func failure (_ domain: String, _ code: String, _ message: String, _ reason: String) {
        let data: Dictionary<String, Any?> = [
            "isSuccess": false,
            "sign": "",
            "liveRate": "",
            "similarity": "",
            "error": message,
            "errorDomain": domain,
            "errorCode": code,
            "errorDescription": message,
            "errorReason": reason,
        ]

        self.result(data)
    }
}
