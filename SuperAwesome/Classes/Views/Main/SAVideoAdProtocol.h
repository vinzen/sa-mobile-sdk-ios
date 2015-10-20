//
//  SAVideoAdProtocol.h
//  Pods
//
//  Created by Gabriel Coman on 20/10/2015.
//
//

#import <UIKit/UIKit.h>

@protocol SAVideoAdProtocol <NSObject>

@optional
- (void) videoStarted:(NSInteger)placementId;
- (void) videoEnded:(NSInteger)placementId;
- (void) videoReachedFirstQuartile:(NSInteger)placementId;
- (void) videoReachedMidpoint:(NSInteger)placementId;
- (void) videoReachedThirdQuartile:(NSInteger)placementId;

@end
