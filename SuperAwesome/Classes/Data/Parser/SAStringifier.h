//
//  SAEnumToString.h
//  Pods
//
//  Created by Gabriel Coman on 12/10/2015.
//
//

#import <Foundation/Foundation.h>
#import "SACreativeFormat.h"
#import "SAPlacementFormat.h"
#import "SAEventType.h"

@interface SAStringifier: NSObject

+ (NSString*) creativeFormatToString:(SACreativeFormat) format;
+ (NSString*) placementFormatToString:(SAPlacementFormat) format;
+ (NSString*) eventTypeFromValue:(SAEventType) evt;

@end

