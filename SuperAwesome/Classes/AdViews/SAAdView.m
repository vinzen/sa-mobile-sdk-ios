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

// import parental gate
#import "SAParentalGate.h"
#import "SAPadlockView.h"

@interface SAAdView () <SAParentalGateProtocol>

// the parental gate
@property (nonatomic, strong) SAParentalGate *gate;
@property (nonatomic, strong) SAPadlockView *pad;

// the button to click in case of click on ad
@property (nonatomic, strong) UIButton *clickBtn;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIButton *padlockBtn;
@property (nonatomic, strong) UIButton *learnMoreBtn;

@end

@implementation SAAdView

// custom init functions
- (id) init {
    if (self = [super init]) {
        // init defaults
        _placementId = 0;
        _isParentalGateEnabled = true;
        _playInstantly = true;
        _refreshPeriod = 30;
    }
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]){
        // init defaults
        _placementId = 0;
        _isParentalGateEnabled = true;
        _playInstantly = true;
        _refreshPeriod = 30;
    }
    
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // init defaults
        _placementId = 0;
        _isParentalGateEnabled = true;
        _playInstantly = true;
        _refreshPeriod = 30;
    }
    
    return self;
}

- (void) play {
    
    // don't implement this here
    [SANetwork getAdWith:_placementId withSuccess:^(SAAd *ad) {
        // assign ad
        _ad = ad;
        
        // call delegate
        if (_delegate && [_delegate respondsToSelector:@selector(adWasLoaded:)]) {
            [_delegate adWasLoaded:_placementId];
        }
        
        // only show if it started instantly
        [self display];
    } orFailure:^{
        // call to delegate
        if (_delegate && [_delegate respondsToSelector:@selector(adFailedToLoad:)]) {
            [_delegate adFailedToLoad:_placementId];
        }
    }];
}

- (void) display {
    // do nothing here
}

#pragma mark Aux create functions

//- (void) createTimerViewWithParent:(UIView *)parent{
//    // no implementation now
//}
//
- (void) createPadlockButtonWithParent:(UIView *)parent{
    // 2.
    // add the padlock button
    CGRect main_frame = parent.frame;
    CGSize padlock_size = CGSizeMake(15, 15);
    CGRect padlock_frame = CGRectMake(main_frame.size.width - padlock_size.width,
                                      main_frame.size.height - padlock_size.height,
                                      padlock_size.width,
                                      padlock_size.height);
    
    _padlockBtn = [[UIButton alloc] initWithFrame:padlock_frame];
    [_padlockBtn setImage:[UIImage imageNamed:@"sa_padlock"] forState:UIControlStateNormal];
    [_padlockBtn addTarget:self action:@selector(onPadlockClick) forControlEvents:UIControlEventTouchUpInside];
    [parent addSubview:_padlockBtn];
    [parent bringSubviewToFront:_padlockBtn];
}
//
//- (void) createLearnMoreButtonWithParent:(UIView *)parent{
//    CGFloat w = parent.frame.size.width;
//    CGFloat offset = (_isFullscreen ? 40 : 0);
//    
//    // step 1. learn more button
//    _learnMoreBtn = [[UIButton alloc] init];
//    [_learnMoreBtn setBackgroundColor:[UIColor clearColor]];
//    [_learnMoreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_learnMoreBtn setTitle:@"Learn more" forState:UIControlStateNormal];
//    [[_learnMoreBtn titleLabel] setFont:[UIFont systemFontOfSize:12]];
//    _learnMoreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    _learnMoreBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
//    [_learnMoreBtn setFrame:CGRectMake(w - 120, offset, 120, 22)];
//    [_learnMoreBtn addTarget:self action:@selector(onAdClick) forControlEvents:UIControlEventTouchUpInside];
//    [parent addSubview:_learnMoreBtn];
//    [parent bringSubviewToFront:_learnMoreBtn];
//}
//
//- (void) createCloseButtonWithParent:(UIView*)parent {
//    CGSize size = CGSizeMake(30, 30);
//    CGRect frame = CGRectMake(parent.frame.size.width - size.width, 0, size.width, size.height);
//    _closeBtn = [[UIButton alloc] initWithFrame:frame];
//    [_closeBtn setTitle:@"" forState:UIControlStateNormal];
//    [_closeBtn setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
//    [_closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
//    [parent addSubview:_closeBtn];
//    [parent bringSubviewToFront:_closeBtn];
//}

#pragma mark On Click actions - ad and padlock

- (void) onAdClick {
    // perform delegate
    
    // follow URL
    if (_isParentalGateEnabled) {
        if(self.gate == nil){
            _gate = [[SAParentalGate alloc] initWithAd:_ad];
            _gate.delegate = self;
        }
        [self.gate show];
    }
    else {
        // call delegate
        if (_delegate && [_delegate respondsToSelector:@selector(adFollowedURL:)]){
            [_delegate adFollowedURL:_placementId];
        }
        
        // open URL
        NSURL *url = [NSURL URLWithString:_ad.creative.clickURL];
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void) onPadlockClick {
    if (!_pad) {
        _pad = [[SAPadlockView alloc] init];
    }
    
    // show this
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_pad];
}


#pragma mark SAParentalGate2 protocol

- (void) parentalGateWasCanceled {
    if (_delegate && [_delegate respondsToSelector:@selector(parentalGateWasCanceled:)]) {
        [_delegate parentalGateWasCanceled:_ad.placementId];
    }
}

- (void) parentalGateWasFailed {
    if (_delegate && [_delegate respondsToSelector:@selector(parentalGateWasFailed:)]) {
        [_delegate parentalGateWasFailed:_ad.placementId];
    }
}

- (void) parentalGateWasSucceded {
    if (_delegate && [_delegate respondsToSelector:@selector(parentalGateWasSucceded:)]) {
        [_delegate parentalGateWasSucceded:_ad.placementId];
    }
    
    // open URL
    NSURL *url = [NSURL URLWithString:_ad.creative.clickURL];
    [[UIApplication sharedApplication] openURL:url];
}


@end
