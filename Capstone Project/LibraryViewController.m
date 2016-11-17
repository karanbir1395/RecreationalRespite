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
             
             // NSLog(@"Array object at 1 %@", jsonImagesArray[1]);
             
             arrayPhotos = [[NSMutableArray alloc]init];
             arrayArticleName = [[NSMutableArray alloc]init];
             arrayArticlePDF = [[NSMutableArray alloc]init];
             
             for (int i=0; i<[responseArray count]; i++) {
                 
                 NSDictionary *dict=[responseArray objectAtIndex:i];
                 
                 NSString *image=[dict valueForKey:@"articleImage"];
                 NSString *name=[dict valueForKey:@"name"];
                 NSString *articlePDF = [dict valueForKey:@"articlePDF"];
                 
                 [arrayPhotos addObject:image];
                 [arrayArticleName addObject:name];
                 [arrayArticlePDF addObject:articlePDF];
                 
                 NSLog(@"Array photos are: %@", arrayPhotos[i]);
                 NSLog(@"array names are: %@", arrayArticleName[i]);
                 
             }
             [self.libraryTableView reloadData];

             
         }
         
     }];
    
}



#pragma mark Table Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [arrayPhotos count];
    
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
        
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: arrayPhotos[row]]];
        
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            cell.myImageView.image = [UIImage imageWithData: data];
        });
    });

    
    cell.primaryLabel.text =arrayArticleName[row];
   // cell.secondaryLabel.text = arrayAddress[row];
  //  cell.myImageView.image = [UIImage imageNamed: arrayPhotos[row]];
    cell.backgroundColor = [UIColor colorWithRed:109.0f/255.0f
                                           green:109.0f/255.0f
                                            blue:109.0f/255.0f
                                           alpha:1.0f
                                            ];
    cell.primaryLabel.textColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //NSLog(@"Checking PDF LINK %@",[arrayArticlePDF objectAtIndex:indexPath.row] );
    mainDelegate.passSelectedArticleFromLibrary = [arrayArticlePDF objectAtIndex:indexPath.row];

    PDFLibraryViewController *pdfLibraryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pdfLibraryViewController"];
    
    [self presentViewController:pdfLibraryViewController animated:YES completion:nil];
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
