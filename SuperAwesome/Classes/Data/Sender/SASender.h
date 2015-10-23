//
//  SASender.h
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 11/10/2015.
//
//

#import <Foundation/Foundation.h>
#import "SAEventType.h"

// forward declaration
@class SAAd;

// @brief:
// SASender is a class that contains a multitude of functions used to send
// messages to the server in case some event gets triggered regarding an Ad
// such as viewable impression, ad rating, etc
@interface SASender : NSObject

// post a viewable impression
// this should be sent only when the ad is visible to the user
+ (void) postEventViewableImpression:(SAAd*)ad;

// post a custom AdFailed event; only when the ad failes to show for a
// reason or another
+ (void) postEventAdFailedToView:(SAAd*)ad;

// posted alongside a user rating (an integer value from 1 to 5)
+ (void) postEventAdRate:(SAAd*)ad withValue:(NSInteger)value;

// posted when a user cancels a parental gate event
+ (void) postEventPGCancel:(SAAd*)ad;

// posted when a user has success with a parental gate event
+ (void) postEventPGSuccess:(SAAd*)ad;

// posted when an event gets an error with a parental gate
+ (void) postEventPGError:(SAAd*)ad;

// posted when a user clicks on an Ad
// this event and viewable impression are the only standard events used
+ (void) postEventClick:(SAAd*)ad;

@end
