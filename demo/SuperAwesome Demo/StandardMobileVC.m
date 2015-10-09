//
//  StandardMobileVC.m
//  SuperAwesome Demo
//
//  Created by Gabriel Coman on 09/10/2015.
//  Copyright © 2015 SuperAwesome Ltd. All rights reserved.
//

#import "StandardMobileVC.h"
#import "SuperAwesome.h"

@interface StandardMobileVC ()

@property (weak, nonatomic) IBOutlet SABannerAd *bannerAd;
@end

@implementation StandardMobileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_bannerAd playInstant];
    
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
