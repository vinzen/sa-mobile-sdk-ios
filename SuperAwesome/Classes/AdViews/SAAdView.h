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
@class SAPadlockView;
@class SAParentalGate;

// interface declaration
@interface SAAdView : UIView {
    // the ad model object
    SAAd *ad;
    
    // other interface elements
    SAParentalGate *gate;
    SAPadlockView *pad;
    UIButton *padlockBtn;
    
    // some other variables
    NSInteger currentRefresh;
    NSTimer *timer;
}

// delegate
@property id<SAAdViewProtocol> delegate;

// public mmeber variables
@property (nonatomic, assign) IBInspectable NSInteger placementId;
@property (nonatomic, assign) IBInspectable BOOL isParentalGateEnabled;
@property (nonatomic, assign) IBInspectable NSInteger refreshPeriod;
@property (nonatomic, assign) IBInspectable BOOL playInstantly;

// major ad view functions
- (void) assignAd:(SAAd*)ad;
- (void) play;
- (void) playInstant;

@end
