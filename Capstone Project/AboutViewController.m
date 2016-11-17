//
//  AboutViewController.m
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-13.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize aboutWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self openPDF];
}

-(void) openPDF
{
    
    recrespiteLink =  @"http://recrespite.com/about-us/";

    NSURL *targetURL = [NSURL URLWithString:recrespiteLink];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [aboutWebView loadRequest:request];
    
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
