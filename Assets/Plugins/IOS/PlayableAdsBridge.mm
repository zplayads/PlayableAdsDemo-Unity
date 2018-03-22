//
//  PlayableAdsBridge.mm
//
//
//  Created by lgd on 2017/12/18.
//

#import "PlayableAdsBridge.h"

@implementation Delegate

- (id) init
{
    return self;
}

- (void)playableAdsDidRewardUser:(PlayableAds *)ads {
    const char *gameObject = [_gameObjName cStringUsingEncoding:NSUTF8StringEncoding];
    if (!gameObject) {
        printf("pa=> playableAdsDidRewardUser gameObject nil");
        return;
    }
    UnitySendMessage(gameObject, "PlayableAdsDidRewardUser", "");
}

/// Tells the delegate that succeeded to load ad.
- (void)playableAdsDidLoad:(PlayableAds *)ads {
    const char *gameObject = [_gameObjName cStringUsingEncoding:NSUTF8StringEncoding];
    if (!gameObject){
        printf("pa=> playableAdsDidLoad gameObject nil");
        return;
    }
    UnitySendMessage(gameObject, "PlayableAdsDidLoad", "");
}

/// Tells the delegate that failed to load ad.
- (void)playableAds:(PlayableAds *)ads didFailToLoadWithError:(NSError *)error{
    NSString *inStr = error.description;
    const char *cString = [inStr cStringUsingEncoding:NSUTF8StringEncoding];
    const char *gameObject = [_gameObjName cStringUsingEncoding:NSUTF8StringEncoding];
    if (!cString) {
        cString = "unkown";
    }
    if (!gameObject){
        printf("pa=> didFailToLoadWithError gameObject nil");
        return;
    }
    UnitySendMessage(gameObject, "DidFailToLoadWithError", cString);
}

/// Tells the delegate that ad will be presented on the screen.
- (void)playableAdsWillPresentScreen:(PlayableAds *)ads{
    NSString *inStr = @"playableAdsWillPresentScreen";
    const char *cString = [inStr cStringUsingEncoding:NSUTF8StringEncoding];
    const char *gameObject = [_gameObjName cStringUsingEncoding:NSUTF8StringEncoding];
    if (!gameObject){
        printf("pa=> playableAdsWillPresentScreen gameObject nil");
        return;
    }
    UnitySendMessage(gameObject, "PlayableAdFeedBack", cString);
}

/// Tells the delegate that ad did present on the screen.
- (void)playableAdsDidPresentScreen:(PlayableAds *)ads{
    NSString *inStr = @"playableAdsDidPresentScreen";
    const char *cString = [inStr cStringUsingEncoding:NSUTF8StringEncoding];
    const char *gameObject = [_gameObjName cStringUsingEncoding:NSUTF8StringEncoding];
    if (!gameObject){
        printf("pa=> playableAdsDidPresentScreen gameObject nil");
        return;
    }
    UnitySendMessage(gameObject, "PlayableAdFeedBack", cString);
}

/// Tells the delegate that user starts playing the ad.
- (void)playableAdsDidStartPlaying:(PlayableAds *)ads{
    NSString *inStr = @"playableAdsDidStartPlaying";
    const char *cString = [inStr cStringUsingEncoding:NSUTF8StringEncoding];
    const char *gameObject = [_gameObjName cStringUsingEncoding:NSUTF8StringEncoding];
    if (!gameObject){
        printf("pa=> playableAdsDidStartPlaying gameObject nil");
        return;
    }
    UnitySendMessage(gameObject, "PlayableAdFeedBack", cString);
}

/// Tells the delegate that the ad is being fully played.
- (void)playableAdsDidEndPlaying:(PlayableAds *)ads{
    NSString *inStr = @"playableAdsDidEndPlaying";
    const char *cString = [inStr cStringUsingEncoding:NSUTF8StringEncoding];
    const char *gameObject = [_gameObjName cStringUsingEncoding:NSUTF8StringEncoding];
    if (!gameObject){
        printf("pa=> playableAdsDidEndPlaying gameObject nil");
        return;
    }
    UnitySendMessage(gameObject, "PlayableAdFeedBack", cString);
}

/// Tells the delegate that the landing page did present on the screen.
- (void)playableAdsDidPresentLandingPage:(PlayableAds *)ads{
    NSString *inStr = @"playableAdsDidPresentLandingPage";
    const char *cString = [inStr cStringUsingEncoding:NSUTF8StringEncoding];
    const char *gameObject = [_gameObjName cStringUsingEncoding:NSUTF8StringEncoding];
    if (!gameObject){
        printf("pa=> playableAdsDidPresentLandingPage gameObject nil");
        return;
    }
    UnitySendMessage(gameObject, "PlayableAdFeedBack", cString);
}

/// Tells the delegate that the ad will be animated off the screen.
- (void)playableAdsWillDismissScreen:(PlayableAds *)ads{
    NSString *inStr = @"playableAdsWillDismissScreen";
    const char *cString = [inStr cStringUsingEncoding:NSUTF8StringEncoding];
    const char *gameObject = [_gameObjName cStringUsingEncoding:NSUTF8StringEncoding];
    if (!gameObject){
        printf("pa=> playableAdsWillDismissScreen gameObject nil");
        return;
    }
    UnitySendMessage(gameObject, "PlayableAdFeedBack", cString);
}

/// Tells the delegate that the ad did animate off the screen.
- (void)playableAdsDidDismissScreen:(PlayableAds *)ads{
    NSString *inStr = @"playableAdsDidDismissScreen";
    const char *cString = [inStr cStringUsingEncoding:NSUTF8StringEncoding];
    const char *gameObject = [_gameObjName cStringUsingEncoding:NSUTF8StringEncoding];
    if (!gameObject){
        printf("pa=> playableAdsDidDismissScreen gameObject nil");
        return;
    }
    UnitySendMessage(gameObject, "PlayableAdFeedBack", cString);
}

/// Tells the delegate that the ad is clicked from landing page.
- (void)playableAdsDidClickFromLandingPage:(PlayableAds *)ads{
    NSString *inStr = @"playableAdsDidClickFromLandingPage";
    const char *cString = [inStr cStringUsingEncoding:NSUTF8StringEncoding];
    const char *gameObject = [_gameObjName cStringUsingEncoding:NSUTF8StringEncoding];
    if (!gameObject){
        printf("pa=> playableAdsDidClickFromLandingPage gameObject nil");
        return;
    }
    UnitySendMessage(gameObject, "PlayableAdFeedBack", cString);
}

/// Tells the delegate that the ad is clicked from video page.
- (void)playableAdsDidClickFromVideoPage:(PlayableAds *)ads{
    NSString *inStr = @"playableAdsDidClickFromVideoPage";
    const char *cString = [inStr cStringUsingEncoding:NSUTF8StringEncoding];
    const char *gameObject = [_gameObjName cStringUsingEncoding:NSUTF8StringEncoding];
    if (!gameObject){
        printf("pa=> playableAdsDidClickFromVideoPage gameObject nil");
        return;
    }
    UnitySendMessage(gameObject, "PlayableAdFeedBack", cString);
}

/// Tells the delegate that it will leaven the application, most likely caused by user click.
- (void)playableAdsWillLeaveApplication:(PlayableAds *)ads{
    NSString *inStr = @"playableAdsWillLeaveApplication";
    const char *cString = [inStr cStringUsingEncoding:NSUTF8StringEncoding];
    const char *gameObject = [_gameObjName cStringUsingEncoding:NSUTF8StringEncoding];
    if (!gameObject){
        printf("pa=> playableAdsWillLeaveApplication gameObject nil");
        return;
    }
    UnitySendMessage(gameObject, "PlayableAdFeedBack", cString);
}

@end

static Delegate* delegateObj;

extern "C"
{
    void _loadAd(const char* gameObj, const char* appId, const char* adUnitId){
        if (delegateObj == nil){
            delegateObj = [[Delegate alloc]init];
        }
        delegateObj.pAd = [[PlayableAds alloc]
                           initWithAdUnitID:[NSString stringWithUTF8String:adUnitId]
                           appID:[NSString stringWithUTF8String:appId]];
        delegateObj.pAd.delegate = delegateObj;
        delegateObj.gameObjName = [NSString stringWithUTF8String: gameObj];
        [delegateObj.pAd loadAd];
    }
    
    void _showAd(const char* appId, const char* adUnitId){
        if (delegateObj != nil && delegateObj.pAd != nil){
            [delegateObj.pAd present];
        }
    }
    
    Boolean _isReady(){
        if(delegateObj != nil && delegateObj.pAd != nil){
            return [delegateObj.pAd isReady];
        }
        return NO;
    }
    
    void _autoload(const bool autoload) {
        if(delegateObj != nil && delegateObj.pAd != nil){
            delegateObj.pAd.autoLoad = autoload;
        }
    }
    
    Boolean _isAutoload(){
        if(delegateObj != nil && delegateObj.pAd != nil){
            return delegateObj.pAd.autoLoad;
        }
        return NO;
    }
}
