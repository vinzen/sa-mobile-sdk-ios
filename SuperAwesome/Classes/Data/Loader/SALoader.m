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

@implementation SALoader

static id<SALoaderProtocol> delegate;

+ (id<SALoaderProtocol>) delegate {
    @synchronized(self) {
        return delegate;
    }
}
+ (void) setDelegate:(id<SALoaderProtocol>)del {
    @synchronized(self) {
        delegate = del;
    }
}

+ (void) loadAdForPlacementId:(NSInteger)placementId {
    
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
            if (SALoader.delegate != NULL){
                [SALoader.delegate didFailToLoadAdForPlacementId:placementId];
            }
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
                        if (SALoader.delegate != NULL) {
                            [SALoader.delegate didLoadAd:ad];
                        }
                    } else {
                        if (SALoader.delegate != NULL) {
                            [SALoader.delegate didFailToLoadAdForPlacementId:placementId];
                        }
                    }
                }];
            } else {
                if ([SAValidator isAdDataValid:ad]) {
                    if (SALoader.delegate != NULL) {
                        [SALoader.delegate didLoadAd:ad];
                    }
                } else {
                    if (SALoader.delegate != NULL) {
                        [SALoader.delegate didFailToLoadAdForPlacementId:placementId];
                    }
                }
            }
        }
        
    } orFailure:^{
        if (SALoader.delegate != NULL) {
            [SALoader.delegate didFailToLoadAdForPlacementId:placementId];
        }
    }];
}

@end
