//
//  SAFullscreenVideoAd.m
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 21/10/2015.
//
//

#import "SAFullscreenVideoAd.h"
#import "SAVideoAd.h"

@implementation SAFullscreenVideoAd

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // setup a special background color
    self.view.backgroundColor = [UIColor blackColor];
    
    adview = [[SAVideoAd alloc] initWithPlacementId:super.placementId andFrame:adviewFrame];
    adview.delegate = super.delegate;
    [(SAVideoAd*)adview setVideoDelegate:_videoDelegate];
    [self.view addSubview:adview];
    
    // only <<IF>> ad is preloaded
    if (ad != NULL) {
        [adview setAd:ad];
        [adview playPreloaded];
    }
    
    // also allow these to be copied
    adview.isParentalGateEnabled = super.isParentalGateEnabled;
    adview.refreshPeriod = super.refreshPeriod;
}

@end
