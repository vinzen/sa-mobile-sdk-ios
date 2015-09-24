//
//  SAEventManager.h
//  Pods
//
//  Created by Gabriel Coman on 19/09/2015.
//
//

#import <Foundation/Foundation.h>

// predef classes
@class SAEventRequest;
@class SAAdResponse;

@interface SAEventManager : NSObject

// singleton function
+ (id) sharedInstance;

// other logging functions
- (void) LogAdFetched:(SAAdResponse*) response;
- (void) LogAdLoaded:(SAAdResponse*) response;
- (void) LogViewableImpression:(SAAdResponse*) response;
- (void) LogAdFailed:(SAAdResponse*) response;
- (void) LogAdStart:(SAAdResponse*) response;
- (void) LogAdStop:(SAAdResponse*) response;
- (void) LogAdResume:(SAAdResponse*) response;
- (void) LogUserCanceledParentalGate:(SAAdResponse*) response;
- (void) LogUserSuccessWithParentalGate:(SAAdResponse*) response;
- (void) LogUserErrorWithParentalGate:(SAAdResponse*) response;
- (void) LogClick:(SAAdResponse*) response;
- (void) LogRating:(SAAdResponse*) response withValue:(int)rating;

@end
