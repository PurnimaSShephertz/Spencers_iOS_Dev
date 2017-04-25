//
//  PaymentInfoVC.h
//  Spencer
//
//  Created by binary on 13/07/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpViewController.h"
#import "ResetPasswordViewController.h"
#import "SignInViewController.h"
#import <CitrusPay/CitrusPay.h>
#import "BaseViewController.h"
#import "UIKeyboardViewController.h"

#import "PaymentsSDK.h"

@interface PaymentInfoVC : BaseViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIKeyboardViewControllerDelegate, PGTransactionDelegate>
{
    BOOL rewardCheck;
    IBOutlet UITableView *paymentTblVew;
    IBOutlet UILabel *grandTotalLbl;
    IBOutlet UILabel *walletAmountLbl;
    CGFloat ScreenWidth,ScreenHeight;
    
    CTSWalletScope scopeType;
    IBOutlet UIButton *walletCheckBoxBtnObj;
    BOOL walletFlag;
    IBOutlet UITextField *creditTxtFld;
    
    NSString * Data;
    IBOutlet UIButton * remove_obj,*reedem_obj,*back_obj,*backobj;
    NSString * checkstatus;
    NSString * chekWalletstatus, *chekSRCstatus;
    NSString * finalAmount, * srcFinalAmount;
    
    NSDictionary *userProfileData;
    
    UILabel * walletLbl;
    
    BOOL redeemRemoveBool;
    BOOL srcRedeemRemoveBool;
    
    
    IBOutlet UIButton *srcCheckBoxBtnObj;
    IBOutlet UILabel *srcAmountLbl;
    IBOutlet UIButton *srcRemove_Obj, *srcReedem_Obj;
    
    IBOutlet UIButton *srcBackobj, *srcBack_obj;
    
    IBOutlet UIImageView *smartRewardImgVew;
    
    IBOutlet UIView *smartRewardVew;
    
    BOOL smartRewardFlag;
    
    IBOutlet UIButton *enrolSubmitBtnObj;
    IBOutlet UITextField *crmTxtFld;
    
}

@property (nonatomic, retain) NSString *grandTotalStr;
- (IBAction)walletCheckBoxBtnAct:(UIButton *)sender;
-(IBAction)reedem_Act:(id)sender;
-(IBAction)Remove_Act:(id)sender;
-(IBAction)Proceed_Act:(id)sender;

- (IBAction)srcReedem_Act:(UIButton *)sender;
- (IBAction)srcRemove_Act:(UIButton *)sender;
- (IBAction)srcProceed_Act:(UIButton *)sender;

- (IBAction)enrollSmartRewardBtnAct:(UIButton *)sender;
- (IBAction)rewardSubmitBtnAct:(UIButton *)sender;

@end
