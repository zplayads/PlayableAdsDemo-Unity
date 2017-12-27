//
//  PlayableAdsBridge.h
//
//
//  Created by lgd on 2017/12/18.
//

#import <Foundation/Foundation.h>
#import <PlayableAds/PlayableAds.h>

@interface Delegate : NSObject<PlayableAdsDelegate>
@property (nonatomic) PlayableAds *pAd;
@property (nonatomic) NSString *gameObjName;
@end

