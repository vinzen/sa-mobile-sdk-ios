//
//  SAAdView+Protected.h
//  Pods
//
//  Created by Gabriel Coman on 09/10/2015.
//
//

#import "SAAdView.h"

@interface SAAdView (Protected)

// on ad click
- (void) onAdClick;

// aux creation functions
- (void) createPadlockButtonWithParent:(UIView*)parent;
- (void) removePadlockButtonFromParent;

@end
