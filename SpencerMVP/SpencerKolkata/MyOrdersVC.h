//
//  MyOrdersVC.h
//  MeraGrocer
//
//  Created by Binarysemantics  on 6/12/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrdersCell.h"

#import "ToastAlert.h"

#import "OrderDetailsVC.h"
#import "GAI.h"

#import "VSDropdown.h"

#import "SVProgressHUD.h"

@interface MyOrdersVC : GAITrackedViewController <UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate, VSDropdownDelegate>
{
    VSDropdown *_dropdown;
    NSMutableArray *myOrdersArray;
    IBOutlet UITableView *myOrderTblVew;
//    NSDictionary * orders_Dict;
    NSMutableArray *orders_Arr;
    NSArray *orderKeyArr;
    OrderDetailsVC *orderDetailsVC;
     IBOutlet UIView * footer_View;
    IBOutlet UIButton *offerObj;
}

@property (strong, nonatomic) NSDictionary * orders_Dict;

@property (strong, nonatomic) IBOutlet MyOrdersCell *myOrdersCell;


@property (nonatomic, retain) IBOutlet UIButton *menuBtnObj, *searchBtnObj, *cartBtnObj, *myProfileBtnObj, *logoLargeBtn;
@property (strong, nonatomic) IBOutlet UITextField *searchBar;

@property (strong, nonatomic) IBOutlet UIImageView *logoLargeImg, *logoSmallImg, *footerImg, *myProfileImg;
@property (strong, nonatomic) IBOutlet UILabel *bangeLbl;
@property (strong, nonatomic) IBOutlet UIImageView *searchBg;
@property (nonatomic, retain) NSDictionary *offerUrlDict;

- (IBAction)menuBtnAct:(UIButton *)sender;
- (IBAction)deleteMyOrdersBtnAct:(UIButton *)sender;


@end
