//
//  ProfileView.h
//  CustomMenu
//
//  Created by Binary Semantics on 6/9/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKeyboardViewController.h"
#import "Webmethods.h"
//#import "GAI.h"
#import "SVProgressHUD.h"
#import "GAI.h"

@interface ProfileView : GAITrackedViewController <UIKeyboardViewControllerDelegate, UITextFieldDelegate>
{
    
    CGRect textFieldFrame;
    IBOutlet UIButton * backbutt;
    UIKeyboardViewController *keyBoardController;
    IBOutlet UITextField * field1,*field2,*field3,*field4,*field5,*field6, *field7;
    NSDictionary * Customer_Dict,* UpdateCustomer_Dict;
    NSString * CustomerDetails_Str;
    IBOutlet UILabel * Userdails_Lbl,*profileheader_Lbl;;
    IBOutlet UIView * ChangepasswordView;
    IBOutlet UIButton *radio_button;
    IBOutlet UIImageView * changepass_img;
    IBOutlet UILabel * changepassheader_lbl;
    BOOL pos;
    IBOutlet UIView * footer_View;
    
    IBOutlet UIButton *offerObj;
    NSDictionary *DictFinal;
    
    BOOL viewMoved, keyboardShown;
    
    IBOutlet UIView *editView;
    
    IBOutlet UILabel *locationLbl;
    
    IBOutlet UIButton *updateBtnObj;
    IBOutlet UIButton *saveBtnObj;
    IBOutlet UIButton *cancelBtnObj;
    
    
    IBOutlet UIView *otpView;
    IBOutlet UIView *otpBgVew;
    IBOutlet UITextField *enterOTPTxtFld;
    IBOutlet UIButton *resendOtpBtnObj;

    IBOutlet UILabel *srcPointLbl;
    IBOutlet UILabel *srcAmountLbl;
    
}

@property (nonatomic, assign) BOOL isKeyboradShow;
@property (nonatomic, retain) IBOutlet UIButton *logoLargeBtn;

@property (nonatomic, retain) IBOutlet UIButton *menuBtnObj, *searchBtnObj, *cartBtnObj, *myProfileBtnObj;
@property (strong, nonatomic) IBOutlet UILabel *bangeLbl;
@property (strong, nonatomic) IBOutlet UIImageView *footerImg;


- (IBAction)backBtnAct:(UIButton *)sender;
-(IBAction)Edit_butt:(id)sender;
-(IBAction)Update_butt:(id)sender;
-(IBAction)save_butt:(id)sender;


- (IBAction)menuBtnAct:(UIButton *)sender;
-(IBAction)radio_button:(id)sender;
- (IBAction)cancel_btn:(UIButton *)sender;


- (IBAction)resendOtpBtnAct:(UIButton *)sender;
- (IBAction)otpCancelBtnAct:(UIButton *)sender;
- (IBAction)otpVerifyBtnAct:(UIButton *)sender;

@end
