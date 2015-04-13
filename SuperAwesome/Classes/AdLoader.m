//
//  AdLoader.m
//  Pods
//
//  Created by Balázs Kiss on 13/04/15.
//
//

#import "AdLoader.h"

@implementation AdLoader


- (void)loadAd:(NSString *)placementID completion:(void(^)(NSError *error))completion
{
    NSError *error;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSString *urlString = [NSString stringWithFormat:@"%@/ad/%@", self.baseURL, placementID];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"%@", urlString);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", dataStr);
        
        SAServerResponse *resp = [[SAServerResponse alloc] initWithData:data error:&error];
        
        if(resp == nil){
            NSLog(@"SA: Could not load app configuration (%@)", error.localizedDescription);
            completion(error);
        }else{
            if(resp.success){
                NSLog(@"SA: App configuration has been loaded successfully ");
                

                completion(nil);
            }else{
                NSLog(@"SA: Could not load app configuration (%@)", resp.errorMessage);
                completion([NSError errorWithDomain:@"SADashboard" code:[resp.errorCode integerValue] userInfo:@{}]);
            }
        }
    }];
    
    [postDataTask resume];
    
}


@end
