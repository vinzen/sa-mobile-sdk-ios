//
//  SAVideoViewController.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 30/07/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SAVideoViewController.h"

@interface SAVideoViewController ()

@end

@implementation SAVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    self.moviePlayerController = [[ATMoviePlayerController alloc] initWithContentURL:YOUR_CONTENT_URL];
//    self.moviePlayerController.presentingViewController = self;
//    ATAdtechVideoAdConfiguration *configuration = [ATAdtechVideoAdConfiguration configuration];
////    configuration.networkID = YOUR_NETWORK_ID; // if different from the default value set in the ADTECHAdConfiguration.plist file
////    configuration.subNetworkID = YOUR_SUB_NETWORK_ID; // if different from the default value set in the ADTECHAdConfiguration.plist file
////    configuration.alias = YOUR_ALIAS;
//    [configuration enableAdType:kATVideoAdPreRoll]; // Choose one or more, depending on what you have configured server-side.
//    [configuration enableAdType:kATVideoAdMidRoll]; [configuration enableAdType:kATVideoAdPostRoll];
//    self.moviePlayerController.configuration = configuration;
//    [self.moviePlayerController prepareToPlay];
//    
//    [self.view addSubview:self.moviePlayerController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
