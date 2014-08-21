//
//  SuperAwesome.h
//  SAMobileSDK
//
//  Created by Balázs Kiss on 29/07/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ADTECHMobileSDK/ADTECHMobileSDK.h>
#import "SAAdPlacement.h"

@interface SuperAwesome : NSObject

@property (nonatomic,strong) NSString *appID;
@property (nonatomic,strong) NSArray *placements;

- (SAAdPlacement *)placementForSize:(CGSize)size;

+ (id)sharedManager;

@end
