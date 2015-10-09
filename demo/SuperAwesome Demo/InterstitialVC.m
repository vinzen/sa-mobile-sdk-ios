//
//  InterstitialVC.m
//  SuperAwesome Demo
//
//  Created by Gabriel Coman on 08/10/2015.
//  Copyright © 2015 SuperAwesome Ltd. All rights reserved.
//

#import "InterstitialVC.h"
#import "SuperAwesome.h"

@interface InterstitialVC () <SAAdPreloadProtocol, SAAdViewProtocol>

@property (nonatomic, retain) SAInterstitialAd *inter;
@end

@implementation InterstitialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[SAAdLoader sharedManager] setDelegate:self];
    [[SAAdLoader sharedManager] preloadAd:21450];
    
    _inter = [[SAInterstitialAd alloc] initWithPlcementId:21450];
    _inter.delegate = self;
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction) playAction:(id)sender {
    [_inter play];
}

#pragma mark SAAdPreload protocol function implementations

- (void) didPreloadAd:(SAAd *)ad forPlacementId:(NSInteger)placementId{
    [_inter assignAd:ad];
}

- (void) didFailToPreloadAdForPlacementId:(NSInteger)placementId {
    NSLog(@"Fail to load %ld", placementId);
}

#pragma mark SAAdView protocol function implementations

- (void) adWasShown:(NSInteger)placementId {
    NSLog(@"Ad for %ld was shown", placementId);
}

- (void) adFailedToShow:(NSInteger)placementId {
    NSLog(@"Ad for %ld failed to shown", placementId);
}

- (void) adWasClosed:(NSInteger)placementId {
    NSLog(@"Ad for %ld was closed", placementId);
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
