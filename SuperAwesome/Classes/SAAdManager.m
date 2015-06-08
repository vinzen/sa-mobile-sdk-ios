//
//  AdLoader.m
//  Pods
//
//  Created by Balázs Kiss on 13/04/15.
//
//

#import "SAAdManager.h"
#import "SKLogger.h"

@interface SAAdManager ()

@end

@implementation SAAdManager


- (void)loadAd:(SAAdRequest *)adRequest completion:(void(^)(SAAdResponse *response, NSError *error))completion
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSString *urlString = [NSString stringWithFormat:@"%@/ad/%@", self.baseURL, adRequest.placementID];
    NSURL *url = [NSURL URLWithString:urlString];
    [SKLogger debug:@"" withMessage:[NSString stringWithFormat:@"New request to %@", urlString]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [SKLogger debug:@"SAAdManager" withMessage:urlString];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error != nil){
            [SKLogger error:@"SAAdManager" withMessage:[NSString stringWithFormat:@"Request failed (%@)", error.localizedDescription]];
            completion(nil, error);
            return;
        }
        
        NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", dataStr);
        
        SAAdResponse *resp = [[SAAdResponse alloc] initWithData:data error:&error];
        
        if(error != nil){
            [SKLogger error:@"SAAdManager" withMessage:[NSString stringWithFormat:@"Request failed (%@)", error.localizedDescription]];
            completion(nil, error);
            return;
        }
        
        if(resp.error){
            [SKLogger error:@"SAAdManager" withMessage:[NSString stringWithFormat:@"Ad server error"]];
            completion(resp, [NSError errorWithDomain:@"SuperAwesome" code:1000 userInfo:@{}]);
            return;
        }
        
        completion(resp, nil);
    }];
    
    [postDataTask resume];
}

- (void)sendEvent:(SAEventRequest *)event completion:(void(^)(SAEventResponse *response, NSError *error))completion
{
    //TODO: send event to ad server
}


@end
