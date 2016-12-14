//
//  ParticipantInformationViewController.h
//  Capstone Project
//
//  Created by iOS Xcode User on 2016-03-24.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"

@interface ParticipantInformationViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource,  UITableViewDelegate>
{
    IBOutlet UIPickerView *pvGender;
    NSArray *gender;
    IBOutlet UITextField *tfFirstName;
    IBOutlet UITextField *tfLastName;
    IBOutlet UITextField *tfAge;
    IBOutlet UITextField *tfDiagnosis;
    IBOutlet UITextField *tfProgram;
    IBOutlet UITextField *tfGender;
    IBOutlet UILabel *lblParticipants;
    IBOutlet UIPickerView *pickerGender;
    IBOutlet UIButton *btnCreateProfile;
    IBOutlet UITextView *tvNotes;
    NSMutableArray *names;
    NSArray *arrayGender;
    AppDelegate *mainDelegate;
    int count;
}
@property(nonatomic, strong) IBOutlet UIPickerView *pvGender;
@property(nonatomic, strong) NSArray *gender;
@property(strong, nonatomic) NSMutableArray *names;
@property(strong, nonatomic) IBOutlet UITextField *tfFirstName;
@property(strong, nonatomic) IBOutlet UITextField *tfLastName;
@property(strong, nonatomic) IBOutlet UITextField *tfAge;
@property(strong, nonatomic) IBOutlet UITextField *tfDiagnosis;
@property(strong, nonatomic) IBOutlet UITextField *tfProgram;
@property(strong, nonatomic) IBOutlet UITextField *tfGender;
@property(strong, nonatomic) IBOutlet UILabel *lblParticipants;
@property(strong, nonatomic) IBOutlet UIPickerView *pickerGender;
@property(strong, nonatomic) IBOutlet UIButton *btnCreateProfile;
@property (strong, nonatomic)IBOutlet UITextView *tvNotes;
@property(strong, nonatomic) NSArray *arrayGender;
@property(strong, nonatomic) NSString *username;


@end
