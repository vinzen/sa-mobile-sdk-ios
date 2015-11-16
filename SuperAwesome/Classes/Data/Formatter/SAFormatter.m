//
//  SAFormatter.m
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 12/10/2015.
//
//

#import "SAFormatter.h"
#import "SACreative.h"
#import "SADetails.h"
#import "NSString+Addition.h"

@implementation SAFormatter

+ (NSString*) formatCreativeDataIntoAdHTML:(SACreative*)creative {
    
    switch (creative.format) {
        case image:{
            return [self formatCreativeIntoImageHTML:creative];
            break;
        }
        case video:{
            return [self formatCreativeIntoVideoHTML:creative];
            break;
        }
        case rich:{
            return [self formatCreativeIntoRichMediaHTML:creative];
            break;
        }
        case tag:{
            return [self formatCreativeIntoTagHTML:creative];
            break;
        }
        default:{
            return [self formatCreativeIntoImageHTML:creative];
            break;
        }
    }
}

+ (NSString*) formatCreativeIntoImageHTML:(SACreative*)creative {
    NSString *imageURL = creative.details.image;
    NSString *fPath = [[NSBundle mainBundle] pathForResource:@"displayImage" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:fPath encoding:NSUTF8StringEncoding error:nil];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"imageURL" withString:imageURL];
    return htmlString;
}

+ (NSString*) formatCreativeIntoVideoHTML:(SACreative*)creative {
    // not implemented anymore
    return @"";
}

+ (NSString*) formatCreativeIntoRichMediaHTML:(SACreative*)creative {
    NSString *richMediaURL = creative.details.url;
    NSString *fPath = [[NSBundle mainBundle] pathForResource:@"displayRichMedia" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:fPath encoding:NSUTF8StringEncoding error:nil];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"richMediaURL" withString:richMediaURL];
    return htmlString;
}

+ (NSString*) formatCreativeIntoTagHTML:(SACreative*)creative {
    NSString *javascriptData = creative.details.tag;
    NSString *urlFromJS = [javascriptData stringBetweenString:@"src=\"" andString:@"\""];
    NSString *fPath = [[NSBundle mainBundle] pathForResource:@"displayRichMedia" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:fPath encoding:NSUTF8StringEncoding error:nil];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"richMediaURL" withString:urlFromJS];
    return htmlString;
}

@end
