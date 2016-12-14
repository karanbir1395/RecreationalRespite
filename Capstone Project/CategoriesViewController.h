//
//  CategoriesViewController.h
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-12-07.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiteCell.h"
#import "AppDelegate.h"
#import "LibraryViewController.h"

@interface CategoriesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tableView;
    NSMutableArray *arrayCategories;
    AppDelegate *mainDelegate;
}
@property(strong, nonatomic) IBOutlet UITableView *tableView;

@end
