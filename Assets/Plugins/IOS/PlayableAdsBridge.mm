//
//  PlayableAdsBridge.mm
//
//
//  Created by lgd on 2017/12/18.
//

#import "PlayableAdsBridge.h"
static Delegate* delegateObj;
static NSString* channel;
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
    UnitySendMessage(gameObject, "PlayableAdsDidRewardUser", [[self getUnitIdFrom:ads] UTF8String]);
}

/// Tells the delegate that succeeded to load ad.
- (void)playableAdsDidLoad:(PlayableAds *)ads {
    const char *gameObject = [_gameObjName cStringUsingEncoding:NSUTF8StringEncoding];
    if (!gameObject){
        printf("pa=> playableAdsDidLoad gameObject nil");
        return;
    }
    UnitySendMessage(gameObject, "PlayableAdsDidLoad", [[self getUnitIdFrom:ads] UTF8String]);
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

- (NSString*)getUnitIdFrom:(PlayableAds*)ad{
    NSString* result = @"";
    if (!delegateObj.pAds){
        return result;
    }
    __block NSString* theKey = @"";
    [delegateObj.pAds enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if(obj == ad){
            theKey = key;
        }
    }];
    if (theKey.length > 0){
        NSArray* kArray = [theKey componentsSeparatedByString: delegateObj.appId];
        if ([kArray count] == 2){
            result = kArray[1];
        }
    }
    return result;
}

@end

extern "C"
{
    void _init(const char* gameObj, const char* appId) {
        if (delegateObj == nil){
            delegateObj = [[Delegate alloc]init];
            delegateObj.pAds = [[NSMutableDictionary alloc] init];
            delegateObj.appId = [NSString stringWithUTF8String:appId];
            delegateObj.gameObjName = [NSString stringWithUTF8String:gameObj];
            delegateObj.autoload = true;
        }
    }
    
    NSString* unitId2adKey(const char* unitId){
        if (delegateObj == nil || !delegateObj.appId){
            return @"";
        }
        return [NSString stringWithFormat:@"%@%s", delegateObj.appId, unitId];
    }
    
    PlayableAds* getAd(const char* unitId){
        if (delegateObj == nil || [delegateObj.pAds count] < 1){
            return nil;
        }
        return [delegateObj.pAds objectForKey:unitId2adKey(unitId)];
    }
    
    bool addAd(const char* unitId){
        if (delegateObj == nil || !delegateObj.pAds){
            return false;
        }
        PlayableAds* pa = [[PlayableAds alloc]
                           initWithAdUnitID:[NSString stringWithUTF8String:unitId]
                           appID:delegateObj.appId];
        pa.delegate = delegateObj;
        pa.autoLoad = delegateObj.autoload;
        [delegateObj.pAds setObject:pa forKey:unitId2adKey(unitId)];
        return true;
    }
    
    void _loadAd(const char* adUnitId){
        if (!getAd(adUnitId) && !addAd(adUnitId)){
            return;
        }
        PlayableAds* pa = getAd(adUnitId);
        pa.channelId = channel;
        [pa loadAd];
    }
    
    bool _isReady(const char* adUnitId){
        PlayableAds* pa = getAd(adUnitId);
        if (!pa){
            return false;
        }
        return [pa isReady];
    }
    
    void _showAd(const char* adUnitId){
        if (_isReady(adUnitId)){
            [getAd(adUnitId) present];
        }else{
            NSLog(@"ZPLAYAds not ready");
        }
    }
    
    void _autoload(const bool autoload) {
        delegateObj.autoload = autoload;
        if (!delegateObj.pAds){
            return;
        }
        [delegateObj.pAds enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            PlayableAds* pa = obj;
            pa.autoLoad = autoload;
        }];
    }
    
    void _setChannelId(const char* channelId) {
        channel = [NSString stringWithFormat:@"%s", channelId];
    }

    Boolean _isAutoload(){
        return delegateObj.autoload;
    }
    
}
