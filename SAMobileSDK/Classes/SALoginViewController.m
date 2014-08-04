//
//  SALoginViewController.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 01/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SALoginViewController.h"
#import "SALoginWebViewController.h"

@interface SALoginViewController ()

@end

@implementation SALoginViewController

- (id)init
{
    SALoginWebViewController *vc = [[SALoginWebViewController alloc] initWithNibName:@"SALoginWebViewController" bundle:[NSBundle mainBundle]];
    return [self initWithRootViewController:vc];
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
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
