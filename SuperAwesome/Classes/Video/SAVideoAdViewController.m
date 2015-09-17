//
//  SAVideoAdViewController.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 03/02/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "SAVideoAdViewController.h"

@interface SAVideoAdViewController ()

@property (nonatomic,strong) NSString *placementID;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation SAVideoAdViewController

- (instancetype)initWithPlacementID:(NSString *)placementID;
{
    if(self = [super init]){
        self.videoView = [[SAVideoAdView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        self.videoView.delegate = self;
        self.videoView.placementID = placementID;
    }
    return self;
}

- (instancetype)initWithAdLoader:(SAVideoAdLoader *)adLoader
{
    if(self = [super init]){
        self.videoView = [[SAVideoAdView alloc] initWithAdLoader:adLoader];
        self.videoView.delegate = self;
    }
    return self;
}

- (void)setParentalGateEnabled:(BOOL)parentalGateEnabled
{
    _parentalGateEnabled = parentalGateEnabled;
    if(self.videoView){
        self.videoView.parentalGateEnabled = self.parentalGateEnabled;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.view.backgroundColor = [UIColor blackColor];
    
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

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.activityIndicatorView.center = self.view.center;
    self.videoView.frame = self.view.bounds;
}

- (void)appplicationDidBecomeActive:(NSNotification *)notification
{
    [self.videoView resume];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(self.videoView.isReady){
        [self start];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)start
{
    [self.activityIndicatorView stopAnimating];
    [self.videoView play];
    [_videoView setupPadlockButton:self.view];
}


#pragma mark - SAVideoAdViewDelegate

- (void)didLoadVideoAd:(SAVideoAdView *)videoAd
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // if VC is visible
        if (self.isViewLoaded && self.view.window) {
            [self start];
        }
    });
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didLoadVideoAd:)]){
        [self.delegate didLoadVideoAd:self];
    }
}

- (void)didFinishPlayingVideoAd:(SAVideoAdView *)videoAd{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)didFailToLoadVideoAd:(SAVideoAdView *)videoAd
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didFailToLoadVideoAd:)]){
        [self.delegate didFailToLoadVideoAd:self];
    }
}

- (void)didFailToPlayVideoAd:(SAVideoAdView *)videoAd
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)didClickVideoAd:(SAVideoAdView *)videoAd
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appplicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    });
}

@end
