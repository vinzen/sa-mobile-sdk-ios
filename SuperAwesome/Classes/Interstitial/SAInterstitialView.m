//
//  SAInterstitialView.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 12/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SAInterstitialView.h"

@interface SAInterstitialView ()

@property (nonatomic,strong) UIViewController *viewController;
@property (nonatomic,strong) SKMRAIDInterstitial *interstitialView;
@property (nonatomic,strong) SAParentalGate *gate;
@property (nonatomic,strong) NSURL *adURL;

@end

@implementation SAInterstitialView

- (instancetype)initWithViewController:(UIViewController *)viewController
{
    if(self = [super init]){
        self.viewController = viewController;
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
}

- (void)setPlacementID:(NSString *)placementID
{
    [super setPlacementID:placementID];
    
//    [[[SuperAwesome sharedManager] adLoader] loadAd:[[SAAdRequest alloc] initWithPlacementId:placementID] completion:^(SAAdResponse *response, NSError *error) {
//        if(error != nil){
//            NSLog(@"Could not load ad");
//            return ;
//        }
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.interstitialView = [[SKMRAIDInterstitial alloc] initWithSupportedFeatures:@[] withHtmlData:[response toHTML] withBaseURL:[NSURL URLWithString:@"http://superawesome.tv"] delegate:self serviceDelegate:nil rootViewController:self.viewController];
//            [self.interstitialView setBackgroundColor:self.backgroundColor];
//        });
//        
//    }];
}

- (void)present
{
    [self.interstitialView show];
}

- (BOOL)isReady
{
    return YES;
}

- (void)load
{
    
}

#pragma mark - SAParentalGateDelegate

- (void)didGetThroughParentalGate:(SAParentalGate *)parentalGate
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(willLeaveApplicationForInterstitialAd:)]){
        [self.delegate willLeaveApplicationForInterstitialAd:self];
    }
    [[UIApplication sharedApplication] openURL:self.adURL];
}

#pragma mark - SKMRAIDInterstitialDelegate

- (void)mraidInterstitialAdReady:(SKMRAIDInterstitial *)mraidInterstitial
{
    NSLog(@"Ad Ready");
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSuccessfullyFetchInterstitialAd:)]){
        [self.delegate didSuccessfullyFetchInterstitialAd:self];
    }
}

- (void)mraidInterstitialAdFailed:(SKMRAIDInterstitial *)mraidInterstitial
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didFailFetchingInterstitialAd:)]){
        [self.delegate didFailFetchingInterstitialAd:self];
    }
}

- (void)mraidInterstitialWillShow:(SKMRAIDInterstitial *)mraidInterstitial
{
    NSLog(@"will show");
}

- (void)mraidInterstitialDidHide:(SKMRAIDInterstitial *)mraidInterstitial
{
    NSLog(@"did hide");
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didHideInterstitialView:)]){
        [self.delegate didHideInterstitialView:self];
    }
}

- (void)mraidInterstitialNavigate:(SKMRAIDInterstitial *)mraidInterstitial withURL:(NSURL *)url
{
    NSLog(@"navigate");
    
    if([self isParentalGateEnabled]){
        if(self.gate == nil){
            self.gate = [[SAParentalGate alloc] init];
            self.gate.delegate = self;
        }
        [self.gate show];
        self.adURL = url;
    }else{
        if(self.delegate && [self.delegate respondsToSelector:@selector(willLeaveApplicationForInterstitialAd:)]){
            [self.delegate willLeaveApplicationForInterstitialAd:self];
        }
        [[UIApplication sharedApplication] openURL:url];
    }
}


@end
