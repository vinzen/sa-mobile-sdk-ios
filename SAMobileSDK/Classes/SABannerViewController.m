//
//  SABannerViewController.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 29/07/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SABannerViewController.h"

@interface SABannerViewController ()

@end

@implementation SABannerViewController

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
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"%@", [[NSBundle mainBundle] bundleIdentifier]);
    
    
    ATAdtechAdConfiguration *configuration = [ATAdtechAdConfiguration configuration]; configuration.alias = @"home-top-5";
    self.bannerView.configuration = configuration;
    self.bannerView.viewController = self;
    //self.bannerView.delegate = self;
    //adtechBanner.allowLocationsServices = YES; //Optionally allow usage of the Location Services, if the presented ad would like to use them
    [self.bannerView load];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
