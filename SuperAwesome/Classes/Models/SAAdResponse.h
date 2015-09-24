//
//  SAAdResponse.h
//  SAMobileSDK
//
//  Created by Balázs Kiss on 20/01/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "JSONModel.h"

@class SAAdCreative;

@interface SAAdResponse : JSONModel

@property (nonatomic,strong) NSNumber *error;
@property (nonatomic,strong) NSString *errorMessage;
@property (nonatomic,strong) NSString *placementID;
@property (nonatomic,strong) NSString *lineItemID;
@property (nonatomic,strong) NSString *campaignID;
@property (nonatomic,assign,getter=isFallback,setter=setIsFallback:) BOOL fallback;
@property (nonatomic,strong) SAAdCreative *creative;

- (id) initWithPlacementId:(NSString*)placementID andLineItemId:(NSString*)lineIItemID andCreativId:(NSString*)creativeId;

@end
