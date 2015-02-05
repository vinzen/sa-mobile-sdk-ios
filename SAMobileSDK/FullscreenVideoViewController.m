//
//  FullscreenVideoViewController.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 03/02/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "FullscreenVideoViewController.h"

@interface FullscreenVideoViewController ()

@property (nonatomic,strong) SAVideoAdView *videoView;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation FullscreenVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.videoView = [[SAVideoAdView alloc] initWithFrame:self.view.bounds];
    self.videoView.delegate = self;
    self.videoView.appID = @"14";
    self.videoView.placementID = @"314228";
    [self.view addSubview:self.videoView];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.activityIndicatorView startAnimating];
    [self.view addSubview:self.activityIndicatorView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.activityIndicatorView.center = self.view.center;
    self.videoView.frame = self.view.bounds;
}

#pragma mark - SAVideoAdViewDelegate

- (void)didLoadVideoAd:(SAVideoAdView *)videoAd
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicatorView stopAnimating];
        [self.videoView play];
    });
}

- (void)didFinishPlayingVideoAd:(SAVideoAdView *)videoAd{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

@end
