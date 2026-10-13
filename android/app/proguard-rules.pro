# Cronet ships JNI + native code. R8 must keep the Java API used by PixivCronet.
-keep class org.chromium.net.** { *; }
-keep class org.chromium.base.** { *; }
-dontwarn org.chromium.**
