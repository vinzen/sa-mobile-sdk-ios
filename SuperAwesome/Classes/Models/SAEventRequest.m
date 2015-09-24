//
//  SAEventRequest.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 20/01/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "SAEventRequest.h"
#import "SAAdResponse.h"
#import "SAAdCreative.h"

@implementation SAEventRequest

- (instancetype)initWithAdResponse:(SAAdResponse *)adResponse
{
    if(self = [super init]){
        _placementID = adResponse.placementID;
        _creativeID = adResponse.creative.creativeID;
        _lineItemID = adResponse.lineItemID;
        _type = NoAd;
        _detailValue = -1;
        
    }
    return self;
}

- (id) init {
    if (self = [super init]) {
        _placementID = nil;
        _creativeID = nil;
        _lineItemID = nil;
        _type = NoAd;
        _detailValue = -1;
    }
    
    return self;
}

@end
