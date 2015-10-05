//
//  SAVideoDetails.h
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import "SADetails.h"

@interface SAVideoDetails : SADetails

// member variables
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *video;
@property (nonatomic, assign) NSInteger bitrate;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) NSString *vast;

// custom init from NSDictionary
- (id) initWithDictionary:(NSDictionary*)dict;

@end
