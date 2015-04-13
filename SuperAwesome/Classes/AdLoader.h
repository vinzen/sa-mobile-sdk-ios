//
//  AdLoader.h
//  Pods
//
//  Created by Balázs Kiss on 13/04/15.
//
//

#import <Foundation/Foundation.h>
#import "SAServerResponse.h"

@interface AdLoader : NSObject

@property (nonatomic,strong) NSString *baseURL;

- (void)loadAd:(NSString *)placementID completion:(void(^)(NSError *error))completion;

@end
