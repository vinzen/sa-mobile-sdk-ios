//
//  SAPlacement.h
//  SAMobileSDK
//
//  Created by Balázs Kiss on 01/12/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAParentalGate.h"

@interface SAPlacementView : UIView

/**
 * set two important variables for the SAPlacementView, that will carry on to the
 * subviews
 */
@property (nonatomic, strong) IBInspectable NSString *placementID;
@property (assign, nonatomic, getter=isParentalGateEnabled) IBInspectable BOOL parentalGateEnabled;

/**
 * the common padlock button
 */
@property (nonatomic, strong) UIButton *padlockBtn;

/**
 * Method to setup the padlock button
 */
- (void) setupPadlockButton:(UIView*)parent;
- (void) removePadlockButton;

@end
