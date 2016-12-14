//
//  HomePageViewController.m
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-09-10.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "HomePageViewController.h"
#import "SiteCell.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController
@synthesize ScrollViewHorizontal,btnLibrary, tableView,activityIndicator;





-(IBAction)onClickLogout:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"username"];
    //  [[NSUserDefaults standardUserDefaults] setValue:_password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    ViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    
    [self presentViewController:loginViewController animated:YES completion:nil];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [ScrollViewHorizontal setScrollEnabled:YES];

    
     //arrayPhotos = [[NSArray alloc] initWithObjects:@"1.JPG",@"2.JPG", @"3.JPG", @"4.JPG", @"5.JPG", @"6.JPG", @"7.jpg", @"8.jpeg", nil];
    
    
    
    [self getArticlesFromFirebase];
    [self getEventsFromFirebase];
   
}

-(void)getArticlesFromFirebase
{
    [activityIndicator startAnimating];

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
             // NSLog(@"response is %@", responseString);
             
             NSArray *jsonImagesArray = [[NSMutableArray alloc] init];
             jsonImagesArray = [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingMutableContainers error:nil];
             
             NSLog(@"Array object at 1 %@", jsonImagesArray[1]);
             
             arrayArticlePhotos = [[NSMutableArray alloc]init];
             arrayArticleNames = [[NSMutableArray alloc] init];
             arrayArticleId = [[NSMutableArray alloc]init];
             arrayArticlePDF = [[NSMutableArray alloc]init];

             for (int i=0; i<[jsonImagesArray count]; i++) {
                 
                 NSDictionary *dict=[jsonImagesArray objectAtIndex:i];
                 
                 NSString *image=[dict valueForKey:@"articleImage"];
                 NSString *name=[dict valueForKey:@"name"];
                 NSString *Id = [dict valueForKey:@"articleId"];
                 NSString *pdf = [dict valueForKey:@"articlePDF"];
                 
                 [arrayArticlePhotos addObject:image];
                 [arrayArticleNames addObject:name];
                 [arrayArticleId addObject:Id];
                 [arrayArticlePDF addObject:pdf];
                 
                 //NSLog(@"Array Photo object at 1 %@", arrayArticlePhotos[1]);

             }
             
             [self createScrollMenu];
             
         }
         
     }];
}


-(void)getEventsFromFirebase
{
    NSString *fullRequestUrl = [NSString stringWithFormat:@"https://recrespite-3c13b.firebaseio.com/events/events.json"];
    
    
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
             
             arrayEventName = [[NSMutableArray alloc]init];
             arrayEventPhotos = [[NSMutableArray alloc]init];
             arrayEventAddress = [[NSMutableArray alloc]init];
             arrayEventDate = [[NSMutableArray alloc]init];
             arrayEventSeats = [[NSMutableArray alloc]init];
             arrayEventStartTime = [[NSMutableArray alloc]init];
             arrayEventEndTime = [[NSMutableArray alloc]init];
             arrayEventDescription = [[NSMutableArray alloc]init];
             arrayEventId = [[NSMutableArray alloc]init];
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
                 NSString *eventId = [dict valueForKey:@"Id"];
                 NSString *eventCost = [dict valueForKey:@"cost"];
                 
                 [arrayEventPhotos addObject:image];
                 [arrayEventName addObject:name];
                 [arrayEventAddress addObject:address];
                 [arrayEventDescription addObject:description];
                 [arrayEventEndTime addObject:endTime];
                 [arrayEventStartTime addObject:startTime];
                 [arrayEventDate addObject:date];
                 [arrayEventSeats addObject:seats];
                 [arrayEventId addObject:eventId];
                 [arrayEventCost addObject:eventCost];
                 
             }
             
             [self.tableView reloadData];
         //    tableView.tag =1;

         }

     }];
   // [activityIndicator hidesWhenStopped];

}


//ONCLICK ARTICLE IMAGE AND BUTTON



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createScrollMenu
{
   
    int x = 0;
    for (int i=0; i<[arrayArticlePhotos count]; i++)
    {
       // UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, 100, 100)];
        //[button setTitle:[NSString stringWithFormat:@"Button %d", i] forState:UIControlStateNormal];
        
       // UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(x+5, 5, 175, 110)];
        UIButton *btnCoverImageView = [[UIButton alloc] initWithFrame:CGRectMake(x+5, 5, 175, 110)];

        UIButton *btnName = [[UIButton alloc] initWithFrame:CGRectMake(x+5, 119, 175, 20)];
        //imgView.image = [UIImage imageNamed: arrayPhotos[i]];

        dispatch_async(dispatch_get_global_queue(0,0), ^{
            
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: arrayArticlePhotos[i]]];
            
            if ( data == nil )
                return;
            dispatch_async(dispatch_get_main_queue(), ^{
                // WARNING: is the cell still using the same data by this point??
              //  imgView.image = [UIImage imageWithData: data];
            //    imgView.tag = [arrayArticleId[i] intValue];
                
                btnCoverImageView.tag = [arrayArticleId[i] intValue];
                [btnName setTitle:arrayArticleNames[i] forState:UIControlStateNormal];
                btnName.tag = [arrayArticleId[i] intValue];
                
                UIImage *image = [UIImage imageWithData:data];
               
               // [ btnCoverImageView setTitle: @"1" forState:UIControlStateNormal];
                [btnCoverImageView setBackgroundImage: image forState:UIControlStateNormal];
                btnCoverImageView.backgroundColor = [UIColor clearColor];
                [btnCoverImageView addTarget:self action:@selector(stayPressed:) forControlEvents:UIControlEventTouchDown];
            });
        });
        
       // [ScrollViewHorizontal addSubview:imgView];
        [ScrollViewHorizontal addSubview:btnName];
        [ScrollViewHorizontal addSubview:btnCoverImageView];
        x += btnCoverImageView.frame.size.width+9;
        
        
        
        
    }
    
    ScrollViewHorizontal.contentSize = CGSizeMake(x, ScrollViewHorizontal.frame.size.height);
    ScrollViewHorizontal.backgroundColor = [UIColor lightGrayColor];
    
    
    
    [self.view addSubview:ScrollViewHorizontal];



}



-(void)stayPressed:(UIButton *) sender {
    if (sender.selected == YES) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
        NSLog(@"button not selected");
        NSInteger *tagSelected = sender.tag;
        
        NSLog(@"Tag is %d", tagSelected);

        
        
        AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        //NSLog(@"Checking PDF LINK %@",[arrayArticlePDF objectAtIndex:indexPath.row] );
        mainDelegate.passSelectedArticleFromLibrary = [arrayArticlePDF objectAtIndex:tagSelected];
        
        PDFLibraryViewController *pdfLibraryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pdfLibraryViewController"];
        
        [self presentViewController:pdfLibraryViewController animated:YES completion:nil];
        
    }
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
            // WARNING: is the cell still using the same data by this point??
            cell.myImageView.image = [UIImage imageWithData: data];
            //[activityIndicator stopAnimating];

        });
    });

    
    cell.primaryLabel.text =arrayEventName[row];
    cell.secondaryLabel.text = arrayEventAddress[row];
    //cell.addressFrame.text = arrayEventDate[row];
    //cell.secondaryLabel.textColor = [UIColor colorWithRed:0.51 green:0.58 blue:0.34 alpha:1.0];
    cell.secondaryLabel.textColor = [UIColor orangeColor];
   // cell.addressFrame.textColor = [UIColor orangeColor];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    
    
    return cell;
    

}

- (void) viewDidAppear:(BOOL)animated {
    
   
        [activityIndicator stopAnimating];
        
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //NSLog(@"Checking PDF LINK %@",[arrayArticlePDF objectAtIndex:indexPath.row] );
    mainDelegate.passEventName = [arrayEventName objectAtIndex:indexPath.row];
    mainDelegate.passEventDescription = [arrayEventDescription objectAtIndex:indexPath.row];
    mainDelegate.passEventStartTime = [arrayEventStartTime objectAtIndex:indexPath.row];
    mainDelegate.passEventEndTime = [arrayEventEndTime objectAtIndex:indexPath.row];
    mainDelegate.passEventAddress = [arrayEventAddress objectAtIndex:indexPath.row];
    mainDelegate.passEventDate = [arrayEventDate objectAtIndex:indexPath.row];
    mainDelegate.passEventSeats = [arrayEventSeats objectAtIndex:indexPath.row];
    mainDelegate.passEventImage = [arrayEventPhotos objectAtIndex:indexPath.row];
    mainDelegate.passEventId = [arrayEventId objectAtIndex:indexPath.row];
    mainDelegate.passEventCost = [arrayEventCost objectAtIndex:indexPath.row];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // WARNING: is the cell still using the same data by this point??
       // cell.myImageView.image = [UIImage imageWithData: data];
        //[activityIndicator stopAnimating];
        EventsViewController *eventsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"eventsViewController"];
        
        [self presentViewController:eventsViewController animated:YES completion:nil];
        
    });

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
