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

@property (nonatomic, strong) SABannerAd *banner;

@end

@implementation BannerCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _banner = [[SABannerAd alloc] initWithFrame:CGRectMake(0, 100, 320, 50) andPlacementId:10001];
    [self.view addSubview:_banner];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
