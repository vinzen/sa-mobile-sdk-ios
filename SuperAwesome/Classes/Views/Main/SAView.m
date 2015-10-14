//
//  SAView.m
//  Pods
//
//  Created by Gabriel Coman on 12/10/2015.
//
//

#import "SAView.h"

// import model
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"

// import loade
#import "SALoader.h"
#import "SASender.h"

// import subview
#import "SAParentalGate.h"
#import "SAPadlockView.h"

@interface SALoader ()
- (void) loadAdForPlacementId:(NSInteger)placementId withAd:(gotad)gotad orFailure:(failure)failure;
@end

@interface SAView () <SAParentalGateProtocol>
@end

@implementation SAView

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _playInstantly = true;
        _isParentalGateEnabled = YES;
    }
    
    return self;
}

#pragma mark Playing and displaying

- (void) setAd:(SAAd *)_ad {
    ad = _ad;
}

- (void) playInstant {
    [[SALoader sharedManager] loadAdForPlacementId:_placementId withAd:^(SAAd *_ad) {
        ad = _ad;
        [self display];
    } orFailure:^{
        // call to delegate (probably)
    }];
}

- (void) playPreloaded {
    if (ad) {
        [self display];
    }
}

- (void) display {
    // do nothing here
}

- (CGRect) arrangeAdInFrame:(CGRect)frame {
    
    CGFloat SW = frame.size.width;
    CGFloat SH = frame.size.height;
    CGFloat AW = (CGFloat)ad.creative.details.width;
    CGFloat AH = (CGFloat)ad.creative.details.height;
    if (AW == 1 || AW == 0) { AW = SW; }
    if (AH == 1 || AH == 0) { AH = SH; }
    
    CGFloat dW = MIN((CGFloat)SW/AW, 1);
    CGFloat dH = MIN((CGFloat)SH/AH, 1);
    CGFloat dT = MIN(dW, dH);
    
    CGFloat nW = AW * dT;
    CGFloat nH = AH * dT;
    CGFloat nX = (SW - nW) / 2.0f;
    CGFloat nY = (SH - nH) / 2.0f;
    
    return CGRectMake(nX, nY, nW, nH);
}

#pragma mark Normal click

- (void) clickOnAd {
    // follow URL
    if (self.isParentalGateEnabled) {
        if(gate == nil){
            gate = [[SAParentalGate alloc] initWithAd:ad];
            gate.delegate = self;
        }
        [gate show];
    }
    else {
        // call delegate
        if (_delegate && [_delegate respondsToSelector:@selector(adFollowedURL:)]){
            [_delegate adFollowedURL:_placementId];
        }
        
        // log
        [SASender postEventClick:ad];
        
        // open URL
        NSURL *url = [NSURL URLWithString:ad.creative.clickURL];
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark Parental Gate

- (void) parentalGateWasCanceled {
    if (_delegate && [_delegate respondsToSelector:@selector(parentalGateWasCanceled:)]) {
        [_delegate parentalGateWasCanceled:ad.placementId];
    }
}

- (void) parentalGateWasFailed {
    if (_delegate && [_delegate respondsToSelector:@selector(parentalGateWasFailed:)]) {
        [_delegate parentalGateWasFailed:ad.placementId];
    }
}

- (void) parentalGateWasSucceded {
    if (_delegate && [_delegate respondsToSelector:@selector(parentalGateWasSucceded:)]) {
        [_delegate parentalGateWasSucceded:ad.placementId];
    }
    
    // open URL
    NSURL *url = [NSURL URLWithString:ad.creative.clickURL];
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark Padlock

- (void) createPadlockButtonWithParent:(UIView *)parent{
    
    // don't go any further is ad is fallback
    if (ad.isFallback) {
        return;
    }
    
    // 2.
    // add the padlock button
    CGRect main_frame = parent.frame;
    CGSize padlock_size = CGSizeMake(15, 15);
    CGRect padlock_frame = CGRectMake(main_frame.size.width - padlock_size.width,
                                      main_frame.size.height - padlock_size.height,
                                      padlock_size.width,
                                      padlock_size.height);
    
    padlockBtn = [[UIButton alloc] initWithFrame:padlock_frame];
    [padlockBtn setImage:[UIImage imageNamed:@"sa_padlock"] forState:UIControlStateNormal];
    [padlockBtn addTarget:self action:@selector(onPadlockClick) forControlEvents:UIControlEventTouchUpInside];
    [parent addSubview:padlockBtn];
    [parent bringSubviewToFront:padlockBtn];
}

- (void) removePadlockButtonFromParent {
    [padlockBtn removeFromSuperview];
}

- (void) onPadlockClick {
    if (!pad) {
        pad = [[SAPadlockView alloc] initWithAd:ad];
    }
    
    // show this
    [[[[UIApplication sharedApplication] delegate] window] addSubview:pad];
}

@end
