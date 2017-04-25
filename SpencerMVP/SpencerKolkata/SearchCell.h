//
//  SearchCell.h
//  MeraGrocer
//
//  Created by binary on 14/06/16.
//  Copyright © 2016 Binarysemantics . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *DetailProductsLbl;
@property (strong, nonatomic) IBOutlet UILabel *numberOfItems;
@property (strong, nonatomic) IBOutlet UIImageView *productDetailsImg,*wishimg;

@property (strong, nonatomic) IBOutlet UILabel *minMaxLbl;

@property (strong, nonatomic) IBOutlet UIButton *minusBtnObj;
@property (strong, nonatomic) IBOutlet UIButton *plusBtnObj;
@property (strong, nonatomic)IBOutlet  UIImageView * imageplus,*imageminus;

@property (strong, nonatomic) IBOutlet UIButton *kgBtnObj;
@property (strong, nonatomic) IBOutlet UILabel *saveLbl;

@property (strong, nonatomic) IBOutlet UIButton *addCartBtnObj;

@property (strong, nonatomic) IBOutlet UIImageView *dropDownImg,*plus_img;

@property (strong, nonatomic) IBOutlet UILabel *rateImgLbl;


@property (strong, nonatomic) IBOutlet UILabel *promotionLbl;


@property (strong, nonatomic) IBOutlet UIButton *productDetailsBtnObj;

@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *qty;
@property (strong, nonatomic) IBOutlet UILabel *count;
@property (strong, nonatomic) IBOutlet UILabel *mrp;
@property (strong, nonatomic) IBOutlet UILabel *sp;
@property (strong, nonatomic) IBOutlet UIButton *plusObj;
@property (strong, nonatomic) IBOutlet UIButton *minusObj;


@property (strong, nonatomic) IBOutlet UILabel *mrpCutLbl;



@end
