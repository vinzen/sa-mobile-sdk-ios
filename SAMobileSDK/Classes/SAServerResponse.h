//
//  SAServerResponse.h
//  SAMobileSDK
//
//  Created by Balázs Kiss on 21/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "JSONModel.h"
#import "SAAdPlacement.h"

@interface SAServerResponse : JSONModel

@property (nonatomic,assign) BOOL success;
@property (nonatomic,strong) NSNumber<Optional> *errorCode;
@property (nonatomic,strong) NSString<Optional> *errorMessage;
@property (nonatomic,strong) NSArray<Optional, SAAdPlacement> *ads;

@end
