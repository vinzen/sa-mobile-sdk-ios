//
//  SAScreenView.h
//  Pods
//
//  Created by Gabriel Coman on 06/10/2015.
//
//

#import "SAAdView.h"

@class SKMRAIDView;

@interface SAInScreenAdView : SAAdView {
    SKMRAIDView *raidview;
}

// designated code init
- (id) initWithFrame:(CGRect)frame andPlacementId:(NSInteger)placementId;

@end
