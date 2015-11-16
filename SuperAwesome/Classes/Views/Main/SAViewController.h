//
//  SAViewController.h
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 21/10/2015.
//
//

#import <UIKit/UIKit.h>

// forward declarations for SAView
@class SAView;
@class SAAd;

// import SAView Protocol
#import "SAAdProtocol.h"

// @brief:
// The SAViewController is the fullscreen equivalent to SAView
// It also defines a number of private instance variables, around
// a SAView object
@interface SAViewController : UIViewController {
    // internal SAView object
    SAView *adview;
    
    // other aux objects
    SAAd *ad;
    UIButton *closeBtn;
    
    // frames that need to be private ivars because they are used in
    // subclasses
    CGRect adviewFrame;
    CGRect buttonFrame;
}

// delegate of the SA View protocol
@property id<SAAdProtocol> delegate;

// public mmeber variables
@property (nonatomic, assign) IBInspectable BOOL isParentalGateEnabled;
@property (nonatomic, assign) IBInspectable NSInteger refreshPeriod;

// important SAview functions
- (void) setAd:(SAAd*)ad;
- (void) play;

@end
