//
//  InCartCell.h
//  Spencer
//
//  Created by binary on 02/07/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InCartCell : UITableViewCell
{
    
}

@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *qty;
@property (strong, nonatomic) IBOutlet UILabel *count;
@property (strong, nonatomic) IBOutlet UILabel *mrp;
@property (strong, nonatomic) IBOutlet UILabel *sp;
@property (strong, nonatomic) IBOutlet UIButton *plusObj;
@property (strong, nonatomic) IBOutlet UIButton *minusObj;

@property (strong, nonatomic) IBOutlet UIButton *modifyBtnObj;

@property (strong, nonatomic) IBOutlet UILabel *mrpCrossLbl;

@property (strong, nonatomic) IBOutlet UILabel *statusLbl;

@property (strong, nonatomic) IBOutlet UIButton *deleteBtnObj;

@end
