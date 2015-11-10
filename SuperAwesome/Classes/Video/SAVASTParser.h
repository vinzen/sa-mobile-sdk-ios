//
//  SAVASTParser.h
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 28/10/2015.
//
//

#import <Foundation/Foundation.h>

// include the SAVASTProtocol
#import "SAVASTProtocol.h"

//
// @brief: This is a wrapper around NSXMLParser
// It's goal is to parse a standard VAST Tag and find the ClickThrough tag's
// value, which is the correct clickURL in case of video ads
@interface SAVASTParser : NSObject

// delegate
@property id<SAVASTProtocol> delegate;

// static function that performs the VAST Tag parsing
- (void) findCorrectVASTClick:(NSString*)vastURL;

@end