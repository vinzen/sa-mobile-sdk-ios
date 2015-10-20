//
//  SAHalfscreenView.h
//  Pods
//
//  Created by Gabriel Coman on 12/10/2015.
//
//

#import "SAView.h"

@class SKMRAIDView;

@interface SABannerAd : SAView {
    SKMRAIDView *raidview;
}

- (id) initWithPlacementId:(NSInteger)placementId andFrame:(CGRect)frame;

@end
