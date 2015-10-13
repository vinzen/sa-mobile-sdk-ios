//
//  SACreativeFormat.h
//  Pods
//
//  Created by Gabriel Coman on 13/10/2015.
//
//

#import <Foundation/Foundation.h>

// define the format of the Creative
typedef NS_ENUM(NSUInteger, SACreativeFormat) {
    format_unknown = -1,
    image_with_link = 0,
    video = 1,
    rich_media = 2,
    rich_media_resizing = 3,
    swf = 4,
    tag = 5
};
