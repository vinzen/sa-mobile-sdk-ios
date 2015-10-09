//
//  SAAdView.h
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import <UIKit/UIKit.h>
#import "SAAdViewProtocol.h"

// forward declarations
@class SAAd;

// interface declaration
@interface SAAdView : UIView {
    SAAd *ad;
}

// delegate
@property id<SAAdViewProtocol> delegate;

// public mmeber variables
@property (nonatomic, assign) IBInspectable NSInteger placementId;
@property (nonatomic, assign) IBInspectable BOOL isParentalGateEnabled;
@property (nonatomic, assign) IBInspectable NSInteger refreshPeriod;
@property (nonatomic, assign) IBInspectable BOOL playInstantly;

@property (nonatomic, assign) NSInteger currentRefresh;
@property (nonatomic, strong) NSTimer *timer;

// major ad view functions
- (void) assignAd:(SAAd*)ad;
- (void) play;
- (void) playInstant;

// aux creation functions
- (void) onAdClick;
//- (void) timerFunc;
- (void) createPadlockButtonWithParent:(UIView*)parent;
- (void) removePadlockButtonFromParent;

@end
