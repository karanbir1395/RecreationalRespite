//
//  UserCategoriesViewController.m
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-21.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "UserCategoriesViewController.h"

@interface UserCategoriesViewController ()

@end

@implementation UserCategoriesViewController
@synthesize scrollView,rememberContentOffset;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [scrollView setScrollEnabled:YES];
}


//SCROLL VIEW METHODS
- (void) viewDidAppear:(BOOL)animated {
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width *1, self.view.frame.size.height *3.1)];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    self.scrollView.contentOffset = CGPointMake(0, 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    self.rememberContentOffset = self.scrollView.contentOffset;
    [super viewWillDisappear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.contentOffset = CGPointMake(0, self.rememberContentOffset.y);
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
