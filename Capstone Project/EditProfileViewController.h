//
//  EditProfileViewController.h
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-13.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SiteCell.h"
#import "EditParticipantViewController.h"

@interface EditProfileViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

{
    IBOutlet UIScrollView *scrollView;

    IBOutlet UITextField *tfUsername;
    IBOutlet UITextField *tfFirstName;
    IBOutlet UITextField *tfLastName;
    IBOutlet UITextField *tfEmail;
    IBOutlet UITextField *tfPhoneNumber;
    IBOutlet UITextField *tfCity;
    IBOutlet UITextField *tfRegion;

    IBOutlet UITableView *tableView;
    IBOutlet UIStackView *stackView;

    NSMutableArray *arrayParticipantNames;
    NSMutableArray *arrayParticipantLastname;
    NSMutableArray *arrayParticipantAge;
    NSMutableArray *arrayParticipantGender;
    NSMutableArray *arrayParticipantDiagnosis;
    NSMutableArray *arrayParticipantProgramOfInterest;
    NSMutableArray *arrayParticipantNotes;
    NSMutableArray *arrayParticipantNodeId;
    
    AppDelegate *mainDelegate;
   
    
}

@property(strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property(strong, nonatomic) IBOutlet UITableView *tableView;
@property (assign) CGPoint rememberContentOffset;

@end
