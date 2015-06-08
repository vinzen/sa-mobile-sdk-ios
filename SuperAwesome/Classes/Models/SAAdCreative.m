//
//  SAAdCreative.m
//  Pods
//
//  Created by Balázs Kiss on 08/06/2015.
//
//

#import "SAAdCreative.h"
#import "SKLogger.h"

@implementation SAAdCreative

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"creativeID",
                                                       @"format":@"format",
                                                       @"click_url":@"clickURL",
                                                       @"details": @"details"
                                                       }];
}


- (NSString *)toHTML
{
    if([self.format isEqualToString:@"image_with_link"]){
        NSString *img = [self.details objectForKey:@"image"];
        NSString *url = self.clickURL;
        return [NSString stringWithFormat:@"<div><a href=\"%@\"><img src=\"%@\"></a></div>", url, img];
    }
    
    [SKLogger error:@"SAAdCreative" withMessage:@"Cannot convert format to HTML"];
    return @"";
}

@end
