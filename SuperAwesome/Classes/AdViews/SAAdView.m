//
//  SAAdView.m
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import "SAAdView.h"

// import other headers
#import "SANetwork+Ad.h"

// import some models I would need
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"
#import "SAEventManager.h"
#import "SAAdLoader.h"

// import parental gate
#import "SAParentalGate.h"
#import "SAPadlockView.h"
#import "WeakRefClass.h"

@interface SAAdView () <SAParentalGateProtocol>
@end

@implementation SAAdView

// custom init functions
- (id) init {
    if (self = [super init]) {
        // init defaults
        _placementId = 0;
        _isParentalGateEnabled = true;
        _refreshPeriod = 5;
        _playInstantly = false;
    }
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]){
        // init defaults
        _placementId = 0;
        _isParentalGateEnabled = true;
        _refreshPeriod = 5;
        _playInstantly = false;
    }
    
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // init defaults
        _placementId = 0;
        _isParentalGateEnabled = true;
        _refreshPeriod = 5;
        _playInstantly = false;
    }
    
    return self;
}

- (void) dealloc {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

- (void) assignAd:(SAAd *)_ad {
    ad = _ad;
}

- (void) play {
    // do nothing here
}

- (void) playInstant {
    [[SAAdLoader sharedManager] loadAd:_placementId withSuccess:^(SAAd *_ad) {
        ad = _ad;
        [self play];
    } orFailure:^{
        // failure case
    }];
}

#pragma mark Aux create functions

//- (void) createTimer{
//    _currentRefresh = 0;
//    
//    if (_ad.creative.details.duration > 0) {
//        _refreshPeriod = _ad.creative.details.duration;
//    }
//    
//    if (_timer) {
//        [_timer invalidate];
//        _timer = nil;
//    }
//    
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[WeakRefClass getWeakReferenceOf:self] selector:@selector(timerFunc) userInfo:nil repeats:YES];
//}

//- (void) timerFunc {
//    // to be implemented in children
//}

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

#pragma mark On Click actions - ad and padlock

- (void) onAdClick {
    // perform delegate
    
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
        [[SAEventManager sharedInstance] LogClick:ad];
        
        // open URL
        NSURL *url = [NSURL URLWithString:ad.creative.clickURL];
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void) onPadlockClick {
    if (!pad) {
        pad = [[SAPadlockView alloc] initWithAd:ad];
    }
    
    // show this
    [[[[UIApplication sharedApplication] delegate] window] addSubview:pad];
}


#pragma mark SAParentalGate2 protocol

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


@end
