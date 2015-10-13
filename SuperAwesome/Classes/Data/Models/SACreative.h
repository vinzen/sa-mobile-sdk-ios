//
//  SACreative.h
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import <Foundation/Foundation.h>
#import "SACreativeFormat.h"

// forward declarations
@class SADetails;

// define the Creative class
@interface SACreative : NSObject

// member variables
@property (nonatomic, assign) NSInteger creativeId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger cpm;
@property (nonatomic, assign) SACreativeFormat format;
@property (nonatomic, strong) NSString *impressionURL;
@property (nonatomic, strong) NSString *clickURL;
@property (nonatomic, strong) SADetails *details;
@property (nonatomic, assign) BOOL approved;

@end
