//
//  SAPadlockView.m
//  Pods
//
//  Created by Gabriel Coman on 08/09/2015.
//
//

#import "SAPadlockView.h"

/**
 * Defines constants for padlock texts
 */
#define SA_PADLOCKVIEW_TITLE @"About SA Ads"
#define SA_PADLOCKVIEW_SUBTITLE1 @"This is SuperAwesome kid-safe ad. Click here for more information."
#define SA_PADLOCKVIEW_SUBTITLE2 @"Rate this Ad"
#define SA_PADLOCKVIEW_SUBTITLE3 @"Share your oppinion:"
#define SA_PADLOCKVIEW_OKBUTTON_TITLE @"OK"

@interface SAPadlockView ()

// internal (private) outlets
@property (strong, nonatomic) UIView *view;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *infoPanel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *Title;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *Subtitle1;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *Subtitle2;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *Subtitle3;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *rateButtons;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *OKBtn;

// touch responder to close
@property (nonatomic, strong) UITapGestureRecognizer *tapToClose;

@end

@implementation SAPadlockView

- (id) init {
    if (self = [super init]) {
        // setup the pop-up frame
        self.frame = [UIScreen mainScreen].bounds;
        
        // load the view from a NIB / XIB file
        _view = [[[NSBundle mainBundle] loadNibNamed:@"SAPadlockView" owner:self options:nil] firstObject];
        _view.frame = self.frame;
        [self addSubview:_view];
        
        // do some more panel view setup
        _infoPanel.layer.shadowColor = [UIColor blackColor].CGColor;
        _infoPanel.layer.shadowOpacity = 0.25f;
        _infoPanel.layer.shadowRadius = 2.25f;
        _infoPanel.layer.shadowOffset = CGSizeMake(0, 0);
        
        // setup texts
        _Title.text = SA_PADLOCKVIEW_TITLE;
        _Subtitle1.text = SA_PADLOCKVIEW_SUBTITLE1;
        _Subtitle2.text = SA_PADLOCKVIEW_SUBTITLE2;
        _Subtitle3.text = SA_PADLOCKVIEW_SUBTITLE3;
        [_OKBtn setTitle:SA_PADLOCKVIEW_OKBUTTON_TITLE forState:UIControlStateNormal];
        
        // setup tags
        short i = 0;
        for (UIButton *rateBtn in _rateButtons) {
            i++;
            rateBtn.tag = i;
        }
        
        // get the tap part
        _tapToClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:_tapToClose];
    }
    
    return self;
}

// rate the current ad
- (IBAction) rateAction:(id)sender{
    for (UIButton *rateBtn in _rateButtons) {
        [rateBtn setSelected:false];
    }
    
    for (short i = 0; i < [sender tag]; i++) {
        [_rateButtons[i] setSelected:true];
    }
}

// when tapping outside the info panel's frame,
// close the view
- (void) tapAction:(UITapGestureRecognizer*)recognizer {
    
    CGPoint touchPoint = [recognizer locationInView:self];
    CGRect panelFrame = _infoPanel.frame;
    
    if (!CGRectContainsPoint(panelFrame, touchPoint)) {
        [self closeThisView];
    }
}

// when pressing the OK button,
// close the view
- (IBAction)okBtnAction:(id)sender {
    [self closeThisView];
}

// properly close the view
- (void) closeThisView {
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
