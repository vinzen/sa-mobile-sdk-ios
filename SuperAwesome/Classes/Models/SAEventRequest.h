//
//  SAEventRequest.h
//  SAMobileSDK
//
//  Created by Balázs Kiss on 20/01/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "JSONModel.h"

@interface SAEventRequest : JSONModel

@property (nonatomic,strong) NSString *placementID;
@property (nonatomic,strong) NSString *lineItemID;
@property (nonatomic,strong) NSString *type;

- (NSDictionary *)dictionaryValue;
- (NSString *)JSONValue;

@end
