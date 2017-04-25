//
//  OrderDetailsVC.h
//  MeraGrocer
//
//  Created by Binarysemantics  on 6/25/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailsCell.h"
//#import "GAI.h"
#import "SVProgressHUD.h"
#import "GAI.h"

@interface OrderDetailsVC : GAITrackedViewController <UITableViewDataSource , UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
{
    NSString *billingStr, *shippingStr;
    
    IBOutlet UIButton *offerObj;
    
    IBOutlet UILabel *DiscountLbl;
    IBOutlet UILabel *totalAmountLbl;
    IBOutlet UIButton *editOrderBtnObj;
    IBOutlet UILabel *slotTimeTitLbl;
    IBOutlet UILabel *deliveryDateLbl;
    IBOutlet UILabel *deliveryTimeLbl;
}
@property (strong, nonatomic) IBOutlet UILabel *mobileNoTitLbl;
@property (strong, nonatomic) IBOutlet UILabel *mobileNoLbl;
@property (nonatomic, retain) IBOutlet UILabel *orderNumberTitLbl, *customerNameTitLbl, *statusTitLbl, *orderDateTitLbl, *orderNumberLbl, *customerNameLbl, *statusLbl, *orderDateLbl, *billingAddresTitLbl, *shippingAddressTitLbl, *shippingMethodTitLbl, *paymentMethodTitLbl, *shippingMethodLbl, *paymentMethodLbl, *itemsOrderedLbl;
@property (nonatomic, retain) IBOutlet UITextView *shippingAddressTxtVew, *billingAddressTxtVew;
@property (nonatomic, retain) IBOutlet UITableView *orderDetailsTblVew;
@property (nonatomic, strong) NSMutableArray *orderArr;
@property (nonatomic, strong) NSString *orderkeyStr;

@property (nonatomic, retain) IBOutlet UIButton *menuBtnObj, *logoLargeBtn;
@property (strong, nonatomic) IBOutlet OrderDetailsCell *orderDetailsCell;


- (IBAction)menuBtnAct:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIButton *reorderBtnObj;
- (IBAction)reorderBtnAct:(UIButton *)sender;
- (IBAction)editOrderBtnAct:(UIButton *)sender;

@end
