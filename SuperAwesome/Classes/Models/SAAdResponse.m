//
//  SAAdResponse.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 20/01/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "SAAdResponse.h"

@implementation SAAdResponse

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"error": @"error",
                                                       @"error_message":@"errorMessage",
                                                       @"placement_id":@"placementID",
                                                       @"line_item_id": @"lineItemID",
                                                       @"creative": @"creative",
                                                       @"campaign_id": @"campaignID",
                                                       @"fallback":@"is_fallback"
                                                       }];
}

+ (BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
