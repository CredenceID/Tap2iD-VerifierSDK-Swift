# Tap2iD SDK for iOS

## Overview

The Tap2iD SDK complies with the ISO/IEC 18013-5:2021 standard, facilitating digital representation for mobile-based credentials, including mobile driver's licenses (mDL). 

## System Requirements

- **Supported iOS Versions**: iOS 17.0 and later
- **Dependencies**: Xcode 15.0 or later
- **Hardware Requirements**: iPhone 11 or newer with NFC enabled

## Installation

### Swift Package Manager

To add the Tap2iD SDK to your Xcode project using Swift Package Manager:

1. **Open Xcode**: Launch your project in Xcode.
2. **Add Package Dependency**:
   - Go to `File > Swift Packages > Add Package Dependency`.
   - Enter `https://github.com/CredenceID/Tap2iD-VerifierSDK-Swift.git` in the repository URL field.
3. **Specify Version**:
   - Choose "Up to Next Major" and specify `X.X.X` as the earliest version.
4. **Add to Target**:
   - Select "Tap2iD-VerifierSDK-Swift" when Xcode resolves the version and add it to your app target.

For troubleshooting, refer to Apple's [Adding Package Dependencies to Your App](https://developer.apple.com/library/archive/documentation/Xcode/Adding_Package_Dependencies_to_Your_App/) guide.

## Enabling BLE and NFC Support

### Bluetooth Support

1. **Open `Info.plist`**:
   - Locate and open the `Info.plist` file in your Xcode project.

2. **Add Bluetooth Usage Description Keys**:
   Include the following keys to request Bluetooth permissions:

   ```xml
   <key>NSBluetoothAlwaysUsageDescription</key>
   <string>Your app requires Bluetooth access to connect to nearby devices even in the background.</string>
   
   <key>NSBluetoothPeripheralUsageDescription</key>
   <string>Your app needs to advertise and communicate with other Bluetooth devices.</string>
   
   <key>NSBluetoothWhenInUseUsageDescription</key>
   <string>Your app requires Bluetooth access to connect to nearby devices while in use.</string>


# NFC Support

NFC support has been detailed separately to ensure clarity and focus on each individual technology's configuration. Below are the steps to enable NFC support for the Tap2iD Verifier-SDK.

## Enable NFC Capability

1. **Select Your Project**:
   - Open Xcode and select your project in the Project Navigator.

2. **Choose Your Target**:
   - In the Targets list, select your app target.

3. **Add NFC Capability**:
   - Go to the "Signing & Capabilities" tab.
   - Click the "+" button and choose "Near Field Communication Tag Reading" from the list of available capabilities.

## Modify `Info.plist`

To request NFC permissions, you need to update your `Info.plist` file. Add the following entries to explain why your app needs NFC access:

```xml
<key>NFCReaderUsageDescription</key>
<string>YOUR_PRIVACY_DESCRIPTION</string>

<key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
<array>
    <string>D2760000850101</string>
</array>

<key>com.apple.developer.nfc.readersession.felica.systemcodes</key>
<array>
    <string>12FC</string>
</array>

```


## Example Usage

Here is an example of how to use the Tap2iD Verify SDK:

```swift

import Tap2iDVerifierSDK

class TestSDK {
    
    func initSDK(apiKey: String, result: @escaping (String?,String?) -> Void) {
        let sdkConfig = CoreSdkConfig(apiKey: apiKey)
        Tap2iDVerifySDK.shared.initSdk(config: sdkConfig) { (error, message) in
            result(error, message)
        }
    }

    func startQrEngagement(capturedQr: String, result: @escaping (Error?) -> Void) {
        let error = Tap2iDVerifySDK.shared.verifyMdoc(engagementConfig: .qrCode(capturedQr), delegate: self)
        if let error = error {
            result(error)
        }
    }
}

extension TestSDK: Tap2iDVerifySDKDelegate {
    
    func onVerificationStageStarted(stage: VerificationStage) {
        // onVerificationStageStarted
    }
    
    func onVerificationStageError(stage: VerificationStage?, error: CoreCredenceErrorStruct?) {
        //onVerificationStageError
    }
    
    func onVerificationStageCompleted(stage: VerificationStage) {
        //onVerificationStageCompleted
    }
    
    func onVerificationCompleted(result: MdlAttributes, validationResult: [CoreCredenceErrorStruct]) {
        //onVerificationCompleted
    }
}

```
