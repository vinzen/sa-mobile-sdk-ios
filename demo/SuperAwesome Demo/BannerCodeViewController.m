//
//  BannerCodeViewController.m
//  SuperAwesome Demo
//
//  Created by Balázs Kiss on 21/04/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "BannerCodeViewController.h"
#import "SuperAwesome.h"

@interface BannerCodeViewController ()

@end

@implementation BannerCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SABannerView *bannerView = [[SABannerView alloc] initWithFrame:CGRectMake(0, 100, 320, 50)];
    bannerView.placementID = @"26";
    [self.view addSubview:bannerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
