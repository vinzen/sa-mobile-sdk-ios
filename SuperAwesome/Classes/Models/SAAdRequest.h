//
//  SAAdRequest.h
//  SAMobileSDK
//
//  Created by Balázs Kiss on 20/01/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "JSONModel.h"

@interface SAAdRequest : JSONModel

@property (nonatomic,strong) NSString *placementID;

- (instancetype)initWithPlacementId:(NSString *)placementID;

@end
