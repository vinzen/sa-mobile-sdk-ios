//
//  SASerializer.h
//  Pods
//
//  Created by Gabriel Coman on 11/10/2015.
//
//

#import <UIKit/UIKit.h>

@class SAAd;

@interface SASerializer : NSObject

+ (NSDictionary*) serializeAdEssentials:(SAAd*)ad;

@end
