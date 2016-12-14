//
//  HomePageViewController.h
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-09-10.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "EventsViewController.h"
#import "PDFLibraryViewController.h"
#import "ViewController.h"

@interface HomePageViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIScrollView *ScrollViewHorizontal;
    NSMutableArray *arrayArticlePhotos;
    NSMutableArray *arrayArticleNames;
    NSMutableArray *arrayArticleId;
    NSMutableArray *arrayArticlePDF;
    NSMutableArray *arrayEventAddress;
    NSMutableArray *arrayEventName;
    NSMutableArray *arrayEventPhotos;
    NSMutableArray *arrayEventDescription;
    NSMutableArray *arrayEventDate;
    NSMutableArray *arrayEventStartTime;
    NSMutableArray *arrayEventEndTime;
    NSMutableArray *arrayEventSeats;
    NSMutableArray *arrayEventId;
    NSMutableArray *arrayEventCost;

    IBOutlet UIActivityIndicatorView *activityIndicator;
    
    IBOutlet UIBarButtonItem *btnLibrary;
    IBOutlet UITableView *tableView;
}

@property(nonatomic, strong) UIScrollView *ScrollViewHorizontal;
@property(nonatomic, strong) UIBarButtonItem *btnLibrary;
@property(nonatomic, strong ) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic,strong) UITableView *tableView;

@end
