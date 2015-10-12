//
//  SADetails.h
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import <Foundation/Foundation.h>

// define the format of the Creative
typedef NS_ENUM(NSUInteger, SAPlacementFormat) {
    web_display = 0,
    floor_display = 1
};

// string function
NSString *SAPlacementFormatToString(SAPlacementFormat format);

@interface SADetails : NSObject

// member variables
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *video;
@property (nonatomic, assign) NSInteger bitrate;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) NSString *vast;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, assign) SAPlacementFormat placementFormat;
@property (nonatomic, strong) NSString *zip;
@property (nonatomic, strong) NSString *url;

// custom init function
- (id) initWithDictionary:(NSDictionary*)dict;

@end
