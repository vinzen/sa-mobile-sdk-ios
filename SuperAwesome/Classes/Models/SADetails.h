//
//  SADetails.h
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import <Foundation/Foundation.h>

@interface SADetails : NSObject

// member variables
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;

// custom init function
- (id) initWithDictionary:(NSDictionary*)dict;

@end
