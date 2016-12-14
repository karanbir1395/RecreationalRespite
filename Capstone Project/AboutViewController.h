//
//  AboutViewController.h
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-13.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *aboutWebView;
    NSString *recrespiteLink;
    IBOutlet UIActivityIndicatorView *activityIndicator;

}

@property(strong, nonatomic) IBOutlet UIWebView *aboutWebView;

@end
