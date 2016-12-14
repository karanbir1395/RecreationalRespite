//
//  SignUpViewController.m
//  Capstone Project
//
//  Created by iOS Xcode User on 2016-03-24.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize tfCity,tfPhoneNumber,tfEmail,tfFirstName,tfLastName,tfRegion, pickerRegion,tfUsername, arrayRegion, lblUsernameError, lblAsterisk,scrollView,rememberContentOffset;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [scrollView setScrollEnabled:YES];

    self.pickerRegion = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    
    [tfPhoneNumber setDelegate: self];
    [tfLastName setDelegate: self];
    [tfFirstName setDelegate: self];
    [tfEmail setDelegate: self];
    [tfCity setDelegate: self];
    [tfRegion setDelegate: self];
    [pickerRegion setDelegate:self];
    [tfUsername setDelegate:self];
    
    lblUsernameError.hidden = true;
    lblAsterisk.hidden = true;
    lblInvalidEmail.hidden = true;
    
    self.tfRegion.inputView = self.pickerRegion;
    
    [self layoutOfTextBoxes];
    //arrayRegion = [[NSArray alloc]init];
     NSArray *a = [[NSArray alloc]initWithObjects:@"Hamilton", @"Brampton", @"Blue Mountains", @"Niagara", @"Western Ontario", nil];
    
    self.arrayRegion = a;
}

#pragma picker Methods

-(NSInteger) pickerView: (UIPickerView*) pickerView numberOfRowsInComponent:(NSInteger)component
{
    return  [arrayRegion count];
}

-(NSInteger) numberOfComponentsInPickerview: (UIPickerView *) pickerView
{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
        return [arrayRegion objectAtIndex:row];
    
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if([touch view] != pickerRegion)
    {
        int row =[self.pickerRegion selectedRowInComponent:0];
        tfRegion.text = [arrayRegion objectAtIndex:row ];
        [[self view] endEditing:YES];
    }
}

-(void) layoutOfTextBoxes
{
    CALayer *border = [CALayer layer];
    

    CGFloat borderWidth = 2;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.borderWidth = borderWidth;
    border.frame = CGRectMake(0, tfFirstName.frame.size.height - borderWidth, tfFirstName.frame.size.width, tfFirstName.frame.size.height);
    [tfFirstName.layer addSublayer:border];
    tfFirstName.layer.masksToBounds = YES;

    CALayer *border2 = [CALayer layer];
    border2.borderColor = [UIColor lightGrayColor].CGColor;
    border2.borderWidth = borderWidth;
    border2.frame = CGRectMake(0, tfLastName.frame.size.height - borderWidth, tfLastName.frame.size.width, tfLastName.frame.size.height);
    [tfLastName.layer addSublayer:border2];
    tfLastName.layer.masksToBounds = YES;
    
    CALayer *border3 = [CALayer layer];
    border3.borderColor = [UIColor lightGrayColor].CGColor;
    border3.borderWidth = borderWidth;
    border3.frame = CGRectMake(0, tfEmail.frame.size.height - borderWidth, tfEmail.frame.size.width, tfEmail.frame.size.height);
    [tfEmail.layer addSublayer:border3];
    tfEmail.layer.masksToBounds = YES;
    
    CALayer *border4 = [CALayer layer];
    border4.borderColor = [UIColor lightGrayColor].CGColor;
    border4.borderWidth = borderWidth;
    border4.frame = CGRectMake(0, tfPhoneNumber.frame.size.height - borderWidth, tfPhoneNumber.frame.size.width, tfPhoneNumber.frame.size.height);
    [tfPhoneNumber.layer addSublayer:border4];
    tfPhoneNumber.layer.masksToBounds = YES;
    
    CALayer *border5 = [CALayer layer];
    border5.borderColor = [UIColor lightGrayColor].CGColor;
    border5.borderWidth = borderWidth;
    border5.frame = CGRectMake(0, tfRegion.frame.size.height - borderWidth, tfRegion.frame.size.width, tfRegion.frame.size.height);
    [tfRegion.layer addSublayer:border5];
    tfRegion.layer.masksToBounds = YES;
    
    CALayer *border6 = [CALayer layer];
    border6.borderColor = [UIColor lightGrayColor].CGColor;
    border6.borderWidth = borderWidth;
    border6.frame = CGRectMake(0, tfCity.frame.size.height - borderWidth, tfCity.frame.size.width, tfCity.frame.size.height);
    [tfCity.layer addSublayer:border6];
    tfCity.layer.masksToBounds = YES;
    
    CALayer *border7 = [CALayer layer];
    border7.borderColor = [UIColor lightGrayColor].CGColor;
    border7.borderWidth = borderWidth;
    border7.frame = CGRectMake(0, tfUsername.frame.size.height - borderWidth, tfUsername.frame.size.width, tfUsername.frame.size.height);
    [tfUsername.layer addSublayer:border7];
    tfUsername.layer.masksToBounds = YES;
}


//NEXT BUTTON IS PRESSED - USER SAVED TO DATABASE
-(IBAction)nextButtonPressed:(id)sender
{

    NSString *username = tfUsername.text;
    
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
            // NSLog(@"response is %@", responseString);
          
             if([responseString  isEqual: @"null"])
             {
                 lblUsernameError.hidden = true;
                 
                 BOOL email = [self NSStringIsValidEmail:tfEmail.text];
                 
                 if(email)
                 {
                    lblInvalidEmail.hidden = true;
                     [self InsertIntoUserInformation];
  
                 }
                 else if([tfEmail.text isEqualToString:@""])
                 {
                     lblInvalidEmail.text = @"Please enter Email";
                     lblInvalidEmail.hidden = false;
                 }
                 
                 else if(!email)
                 {
                     lblInvalidEmail.text = @"Invalid Email";
                     lblInvalidEmail.hidden = false;

                 }
                 
                 
             }
             else
             {
                 if([tfUsername.text isEqualToString:@""] )
                 {
                     lblUsernameError.text = @"Please enter Username";
                     
                     lblUsernameError.hidden = false;
                 }
                 else
                 {
                 lblInvalidEmail.text = @"Please enter Email";
                 lblUsernameError.text= @"Username Exists";
                 lblUsernameError.hidden = false;
                 lblInvalidEmail.hidden = false;
             }
             }
         }
         
     }];
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void) InsertIntoUserInformation
{
    NSString *username = tfUsername.text;
    NSString *urlString = [NSString stringWithFormat:@"https://recrespite-3c13b.firebaseio.com/UserInformation/%@.json",username];



    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSDictionary *postJSON = [[NSMutableDictionary alloc]init];
    [postJSON setValue:self.tfUsername.text forKey:@"username"];
    [postJSON setValue:self.tfFirstName.text forKey:@"firstname"];
    [postJSON setValue:self.tfLastName.text forKey:@"lastname"];
    [postJSON setValue:self.tfEmail.text forKey:@"email"];
    [postJSON setValue:self.tfPhoneNumber.text forKey:@"phoneNumber"];
    [postJSON setValue:self.tfCity.text forKey:@"city"];
    [postJSON setValue:self.tfRegion.text forKey:@"region"];
    
    
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
                
                mainDelegate.passUsernametoNextScreen = username;
                mainDelegate.passUserEmail_Regis = tfEmail.text;
                mainDelegate.passUserPhone_Regis = tfPhoneNumber.text;
                ParticipantInformationViewController *participantViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"participantViewController"];
                
                [self presentViewController:participantViewController animated:YES completion:nil];
                
            });
            
        }
        else
        {
            NSLog(@"Error inserting new object");
        }
    }] resume];
    
    
}


//METHOD EXECUTED ON USERNAME TEXTFIELD TEXT CHANGE
-(IBAction)didChangeEditing:(id)sender
{
    NSString *username = tfUsername.text;
    
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
             
             if([responseString  isEqual: @"null"])
             {
                 lblAsterisk.hidden = true;
                 lblUsernameError.hidden = false;
                 lblUsernameError.text = @"Valid Username";
                 lblUsernameError.textColor = [UIColor greenColor];
             }
             else
             {
                 lblAsterisk.hidden = false;
                 lblUsernameError.hidden = false;
                 lblUsernameError.text = @"Username Exists";
                 lblUsernameError.textColor = [UIColor redColor];

             }
         }
         
     }];
}

//to disable keyboard from text field
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

//SCROLL VIEW METHODS
- (void) viewDidAppear:(BOOL)animated {
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width *1, self.view.frame.size.height*1)];
    
}
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
