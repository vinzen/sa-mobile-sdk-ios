//
//  ViewController.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 01/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)openLogin:(id)sender
{
    SALoginViewController *vc = [[SALoginViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark SALoginViewControllerDelegate

- (void)loginViewController:(SALoginViewController *)loginVC didSucceedWithToken:(NSString *)token
{
    NSLog(@"Login success! Token: %@", token);
}

- (void)loginViewController:(SALoginViewController *)loginVC didFailWithError:(NSString *)error
{
    NSLog(@"Login failed! Error: %@", error);
}

@end
