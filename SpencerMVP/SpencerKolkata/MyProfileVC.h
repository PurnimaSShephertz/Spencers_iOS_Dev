//
//  MyProfileVC.h
//  CustomMenu
//
//  Created by Binarysemantics  on 6/8/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileView.h"
#import "MyOrdersVC.h"
#import "LoginVC.h"
#import "AddressVC.h"
#import "UIKeyboardViewController.h"
//#import "GAI.h"

#import "VSDropdown.h"
#import "SVProgressHUD.h"
#import "MainCategoryVC.h"
#import "GAI.h"

@interface MyProfileVC : GAITrackedViewController < UITextFieldDelegate,UIKeyboardViewControllerDelegate, VSDropdownDelegate>
{
    IBOutlet UIImageView *footerImg;
    IBOutlet UITableView * profile_table;
    NSMutableArray * Profile_Arry,* profileimages_array;
    IBOutlet UIButton * searchBtnObj;
     NSDictionary *Customer_Dict;
     UIKeyboardViewController *keyBoardController;
    IBOutlet UILabel *lbl1;
    
    IBOutlet UILabel *lbl6;
    IBOutlet UILabel *lbl2;
    IBOutlet UILabel *lbl3;
    IBOutlet UILabel *lbl4;
    IBOutlet UILabel *lbl5;
    IBOutlet UIImageView *Check_Box_image;
    IBOutlet UIButton *Newsletter_button;
    BOOL checkbox_check;
    
    
    IBOutlet UILabel *lbl7;
    NSUserDefaults *temp;
    NSString * oauth_token;
    NSString * oauth_token_secret;
    
    IBOutlet UIButton *offerObj;
    IBOutlet UITextField * Pin_Txt;
    IBOutlet UIView * launchView;
    IBOutlet UILabel *locationLbl;
     NSDictionary * DictFinal;
    MainCategoryVC *homeVC;
    
    
    
    NSMutableDictionary * inCartDict;
    NSMutableArray * inCartArr;
}
- (IBAction)searchBtnAct:(UIButton *)sender;
- (IBAction)backBtnAct:(UIButton *)sender;
- (IBAction)cartBtnAct:(UIButton *)sender;
- (IBAction)settingBtnAct:(UIButton *)sender;



@property (nonatomic, retain) IBOutlet UIButton *menuBtnObj, *searchBtnObj, *cartBtnObj, *myProfileBtnObj, *logoLargeBtn;
@property (strong, nonatomic) IBOutlet UIImageView *searchBg;
@property (strong, nonatomic) IBOutlet UITextField *searchBar;
@property (strong, nonatomic) IBOutlet UIImageView *logoLargeImg, *logoSmallImg, *footerImg, *myProfileImg;
@property (strong, nonatomic) IBOutlet UILabel *bangeLbl;
@property (strong, nonatomic) IBOutlet UIButton *offerBtnObj;
@property (strong, nonatomic) IBOutlet UIButton *Skip_Obj;

@property (strong, nonatomic) IBOutlet UIButton *Pin_Save;
- (IBAction)Submit_Pin:(id)sender;
- (IBAction)SkipButton:(id)sender;
- (IBAction)menuBtnAct:(UIButton *)sender;
- (IBAction)Myprofile_button:(id)sender;
- (IBAction)Myorders_button:(id)sender;
- (IBAction)Mycredits_button:(id)sender;
- (IBAction)MyaddresBook_button:(id)sender;
- (IBAction)Newsletter_button:(id)sender;
- (IBAction)Log_Out:(id)sender;
- (IBAction)Location:(id)sender;

@end
