//
//  RegistrationViewController.h
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-05.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiteCell.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "ResigtrationAllParticipantsViewController.h"

@interface RegistrationViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIButton *btnRegister;
    IBOutlet UITextField *txtName;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtPhone;
    IBOutlet UITextField *txtAge;
    IBOutlet UITextField *txtLocation;
    IBOutlet UITextField *txtEmergencyPhone;
    IBOutlet UITextField *txtProgramOfInterest;
    IBOutlet UITextField *txtPaymentType;
    IBOutlet UITextField *txtRecreationalInterest;
    IBOutlet UITextField *txtExpectationsAndGoals;
    IBOutlet UITextField *txtAllergies;
    IBOutlet UITextField *txtSpecialNeeds;
    IBOutlet UITableView *tableView;
    IBOutlet UILabel *lblEventName;
    NSMutableArray *arrayParticipants;

}
@property(strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property(strong, nonatomic) IBOutlet UITableView *tableView;
@property (assign) CGPoint rememberContentOffset;

@end
