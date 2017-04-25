//
//  InCartVC.h
//  Spencer
//
//  Created by binary on 02/07/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InCartCell.h"
#import "GAI.h"

@interface InCartVC : GAITrackedViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
{
    
    CGFloat width ;
    CGFloat height ;
    CGFloat screenX ;
    CGFloat screenY ;
    
    NSDictionary *inCartDict;
    NSArray *inCartArr;
    IBOutlet UIView *priceView;
    
    IBOutlet UISearchBar *searchBar1;
    IBOutlet UITableView *inCartTblVew;
    IBOutlet InCartCell *inCartCell;
    
    IBOutlet UILabel *coupanLbl;
    IBOutlet UITextField * Coupon_TXT;
    NSUserDefaults *temp;
    NSString *storeIdStr;
    NSDictionary * CouPonResponse_Dict;
    BOOL applyBool;
    IBOutlet UILabel *bangeLbl;
    IBOutlet UILabel *subTotalLbl;
    IBOutlet UIView *bottomView;
    IBOutlet UIButton *currentLocationBtnObj;
    
    NSString * oauth_token;
    
    NSMutableDictionary *cartItemCountDict;
    IBOutlet UIButton *addMoreProductInCartBtnObj;
    IBOutlet UILabel *myCartCountLbl;
    int deleteIndex;
}
@property (strong, nonatomic) NSString *loginNav;
@property (strong, nonatomic) IBOutlet UIButton *RemoveCouonObj;
@property (strong, nonatomic) IBOutlet UIButton *placeToOrderObj;
@property (nonatomic, retain) IBOutlet UIButton *backBtnObj, *searchBtnObj, *cartBtnObj, *myProfileBtnObj,*applyBtnobj,*continueShopingBtnObj, *logoLargeBtn,*applytxt;
- (IBAction)backBtnAct:(UIButton *)sender;
- (IBAction)menuBtnAct:(UIButton *)sender;

- (IBAction)minusAct:(UIButton *)sender;
- (IBAction)plusAct:(UIButton *)sender;

- (IBAction)footerBtnAct:(UIButton *)sender;

@property (nonatomic, assign) BOOL isKeyboradShow;
- (IBAction)currentLocationBtnAct:(UIButton *)sender;


- (IBAction)modifyBtnAct:(UIButton *)sender;
- (IBAction)addMoreProductInCartBtnAct:(UIButton *)sender;

- (IBAction)deleteBtnObj:(UIButton *)sender;

@end
