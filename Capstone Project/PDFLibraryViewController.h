//
//  PDFLibraryViewController.h
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-02.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface PDFLibraryViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *pdfWebView;
    NSMutableArray *arrayPdfLinks;
    NSString *pdfLink;
    IBOutlet UIActivityIndicatorView *activityIndicator;

}

@property(strong, nonatomic) IBOutlet UIWebView *pdfWebView;
@property(strong, nonatomic) IBOutlet NSMutableArray *arrayPdfLinks;
@property(strong, nonatomic) NSString *pdfLink;;
@end
