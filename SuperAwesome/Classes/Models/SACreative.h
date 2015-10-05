//
//  SACreative.h
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import <Foundation/Foundation.h>

// forward declarations
@class SADetails;

// define the format of the Creative
typedef NS_ENUM(NSUInteger, SACreativeFormat) {
    image_with_link = 0,
    video = 1
};

// define the Creative class
@interface SACreative : NSObject

// member variables
@property (nonatomic, assign) NSInteger creativeId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) SACreativeFormat format;
@property (nonatomic, strong) NSString *clickURL;
@property (nonatomic, strong) SADetails *details;

// init with dictionary
- (id) initWithDictionary:(NSDictionary*)dict;

@end
