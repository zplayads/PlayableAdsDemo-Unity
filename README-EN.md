### PlayableAdsSDK for Unity
1. General Introduction
2. About Demo
3. Importing PlayableAds.unitypackage
4. Install ZPLAY Ads SDK


### General Introduction
1. Target users: This document is used to serve those who want to integrate ZPLAY Ads SDK in Unity environment
2. Development Environment

    Xcode 7.0 or above
    iOS 8.0 or above
3. The environment for demo running
    mac：macOS Sierra 10.12.6
    unity: version 2017.1.1f1 Personal
    xcode: Version 9.1 (9B55)
    cocoapods: 1.2.1


### About Demo
Download the demo’s source code, and import it from unity. Then open scene “SampleGame.unity”

**1. The main interface and basic settings are as follows**
![image](/images/image01.png)

**2. Main Camera’s controller script is:**
![image](/images/image02.png)

This demo takes Main Camera as the ad event receiver object, other GameObjects can also be used as the event receiver. Just make sure that the ad requests and receivers are under the same GameObject.

If you send requests from more than one GameObject, then only the last GameObject takes effect.

### Importing PlayableAds.unitypackage
**1. Import ZPLAY Ads plugin: Assets->Import Package -> Custom Package...**
![image](/images/image03.png)
[PlayableAds.unitypackage资源位置](/PlayableAds.unitypackage)
**2. Choose the PlayableAds.unitypackage , and open it**
![image](/images/image04.png)
**3. Import all files. If a folder with the same name has already in your project, the files will be copied into it. Click on Import to import them.**
![image](/images/image05.png)

If there’s a file name conflict, you can modify the file name or the class name. Just make sure it’s in correspondence with what you will call.

**4. Add script on relevant GameObject(eg.: it’s Main Camera in this demo)**
![image](/images/image06.png)
![image](/images/image07.png)

Initialize and load ads, replace iOSDemoApp and iOSDemoAdUnit with your own app id and placement id, which you registered on ZPLAY Ads website. 
```c#
PlayableAdsBridge.LoadAd(gameObject.name, "iOSDemoApp", "iOSDemoAdUnit");
```
Judge if the ad is loaded
```c#
PlayableAdsBridge.IsReady()
```
Show an ad
```c#
PlayableAdsBridge.PresentAd();
```

How to make messages pass-through. Note that this needs to be on the same GameObject with the requesting. In this demo, the GameObject is Main Camera.
```c#
#region PlayableAds listener
// The ad is completed, and it’s time to give rewards
public void PlayableAdsDidRewardUser(string msg)
{
  cbInfo.text = "PlayableAdsDidRewardUser";
}

// An ad is loaded, and can be shown at any time了
public void PlayableAdsDidLoad(string msg)
{
  cbInfo.text = "PlayableAdsDidLoad";
}

// Failed to load an ad, check error information to find out the reason
public void DidFailToLoadWithError(string error)
{
  cbInfo.text = error;
}

// Other callback information, view msg for details
public void PlayableAdFeedBack(string msg)
{
  Debug.Log("PlayableAdFeedBack: " + msg);
}
#endregion
```
Above are all steps to configure a ZPLAY Ads plugin. After that, you can export an iOS project to install ZPLAY Ads SDK.

### Install ZPLAY Ads SDK

**1. Enter the root folder of the xcode project exported from unity. And initialize pod here, in our example it’s iOSProj folder:**

![image](/images/image14.png)

**2. A Podfile will be generated after the initialization. Add ZPLAY Ads sdk in this file as following:**

![image](/images/image15.png)

This file may looks different in different projects. Just make sure to add```pod 'PlayableAds'```into Podfile. 
Please Note that the OS requirement of ZPLAY Ads is iOS 8.0.

**3. Install ZPLAY Ads sdk**
```
pod install --repo-update
```
![image](/images/image16.png)

When you see the messaged marked with red line, it means the SDK has been installed successfully. You can run the project to check it. 

**4. Verify if the SDK is installed**
Open  **.xcworkspace** , and install the app to iPhone

![image](/images/image17.png)

Note that it's **.xcworkspace** file here, not **.xcodeproj**

**5. Preview the demo**

The whole workflow is:
* Tap “Request” to request for ads; 
* "PlayableAdsDidLoad" will be shown when an ad is loaded; 
* Tap “Present” to show the ad; 
* Tap on "X" to close it after it’s over. 
* A "PlayableAdsDidRewardUser" message will be received.

![image](/images/image19.jpg)
