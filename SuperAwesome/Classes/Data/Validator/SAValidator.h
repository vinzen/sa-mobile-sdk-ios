//
//  SAValidator.h
//  Pods
//
//  Created by Gabriel Coman on 11/10/2015.
//
//

#import <Foundation/Foundation.h>

@class SAAd;

@interface SAValidator : NSObject

// function that validates an Ad
+ (BOOL) isAdDataValid:(SAAd*)ad;

@end
