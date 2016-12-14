//
//  OpenBrochureViewController.m
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-12-08.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "OpenBrochureViewController.h"

@interface OpenBrochureViewController ()

@end

@implementation OpenBrochureViewController
@synthesize webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self openPDF];
}

//Executed when Web View is loaded
-(void) webViewDidStartLoad:(UIWebView *)webView
{
    
    [activityIndicator startAnimating];
    
}

//Executed when web view stopped loading
-(void) webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
    
}

//Open PDF in Web View
-(void) openPDF
{
    
    NSString *pdfLink =  mainDelegate.passOneToOneLink;
    
    NSURL *targetURL = [NSURL URLWithString:pdfLink];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [webView loadRequest:request];
    
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
