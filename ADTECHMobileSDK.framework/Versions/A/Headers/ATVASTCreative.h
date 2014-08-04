//
//  ATVASTCreative.h
//  ADTECHMobileSDK
//
//  Created by ADTECH AG on 4/19/12.
//  Copyright (c) 2012 ADTECH AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ATVASTLinear;
@class ATVASTNonLinearAds;

@interface ATVASTCreative : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) NSInteger sequence;
@property (nonatomic, copy) NSString *adID;

@property (nonatomic, strong) ATVASTLinear *linear;
@property (nonatomic, readonly) NSMutableArray *companionAds;
@property (nonatomic, strong) ATVASTNonLinearAds *nonLinearAds;

@end
