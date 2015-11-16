//
//  SAView.h
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 12/10/2015.
//
//

#import <UIKit/UIKit.h>

// the view protocol
#import "SAAdProtocol.h"

// forward declarations of different classes that are needed for a SAView
@class SAAd;
@class SAParentalGate;
@class SAPadlockView;

// Interface declaration of SAView with some private instance variables
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

// a boolean that determines whether parental gate will be shown or not
@property (nonatomic, assign) IBInspectable BOOL isParentalGateEnabled;

// an integer which specifies when an ad should be relaoded
@property (nonatomic, assign) IBInspectable NSInteger refreshPeriod;

// this function acts as setter for the ad object
- (void) setAd:(SAAd*)ad;

// play instant function
- (void) play;

@end
