#不混淆内部类
-keepattributes InnerClasses

#不混淆jni调用类
-keepclasseswithmembers class *{
    native <methods>;
}

###################### faceverify-BEGIN ###########################
-ignorewarnings
-keep public class com.tencent.ytcommon.**{*;}
-keep class com.tencent.turingface.sdk.*.TNative$aa { public *; }
-keep class com.tencent.turingface.sdk.*.TNative$aa$bb { public *; }
-keep class com.tencent.turingcam.** {*;}

-keep public class com.tencent.cloud.nativeapi.reflect.jni.**{*;}
-keep public class com.tencent.cloud.nativeapi.reflect.YTAGReflectLiveCheckInterface{
    public <methods>;
}

# 保护外部库依赖
-keep public class com.tencent.youtu.** {*;}
-keep public class com.tencent.cloud.nativeapi.pose.jni.**{*;}
-keep public class com.tencent.cloud.nativeapi.pose.data.**{*;}
-keep public class com.tencent.youtu.liveness.YTDeviceInfo{*;}
# 保护 nativeapi 包下的所有类不被混淆
-keep class com.tencent.cloud.nativeapi.** {*;}
-keep public class com.tencent.cloud.nativeapi.framework.YtSDKKitFrameworkTool{
   public *;
}
-keep public class com.tencent.cloud.nativeapi.framework.common.YTImageData{
   *;
}
-keep public class com.tencent.cloud.huiyansdkface.facelight.net.*$*{
    *;
}
-keep public class com.tencent.cloud.huiyansdkface.facelight.net.**{
    *;
}
-keep public class com.tencent.cloud.huiyansdkface.facelight.provider.WbDeviceRiskInfo{
    public <fields>;
}
-keep public class com.tencent.cloud.huiyansdkface.facelight.provider.WbUiTips{
    *;
}
-keep class com.tencent.kyc.toolkit.**{*;}
###################### face-will-BEGIN ###########################
-ignorewarnings
-keep class com.tencent.cloud.huiyansdkface.wbwillexpressionsdk.WbFaceWillImpl{
    public <methods>;
}
-keep public class com.tencent.cloud.huiyansdkface.wbwillexpressionsdk.config.WbWillUiTips{
    *;
}
-keep public class com.tencent.cloud.huiyansdkface.wbwillexpressionsdk.net.*$*{
    *;
}
-keep public class com.tencent.cloud.huiyansdkface.wbwillexpressionsdk.net.**{
    *;
}

#================数据上报混淆规则 start===========================
#实体类
-keep class com.tencent.cloud.huiyansdkface.analytics.EventSender{
    *;
}
-keep class com.tencent.cloud.huiyansdkface.analytics.EventSender$*{
    *;
}
-keep class com.tencent.cloud.huiyansdkface.analytics.WBSAEvent{
     *;
}
-keep class com.tencent.cloud.huiyansdkface.analytics.WBSAParam{
     *;
}
#================数据上报混淆规则 end===========================

#######################faceverify-END#############################

####################### normal混淆规则-BEGIN#############################
#不混淆内部类
-keepattributes InnerClasses
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes Exceptions

-keep public class com.tencent.cloud.huiyansdkface.normal.net.*$*{
    *;
}
-keep public class com.tencent.cloud.huiyansdkface.normal.net.*{
    *;
}
#bugly
-keep class com.tencent.bugly.idasc.**{
    *;
}
#wehttp混淆规则
-dontwarn com.tencent.cloud.huiyansdkface.okio.**
-keep class com.tencent.cloud.huiyansdkface.okio.**{
    *;
}
-dontwarn com.tencent.cloud.huiyansdkface.okhttp3.OkHttpClient$Builder

####################### normal混淆规则-END#############################
