# Razorpay SDK
-keep class com.razorpay.** {*;}
-keepclassmembers class * {
    @com.razorpay.** <methods>;
}
-dontwarn com.razorpay.**
