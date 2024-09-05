---

# IBD Symptom Detection - iOS Application

## Overview
This iOS application is part of the IBD Symptom Detection project. The app allows users to upload their medical reports, which are analyzed by a machine learning model to detect the presence of Inflammatory Bowel Disease (IBD) symptoms. Based on the classification results, users can access relevant resources, support groups, or medical specialists directly from the app.

## Features
- **Medical Report Upload:** Users can upload medical reports for analysis.
- **IBD Symptom Classification:** The app uses a trained machine learning model to classify reports as positive or negative for IBD symptoms.
- **Firebase Integration:** Secure user authentication and data storage using Firebase.
- **Recommendations and Resources:** Provides users with tailored recommendations and resources based on their classification results.

## Prerequisites
- **Xcode:** Version 11 or later.
- **iOS:** Version 12.0 or later.
- **Firebase Account:** A Firebase project set up for iOS integration.

## Setup and Installation

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/IBD-Detection.git
cd IBD-Detection/ios
```

### 2. Open the Project in Xcode
- Open `IBD-Symptom-Detection.xcodeproj` in Xcode.

### 3. Install CocoaPods Dependencies
If your project uses CocoaPods for Firebase integration, install the necessary pods:
```bash
pod install
```
After this, make sure to open the `.xcworkspace` file in Xcode instead of `.xcodeproj`.

### 4. Firebase Setup
1. Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project if you haven't already.
2. Add an iOS app to your Firebase project. You will need your app's bundle identifier (e.g., `com.yourname.IBDSymptomDetection`).
3. Download the `GoogleService-Info.plist` file and add it to your Xcode project. Ensure it's included in the app target.
4. Initialize Firebase in your app by adding the following code to your `AppDelegate.swift`:
```swift
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
```

### 5. Build and Run
- Connect your iOS device or use a simulator, then build and run the app from Xcode.

## Usage

1. **Sign Up/Log In:** Use the Firebase authentication system to sign up or log in.
2. **Upload Medical Report:** Navigate to the upload section and choose a medical report from your device.
3. **Classification Results:** The app will analyze the report and classify it as positive or negative for IBD symptoms.
4. **Recommendations:** Based on the classification, the app will offer recommendations, such as joining support groups, accessing resources, or consulting with a healthcare professional.

## Firebase Configuration (Optional)
If you want to enable additional Firebase features, such as Firestore, Realtime Database, or Analytics, make sure to configure them in your Firebase Console and integrate the necessary SDKs into your project using CocoaPods.

## Contributing
Contributions to the iOS app are welcome! If you have suggestions for new features or improvements, please fork the repository and create a pull request.

### Steps to Contribute:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a pull request.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact
For any questions or inquiries, please contact:
- **Your Name:** Darshan Virani
- **Gmail:** darshanvirani2468@gmail.com

---
