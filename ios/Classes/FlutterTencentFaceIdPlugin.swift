import Flutter
import TencentCloudHuiyanSDKFace
import UIKit

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
           let licence = args["licence"] as? String,
           let version = args["version"] as? String,
           let faceId = args["faceId"] as? String,
           let optimalDomain = args["optimalDomain"] as? String {
            manager.start(
                userId: userId,
                nonce: nonce,
                sign: sign,
                appId: appId,
                orderNo: orderNo,
                licence: licence,
                version: version,
                faceId: faceId,
                optimalDomain: optimalDomain
            )
        } else {
            result(nil)
        }
    }
}
