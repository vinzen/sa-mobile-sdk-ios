//
//  ATVASTInLine.h
//  ADTECHMobileSDK
//
//  Created by ADTECH AG on 4/19/12.
//  Copyright (c) 2012 ADTECH AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATVASTInLineAndWrapperBase.h"

@interface ATVASTInLine : ATVASTInLineAndWrapperBase

@property (nonatomic, copy) NSString *adTitle;
@property (nonatomic, copy) NSString *inLineDescription;
@property (nonatomic, copy) NSURL *survey;

@end
