//
//  AllEventsViewController.h
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-13.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsViewController.h"
#import "SiteCell.h"

@interface AllEventsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tableView;
    
    NSMutableArray *arrayEventAddress;
    NSMutableArray *arrayEventName;
    NSMutableArray *arrayEventPhotos;
    NSMutableArray *arrayEventDescription;
    NSMutableArray *arrayEventDate;
    NSMutableArray *arrayEventStartTime;
    NSMutableArray *arrayEventEndTime;
    NSMutableArray *arrayEventSeats;
}

@property(strong, nonatomic) IBOutlet UITableView *tableView;
@end
