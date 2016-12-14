//
//  LibraryViewController.m
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-02.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "LibraryViewController.h"

@interface LibraryViewController ()

@end

@implementation LibraryViewController
@synthesize arrayPhotos,arrayArticleName,libraryTableView,arrayArticlePDF;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self getArticleImageAndName];
}



-(void)getArticleImageAndName
{
    NSString *fullRequestUrl = [NSString stringWithFormat:@"https://recrespite-3c13b.firebaseio.com/articles/articles/.json"];
    
    NSString *expectedCategory = mainDelegate.passSelectedCategory;
    
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
             
             arrayPhotos = [[NSMutableArray alloc]init];
             arrayArticleName = [[NSMutableArray alloc]init];
             arrayArticlePDF = [[NSMutableArray alloc]init];
             
             for (int i=0; i<[responseArray count]; i++) {
                 
                 NSDictionary *dict=[responseArray objectAtIndex:i];
                 
                 NSString *image=[dict valueForKey:@"articleImage"];
                 NSString *name=[dict valueForKey:@"name"];
                 NSString *articlePDF = [dict valueForKey:@"articlePDF"];
                 NSString *actualCategory = [dict valueForKey:@"category"];
                 
                 if([actualCategory isEqualToString:expectedCategory])
                 {
                     [arrayPhotos addObject:image];
                     [arrayArticleName addObject:name];
                     [arrayArticlePDF addObject:articlePDF];
                     
                 }
                 
             }
             
             if(arrayArticleName.count == 0)
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     UIAlertController * alert=   [UIAlertController
                                                   alertControllerWithTitle:@"Empty!"
                                                   message:@"This Category has no Articles"
                                                   preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction* ok = [UIAlertAction
                                          actionWithTitle:@"Ok"
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action)
                                          {
                                              
                                              CategoriesViewController *categoriesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"categoriesViewController"];
                                              
                                              [self presentViewController:categoriesViewController animated:YES completion:nil];
                                          }];
                     
                     [alert addAction:ok];
                     
                     [self presentViewController:alert animated:YES completion:nil];
                 });
                 
                 
             }
             
             [self.libraryTableView reloadData];
             
             
         }
     }];
    
}



- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    searchResults = [arrayArticleName filteredArrayUsingPredicate:resultPredicate];
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
        
        return [arrayPhotos count];
        
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
        cell.textLabel.text = [arrayArticleName objectAtIndex:indexPath.row];
        
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self nothing];
    
}

-(void)nothing
{
    NSIndexPath *indexPath = nil;
    
    if ([self.searchDisplayController isActive]) {
        
        selectedArticleName = [searchResults objectAtIndex:indexPath.row];
        [self getArticlePDF];
        
        
        
    }
    else {
        indexPath = [self.libraryTableView indexPathForSelectedRow];

        mainDelegate.passSelectedArticleFromLibrary = [arrayArticlePDF objectAtIndex:indexPath.row];
        
        NSLog(@"index is %ld", (long)indexPath.row);
        PDFLibraryViewController *pdfLibraryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pdfLibraryViewController"];
        
        [self presentViewController:pdfLibraryViewController animated:YES completion:nil];    }
}


-(void)getArticlePDF
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
             
             
             arrayArticleName = [[NSMutableArray alloc]init];
             arrayArticlePDF = [[NSMutableArray alloc]init];
             
             for (int i=0; i<[responseArray count]; i++) {
                 
                 NSDictionary *dict=[responseArray objectAtIndex:i];
                 
                 NSString *image=[dict valueForKey:@"articleImage"];
                 NSString *name=[dict valueForKey:@"name"];
                 NSString *articlePDF = [dict valueForKey:@"articlePDF"];
                 
                 
                 if([name isEqualToString:selectedArticleName])
                 {
                     mainDelegate.passSelectedArticleFromLibrary = articlePDF;
                     PDFLibraryViewController *pdfLibraryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pdfLibraryViewController"];
                     
                     [self presentViewController:pdfLibraryViewController animated:YES completion:nil];
                 }
                 
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
