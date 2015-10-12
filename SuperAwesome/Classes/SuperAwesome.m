//
//  SuperAwesome2.m
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

// import header
#import "SuperAwesome.h"

// define
#define BASE_URL_STAGING @"https://staging.beta.ads.superawesome.tv/v2"
#define BASE_URL_DEVELOPMENT @"https://dev.ads.superawesome.tv/v2"
#define BASE_URL_PRODUCTION @"https://ads.superawesome.tv/v2"

@interface SuperAwesome ()

// private vars
@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, assign) BOOL isTestEnabled;

@end

@implementation SuperAwesome

+ (SuperAwesome *)sharedManager {
    static SuperAwesome *sharedManager = nil;
    @synchronized(self) {
        if (sharedManager == nil){
            sharedManager = [[self alloc] init];
        }
    }
    return sharedManager;
}

- (instancetype) init {
    if (self = [super init]) {
        // do nothing
        [self setConfigurationProduction];
        [self disableTestMode];
    }
    
    return self;
}

- (NSString*) version {
    return @"3.0";
}

- (void) setConfigurationProduction {
    _baseURL = BASE_URL_PRODUCTION;
}

- (void) setConfigurationStaging {
    _baseURL = BASE_URL_DEVELOPMENT;
}

- (void) setConfigurationDevelopment {
    _baseURL = BASE_URL_STAGING;
}

- (NSString*) getBaseURL {
    return _baseURL;
}

- (void) enableTestMode {
    _isTestEnabled = true;
}

- (void) disableTestMode {
    _isTestEnabled = false;
}

- (BOOL) isTestingEnabled {
    return _isTestEnabled;
}


@end
