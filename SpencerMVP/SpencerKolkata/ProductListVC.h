//
//  ProductListVC.h
//  Spencer
//
//  Created by binary on 06/07/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductVC.h"
//#import "MyProfileVC.h"
//#import "MBProgressHUD.h"
#import "SearchVC.h"

//#import "GAI.h"
#import "VSDropdown.h"

#import "ACPScrollMenu.h"
#import "GAI.h"


@interface ProductListVC : GAITrackedViewController <UITextFieldDelegate, VSDropdownDelegate, ACPScrollDelegate, UITableViewDataSource, UITableViewDelegate>
{
    
    CGFloat width ;
    CGFloat height ;
    CGFloat screenX ;
    CGFloat screenY ;
    
    VSDropdown *_dropdown;
    IBOutlet UITableView *itemListTblVew;
    NSMutableDictionary *productDetailsDict;
    NSMutableDictionary *kgIndexDict;
    NSMutableArray *productDetailsArray;
    BOOL selected;
    int pageNumber;
    
    IBOutlet UIButton *offerObj;
    
    ACPScrollMenu *_scrollMenu;
    
    SearchVC *searchVC;
                 
    IBOutlet UISearchBar *searchBar1;
    UITextField *searchBar;
    UIView * headerView;
    IBOutlet UIButton *viewAllBtnObj;
    
    int valuecheck;
}

- (IBAction)viewAllButtonAct:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UILabel *headerLbl;

@property (nonatomic, retain) NSMutableArray *productListArray, *listImageArray, *preservedListArray;
@property (nonatomic, retain) NSString *menuHeader, *productHeader, *headerTitleStr;

@property (nonatomic, retain) IBOutlet UIButton *menuBtnObj, *searchBtnObj, *cartBtnObj, *myProfileBtnObj, *logoLargeBtn;
@property (strong, nonatomic) IBOutlet UIImageView *searchBg;
@property (strong, nonatomic) IBOutlet UIImageView *logoLargeImg,*logoSmallImg, *footerImg, *myProfileImg;
@property (strong, nonatomic) IBOutlet UILabel *bangeLbl;

- (IBAction)menuBtnAct:(UIButton *)sender;

@property (strong, nonatomic) ProductVC *productVC;
- (IBAction)backBtnAct:(UIButton *)sender;

- (IBAction)inCartBtnAct:(UIButton *)sender;

@property (assign) int catId;

@end
