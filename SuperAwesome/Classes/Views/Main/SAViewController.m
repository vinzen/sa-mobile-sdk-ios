//
//  SAViewController.m
//  Pods
//
//  Created by Gabriel Coman on 21/10/2015.
//
//

#import "SAViewController.h"

// import header
#import "SAView.h"
#import "SAAd.h"
#import "SABannerAd.h"
#import "Utils.h"

@interface SAView ()
- (void) resizeToFrame:(CGRect)toframe;
@end

@interface SAViewController ()

@end

@implementation SAViewController

- (id) init {
    if (self = [super init]) {
        _placementId = 0;
    }
    
    return self;
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _placementId = 0;
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _placementId = 0;
    }
    return self;
}

- (id) initWithPlacementId:(NSInteger)placementId {
    if (self = [super init]) {
        _placementId = placementId;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set bg color
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // setup coordinates
    [self setupCoordinates];
    
    // create close button
    closeBtn = [[UIButton alloc] initWithFrame:buttonFrame];
    [closeBtn setTitle:@"" forState:UIControlStateNormal];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    // add notification
    [[NSNotificationCenter defaultCenter] addObserver:self // put here the view controller which has to be notified
                                             selector:@selector(orientationChanged:)
                                                 name:@"UIDeviceOrientationDidChangeNotification"
                                               object:nil];
}

- (void) setupCoordinates {
    CGRect frame = [UIScreen mainScreen].bounds;
    
    CGFloat tW = frame.size.width * 0.85;
    CGFloat tH = frame.size.height * 0.85;
    CGFloat tX = ( frame.size.width - tW ) / 2;
    CGFloat tY = ( frame.size.height - tH) / 2;
    CGRect newR = [Utils arrangeAdInNewFrame:CGRectMake(tX, tY, tW, tH) fromFrame:frame ];
    newR.origin.x += tX;
    newR.origin.y += tY;
    
    CGFloat cs = MIN(frame.size.width, frame.size.height) * 0.15f;
    
    // final frames
    adviewFrame = newR;
    buttonFrame = CGRectMake(frame.size.width - cs, 0, cs, cs);
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) setAd:(SAAd *)_ad {
    ad = _ad;
}

- (void) playInstant {
    [adview playInstant];
}

- (void) playPreloaded {
    [adview playPreloaded];
}

- (void) closeAction: (id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([adview.delegate respondsToSelector:@selector(adWasClosed:)]) {
            [adview.delegate adWasClosed:_placementId];
        }
    }];
}

- (void)orientationChanged:(NSNotification *)notification{
    // restup coordinates
    [self setupCoordinates];
    
    closeBtn.frame = buttonFrame;
    
    [adview resizeToFrame:adviewFrame];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
