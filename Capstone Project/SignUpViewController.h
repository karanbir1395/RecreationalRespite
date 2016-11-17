//
//  SignUpViewController.h
//  Capstone Project
//
//  Created by iOS Xcode User on 2016-03-24.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParticipantInformationViewController.h"
#import "AppDelegate.h"

@interface SignUpViewController : UIViewController <UITableViewDataSource,  UITableViewDelegate,UIDataSourceModelAssociation>

{
    IBOutlet UITextField *tfCity;
     IBOutlet UITextField *tfFirstName;
     IBOutlet UITextField *tfLastName;
    IBOutlet UITextField *tfUsername;
     IBOutlet UITextField *tfPhoneNumber;
    IBOutlet UITextField *tfEmail;
    IBOutlet UITextField *tfRegion;
    IBOutlet UIPickerView *pickerRegion;
    
    IBOutlet UILabel *lblAsterisk;
    IBOutlet UILabel *lblUsernameError;
    
    NSArray *arrayRegion;
}

@property(nonatomic, strong) IBOutlet UITextField *tfFirstName;
@property(nonatomic, strong) IBOutlet UITextField *tfLastName;
@property(nonatomic, strong) IBOutlet UITextField *tfUsername;
@property(nonatomic, strong) IBOutlet UITextField *tfPhoneNumber;
@property(nonatomic, strong) IBOutlet UITextField *tfCity;
@property(nonatomic, strong) IBOutlet UITextField *tfEmail;
@property(nonatomic, strong) IBOutlet UITextField *tfRegion;
@property(nonatomic, strong) IBOutlet UIPickerView *pickerRegion;
@property(nonatomic, strong) IBOutlet NSArray *arrayRegion;
@property (nonatomic, strong) IBOutlet UILabel *lblAsterisk;
@property(nonatomic, strong) IBOutlet UILabel *lblUsernameError;


@end
