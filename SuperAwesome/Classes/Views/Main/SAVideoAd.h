//
//  SAVideoAd.h
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 20/10/2015.
//
//

#import "SAView.h"
#import "SAVideoAdProtocol.h"

// @brief:
// The SAVideoAd is a subclass of SAView that uses Google IMA Ads to
// read and render VAST compliant video ads
@interface SAVideoAd : SAView {
    UIButton *actionButton;
}

// video delegate
@property id<SAVideoAdProtocol> videoDelegate;

// custom init with frame function, for preloading
- (id) initWithFrame:(CGRect)frame;

// custom init function, that assigns placement Id and frame
- (id) initWithPlacementId:(NSInteger)placementId andFrame:(CGRect)frame;

@end
