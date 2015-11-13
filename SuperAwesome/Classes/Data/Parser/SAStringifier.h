//
//  SAEnumToString.h
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 12/10/2015.
//
//

#import <Foundation/Foundation.h>
#import "SAEventType.h"

// @brief:
// Wrapper class for a couple of very ObjC / C specific functions that
// magically transform Enum values to strings for comparison
// @param:
// - some kind of Enum type
// @return:
// - NSString
@interface SAStringifier: NSObject

// class function that transforms a SAEventType enum value to string
+ (NSString*) eventTypeFromValue:(SAEventType) evt;

@end

