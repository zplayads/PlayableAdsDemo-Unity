//
//  PAMediaView.h
//  Pods
//
//  Created by Michael Tang on 2018/9/6.
//

#import <UIKit/UIKit.h>

@protocol PAMediaViewDelegate;

@interface PAMediaView : UIView

/// The view scale. width/height
@property (nonatomic, readonly, assign) CGFloat ratios;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
///  This is a method to initialize an PAMediaView.
- (instancetype)initWithMediaURL:(NSURL *)url delegate:(id<PAMediaViewDelegate>)delegate;

/// play
- (void)playVideo;
/// pause
- (void)pauseVideo;
///set video muted
- (void)setMuted:(BOOL)isMuted;

@end
@protocol PAMediaViewDelegate <NSObject>

@optional
/// Sent when an PAMediaView has been successfully loaded.
- (void)mediaViewDidLoad:(PAMediaView *)mediaView localFilePathUrl:(NSURL *)fileUrl;
/// load fail
- (void)mediaViewDidFail:(NSError *)error;

@end
