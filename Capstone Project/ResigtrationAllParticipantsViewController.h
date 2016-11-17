//
//  ResigtrationAllParticipantsViewController.h
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-15.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "RegistrationViewController.h"

@interface ResigtrationAllParticipantsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tableView;
    NSMutableArray *arrayParticipants;
    NSMutableArray *arrayParticipantAge;
    

}

@property(strong, nonatomic) IBOutlet UITableView *tableView;


@end
