# firebaseconfigapp

Applicação fluuter para aprender o FIREBASE

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,


## PACKAGES - pubspec.yaml
 dependencies:
   firebase_core: ^0.4.4+3
   cloud_firestore: ^0.13.5
   firebase_storage: ^3.1.5
   firebase_auth: ^0.16.0


## FIXES ANDROIDX - android/gradle.properties
//add lines
android.useAndroidX=true
android.enableJetifier=true


## FIXES FIREBASE - android/build.gradle
//add lines
dependencies {

        classpath 'com.google.gms:google-services:4.3.3'
 }


## FIXES FIREBASE - android/app/build.gradle
//add lines
defaultConfig {
        multiDexEnabled true
   }

 android {
       ...
 }

 apply plugin: 'com.google.gms.google-services'

 dependencies {
     implementation 'com.android.support:multidex:2.0.1'  //with support libraries
     implementation 'com.google.firebase:firebase-core:17.0.0'
 }
