//
//  SAInterstitialView.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 12/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SAInterstitialView.h"
#import "SKLogger.h"

@interface SAInterstitialView ()

@property (nonatomic,strong) UIViewController *viewController;
@property (nonatomic,strong) SKMRAIDInterstitial *interstitialView;
@property (nonatomic,strong) SAParentalGate *gate;
@property (nonatomic,strong) SAAdResponse *adResponse;
@property (nonatomic,strong) NSURL *adURL;
@property (nonatomic,readwrite,getter=isReady) BOOL ready;

- (void)fetchAd;

@end

@implementation SAInterstitialView

- (instancetype)initWithViewController:(UIViewController *)viewController
{
    if(self = [super init]){
        self.ready = NO;
        self.viewController = viewController;
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
}

- (void)fetchAd
{
    self.ready = NO;
    
    SAAdManager *adLoader = [[SuperAwesome sharedManager] adManager];
    SAAdRequest *adRequest = [[SAAdRequest alloc] initWithPlacementId:self.placementID];
    [adLoader loadAd:adRequest completion:^(SAAdResponse *response, NSError *error) {
        if(error != nil){
            [SKLogger error:@"SAinterstitialView" withMessage:@"Failed to fetch ad"];
            if(self.delegate && [self.delegate respondsToSelector:@selector(didFailFetchingInterstitialAd:)]){
                [self.delegate didFailFetchingInterstitialAd:self];
            }
            return ;
        }
        
        self.adResponse = response;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self renderAd];
        });
    }];
}

- (void) renderAd {
    NSString *html = [self.adResponse.creative toHTML];
    self.interstitialView = [[SKMRAIDInterstitial alloc] initWithSupportedFeatures:@[] withHtmlData:html withBaseURL:[NSURL URLWithString:@"http://superawesome.tv"] delegate:self serviceDelegate:nil rootViewController:self.viewController];
    [self.interstitialView setBackgroundColor:self.backgroundColor];
}

- (void) present
{
    [self.interstitialView show];
    
    // present the interstitial view's padlock
    if (!_adResponse.isFallback) {
        [self setupPadlockButton:[[[UIApplication sharedApplication] delegate] window]];
    }
}

- (void)load
{
    [self fetchAd];
}

#pragma mark - SKMRAIDInterstitialDelegate

- (void)mraidInterstitialAdReady:(SKMRAIDInterstitial *)mraidInterstitial
{
    [SKLogger debug:@"SAInterstitialView" withMessage:@"Ad is ready to display"];
    self.ready = YES;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.delegate && [self.delegate respondsToSelector:@selector(didSuccessfullyFetchInterstitialAd:)]){
            [self.delegate didSuccessfullyFetchInterstitialAd:self];
        }
    });
    
}

- (void)mraidInterstitialAdFailed:(SKMRAIDInterstitial *)mraidInterstitial
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didFailFetchingInterstitialAd:)]){
        [self.delegate didFailFetchingInterstitialAd:self];
    }
}

- (void)mraidInterstitialWillShow:(SKMRAIDInterstitial *)mraidInterstitial
{
    [SKLogger debug:@"SAInterstitialView" withMessage:@"Ad will show"];
}

- (void)mraidInterstitialDidHide:(SKMRAIDInterstitial *)mraidInterstitial
{
    [SKLogger debug:@"SAInterstitialView" withMessage:@"Ad did hide"];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didHideInterstitialView:)]){
        [self.delegate didHideInterstitialView:self];
    }
    
    if (!_adResponse.isFallback) {
        [self removePadlockButton];
    }
}

- (void)mraidInterstitialNavigate:(SKMRAIDInterstitial *)mraidInterstitial withURL:(NSURL *)url
{    
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

#pragma mark - SAParentalGateDelegate

- (void)didGetThroughParentalGate:(SAParentalGate *)parentalGate
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(willLeaveApplicationForInterstitialAd:)]){
        [self.delegate willLeaveApplicationForInterstitialAd:self];
    }
    [[UIApplication sharedApplication] openURL:self.adURL];
}

@end
