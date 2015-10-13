//
//  SANetwork.h
//  Pods
//
//  Created by Gabriel Coman on 11/10/2015.
//
//

#import <Foundation/Foundation.h>

// callback for iOS's own [NSURLConnection sendAsynchronousRequest:]
typedef void (^netresponse)(NSURLResponse * response, NSData * data, NSError * error);

// callback for generic success with data
typedef void (^success)(NSData *data);

// callback for generic failure with no data
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
