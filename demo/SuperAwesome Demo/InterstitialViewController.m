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
    // Do any additional setup after loading the view.
    
    self.interstitial = [[SAInterstitialView alloc] initWithViewController:self];
    self.interstitial.appID = @"14";
    self.interstitial.placementID = @"5247931";
    self.interstitial.delegate = self;
    self.interstitial.backgroundColor = [UIColor lightGrayColor];
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
}

- (void)didFailFetchingInterstitialAd:(SAInterstitialView *)interstitialView
{
    NSLog(@"Interstitial error");
}

- (void)didHideInterstitialView:(SAInterstitialView *)interstitialView
{
    NSLog(@"hidden");
}



@end
