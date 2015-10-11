//
//  RichMediaVC.m
//  SuperAwesome Demo
//
//  Created by Gabriel Coman on 09/10/2015.
//  Copyright © 2015 SuperAwesome Ltd. All rights reserved.
//

#import "RichMediaVC.h"
#import "SuperAwesome.h"

@interface RichMediaVC () <SAAdPreloadProtocol, SAAdViewProtocol>
@property (weak, nonatomic) IBOutlet SABannerAd *bannerAd;
@end

@implementation RichMediaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[SAAdLoader sharedManager] setDelegate:self];
    [[SAAdLoader sharedManager] preloadAd:21746];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Preload protocol

- (void) didPreloadAd:(SAAd *)ad forPlacementId:(NSInteger)placementId {
    [_bannerAd assignAd:ad];
    [_bannerAd play];
}

- (void) didFailToPreloadAdForPlacementId:(NSInteger)placementId {
    NSLog(@"Failed to load %ld", placementId);
}

#pragma mark View protocol

- (void) adWasShown:(NSInteger)placementId {
    NSLog(@"Showing ad %ld", placementId);
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
