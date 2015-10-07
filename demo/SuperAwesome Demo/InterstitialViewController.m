//
//  InterstitialViewController.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 26/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "InterstitialViewController.h"
#import "SuperAwesome.h"

@interface InterstitialViewController ()

@property (nonatomic, strong) SAInterstitialAd *interstitial;

@end

@implementation InterstitialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _interstitial = [[SAInterstitialAd alloc] initWithPlcementId:10029];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)presentInterstitial:(id)sender
{
    [_interstitial play];
//    [_interstitial showWithVC:self];
}

@end
