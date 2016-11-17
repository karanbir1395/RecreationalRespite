//
//  RegistrationViewController.m
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-05.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController
@synthesize scrollView, rememberContentOffset,tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [scrollView setScrollEnabled:YES];

    [txtAllergies setDelegate:self];
    [txtAge setDelegate:self];
    [txtName setDelegate:self];
    [txtEmail setDelegate:self];
    [txtPhone setDelegate:self];
    [txtLocation setDelegate:self];
    [txtPaymentType setDelegate:self];
    [txtSpecialNeeds setDelegate:self];
    [txtEmergencyPhone setDelegate:self];
    [txtExpectationsAndGoals setDelegate:self];
    [txtRecreationalInterest setDelegate:self];
    [txtProgramOfInterest setDelegate:self];
    
    
    [self populateTextboxes];
    
}

-(void) populateTextboxes
{
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    txtName.text = mainDelegate.passParticipantName_Regis;
    txtAge.text = mainDelegate.passParticipantAge_Regis;
    txtEmail.text = mainDelegate.passUserEmail_Regis;
    txtPhone.text = mainDelegate.passUserPhone_Regis;
    txtLocation.text = mainDelegate.passEventAddress;
    lblEventName.text = mainDelegate.passEventName;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    
    return YES;
}


-(IBAction)onClickRegister:(id)sender
{
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    NSString *eventId = mainDelegate.passEventId;
    NSString *participantName = txtName.text;
    NSString *username = mainDelegate.usernameLoggedIn;
    
    NSString *urlString = [NSString stringWithFormat:@"https://recrespite-3c13b.firebaseio.com/events/events/%@/registration/%@.json",eventId,participantName];
    
    
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    NSDictionary *postJSON = [[NSMutableDictionary alloc]init];
    [postJSON setValue:txtName.text forKey:@"name"];
    [postJSON setValue:txtEmail.text forKey:@"email"];
    [postJSON setValue:txtPhone.text forKey:@"phone"];
    [postJSON setValue:txtAge.text forKey:@"age"];
    [postJSON setValue:txtLocation.text forKey:@"location"];
    [postJSON setValue:txtEmergencyPhone.text forKey:@"emergencyPhone"];
    [postJSON setValue:txtProgramOfInterest.text forKey:@"programOfInterest"];
    [postJSON setValue:txtPaymentType.text forKey:@"paymentType"];
    [postJSON setValue:txtRecreationalInterest.text forKey:@"recreationalInterest"];
    [postJSON setValue:txtExpectationsAndGoals.text forKey:@"expectationsAndGoals"];
    [postJSON setValue:txtAllergies.text forKey:@"allergies"];
    [postJSON setValue:txtSpecialNeeds.text forKey:@"specialNeeds"];
    [postJSON setValue:username forKey:@"username"];


    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:postJSON
                                                       options:NSJSONWritingPrettyPrinted error:NULL];
    
    
    [request setHTTPMethod:@"PUT"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: jsonData];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
        
        if(![requestReply containsString:@"error"])
        {
            //DISPATCH_ASYNC IS USED BECAUSE WE SHOULD ALWAYS UPDATE UI FROM MAIN THREAD
            dispatch_async(dispatch_get_main_queue(), ^{
                
                HomePageViewController *homePageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homePageViewController"];
                
                [self presentViewController:homePageViewController animated:YES completion:nil];
                
            });
            
        }
        else
        {
            NSLog(@"Error inserting new object");
        }
    }] resume];
    

}



//SCROLL VIEW METHODS
- (void) viewDidAppear:(BOOL)animated {
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width *1, self.view.frame.size.height *1.45)];
   

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    [self registerForKeyboardNotifications];
    self.scrollView.contentOffset = CGPointMake(0, 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [self deregisterFromKeyboardNotifications];
       self.rememberContentOffset = self.scrollView.contentOffset;
    [super viewWillDisappear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.contentOffset = CGPointMake(0, self.rememberContentOffset.y);
}



//KEYBOARD MOVE UP METHODS

- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}


-(void)keyboardWasShown:(NSNotification *)notification {
    
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width *1, self.view.frame.size.height *1.73)];

    NSDictionary* info = [notification userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGPoint buttonOrigin = txtAllergies.frame.origin;
    
    CGFloat buttonHeight = txtAllergies.frame.size.height;
    
    CGRect visibleRect = self.view.frame;
    
    visibleRect.size.height -= keyboardSize.height;
    
   /* if (!CGRectContainsPoint(visibleRect, buttonOrigin)){
        
        CGPoint scrollPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight);
        
        [self.scrollView setContentOffset:scrollPoint animated:YES];
        
    }*/
    if( [txtRecreationalInterest isFirstResponder] || [txtExpectationsAndGoals isFirstResponder] || [txtAllergies isFirstResponder] || [txtSpecialNeeds isFirstResponder])
    {
       // CGRect f = self.view.frame;
        //f.origin.y = -keyboardSize.height;
        //self.scrollView.frame = f;
        
       [UIView animateWithDuration:0.0010 animations:^{
        self.scrollView.contentOffset = CGPointMake(0,txtRecreationalInterest.frame.origin.y);
       }];
        
    }
    
    if( [txtLocation isFirstResponder] || [txtEmergencyPhone isFirstResponder] || [txtProgramOfInterest isFirstResponder] || [txtPaymentType isFirstResponder])
    {
        // CGRect f = self.view.frame;
        //f.origin.y = -keyboardSize.height;
        //self.scrollView.frame = f;
        
        [UIView animateWithDuration:0.0010 animations:^{
            self.scrollView.contentOffset = CGPointMake(0,txtLocation.frame.origin.y);
        }];
        
    }

}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    
   // [scrollView setContentSize:CGSizeMake(self.view.frame.size.width *1, self.view.frame.size.height*1.45)];
    self.scrollView.contentOffset = CGPointMake(0, 0);
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width *1, self.view.frame.size.height*1.45)];
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
