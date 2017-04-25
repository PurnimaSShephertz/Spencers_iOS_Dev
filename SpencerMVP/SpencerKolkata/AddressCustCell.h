//
//  AddressCustCell.h
//  Spencer
//
//  Created by Binary Semantics on 7/8/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressCustCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *Address_lbl;
@property (strong, nonatomic) IBOutlet  UIButton * Delete_obj,* Edir_obj, *selectionBtnObj;
@property (strong, nonatomic) IBOutlet UIImageView *bgImgVew;
@property (strong, nonatomic) IBOutlet UIView * BackView;
@end
