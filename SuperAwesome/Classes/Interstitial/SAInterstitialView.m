//
//  SAInterstitialView.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 12/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SAInterstitialView.h"

@interface SAInterstitialView ()

@property (nonatomic,strong) SKMRAIDInterstitial *interstitialView;
@property (nonatomic,strong) SAParentalGate *gate;
@property (nonatomic,strong) NSURL *adURL;

@end

@implementation SAInterstitialView

- (instancetype)initWithViewController:(UIViewController *)viewController
{
    if(self = [super init]){
        
        self.interstitialView = [[SKMRAIDInterstitial alloc] initWithSupportedFeatures:@[] withHtmlData:@"<script type=\"text/javascript\" src=\"http://staging.beta.ads.superawesome.tv/v2/ad.js?placement=1194499\"></script>" withBaseURL:[NSURL URLWithString:@"http://superawesome.tv"] delegate:self serviceDelegate:nil rootViewController:viewController];
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
    
    [[[SuperAwesome sharedManager] adLoader] loadAd:placementID completion:^(NSError *error) {
        
    }];
}

- (void)tryToLoadAd
{
    if(self.placementID == nil) return;
    
    [[SuperAwesome sharedManager] displayAdForApp:self.appID placement:self.placementID completion:^(SADisplayAd *displayAd) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(displayAd == nil){
                NSLog(@"SA: Could not find placement with the provided placement ID");
            }else{

            }
        });
    }];
}

- (void)present
{
    [self.interstitialView show];
}

#pragma mark - SAParentalGateDelegate

- (void)didGetThroughParentalGate:(SAParentalGate *)parentalGate
{
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
    NSLog(@"Ad Failed");
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
        [[UIApplication sharedApplication] openURL:url];
    }
}


@end
