//
//  SAEventManager.h
//  Pods
//
//  Created by Gabriel Coman on 19/09/2015.
//
//

#import <Foundation/Foundation.h>

// predef classes
@class SAEvent;
@class SAAd;

@interface SAEventManager : NSObject

// singleton function
+ (id) sharedInstance;

- (void) LogAdView:(SAAd*) ad;
- (void) LogAdFailedToView:(SAAd*)ad;
- (void) LogAdRate:(SAAd*) ad withValue:(NSInteger)value;
- (void) LogAdPGCancel:(SAAd*) ad;
- (void) LogAdPGSuccess:(SAAd*) ad;
- (void) LogAdPGError:(SAAd*)ad;
- (void) LogClick:(SAAd*)ad;

@end
