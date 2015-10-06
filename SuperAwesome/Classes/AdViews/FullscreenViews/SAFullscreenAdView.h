//
//  SAFullscreenView.h
//  Pods
//
//  Created by Gabriel Coman on 06/10/2015.
//
//

#import "SAAdView.h"

@class SKMRAIDInterstitial;

@interface SAFullscreenAdView : SAAdView {
    SKMRAIDInterstitial *raidview;
    UIViewController *vc;
}

// custom initializer
- (id) initWithParentVC:(UIViewController*)parent andPlcementId:(NSInteger)placementId;

@end
