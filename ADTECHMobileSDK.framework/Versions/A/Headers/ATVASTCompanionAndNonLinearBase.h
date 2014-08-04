//
//  ATVASTCompanionAndNonLinearBase.h
//  ADTECHMobileSDK
//
//  Created by ADTECH AG on 4/20/12.
//  Copyright (c) 2012 ADTECH AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ATVASTStaticResource;

@interface ATVASTCompanionAndNonLinearBase : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger expandedWidth;
@property (nonatomic, assign) NSInteger expandedHeight;
@property (nonatomic, copy) NSString *apiFramework;
@property (nonatomic, strong) ATVASTStaticResource *staticResource;
@property (nonatomic, copy) NSURL *iFrameResource;
@property (nonatomic, copy) NSString *HTMLResource;
@property (nonatomic, copy) NSString *adParameters;

@end
