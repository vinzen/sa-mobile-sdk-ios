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
        [self setClientConfiguration:SAClientConfigurationDevelopment];
        
    }
    return self;
}

- (NSString *)version
{
    return @"SuperAwesome iOS SDK version 2.0.0";
}


- (void)setClientConfiguration:(SAClientConfiguration)clientConfiguration
{
    _clientConfiguration = clientConfiguration;
    
    
    if(self.clientConfiguration == SAClientConfigurationProduction){
        self.adLoader.baseURL = @"http://beta.ads.superawesome.tv/v2";
    }else if(self.clientConfiguration == SAClientConfigurationStaging){
        self.adLoader.baseURL = @"http://beta.ads.superawesome.tv/v2";
    }else{
        self.adLoader.baseURL = @"http://dev.ads.superawesome.tv/v2";
    }
}


@end
