//
//  ComplexVC.m
//  SuperAwesome Demo
//
//  Created by Gabriel Coman on 09/10/2015.
//  Copyright © 2015 SuperAwesome Ltd. All rights reserved.
//

#import "ComplexVC.h"
#import "SuperAwesome.h"

@interface ComplexVC () <SAAdPreloadProtocol>

// four different types of Ads
@property (weak, nonatomic) IBOutlet SABannerAd *leaderboardAd;
@property (weak, nonatomic) IBOutlet SAVideoAd *videoAd;
@property (weak, nonatomic) IBOutlet SABannerAd *bannerAd;
@property (nonatomic, retain) SAInterstitialAd *interstitialAd;

@end

@implementation ComplexVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // preload the banner, video and interstitial ads
    [[SAAdLoader sharedManager] setDelegate:self];
    [[SAAdLoader sharedManager] preloadAd:21863]; // banner
    [[SAAdLoader sharedManager] preloadAd:21925]; // video
    
    _interstitialAd = [[SAInterstitialAd alloc] initWithPlcementId:21924];
    
    // load the leaderboard instantly
    [_leaderboardAd playInstant];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Button Actions

- (IBAction) playPreloadedMovie:(id)sender {
    [_videoAd play];
}

- (IBAction) openPreloadedInterstitial:(id)sender {
    [_interstitialAd playInstant];
}

#pragma mark SA Protocol function implementations

- (void) didPreloadAd:(SAAd *)ad forPlacementId:(NSInteger)placementId{
    if (placementId == 21863) {
        [_bannerAd assignAd:ad];
        [_bannerAd play];
    }
    else if (placementId == 21925){
        [_videoAd assignAd:ad];
    }
}

- (void) didFailToPreloadAdForPlacementId:(NSInteger)placementId {
    NSLog(@"Fail to load ad %ld", placementId);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
