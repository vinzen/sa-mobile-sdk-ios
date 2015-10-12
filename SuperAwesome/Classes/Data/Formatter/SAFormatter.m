//
//  SAFormatter.m
//  Pods
//
//  Created by Gabriel Coman on 12/10/2015.
//
//

#import "SAFormatter.h"
#import "SACreative.h"
#import "SADetails.h"

@implementation SAFormatter

+ (NSString*) formatCreativeDataIntoAdHTML:(SACreative*)creative {
    
    NSString *htmlString = @"";
    
    switch (creative.format) {
        case image_with_link:{
            NSString *imageURL = creative.details.image;
            NSString *fPath = [[NSBundle mainBundle] pathForResource:@"displayImage" ofType:@"html"];
            htmlString = [NSString stringWithContentsOfFile:fPath encoding:NSUTF8StringEncoding error:nil];
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"imageURL" withString:imageURL];
            break;
        }
        case video:{
            NSString *videoURL = creative.details.video;
            NSString *fPath = [[NSBundle mainBundle] pathForResource:@"displayVideo" ofType:@"html"];
            htmlString = [NSString stringWithContentsOfFile:fPath encoding:NSUTF8StringEncoding error:nil];
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"videoURL" withString:videoURL];
            break;
        }
        case rich_media:{
            NSString *richMediaURL = creative.details.url;
            NSString *fPath = [[NSBundle mainBundle] pathForResource:@"displayRichMedia" ofType:@"html"];
            htmlString = [NSString stringWithContentsOfFile:fPath encoding:NSUTF8StringEncoding error:nil];
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"richMediaURL" withString:richMediaURL];
            break;
        }
        case rich_media_resizing:{
            break;
        }
        case swf:{
            break;
        }
        case tag:{
            break;
        }
        default:
            break;
    }
    
    return htmlString;
}

@end
