//
//  SAView.h
//  Pods
//
//  Created by Gabriel Coman on 12/10/2015.
//
//

#import <UIKit/UIKit.h>

// the view protocol
#import "SAAdProtocol.h"

@class SAAd;
@class SAParentalGate;
@class SAPadlockView;

@interface SAView : UIView {
    // inner ad
    SAAd *ad;
    
    // aux views
    UIButton *padlockBtn;
    SAParentalGate *gate;
    SAPadlockView *pad;
}

// delegate of the SA View protocol
@property id<SAAdProtocol> delegate;

// public mmeber variables
@property (nonatomic, assign) IBInspectable NSInteger placementId;
@property (nonatomic, assign) IBInspectable BOOL isParentalGateEnabled;
@property (nonatomic, assign) IBInspectable NSInteger refreshPeriod;
@property (nonatomic, assign) IBInspectable BOOL playInstantly;

// important SAview functions
- (void) setAd:(SAAd*)ad;
- (void) playInstant;
- (void) playPreloaded;

@end
