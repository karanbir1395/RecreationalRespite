//
//  EditProfileViewController.m
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-13.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController
@synthesize scrollView, rememberContentOffset, tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [scrollView setScrollEnabled:YES];
    
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [tfFirstName setDelegate:self];
    [tfLastName setDelegate:self];
    [tfUsername setDelegate:self];
    [tfEmail setDelegate:self];
    [tfPhoneNumber setDelegate:self];
    [tfCity setDelegate:self];
    [tfRegion setDelegate:self];
    
    
    [self setTextboxLayout];
    
    [self getUserInfoFromFirebase];
    
    // Do any additional setup after loading the view.
}

//Set layout of text boxes
-(void) setTextboxLayout
{
    
    [stackView setNeedsLayout];
    [stackView layoutIfNeeded];
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = [UIColor  lightGrayColor].CGColor;
    border.borderWidth = borderWidth;
    border.frame = CGRectMake(0, tfFirstName.bounds.size.height - borderWidth, tfFirstName.bounds.size.width -15, tfFirstName.bounds.size.height);
    [tfFirstName.layer addSublayer:border];
    tfFirstName.layer.masksToBounds = YES;
    
    CALayer *border2 = [CALayer layer];
    border2.borderColor = [UIColor  lightGrayColor].CGColor;
    border2.borderWidth = borderWidth;
    border2.frame = CGRectMake(0, tfLastName.frame.size.height - borderWidth, tfLastName.frame.size.width-15, tfLastName.frame.size.height);
    [tfLastName.layer addSublayer:border2];
    tfLastName.layer.masksToBounds = YES;
    
    CALayer *border3 = [CALayer layer];
    border3.borderColor = [UIColor  lightGrayColor].CGColor;
    border3.borderWidth = borderWidth;
    border3.frame = CGRectMake(0, tfUsername.frame.size.height - borderWidth, tfUsername.frame.size.width-15, tfUsername.frame.size.height);
    [tfUsername.layer addSublayer:border3];
    tfUsername.layer.masksToBounds = YES;
    
    CALayer *border4 = [CALayer layer];
    border4.borderColor = [UIColor  lightGrayColor].CGColor;
    border4.borderWidth = borderWidth;
    border4.frame = CGRectMake(0, tfEmail.frame.size.height - borderWidth, tfEmail.frame.size.width-15, tfEmail.frame.size.height);
    [tfEmail.layer addSublayer:border4];
    tfEmail.layer.masksToBounds = YES;
    
    CALayer *border5 = [CALayer layer];
    border5.borderColor = [UIColor  lightGrayColor].CGColor;
    border5.borderWidth = borderWidth;
    border5.frame = CGRectMake(0, tfPhoneNumber.frame.size.height - borderWidth, tfPhoneNumber.frame.size.width-15, tfPhoneNumber.frame.size.height);
    [tfPhoneNumber.layer addSublayer:border5];
    tfPhoneNumber.layer.masksToBounds = YES;
    
    CALayer *border6 = [CALayer layer];
    border6.borderColor = [UIColor  lightGrayColor].CGColor;
    border6.borderWidth = borderWidth;
    border6.frame = CGRectMake(0, tfRegion.frame.size.height - borderWidth, tfRegion.frame.size.width-15, tfRegion.frame.size.height);
    [tfRegion.layer addSublayer:border6];
    tfRegion.layer.masksToBounds = YES;
    
    CALayer *border7 = [CALayer layer];
    border7.borderColor = [UIColor  lightGrayColor].CGColor;
    border7.borderWidth = borderWidth;
    border7.frame = CGRectMake(0, tfCity.frame.size.height - borderWidth, tfCity.frame.size.width-15, tfCity.frame.size.height);
    [tfCity.layer addSublayer:border7];
    tfCity.layer.masksToBounds = YES;
    
}


//Get Data of User from Firebase
-(void)getUserInfoFromFirebase
{
    NSString *username = mainDelegate.usernameLoggedIn;
    
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
             
             
             NSString *phone = [dict valueForKey:@"phoneNumber"];
             
             NSString *email = [dict valueForKey:@"email"];
             
             NSString *firstname = [dict valueForKey:@"firstname"];
             
             NSString *lastname = [dict valueForKey:@"lastname"];
             
             NSString *city = [dict valueForKey:@"city"];
             
             NSString *region = [dict valueForKey: @"region"];
             
             NSString *username = [dict valueForKey:@"username"];
             
             
             arrayParticipantNames = [[NSMutableArray alloc] init];
             arrayParticipantLastname = [[NSMutableArray alloc] init];
             arrayParticipantAge = [[NSMutableArray alloc] init];
             arrayParticipantGender = [[NSMutableArray alloc] init];
             arrayParticipantDiagnosis = [[NSMutableArray alloc] init];
             arrayParticipantProgramOfInterest = [[NSMutableArray alloc] init];
             arrayParticipantNotes = [[NSMutableArray alloc] init];
             arrayParticipantNodeId = [[NSMutableArray alloc]init];
             
             NSArray *fetchedArr = [dict objectForKey:@"participants"];
             
             for(int i =0; i< [fetchedArr count]; i++)
             {
                 NSDictionary *dictFirstName=[fetchedArr objectAtIndex:i];
                 
                 NSString *firstnameParticipant=[dictFirstName valueForKey:@"firstname"];
                 NSString *lastnameParticipant = [dictFirstName valueForKey:@"lastname"];
                 NSString *age = [dictFirstName valueForKey:@"age"];
                 NSString *gender = [dictFirstName valueForKey:@"gender"];
                 NSString *diagnosis = [dictFirstName valueForKey:@"diagnosis"];
                 NSString *program = [dictFirstName valueForKey:@"program"];
                 NSString *notes = [dictFirstName valueForKey:@"notes"];
                 NSString *nodeId = [NSString stringWithFormat:@"%d", i] ;
                 
                 [arrayParticipantNames addObject:firstnameParticipant];
                 [arrayParticipantLastname addObject:lastnameParticipant];
                 [arrayParticipantAge addObject:age];
                 [arrayParticipantGender addObject:gender];
                 [arrayParticipantDiagnosis addObject:diagnosis];
                 [arrayParticipantProgramOfInterest addObject:program];
                 [arrayParticipantNotes addObject:notes];
                 [arrayParticipantNodeId addObject:nodeId];
             }
             [tableView reloadData];
             
             NSLog(@"array %@", fetchedArr);
             
             if([responseString  isEqual: @"null"] || [username  isEqual: @""])
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     UIAlertController * alert=   [UIAlertController
                                                   alertControllerWithTitle:@"Error!"
                                                   message:@"There is some problem in the system."
                                                   preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction* ok = [UIAlertAction
                                          actionWithTitle:@"Close"
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
                 tfFirstName.text = firstname;
                 tfLastName.text = lastname;
                 tfUsername.text = username;
                 tfEmail.text = email;
                 tfPhoneNumber.text = phone;
                 tfCity.text = city;
                 tfRegion.text = phone;
                 
             }
         }
         
     }];
}


#pragma mark Table Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayParticipantNames count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [arrayParticipantNames objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor colorWithRed:109.0f/255.0f
                                           green:109.0f/255.0f
                                            blue:109.0f/255.0f
                                           alpha:1.0f
                            ];
    return cell;
    
    
}

//On select table view row
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    mainDelegate.passEditParticipantFirstname = [arrayParticipantNames objectAtIndex:indexPath.row];
    mainDelegate.passEditParticipantLastname = [arrayParticipantLastname objectAtIndex:indexPath.row];
    mainDelegate.passEditParticipantAge = [arrayParticipantAge objectAtIndex:indexPath.row];
    mainDelegate.passEditParticipantGender = [arrayParticipantGender objectAtIndex:indexPath.row];
    mainDelegate.passEditParticipantDiagnosis = [arrayParticipantDiagnosis objectAtIndex:indexPath.row];
    mainDelegate.passEditParticipantProgramOfInterest = [arrayParticipantProgramOfInterest objectAtIndex:indexPath.row];
    mainDelegate.passEditParticipantNotes = [arrayParticipantNotes objectAtIndex:indexPath.row];
    mainDelegate.passEditParticipantNodeId = [arrayParticipantNodeId objectAtIndex:indexPath.row];
    
    EditParticipantViewController *editParticipantViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"editParticipantViewController"];
    
    [self presentViewController:editParticipantViewController animated:YES completion: nil];
    
}

//Executed when Save button is clicked
-(IBAction)onClickSaveButton:(id)sender
{
    NSString *username = tfUsername.text;
    NSString *urlString = [NSString stringWithFormat:@"https://recrespite-3c13b.firebaseio.com/UserInformation/%@.json",username];
    
    
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSDictionary *postJSON = [[NSMutableDictionary alloc]init];
    [postJSON setValue:tfUsername.text forKey:@"username"];
    [postJSON setValue:tfFirstName.text forKey:@"firstname"];
    [postJSON setValue:tfLastName.text forKey:@"lastname"];
    [postJSON setValue:tfEmail.text forKey:@"email"];
    [postJSON setValue:tfPhoneNumber.text forKey:@"phoneNumber"];
    [postJSON setValue:tfCity.text forKey:@"city"];
    [postJSON setValue:tfRegion.text forKey:@"region"];
    
    
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
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:@"Success!"
                                              message:@"User information was saved."
                                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"Ok"
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
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:@"Failed!"
                                              message:@"User information was not saved."
                                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"Ok"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                         
                                         
                                     }];
                
                [alert addAction:ok];
                
                [self presentViewController:alert animated:YES completion:nil];
            });
            
            
            
        }
    }] resume];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//SCROLL VIEW METHODS
- (void) viewDidAppear:(BOOL)animated {
    
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width *1, self.view.frame.size.height*1.16)];
    
    
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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
