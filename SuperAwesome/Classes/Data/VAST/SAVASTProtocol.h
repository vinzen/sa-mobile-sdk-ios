//
//  SAVASTProtocol.h
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 28/10/2015.
//
//

#import <UIKit/UIKit.h>

// @brief:
// A protocol that will help SAVASTParser to send the final clickURL data
// to the consumer class that will finally use it (SAVideoAd, most probably)
@protocol SAVASTProtocol <NSObject>

// when the VAST XML tag has been parsed and a VASTClickURL has been found,
// call this function
- (void) didFindVASTClickURL:(NSString*)clickURL;

@end
