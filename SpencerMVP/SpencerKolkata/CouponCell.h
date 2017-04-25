//
//  CouponCell.h
//  Spencer
//
//  Created by Binary Semantics on 8/4/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name_lbl,*description_lbl,*code_lbl;
@property (strong, nonatomic) IBOutlet UIButton * coupon_obj;
@end
