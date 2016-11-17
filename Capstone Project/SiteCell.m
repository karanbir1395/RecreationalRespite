//
//  SiteCell.m
//  Nibs And Tables 2
//
//  Created by Jawaad Sheikh on 2016-03-14.
//  Copyright © 2016 Jawaad Sheikh. All rights reserved.
//

#import "SiteCell.h"

@implementation SiteCell
@synthesize primaryLabel, secondaryLabel, myImageView;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        primaryLabel = [[UILabel alloc] init];
        primaryLabel.textAlignment = NSTextAlignmentLeft;
         if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
             primaryLabel.font = [UIFont systemFontOfSize:36];
        else
            primaryLabel.font = [UIFont systemFontOfSize:18];
        primaryLabel.backgroundColor = [UIColor clearColor];
        primaryLabel.textColor = [UIColor blackColor];
        
        secondaryLabel = [[UILabel alloc] init];
        secondaryLabel.textAlignment = NSTextAlignmentLeft;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            secondaryLabel.font = [UIFont systemFontOfSize:24];
        else
            secondaryLabel.font = [UIFont systemFontOfSize:12];
        secondaryLabel.backgroundColor = [UIColor clearColor];
        secondaryLabel.textColor = [UIColor blueColor];
        
        myImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:myImageView];
        [self.contentView addSubview:primaryLabel];
        [self.contentView addSubview:secondaryLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        frame = CGRectMake(15, 15, 80, 80);
        myImageView.frame = frame;
    
        frame = CGRectMake(200, 15, 460, 40);
        primaryLabel.frame = frame;
    
        frame = CGRectMake(200, 60, 460, 40);
        secondaryLabel.frame = frame;
    }
    else
    {
        frame = CGRectMake(5, 5, 65, 45);
        myImageView.frame = frame;
        
        frame = CGRectMake(110, 5, 260, 20);
        primaryLabel.frame = frame;
        
        frame = CGRectMake(110, 30, 260, 20);
        secondaryLabel.frame = frame;
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
