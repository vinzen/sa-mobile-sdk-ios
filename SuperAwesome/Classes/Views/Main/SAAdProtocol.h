//
//  SAViewProtocol.h
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 12/10/2015.
//
//

#import <UIKit/UIKit.h>

// @brief:
// This protocol informs the user about different events in the lifecylce
// of a normal Ad;
// It has to be implemented as a delegate object by any child of
// SAView, meaning any Ad type is valid
@protocol SAAdProtocol <NSObject>

@optional

// this function is called when the ad is shown on the screen
- (void) adWasShown:(NSInteger)placementId;

// this function is called when the ad failed to show
- (void) adFailedToShow:(NSInteger)placementId;

// this function is called when an ad is closed;
// only applies to fullscreen ads like interstitials and fullscreen videos
- (void) adWasClosed:(NSInteger)placementId;

// this function is called when an ad is clicked
- (void) adFollowedURL:(NSInteger)placementId;

// this function is called when a parental gate pop-up "cancel" button is pressed
- (void)parentalGateWasCanceled:(NSInteger)placementId;

// this function is called when a parental gate pop-up "continue" button is
// pressed and the parental gate failed (because the numbers weren't OK)
- (void)parentalGateWasFailed:(NSInteger)placementId;

// this function is called when a parental gate pop-up "continue" button is
// pressed and the parental gate succedded
- (void)parentalGateWasSucceded:(NSInteger)placementId;

@end
