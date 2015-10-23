//
//  SAFullscreenView.m
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 12/10/2015.
//
//

#import "SAInterstitialAd.h"
#import "SABannerAd.h"

@implementation SAInterstitialAd

- (void) viewDidLoad {
    [super viewDidLoad];
    
    adview = [[SABannerAd alloc] initWithPlacementId:super.placementId andFrame:adviewFrame];
    adview.delegate = super.delegate;
    [self.view addSubview:adview];
    
    // only <<IF>> ad is preloaded
    if (ad != NULL) {
        [adview setAd:ad];
    }
    
    // also allow these to be copied
    adview.isParentalGateEnabled = super.isParentalGateEnabled;
    adview.refreshPeriod = super.refreshPeriod;
}

@end
