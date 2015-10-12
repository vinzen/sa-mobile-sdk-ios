//
//  SAFormatter.h
//  Pods
//
//  Created by Gabriel Coman on 12/10/2015.
//
//

#import <Foundation/Foundation.h>

// forward declaration
@class SACreative;

@interface SAFormatter : NSObject

// formats HTML text based on ad type
+ (NSString*) formatCreativeDataIntoAdHTML:(SACreative*)creative;

@end
