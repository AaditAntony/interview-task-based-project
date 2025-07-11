# trends

A new Flutter project.

## Getting Started

# the reference i took to complete the login screen 

i have used mvvm architecture and riverpod for the stamanagemnt as this option is best for the clear seperation of code of business logic form the ui

i have read the riverpod statenotifier provider from the official riverpod site and https://pub.dev/documentation/hooks_riverpod/3.0.0-dev.16/legacy/StateNotifierProvider-class.html

i have an experience doing login page form the previous company i previously  work and the project called  Expand where i use the riverpod for statemanagement in my git hub this is the link : 
https://github.com/AaditAntony/expand/tree/main/lib/features/auth

there is a problem with the ndk version with the sharedpreference i solve it using the debug and the appropriate version in the app inside android folder  build-gradle.kts file and that proble has been solved

onece the token is stored in the local storage there is no need for relogin unless the app in uninstalled

for the reference i have used chat GPT and tech brother which is youtube channel  for the  reference and correction of riverpod and login state

# Key Features of the login page

MVVM Architecture for clear separation of business logic and UI
Riverpod for state management (using StateNotifierProvider)
SharedPreferences for local storage
when entering in the app there is no need of login everytime


# Implementation Details

Followed Riverpod's official documentation and best practices
Solved NDK version conflict with SharedPreferences by updating build-gradle.kts
Built upon previous experience from Expand project
References

Riverpod Documentation
Tech Brothers YouTube channel
ChatGPT for code references and corrections

# key features of the Api Product displaying 

i have performed this api using riverpod and mvvm architecture

# reference of this implementaion
i have used my own git hubs previous project  called expand where i tried to implement the this type of api in form the site called : https://dummyjson.com/products. and this is the projects link  : https://github.com/AaditAntony/expand/tree/main/lib/features/Product


# key features of displayig the Product Detailed Screen

since the api is already displayed in the ui i only need to pass the model to the product detailed screen. and it has been done successfully and implemented the product details in the screen

# key features of displayig the Payment gate in Product Detailed Screen
after creating the product page i have implemented the payment gate in the product detailed screen

it consist of error handling
attacheed event listner for handling payment success
attacheed event listner for handling payment error
attacheed event listner for handling payment external wallet

notifies the listner if the payment is success of failure there will be an attached snackbar with the message 

# reference i have used

read this documentation of the official RazorPay through this link : https://razorpay.com/docs/payments/payment-gateway/flutter-integration/standard/build-integration/#11-install-razorpay-flutter-plugin

watched the youtube videos of the razor pay integration :https://www.youtube.com/watch?v=pakLL37M6KI

i have reffered chatgpt for the integration error for the creation of proguard-rules.pro and add dependency in the build.gradle.kts etc...

Card Number: 4111 1111 1111 1111
Expiry: Any future date (like 12/26)
CVV: 123
Name: Acdg

this is the card name i have used

# order success page
order success page has been implemented in the product detailed screen where the
payment handled success method now return  the order success page if the oreder is confirmed

# payment failure page

if the payment failed in any case this this will direct to the payment failure screen this is
implemented in the product detailed screen .