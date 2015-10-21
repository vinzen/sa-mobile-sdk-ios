//
//  SACreative.h
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import <Foundation/Foundation.h>
#import "SACreativeFormat.h"

// forward declarations
@class SADetails;

// @brief:
// The creative contains essential ad information like format, click url
// and such
@interface SACreative : NSObject

// the creative ID is a unique ID associated by the server with this Ad
@property (nonatomic, assign) NSInteger creativeId;

// name of the creative - set by the user in the dashboard
@property (nonatomic, strong) NSString *name;

// agreed upon CPM; not really a useful field
@property (nonatomic, assign) NSInteger cpm;

// the creative format defines the type of ad (image, video, rich media, tag, etc)
// and is an enum defined in SACreativeFormat.h
@property (nonatomic, assign) SACreativeFormat format;

// the impression URL; not really useful
@property (nonatomic, strong) NSString *impressionURL;

// the click URL; used by the SDK to point users to the webpage behind the ad
@property (nonatomic, strong) NSString *clickURL;

// must be always true for real ads
@property (nonatomic, assign) BOOL approved;

// pointer to a SADetails object containing even more creative information
@property (nonatomic, strong) SADetails *details;

@end
