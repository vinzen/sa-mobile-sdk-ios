//
//  SAValueDetails.h
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import "SADetails.h"

@interface SAValueDetails : SADetails

// member variables
@property (nonatomic, assign) NSInteger value;

// custom init
- (id) initWithDictionary:(NSDictionary *)dict;

@end
