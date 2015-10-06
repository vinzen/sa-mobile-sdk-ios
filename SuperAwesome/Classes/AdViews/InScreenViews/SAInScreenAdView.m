//
//  SAScreenView.m
//  Pods
//
//  Created by Gabriel Coman on 06/10/2015.
//
//

#import "SAInScreenAdView.h"
#import "SKMRAIDView.h"
#import "SAImageDetials.h"

@interface SAInScreenAdView () <SKMRAIDViewDelegate>
@end

@implementation SAInScreenAdView

- (id) init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"-init is not a valid initializer for the class SAScreenView"
                                 userInfo:nil];
    return nil;
}

- (id) initWithFrame:(CGRect)frame {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"-initWithFrame is not a valid initializer for the class SAScreenView"
                                 userInfo:nil];
    return nil;
}

- (id) initWithFrame:(CGRect)frame andPlacementId:(NSInteger)placementId {
    if (self = [super initWithFrame:frame]) {
        super.placementId = placementId;
    }
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        // do nothing
    }
    
    return self;
}

- (void) didMoveToWindow {
    [super didMoveToWindow];
    
    if (super.playInstantly) {
        [self play];
    }
}

#pragma mark MKRAID View delegate

- (void) mraidViewAdReady:(SKMRAIDView *)mraidView {
    NSLog(@"AD READY");
    
    if (super.delegate && [super.delegate respondsToSelector:@selector(adWasShown:)]) {
        [super.delegate adWasShown:super.placementId];
    }
}

- (void) mraidViewAdFailed:(SKMRAIDView *)mraidView {
    NSLog(@"AD FAILED");
    
    if (super.delegate && [super.delegate respondsToSelector:@selector(adFailedToShow:)]) {
        [super.delegate adFailedToShow:super.placementId];
    }
}

- (void) mraidViewNavigate:(SKMRAIDView *)mraidView withURL:(NSURL *)url {
    NSLog(@"AD NAVIGATE");
}


@end
