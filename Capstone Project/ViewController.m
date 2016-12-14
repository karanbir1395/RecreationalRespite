//
//  ViewController.m
//  Capstone Project
//
//  Created by iOS Xcode User on 2016-03-19.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
     mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    }

-(void) viewDidAppear:(BOOL)animated
{
    [self homeScreen];
   
}



-(void) homeScreen
{
    NSString *isUserLoggedIn = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];

    if(![isUserLoggedIn isEqualToString:@""])
    {

        mainDelegate.usernameLoggedIn = isUserLoggedIn;
    HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeViewController"];
    
    [self presentViewController:homeViewController animated:YES completion:nil];
    
    }

}

-(IBAction)onClickLogin:(id)sender
{
    
    [self checkUsernameAndSaveFromFirebase];
    
}

-(void)checkUsernameAndSaveFromFirebase
{
    NSString *username = txtUsername.text;
    
    NSString *fullRequestUrl = [NSString stringWithFormat:@"https://recrespite-3c13b.firebaseio.com/UserInformation/%@.json",username];
    
    
    NSURL *url = [NSURL URLWithString:fullRequestUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     
     {
         if (data.length > 0 && connectionError == nil)
             
         {
             
             NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSString *str =  [NSString stringWithFormat:@"[%@]",
                               responseString];
             NSData* data2 = [str dataUsingEncoding:NSUTF8StringEncoding];
             
             
             NSArray *jsonArray = [[NSMutableArray alloc] init];
             jsonArray = [NSJSONSerialization JSONObjectWithData: data2 options:NSJSONReadingMutableContainers error:nil];
             
             NSLog(@"Array object %@", jsonArray);
             
             
             
             
             NSDictionary *dict=[jsonArray objectAtIndex:0];
             
             
                mainDelegate.passUserPhone_Regis = [dict valueForKey:@"phoneNumber"];
             
              mainDelegate.passUserEmail_Regis = [dict valueForKey:@"email"];
             
             mainDelegate.passUserLoggedInPhone=mainDelegate.passUserPhone_Regis;
             mainDelegate.passUserLoggedInEmail=mainDelegate.passUserEmail_Regis;

             
             if([responseString  isEqual: @"null"] || [username  isEqual: @""])
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     UIAlertController * alert=   [UIAlertController
                                                   alertControllerWithTitle:@"Error!"
                                                   message:@"Username does not exist, please try again."
                                                   preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction* ok = [UIAlertAction
                                          actionWithTitle:@"Try Again"
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action)
                                          {
                                              [alert dismissViewControllerAnimated:YES completion:nil];
                                             
                                          }];
                     
                     [alert addAction:ok];
                     
                     [self presentViewController:alert animated:YES completion:nil];
                 });

             }
             else
             {
                 mainDelegate.usernameLoggedIn = username;
                 mainDelegate.passUserLoggedInPhone=mainDelegate.passUserPhone_Regis;
                 mainDelegate.passUserLoggedInEmail=mainDelegate.passUserEmail_Regis;
                 
                 [[NSUserDefaults standardUserDefaults] setValue:txtUsername.text forKey:@"username"];
                
                 [[NSUserDefaults standardUserDefaults] synchronize];
               
                 HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeViewController"];
                 
                 [self presentViewController:homeViewController animated:YES completion:nil];
                 
             }
         }
         
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
