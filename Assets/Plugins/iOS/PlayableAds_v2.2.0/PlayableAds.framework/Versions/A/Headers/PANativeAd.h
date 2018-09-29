//
//  PANativeAd.h
//  Pods
//
//  Created by Michael Tang on 2018/8/27.
//

#import "PANativeAdModel.h"
#import <Foundation/Foundation.h>

@class PANativeAd;

/// Delegate methods for receiving PANativeAdDelegate state change messages.
@protocol PANativeAdDelegate <NSObject>

/// Tells the delegate that an ad has been successfully loaded.
- (void)playableNativeAdDidLoad:(PANativeAdModel *)nativeAd;

@optional
/// Tells the delegate that a request failed.
- (void)playableNativeAdDidFailWithError:(NSError *)error;

/// Tells the delegate that the Native view has been clicked.
- (void)playableNativeAdDidClick:(PANativeAdModel *)nativeAd;

@end

@interface PANativeAd : NSObject

/// channelId
@property (nonatomic) NSString *channelId;
/// Optional delegate object that receives state change notifications.
@property (nonatomic, weak, nullable) id<PANativeAdDelegate> delegate;

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

/// Initializes and returns a Native object.
- (instancetype)initWithAdUnitID:(NSString *)adUnitID appID:(NSString *)appID;

/**
 This is a method to associate a PANativeAd with the UIView you will use to display the native ads.
 - Parameter view: The UIView you created to render all the native ads data elements.
 - Parameter nativeAd: the ad you want to register.
 */
- (void)registerViewForInteraction:(UIView *)view nativeAd:(PANativeAdModel *)nativeAd;

/**
 report impression when display the native ad.
 - Parameter nativeAd: the ad you want to display.
 - Parameter view: view you display the ad.
 */
- (void)reportImpression:(PANativeAdModel *)nativeAd view:(UIView *)view;

/// Begins loading the PANativeAd.
- (void)loadAd;

@end
