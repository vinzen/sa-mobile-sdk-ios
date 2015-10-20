//
//  Utils.m
//  Pods
//
//  Created by Gabriel Coman on 20/10/2015.
//
//

#import "Utils.h"

@implementation Utils

+ (CGRect) arrangeAdInNewFrame:(CGRect)frame fromFrame:(CGRect)oldframe {
    
    CGFloat newW = frame.size.width;
    CGFloat newH = frame.size.height;
    CGFloat oldW = oldframe.size.width;
    CGFloat oldH = oldframe.size.height;
    if (oldW == 1 || oldW == 0) { oldW = newW; }
    if (oldH == 1 || oldH == 0) { oldH = newH; }
    
    CGFloat oldR = oldW / oldH;
    CGFloat newR = newW / newH;
    
    CGFloat X = 0, Y = 0, W = 0, H = 0;
    
    if (oldR > newR) {
        W = newW;
        H = W / oldR;
        X = 0;
        Y = (newH - H) / 2.0f;
    }
    else {
        H = newH;
        W = H * oldR;
        Y = 0;
        X = (newW - W) / 2.0f;
    }
    
    return CGRectMake(X, Y, W, H);
}

+ (NSInteger)randomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max {
    return min + arc4random_uniform((uint32_t)(max - min + 1));
}

@end
