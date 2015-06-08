//
//  InterstitialViewController.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 26/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "InterstitialViewController.h"

@interface InterstitialViewController ()

@property (nonatomic,strong) SAInterstitialView *interstitial;

@end

@implementation InterstitialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.showButton.enabled = NO;
    
    self.interstitial = [[SAInterstitialView alloc] initWithViewController:self];
    self.interstitial.placementID = @"271";
    self.interstitial.delegate = self;
//    self.interstitial.parentalGateEnabled = YES;
    self.interstitial.backgroundColor = [UIColor lightGrayColor];
    
    [self.interstitial load];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)presentInterstitial:(id)sender
{
    [self.interstitial present];
}

#pragma mark - SAInterstitialViewDelegate methods

- (void)didSuccessfullyFetchInterstitialAd:(SAInterstitialView *)interstitialView
{
    NSLog(@"Interstitial loaded");
    
    self.showButton.enabled = YES;
}

- (void)didFailFetchingInterstitialAd:(SAInterstitialView *)interstitialView
{
    NSLog(@"Interstitial error");
}

- (void)didHideInterstitialView:(SAInterstitialView *)interstitialView
{
    NSLog(@"Interstitial hidden");
    self.showButton.enabled = NO;
    [self.interstitial load];
}

- (void)willLeaveApplicationForInterstitialAd:(SAInterstitialView *)interstitialView
{
    NSLog(@"Will leave app for interstitial");
}

@end
