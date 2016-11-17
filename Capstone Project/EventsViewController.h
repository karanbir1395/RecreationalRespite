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
    IBOutlet UILabel *lblName;
    IBOutlet UILabel *lblDescription;
    IBOutlet UILabel *lblDate;
    IBOutlet UILabel *lblStartTime;
    IBOutlet UILabel *lblEndTime;
    IBOutlet UILabel *lblAddress;
    IBOutlet UILabel *lblSeatsLeft;
    
    IBOutlet UIImageView *imgView;

}

@property(strong, nonatomic) IBOutlet UILabel *lblName;
@property(strong, nonatomic) IBOutlet UILabel *lblDescription;
@property(strong, nonatomic) IBOutlet UILabel *lblDate;
@property(strong, nonatomic) IBOutlet UILabel *lblStartTime;
@property(strong, nonatomic) IBOutlet UILabel *lblEndTime;
@property(strong, nonatomic) IBOutlet UILabel *lblAddress;
@property(strong, nonatomic) IBOutlet UILabel *lblSeatsLeft;

@end
