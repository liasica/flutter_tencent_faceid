package com.liasica.flutter_tencent_faceid

import android.app.Activity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** 腾讯云人脸核身 Flutter 插件 */
class FlutterTencentFaceIdPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel

    private var activity: Activity? = null

    companion object {
        const val METHOD_CHANNEL_NAME = "com.liasica.flutter_tencent_faceid/method"
        const val LOG_TAG = "FLUTTER_TENCENT_FACEID"
        const val ERROR_NO_ACTIVITY = "NO_ACTIVITY"
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, METHOD_CHANNEL_NAME)
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        activity = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val currentActivity = activity
        if (currentActivity == null) {
            result.error(ERROR_NO_ACTIVITY, "插件尚未附着到 Activity", null)
            return
        }

        try {
            when (call.method) {
                "ocr" -> WBOCRManager.start(currentActivity, call.arguments as Map<*, *>?, result)
                "face" -> WBFaceVerifyManager.start(currentActivity, call.arguments as Map<*, *>?, result)
                else -> result.notImplemented()
            }
        } catch (e: Exception) {
            result.error(LOG_TAG, e.toString(), null)
        }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }
}
