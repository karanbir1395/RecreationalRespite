//
//  PDFLibraryViewController.m
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-02.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "PDFLibraryViewController.h"

@interface PDFLibraryViewController ()

@end

@implementation PDFLibraryViewController
@synthesize pdfWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self openPDF];
}


-(void) webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicator startAnimating];
    
}

-(void) webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
    
}

-(void) openPDF
{
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    pdfLink =  mainDelegate.passSelectedArticleFromLibrary;
    NSLog(@"PDF link is %@", pdfLink);
    NSURL *targetURL = [NSURL URLWithString:pdfLink];
 
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [pdfWebView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
