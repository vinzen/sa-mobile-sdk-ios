//
//  SAAdResponse.h
//  SAMobileSDK
//
//  Created by Balázs Kiss on 20/01/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "JSONModel.h"

@interface SAAdResponse : JSONModel

@property (nonatomic,strong) NSNumber *error;
@property (nonatomic,strong) NSString *errorMessage;
@property (nonatomic,strong) NSString *placementID;
@property (nonatomic,strong) NSString *lineItemID;
@property (nonatomic,strong) NSString *campaignID;
@property (nonatomic,strong) NSDictionary *creative;


- (NSString *)toHTML;

@end
