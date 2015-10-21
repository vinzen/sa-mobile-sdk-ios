//
//  TestVCViewController.m
//  SuperAwesome Demo
//
//  Created by Gabriel Coman on 20/10/2015.
//  Copyright © 2015 SuperAwesome Ltd. All rights reserved.
//

#import "TestVCViewController.h"
#import "SuperAwesome.h"

@interface TestVCViewController () <SALoaderProtocol>

@property (nonatomic, strong) SAInterstitialAd *inter;
@property (nonatomic, strong) SAFullscreenVideoAd *fvid;

@end

@implementation TestVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[SALoader sharedManager] preloadAdForPlacementId:21022];
    [[SALoader sharedManager] preloadAdForPlacementId:21924];
    [[SALoader sharedManager] setDelegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonAction:(id)sender {
    
    [self presentViewController:_inter animated:YES completion:^{
        [_inter playPreloaded];
    }];
}

- (IBAction)button2Action:(id)sender {
    _fvid.isParentalGateEnabled = YES;
    [self presentViewController:_fvid animated:YES completion:^{
         [_fvid playPreloaded];
    }];
   
}

- (void) didPreloadAd:(SAAd *)ad forPlacementId:(NSInteger)placementId {
    if (placementId == 21022) {
        _fvid = [[SAFullscreenVideoAd alloc] initWithPlacementId:21022];
        [_fvid setAd:ad];
    }
    else if (placementId == 21924) {
        _inter = [[SAInterstitialAd alloc] initWithPlacementId:21924];
        [_inter setAd:ad];
    }
}

- (void) didFailToPreloadAdForPlacementId:(NSInteger)placementId {
    NSLog(@"Failed");
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
