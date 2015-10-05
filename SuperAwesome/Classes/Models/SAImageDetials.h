//
//  SAImageDetials.h
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import "SADetails.h"

@interface SAImageDetials : SADetails

// member variables
@property (nonatomic, strong) NSString *image;

// custom init from NSDictionary
- (id) initWithDictionary:(NSDictionary *)dict;

@end
