//
//  RequestEventEmailViewController.m
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-12-13.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "RequestEventEmailViewController.h"

@interface RequestEventEmailViewController ()

@end

@implementation RequestEventEmailViewController

//View Did Load Method executed
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail]) {
        mc.mailComposeDelegate = self;
        [mc setSubject:@"Request Event"];
        
        [mc setMessageBody:@"1. Event Location: \n \n \n2. Event Description: \n \n \n3. Notes: \n"                                           isHTML:NO];
        
        [mc setToRecipients:@[@"recreactive@recrespite.com"]];
        
        [self presentViewController:mc animated:YES completion:NULL];
    }
    
}


//Handle Email actions for send, cancel, delete, error
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
        {  NSLog(@"Mail cancelled");
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            
        }
            break;
        case MFMailComposeResultSaved:
        {  NSLog(@"Mail saved");
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
            break;
        case MFMailComposeResultSent:
        {            NSLog(@"Mail sent");
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }   break;
        case MFMailComposeResultFailed:
        {            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }   break;
        default:
        {
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
