//
//  AdLoader.m
//  Pods
//
//  Created by Balázs Kiss on 13/04/15.
//
//

#import "AdLoader.h"

@interface AdLoader ()

@end

@implementation AdLoader


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
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error != nil){
            [SKLogger error:@"AdLoader" withMessage:[NSString stringWithFormat:@"Request failed (%@)", error.localizedDescription]];
            completion(nil, error);
            return;
        }
        
        NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", dataStr);
        
        SAAdResponse *resp = [[SAAdResponse alloc] initWithData:data error:&error];
        
        if(error != nil){
            [SKLogger error:@"AdLoader" withMessage:[NSString stringWithFormat:@"Request failed (%@)", error.localizedDescription]];
            completion(nil, error);
            return;
        }
        
        if(resp.error){
            [SKLogger error:@"AdLoader" withMessage:[NSString stringWithFormat:@"Ad server error"]];
            completion(resp, [NSError errorWithDomain:@"SuperAwesome" code:1000 userInfo:@{}]);
            return;
        }
        
        completion(resp, nil);
    }];
    
    [postDataTask resume];
}


@end
