//
//  EditParticipantViewController.h
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-23.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "EditProfileViewController.h"

@interface EditParticipantViewController : UIViewController
{
    IBOutlet UITextField *tfFirstname;
    IBOutlet UITextField *tfLastname;
    IBOutlet UITextField *tfAge;
    IBOutlet UITextField *tfGender;
    IBOutlet UITextField *tfDiagnosis;
    IBOutlet UITextField *tfProgramOfInterest;
    IBOutlet UITextView *tvNotes;
    
    IBOutlet UIStackView *stackView;
    IBOutlet UIScrollView *scrollView;

    AppDelegate *mainDelegate;
}
@property (assign) CGPoint rememberContentOffset;

@property(strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end
