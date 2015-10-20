//
//  Utils.h
//  Pods
//
//  Created by Gabriel Coman on 20/10/2015.
//
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (CGRect) arrangeAdInNewFrame:(CGRect)frame fromFrame:(CGRect)oldframe;
+ (NSInteger)randomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max;

@end
