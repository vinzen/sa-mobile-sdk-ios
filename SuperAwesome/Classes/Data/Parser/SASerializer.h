//
//  SASerializer.h
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 11/10/2015.
//
//

#import <UIKit/UIKit.h>

@class SAAd;

// @brief:
// Wrapper class for class functions that transform AA models into NSDictionaries
// @params:
// - some kind of AA model
// @return:
// - NSDictionary
@interface SASerializer : NSObject

// classs function that serializes an Ads esential informaiton
// - creativeId
// - placementId
// - lineItemId
+ (NSDictionary*) serializeAdEssentials:(SAAd*)ad;

@end
