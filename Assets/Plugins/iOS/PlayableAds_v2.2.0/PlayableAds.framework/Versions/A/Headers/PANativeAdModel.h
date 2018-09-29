//
//  PANativeAdModel.h
//  Pods
//
//  Created by Michael Tang on 2018/8/27.
//

#import "PAAdImage.h"
#import "PAMediaView.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PANativeAdModel : NSObject

/// AdID
@property (nonatomic, assign, readonly) NSUInteger nativeAdID;
/// htmlRatios
@property (nonatomic, assign, readonly) CGFloat ratios;
/// PAMediaView
@property (nonatomic, strong, readonly, nullable) PAMediaView *mediaView;
/// title
@property (nonatomic, copy, readonly, nullable) NSString *title;
/// description
@property (nonatomic, copy, readonly, nullable) NSString *desc;
/// icon url
@property (nonatomic, strong, readonly, nullable) PAAdImage *icon;
/// cover image url
@property (nonatomic, strong, readonly, nullable) PAAdImage *coverImage;
/// UIButton
@property (nonatomic, strong, readonly, nullable) UIButton *callToAction;

@end
