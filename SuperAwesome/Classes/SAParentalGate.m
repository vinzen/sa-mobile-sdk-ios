//
//  ParentalGate.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 16/09/14.
//  Modified by Gabriel Coman (gabriel.coman@superawesome.tv)
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SAParentalGate.h"
#import "SuperAwesome.h"
#import "UIAlertController+Window.h"

/**
 * SAParentalGate defines
 */
#define SA_CHALLANGE_ALERTVIEW 0
#define SA_ERROR_ALLERTVIEW 1

#define SA_RAND_MIN 50
#define SA_RAND_MAX 99

#define SA_CHALLANGE_ALERTVIEW_TITLE @"Parental Gate"
#define SA_CHALLANGE_ALERTVIEW_MESSAGE @"Please solve the following problem to continue:\n%@ + %@ = ?"
#define SA_CHALLANGE_ALERTVIEW_FORMATTED_MESSAGE [NSString stringWithFormat:SA_CHALLANGE_ALERTVIEW_MESSAGE, @(_number1), @(_number2)]
#define SA_CHALLANGE_ALERTVIEW_CANCELBUTTON_TITLE @"Cancel"
#define SA_CHALLANGE_ALERTVIEW_CONTINUEBUTTON_TITLE @"Continue"

#define SA_ERROR_ALERTVIEW_TITLE @"Sorry, that was the wrong answer"
#define SA_ERROR_ALERTVIEW_MESSAGE @"Please ask an adult for help"
#define SA_ERROR_ALERTVIEW_CANCELBUTTON_TITLE @"Ok"

// anonymous extension of SAParentalGate
@interface SAParentalGate ()

@property (nonatomic,assign) NSInteger number1;
@property (nonatomic,assign) NSInteger number2;
@property (nonatomic,assign) NSInteger solution;

@property (nonatomic, retain) UIAlertView *challengeAlertView;
@property (nonatomic, retain) UIAlertController *challangeAlertView;
@property (nonatomic, retain) UIAlertView *wrongAnswerAlertView;

// blocks (if you don't want to use protocols
@property (nonatomic, retain) NSString *adname;
@property (nonatomic, assign) interactionBlock didGetThroughParentalGate;
@property (nonatomic, assign) interactionBlock didCancelParentalGate;
@property (nonatomic, assign) interactionBlock didFailChallengeForParentalGate;

// the ad response
@property (nonatomic, retain) SAAdResponse *response;

@end

@implementation SAParentalGate

- (id) initWithAdResponse:(SAAdResponse *)response {
    if (self = [super init]) {
        _response = response;
    }
    
    return self;
}

- (id) initWithPlacementId:(NSString*)placementID
             andCreativeId:(NSString*)creativeID
             andLineItemId:(NSString*)lineItemID {
    if (self = [super init]) {
        _response = [[SAAdResponse alloc] initWithPlacementId:placementID
                                                andLineItemId:lineItemID
                                                 andCreativId:creativeID];
    }
    
    return self;
}

/**
 * This function initiates a new question
 */
- (void) newQuestion {
    _number1 = [self randomNumberBetween:SA_RAND_MIN maxNumber:SA_RAND_MAX];
    _number2 = [self randomNumberBetween:SA_RAND_MIN maxNumber:SA_RAND_MAX];
    _solution = _number1 + _number2;
}

- (void) show {
    [self newQuestion];
    
    // action block #1
    actionBlock cancelBlock = ^(UIAlertAction *action) {
        // log the action
        [[SAEventManager sharedInstance] LogUserCanceledParentalGate:_response];
        
        #pragma mark Normal iOS behaviour
        if(self.delegate && [self.delegate respondsToSelector:@selector(didCancelParentalGate:)]){
            [self.delegate didCancelParentalGate:self];
        }
        
        #pragma mark Unity / iOS behaviour
        if (_didCancelParentalGate != nil) {
            _didCancelParentalGate(_adname);
        }
    };
    
    // action block #2
    actionBlock continueBlock = ^(UIAlertAction *action) {
        
        // get number from text field
        UITextField *textField = [[_challangeAlertView textFields] firstObject];
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *input = [f numberFromString:textField.text];
        
        // what happens when you get a right solution
        if([input integerValue] == self.solution){
            
            // send a server message
            [[SAEventManager sharedInstance] LogUserSuccessWithParentalGate:_response];
            [[SAEventManager sharedInstance] LogClick:_response];
            
            #pragma mark Normal iOS behaviour
            if(self.delegate && [self.delegate respondsToSelector:@selector(didGetThroughParentalGate:)]){
                [self.delegate didGetThroughParentalGate:self];
            }
            
            #pragma mark Unity / iOS behaviour
            if (_didGetThroughParentalGate != nil){
                _didGetThroughParentalGate(_adname);
            }
        }
        // or a bad solution
        else{
            // log error
            [[SAEventManager sharedInstance] LogUserErrorWithParentalGate:_response];
            
            // ERROR
            _wrongAnswerAlertView = [[UIAlertView alloc] initWithTitle:SA_ERROR_ALERTVIEW_TITLE
                                                               message:SA_ERROR_ALERTVIEW_MESSAGE
                                                              delegate:self
                                                     cancelButtonTitle:SA_ERROR_ALERTVIEW_CANCELBUTTON_TITLE
                                                     otherButtonTitles: nil];
            [_wrongAnswerAlertView show];
            
            #pragma mark Normal iOS behaviour
            if(self.delegate && [self.delegate respondsToSelector:@selector(didFailChallengeForParentalGate:)]){
                [self.delegate didFailChallengeForParentalGate:self];
            }
            
            #pragma mark Unity / iOS behaviour
            if (_didFailChallengeForParentalGate != nil){
                _didFailChallengeForParentalGate(_adname);
            }
        }
    };
    
    
    // alert view (controller)
    _challangeAlertView = [UIAlertController alertControllerWithTitle:SA_CHALLANGE_ALERTVIEW_TITLE
                                                              message:SA_CHALLANGE_ALERTVIEW_FORMATTED_MESSAGE
                                                       preferredStyle:UIAlertControllerStyleAlert];
    
    // actions
    UIAlertAction* continueBtn = [UIAlertAction actionWithTitle:SA_CHALLANGE_ALERTVIEW_CONTINUEBUTTON_TITLE
                                                          style:UIAlertActionStyleDefault
                                                        handler:continueBlock];
    UIAlertAction* cancelBtn = [UIAlertAction actionWithTitle:SA_CHALLANGE_ALERTVIEW_CANCELBUTTON_TITLE
                                                        style:UIAlertActionStyleDefault
                                                      handler:cancelBlock];
    
    
    // add actions
    [_challangeAlertView addAction:cancelBtn];
    [_challangeAlertView addAction:continueBtn];
    __block UITextField *localTextField;
    
    [_challangeAlertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        localTextField = textField;
        localTextField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    [_challangeAlertView show];
    
    // display the alert controller
//    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
//    [topController presentViewController:_challangeAlertView animated:YES completion:nil];
}

// internal random functions
- (NSInteger)randomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max {
    return min + arc4random_uniform((uint32_t)(max - min + 1));
}

- (void) setAdName:(NSString *)adname {
    _adname = adname;
}

- (void) addSuccessBlock:(interactionBlock)block {
    _didGetThroughParentalGate = block;
}

- (void) addErrorBlock:(interactionBlock)block {
    _didFailChallengeForParentalGate = block;
}

- (void) addCancelBlock:(interactionBlock)block {
    _didCancelParentalGate = block;
}

@end
