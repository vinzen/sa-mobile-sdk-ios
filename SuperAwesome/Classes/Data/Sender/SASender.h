//
//  SASender.h
//  Pods
//
//  Created by Gabriel Coman on 11/10/2015.
//
//

#import <Foundation/Foundation.h>

// forward declaration
@class SAAd;

// specific events for the ads
typedef NS_ENUM(NSUInteger, SAEventType) {
    NoAd = -1,
    viewable_impression = 0,
    AdFailedToView = 1,
    AdRate,
    AdPGCancel,
    AdPGSuccess,
    AdPGError
};

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
