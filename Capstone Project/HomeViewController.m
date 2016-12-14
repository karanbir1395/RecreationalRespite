//
//  HomeViewController.m
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-12-06.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize tableView;

-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    arrayItems= [NSMutableArray arrayWithObjects: @"My Profile", @"1 to 1", @"Groups", @"Request Group", @"Articles Library", @"Logout", nil];
    
    arrayItemImages= [NSMutableArray arrayWithObjects:@"myprofile.png", @"home.png", @"events.png", @"ques.png", @"library.png", @"logout.png", nil];
    
    
}


#pragma mark Table Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [arrayItems count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    
    SiteCellHome *cell = (SiteCellHome *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[SiteCellHome alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSInteger row = [indexPath row];
    
    
    
    cell.imageView.image = [UIImage imageNamed:arrayItemImages[row]];
    cell.primaryLabel.text =arrayItems[row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *selected = [arrayItems objectAtIndex:indexPath.row];
    
    if([selected isEqualToString:@"My Profile"])
    {
        EditProfileViewController *editProfileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"editProfileViewController"];
        
        [self presentViewController:editProfileViewController animated:YES completion:nil];
    }
    
    else if([selected isEqualToString:@"Articles Library"])
    {
        CategoriesViewController *categoriesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"categoriesViewController"];
        
        [self presentViewController:categoriesViewController animated:YES completion:nil];
    }
    
    else if([selected isEqualToString:@"Logout"])
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        ViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        
        [self presentViewController:loginViewController animated:YES completion:nil];
        
    }
    
    else if([selected isEqualToString:@"1 to 1"])
    {
        OneToOneViewController *oneToOneViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"oneToOneViewController"];
        
        [self presentViewController:oneToOneViewController animated:YES completion:nil];
        
    }
    
    else if([selected isEqualToString:@"Groups"])
    {
        RegionViewController *regionsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"regionsViewController"];
        
        [self presentViewController:regionsViewController animated:YES completion:nil];
        
    }
    
    else if([selected isEqualToString:@"Request Group"])
    {
        RequestEventEmailViewController *requestEmailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"requestEmailViewController"];
        
        [self presentViewController:requestEmailViewController animated:YES completion:nil];
        
    }
}

//If contact us icon is tapped
-(IBAction)contactUs:(id)sender
{
    NSString *mailString = [NSString stringWithFormat:@"mailto:info@recrespite.com"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailString]];
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
