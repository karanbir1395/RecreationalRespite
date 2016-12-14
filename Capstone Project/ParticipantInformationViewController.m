//
//  ParticipantInformationViewController.m
//  Capstone Project
//
//  Created by iOS Xcode User on 2016-03-24.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "ParticipantInformationViewController.h"

@interface ParticipantInformationViewController ()

@end

@implementation ParticipantInformationViewController
@synthesize pvGender, gender, names, tfFirstName, tfLastName, tfAge, tfDiagnosis, tfProgram, lblParticipants, tfGender, pickerGender, arrayGender, btnCreateProfile, tvNotes,username;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    self.pickerGender = [[UIPickerView alloc] initWithFrame:CGRectZero];

     [tfFirstName setDelegate: self];
    [tfLastName setDelegate: self];
    [tfAge setDelegate: self];
    [tfDiagnosis setDelegate: self];
    [tfProgram setDelegate: self];
    [tfLastName setDelegate: self];
    [tfGender setDelegate: self];
    [pickerGender setDelegate:self];
    [tvNotes setDelegate:self];
    
    //Setting gender picker view from bottom
    self.tfGender.inputView = self.pickerGender;
    NSArray *a = [[NSArray alloc]initWithObjects:@"Male", @"Female", nil];
    
    self.arrayGender = a;
    
    names = [[NSMutableArray alloc] init];
    
    lblParticipants.hidden = YES;
    

}


#pragma picker Methods

-(NSInteger) pickerView: (UIPickerView*) pickerView numberOfRowsInComponent:(NSInteger)component
{
    return  [arrayGender count];
}

-(NSInteger) numberOfComponentsInPickerview: (UIPickerView *) pickerView
{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [arrayGender objectAtIndex:row];
    
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if([touch view] != pickerGender)
    {
        int row =[self.pickerGender selectedRowInComponent:0];
        tfGender.text = [arrayGender objectAtIndex:row ];
        [[self view] endEditing:YES];
    }
}


//disable keyboard from text view
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

//to disable keyboard from text field
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

//CREATE PROFILE BUTTON IS PRESSED - PARTICIPANT SAVED TO DATABASE
-(IBAction)CreateProfileButtonPressed:(id)sender
{
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    username = mainDelegate.passUsernametoNextScreen;
    NSLog(@"username is %@", username);
    
    mainDelegate.usernameLoggedIn = username;
    
    NSString *firstName = tfFirstName.text;
    NSString *lastName = tfLastName.text;
    NSString *age = tfAge.text;
    NSString *diagnosis = tfDiagnosis.text;
    NSString *gender = tfGender.text;
    NSString *notes = tvNotes.text;
    NSString *programOfInterest = tfProgram.text;
    
    NSString *fullRequestUrl = [NSString stringWithFormat:@"https://recrespite-3c13b.firebaseio.com/UserInformation/%@/participants.json",username];
    
    
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
             // NSLog(@"response is %@", responseString);
             
             NSArray *jsonArray = [[NSMutableArray alloc] init];
             jsonArray = [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingMutableContainers error:nil];
             
            // NSLog(@"Array object %@", jsonArray);
             
             count =0;
             
             if(jsonArray == nil)
             {
             count = 0;
             }
             
             
             else
             {
                 
                count = [jsonArray count];
 
             }
             
             NSLog(@"count is %d", count);
             
            
                 [self InsertIntoParticipantTable];
            
         }
         
     }];
}


-(void) InsertIntoParticipantTable
{
    NSString *firstName = tfFirstName.text;
    NSString *urlString = [NSString stringWithFormat:@"https://recrespite-3c13b.firebaseio.com/UserInformation/%@/participants/%d.json",username,count];
    
    
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    NSDictionary *postJSON = [[NSMutableDictionary alloc]init];
    [postJSON setValue:self.username forKey:@"username"];
    [postJSON setValue:self.tfFirstName.text forKey:@"firstname"];
    [postJSON setValue:self.tfLastName.text forKey:@"lastname"];
    [postJSON setValue:self.tfAge.text forKey:@"age"];
    [postJSON setValue:self.tfDiagnosis.text forKey:@"diagnosis"];
    [postJSON setValue:self.tfGender.text forKey:@"gender"];
    [postJSON setValue:self.tvNotes.text forKey:@"notes"];
    [postJSON setValue:self.tfProgram.text forKey:@"program"];
    
    
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
            /*dispatch_async(dispatch_get_main_queue(), ^{
                
                HomePageViewController *homePageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homePageViewController"];
                
                [self presentViewController:homePageViewController animated:YES completion:nil];
                
            });*/
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:@"Participant Added!"
                                              message:@"Do you want to add another participant?"
                                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"Yes"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         
                                         if(count == 4)
                                         {
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 UIAlertController * alert=   [UIAlertController
                                                                               alertControllerWithTitle:@"Error!"
                                                                               message:@"Cannot add more than 5 participants"
                                                                               preferredStyle:UIAlertControllerStyleAlert];
                                                 
                                                 
                                                 
                                                 UIAlertAction* cancel = [UIAlertAction
                                                                          actionWithTitle:@"Ok"
                                                                          style:UIAlertActionStyleDefault
                                                                          handler:^(UIAlertAction * action)
                                                                          {
                                                                              [alert dismissViewControllerAnimated:YES completion:nil];
                                                                        
                                                                //DISPATCH_ASYNC IS USED BECAUSE WE SHOULD ALWAYS UPDATE UI FROM MAIN THREAD
                                                                              
                                                                              
                                                                              
                                                                              HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeViewController"];
                                                                              
                                                                              [self presentViewController:homeViewController animated:YES completion:nil];
                                                                              
                                                                              
                                                                          }];
                                                 
                                                 // [alert addAction:ok];
                                                 [alert addAction:cancel];
                                                 
                                                 [self presentViewController:alert animated:YES completion:nil];
                                             });
                                             
                                            
                                         }
                                    else
                                    {
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                         
                                         tfFirstName.text=@"";
                                         tfLastName.text=@"";
                                         tfProgram.text=@"";
                                         tfDiagnosis.text=@"";
                                         tfAge.text=@"";
                                         tvNotes.text=@"";
                                         tfGender.text=@"";
                                         
                                      
                                    }
                                         
                                     }];
                                     
                                     
                UIAlertAction* cancel = [UIAlertAction
                                         actionWithTitle:@"No"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action)
                                         {
                                             [alert dismissViewControllerAnimated:YES completion:nil];
                                             //DISPATCH_ASYNC IS USED BECAUSE WE SHOULD ALWAYS UPDATE UI FROM MAIN THREAD
                                           
                                             [[NSUserDefaults standardUserDefaults] setValue: mainDelegate.usernameLoggedIn forKey:@"username"];
                                             
                                             [[NSUserDefaults standardUserDefaults] synchronize];
                                              
                                              HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeViewController"];
                                              
                                              [self presentViewController:homeViewController animated:YES completion:nil];
                                              
                                             
                                         }];
                
                [alert addAction:ok];
                [alert addAction:cancel];
                
                [self presentViewController:alert animated:YES completion:nil];
            });

            
            
        }
        else
        {
            NSLog(@"Error inserting new object");
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
