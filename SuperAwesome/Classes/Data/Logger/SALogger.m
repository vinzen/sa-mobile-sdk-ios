//
//  SALogger.h
//  SA.Data.Logger
//
//  Created by Gabriel Coman on 11/10/2015.
//

#import "SALogger.h"

// defines
#define MSG_OK @"[OK]"
#define MSG_WARN @"[WARNING]"
#define MSG_ERROR @"[ERROR]"

// different errors and associated messages
#define CODE_NETWORK_ERROR 101
#define MSG_NETWORK_ERROR @"A network error occured. "

#define CODE_NETWORK_SUCCESS 100
#define MSG_NETWORK_SUCCESS @"A network operation was successfull. "

@implementation SALogger

+ (void) LogMessageWithType:(NSString*)type andCode:(NSInteger)code andMessage:(NSString*)message {
    NSLog(@"\n------------\nSALogger:\n%@ - %ld\n%@", type, code, message);
}

+ (void) LogNetworkErrorToURL:(NSString*)url andStatusCode:(NSInteger)statusCode {
    NSString *msg = [NSString stringWithFormat:@"%@ %@ - %ld", MSG_NETWORK_ERROR, url, (long)statusCode];
    [SALogger LogMessageWithType:MSG_ERROR andCode:CODE_NETWORK_ERROR andMessage:msg];
}

+ (void) LogNetworkSuccessToURL:(NSString*)url andResponse:(NSString *)response {
    NSString *msg = [NSString stringWithFormat:@"%@ %@\n------------\n%@", MSG_NETWORK_SUCCESS, url, response];
    [SALogger LogMessageWithType:MSG_OK andCode:CODE_NETWORK_SUCCESS andMessage:msg];
}

@end
