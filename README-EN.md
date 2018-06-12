## PlayableAdsSDK for Unity
1. General Introduction
2. About Demo
3. Importing PlayableAds.unitypackage
4. Install ZPLAY Ads SDK


## General Introduction
1. Target users: This document is used to serve those who want to integrate ZPLAY Ads SDK in Unity environment
2. Development Environment
    - iOS:
        Xcode 7.0 or above
        iOS 8.0 or above
    - Android:
        Android 4.0 or above
3. The environment for demo running
    - iOS
        mac：macOS Sierra 10.12.6
        unity: version 2017.1.1f1 Personal
        xcode: Version 9.1 (9B55)
        cocoapods: 1.2.1
    - Andoird
        mac：macOS Sierra 10.12.6
        unity: version 2017.1.1f1 Personal

## About Demo
Download the demo’s source code, and import it from unity. Then open scene “SampleGame.unity”

### 1. The main interface and basic settings are as follows
![image](./images/image01.png)

### 2. Main Camera's controller script is:
![image](./images/image02.png)

This demo takes Main Camera as the ad event receiver object, other GameObjects can also be used as the event receiver. Just make sure that the ad requests and receivers are under the same GameObject.

If you send requests from more than one GameObject, then only the last GameObject takes effect.

## Importing PlayableAds.unitypackage
### 1. Import ZPLAY Ads plugin 
Android and iOS use the same plug-in package, import step is Assets->Import Package -> Custom Package...

![image](./images/image03.png)

Click to download [PlayableAds.unitypackage](/PlayableAds.unitypackage)

### 2. Choose the PlayableAds.unitypackage , and open it
![image](./images/image04.png)

### 3. Import all files you need. 
If a folder with the same name has already in your project, the files will be copied into it. Click on Import to import them.

a. If you need both Android and iOS, you need to import all files(including iOS plugin and Android plugin), as shown:
![image](./images/image05.png)

b. If you only need iOS, just import files as shown:
![image](./images/image20.png)

c. If you only need Android, just import files as shown:
![image](./images/image21.png)

Note: If there's a file name conflict, you can modify the file name or the class name. Just make sure it’s in correspondence with what you will call.

### 4. Add Code
#### a. Add iOS Code

-  Initialize Ads

    ```C#
    // APP_ID: An ID for your App, obtained when setting up the App for monetization within your account on the ZPLAY Ads website.
    PlayableAdsBridge.Init(gameObjectName, APP_ID);
    ```


- Request Ads

    ``` c#
    // AD_UNIT_ID: An ID for a specific ad placement within your App, as generated for your Apps within your account on the ZPLAY Ads website.
    PlayableAdsBridge.RequestAd(AD_UNIT_ID);
    ```

- Ad ready for display?

    ``` c#
    // You can judge the availability of an ad by this callback. Then you’ll be able to manage your game’s settings according to the ad being ready or not.

    PlayableAdsBridge.IsReady(AD_UNIT_ID);
    ```

- Show Ad
    ``` c#
    PlayableAdsBridge.PresentAd(AD_UNIT_ID);
    ```

- Set to automatically load next ad

    ```c#
    PlayableAdsBridge.Autoload(bool);// default is true
    ```

    The default is automatic loading, that is, after the first request for an ad, the subsequent SDK will automatically load the next ad and does not need to call the request method again.

- Does the ad automatically load the next ad?

    ```c#
    PlayableAdsBridge.IsAutoload();
    ```

    ​

- Custom Event

    ```c#
    // Place: Demo/Assets/Scripts/PlayableAdsBridge.IPlayableListener
    interface IPlayableListener{
        // Reward
        void PlayableAdsDidRewardUser(string msg);

        // ad has been loaded.
        void PlayableAdsDidLoad(string msg);

        // ad load failed
        void DidFailToLoadWithError(string error);

        // user starts playing the ad.
        void PlayableAdsDidStartPlaying(string msg);

        // the ad is being fully played.
        void PlayableAdsDidEndPlaying(string msg);

        // the landing page did present on the screen.
        void PlayableAdsDidPresentLandingPage(string msg);

        // the ad did dismiss the screen.
        void PlayableAdsDidDismissScreen(string msg);

        // the ad is clicked
        void PlayableAdsDidClick(string msg);
    }
    ```

#### b. Add Android Code
-  Initialize SDK
    ``` c#
    // APP_ID: An ID for your App, obtained when setting up the App for monetization within your account on the ZPLAY Ads website.

    PlayableAdsAdapter.Init(gameObjectName, APP_ID);
    ```
- Request Ad 
    ``` c#
    // AD_UNIT_ID: An ID for a specific ad placement within your App, as generated for your Apps within your account on the ZPLAY Ads website.
    PlayableAdsAdapter.RequestAd(AD_UNIT_ID);
    ```
- Ad ready for display?
    ``` c#
    PlayableAdsAdapter.IsReady(AD_UNIT_ID)
    ```
- Show Ad
    ``` c#
    PlayableAdsAdapter.PresentAd(AD_UNIT_ID)
    ```
- Custom Event
    ``` c#
    // Position：Demo/Assets/Scripts/PlayableAdsAdapter.IPlayableAdapterListener
    interface IPlayableAdapterListener{

        // Tells the delegate that succeeded to load ad, you can show ad now
        void OnLoadFinished(string msg);

        // Tells the delegate that failed to load ad, you can find out the reason according error information
        void OnLoadFailed(string error);

        // Give reward, use this callback to judge if the reward is available
        void PlayableAdsIncentive(string msg);

        // Other callback information, please see msg for more details
        void PlayableAdsMessage(string msg);
    }
    ```
    **Notice**：

1. How to make messages pass-through. Note that this needs to be on the same GameObject with the requesting. In this demo, the GameObject is Main Camera.

2. You can use the following test id when you are testing. Test id won't generate revenue, please use official id when you release your App.

| OS      | App_ID                               | Ad_Unit_id                           |
| ------- | ------------------------------------ | ------------------------------------ |
| Android | 5C5419C7-A2DE-88BC-A311-C3E7A646F6AF | 3FBEFA05-3A8B-2122-24C7-A87D0BC9FEEC |
| iOS     | A650AB0D-7BFC-2A81-3066-D3170947C3DA | BAE5DAAC-04A2-2591-D5B0-38FA846E45E7 |

## Install ZPLAY Ads SDK

### 1. Enter the root folder of the xcode project exported from unity. And initialize pod here, in our example it’s iOSProj folder:

![image](./images/image14.png)

### 2. A Podfile will be generated after the initialization. Add ZPLAY Ads sdk in this file as following:

This file may looks different in different projects. Just make sure to add```pod 'PlayableAds', '~>2.0.7'```into Podfile. 
Please Note that the OS requirement of ZPLAY Ads is iOS 8.0.

### 3. Install ZPLAY Ads sdk
```
pod install --repo-update
```
### 4. Verify if the SDK is installed
Open  **.xcworkspace** , and install the app to iPhone

![image](./images/image17.png)

Note that it's **.xcworkspace** file here, not **.xcodeproj**

### 5. Preview the demo

The whole workflow is:
* Tap “Request” to request for ads; 
* "PlayableAdsDidLoad" will be shown when an ad is loaded; 
* Tap “Present” to show the ad; 
* Tap on "X" to close it after it’s over. 
* A "PlayableAdsDidRewardUser" message will be received.

![image](./images/image19.jpg)
