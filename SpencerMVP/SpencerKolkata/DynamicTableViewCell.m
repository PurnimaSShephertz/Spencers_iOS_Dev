//
//  DynamicTableViewCell.m
//  DynamicCellHeight
//
//  Created by Timo Josten on 08/07/15.
//  Copyright (c) 2015 mkswap.net. All rights reserved.
//

#import "DynamicTableViewCell.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "Webmethods.h"
#import <QuartzCore/QuartzCore.h>

#define padding 20
@implementation DynamicTableViewCell

- (void)awakeFromNib
{
//    UIFont * customFont = [UIFont fontWithName:ProximaNovaSemibold size:12]; //custom font
//   // NSString * text = [self fromSender];
//    
//    CGSize labelSize = [text sizeWithFont:customFont constrainedToSize:CGSizeMake(380, 20) lineBreakMode:NSLineBreakByTruncatingTail];
//    
//    label = [[UILabel alloc]initWithFrame:CGRectMake(40, 15, 270, 40)];
//  
//    label.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
//    label.adjustsFontSizeToFitWidth = YES;
//    label.adjustsLetterSpacingToFitWidth = YES;
//    label.minimumScaleFactor = 10.0f/12.0f;
//    label.clipsToBounds = YES;
//    label.backgroundColor = [UIColor clearColor];
//    label.textColor = [UIColor blackColor];
//    label.textAlignment = NSTextAlignmentLeft;
//    [self.contentView  addSubview:label];
    
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        width1 = [UIScreen mainScreen].bounds.size.width;
        
         self.Name_Lbl = [[UILabel alloc] init];
        [self.Name_Lbl setFont:[UIFont systemFontOfSize:14.0]];
        [self.Name_Lbl setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.Name_Lbl];
        
        
        self.messageTextView = [[UITextView alloc] init];
        [self.messageTextView setBackgroundColor:[UIColor clearColor]];
        [self.messageTextView setEditable:NO];
        [self.messageTextView setScrollEnabled:NO];
        [self.messageTextView sizeToFit];
        self.messageTextView.textAlignment = NSTextAlignmentLeft;
        self.messageTextView.contentInset = UIEdgeInsetsZero;
        [self.contentView addSubview:self.messageTextView];
        
         self.nameAndDateLabel = [[UILabel alloc] init];
        [self.nameAndDateLabel setFont:[UIFont systemFontOfSize:14.0]];
        [self.nameAndDateLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.nameAndDateLabel];
        
        self.rateView = [[RateView alloc] init];
        self.rateView.userInteractionEnabled = NO;
        [self.contentView addSubview:self.rateView];
        
        }
    return self;
}

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

+ (CGFloat)heightForCellWithMessage:(NSString *)messagee
{
    NSString *text = messagee;
   CGFloat width1 = [UIScreen mainScreen].bounds.size.width;
    CGSize  textSize = {width1-40, 10000.0};
    
    NSUInteger height;
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.1")){
        CGRect rect = [text boundingRectWithSize:textSize
                                         options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                      attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} context:nil];
        rect.size.height += 60.0;
        height = rect.size.height;
        
    }
    else
    {
        CGSize size = [text sizeWithFont:[UIFont boldSystemFontOfSize:14]
                       constrainedToSize:textSize
                           lineBreakMode:NSLineBreakByWordWrapping];
        size.height += 60.0;
        height = size.height;
    }
    
    return height;
}

-(void)configureCellWithMessage:(NSDictionary *)comment and:(NSString *)value
{
    self.messageTextView.text=nil;
    self.Name_Lbl.text=nil;
    self.nameAndDateLabel.text=nil;
   
   self.messageTextView.text = [comment valueForKey:@"detail"];
   self.Name_Lbl.text = [comment valueForKey:@"nickname"];
   self.nameAndDateLabel.text=[NSString stringWithFormat:@"%@. %@",value,[comment valueForKey:@"title"]];
    
    
    self.rateView.notSelectedImage = [UIImage imageNamed:@"kermit_empty.png"];
    self.rateView.halfSelectedImage = [UIImage imageNamed:@"kermit_half.png"];
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"kermit_full.png"];
    self.rateView.rating = [[comment valueForKey:@"rating"] intValue];
    self.rateView.editable = YES;
    self.rateView.maxRating = 5;
    
    
    self.messageTextView.textColor=[UIColor blackColor];
    self.messageTextView.textAlignment = NSTextAlignmentLeft;
    CGSize textSize = { width1-40, 10000.0 };
    
    NSUInteger width;
    NSUInteger height;
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.1"))
    {
        CGRect rect = [self.messageTextView.text  boundingRectWithSize:textSize
                                                               options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                            attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} context:nil];
        rect.size.width += 50;
      
        width = rect.size.width;
        height = rect.size.height;
    }
    else
    {
//        CGSize size = [self.messageTextView.text sizeWithFont:[UIFont boldSystemFontOfSize:13]
//                                            constrainedToSize:textSize
//                                                lineBreakMode:NSLineBreakByWordWrapping];
        
        CGSize size = [self.messageTextView.text sizeWithAttributes:
                       @{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}];
        size.width += 50.0;
        width = size.width;
        
        
        height = size.height;
    }

    [self.nameAndDateLabel setFrame:CGRectMake(20,5, 200, 16)];
    [self.Name_Lbl setFrame:CGRectMake(20, 25, 200, 16)];
    
    [self.rateView setFrame:CGRectMake(self.frame.size.width/1.5, 3, 106, 22)];
    
    
    [self.messageTextView setFrame:CGRectMake(15, 40, width-30, height)];
    [self.messageTextView sizeToFit];
    
    
}


@end
