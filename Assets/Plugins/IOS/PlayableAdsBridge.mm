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

/// Tells the delegate that user starts playing the ad.
- (void)playableAdsDidStartPlaying:(PlayableAds *)ads{
    NSString *inStr = @"playableAdsDidStartPlaying";
    const char *cString = [inStr cStringUsingEncoding:NSUTF8StringEncoding];
    const char *gameObject = [_gameObjName cStringUsingEncoding:NSUTF8StringEncoding];
    if (!gameObject){
        printf("pa=> playableAdsDidStartPlaying gameObject nil");
        return;
    }
    UnitySendMessage(gameObject, "PlayableAdsDidStartPlaying", cString);
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
    UnitySendMessage(gameObject, "PlayableAdsDidEndPlaying", cString);
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
    UnitySendMessage(gameObject, "PlayableAdsDidPresentLandingPage", cString);
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
    UnitySendMessage(gameObject, "PlayableAdsDidDismissScreen", cString);
}

/// Tells the delegate that the ad is clicked
- (void)playableAdsDidClick:(PlayableAds *)ads{
    NSString *inStr = @"playableAdsDidClick";
    const char *cString = [inStr cStringUsingEncoding:NSUTF8StringEncoding];
    const char *gameObject = [_gameObjName cStringUsingEncoding:NSUTF8StringEncoding];
    if (!gameObject){
        printf("pa=> playableAdsDidClick gameObject nil");
        return;
    }
    UnitySendMessage(gameObject, "PlayableAdsDidClick", cString);
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
