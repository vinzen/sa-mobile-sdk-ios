//
//  SALoader.h
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 11/10/2015.
//
//

#import <Foundation/Foundation.h>
#import "SANetwork.h"
#import "SALoaderProtocol.h"

// predef classes
@class SAAd;

// callback for a success method with AD response
typedef void (^gotad)(SAAd *ad);

// @brief:
// This is a Singleton loader class that acts as Master loading class
// It's main purpose if to be called either by the SDK user or by SAAd
// to perform loading and preloading of ads
//
// It can preload ads using the SALoaderProtocol and - (void) preloadAdForPlacementId:
//
// The direct ad loading functions are hidden from the user
//
@interface SALoader : NSObject

// the delegate for the SALoader protocol
@property id<SALoaderProtocol> delegate;

// singleton instance (instead of init)
+ (SALoader *)getInstance;

// preload ad function;
// does not return anything directly, but via the SALoaderProtocol delegate
- (void) preloadAdForPlacementId:(NSInteger)placementId;

- (void) loadAdForPlacementId:(NSInteger)placementId withAd:(gotad)gotad orFailure:(failure)failure;

@end
