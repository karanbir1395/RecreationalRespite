//
//  EditParticipantViewController.m
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-23.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "EditParticipantViewController.h"

@interface EditParticipantViewController ()

@end

@implementation EditParticipantViewController
@synthesize scrollView, rememberContentOffset;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [scrollView setScrollEnabled:YES];
    
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    
    float sizeOfContent = 0;
    UIView *lLast = [scrollView.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    
    sizeOfContent = wd+ht;
    
    [scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width *1, sizeOfContent)];
    [self setTextboxLayout];
    [self populateTextboxes];
}

//SCROLL VIEW METHODS

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    self.scrollView.contentOffset = CGPointMake(0, 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    self.rememberContentOffset = self.scrollView.contentOffset;
    [super viewWillDisappear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.contentOffset = CGPointMake(0, self.rememberContentOffset.y);
}


//Setting the layout of text boxes
-(void) setTextboxLayout
{
    
    [stackView setNeedsLayout];
    [stackView layoutIfNeeded];
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = [UIColor  lightGrayColor].CGColor;
    border.borderWidth = borderWidth;
    border.frame = CGRectMake(0, tfFirstname.bounds.size.height - borderWidth, tfFirstname.bounds.size.width -15, tfFirstname.bounds.size.height);
    [tfFirstname.layer addSublayer:border];
    tfFirstname.layer.masksToBounds = YES;
    
    CALayer *border2 = [CALayer layer];
    border2.borderColor = [UIColor  lightGrayColor].CGColor;
    border2.borderWidth = borderWidth;
    border2.frame = CGRectMake(0, tfLastname.frame.size.height - borderWidth, tfLastname.frame.size.width-15, tfLastname.frame.size.height);
    [tfLastname.layer addSublayer:border2];
    tfLastname.layer.masksToBounds = YES;
    
    CALayer *border3 = [CALayer layer];
    border3.borderColor = [UIColor  lightGrayColor].CGColor;
    border3.borderWidth = borderWidth;
    border3.frame = CGRectMake(0, tfAge.frame.size.height - borderWidth, tfAge.frame.size.width-15, tfAge.frame.size.height);
    [tfAge.layer addSublayer:border3];
    tfAge.layer.masksToBounds = YES;
    
    CALayer *border4 = [CALayer layer];
    border4.borderColor = [UIColor  lightGrayColor].CGColor;
    border4.borderWidth = borderWidth;
    border4.frame = CGRectMake(0, tfGender.frame.size.height - borderWidth, tfGender.frame.size.width-15, tfGender.frame.size.height);
    [tfGender.layer addSublayer:border4];
    tfGender.layer.masksToBounds = YES;
    
    CALayer *border5 = [CALayer layer];
    border5.borderColor = [UIColor  lightGrayColor].CGColor;
    border5.borderWidth = borderWidth;
    border5.frame = CGRectMake(0, tfDiagnosis.frame.size.height - borderWidth, tfDiagnosis.frame.size.width-15, tfDiagnosis.frame.size.height);
    [tfDiagnosis.layer addSublayer:border5];
    tfDiagnosis.layer.masksToBounds = YES;
    
    CALayer *border6 = [CALayer layer];
    border6.borderColor = [UIColor  lightGrayColor].CGColor;
    border6.borderWidth = borderWidth;
    border6.frame = CGRectMake(0, tfProgramOfInterest.frame.size.height - borderWidth, tfProgramOfInterest.frame.size.width-15, tfProgramOfInterest.frame.size.height);
    [tfProgramOfInterest.layer addSublayer:border6];
    tfProgramOfInterest.layer.masksToBounds = YES;
    
}

//Seeting values for text fields
-(void)populateTextboxes
{
    tfFirstname.text = mainDelegate.passEditParticipantFirstname;
    tfLastname.text = mainDelegate.passEditParticipantLastname;
    tfAge.text = mainDelegate.passEditParticipantAge;
    tfGender.text = mainDelegate.passEditParticipantGender;
    tfDiagnosis.text = mainDelegate.passEditParticipantDiagnosis;
    tfProgramOfInterest.text = mainDelegate.passEditParticipantProgramOfInterest;
    tvNotes.text = mainDelegate.passEditParticipantNotes;
}

//Executed when save button is clicked
-(IBAction)onClickSaveButton:(id)sender
{
    NSString *username = mainDelegate.usernameLoggedIn;
    NSString *participantNodeId = mainDelegate.passEditParticipantNodeId;
    
    NSString *urlString = [NSString stringWithFormat:@"https://recrespite-3c13b.firebaseio.com/UserInformation/%@/participants/%@.json",username, participantNodeId];
    
    
    NSLog(@"URL is %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    NSDictionary *postJSON = [[NSMutableDictionary alloc]init];
    [postJSON setValue:tfFirstname.text forKey:@"firstname"];
    [postJSON setValue:tfLastname.text forKey:@"lastname"];
    [postJSON setValue:tfGender.text forKey:@"gender"];
    [postJSON setValue:tfAge.text forKey:@"age"];
    [postJSON setValue:tfDiagnosis.text forKey:@"diagnosis"];
    [postJSON setValue:tfProgramOfInterest.text forKey:@"program"];
    [postJSON setValue:tvNotes.text forKey:@"notes"];
    
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:postJSON
                                                       options:NSJSONWritingPrettyPrinted error:NULL];
    
    
    [request setHTTPMethod:@"PATCH"];
    
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
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController * alert=   [UIAlertController
                                                  alertControllerWithTitle:@"Success!"
                                                  message:@"Participant was saved."
                                                  preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* ok = [UIAlertAction
                                         actionWithTitle:@"Ok"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action)
                                         {
                                             [alert dismissViewControllerAnimated:YES completion:nil];
                                             
                                             EditProfileViewController *editProfileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"editProfileViewController"];
                                             
                                             [self presentViewController:editProfileViewController animated:YES completion: nil];
                                             
                                         }];
                    
                    [alert addAction:ok];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                });
                
                
            });
            
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:@"Failed!"
                                              message:@"Participant was not saved."
                                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"Ok"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                         
                                         EditProfileViewController *editProfileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"editProfileViewController"];
                                         
                                         [self presentViewController:editProfileViewController animated:YES completion: nil];
                                         
                                     }];
                
                [alert addAction:ok];
                
                [self presentViewController:alert animated:YES completion:nil];
            });
            
            
        }
        
    }] resume];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
