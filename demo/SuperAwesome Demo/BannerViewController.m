//
//  BannerViewController.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 26/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "BannerViewController.h"
#import "SuperAwesome.h"

@interface BannerViewController ()

@property (weak, nonatomic) IBOutlet SABannerAd *banner;

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
    
    [_banner play];
    
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
