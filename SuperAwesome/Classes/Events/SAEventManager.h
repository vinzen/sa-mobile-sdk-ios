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

- (void) LogAdLoad:(SAAd*) ad;
- (void) LogAdFail:(SAAd*) ad;
- (void) LogViewableImpression:(SAAd*) ad;
- (void) LogAdStop:(SAAd*) ad;
- (void) LogAdRate:(SAAd*) ad withValue:(NSInteger)value;
- (void) LogPGCancel:(SAAd*) ad;
- (void) LogPGSuccess:(SAAd*) ad;
- (void) LogPGError:(SAAd*)ad;
- (void) LogClick:(SAAd*)ad;

@end
