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
    
    [self getParticipantsFromFirebase];
}

-(void)getParticipantsFromFirebase
{
    NSString *fullRequestUrl = [NSString stringWithFormat:@"https://recrespite-3c13b.firebaseio.com/UserInformation/mannkara/participants.json"];
    
    
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
             
             // NSLog(@"Array object at 1 %@", jsonImagesArray[1]);
             
             arrayParticipants = [[NSMutableArray alloc]init];
             arrayParticipantAge = [[NSMutableArray alloc]init];
             
             for (int i=0; i<[jsonArray count]; i++) {
                 
                 NSDictionary *dict=[jsonArray objectAtIndex:i];
                 
                 NSString *firstname=[dict valueForKey:@"firstname"];
                 NSString *age=[dict valueForKey:@"age"];
                 
                 /* NSString *address = [dict valueForKey:@"location"];
                  NSString *startTime = [dict valueForKey:@"startTime"];
                  NSString *endTime = [dict valueForKey:@"endTime"];
                  NSString *date = [dict valueForKey:@"date"];
                  NSString *seats = [dict valueForKey:@"totalSeats"];
                  NSString *description = [dict valueForKey:@"eventDescription"];
                  */
                 [arrayParticipantAge addObject:age];
                 [arrayParticipants addObject:firstname];
                 /*       [arrayEventName addObject:name];
                  [arrayEventAddress addObject:address];
                  [arrayEventDescription addObject:description];
                  [arrayEventEndTime addObject:endTime];
                  [arrayEventStartTime addObject:startTime];
                  [arrayEventDate addObject:date];
                  [arrayEventSeats addObject:seats];
                  */
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
    cell.textLabel.textColor = [UIColor blueColor];
    return cell;
    
  
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"Checking PDF LINK %@",[arrayArticlePDF objectAtIndex:indexPath.row] );
   
    [self getParticipantInfoFromFirebase];

    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    mainDelegate.passParticipantAge_Regis =[arrayParticipantAge objectAtIndex:indexPath.row];
    mainDelegate.passParticipantName_Regis =[arrayParticipants objectAtIndex:indexPath.row];

    NSString *age =[arrayParticipantAge objectAtIndex:indexPath.row];
    NSLog(@"age is %@", age);
    
    RegistrationViewController *pdfLibraryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"registrationForm"];
    
    [self presentViewController:pdfLibraryViewController animated:YES completion:nil];
}



-(void)getParticipantInfoFromFirebase
{
    NSString *fullRequestUrl = [NSString stringWithFormat:@"https://recrespite-3c13b.firebaseio.com/UserInformation/mannkara.json"];
    
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
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
           NSString *str =  [NSString stringWithFormat:@"[%@]",
              responseString];
           //  NSLog(@"json string %@", str);
             NSData* data2 = [str dataUsingEncoding:NSUTF8StringEncoding];

             
             NSArray *jsonArray = [[NSMutableArray alloc] init];
             jsonArray = [NSJSONSerialization JSONObjectWithData: data2 options:NSJSONReadingMutableContainers error:nil];
             
              NSLog(@"Array object %@", jsonArray);
             
          
             
             for (int i=0; i<[jsonArray count]; i++) {
                 
                 NSDictionary *dict=[jsonArray objectAtIndex:i];
                 
                 mainDelegate.passUserPhone_Regis = [dict valueForKey:@"phoneNumber"];
                 
                 mainDelegate.passUserEmail_Regis = [dict valueForKey:@"email"];
              
                 
             }
             
         }
         
     }];
    
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
