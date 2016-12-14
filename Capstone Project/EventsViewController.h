//
//  EventsViewController.h
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-04.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface EventsViewController : UIViewController
{
    IBOutlet UITextField *tfName;
    IBOutlet UITextView *tvDescription;
    IBOutlet UITextField *tfDate;
    IBOutlet UITextField *tfStartTime;
    IBOutlet UITextField *tfEndTime;
    IBOutlet UITextField *tfAddress;
    IBOutlet UITextField *tfSeatsLeft;
    IBOutlet UITextField *tfCost;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UITextField *tfDescription;
    
    IBOutlet UIImageView *imgView;
    
    AppDelegate *mainDelegate;
    
}

@property (assign) CGPoint rememberContentOffset;

@property(strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property(strong, nonatomic) IBOutlet UITextField *tfName;
@property(strong, nonatomic) IBOutlet UITextView *tvDescription;
@property(strong, nonatomic) IBOutlet UITextField *tfDate;
@property(strong, nonatomic) IBOutlet UITextField *tfStartTime;
@property(strong, nonatomic) IBOutlet UITextField *tfEndTime;
@property(strong, nonatomic) IBOutlet UITextField *tfAddress;
@property(strong, nonatomic) IBOutlet UITextField *tfSeatsLeft;
@property(strong, nonatomic) IBOutlet UITextField *tfCost;

@end
