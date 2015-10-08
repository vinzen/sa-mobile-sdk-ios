//
//  VideoViewController.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 26/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "VideoViewController.h"
#import "SuperAwesome.h"

@interface VideoViewController ()
//@property (weak, nonatomic) IBOutlet SAVideoAdView2 *viewAdView2;

@end

@implementation VideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup afte
    
    SAVideoAd *videoad = [[SAVideoAd alloc] initWithFrame:CGRectMake(20, 150, 320, 240) andPlacementId:10002];
    [self.view addSubview:videoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startVideoAd:(id)sender
{
}

- (IBAction)stopVideoAd:(id)sender
{
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
