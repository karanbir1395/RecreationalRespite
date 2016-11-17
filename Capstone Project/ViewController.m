//
//  ViewController.m
//  Capstone Project
//
//  Created by iOS Xcode User on 2016-03-19.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)onClickLogin:(id)sender
{
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    mainDelegate.usernameLoggedIn = @"mannkara";
    
    HomePageViewController *homePageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homePageViewController"];
    
    [self presentViewController:homePageViewController animated:YES completion:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
