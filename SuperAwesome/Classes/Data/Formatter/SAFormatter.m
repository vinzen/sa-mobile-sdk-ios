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
            return nil;
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
            return nil;
            break;
        }
    }
}

+ (NSString*) formatCreativeIntoImageHTML:(SACreative*)creative {
    NSString *fPath = [[NSBundle mainBundle] pathForResource:@"displayImage" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:fPath encoding:NSUTF8StringEncoding error:nil];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"imageURL" withString:creative.details.image];
    return htmlString;
}

+ (NSString*) formatCreativeIntoRichMediaHTML:(SACreative*)creative {
    NSString *fPath = [[NSBundle mainBundle] pathForResource:@"displayRichMedia" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:fPath encoding:NSUTF8StringEncoding error:nil];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"richMediaURL" withString:creative.details.url];
    return htmlString;
}

+ (NSString*) formatCreativeIntoTagHTML:(SACreative*)creative {
    NSString *fPath = [[NSBundle mainBundle] pathForResource:@"displayTag" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:fPath encoding:NSUTF8StringEncoding error:nil];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"tagdata" withString:creative.details.tag];
    return htmlString;
}

@end
