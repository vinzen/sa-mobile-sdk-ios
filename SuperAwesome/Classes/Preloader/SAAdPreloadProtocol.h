//
//  SAAdPreloaderProtocol.h
//  Pods
//
//  Created by Gabriel Coman on 09/10/2015.
//
//

#import <Foundation/Foundation.h>

// forward declarations
@class SAAd;

@protocol SAAdPreloadProtocol <NSObject>

// main protocol functions
@optional
- (void) didPreloadAd:(SAAd*)ad forPlacementId:(NSInteger)placementId;
- (void) didFailToPreloadAdForPlacementId:(NSInteger)placementId;

@end