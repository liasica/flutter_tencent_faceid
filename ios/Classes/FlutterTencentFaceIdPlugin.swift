import Flutter
import UIKit
#if !targetEnvironment(simulator)
    import TencentCloudHuiyanSDKFace
#endif

public class FlutterTencentFaceIdPlugin: NSObject, FlutterPlugin {
    static let methodChannelName = "com.liasica.flutter_tencent_faceid/method"
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: methodChannelName, binaryMessenger: registrar.messenger())
        let instance = FlutterTencentFaceIdPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "ocr":
            handleOcr(call, result)
        case "face":
            handleFace(call, result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
#if targetEnvironment(simulator)

    // 腾讯 SDK 未提供 arm64 模拟器切片，模拟器构建不链接 SDK，两项能力均不可用
    // （活体核验与证件 OCR 都依赖摄像头，模拟器本就无法完成）
    private func handleOcr(_: FlutterMethodCall, _ result: @escaping FlutterResult) {
        print(Self.unsupportedMessage)
        result(nil)
    }

    private func handleFace(_: FlutterMethodCall, _ result: @escaping FlutterResult) {
        print(Self.unsupportedMessage)
        result(nil)
    }

    private static let unsupportedMessage = "[FlutterTencentFaceId] 腾讯人脸核身 SDK 无 arm64 模拟器切片，模拟器上不可用，请用真机调试"

#else

    private func handleOcr(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        // let arguments = call.arguments
        if let args = call.arguments as? Dictionary<String, Any>,
           let appId = args["appId"] as? String,
           let userId = args["userId"] as? String,
           let nonce = args["nonce"] as? String,
           let sign = args["sign"] as? String,
           let orderNo = args["orderNo"] as? String,
           let version = args["version"] as? String {
            
            WBOCRManager.start(
                result,
                appId: appId,
                userId: userId,
                sign: sign,
                orderNo: orderNo,
                nonce: nonce,
                version: version
            )
        } else {
            result(nil)
        }
    }
    
    let faceDelegate: WBFaceVerifyDelegate = WBFaceVerifyDelegate()
        
    private func handleFace(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let manager = WBFaceVerifyManager(result)
        self.faceDelegate.result = result
        
        WBFaceVerifyCustomerService.sharedInstance().delegate = self.faceDelegate
        
        let arguments = call.arguments
        if let args = arguments as? Dictionary<String, Any>,
           let appId = args["appId"] as? String,
           let userId = args["userId"] as? String,
           let nonce = args["nonce"] as? String,
           let sign = args["sign"] as? String,
           let orderNo = args["orderNo"] as? String,
           let license = args["licence"] as? String,
           let version = args["version"] as? String,
           let faceId = args["faceId"] as? String,
           let optimalDomain = args["optimalDomain"] as? String {
            manager.start(
                userId: userId,
                nonce: nonce,
                sign: sign,
                appId: appId,
                orderNo: orderNo,
                license: license,
                version: version,
                faceId: faceId,
                optimalDomain: optimalDomain
            )
        } else {
            result(nil)
        }
    }

#endif
}
