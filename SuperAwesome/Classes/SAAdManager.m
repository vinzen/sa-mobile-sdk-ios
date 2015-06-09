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

- (NSURLRequest *)requestWithPath:(NSString *)path data:(NSObject *)data;
- (NSURLSessionDataTask *)sendRequest:(NSURLRequest *)request completionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

@end

@implementation SAAdManager

- (NSURLRequest *)requestWithPath:(NSString *)path data:(NSObject *)data
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", self.baseURL, path];
    NSURL *url = [NSURL URLWithString:urlString];
    [SKLogger debug:@"SAAdManager" withMessage:[NSString stringWithFormat:@"New request to %@", urlString]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    if(data != nil) {
        NSError *error;
        [request setHTTPMethod:@"POST"];
        NSData *postData = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];
        [request setHTTPBody:postData];
    }
    
    return request;
}

- (NSURLSessionDataTask *)sendRequest:(NSURLRequest *)request completionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error != nil){
            [SKLogger error:@"SAAdManager" withMessage:[NSString stringWithFormat:@"Request failed (%@)", error.localizedDescription]];
        }
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [SKLogger debug:@"SAAdManager" withMessage:dataString];
        completionHandler(data, response, error);
    }];
    [postDataTask resume];
    return postDataTask;
}

- (void)loadAd:(SAAdRequest *)adRequest completion:(void(^)(SAAdResponse *response, NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"ad/%@", adRequest.placementID];
    if(self.isTestModeEnabled) path = [path stringByAppendingString:@"?test=true"];
    NSURLRequest *request = [self requestWithPath:path data:nil];
    
    [self sendRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error != nil){
            completion(nil, error);
            return;
        }
        
        SAAdResponse *resp = [[SAAdResponse alloc] initWithData:data error:&error];
        resp.placementID = adRequest.placementID;
        
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
}

- (void)sendEvent:(SAEventRequest *)event completion:(void(^)(SAEventResponse *response, NSError *error))completion
{
    NSString *path = @"event";
    NSDictionary *data = [event dictionaryValue];
    NSURLRequest *request = [self requestWithPath:path data:data];
    
    [self sendRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error != nil){
            completion(nil, error);
            return;
        }
        
        SAEventResponse *resp = [[SAEventResponse alloc] initWithData:data error:&error];
        
        if(error != nil){
            [SKLogger error:@"SAAdManager" withMessage:[NSString stringWithFormat:@"Request failed (%@)", error.localizedDescription]];
            completion(nil, error);
            return;
        }
        
        completion(resp, nil);
    }];
}

@end
