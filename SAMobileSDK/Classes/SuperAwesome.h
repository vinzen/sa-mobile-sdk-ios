//
//  SuperAwesome.h
//  SAMobileSDK
//
//  Created by Balázs Kiss on 29/07/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ADTECHMobileSDK/ADTECHMobileSDK.h>
#import "SADisplayAd.h"
#import "SAVideoAd.h"

//Advertising Classes
#import "SABannerView.h"
#import "SAInterstitialView.h"
#import "SAVideoAdView.h"

//Loyalty Classes
#import "SALoginViewController.h"

typedef NS_ENUM(NSUInteger, SAClientConfiguration) {
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

/**
 *  Sets if the SDK should display a parantal gate when the ad is tapped
 */
@property (nonatomic,assign) BOOL useParentalGate;


- (void)displayAdForApp:(NSString *)appID placement:(NSString *)placementID completion:(void(^)(SADisplayAd *))completion;
- (void)videoAdForApp:(NSString *)appID placement:(NSString *)placementID completion:(void(^)(SAVideoAd *))completion;

/**
 *  Returns singleton instance
 *
 *  @return singleton instance
 */
+ (id)sharedManager;

@end
