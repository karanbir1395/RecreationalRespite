//
//  AllEventsViewController.m
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-13.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "AllEventsViewController.h"

@interface AllEventsViewController ()

@end

@implementation AllEventsViewController
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    [self getEventsFromFirebase];
}

//Making GET request to Firebase to get Event information
-(void)getEventsFromFirebase
{
    NSString *fullRequestUrl = [NSString stringWithFormat:@"https://recrespite-3c13b.firebaseio.com/events/events.json"];
    
    NSString *expectedRegion = mainDelegate.passSelectedRegion;
    
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
             
             NSArray *jsonArray = [[NSMutableArray alloc] init];
             jsonArray = [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingMutableContainers error:nil];
             
             arrayEventName = [[NSMutableArray alloc]init];
             arrayEventPhotos = [[NSMutableArray alloc]init];
             arrayEventAddress = [[NSMutableArray alloc]init];
             arrayEventDate = [[NSMutableArray alloc]init];
             arrayEventSeats = [[NSMutableArray alloc]init];
             arrayEventStartTime = [[NSMutableArray alloc]init];
             arrayEventEndTime = [[NSMutableArray alloc]init];
             arrayEventDescription = [[NSMutableArray alloc]init];
             arrayEventCost = [[NSMutableArray alloc]init];
             
             for (int i=0; i<[jsonArray count]; i++) {
                 
                 NSDictionary *dict=[jsonArray objectAtIndex:i];
                 
                 NSString *image=[dict valueForKey:@"eventImage"];
                 NSString *name=[dict valueForKey:@"eventName"];
                 NSString *address = [dict valueForKey:@"location"];
                 NSString *startTime = [dict valueForKey:@"startTime"];
                 NSString *endTime = [dict valueForKey:@"endTime"];
                 NSString *date = [dict valueForKey:@"date"];
                 NSString *seats = [dict valueForKey:@"totalSeats"];
                 NSString *description = [dict valueForKey:@"eventDescription"];
                 NSString *eventCost = [dict valueForKey:@"cost"];
                 NSString *actualRegion = [dict valueForKey:@"region"];
                 
                 if([actualRegion isEqualToString:expectedRegion])
                 {
                     [arrayEventPhotos addObject:image];
                     [arrayEventName addObject:name];
                     [arrayEventAddress addObject:address];
                     [arrayEventDescription addObject:description];
                     [arrayEventEndTime addObject:endTime];
                     [arrayEventStartTime addObject:startTime];
                     [arrayEventDate addObject:date];
                     [arrayEventSeats addObject:seats];
                     [arrayEventCost addObject:eventCost];
                     
                 }
             }
             
            
                 if(arrayEventName.count == 0)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         UIAlertController * alert=   [UIAlertController
                                                       alertControllerWithTitle:@"Empty!"
                                                       message:@"This Region has no Events"
                                                       preferredStyle:UIAlertControllerStyleAlert];
                         
                         UIAlertAction* ok = [UIAlertAction
                                              actionWithTitle:@"Ok"
                                              style:UIAlertActionStyleDefault
                                              handler:^(UIAlertAction * action)
                                              {
                                                  
                                                  RegionViewController *regionsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"regionsViewController"];
                                                  
                                                  [self presentViewController:regionsViewController animated:YES completion:nil];
                                              }];
                         
                         
                         
                         
                         [alert addAction:ok];
                         
                         [self presentViewController:alert animated:YES completion:nil];
                     });
                     
                     
                 }
             
             [self.tableView reloadData];
             
         }
         
     }];
    
}


#pragma mark Table Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayEventPhotos count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    
    SiteCell *cell = (SiteCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[SiteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSInteger row = [indexPath row];
    
    
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: arrayEventPhotos[row]]];
        
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{

            cell.myImageView.image = [UIImage imageWithData: data];
        });
    });
    
    
    cell.primaryLabel.text =arrayEventName[row];
    cell.secondaryLabel.text = arrayEventAddress[row];
    cell.backgroundColor = [UIColor colorWithRed:109.0f/255.0f
                                           green:109.0f/255.0f
                                            blue:109.0f/255.0f
                                           alpha:1.0f
                            ];
    cell.primaryLabel.textColor = [UIColor whiteColor];
    cell.secondaryLabel.textColor = [UIColor colorWithRed:0.51 green:0.58 blue:0.34 alpha:1.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.secondaryLabel.font = [UIFont boldSystemFontOfSize:13];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    mainDelegate.passEventName = [arrayEventName objectAtIndex:indexPath.row];
    mainDelegate.passEventDescription = [arrayEventDescription objectAtIndex:indexPath.row];
    mainDelegate.passEventStartTime = [arrayEventStartTime objectAtIndex:indexPath.row];
    mainDelegate.passEventEndTime = [arrayEventEndTime objectAtIndex:indexPath.row];
    mainDelegate.passEventAddress = [arrayEventAddress objectAtIndex:indexPath.row];
    mainDelegate.passEventDate = [arrayEventDate objectAtIndex:indexPath.row];
    mainDelegate.passEventSeats = [arrayEventSeats objectAtIndex:indexPath.row];
    mainDelegate.passEventImage = [arrayEventPhotos objectAtIndex:indexPath.row];
    mainDelegate.passEventCost = [arrayEventCost objectAtIndex:indexPath.row];
    
    EventsViewController *eventsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"eventsViewController"];
    
    [self presentViewController:eventsViewController animated:YES completion:nil];
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
