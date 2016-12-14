//
//  ViewController.h
//  Capstone Project
//
//  Created by iOS Xcode User on 2016-03-19.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "HomeViewController.h"
#import <Security/Security.h>

@interface ViewController : UIViewController
{
    IBOutlet UITextField *txtUsername;
    
    AppDelegate *mainDelegate;
}


@end

