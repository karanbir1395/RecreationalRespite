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
@synthesize tfCost,tfDate,tfName,tfAddress,tfEndTime,tfSeatsLeft,tfStartTime,tvDescription,scrollView, rememberContentOffset;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self setLabels];
    [scrollView setScrollEnabled:YES];
    
    [tfCost setDelegate:self];
    [tfSeatsLeft setDelegate:self];
    [tfAddress setDelegate:self];
    [tfEndTime setDelegate:self];
    [tfStartTime setDelegate:self];
    [tfName setDelegate:self];
    [tfDate setDelegate:self];
    [tfDescription setDelegate:self];
    
    
    
    
    [self setTextboxLayout];
    
}

//Set text field custom layout
-(void) setTextboxLayout
{
    
    CALayer *border = [CALayer layer];
    
    
    CGFloat borderWidth = 2;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.borderWidth = borderWidth;
    border.frame = CGRectMake(0, tfName.frame.size.height - borderWidth, tfName.frame.size.width, tfName.frame.size.height);
    [tfName.layer addSublayer:border];
    tfName.layer.masksToBounds = YES;
    
    CALayer *border2 = [CALayer layer];
    border2.borderColor = [UIColor lightGrayColor].CGColor;
    border2.borderWidth = borderWidth;
    border2.frame = CGRectMake(0, tfDate.frame.size.height - borderWidth, tfDate.frame.size.width, tfDate.frame.size.height);
    [tfDate.layer addSublayer:border2];
    tfDate.layer.masksToBounds = YES;
    
    CALayer *border3 = [CALayer layer];
    border3.borderColor = [UIColor lightGrayColor].CGColor;
    border3.borderWidth = borderWidth;
    border3.frame = CGRectMake(0, tfStartTime.frame.size.height - borderWidth, tfStartTime.frame.size.width, tfStartTime.frame.size.height);
    [tfStartTime.layer addSublayer:border3];
    tfStartTime.layer.masksToBounds = YES;
    
    CALayer *border4 = [CALayer layer];
    border4.borderColor = [UIColor lightGrayColor].CGColor;
    border4.borderWidth = borderWidth;
    border4.frame = CGRectMake(0, tfEndTime.frame.size.height - borderWidth, tfEndTime.frame.size.width, tfEndTime.frame.size.height);
    [tfEndTime.layer addSublayer:border4];
    tfEndTime.layer.masksToBounds = YES;
    
    CALayer *border5 = [CALayer layer];
    border5.borderColor = [UIColor lightGrayColor].CGColor;
    border5.borderWidth = borderWidth;
    border5.frame = CGRectMake(0, tfAddress.frame.size.height - borderWidth, tfAddress.frame.size.width, tfAddress.frame.size.height);
    [tfAddress.layer addSublayer:border5];
    tfAddress.layer.masksToBounds = YES;
    
    CALayer *border6 = [CALayer layer];
    border6.borderColor = [UIColor lightGrayColor].CGColor;
    border6.borderWidth = borderWidth;
    border6.frame = CGRectMake(0, tfSeatsLeft.frame.size.height - borderWidth, tfSeatsLeft.frame.size.width, tfSeatsLeft.frame.size.height);
    [tfSeatsLeft.layer addSublayer:border6];
    tfSeatsLeft.layer.masksToBounds = YES;
    
    CALayer *border7 = [CALayer layer];
    border7.borderColor = [UIColor lightGrayColor].CGColor;
    border7.borderWidth = borderWidth;
    border7.frame = CGRectMake(0, tfCost.frame.size.height - borderWidth, tfCost.frame.size.width, tfCost.frame.size.height);
    [tfCost.layer addSublayer:border7];
    tfCost.layer.masksToBounds = YES;
    
    CALayer *border8 = [CALayer layer];
    border8.borderColor = [UIColor lightGrayColor].CGColor;
    border8.borderWidth = borderWidth;
    border8.frame = CGRectMake(0, tfDescription.frame.size.height - borderWidth, tfDescription.frame.size.width, tfDescription.frame.size.height);
    [tfDescription.layer addSublayer:border8];
    tfDescription.layer.masksToBounds = YES;
    
    
}

//Set label values from App Delegate
-(void)setLabels
{
    NSString *imageLink = mainDelegate.passEventImage;
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageLink]];
        
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            imgView.image = [UIImage imageWithData: data];
        });
    });
    
    tfName.text = mainDelegate.passEventName;
    tfDescription.text = mainDelegate.passEventDescription;
    tfDate.text = mainDelegate.passEventDate;
    tfStartTime.text = mainDelegate.passEventStartTime;
    tfEndTime.text = mainDelegate.passEventEndTime;
    tfAddress.text = mainDelegate.passEventAddress;
    tfSeatsLeft.text = mainDelegate.passEventSeats;
    tfCost.text = [NSString stringWithFormat:@"%@", mainDelegate.passEventCost];
    
}


//SCROLL VIEW METHODS
- (void) viewDidAppear:(BOOL)animated {
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width *1, self.view.frame.size.height*1)];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    self.scrollView.contentOffset = CGPointMake(0, 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    self.rememberContentOffset = self.scrollView.contentOffset;
    [super viewWillDisappear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.contentOffset = CGPointMake(0, self.rememberContentOffset.y);
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
