//
//  SAEventType.h
//  Pods
//
//  Created by Gabriel Coman on 15/10/2015.
//
//

#import <Foundation/Foundation.h>

// specific events for the ads
typedef NS_ENUM(NSUInteger, SAEventType) {
    NoAd = -1,
    viewable_impression = 0,
    AdFailedToView = 1,
    AdRate,
    AdPGCancel,
    AdPGSuccess,
    AdPGError
};
