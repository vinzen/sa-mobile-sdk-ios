//
//  ATVASTNonLinear.h
//  ADTECHMobileSDK
//
//  Created by ADTECH AG on 4/20/12.
//  Copyright (c) 2012 ADTECH AG. All rights reserved.
//

#import "ATVASTCompanionAndNonLinearBase.h"
#import "ATVASTEnums.h"

@interface ATVASTNonLinear : ATVASTCompanionAndNonLinearBase

@property (nonatomic, copy) NSURL *nonLinearClickThrough;
@property (nonatomic, assign) ATVASTTriState scalable;
@property (nonatomic, assign) ATVASTTriState maintainAspectRatio;
@property (nonatomic, assign) NSTimeInterval minSuggestedDuration;

@end
