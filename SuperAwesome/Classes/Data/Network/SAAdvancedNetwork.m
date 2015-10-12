//
//  SAAdvancedNetwork.m
//  Pods
//
//  Created by Gabriel Coman on 11/10/2015.
//
//

#import "SAAdvancedNetwork.h"

// get main header file for SA
#import "SuperAwesome.h"

// get other header files
#import "SAAd.h"
#import "SAEvent.h"

@implementation SAAdvancedNetwork

// implementation of the GET functions
+ (void) getAdWith:(NSInteger)placementId withSuccess:(gotad)gotad orFailure:(failure)failure {
    // form the main URL
    NSString *endpoint = [NSString stringWithFormat:@"/ad/%ld", placementId];
    BOOL isTest = [[SuperAwesome sharedManager] isTestingEnabled];
    NSDictionary *dict = @{@"test": [NSNumber numberWithBool:isTest]};
    
    [self sendGETtoEndpoint:endpoint withQueryDict:dict andSuccess:^(NSData *data) {
        
        // transfrom from raw data to dictionary
        NSError *jsonError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        
        // some error occured, probably the JSON string was badly formatted
        if (jsonError) {
            failure();
        }
        else {
            // format the ad JSON as a SuperAwesome model and return
            SAAd *ad = [[SAAd alloc] initWithPlacementId:placementId andWithDictionary:json];
            
            // if some other type of error appears
            if (ad.error > 0) {
                failure();
            }
            else {
                gotad(ad);
            }
        }
        
    } orFailure:^{
        failure();
    }];
}

+ (void) getAdAuxData:(NSString *)url withsuccess:(gothtml)gothtml orFailure:(failure)failure {
    [self sendGETtoEndpoint:url withQueryDict:@{} andSuccess:^(NSData *data) {
        NSString *rawhtml = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        gothtml(rawhtml);
    } orFailure:^{
        failure();
    }];
}

// implementation of the POST functions
+ (void) postEvent:(SAEvent *)event withSuccess:(postevent)postevent orFailure:(failure)failure {
    [self sendPOSTtoEndpoint:@"/event" withBodyDict:[event dictionaryFromModel] andSuccess:^(NSData *data) {
        postevent();
    } orFailure:^{
        failure();
    }];
}

+ (void) postClick:(SAEvent *)event withSuccess:(postclick)postclick orFailure:(failure)failure {
    
    [self sendPOSTtoEndpoint:@"/click" withBodyDict:[event dictionaryFromModel] andSuccess:^(NSData *data) {
        postclick();
    } orFailure:^{
        failure();
    }];
}

@end
