//
//  SAPreroll.h
//  SAMobileSDK
//
//  Created by Balázs Kiss on 25/09/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "JSONModel.h"

@protocol SAPreroll
@end

@interface SAPreroll : JSONModel

@property (nonatomic,strong) NSNumber *id;
@property (nonatomic,strong) NSString *vast;

@end
