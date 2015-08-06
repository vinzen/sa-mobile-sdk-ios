//
//  FullscreenVideoPreloadViewController.m
//  SuperAwesome Demo
//
//  Created by Balázs Kiss on 20/04/15.
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//

#import "FullscreenVideoPreloadViewController.h"
#import "SuperAwesome.h"

@interface FullscreenVideoPreloadViewController ()

@property (nonatomic,strong) SAVideoAdViewController *vc;

@end

@implementation FullscreenVideoPreloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.playButton.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)load:(id)sender
{
    self.playButton.enabled = NO;
    self.vc = [[SAVideoAdViewController alloc] initWithPlacementID:@"5740"];
    self.vc.delegate = self;
}

- (IBAction)play:(id)sender
{
    [self presentViewController:self.vc animated:YES completion:nil];
}

#pragma mark - SAVideoViewControllerDelegate

- (void)didLoadVideoAd:(SAVideoAdViewController *)videoAdViewController
{
    self.playButton.enabled = YES;
}

- (void)didFailToLoadVideoAd:(SAVideoAdViewController *)videoAdViewController
{
    NSLog(@"Ad Error");
}


@end
