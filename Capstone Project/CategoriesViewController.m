//
//  CategoriesViewController.m
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-12-07.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "CategoriesViewController.h"

@interface CategoriesViewController ()

@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self getArticleImageAndName];
}


-(void)getArticleImageAndName
{
    NSString *fullRequestUrl = [NSString stringWithFormat:@"https://recrespite-3c13b.firebaseio.com/articles/articles/.json"];
    
    
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
             
             
             arrayCategories = [[NSMutableArray alloc]init];
             
             for (int i=0; i<[responseArray count]; i++) {
                 
                 NSDictionary *dict=[responseArray objectAtIndex:i];
                 
                 NSString *category=[dict valueForKey:@"category"];
                 if(![arrayCategories containsObject:category])
                 {
                 [arrayCategories addObject:category];
                 }
                 
             }
             [self.tableView reloadData];
             
             
         }
         
     }];
    
}


#pragma mark Table Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
        return [arrayCategories count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
    
    
    
    
        cell.textLabel.text = [arrayCategories objectAtIndex:indexPath.row];
   
    cell.backgroundColor = [UIColor colorWithRed:109.0f/255.0f
                                           green:109.0f/255.0f
                                            blue:109.0f/255.0f
                                           alpha:1.0f
                            ];
    cell.primaryLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.textLabel.textColor= [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    mainDelegate.passSelectedCategory = [arrayCategories objectAtIndex:indexPath.row];
    
    LibraryViewController *libraryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"libraryViewController"];
    
    [self presentViewController:libraryViewController animated:YES completion:nil];
    
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
