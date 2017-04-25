//
//  OrderReviewCell.h
//  Spencer
//
//  Created by Binary Semantics on 7/9/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderReviewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *img;
@property (strong, nonatomic) IBOutlet UIImageView *productimg;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *mrp;
@property (strong, nonatomic) IBOutlet UILabel *sp;
@property (strong, nonatomic) IBOutlet UILabel *count;

@end
