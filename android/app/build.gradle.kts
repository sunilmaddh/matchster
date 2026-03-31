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

    // kotlinOptions block DELETED here

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

    // 🔥 Firebase BOM
    implementation(platform("com.google.firebase:firebase-bom:34.7.0"))
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-analytics")

    // Facebook Login
    implementation("com.facebook.android:facebook-login:16.3.0")

    // 📷 CameraX
    val cameraxVersion = "1.5.3"
    implementation("androidx.camera:camera-core:$cameraxVersion")
    implementation("androidx.camera:camera-camera2:$cameraxVersion")
    implementation("androidx.camera:camera-lifecycle:$cameraxVersion")
    implementation("androidx.camera:camera-view:$cameraxVersion")

    // ✋ MediaPipe
    implementation("com.google.mediapipe:tasks-vision:0.20230731")
    implementation("androidx.appcompat:appcompat:1.7.1")
}


flutter {
    source = "../.."
}