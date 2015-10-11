//
//  SuperAwesome2.m
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

// import header
#import "SuperAwesome.h"

// load some more (private) headers
#import "SKLogger.h"
#import "SANetwork.h"
#import "SANetwork+Ad.h"

// define
#define BASE_URL_STAGING @"https://staging.beta.ads.superawesome.tv/v2"
#define BASE_URL_DEVELOPMENT @"https://dev.ads.superawesome.tv/v2"
#define BASE_URL_PRODUCTION @"https://ads.superawesome.tv/v2"

@interface SuperAwesome ()

// private vars
@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, assign) BOOL isTestEnabled;
@property (nonatomic, assign) SAConfiguration configuration;

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
        [self setConfiguration:SAConfigurationProduction];
        [self disableTestMode];
    }
    
    return self;
}

- (NSString*) version {
    return @"3.0";
}

- (void) setLogging:(SourceKitLogLevel)loglevel {
    [SKLogger setLogLevel:loglevel];
}

- (void) setConfiguration:(SAConfiguration)configuration {
    switch (configuration) {
        case SAConfigurationProduction:{
            _baseURL = BASE_URL_PRODUCTION;
            [self setLogging:SourceKitLogLevelWarning];
            break;
        }
        case SAConfigurationDevelopment:{
            _baseURL = BASE_URL_DEVELOPMENT;
            [self setLogging:SourceKitLogLevelDebug];
            break;
        }
        case SAConfigurationStaging:{
            _baseURL = BASE_URL_STAGING;
            [self setLogging:SourceKitLogLevelDebug];
            break;
        }
        default:
            break;
    }
}

- (void) setConfigurationProduction {
    [self setConfiguration:SAConfigurationProduction];
}

- (void) setConfigurationStaging {
    [self setConfiguration:SAConfigurationStaging];
}

- (void) setConfigurationDevelopment {
    [self setConfiguration:SAConfigurationDevelopment];
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
