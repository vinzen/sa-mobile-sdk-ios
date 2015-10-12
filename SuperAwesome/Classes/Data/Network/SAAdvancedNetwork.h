//
//  SAAdvancedNetwork.h
//  Pods
//
//  Created by Gabriel Coman on 11/10/2015.
//
//

#import "SABaseNetwork.h"

// forward declaration
@class SAAd;
@class SAEvent;

// callback for a success method with AD response
typedef void (^gotad)(SAAd *ad);

// callback for a success method with a HTML string
typedef void (^gothtml)(NSString *string);

// callback for a successfull post event
typedef void (^postevent)();

// callback for a successfull click event
typedef void (^postclick)();

@interface SAAdvancedNetwork : SABaseNetwork

// function that gets an ad from the server
+ (void) getAdWith:(NSInteger)placementId withSuccess:(gotad)gotad orFailure:(failure)failure;

// function that gets aux ad data
+ (void) getAdAuxData:(NSString*)url withsuccess:(gothtml)gothtml orFailure:(failure)failure;

// function that posts an event
+ (void) postEvent:(SAEvent*)event withSuccess:(postevent)postevent orFailure:(failure)failure;

// function that posts a click
+ (void) postClick:(SAEvent*)event withSuccess:(postclick)postclick orFailure:(failure)failure;

@end
