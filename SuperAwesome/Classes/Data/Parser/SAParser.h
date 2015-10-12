//
//  SAParser.h
//  Pods
//
//  Created by Gabriel Coman on 11/10/2015.
//
//

#import <Foundation/Foundation.h>

// forward declarations
@class SAAd;
@class SACreative;
@class SADetails;

@interface SAParser : NSObject

// function that parses the SAAd main data, excepting the creative
+ (SAAd*) parseAdWithDictionary:(NSDictionary*)dict;

// function that parses the SACreative main data, excepting the details
+ (SACreative*) parseCreativeWithDictionary:(NSDictionary*)maindict;

// function that parses the SADetails main data
+ (SADetails*) parseDetailsWithDictionary:(NSDictionary*)maindict;

@end
