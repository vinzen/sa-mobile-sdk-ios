//
//  TestVCViewController.m
//  SuperAwesome Demo
//
//  Created by Gabriel Coman on 20/10/2015.
//  Copyright © 2015 SuperAwesome Ltd. All rights reserved.
//

#import "TestVCViewController.h"
#import "SuperAwesome.h"


@interface TestVCViewController () <SALoaderProtocol, SAAdProtocol, SAVideoAdProtocol>

@property (nonatomic, strong) SABannerAd *ad;

@end

@implementation TestVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[SALoader sharedManager] setDelegate:self];
    [[SALoader sharedManager] preloadAdForPlacementId:5811];
    
    [@"" stringByAddingPercentEscapesUsingEncoding:NSStringEncodingConversionAllowLossy];
    NSString *abc = @"{\"placement\":5692,\"creative\":-1,\"line_item\":-1,\"type\":\"viewable_impression\"}";
    NSString *datajson = [[NSString stringWithFormat:abc]
                          stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString *str = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                              (__bridge CFStringRef)abc,
                                                                              NULL,
                                                                              (__bridge CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                              CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    
    NSString *endpoing = [NSString stringWithFormat:@"https://ads.superawesome.tv/v2/event?data=%@", str];
    NSLog(@"%@", endpoing);
    [SANetwork sendGETtoEndpoint:endpoing withQueryDict:@{} andSuccess:^(NSData *data) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", str);
    } orFailure:^{
        
    }];
    
    _ad = [[SABannerAd alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
//    _ad = [[SABannerAd alloc] initWithPlacementId:<#(NSInteger)#> andFrame:<#(CGRect)#>]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actiion:(id)sender {
    
    SAInterstitialAd *iad = [[SAInterstitialAd alloc] initWithPlacementId:5692];
    [self presentViewController:iad animated:YES completion:^{
        [iad playInstant];
    }];
    
}
- (IBAction)action2:(id)sender {
    
    SAFullscreenVideoAd *fvad = [[SAFullscreenVideoAd alloc] initWithPlacementId:24532];
    fvad.isParentalGateEnabled = YES;
    [self presentViewController:fvad animated:YES completion:^{
        [fvad playInstant];
    }];
    
}

- (void) didPreloadAd:(SAAd *)ad forPlacementId:(NSInteger)placementId {
    
}

- (void) didFailToPreloadAdForPlacementId:(NSInteger)placementId {
    
}

@end
