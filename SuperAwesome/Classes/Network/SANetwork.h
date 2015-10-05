//
//  SANetwork.h
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import <UIKit/UIKit.h>

// typedef some resonse callback
typedef void (^netresponse)(NSURLResponse * response, NSData * data, NSError * error);
typedef void (^success)(NSData *data);
typedef void (^failure)();

// implementation
@interface SANetwork : NSObject

// POST
+ (void) sendPOSTtoEndpoint:(NSString*)endpoint
               withBodyDict:(NSDictionary*)POSTDict
                 andSuccess:(success)success
                  orFailure:(failure)failure;

// GET
+ (void) sendGETtoEndpoint:(NSString*)endpoint
             withQueryDict:(NSDictionary*)GETDict
                andSuccess:(success)success
                 orFailure:(failure)failure;

@end
