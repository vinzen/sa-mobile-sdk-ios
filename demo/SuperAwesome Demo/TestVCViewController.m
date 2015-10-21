//
//  TestVCViewController.m
//  SuperAwesome Demo
//
//  Created by Gabriel Coman on 20/10/2015.
//  Copyright © 2015 SuperAwesome Ltd. All rights reserved.
//

#import "TestVCViewController.h"
#import "SuperAwesome.h"

@interface TestVCViewController () <SALoaderProtocol, SAViewProtocol, SAVideoAdProtocol>

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
    _fvid.delegate = self;
    _fvid.videoDelegate = self;
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

#pragma mark View Protocol

- (void) adWasShown:(NSInteger)placementId {
    NSLog(@"Ad %ld was shown", placementId);
}

- (void) adFailedToShow:(NSInteger)placementId {
    NSLog(@"Ad %ld failed to show", placementId);
}

- (void) adWasClosed:(NSInteger)placementId {
    NSLog(@"Ad %ld was closed", placementId);
}

- (void) adFollowedURL:(NSInteger)placementId {
    NSLog(@"Ad %ld went to URL", placementId);
}

- (void)parentalGateWasCanceled:(NSInteger)placementId {
    NSLog(@"Ad %ld canceled parental gate", placementId);
}

- (void)parentalGateWasFailed:(NSInteger)placementId {
    NSLog(@"Ad %ld failed parental gate", placementId);
}

- (void)parentalGateWasSucceded:(NSInteger)placementId {
    NSLog(@"Ad %ld OK parental gate", placementId);
}

#pragma mark Video Protocol

- (void) videoStarted:(NSInteger)placementId {
    NSLog(@"DELEGATE VIDEO STARTED %ld", placementId);
}

- (void) videoEnded:(NSInteger)placementId {
    NSLog(@"DELEGATE VIDEO ENDED %ld", placementId);
}

- (void) videoReachedFirstQuartile:(NSInteger)placementId {
    NSLog(@"DELEGATE VIDEO 1/4 %ld", placementId);
}

- (void) videoReachedMidpoint:(NSInteger)placementId {
    NSLog(@"DELEGATE VIDEO 1/2 %ld", placementId);
}

- (void) videoReachedThirdQuartile:(NSInteger)placementId {
   NSLog(@"DELEGATE VIDEO 3/4 %ld", placementId);
}

- (void) videoSkipped:(NSInteger)placementId {
   NSLog(@"DELEGATE VIDEO SKIPPED %ld", placementId);
}

@end
