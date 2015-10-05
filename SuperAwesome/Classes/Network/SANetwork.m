//
//  SANetwork.m
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

// import own header
#import "SANetwork.h"

// import other headers
#import "SuperAwesome.h"

@implementation SANetwork

// private functions
// Generic functions to GET & POST
+ (void) sendPOSTtoEndpoint:(NSString*)endpoint
               withBodyDict:(NSDictionary*)POSTDict
                 andSuccess:(success)success
                  orFailure:(failure)failure{
    
    // prepare the data
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:POSTDict options:0 error:nil];
    __block NSString *postString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSData *postData = [postString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    // prepare the URL
    __block NSString *_surl = [NSString stringWithFormat:@"%@/%@", [[SuperAwesome sharedManager] getBaseURL], endpoint];
    NSURL *url = [NSURL URLWithString:_surl];
    
    // create the request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // form the response block to the POST
    netresponse resp = ^(NSURLResponse * response, NSData * data, NSError * error) {
        
        if (error != nil) {
            [SKLogger error:@"SANetManager: " withMessage:[NSString stringWithFormat:@"Request failed (%@)", error.localizedDescription]];
            failure();
        }
        else {
            // only if status code is 200
            if (((NSHTTPURLResponse*)response).statusCode == 200) {
                NSString *strData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                [SKLogger error:@"[OK] SANetManager: " withMessage:[NSString stringWithFormat:@"POST to %@ with %@ and response %@", _surl, postString, strData]];
                success(data);
            }
            // else call it failure
            else {
                [SKLogger error:@"SANetManager: " withMessage:[NSString stringWithFormat:@"Request failed (%ld)", (long)((NSHTTPURLResponse*)response).statusCode]];
                failure();
            }
        }
    };
    
    // make the request and get back the data
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:resp];
    
}

+ (void) sendGETtoEndpoint:(NSString*)endpoint
             withQueryDict:(NSDictionary*)GETDict
                andSuccess:(success)success
                 orFailure:(failure)failure {
    
    // prepare the URL
    __block NSMutableString *_surl = [[NSMutableString alloc] init];
    [_surl appendString:[[SuperAwesome sharedManager] getBaseURL]];
    [_surl appendFormat:@"/%@", endpoint];
    [_surl appendString:(GETDict.allKeys.count > 0 ? @"?" : @"")];
    
    NSMutableArray *getParams = [[NSMutableArray alloc] init];
    for (NSString *key in GETDict.allKeys) {
        [getParams addObject:[NSString stringWithFormat:@"%@=%@", key, [GETDict objectForKey:key]]];
    }
    [_surl appendString:[getParams componentsJoinedByString:@"&"]];
    
    NSURL *url = [NSURL URLWithString:_surl];
    
    // create the request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    
    // form the response block to the POST
    netresponse resp = ^(NSURLResponse * response, NSData * data, NSError * error) {
        
        if (error != nil) {
            [SKLogger error:@"SANetManager: " withMessage:[NSString stringWithFormat:@"Request failed (%@)", error.localizedDescription]];
            failure();
        }
        else {
            // only if status code is 200
            if (((NSHTTPURLResponse*)response).statusCode == 200) {
                NSString *strData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                [SKLogger error:@"[OK] SANetManager: " withMessage:[NSString stringWithFormat:@"GET to %@ and response %@", _surl, strData]];
                success(data);
            }
            // else call it failure
            else {
                [SKLogger error:@"SANetManager: " withMessage:[NSString stringWithFormat:@"Request failed (%ld)", (long)((NSHTTPURLResponse*)response).statusCode]];
                failure();
            }
        }
    };
    
    // make the request and get back the data
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:resp];
    
}

@end
