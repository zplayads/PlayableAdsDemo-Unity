//
//  PlayableViewController.h
//  Pods
//
//  Created by d on 11/7/2017.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PlayableAds;

/// Delegate for receiving state change messages from PlayableAds.
@protocol PlayableAdsDelegate <NSObject>

@optional

/// Tells the delegate that the USER should be rewarded.
- (void)playableAdsDidRewardUser:(PlayableAds *)ads;

/// Tells the delegate that succeeded to load ad.
- (void)playableAdsDidLoad:(PlayableAds *)ads;

/// Tells the delegate that failed to load ad.
- (void)playableAds:(PlayableAds *)ads didFailToLoadWithError:(NSError *)error;

/// Tells the delegate that user starts playing the ad.
- (void)playableAdsDidStartPlaying:(PlayableAds *)ads;

/// Tells the delegate that the ad is being fully played.
- (void)playableAdsDidEndPlaying:(PlayableAds *)ads;

/// Tells the delegate that the landing page did present on the screen.
- (void)playableAdsDidPresentLandingPage:(PlayableAds *)ads;

/// Tells the delegate that the ad did animate off the screen.
- (void)playableAdsDidDismissScreen:(PlayableAds *)ads;

/// Tells the delegate that the ad is clicked
- (void)playableAdsDidClick:(PlayableAds *)ads;

@end

/// An playable ad. This is a full-screen advertisement shown at natural transition points in
/// your application such as between game levels or news stories.
@interface PlayableAds : NSObject

/// Optional delegate object that receives state change notifications.
@property (nonatomic, weak, nullable) id<PlayableAdsDelegate> delegate;

/// Returns YES if the ad is ready to be presented.
@property (nonatomic, assign, readonly, getter=isReady) BOOL ready;

@property (nonatomic, assign, getter=autoLoad) BOOL autoLoad;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;

/// Initializes a playable ad. DEPRECATED.
- (instancetype)initWithAdUnitID:(NSString *)adUnitID
                           appID:(NSString *)appID
              rootViewController:(UIViewController *)rootViewController
    DEPRECATED_MSG_ATTRIBUTE("Use initWithAdUnitID:appID: instead.");

/// Initializes a playable ad.
- (instancetype)initWithAdUnitID:(NSString *)adUnitID appID:(NSString *)appID;

/// LoadAd request ads in production.
- (void)loadAd;

/// Presents the ad from the view controller passed in in initialization method, must be call in main thread.
- (void)present;

@end

NS_ASSUME_NONNULL_END
