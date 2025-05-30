plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter plugin wajib ditaruh terakhir
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.deteksi_jerawat"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" // Gunakan NDK yang kompatibel dengan plugin

    defaultConfig {
        applicationId = "com.example.deteksi_jerawat"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        release {
            // Set false kalau tidak pakai obfuscation
            isMinifyEnabled = false
            isShrinkResources = false // ⛔ HARUS false jika minify juga false

            signingConfig = signingConfigs.getByName("debug") // Ganti jika ada release key
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}
