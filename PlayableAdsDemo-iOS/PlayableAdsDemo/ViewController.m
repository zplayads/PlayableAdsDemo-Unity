//
//  ViewController.m
//  PlayableAdsDemo
//
//  Created by lgd on 2017/11/6.
//  Copyright © 2017年 lgd. All rights reserved.
//

#import "ViewController.h"

@import PlayableAds;

@interface ViewController () <PlayableAdsDelegate>
@property (nonatomic) PlayableAds *ad;

@property (weak, nonatomic) IBOutlet UIButton *requestAd;
@property (weak, nonatomic) IBOutlet UIButton *presentAd;

@property (weak, nonatomic) IBOutlet UILabel *logLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init Playable Advertising.
    _ad = [[PlayableAds alloc] initWithAdUnitID:@"BAE5DAAC-04A2-2591-D5B0-38FA846E45E7" appID:@"A650AB0D-7BFC-2A81-3066-D3170947C3DA"];
    _ad.delegate = self;
    [self requestAdvertising:nil];
}

-(void)viewDidDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)requestAdvertising:(UIButton *)sender {
    [self addLog:@"request advertising."];
    [_ad loadAd];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [sender setEnabled:NO];
}

- (IBAction)presentAdvertising:(UIButton *)sender {
    if (_ad.isReady) {
        [self addLog:@"show advertising"];
        // show the ad
        [_ad present];
    }else {
        // ad is not ready, do nothing
        [self addLog:@"advertising has not ready."];
    }
}

- (IBAction)autoloadAd:(UISwitch *)sender {
    _ad.autoLoad = sender.isOn;
    if (sender.isOn){
        [_ad loadAd];
        [_requestAd setEnabled:NO];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    } else {
        [_requestAd setEnabled:YES];
    }
}

- (void) addLog: (NSString*) log {
    NSLog(@"PA log: %@", log);
    
    NSString *newLineLog = [_logLabel.text stringByAppendingString:@"\n"];
    _logLabel.text = [newLineLog stringByAppendingString: log];
}

- (IBAction)clearLog:(id)sender {
    _logLabel.text = @"info: long press to clear.";
}

#pragma mark - PlayableAdsDelegate
- (void)playableAdsDidRewardUser:(PlayableAds *)ads {
    NSLog(@"playableAdsDidRewardUser");
    [self addLog:@"playableAdsDidRewardUser"];
}

/// Tells the delegate that succeeded to load ad.
- (void)playableAdsDidLoad:(PlayableAds *)ads {
    NSLog(@"playableAdsDidLoad");
    [self addLog:@"playableAdsDidLoad"];
    if(!_ad.autoLoad){
        [_requestAd setEnabled:YES];
    }else {
        [_requestAd setEnabled:NO];
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

/// Tells the delegate that failed to load ad.
- (void)playableAds:(PlayableAds *)ads didFailToLoadWithError:(NSError *)error {
    NSLog(@"playableAds error:\n%@", error);
    if(!_ad.autoLoad){
        [_requestAd setEnabled:YES];
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self addLog: [@"\nThere was a problem loading advertising:" stringByAppendingString:[error localizedDescription] ]];
}

- (void)playableAdsDidEndPlaying:(PlayableAds *)ads{
     [self addLog:@"playableAdsDidEndPlaying"];
}
- (void)playableAdsDidStartPlaying:(PlayableAds *)ads{
    [self addLog:@"playableAdsDidStartPlaying"];
}

- (void)playableAdsDidPresentLandingPage:(PlayableAds *)ads{
    [self addLog:@"playableAdsDidPresentLandingPage"];
}

- (void)playableAdsDidClick:(PlayableAds *)ads{
    [self addLog:@"playableAdsDidClick"];
}

- (void)playableAdsDidDismissScreen:(PlayableAds *)ads{
    [self addLog:@"playableAdsDidDismissScreen"];
}

@end
