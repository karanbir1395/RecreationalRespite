//
//  UserCategoriesViewController.h
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-21.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCategoriesViewController : UIViewController
{
    IBOutlet UIScrollView *scrollView;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (assign) CGPoint rememberContentOffset;

@end
