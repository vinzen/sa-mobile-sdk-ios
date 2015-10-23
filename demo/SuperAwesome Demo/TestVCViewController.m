//
//  TestVCViewController.m
//  SuperAwesome Demo
//
//  Created by Gabriel Coman on 20/10/2015.
//  Copyright © 2015 SuperAwesome Ltd. All rights reserved.
//

#import "TestVCViewController.h"
#import "SuperAwesome.h"

@interface TestVCViewController () <SALoaderProtocol, SAAdProtocol, SAVideoAdProtocol>

@property (nonatomic, strong) SABannerAd *ad;

@end

@implementation TestVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[SALoader sharedManager] setDelegate:self];
    [[SALoader sharedManager] preloadAdForPlacementId:5811];
    
    _ad = [[SABannerAd alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
//    _ad = [[SABannerAd alloc] initWithPlacementId:<#(NSInteger)#> andFrame:<#(CGRect)#>]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actiion:(id)sender {
    
    SAInterstitialAd *iad = [[SAInterstitialAd alloc] initWithPlacementId:5692];
    [self presentViewController:iad animated:YES completion:^{
        [iad playInstant];
    }];
    
}
- (IBAction)action2:(id)sender {
    
    SAFullscreenVideoAd *fvad = [[SAFullscreenVideoAd alloc] initWithPlacementId:5740];
    [self presentViewController:fvad animated:YES completion:^{
        [fvad playInstant];
    }];
    
}

- (void) didPreloadAd:(SAAd *)ad forPlacementId:(NSInteger)placementId {
    
}

- (void) didFailToPreloadAdForPlacementId:(NSInteger)placementId {
    
}

@end
