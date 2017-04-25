//
//  Result.h
//  MeraGrocer
//
//  Created by Binarysemantics  on 7/30/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "GAI.h"
#import "ResultCell.h"
#import "GAI.h"

@interface Result : GAITrackedViewController <UITableViewDataSource, UITableViewDelegate>
{
    CGFloat width ;
    CGFloat height ;
    CGFloat screenX ;
    CGFloat screenY ;
    
    IBOutlet UILabel *nameLbl;
    IBOutlet UILabel *orderNoLbl;
    IBOutlet UILabel *deliveryScheduleLbl;
    IBOutlet UILabel *deliveryAddressLbl;
    IBOutlet UILabel *billingEmailLbl;
    IBOutlet UILabel *paymentMethodLbl;
    IBOutlet UITableView *myOrderTblVew;
    IBOutlet ResultCell *resultCel;
    IBOutlet UIButton * Continue_obj;
}

@property (nonatomic, strong) NSString *paymentMethodStr;
- (IBAction)backToShoppingBtnAct:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *lbl1;
@property (strong, nonatomic) IBOutlet UILabel *lbl2;
@property (strong, nonatomic) IBOutlet UILabel *lbl3;
@property (strong, nonatomic) NSString *incrementID_str;

@end
