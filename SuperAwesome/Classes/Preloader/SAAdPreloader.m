//
//  AdLoader.m
//  Pods
//
//  Created by Gabriel Coman on 09/10/2015.
//
//

// import header
#import "SAAdPreloader.h"

// import other models
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"

@implementation SAAdPreloader

+ (SAAdPreloader *)sharedManager {
    static SAAdPreloader *sharedManager = nil;
    @synchronized(self) {
        if (sharedManager == nil){
            sharedManager = [[self alloc] init];
        }
    }
    return sharedManager;
}

- (instancetype) init {
    if (self = [super init]) {
        // do init stuff
    }
    
    return self;
}

- (void) preloadAd:(NSInteger)placementId {
    [self loadAd:placementId withSuccess:^(SAAd *ad) {
        // in this case call the delegate
        if (_delegate && [_delegate respondsToSelector:@selector(didPreloadAd:)]) {
            [_delegate didPreloadAd:ad];
        }
    } orFailure:^{
        // also call failure delegate
        if (_delegate && [_delegate respondsToSelector:@selector(didFailToPreloadAd:)]) {
            [_delegate didFailToPreloadAd:placementId];
        }
    }];
}

- (void) loadAd:(NSInteger)placementId withSuccess:(gotad)gotad orFailure:(failure)failure {
    
    [SANetwork getAdWith:placementId withSuccess:^(SAAd *ad) {
        // assign ad
        SAAd *_ad = ad;
        
        // first check if the ad data is complete in all ways necesssary
        if ([_ad isAdDataComplete] == true) {
            gotad(_ad);
            
        }
        // if not, it's better to call failure
        else {
            failure();
        }
    } orFailure:^{
        failure();
    }];
}

@end
