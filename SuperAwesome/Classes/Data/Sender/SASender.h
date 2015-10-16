//
//  SASender.h
//  Pods
//
//  Created by Gabriel Coman on 11/10/2015.
//
//

#import <Foundation/Foundation.h>
#import "SAEventType.h"

// forward declaration
@class SAAd;

@interface SASender : NSObject

// sa sender functions
+ (void) postEventViewableImpression:(SAAd*)ad;
+ (void) postEventAdFailedToView:(SAAd*)ad;
+ (void) postEventAdRate:(SAAd*)ad withValue:(NSInteger)value;
+ (void) postEventPGCancel:(SAAd*)ad;
+ (void) postEventPGSuccess:(SAAd*)ad;
+ (void) postEventPGError:(SAAd*)ad;
+ (void) postEventClick:(SAAd*)ad;

@end
