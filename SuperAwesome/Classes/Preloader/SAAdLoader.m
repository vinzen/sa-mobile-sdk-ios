//
//  AdLoader.m
//  Pods
//
//  Created by Gabriel Coman on 09/10/2015.
//
//

// import header
#import "SAAdLoader.h"

// import other models
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"
#import "SAAdHTMLParser.h"

@implementation SAAdLoader

+ (SAAdLoader *)sharedManager {
    static SAAdLoader *sharedManager = nil;
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
        if (_delegate && [_delegate respondsToSelector:@selector(didPreloadAd:forPlacementId:)]) {
            [_delegate didPreloadAd:ad forPlacementId:placementId];
        }
    } orFailure:^{
        // also call failure delegate
        if (_delegate && [_delegate respondsToSelector:@selector(didFailToPreloadAdForPlacementId:)]) {
            [_delegate didFailToPreloadAdForPlacementId:placementId];
        }
    }];
}

- (void) loadAd:(NSInteger)placementId withSuccess:(gotad)gotad orFailure:(failure)failure {
    
    [SANetwork getAdWith:placementId withSuccess:^(SAAd *ad) {
        // assign ad
        SAAd *_ad = ad;
        
        // first check if the ad data is complete in all ways necesssary
        if ([_ad isAdDataComplete] == true) {
            
            // load additional HTML data
            switch (ad.creative.format) {
                case image_with_link: {
                    _ad.adHTML = [NSString stringWithFormat:@"%@", _ad.creative.details.image];
                    gotad(_ad);
                    break;
                }
                case video: {
                    _ad.adHTML = [NSString stringWithFormat:@"%@", _ad.creative.details.video];
                    gotad(_ad);
                    break;
                }
                case rich_media:{
                    [SANetwork getAdHTMLWith:_ad.creative.details.url withsuccess:^(NSString *string) {
                        _ad.adHTML = string;
                        gotad(_ad);
                    } orFailure:^{
                        failure();
                    }];
                    break;
                }
                case rich_media_resizing: {
                    // do nothing
                    break;
                }
                case tag: {
                    // do nothing
                    break;
                }
                case swf:{
                    break;
                }
                default:
                    break;
            }
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
