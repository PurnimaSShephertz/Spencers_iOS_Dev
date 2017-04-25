//
//  OrderDetailsCell.h
//  MeraGrocer
//
//  Created by Binarysemantics  on 6/29/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *priceLbl;
@property (strong, nonatomic) IBOutlet UILabel *quantityLbl;

@end
