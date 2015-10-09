//
//  AdLoader.h
//  Pods
//
//  Created by Gabriel Coman on 09/10/2015.
//
//

#import <Foundation/Foundation.h>
#import "SANetwork+Ad.h"
#import "SAAdPreloadProtocol.h"

@interface SAAdLoader : NSObject

// delegate
@property id<SAAdPreloadProtocol> delegate;

// singleton instance (instead of init)
+ (SAAdLoader *)sharedManager;

// preload ad function
- (void) preloadAd:(NSInteger)placementId;

// function that gets an ad and uses blocks to signal finishing or failing the job
- (void) loadAd:(NSInteger)placementId withSuccess:(gotad)gotad orFailure:(failure)failure;

@end
