//
//  SANetwork+Ad.h
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import "SANetwork.h"

// forward declaration
@class SAAd;
@class SAEvent;

// typedef a Block specifically for the ad
typedef void (^gotad)(SAAd *ad);
typedef void (^gothtml)(NSString *string);
typedef void (^postevent)();
typedef void (^postclick)();

@interface SANetwork (Ad)

// function that gets an ad from the server
+ (void) getAdWith:(NSInteger)placementId withSuccess:(gotad)gotad orFailure:(failure)failure;
+ (void) postEvent:(SAEvent*)event withSuccess:(postevent)postevent orFailure:(failure)failure;
+ (void) postClick:(SAEvent*)event withSuccess:(postclick)postclick orFailure:(failure)failure;
+ (void) getAdHTMLWith:(NSString*)url withsuccess:(gothtml)gothtml orFailure:(failure)failure;

@end
