//
//  AdLoader.h
//  Pods
//
//  Created by Balázs Kiss on 13/04/15.
//
//

#import <Foundation/Foundation.h>
#import "SAAdRequest.h"
#import "SAEventRequest.h"
#import "SAEventResponse.h"
#import "SAAdResponse.h"

@interface SAAdManager : NSObject

@property (nonatomic,strong) NSString *baseURL;
@property (nonatomic,assign,getter=isTestModeEnabled) BOOL testModeEnabled;

- (void)loadAd:(SAAdRequest *)adRequest completion:(void(^)(SAAdResponse *response, NSError *error))completion;
- (void)sendEvent:(SAEventRequest *)event completion:(void(^)(SAEventResponse *response, NSError *error))completion;

@end
