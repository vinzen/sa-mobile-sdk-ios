//
//  SAVideoAd.h
//  Pods
//
//  Created by Gabriel Coman on 20/10/2015.
//
//

#import "SAView.h"
#import "SAVideoAdProtocol.h"

@interface SAVideoAd : SAView {
    
}

// video delegate
@property id<SAVideoAdProtocol> videoDelegate;

// custom init
- (id) initWithPlacementId:(NSInteger)placementId andFrame:(CGRect)frame;

@end
