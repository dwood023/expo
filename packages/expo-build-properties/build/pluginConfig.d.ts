/**
 * Interface representing base build properties configuration.
 */
export interface PluginConfigType {
    /**
     * Interface representing available configuration for Android native build properties.
     * @platform android
     */
    android?: PluginConfigTypeAndroid;
    /**
     * Interface representing available configuration for iOS native build properties.
     * @platform ios
     */
    ios?: PluginConfigTypeIos;
}
/**
 * Interface representing available configuration for Android native build properties.
 * @platform android
 */
export interface PluginConfigTypeAndroid {
    /**
     * Enable React Native new architecture for Android platform.
     */
    newArchEnabled?: boolean;
    /**
     * Override the default `minSdkVersion` version number in **build.gradle**.
     * */
    minSdkVersion?: number;
    /**
     * Override the default `compileSdkVersion` version number in **build.gradle**.
     */
    compileSdkVersion?: number;
    /**
     * Override the default `targetSdkVersion` version number in **build.gradle**.
     */
    targetSdkVersion?: number;
    /**
     *  Override the default `buildToolsVersion` version number in **build.gradle**.
     */
    buildToolsVersion?: string;
    /**
     * Override the Kotlin version used when building the app.
     */
    kotlinVersion?: string;
    /**
     * Enable [Proguard or R8](https://developer.android.com/studio/build/shrink-code) in release builds to obfuscate Java code and reduce app size.
     */
    enableProguardInReleaseBuilds?: boolean;
    /**
     * Append custom [Proguard rules](https://www.guardsquare.com/manual/configuration/usage) to **android/app/proguard-rules.pro**.
     */
    extraProguardRules?: string;
    /**
     * Interface representing available configuration for Android Gradle plugin [PackagingOptions](https://developer.android.com/reference/tools/gradle-api/7.0/com/android/build/api/dsl/PackagingOptions).
     */
    packagingOptions?: PluginConfigTypeAndroidPackagingOptions;
}
/**
 * Interface representing available configuration for iOS native build properties.
 * @platform ios
 */
export interface PluginConfigTypeIos {
    /**
     * Enable React Native new architecture for iOS platform.
     */
    newArchEnabled?: boolean;
    /**
     * Override the default iOS "Deployment Target" version in the following projects:
     *  - in CocoaPods projects,
     *  - `PBXNativeTarget` with "com.apple.product-type.application" `productType` in the app project.
     */
    deploymentTarget?: string;
    /**
     * Enable [`use_frameworks!`](https://guides.cocoapods.org/syntax/podfile.html#use_frameworks_bang)
     * in `Podfile` to use frameworks instead of static libraries for Pods.
     */
    useFrameworks?: 'static' | 'dynamic';
}
/**
 * Interface representing available configuration for Android Gradle plugin [PackagingOptions](https://developer.android.com/reference/tools/gradle-api/7.0/com/android/build/api/dsl/PackagingOptions).
 * @platform android
 */
export interface PluginConfigTypeAndroidPackagingOptions {
    /**
     * Array of patterns for native libraries where only the first occurrence is packaged in the APK.
     */
    pickFirst?: string[];
    /**
     * Array of patterns for native libraries that should be excluded from being packaged in the APK.
     */
    exclude?: string[];
    /**
     * Array of patterns for native libraries where all occurrences are concatenated and packaged in the APK.
     */
    merge?: string[];
    /**
     * Array of patterns for native libraries that should not be stripped of debug symbols.
     */
    doNotStrip?: string[];
}
/**
 * @ignore
 */
export declare function validateConfig(config: any): PluginConfigType;
