## 1. Overview
### 1.1 Introduction
This guide is designed for the developers who are going to integrate ZPLAY Ads SDK into their Xcode project.
### 1.2 Develop Environment
- OS: Mac OS X10.8.5 and above
- Development environment: Xcode7 and above
- Deployment Target: iOS8 and above
### 1.3 Terms

**APPID**: ID for your Application, obtained when setting up the app within your account on ZPLAY Ads platform.

**AdUnitID**: ID for a specific ad placement within your App, as generated for your Apps within your account on ZPLAY Ads platform.  
## 2.SDK Integration
### 2.1 CocoaPods(recommended)
#### 2.1.1 Install CocoaPods 
```sh
sudo gem install cocoapods
```
#### 2.1.2 Switch terminal to root directory of iOS project, create podfile.
```sh
pod init
```
#### 2.1.3 Add ZPLAY Ads SDK into Podfile
```sh
pod 'PlayableAds'
```
##### 2.1.4 Install ZPLAY Ads SDK
```sh
pod install
```
### 2.2 Manual integration
#### 2.2.1 Download ZPLAY Ads SDK
Download ZPLAY Ads SDK [**HERE**](https://github.com/zplayads/PlayableAdsDemo-iOS/tree/master/sdk-framework). When completed, please unzip .zip file to obtain PlayableAds.framework.
#### 2.2.2 Add to project
Add the PlayableAds.framework you obtained in 2.2.1 to project.![图片](./tutorialImg/manual-add-files.png)
![图片](./tutorialImg/manual-add-files2.png)
#### 2.2.3 Add the dependencies of ZPLAY Ads
The dependency frameworks of ZPLAY Ads consist of UIKit, Foundation, WebKit, SystemConfiguration, MobileCoreServices, AdSupport, CoreLocation, CoreTelephony, StoreKit, Security.

The dependency libraries of ZPLAY Ads is xml2.

After importing: ![图片](./tutorialImg/manual-add-framework-libs.png)
#### 2.2.4 Others
Find Build Settings page in the project, add $(SDKROOT)/usr/include/libxml2 into Header Search Paths under Search Paths, and add -ObjC into Other Linker Flags under Linking.
![图片](./tutorialImg/manual-add-header-search-paths.png)
![图片](./tutorialImg/manual-add-other-linker-flags.png)
## 3. Access code
### 3.1 Initialize SDK
Initialize ZPLAY Ads, show ad.
> To pre-load an ad may take several seconds, so it’s recommended to initialize the SDK and load ads as early as possible. Please fill in the APPID and adUnitID you obtained on ZPLAY Ads platform When initializing the SDK.


```objective-c
@import PlayableAds;

@interface ViewController () <PlayableAdsDelegate>

// Create an ad and start preloading
- (PlayableAds *)createAndLoadPlayableAds {
    PlayableAds *ad = [[PlayableAds alloc] initWithAdUnitID:@"Your Ad-Unit-ID" appID:@"Your App-ID" rootViewController:self];
    ad.delegate = self;
    [ad loadAd];
    
    return ad;
}
```
Note: You can use the following test ID when testing. Test ID won't generate any revenue, please use official ID when you release your App.

| OS   | Ad_type        | App_ID                               | Ad_Unit_ID                           |
| ---- | -------------- | ------------------------------------ | ------------------------------------ |
| iOS  | Rewarded video | A650AB0D-7BFC-2A81-3066-D3170947C3DA | BAE5DAAC-04A2-2591-D5B0-38FA846E45E7 |
| iOS  | Intertitial    | A650AB0D-7BFC-2A81-3066-D3170947C3DA | 0868EBC0-7768-40CA-4226-F9924221C8EB |

### 3.2 Show Ads

When an ad is ready to display, you can play it using following method:
```objective-c
// show an ad
- (void)showAd {
    // ad is not ready, do nothing
    if (!self.ad.ready) {
        return;
    }
    
    // show the ad
    [self.ad present];
}
```
### 3.3 Determine whether an add has been loaded

You can determine the availability of an ad via this callback. 
> You are available to determine in-game settings via the following method.
```objective-c
- (void)playableAdsDidLoad:(PlayableAds *)ads {
    NSLog(@"playable ads did load");
}
```
### 3.4 Obtain reward
You are available to realize this callback to reward users, only valid for rewarded video.
> When using ZPLAY Ads to show rewarded video, you should reward those who has completed watching the video already via this callback.


```objective-c
#pragma mark - PlayableAdsDelegate
// Give reward, use this callback to judge whether the reward is available.
- (void)playableAdsDidRewardUser:(PlayableAds *)ads {
    NSLog(@"playable ads did reward");
}
```
## 4 Code Sample

```objective-c
#import "ViewController.h"

@import PlayableAds;

@interface ViewController () <PlayableAdsDelegate>

@property (nonatomic) PlayableAds *ad;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.ad = [self createAndLoadPlayableAds];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)requestAdvertising:(UIButton *)sender {
    NSLog(@"request advertising.");
    [self.ad loadAd];
}

- (IBAction)presentAdvertising:(UIButton *)sender {
    [self showAd];
}

// Create an ad and start preloading
- (PlayableAds *)createAndLoadPlayableAds {
    PlayableAds *ad = [[PlayableAds alloc] initWithAdUnitID:@"iOSDemoAdUnit" appID:@"iOSDemoApp" rootViewController:self];
    ad.delegate = self;
    return ad;
}

// Show the ad
- (void)showAd {
    // ad is not ready, do nothing
    if (!self.ad.ready) {
        return;
    }
    
    // show the ad
    [self.ad present];
}
 

#pragma mark - PlayableAdsDelegate
- (void)playableAdsDidRewardUser:(PlayableAds *)ads {
    NSLog(@"Advertising successfully presented");
}

/// Tells the delegate that succeeded to load ad.
- (void)playableAdsDidLoad:(PlayableAds *)ads {
    NSLog(@"Advertising is ready to play.");
}

/// Tells the delegate that failed to load ad.
- (void)playableAds:(PlayableAds *)ads didFailToLoadWithError:(NSError *)error {
    NSLog(@"There was a problem loading advertising: %@", error);
}

/// Tells the delegate that user starts playing the ad.
- (void)playableAdsDidStartPlaying:(PlayableAds *)ads{
   NSLog(@"Advertising start playing");
}

/// Tells the delegate that the ad is being fully played.
- (void)playableAdsDidEndPlaying:(PlayableAds *)ads{
  NSLog(@"Advertising did end playing");
}

/// Tells the delegate that the landing page did present on the screen.
- (void)playableAdsDidPresentLandingPage:(PlayableAds *)ads{
  NSLog(@"Advertising start playing");
}

/// Tells the delegate that the ad did animate off the screen.
- (void)playableAdsDidDismissScreen:(PlayableAds *)ads{
  NSLog(@"Advertising did dismiss screen");
}

/// Tells the delegate that the ad is clicked
- (void)playableAdsDidClick:(PlayableAds *)ads{
  NSLog(@"Advertising did clicked");
}
@end
```
## 5 Considerations
### 5.1 Error 400

Check whether the project has been set a Display Name.
### 5.2 Black screen when showing an ad
There may be a http link in the ad. You can add the following codes in info.plist:
```objective-c
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
	<true/>
</dict>
```
### 5.3 Request Ads ASAP
To ensure the ad can be loaded successfully, you are suggested to request ads ASAP.
### 5.4 Request Next Ad
* The SDK will request the next ad automatically when an ad has been completed or request failure. If auto-loading fails, it will retry in 5 seconds.

* If you want to request the next ad manually, please set ```playableAd.autoload = NO``` to disable auto-loading. Auto-loading is the default setting.
### 5.5 Interstitial and Rewarded Video
* From v2.0.3, you can choose to act as interstitial or rewarded video when applying for ad unit. If interstitial, the ad can be terminated during playing and no rewards will be given. If rewarded video, the ad can't be terminated during playing, and a reward will be given after playing.
* Except```- (void)playableAdsDidRewardUser:(PlayableAds *)ads```, which will not be triggered, all call and callback methods of interstitial are the same as those of rewarded video. 
