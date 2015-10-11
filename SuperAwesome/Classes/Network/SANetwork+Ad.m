//
//  SANetwork+Ad.m
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

// get own extension header file
#import "SANetwork+Ad.h"

// get main header file for SA
#import "SuperAwesome.h"

// get other header files
#import "SAAd.h"
#import "SAEvent.h"

@implementation SANetwork (Ad)

+ (void) getAdWith:(NSInteger)placementId withSuccess:(gotad)gotad orFailure:(failure)failure {
    // form the main URL
    NSString *endpoint = [NSString stringWithFormat:@"/ad/%ld", placementId];
    BOOL isTest = [[SuperAwesome sharedManager] isTestingEnabled];
    NSDictionary *dict = @{@"test": [NSNumber numberWithBool:isTest]};
    
    [SANetwork sendGETtoEndpoint:endpoint withQueryDict:dict andSuccess:^(NSData *data) {
        
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

+ (void) postEvent:(SAEvent *)event withSuccess:(postevent)postevent orFailure:(failure)failure {
    [SANetwork sendPOSTtoEndpoint:@"/event" withBodyDict:[event dictionaryFromModel] andSuccess:^(NSData *data) {
        postevent();
    } orFailure:^{
        failure();
    }];
}

+ (void) postClick:(SAEvent *)event withSuccess:(postclick)postclick orFailure:(failure)failure {
    
    [SANetwork sendPOSTtoEndpoint:@"/click" withBodyDict:[event dictionaryFromModel] andSuccess:^(NSData *data) {
        postclick();
    } orFailure:^{
        failure();
    }];
}

+ (void) getAdHTMLWith:(NSString *)url withsuccess:(gothtml)gothtml orFailure:(failure)failure {
    [SANetwork sendGETtoEndpoint:url withQueryDict:@{} andSuccess:^(NSData *data) {
        NSString *rawhtml = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        gothtml(rawhtml);
    } orFailure:^{
        failure();
    }];
}

@end
