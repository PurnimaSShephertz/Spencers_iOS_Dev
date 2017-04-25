//
//  RegistrationVC.h
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

@interface RegistrationVC : GAITrackedViewController <REFrostedViewControllerDelegate>
{
    IBOutlet UILabel *loginLbl, *signUpLbl;
    IBOutlet UITextField *firstNameTxtFld, * emailTxtFld, *passwordTxtFld, *lastNameTxtFld, *mobileNoTxtFld;
    IBOutlet UIButton *loginBtnObj, *skipBtnObj, *signUpBtnObj;
    IBOutlet UIView *otpView;
    IBOutlet UIView *otpBgVew;
    IBOutlet UITextField *enterOTPTxtFld;
    IBOutlet UIButton *resendOtpBtnObj;
}
@property (nonatomic, retain) NSString *Skipcheck;
- (IBAction)resendOtpBtnAct:(UIButton *)sender;

-(IBAction)loginBtnAct:(UIButton *)sender;
-(IBAction)signUpBtnAct:(UIButton *)sender;
-(IBAction)skipBtnAct:(UIButton *)sender;

- (IBAction)otpCancelBtnAct:(UIButton *)sender;
- (IBAction)otpVerifyBtnAct:(UIButton *)sender;

@property  (nonatomic,retain) NSString * checkLoginFromCheckout, *checkLoginFromProfilepage, *CheckProfileStatus, *checkdrawermenu, *sessionExpireStr;

@end
