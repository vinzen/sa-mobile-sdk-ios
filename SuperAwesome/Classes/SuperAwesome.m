//
//  SuperAwesome.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 29/07/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SuperAwesome.h"
#import "SAServerResponse.h"
#import "SAAppConfig.h"

@interface SuperAwesome ()

- (NSString *)baseURL;

@end

@implementation SuperAwesome

+ (id)sharedManager
{
    static SuperAwesome *sharedManager = nil;
    @synchronized(self) {
        if (sharedManager == nil){
            sharedManager = [[self alloc] init];
            NSLog(@"%@", [sharedManager version]);
        }
    }
    return sharedManager;
}

- (instancetype)init
{
    if(self = [super init]){
        _adLoader = [[AdLoader alloc] init];
        [self setClientConfiguration:SAClientConfigurationStaging];
        
    }
    return self;
}

- (NSString *)version
{
    return @"SuperAwesome iOS SDK version 2.0.0";
}

- (NSString *)baseURL
{
    if(self.clientConfiguration == SAClientConfigurationProduction){
        return @"http://ads.superawesome.tv/ads/";
    }else{
        return @"http://staging.dashboard.superawesome.tv/api/sdk/ads";
    }
}

@end
