//
//  DynamicTableViewCell.h
//  DynamicCellHeight
//
//  Created by Timo Josten on 08/07/15.
//  Copyright (c) 2015 mkswap.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"
@interface DynamicTableViewCell : UITableViewCell
{
    CGFloat width1;
    
}
@property (retain, nonatomic) IBOutlet RateView *rateView;

@property (nonatomic,retain) UILabel *Name_Lbl,*nameAndDateLabel;
@property (nonatomic,retain) UITextView  *messageTextView;

+ (CGFloat)heightForCellWithMessage:(NSString *)messagee;
-(void)configureCellWithMessage:(NSDictionary *)comment and:(NSString *)value;
@end
