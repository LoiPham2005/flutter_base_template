plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.flutter_base_template"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    signingConfigs {
        create("release") {
            storeFile = file("../app/signing/release-keystore.jks")
            storePassword = System.getenv("KEYSTORE_PASSWORD") ?: "your_password"
            keyAlias = System.getenv("KEY_ALIAS") ?: "your_alias"
            keyPassword = System.getenv("KEY_PASSWORD") ?: "your_key_password"
        }
    }

    defaultConfig {
        applicationId = "com.example.flutter_base_template"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        
        // Enable multidex
        multiDexEnabled = true
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            signingConfig = signingConfigs.getByName("release")
            
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        
        debug {
            applicationIdSuffix = ".debug"
            isDebuggable = true
        }
    }

    flavorDimensions += "environment"
    productFlavors {
        create("development") {
            dimension = "environment"
            applicationIdSuffix = ".dev"
            resValue("string", "app_name", "Flutter Base Dev")
        }
        
        create("staging") {
            dimension = "environment"
            applicationIdSuffix = ".stg" 
            resValue("string", "app_name", "Flutter Base Staging")
        }
        
        create("production") {
            dimension = "environment"
            resValue("string", "app_name", "Flutter Base")
        }
    }
}

dependencies {
    add("coreLibraryDesugaring", "com.android.tools:desugar_jdk_libs:2.1.4")
}

flutter {
    source = "../.."
}
