#######################normal混淆规则-BEGIN#############################
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
-keep public class com.tencent.cloud.huiyansdkface.normal.thread.*{
   *;
}
-keep public class com.tencent.cloud.huiyansdkface.normal.tools.*{
   *;
}
-keep public class com.tencent.cloud.huiyansdkface.normal.thread.*$*{
   *;
}

-keep public class com.tencent.cloud.huiyansdkface.normal.tools.secure.*{
   *;
}

-keep public class com.tencent.cloud.huiyansdkface.normal.tools.WLogger{
    *;
}
-keep class com.tencent.bugly.idasc.**{
    *;
}
#wehttp混淆规则
-dontwarn com.tencent.cloud.huiyansdkface.okio.**
-keep class com.tencent.cloud.huiyansdkface.okio.**{
    *;
}

# 里面 有 Java8的一些类 如 Duration
-dontwarn com.tencent.cloud.huiyansdkface.okhttp3.OkHttpClient$Builder
-keep class com.tencent.cloud.huiyansdkface.wehttp2.**{
    public <methods>;
}

-keep class com.tencent.cloud.huiyansdkface.okhttp3.**{
    public <methods>;
}

-keep interface com.tencent.cloud.huiyansdkface.wehttp2.**{
    public <methods>;
}
-keep public class com.tencent.cloud.huiyansdkface.wehttp2.WeLog$Level{
    *;
}
-keep class com.tencent.cloud.huiyansdkface.wejson.*{
    *;
}

-keep public class com.tencent.cloud.huiyansdkface.wehttp2.WeReq$ErrType{
    *;
}

-keep class * extends com.tencent.cloud.huiyansdkface.wehttp2.WeReq$Callback{
   public <methods>;
}

-keep class com.tencent.cloud.huiyansdkface.okio.**{
    *;
}

#for R8
-keep,allowobfuscation,allowshrinking class * implements com.tencent.cloud.huiyansdkface.wehttp2.WeReq$Callback
-keep,allowobfuscation,allowshrinking interface com.tencent.cloud.huiyansdkface.wehttp2.WeReq$Callback
#######################normal混淆规则-END#############################
