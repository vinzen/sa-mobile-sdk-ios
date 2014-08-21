//
//  SuperAwesome.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 29/07/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SuperAwesome.h"
#import "SAServerResponse.h"

@interface SuperAwesome ()

- (void)loadSettings;

@end

@implementation SuperAwesome

+ (id)sharedManager
{
    static SuperAwesome *sharedManager = nil;
    @synchronized(self) {
        if (sharedManager == nil)
            sharedManager = [[self alloc] init];
    }
    return sharedManager;
}

- (instancetype)init
{
    if(self = [super init]){
        [ATBaseConfiguration setLoggingLevel:kATLogOff];
    }
    return self;
}

- (void)setAppID:(NSString *)appID
{
    _appID = appID;
    [self loadSettings];
}

- (void)loadSettings
{
    NSError *error;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:@"http://dashboard-staging.superawesome.tv/api/sdk/ads"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    NSDictionary *mapData = [[NSDictionary alloc] initWithObjectsAndKeys: self.appID, @"app_id", nil];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        SAServerResponse *resp = [[SAServerResponse alloc] initWithData:data error:&error];
        if(resp.success){
            self.placements = resp.ads;
        }
    }];
    
    [postDataTask resume];
}

- (SAAdPlacement *)placementForSize:(CGSize)size
{
    for (SAAdPlacement *placement in self.placements) {
        if([placement.width floatValue] == size.width && [placement.height floatValue] == size.height){
            return placement;
        }
    }
    return nil;
}

@end
