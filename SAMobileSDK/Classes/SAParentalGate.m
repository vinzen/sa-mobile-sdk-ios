//
//  ParentalGate.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 16/09/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SAParentalGate.h"
#import "SAAlertView.h"

@interface SAParentalGate ()

@property (nonatomic,assign) NSInteger number1;
@property (nonatomic,assign) NSInteger number2;
@property (nonatomic,assign) NSInteger solution;
@property (nonatomic,strong) UIAlertView *wrongAnswerAlertView;

@end

@implementation SAParentalGate

- (void)newQuestion
{
    self.number1 = arc4random() % 80 + 20;
    self.number2 = arc4random() % 80 + 20;
    self.solution = self.number1 + self.number2;
}

- (void)show
{
    [self newQuestion];
    NSString *msg = [NSString stringWithFormat:@"Solve the following sum to continue: %@ + %@ = ?", @(self.number1), @(self.number2)];
    SAAlertView *alertView = [[SAAlertView alloc] initWithTitle:@"Parental Gate" message:msg delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alertView textFieldAtIndex:0];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        UITextField *textField = [alertView textFieldAtIndex:0];
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *input = [f numberFromString:textField.text];
        if([input integerValue] == self.solution){
            if(self.delegate && [self.delegate respondsToSelector:@selector(didGetThroughParentalGate:)]){
                [self.delegate didGetThroughParentalGate:self];
            }
        }else{
            self.wrongAnswerAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry, that was the wrong answer" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [self.wrongAnswerAlertView show];
            [self performSelector:@selector(dismissAlertView:) withObject:self.wrongAnswerAlertView afterDelay:2];
        }
    }
}

-(void)dismissAlertView:(UIAlertView*)alertView{
	[alertView dismissWithClickedButtonIndex:-1 animated:YES];
}

@end
