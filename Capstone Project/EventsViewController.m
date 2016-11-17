//
//  EventsViewController.m
//  Capstone Project
//
//  Created by Karanbir Singh Mann on 2016-11-04.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import "EventsViewController.h"

@interface EventsViewController ()

@end

@implementation EventsViewController
@synthesize lblDate,lblName,lblAddress,lblEndTime,lblSeatsLeft,lblStartTime,lblDescription;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLabels];
}

-(void)setLabels
{
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *imageLink = mainDelegate.passEventImage;
    
    // imgView = [[UIImageView alloc]init];
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageLink]];
        
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            imgView.image = [UIImage imageWithData: data];
        });
    });

    lblName.text = mainDelegate.passEventName;
    lblDescription.text = mainDelegate.passEventDescription;
    lblDate.text = mainDelegate.passEventDate;
    lblStartTime.text = mainDelegate.passEventStartTime;
    lblEndTime.text = mainDelegate.passEventEndTime;
    lblAddress.text = mainDelegate.passEventAddress;
    lblSeatsLeft.text = mainDelegate.passEventSeats;
    
    
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
