//
//  RegionViewController.h
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-12-08.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AllEventsViewController.h"
#import "SiteCell.h"

@interface RegionViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tableView;
    AppDelegate *mainDelegate;
    NSMutableArray *arrayRegionName;
    NSArray *searchResults;
    
    NSString *selectedRegion;
    
}
@property(strong, nonatomic) IBOutlet UITableView *tableView;

@end
