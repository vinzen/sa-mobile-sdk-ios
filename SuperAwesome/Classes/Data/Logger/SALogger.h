//
//  SALogger.h
//  SA.Data.Logger
//
//  Created by Gabriel Coman on 11/10/2015.
//

#import <Foundation/Foundation.h>

// the SALogger interface
@interface SALogger : NSObject

// different error logs
+ (void) LogNetworkErrorToURL:(NSString*)url andStatusCode:(NSInteger)statusCode;
+ (void) LogNetworkSuccessToURL:(NSString*)url andResponse:(NSString*)response;

@end
