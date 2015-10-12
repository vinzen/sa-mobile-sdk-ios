//
//  SALoader.h
//  Pods
//
//  Created by Gabriel Coman on 11/10/2015.
//
//

#import <Foundation/Foundation.h>
#import "SABaseNetwork.h"
#import "SALoaderProtocol.h"

// predef classes
@class SAAd;

// callback for a success method with AD response
typedef void (^gotad)(SAAd *ad);

@interface SALoader : NSObject

// the delegate for the SALoader protocol
@property id<SALoaderProtocol> delegate;

// singleton instance (instead of init)
+ (SALoader *)sharedManager;

// preload function
- (void) preloadAdForPlacementId:(NSInteger)placementId;

@end
