//
//  SALoaderProtocol.h
//  Pods
//
//  Created by Gabriel Coman on 11/10/2015.
//
//

#import <Foundation/Foundation.h>

@class SAAd;

@protocol SALoaderProtocol <NSObject>

// main protocol functions
@optional
- (void) didPreloadAd:(SAAd*)ad forPlacementId:(NSInteger)placementId;
- (void) didFailToPreloadAdForPlacementId:(NSInteger)placementId;

@end
