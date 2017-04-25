//
//  LoginVC.h
//  SpencerKolkata
//
//  Created by binary on 30/06/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DEMOMenuViewController.h"
#import "DEMONavigationController.h"
#import "REFrostedViewController.h"

#import "GAI.h"

@interface LoginVC : GAITrackedViewController <REFrostedViewControllerDelegate, UIAlertViewDelegate>
{
    IBOutlet UILabel *loginLbl, *signUpLbl;
    IBOutlet UITextField *emailTxtFld, *passwordTxtFld;
    IBOutlet UIButton *loginBtnObj, *skipBtnObj, *signUpBtnObj;
    NSDictionary *Customer_Dict;
    UILabel *bangeLbl;
    
    
    IBOutlet UIView *otpView;
    IBOutlet UIView *otpBgVew;
    IBOutlet UITextField *enterOTPTxtFld;
    IBOutlet UIButton *resendOtpBtnObj;
    IBOutlet UIView *mobileNoVew;
    IBOutlet UITextField *mobileNoTxtFld;
    
    
    NSString * firstNameStr, *lastNameStr, *emailStr, *crmIdStr, *mobileNumberStr, *otpStr, *customerIdStr;
}
- (IBAction)mobileCancelBtnAct:(UIButton *)sender;
- (IBAction)mobileNoSubmitBtnAct:(UIButton *)sender;

-(IBAction)loginBtnAct:(UIButton *)sender;
-(IBAction)skipBtnAct:(UIButton *)sender;
-(IBAction)signUpBtnAct:(UIButton *)sender;
-(IBAction)forgot_butt:(id)sender;
@property  (nonatomic,retain) NSString * checkLoginFromCheckout, *checkLoginFromProfilepage, *CheckProfileStatus, *checkdrawermenu, *sessionExpireStr;

- (IBAction)resendOtpBtnAct:(UIButton *)sender;
- (IBAction)otpCancelBtnAct:(UIButton *)sender;
- (IBAction)otpVerifyBtnAct:(UIButton *)sender;

@end
