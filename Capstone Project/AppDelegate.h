//
//  AppDelegate.h
//  Capstone Project
//
//  Created by iOS Xcode User on 2016-03-19.
//  Copyright © 2016 Karanbir Singh Mann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString *passUsernametoNextScreen;
    NSString *passSelectedArticleFromLibrary;
    
    NSString *passEventName;
    NSString *passEventDate;
    
    NSString *passEventStartTime;
    NSString *passEventEndTime;
    NSString *passEventAddress;
    NSString *passEventSeats;
    NSString *passEventDescription;
    NSString *passEventImage;
    
    NSString *passParticipantName_Regis;
    NSString *passUserEmail_Regis;
    NSString *passUserPhone_Regis;
    NSString *passParticipantAge_Regis;
    NSString *passEventLocation_Regis;
    NSString *passEventName_Regis;
    NSString *passEventId;
    
    NSString *usernameLoggedIn;

}

@property(strong, nonatomic) NSString *passUsernametoNextScreen;
@property(strong, nonatomic) NSString *passSelectedArticleFromLibrary;

@property(strong, nonatomic) NSString *passEventName;
@property(strong, nonatomic) NSString *passEventDate;
@property(strong, nonatomic) NSString *passEventStartTime;
@property(strong, nonatomic) NSString *passEventEndTime;
@property(strong, nonatomic) NSString *passEventAddress;
@property(strong, nonatomic) NSString *passEventSeats;
@property(strong, nonatomic) NSString *passEventDescription;
@property(strong, nonatomic) NSString *passEventImage;

@property(strong, nonatomic) NSString *passParticipantName_Regis;
@property(strong, nonatomic) NSString *passUserEmail_Regis;
@property(strong, nonatomic) NSString *passUserPhone_Regis;
@property(strong, nonatomic) NSString *passParticipantAge_Regis;
@property(strong, nonatomic) NSString *passEventLocation_Regis;
@property(strong, nonatomic) NSString *passEventName_Regis;
@property(strong, nonatomic) NSString *passEventId;

@property(strong, nonatomic) NSString *usernameLoggedIn;

@property (strong, nonatomic) UIWindow *window;

// @property (strong, nonatomic) NSMutableArray *options;

@end

