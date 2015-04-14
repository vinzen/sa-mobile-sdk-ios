//
//  SAAdRequest.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 20/01/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "SAAdRequest.h"

@implementation SAAdRequest

- (instancetype)initWithPlacementId:(NSString *)placementID
{
    if(self = [super init]){
        self.placementID = placementID;
    }
    return self;
}

@end
