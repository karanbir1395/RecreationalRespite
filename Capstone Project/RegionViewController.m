//
//  RegionViewController.m
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-12-08.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "RegionViewController.h"

@interface RegionViewController ()

@end

@implementation RegionViewController
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self getRegions];
}

//Getting all region names from firebase database
//Making a GET Request
-(void)getRegions
{
    NSString *fullRequestUrl = [NSString stringWithFormat:@"https://recrespite-3c13b.firebaseio.com/regions.json"];
    
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
             
             NSArray *responseArray = [[NSMutableArray alloc] init];
             
             responseArray = [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingMutableContainers error:nil];
             
             arrayRegionName = [[NSMutableArray alloc]init];
             
             
             for (int i=0; i<[responseArray count]; i++) {
                 
                 NSDictionary *dict=[responseArray objectAtIndex:i];
                 
                 NSString *name=[dict valueForKey:@"name"];
                 
                 [arrayRegionName addObject:name];
                 
             }
             
             [self.tableView reloadData];
             
         }
     }];
    
}

//Filtering data according to text entered in search bar
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    searchResults = [arrayRegionName filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}


#pragma mark Table Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    }
    else {
        
        return [arrayRegionName count];
        
    }
    
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
        cell = [[SiteCell alloc] initWithStyle:UITextAlignmentCenter reuseIdentifier:cellIdentifier];
    }
    NSInteger row = [indexPath row];
    
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
        
        
    } else {
        cell.textLabel.text = [arrayRegionName objectAtIndex:indexPath.row];
        
    }
    
    cell.backgroundColor = [UIColor colorWithRed:109.0f/255.0f
                                           green:109.0f/255.0f
                                            blue:109.0f/255.0f
                                           alpha:1.0f
                            ];
    cell.primaryLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textColor= [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self nothing];
    
    
}

//Sets PDF value with every search result
-(void)nothing
{
    NSIndexPath *indexPath = nil;
    
    if ([self.searchDisplayController isActive]) {
        
        selectedRegion = [searchResults objectAtIndex:indexPath.row];
        mainDelegate.passSelectedRegion = [searchResults objectAtIndex:indexPath.row];
        
        AllEventsViewController *allEventsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"allEventsViewController"];
        
        [self presentViewController:allEventsViewController animated:YES completion:nil];
        
        
    }
    else {
        indexPath = [self.tableView indexPathForSelectedRow];
        
        mainDelegate.passSelectedRegion = [arrayRegionName objectAtIndex:indexPath.row];
        
        AllEventsViewController *allEventsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"allEventsViewController"];
        
        [self presentViewController:allEventsViewController animated:YES completion:nil];    }
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
