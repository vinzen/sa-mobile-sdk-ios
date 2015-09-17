//
//  BannerViewController.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 26/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "BannerViewController.h"
#import <SuperAwesome.h>

@interface BannerViewController () <SABannerViewDelegate>

@property (weak, nonatomic) IBOutlet SABannerView *bannerView;

@end

@implementation BannerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _bannerView.delegate = self;
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark SABannerViewDelegate functions

- (void) shouldSuspendForAd:(SABannerView *)view {
//    NSLog(@"LIVIU TEST COMMENT: shouldSuspendForAd");
}

- (void) shouldResumeForAd:(SABannerView *)view {
//    NSLog(@"LIVIU TEST COMMENT: shouldResumeForAd");
}

- (void) shouldDisplayCustomMediationForAd:(SABannerView *)view {
//    NSLog(@"LIVIU TEST COMMENT: shouldDisplayCustomMediationForAd");
}

- (void) willLeaveApplicationForAd:(SABannerView *)view {
//    NSLog(@"LIVIU TEST COMMENT: willLeaveApplicationForAd");
}

- (void) didFailShowingAd:(SABannerView *)view {
//    NSLog(@"LIVIU TEST COMMENT: didFailShowingAd");
}

- (void) didFetchNextAd:(SABannerView *)view {
//    NSLog(@"LIVIU TEST COMMENT: didFetchNextAd");
}

@end
