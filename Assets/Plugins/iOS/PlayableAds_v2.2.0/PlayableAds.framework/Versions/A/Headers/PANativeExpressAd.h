//
//  PANativeExpressAd.h
//  Pods
//
//  Created by Michael Tang on 2018/8/27.
//

#import "PANativeExpressAdView.h"
#import <Foundation/Foundation.h>

@protocol PANativeExpressAdDelegate <NSObject>

/// Tells the delegate that an ad has been successfully loaded.
- (void)playableNativeExpressAdDidLoad:(PANativeExpressAdView *)nativeExpressAd;

@optional
/// Tells the delegate that a request failed.
- (void)playableNativeExpressAdDidFailWithError:(NSError *)error;

/// Tells the delegate that the Native view has been clicked.
- (void)playableNativeExpressAdDidClick:(PANativeExpressAdView *)nativeExpressAd;

@end

@interface PANativeExpressAd : NSObject

@property (nonatomic) NSString *channelId;
/// Optional delegate object that receives state change notifications.
@property (nonatomic, weak, nullable) id<PANativeExpressAdDelegate> delegate;

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

/// Initializes and returns a Native object.
- (instancetype)initWithAdUnitID:(NSString *)adUnitID appID:(NSString *)appID adSize:(CGSize)size;
/// Begins loading the PANativeExpressAd.
- (void)loadAd;

@end
