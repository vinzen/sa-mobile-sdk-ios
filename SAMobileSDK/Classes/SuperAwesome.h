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

//Advertising Classes
#import "SABannerView.h"
#import "SAInterstitialView.h"

//Loyalty Classes
#import "SALoginViewController.h"

/**
 *  SuperAwesome Mobile SDK Main Class
 */
@interface SuperAwesome : NSObject

/**
 *  Application ID
 *
 * You can find your appID or create a new one on the SuperAwesome dashboard website.
 */
@property (nonatomic,strong) NSString *appID;
/**
 *  Ad placements
 */
@property (nonatomic,strong) NSArray *placements;
/**
 *  Flag that shows configuration loading
 */
@property (nonatomic,assign,readonly,getter = isLoadingConfiguration) BOOL loadingConfiguration;

/**
 *  Returns ad placement instance for given placement size
 *
 *  @param size Ad placement size
 *
 *  @return SAAdPlacement instance
 */
- (SAAdPlacement *)placementForSize:(CGSize)size;

/**
 *  Returns singleton instance
 *
 *  @return singleton instance
 */
+ (id)sharedManager;

@end
