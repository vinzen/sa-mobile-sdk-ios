//
//  SAParentalGateProtocol.h
//  Pods
//
//  Created by Gabriel Coman on 23/10/2015.
//
//

#import <UIKit/UIKit.h>

// @brief:
// A custom protocol that defines functions that respond to parental gate
// actions
@protocol SAParentalGateProtocol <NSObject>

// all functions are optional
@optional

// called when parental gate btn "cancel" is pressed
- (void)parentalGateWasCanceled;

// called when parental gate btn "continue" is pressed, but the numbers
// don't match (e.g. failure)
- (void)parentalGateWasFailed;

// called when parental gate btn "continue" is pressed, and the numbers match
// (e..g user goes forward to ad)
- (void)parentalGateWasSuccededAndShouldGoTo:(NSURL*)url;

@end