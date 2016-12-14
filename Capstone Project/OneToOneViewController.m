//
//  OneToOneViewController.m
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-12-07.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "OneToOneViewController.h"

@interface OneToOneViewController ()

@end

@implementation OneToOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
}

//on Click Young Adults button
-(IBAction)btnClickYoungAdults:(id)sender
{
    mainDelegate.passOneToOneLink = @"http://recrespite.com/wp-content/uploads/2011/02/RR-YOUNG-ADULTS-3.pdf";
    
    OpenBrochureViewController *openBrochureViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"openBrochureViewController"];
    
    [self presentViewController:openBrochureViewController animated:YES completion:nil];
}

//on Click Adults button
-(IBAction)btnAdults:(id)sender
{
    mainDelegate.passOneToOneLink = @"http://recrespite.com/wp-content/uploads/2011/02/RR-ADULTS-AND-OLDER-ADULTS-full-page.pdf";
    OpenBrochureViewController *openBrochureViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"openBrochureViewController"];
    
    [self presentViewController:openBrochureViewController animated:YES completion:nil];
}

//on Click Children and Youth button
-(IBAction)btnChildrenAndYouth:(id)sender
{
    mainDelegate.passOneToOneLink = @"http://recrespite.com/wp-content/uploads/2011/02/RR-CHILDREN-AND-YOUTH-full-page.pdf";
    
    OpenBrochureViewController *openBrochureViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"openBrochureViewController"];
    
    [self presentViewController:openBrochureViewController animated:YES completion:nil];
}

//on Click Mental Health button
-(IBAction)btnMentalHealth:(id)sender
{
    mainDelegate.passOneToOneLink = @"http://recrespite.com/wp-content/uploads/2011/02/RR-MENTAL-HEALTH-full-page.pdf";
    
    OpenBrochureViewController *openBrochureViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"openBrochureViewController"];
    
    [self presentViewController:openBrochureViewController animated:YES completion:nil];
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
