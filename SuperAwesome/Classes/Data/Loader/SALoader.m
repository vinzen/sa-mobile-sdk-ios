//
//  SALoader.m
//  Pods
//
//  Created by Gabriel Coman on 11/10/2015.
//
//

// import header
#import "SALoader.h"

// import other headers
#import "SAParser.h"
#import "SAValidator.h"
#import "SAFormatter.h"

// import model headers
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"

// import SA main Singleton
#import "SuperAwesome.h"

@interface SALoader ()
- (void) loadAdForPlacementId:(NSInteger)placementId withAd:(gotad)gotad orFailure:(failure)failure;
@end

@implementation SALoader

+ (SALoader *)sharedManager {
    static SALoader *sharedManager = nil;
    @synchronized(self) {
        if (sharedManager == nil){
            sharedManager = [[self alloc] init];
        }
    }
    return sharedManager;
}

- (void) preloadAdForPlacementId:(NSInteger)placementId {
    [self loadAdForPlacementId:placementId withAd:^(SAAd *ad) {
        [_delegate didPreloadAd:ad forPlacementId:placementId];
    } orFailure:^{
        [_delegate didFailToPreloadAdForPlacementId:placementId];
    }];
}

- (void) loadAdForPlacementId:(NSInteger)placementId withAd:(gotad)gotad orFailure:(failure)failure {
    
    // form URL
    NSString *endpoint = [NSString stringWithFormat:@"%@/ad/%ld", [[SuperAwesome sharedManager] getBaseURL], placementId];
    BOOL isTest = [[SuperAwesome sharedManager] isTestingEnabled];
    NSDictionary *dict = @{@"test": [NSNumber numberWithBool:isTest]};
    
    ////////////////////////////////////////////////////////////
    // 1. First GET request to get an Ad
    [SANetwork sendGETtoEndpoint:endpoint withQueryDict:dict andSuccess:^(NSData *data) {
        
        // transfrom from raw data to dictionary
        NSError *jsonError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        
        // some error occured, probably the JSON string was badly formatted
        if (jsonError) {
            failure();
        }
        else {
            // form the Ad
            SAAd *ad = [SAParser parseAdWithDictionary:json];
            ad.placementId = placementId;
            ad.creative = [SAParser parseCreativeWithDictionary:json];
            if (ad.creative) {
                ad.creative.details = [SAParser parseDetailsWithDictionary:json];
            }
            
            ////////////////////////////////////////////////////////////
            // 2. verifiy ad data and send it forward
            if ([SAValidator isAdDataValid:ad]) {
                ad.adHTML = [SAFormatter formatCreativeDataIntoAdHTML:ad.creative];
                gotad(ad);
            }
            // utter failure case
            else {
                failure();
            }
        }
        
    } orFailure:^{
        failure();
    }];
}

@end
