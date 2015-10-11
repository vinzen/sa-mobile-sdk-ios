//
//  SAAdHTMLParser.h
//  Pods
//
//  Created by Gabriel Coman on 09/10/2015.
//
//

#import <Foundation/Foundation.h>
#import "SANetwork+Ad.h"

@class SAAd;

@interface SAAdHTMLParser : NSObject

// only function here
+ (NSString*) parseHTMLForAd:(SAAd*)ad withExtectedSize:(CGSize)screenSize;

@end
