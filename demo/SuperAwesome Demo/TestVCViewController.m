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
@property (nonatomic, strong) SAInterstitialAd *ad;
@end

@implementation TestVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[SALoader sharedManager] preloadAdForPlacementId:21924];
    [[SALoader sharedManager] setDelegate:self];
    
    _ad = [[SAInterstitialAd alloc] init];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonAction:(id)sender {
    [_ad playPreloaded];
}

- (void) didPreloadAd:(SAAd *)ad forPlacementId:(NSInteger)placementId {
    [_ad setAd:ad];
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
