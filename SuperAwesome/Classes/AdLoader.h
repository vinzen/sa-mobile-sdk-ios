//
//  AdLoader.h
//  Pods
//
//  Created by Balázs Kiss on 13/04/15.
//
//

#import <Foundation/Foundation.h>
#import "SAAdRequest.h"
#import "SAAdResponse.h"
#import "SKLogger.h"

@interface AdLoader : NSObject

@property (nonatomic,strong) NSString *baseURL;

- (void)loadAd:(SAAdRequest *)adRequest completion:(void(^)(SAAdResponse *response, NSError *error))completion;

@end
