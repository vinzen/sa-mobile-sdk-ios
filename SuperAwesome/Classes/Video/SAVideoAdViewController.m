//
//  SAVideoAdViewController2.m
//  Pods
//
//  Created by Gabriel Coman on 22/09/2015.
//
//

#import "SAVideoAdViewController.h"
#import "SAVideoAdView.h"

@interface SAVideoAdViewController () <SAVideoAdViewProtocol>

// internal property
@property (nonatomic, strong) SAVideoAdView *videoAd;

// blocks for unity
@property (nonatomic, strong) NSString *adName;
@property (nonatomic, assign) videoBlock loadVideoBlock;
@property (nonatomic, assign) videoBlock failToLoadVideoBlock;
@property (nonatomic, assign) videoBlock startVideoBlock;
@property (nonatomic, assign) videoBlock stopVideoBlock;
@property (nonatomic, assign) videoBlock failToPlayVideoBlock;
@property (nonatomic, assign) videoBlock clickVideoBlock;


@end

@implementation SAVideoAdViewController

- (id) initWithPlacementId:(NSString *)placementID {
    if (self = [super init]) {
        _placementID = placementID;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _videoAd = [[SAVideoAdView alloc] initWithFrame:CGRectMake(0, 25, self.view.frame.size.width, self.view.frame.size.height - 25.0f)];
    _videoAd.shouldAutoplay = false;
    _videoAd.isFullscreen = true;
    _videoAd.placementID = _placementID;
    _videoAd.parentalGateEnabled = _parentalGateEnabled;
    _videoAd.delegate = self;
    _videoAd.canSkip = true;
    [self.view addSubview:_videoAd];
    [_videoAd play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark SAVideoAdView2 delegate

- (void) didLoadVideoAd:(UIView *)view {
    
    #pragma mark Normal iOS behaviour
    if (self.delegate && [self.delegate respondsToSelector:@selector(didLoadVideoAd:)]) {
        [self.delegate didLoadVideoAd:self];
    }
    
    #pragma mark Unity behaviour
    if (_loadVideoBlock != NULL) {
        _loadVideoBlock(_adName);
    }
}

- (void) didShowVideoAd:(UIView *)view {
    
}

- (void) didFailShowingAd:(UIView *)view {
    // dismiss & clear on error
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    #pragma mark Normal iOS behaviour
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFailToLoadVideoAd:)]) {
        [self.delegate didFailToLoadVideoAd:self];
    }
    
    #pragma mark Unity behaviour
    if (_failToLoadVideoBlock != NULL){
        _failToLoadVideoBlock(_adName);
    }
}

- (void)didStartPlayingVideoAd:(UIView *)videoAd {
    #pragma mark Normal iOS behaviour
    if (_delegate && [_delegate respondsToSelector:@selector(didStartPlayingVideoAd:)]){
        [_delegate didStartPlayingVideoAd:self];
    }
    
    #pragma mark Unity behaviour
    if (_startVideoBlock != NULL){
        _startVideoBlock(_adName);
    }
}
- (void)didReachFirstQuartile:(UIView*)videoAd {
    #pragma mark Normal iOS behaviour
    if (_delegate && [_delegate respondsToSelector:@selector(didReachFirstQuartile:)]){
        [_delegate didReachFirstQuartile:self];
    }
}
- (void)didReachHalfpoint:(UIView*)videoAd {
    #pragma mark Normal iOS behaviour
    if (_delegate && [_delegate respondsToSelector:@selector(didReachHalfpoint:)]){
        [_delegate didReachHalfpoint:self];
    }
}
- (void)didReachThirdQuartile:(UIView*)videoAd {
    #pragma mark Normal iOS behaviour
    if (_delegate && [_delegate respondsToSelector:@selector(didReachThirdQuartile:)]){
        [_delegate didReachThirdQuartile:self];
    }
}
- (void)didFailToPlayVideoAd:(UIView *)videoAd {
    #pragma mark Normal iOS behaviour
    if (_delegate && [_delegate respondsToSelector:@selector(didFailToPlayVideoAd:)]){
        [_delegate didFailToPlayVideoAd:self];
    }
    
    #pragma mark Unity behaviour
    if (_failToPlayVideoBlock != NULL){
        _failToPlayVideoBlock(_adName);
    }
}
- (void)didClickVideoAd:(UIView *)videoAd {
    #pragma mark Normal iOS behaviour
    if (_delegate && [_delegate respondsToSelector:@selector(didClickVideoAd:)]){
        [_delegate didClickVideoAd:self];
    }
    
    #pragma mark Unity behaviour
    if (_clickVideoBlock != NULL){
        _clickVideoBlock(_adName);
    }
}

- (void) didFinishPlayingVideoAd:(UIView *)videoAd {
    // dismiss & clear
//    [_videoAd stop];
//    [_videoAd removeFromSuperview];
//    _videoAd = nil;

//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    #pragma mark Normal iOS behaviour
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishPlayingVideoAd:)]) {
        [self.delegate didFinishPlayingVideoAd:self];
    }
    
    #pragma mark Unity behaviour
    if (_stopVideoBlock != NULL){
        _stopVideoBlock(_adName);
    }
}

- (void) didPressOnSkip:(UIView *)view {
    // dismiss & clear
//    [_videoAd stop];
//    [_videoAd removeFromSuperview];
//    _videoAd = nil;
    
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    #pragma mark Normal iOS behaviour
    if (_delegate && [_delegate respondsToSelector:@selector(didPressOnSkip:)]){
        [_delegate didPressOnSkip:self];
    }
}

#pragma mark <UNITY>

- (void) setAdName:(NSString *)adname {
    _adName = adname;
}

- (void) addLoadVideoBlock:(videoBlock)block {
    _loadVideoBlock = block;
}

- (void) addFailToLoadVideoBlock:(videoBlock)block {
    _failToLoadVideoBlock = block;
}

- (void) addStartVideoBlock:(videoBlock)block {
    _startVideoBlock = block;
}

- (void) addStopVideoBlock:(videoBlock)block {
    _stopVideoBlock = block;
}

- (void) addFailToPlayVideoBlock:(videoBlock)block {
    _failToPlayVideoBlock = block;
}

- (void) addClickVideoBlock:(videoBlock)block {
    _clickVideoBlock = block;
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
