//
//  HomeViewController.h
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-12-06.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiteCellHome.h"
#import "EditProfileViewController.h"
#import "LibraryViewController.h"
#import "ViewController.h"
#import "CategoriesViewController.h"
#import "OneToOneViewController.h"
#import "RegionViewController.h"
#import "RequestEventEmailViewController.h"

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tableView;
    NSMutableArray *arrayItems;
    NSMutableArray *arrayItemImages;
}

@property(strong, nonatomic) IBOutlet UITableView *tableView;
@end
