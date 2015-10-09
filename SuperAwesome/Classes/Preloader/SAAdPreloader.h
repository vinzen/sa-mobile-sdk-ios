//
//  AdLoader.h
//  Pods
//
//  Created by Gabriel Coman on 09/10/2015.
//
//

#import <Foundation/Foundation.h>
#import "SANetwork+Ad.h"

// forward declarations
@class SAAd;

@protocol SAPreloadProtocol <NSObject>

// main protocol functions
@optional
- (void) didPreloadAd:(SAAd*)ad;
- (void) didFailToPreloadAd:(NSInteger)placementId;

@end

@interface SAAdPreloader : NSObject

// delegate
@property id<SAPreloadProtocol> delegate;

// singleton instance (instead of init)
+ (SAAdPreloader *)sharedManager;

// preload ad function
- (void) preloadAd:(NSInteger)placementId;

// function that gets an ad and uses blocks to signal finishing or failing the job
- (void) loadAd:(NSInteger)placementId withSuccess:(gotad)gotad orFailure:(failure)failure;

@end
