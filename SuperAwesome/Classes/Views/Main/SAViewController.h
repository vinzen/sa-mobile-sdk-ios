//
//  SAViewController.h
//  Pods
//
//  Created by Gabriel Coman on 21/10/2015.
//
//

#import <UIKit/UIKit.h>

// class SAView
@class SAView;
@class SAAd;

// import SAView Protocol
#import "SAViewProtocol.h"

@interface SAViewController : UIViewController {
    SAView *adview;
    SAAd *ad;
    CGRect adviewFrame;
    CGRect buttonFrame;
    UIButton *closeBtn;
}

// custom init
- (id) initWithPlacementId:(NSInteger)placementId;

// delegate of the SA View protocol
@property id<SAViewProtocol> delegate;

// public mmeber variables
@property (nonatomic, assign) IBInspectable NSInteger placementId;
@property (nonatomic, assign) IBInspectable BOOL isParentalGateEnabled;
@property (nonatomic, assign) IBInspectable NSInteger refreshPeriod;

// important SAview functions
- (void) setAd:(SAAd*)ad;
- (void) playInstant;
- (void) playPreloaded;

@end
