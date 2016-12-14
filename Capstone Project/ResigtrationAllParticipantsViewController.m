//
//  ResigtrationAllParticipantsViewController.m
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-15.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "ResigtrationAllParticipantsViewController.h"

@interface ResigtrationAllParticipantsViewController ()

@end

@implementation ResigtrationAllParticipantsViewController
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self getParticipantsFromFirebase];
}

//Get Participant Information from database- firebase
//GET request made to participants node
-(void)getParticipantsFromFirebase
{
    
    NSString *username = maindelegate.usernameLoggedIn;
    
    NSString *fullRequestUrl = [NSString stringWithFormat:@"https://recrespite-3c13b.firebaseio.com/UserInformation/%@/participants.json", username];
    
    
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
             NSLog(@"response is %@", responseString);
             
             
             NSArray *jsonArray = [[NSMutableArray alloc] init];
             jsonArray = [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingMutableContainers error:nil];
             
             NSLog(@"Array object ", jsonArray);
             
             arrayParticipants = [[NSMutableArray alloc]init];
             arrayParticipantAge = [[NSMutableArray alloc]init];
             
             for (int i=0; i<[jsonArray count]; i++) {
                 
                 NSDictionary *dict=[jsonArray objectAtIndex:i];
                 
                 NSString *firstname=[dict valueForKey:@"firstname"];
                 NSString *age=[dict valueForKey:@"age"];
                 
                 [arrayParticipantAge addObject:age];
                 [arrayParticipants addObject:firstname];
                 
             }
             
             [self.tableView reloadData];
             
         }
         
     }];
    
}



#pragma mark Table Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayParticipants count];
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
    
    cell.textLabel.text = [arrayParticipants objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor colorWithRed:109.0f/255.0f
                                           green:109.0f/255.0f
                                            blue:109.0f/255.0f
                                           alpha:1.0f
                            ];
    return cell;
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    maindelegate.passParticipantAge_Regis =[arrayParticipantAge objectAtIndex:indexPath.row];
    maindelegate.passParticipantName_Regis =[arrayParticipants objectAtIndex:indexPath.row];
    
    
    RegistrationViewController *pdfLibraryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"registrationForm"];
    
    [self presentViewController:pdfLibraryViewController animated:YES completion: nil];
    
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
