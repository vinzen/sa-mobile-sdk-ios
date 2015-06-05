//
//  SuperAwesome.h
//  SAMobileSDK
//
//  Created by Balázs Kiss on 29/07/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdLoader.h"
#import "SADisplayAd.h"
#import "SAVideoAd.h"

//Advertising Classes
#import "SABannerView.h"
#import "SAInterstitialView.h"
#import "SAVideoAdView.h"
#import "SAVideoAdViewController.h"

typedef NS_ENUM(NSUInteger, SAClientConfiguration) {
    SAClientConfigurationDevelopment,
    SAClientConfigurationStaging,
    SAClientConfigurationProduction
};

/**
 *  SuperAwesome Mobile SDK Main Class
 */
@interface SuperAwesome : NSObject

/**
 *  SDK client configuration
 */
@property (nonatomic,assign) SAClientConfiguration clientConfiguration;

@property (nonatomic,strong) AdLoader *adLoader;

- (NSString *)version;

/**
 *  Returns singleton instance
 *
 *  @return singleton instance
 */
+ (id)sharedManager;

@end
