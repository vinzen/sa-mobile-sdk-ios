//
//  SANetManager.h
//  Pods
//
//  Created by Gabriel Coman on 23/09/2015.
//
//

#import <Foundation/Foundation.h>

// typedef some resonse callback
typedef void (^netresponse)(NSURLResponse * response, NSData * data, NSError * error);
typedef void (^success)(NSData *data);
typedef void (^failure)();

@interface SANetManager : NSObject

// Generic functions to GET & POST
+ (void) sendPOSTtoEndpoint:(NSString*)endpoint withBodyDict:(NSDictionary*)POSTDict andSuccess:(success)success orFailure:(failure)failure;
+ (void) sendGETtoEndpoint:(NSString*)endpoint withQueryDict:(NSDictionary*)GETDict andSuccess:(success)success orFailure:(failure)failure;

@end
