//
//  SuperAwesome2.h
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import <Foundation/Foundation.h>

// import model header files
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"
#import "SAEvent.h"

// import views
#import "SABannerAd.h"
#import "SAInterstitialAd.h"
#import "SAVideoAd.h"
#import "SAFullscreenVideoAd.h"
#import "SAAdLoader.h"

// import protocols
#import "SAAdViewProtocol.h"
#import "SAAdPreloadProtocol.h"

// typedef client configuration
typedef NS_ENUM(NSUInteger, SAConfiguration) {
    SAConfigurationDevelopment,
    SAConfigurationStaging,
    SAConfigurationProduction
};

// interface declaration
@interface SuperAwesome : NSObject

// singleton instance (instead of init)
+ (SuperAwesome *)sharedManager;

// other functions
- (NSString*) version;

// set configuration
- (void) setConfigurationProduction;
- (void) setConfigurationStaging;
- (void) setConfigurationDevelopment;
- (NSString*) getBaseURL;

// test mode
- (void) enableTestMode;
- (void) disableTestMode;
- (BOOL) isTestingEnabled;

@end
