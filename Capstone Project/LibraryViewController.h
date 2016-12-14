//
//  LibraryViewController.h
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-02.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiteCell.h"
#import "SiteCellHome.h"
#import "AppDelegate.h"
#import "PDFLibraryViewController.h"
#import "CategoriesViewController.h"

@interface LibraryViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *arrayPhotos;
    NSMutableArray *arrayArticleName;
    NSMutableArray *arrayArticlePDF;
    NSArray *searchResults;
    NSArray *searchPDFResults;
    IBOutlet UITableView *libraryTableView;
    AppDelegate *mainDelegate;
    NSString *selectedArticleName;
    

}
@property(strong, nonatomic) NSMutableArray *arrayPhotos;
@property(strong, nonatomic) NSMutableArray *arrayArticleName;
@property(strong, nonatomic) NSMutableArray *arrayArticlePDF;
@property(strong, nonatomic) IBOutlet UITableView *libraryTableView;

@end
