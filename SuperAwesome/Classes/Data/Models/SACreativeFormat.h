//
//  SACreativeFormat.h
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 13/10/2015.
//
//

#import <Foundation/Foundation.h>

// @brief:
// An enum that defines the number of formats an ad can be in
//  - format_unknown: defined by the SDK in case of some error
//  - image_with_link: the creative is a simple banner image
//  - video: the creative is a video that must be streamed
//  - rich_media: a mini-HTML page with user interaction
//  - rich_media_resizing: a mini-HTML page that will expand out of bounds
//  - swf: deprecated
//  - tag: a rich-media served as a JS file
typedef NS_ENUM(NSUInteger, SACreativeFormat) {
    format_unknown = -1,
    image_with_link = 0,
    video = 1,
    rich_media = 2,
    rich_media_resizing = 3,
    swf = 4,
    tag = 5
};
