//
//  SAAdResponse.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 20/01/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "SAAdResponse.h"
#import "SAAdCreative.h"

@implementation SAAdResponse

- (id) initWithPlacementId:(NSString *)placementID andLineItemId:(NSString *)lineIItemID andCreativId:(NSString *)creativeId {
    
    if (self = [super init]) {
        self.placementID = placementID;
        self.lineItemID = lineIItemID;
        self.creative = [[SAAdCreative alloc] init];
        self.creative.creativeID = creativeId;
    }
    
    return self;
}

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
