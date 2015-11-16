//
//  SALoader.m
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
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
#import "SAVASTParser.h"

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

// Singleton implementation
+ (SALoader *)getInstance {
    static SALoader *sharedManager = nil;
    @synchronized(self) {
        if (sharedManager == nil){
            sharedManager = [[self alloc] init];
        }
    }
    return sharedManager;
}

// implementation of the main class' function
// depends heavily on loadAdForPlacementId, which is a private method
- (void) preloadAdForPlacementId:(NSInteger)placementId {
    [self loadAdForPlacementId:placementId withAd:^(SAAd *ad) {
        [_delegate didPreloadAd:ad forPlacementId:placementId];
    } orFailure:^{
        [_delegate didFailToPreloadAdForPlacementId:placementId];
    }];
}

- (void) loadAdForPlacementId:(NSInteger)placementId withAd:(gotad)gotad orFailure:(failure)failure {
    
    // First thing to do is format the AA URL to get an ad, based on specs
    NSString *endpoint = [NSString stringWithFormat:@"%@/ad/%ld", [[SuperAwesome getInstance] getBaseURL], (long)placementId];
    BOOL isTest = [[SuperAwesome getInstance] isTestingEnabled];
    NSDictionary *dict = @{@"test": [NSNumber numberWithBool:isTest]};
    
    // The second operation to perform is calling a SANetwork class function
    // to get Ad data, returned as NSData
    [SANetwork sendGETtoEndpoint:endpoint withQueryDict:dict andSuccess:^(NSData *data) {
        
        // We're assuming the NSData is actually a JSON in string format,
        // so the next step is to parse it
        NSError *jsonError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        
        // some error occured, probably the JSON string was badly formatted
        if (jsonError) {
            failure();
        }
        // if there is no specific JSON Error, we can move forward to try to
        // create the Ad as it's needed by AA
        else {
            // we invoke SAParser class functions to parse different aspects
            // of the Ad
            SAAd *ad = [SAParser parseAdWithDictionary:json];
            ad.placementId = placementId;
            ad.creative = [SAParser parseCreativeWithDictionary:json];
            if (ad.creative) {
                ad.creative.details = [SAParser parseDetailsWithDictionary:json];
            }
            
            ad = [SAParser finishAdParsing:ad];
            ad.adHTML = [SAFormatter formatCreativeDataIntoAdHTML:ad.creative];
            
            //
            if (ad.creative.format == video){
                SAVASTParser *parser = [[SAVASTParser alloc] init];
                [parser findCorrectVASTClickFor:ad.creative.details.vast withResult:^(NSString *clickURL) {
                    ad.creative.clickURL = clickURL;
                    
                    if ([SAValidator isAdDataValid:ad]) {
                        gotad(ad);
                    } else {
                        failure();
                    }
                }];
            } else {
                if ([SAValidator isAdDataValid:ad]) {
                    gotad(ad);
                } else {
                    failure();
                }
            }
        }
        
    } orFailure:^{
        failure();
    }];
}

@end
