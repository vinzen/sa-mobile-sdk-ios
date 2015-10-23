//
//  SAEventType.h
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 15/10/2015.
//
//

#import <Foundation/Foundation.h>

// @brief:
// Enums for different event types sent to the server
typedef NS_ENUM(NSUInteger, SAEventType) {
    NoAd = -1,
    viewable_impression = 0,
    AdFailedToView = 1,
    AdRate,
    AdPGCancel,
    AdPGSuccess,
    AdPGError
};
