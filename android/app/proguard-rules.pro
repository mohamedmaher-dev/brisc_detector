# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# TensorFlow Lite - Keep all classes and methods
-keep class org.tensorflow.lite.** { *; }
-keep class org.tensorflow.lite.gpu.** { *; }
-keep class org.tensorflow.lite.support.** { *; }
-keep class org.tensorflow.lite.task.** { *; }
-keep class org.tensorflow.lite.flex.** { *; }

# TensorFlow Lite GPU Delegate - Critical for GPU acceleration
-keep class org.tensorflow.lite.gpu.GpuDelegate { *; }
-keep class org.tensorflow.lite.gpu.GpuDelegate$Options { *; }
-keep class org.tensorflow.lite.gpu.GpuDelegateFactory { *; }
-keep class org.tensorflow.lite.gpu.CompatibilityList { *; }

# Suppress warnings for optional TensorFlow Lite classes
-dontwarn org.tensorflow.lite.gpu.GpuDelegateFactory$Options

# NNAPI delegate
-keep class org.tensorflow.lite.nnapi.NnApiDelegate { *; }
-keep class org.tensorflow.lite.nnapi.NnApiDelegate$Options { *; }

# Interpreter and related classes
-keep class org.tensorflow.lite.Interpreter { *; }
-keep class org.tensorflow.lite.Interpreter$Options { *; }
-keep class org.tensorflow.lite.InterpreterApi { *; }
-keep class org.tensorflow.lite.InterpreterApi$Options { *; }

# Keep all native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep all JNI related methods
-keepclasseswithmembers class * {
    native <methods>;
}

# Reflection attributes needed by TensorFlow Lite
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes InnerClasses
-keepattributes RuntimeVisibleAnnotations
-keepattributes RuntimeInvisibleAnnotations

# Flutter Engine classes
-keep class io.flutter.** { *; }
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }

# Google Play Core (for Flutter deferred components) - Make optional
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }

# Image picker plugin
-keep class io.flutter.plugins.imagepicker.** { *; }

# Platform channels
-keep class io.flutter.plugin.common.** { *; }

# Keep R class for resources
-keep class **.R$* { *; }

# General Android framework
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider

# Preserve line number information for debugging
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

# Disable optimization that could break TensorFlow Lite
-dontoptimize 