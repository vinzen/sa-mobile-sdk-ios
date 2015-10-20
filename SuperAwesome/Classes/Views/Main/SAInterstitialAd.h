//
//  SAFullscreenView.h
//  Pods
//
//  Created by Gabriel Coman on 12/10/2015.
//
//

#import "SAView.h"

@class SKMRAIDInterstitial;

@interface SAInterstitialAd : SAView {
    // private vars
    UIViewController *vc;
    SKMRAIDInterstitial *raidinterstitial;
}

// custom init
- (id) initWithPlacementId:(NSInteger)placementId;

@end
