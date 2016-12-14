//
//  OpenBrochureViewController.h
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-12-08.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface OpenBrochureViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    AppDelegate *mainDelegate;
}
@property(strong, nonatomic) IBOutlet UIWebView *webView;

@end
