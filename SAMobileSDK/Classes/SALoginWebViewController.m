//
//  SALoginWebViewController.m
//  SAMobileSDK
//
//  Created by Balázs Kiss on 01/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import "SALoginWebViewController.h"
#import "SALoginViewController.h"

@interface SALoginWebViewController ()

@end

@implementation SALoginWebViewController

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
    
    self.title = @"Login";
    
    if(self.navigationController){
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
        [self.navigationItem setRightBarButtonItem:doneButton];
    }
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"login/index" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:nil];
    
    [self.webView2.scrollView setBounces:NO];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    if(webView == self.webView){
        [webView stringByEvaluatingJavaScriptFromString:@"window.open = function (url, d1, d2, d3, title, callback){ window.native_window_title = title; window.native_window_closed_callback = callback; window.location.assign('open://' + url); }"];
        [self.webView stringByEvaluatingJavaScriptFromString:@"login()"];
    }
    
    if(webView == self.webView2){
        [webView stringByEvaluatingJavaScriptFromString:@"window.close = function (){ window.location.assign('close://' + window.location); }"];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    NSLog(@"Loading URL: %@", request.URL);
    NSString *scheme = request.URL.scheme;
    
    if(webView == self.webView){
        if([scheme isEqualToString:@"open"]){
            NSURL *url = request.URL;
            url = [NSURL URLWithString:[url.absoluteString stringByReplacingOccurrencesOfString:@"open://http//" withString:@"http://"]];
            url = [NSURL URLWithString:[url.absoluteString stringByReplacingOccurrencesOfString:@"open://https//" withString:@"https://"]];
            
            [self.webView2 loadRequest:[NSURLRequest requestWithURL:url]];
            
            return NO;
        }
        
        if([scheme isEqualToString:@"ready"]){
            NSString *response = [self.webView stringByEvaluatingJavaScriptFromString:@"getResponse()"];
            NSData *responseData = [response dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
            
            SALoginViewController *vc = (SALoginViewController *) self.navigationController;
            
            if([responseDict valueForKey:@"error"] != nil){
                NSString *error = [responseDict valueForKey:@"error"];
                [vc.delegate loginViewController:vc didFailWithError:error];
            }else{
                NSString *token = [responseDict valueForKey:@"token"];
                [vc.delegate loginViewController:vc didSucceedWithToken:token];
            }
            
            [self dismiss];

            return NO;
        }
    }

    if(webView == self.webView2){
        if([scheme isEqualToString:@"close"]){
            [self.webView stringByEvaluatingJavaScriptFromString:@"window.native_window_closed_callback()"];
            return NO;
        }
    }
    
    return YES;
}

@end
