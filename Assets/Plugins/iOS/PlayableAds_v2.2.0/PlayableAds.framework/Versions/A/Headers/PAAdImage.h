//
//  PAAdImage.h
//  Pods
//
//  Created by Michael Tang on 2018/9/5.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PAAdImage : NSObject

/// The image.
@property (nonatomic, readonly, strong, nullable) UIImage *image;
/// The image's URL.
@property (nonatomic, readonly, copy) NSURL *imageURL;
/// The image's scale. width/height
@property (nonatomic, readonly, assign) CGFloat ratios;
/// This is a method to initialize an PAAdImage.
///- Parameter url: the image url.
- (instancetype)initWithURL:(NSURL *)url NS_DESIGNATED_INITIALIZER;
/// Loads an image from self.url over the network, or returns the cached image immediately.
/// - Parameter block: Block to handle the loaded image.
- (void)loadImageAsyncWithBlock:(nullable void (^)(UIImage *__nullable image))block;

@end
