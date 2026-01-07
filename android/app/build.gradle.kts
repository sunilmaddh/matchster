plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.matchster.matchster"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.matchster.matchster"

        // ⚠️ Firebase + Facebook require minSdk 21
        minSdk =24

        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
    java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(17))
    }
}
}

dependencies {

implementation(platform("com.google.firebase:firebase-bom:34.7.0"))
implementation("com.google.firebase:firebase-auth")
implementation("com.google.firebase:firebase-analytics")
implementation("com.facebook.android:facebook-login:16.3.0")

}

flutter {
    source = "../.."
}

