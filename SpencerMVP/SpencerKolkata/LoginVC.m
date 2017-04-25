//
//  LoginVC.m
//  SpencerKolkata
//
//  Created by binary on 30/06/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "LoginVC.h"
#import "RegistrationVC.h"
#import "Webmethods.h"
#import "SVProgressHUD.h"
#import "MainCategoryVC.h"
#import "YourLocationVC.h"
#import "AppDelegate.h"
#import "MyProfileVC.h"
#import "InCartVC.h"
#import "MainCategoryVC.h"
#import "IQKeyboardManager.h"
#import "ForgotVC.h"
#import "SH_TrackingUtility.h"


@interface LoginVC () <UITextFieldDelegate>
{
    YourLocationVC *yourLocationVC;
    NSDictionary *Result_Dict;
    RegistrationVC *registrationVC;
    AppDelegate *appDele;
    
    InCartVC *inCartVC;
    MainCategoryVC *mainCategoryVC;
}
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"Login Screen";
    
    UIColor *color = [UIColor colorWithRed:114.0/255.0 green:116.0/255.0 blue:121.0/255.0 alpha:1];
    emailTxtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    passwordTxtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    
    
    [loginBtnObj setTitleColor:color forState:UIControlStateNormal];
    
    
    appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    loginLbl.textColor = kColor_gray;
    signUpLbl.textColor = kColor_gray;
    loginBtnObj.layer.borderColor = kColor_gray.CGColor;
    loginBtnObj.layer.borderWidth = 1;
    loginBtnObj.layer.cornerRadius = 22;
    
    registrationVC = [[RegistrationVC alloc] initWithNibName:@"RegistrationVC" bundle:nil];
    
    if ([_checkLoginFromCheckout isEqualToString:@"0011"])
    {
        registrationVC.Skipcheck=@"003";
    }
    else if ([_CheckProfileStatus isEqualToString:@"002"])
    {
        registrationVC.Skipcheck=@"003";
    }
    else if ([_CheckProfileStatus isEqualToString:@"000"])
    {
        registrationVC.Skipcheck=@"003";
    }
    else if ([_checkdrawermenu isEqualToString:@"2222"])
    {
        registrationVC.Skipcheck=@"003";
    }
    else{
       registrationVC.Skipcheck=@"004";
    }
    
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    emailTxtFld.text = @"";
    passwordTxtFld.text = @"";
    
    bangeLbl.hidden = YES;
    [[IQKeyboardManager sharedManager] setEnable:TRUE];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:TRUE];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 && [mobileNumberStr isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter a 10 digit Mobile Number for OTP Verification"]];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oauth_token"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oauth_token_secret"];
    }
    else
    {
        if (buttonIndex == 1 && ([[alertView textFieldAtIndex:0].text length] == 10) )
        {
            NSString * Requrl= [NSString stringWithFormat:@"%@/profile/", baseUrl1];
            NSString *Finalurl=[Requrl stringByAppendingString:customerIdStr];
            
            mobileNumberStr = [alertView textFieldAtIndex:0].text;
            
            NSDictionary *UpdateCustomer_Dict= [Webmethods UpdateCustomer:Finalurl andDict:firstNameStr andLastName:lastNameStr andEmail:emailStr crmid:crmIdStr mobile:mobileNumberStr];
            
            if ([[UpdateCustomer_Dict valueForKey:@"status"] integerValue]==1)
            {
                if ([[UpdateCustomer_Dict valueForKey:@"message"] isEqualToString:@"OTP sent successfully"])
                {
                    otpView.center = self.view.center;
                    [self.view addSubview:otpView];
                }
                else
                {
                    //            [self.view addSubview:[[ToastAlert alloc] initWithText:[UpdateCustomer_Dict valueForKey:@"message"]]];
                }
                
                [self.view addSubview:[[ToastAlert alloc] initWithText:[UpdateCustomer_Dict valueForKey:@"message"]]];
            }
            else{
                [self.view addSubview:[[ToastAlert alloc] initWithText:[UpdateCustomer_Dict valueForKey:@"message"]]];
            }
            
            [SVProgressHUD dismiss];
            
            otpView.center = self.view.center;
            [self.view addSubview:otpView];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oauth_token"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oauth_token_secret"];
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter correct Mobile No."]];
        }
    }
}

- (IBAction)mobileCancelBtnAct:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oauth_token"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oauth_token_secret"];
    [mobileNoVew removeFromSuperview];
}

- (IBAction)mobileNoSubmitBtnAct:(UIButton *)sender
{
    if ([mobileNoTxtFld.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter a 10 digit Mobile Number for OTP Verification"]];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oauth_token"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oauth_token_secret"];
    }
    if ([mobileNoTxtFld.text length] != 10)
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter a 10 digit Mobile Number for OTP Verification"]];
        return ;
    }
    else
    {
        if ( (mobileNoTxtFld.text.length == 10) )
        {
            NSString * Requrl= [NSString stringWithFormat:@"%@/profile/", baseUrl1];
            NSString *Finalurl=[Requrl stringByAppendingString:customerIdStr];
            
            mobileNumberStr = mobileNoTxtFld.text;
            
            NSDictionary *UpdateCustomer_Dict= [Webmethods UpdateCustomer:Finalurl andDict:firstNameStr andLastName:lastNameStr andEmail:emailStr crmid:crmIdStr mobile:mobileNumberStr];
            
            if ([[UpdateCustomer_Dict valueForKey:@"status"] integerValue]==1)
            {
                if ([[UpdateCustomer_Dict valueForKey:@"message"] isEqualToString:@"OTP sent successfully"])
                {
                    otpView.center = self.view.center;
                    [self.view addSubview:otpView];
                }
                else
                {
                    //            [self.view addSubview:[[ToastAlert alloc] initWithText:[UpdateCustomer_Dict valueForKey:@"message"]]];
                }
                
                [self.view addSubview:[[ToastAlert alloc] initWithText:[UpdateCustomer_Dict valueForKey:@"message"]]];
            }
            else{
//                [self.view addSubview:[[ToastAlert alloc] initWithText:[UpdateCustomer_Dict valueForKey:@"message"]]];
            }
            
            [SVProgressHUD dismiss];
            
//            otpView.center = self.view.center;
//            [self.view addSubview:otpView];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oauth_token"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oauth_token_secret"];
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter correct Mobile No."]];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if(textField.tag==10)
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 10) ? NO : YES;
    }
    return YES; //we allow the user to enter anything
}


-(IBAction)loginBtnAct:(UIButton *)sender
{
    [emailTxtFld resignFirstResponder];
    [passwordTxtFld resignFirstResponder];
    
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"LoginCheck"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"registrationpagecheck"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"profilecheck"];
    BOOL email = [self validateEmailWithString:emailTxtFld.text];
    
    if ([emailTxtFld.text isEqualToString:@""])
    {
//        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter a valid email ID e.g. xyz@abc.com"]];
        [[[UIAlertView alloc] initWithTitle:@"" message:@"Please enter a valid email ID e.g. xyz@abc.com" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
    }
    else if (email == NO)
    {
//        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter a valid email ID e.g. xyz@abc.com"]];
        [[[UIAlertView alloc] initWithTitle:@"" message:@"Please enter a valid email ID e.g. xyz@abc.com" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
        return ;
    }
    else if ([passwordTxtFld.text isEqualToString:@""])
    {
//        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter password"]];
        [[[UIAlertView alloc] initWithTitle:@"" message:@"Please enter password" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
    }
    else
    {
        
        
        //        if ([self validateEmail:field1.text] == NO)
        //        {
        //            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Enter Valid Email ID"]];
        //            return ;
        //        }
        
        
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        
        
        NSString * DeviceID=[[[UIDevice currentDevice] identifierForVendor] UUIDString];
        
        //        NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
        //        NSString * DeviceID =[temp objectForKey:@"devicetoken"];
        
        Result_Dict=[Webmethods LoginMethod:emailTxtFld.text andpassword:passwordTxtFld.text andconsumerkey:@"5af68ccf03ca66408af33172f12f2368" andconsumersecret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329" and:DeviceID];
        
        NSMutableDictionary *customerDict = [[NSMutableDictionary alloc] init];
        
        if ([[Result_Dict valueForKey:@"status"] intValue] == 1)
        {
            
            NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithDictionary:[Result_Dict valueForKey:@"customerData"]];
            
            [customerDict setObject:[Result_Dict valueForKey:@"customerData"] forKey:@"data"];
            
            [customerDict setObject:@"1" forKey:@"status"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirst"];
            
            
            NSString * oauth_token=[[Result_Dict valueForKey:@"data"]valueForKey:@"oauth_token"];
            NSString * oauth_token_secret=[[Result_Dict valueForKey:@"data"]valueForKey:@"oauth_token_secret"];
            
            
            [[NSUserDefaults standardUserDefaults]setValue:oauth_token forKey:@"oauth_token"];
            [[NSUserDefaults standardUserDefaults]setValue:oauth_token_secret forKey:@"oauth_token_secret"];
            
            
            Customer_Dict =  [[NSMutableDictionary alloc] initWithDictionary:customerDict];
            
            
            firstNameStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"firstname"]];
            lastNameStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"lastname"]];
            crmIdStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"crmid"]];
            emailStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"email"]];
            customerIdStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"customerid"]];
//            firstNameStr = [NSString stringWithFormat:@"%@", [customerDict valueForKey:@"firstname"]];
            
            
            
            
            //add APP42Api TrackEvent for login  - email, phone, name
            
            /***
                Login event satrt
             ***/
            
            NSString *fullName = [NSString stringWithFormat:@"%@ %@",firstNameStr, lastNameStr];
            fullName = [fullName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

            NSMutableDictionary *loginProp = [NSMutableDictionary dictionaryWithObjectsAndKeys:fullName, kNameProperty,
                                              mobileNumberStr, kMobileProperty,
                                              emailStr, kEmailProperty,
                                              crmIdStr, kLoyalityCardNumberProperty,
                                              nil];
            [SH_TrackingUtility trackEventOfSpencerEvents:loginEvent eventProp:loginProp];
            
            /***
                Login event satrt
             ***/
            
            
            /***
                set logged in user in app42 api
             ***/
            [SH_TrackingUtility setLoggedInUser:[[NSUserDefaults standardUserDefaults] valueForKey:@"devicetoken"]];
            
            
            if ([[tempDict valueForKey:@"crmid"] isKindOfClass:[NSNull class]] || [[tempDict valueForKey:@"crmid"] isEqualToString:@"<null>"])
            {
                crmIdStr = @"";
                [tempDict setObject:@"" forKey:@"crmid"];
                [Customer_Dict setValue:tempDict forKey:@"data"];
            }
            
            
            if ([[tempDict valueForKey:@"mobile"] isKindOfClass:[NSNull class]] || [[tempDict valueForKey:@"mobile"] isEqualToString:@"<null>"])
            {
//                [tempDict setObject:@"9868632346" forKey:@"mobile"];
//                [customerDict setObject:tempDict forKey:@"data"];
                
//                [[[UIAlertView alloc] initWithTitle:@"" message:@"For better experiance please share your mobile number" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil] show];
                
                mobileNoVew.center = self.view.center;
                [self.view addSubview:mobileNoVew];
                mobileNoTxtFld.text = @"";
                
//                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"For better experience please share your Mobile No." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
//                av.alertViewStyle = UIAlertViewStylePlainTextInput;
//                [av textFieldAtIndex:0].delegate = self;
//                [av show];
                
                
                [SVProgressHUD dismiss];
                
                return ;
            }
            else
            {
                [[NSUserDefaults standardUserDefaults] setObject:Customer_Dict forKey:@"CustomerDict"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
        }
        
        
        
        if ([[[[Result_Dict valueForKey:@"messages"]valueForKey:@"error"]objectAtIndex:0]valueForKey:@"message"]!=nil)
        {
//            [self.view addSubview:[[ToastAlert alloc] initWithText:[[[[Result_Dict valueForKey:@"messages"]valueForKey:@"error"]objectAtIndex:0]valueForKey:@"message"]]];
            [[[UIAlertView alloc] initWithTitle:@"" message:[[[[Result_Dict valueForKey:@"messages"]valueForKey:@"error"]objectAtIndex:0]valueForKey:@"message"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
            [SVProgressHUD dismiss];
        }
        else{
            NSString * oauth_token=[[Result_Dict valueForKey:@"data"]valueForKey:@"oauth_token"];
            NSString * oauth_token_secret=[[Result_Dict valueForKey:@"data"]valueForKey:@"oauth_token_secret"];
            
            
            [[NSUserDefaults standardUserDefaults]setValue:oauth_token forKey:@"oauth_token"];
            [[NSUserDefaults standardUserDefaults]setValue:oauth_token_secret forKey:@"oauth_token_secret"];
            
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateSideMenu" object:nil userInfo:nil];
            
            NSString *    STATUS =[Result_Dict valueForKey:@"status"];
            
            
            if ( [STATUS integerValue]==0)
            {
//                [self.view addSubview:[[ToastAlert alloc] initWithText:[Result_Dict  valueForKey:@"message"]]];
                [[[UIAlertView alloc] initWithTitle:@"" message:[Result_Dict  valueForKey:@"message"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
                 [SVProgressHUD dismiss];
            }
            else
            {
//                [self.view addSubview:[[ToastAlert alloc] initWithText:[Result_Dict  valueForKey:@"message"]]];
                
                [[NSUserDefaults standardUserDefaults]setValue:passwordTxtFld.text forKey:@"PasswordField"];
                if ([_checkLoginFromCheckout isEqualToString:@"0011"])
                {
                    [self.navigationController popViewControllerAnimated:YES];
//                    [self performSelector:@selector(timer1) withObject:nil afterDelay:0.2];
                    
                }
                else if ([_CheckProfileStatus isEqualToString:@"002"])
                {
                    
                    BOOL reach = [Webmethods checkNetwork];
                    if (reach == NO)
                    {
                        return ;
                    }
                    
                    NSArray * arry; // = [WishListData_Dict valueForKey:@"data"];
                    NSMutableDictionary * cartDict= [Webmethods getCartWishlist];
                    
                    appDele.bangeStr = [NSString stringWithFormat:@"%li",[[cartDict valueForKey:@"cart_count"] integerValue]];
                    
                    bangeLbl.text = appDele.bangeStr;
                    
                    if ([bangeLbl.text integerValue] > 0)
                    {
                        bangeLbl.hidden = NO;
                    }
                    else
                    {
                        bangeLbl.hidden = YES;
                    }
                    
                    [self.navigationController popViewControllerAnimated:YES];
//                    MyProfileVC *myProfile;
//                    
//                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//                    {
//                        myProfile = [[MyProfileVC alloc] initWithNibName:@"MyProfileVC" bundle:nil];
//                    }
//                    else
//                    {
//                        myProfile = [[MyProfileVC alloc] initWithNibName:@"MyProfileVC~iPad" bundle:nil];
//                    }
//                    [self.navigationController pushViewController:myProfile animated:NO];
                    
                    
                    
//                    
//                    if ([appDele.bangeStr integerValue] > 0)
//                    {
////                        NSMutableDictionary * cartDict= [Webmethods getCartWishlist];
//                        appDele.bangeStr = [NSString stringWithFormat:@"%li",[[cartDict valueForKey:@"cart_count"] integerValue]];
//                        [[NSUserDefaults standardUserDefaults] setObject:[cartDict valueForKey:@"cartid"] forKey:@"globalcartid"];
//                        
////                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
////                        {
//                            inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
////                        }
////                        else
////                        {
////                            inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC~iPad" bundle:nil];
////                        }
//                        inCartVC.loginNav = @"10";
//                        [self.navigationController pushViewController:inCartVC animated:NO];
//                    }
//                    else
//                    {
////                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
////                        {
//                            mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC" bundle:nil];
////                        }
////                        else
////                        {
////                            mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC~iPad" bundle:nil];
////                        }
//                        
//                        [self.navigationController pushViewController:mainCategoryVC animated:NO];
//                    }

                    
                    
                    [SVProgressHUD dismiss];
                }
                else if ([_CheckProfileStatus isEqualToString:@"000"])
                {
                    
                    BOOL reach = [Webmethods checkNetwork];
                    if (reach == NO) {
                        return ;
                    }
                    
                    NSArray * arry; // = [WishListData_Dict valueForKey:@"data"];
                    
                    NSString * cartStr = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
                    
                    NSMutableDictionary *   cartDict= [Webmethods getCartWishlist];
                    
                    //            appDelegate.bangeStr=[NSString stringWithFormat:@"%lu",(unsigned long)cartArr.count];
                    appDele.bangeStr = [NSString stringWithFormat:@"%i",[[cartDict valueForKey:@"cart_count"] integerValue]];
                    
                    bangeLbl.text = appDele.bangeStr;
                    if ([bangeLbl.text integerValue] > 0)
                    {
                        bangeLbl.hidden = NO;
                    }
                    else
                    {
                        bangeLbl.hidden = YES;
                    }
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
//                    if ([appDele.bangeStr integerValue] > 0)
//                    {
//                        NSMutableDictionary * cartDict= [Webmethods getCartWishlist];
//                        appDele.bangeStr = [NSString stringWithFormat:@"%li",[[cartDict valueForKey:@"cart_count"] integerValue]];
//                        [[NSUserDefaults standardUserDefaults] setObject:[cartDict valueForKey:@"cartid"] forKey:@"globalcartid"];
//                        
////                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
////                        {
//                            inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
////                        }
////                        else
////                        {
////                            inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC~iPad" bundle:nil];
////                        }
//                        inCartVC.loginNav = @"10";
//                        [self.navigationController pushViewController:inCartVC animated:NO];
//                    }
//                    else
//                    {
////                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
////                        {
//                            mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC" bundle:nil];
////                        }
////                        else
////                        {
////                            mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC~iPad" bundle:nil];
////                        }
//                        
//                        [self.navigationController pushViewController:mainCategoryVC animated:NO];
//                    }
                    [SVProgressHUD dismiss];
                    
                }
                else if ([_checkdrawermenu isEqualToString:@"2222"])
                {
                    
//                    [self.navigationController popViewControllerAnimated:YES];
                    
                    
                    BOOL reach = [Webmethods checkNetwork];
                    if (reach == NO) {
                        return ;
                    }
                    
                    NSArray * arry; // = [WishListData_Dict valueForKey:@"data"];
                    
                    NSString * cartStr = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
                    
                    NSMutableDictionary * cartDict= [Webmethods getCartWishlist];
                    
                    //            appDelegate.bangeStr=[NSString stringWithFormat:@"%lu",(unsigned long)cartArr.count];
                    appDele.bangeStr = [NSString stringWithFormat:@"%i",[[cartDict valueForKey:@"cart_count"] integerValue]];
                    
                    bangeLbl.text = appDele.bangeStr;
                    if ([bangeLbl.text integerValue] > 0)
                    {
                        bangeLbl.hidden = NO;
                    }
                    else
                    {
                        bangeLbl.hidden = YES;
                    }
                    
                    mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC" bundle:nil];
                    [self.navigationController pushViewController:mainCategoryVC animated:NO];
                    
//                    [self.navigationController popViewControllerAnimated:YES];
                    
                    
//                    if ([appDele.bangeStr integerValue] > 0)
//                    {
//                        NSMutableDictionary * cartDict= [Webmethods getCartWishlist];
//                        appDele.bangeStr = [NSString stringWithFormat:@"%li",[[cartDict valueForKey:@"cart_count"] integerValue]];
//                        [[NSUserDefaults standardUserDefaults] setObject:[cartDict valueForKey:@"cartid"] forKey:@"globalcartid"];
//                        
////                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
////                        {
//                            inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
////                        }
////                        else
////                        {
////                            inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC~iPad" bundle:nil];
////                        }
//                        inCartVC.loginNav = @"10";
//                        [self.navigationController pushViewController:inCartVC animated:NO];
//                    }
//                    else
//                    {
//                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//                        {
                            mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC" bundle:nil];
//                        }
//                        else
//                        {
//                            mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC~iPad" bundle:nil];
//                        }
                        
                        [self.navigationController pushViewController:mainCategoryVC animated:NO];
//                    }
                    [SVProgressHUD dismiss];
                    
                    
                    
                }
                else
                {
                    
                    
//                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//                    {
//                        mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC" bundle:nil];
//                    }
//                    else
//                    {
//                        mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC~iPad" bundle:nil];
//                    }
//                    
//                    UINavigationController *childNavController = [[UINavigationController alloc] initWithRootViewController:mainCategoryVC];
//                    childNavController.view.frame = mainCategoryVC.view.frame;
//                    
//                    [self addChildViewController:childNavController];
//                    [self.view addSubview:childNavController.view];
//                    [childNavController didMoveToParentViewController:self];
                    
 
                    yourLocationVC = [[YourLocationVC alloc] initWithNibName:@"YourLocationVC" bundle:nil];
                    [self.navigationController pushViewController:yourLocationVC animated:NO];
                    
                    
                    
                    [SVProgressHUD dismiss];
                    
//                    NSLog(@"method called");
//                    inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
//                    [self.navigationController pushViewController:inCartVC animated:YES];
                    
//                    [self.view addSubview:[[ToastAlert alloc] initWithText:@"Customer Login sucessfully."]];
//                    CheckOutViewViewController * checkoutpage ;
//                    
//                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//                    {
//                        checkoutpage=[[CheckOutViewViewController alloc]initWithNibName:@"CheckOutViewViewController" bundle:nil];
//                    }
//                    else
//                    {
//                        checkoutpage=[[CheckOutViewViewController alloc]initWithNibName:@"CheckOutViewViewController~iPad" bundle:nil];
//                    }
                    
//                    [self.navigationController pushViewController:checkoutpage animated:NO];
                }
                
                //             Customer_Dict=[Webmethods Getcustmer];
                
                [[NSUserDefaults standardUserDefaults] setObject:Customer_Dict forKey:@"CustomerDict"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
            }
            [SVProgressHUD dismiss];
        }
        
        
    }
    
}

-(void)threadStartAnimating:(id)dat
{
    [SVProgressHUD show];
}



-(IBAction)skipBtnAct:(UIButton *)sender
{
    
    if ([_checkLoginFromCheckout isEqualToString:@"0011"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([_CheckProfileStatus isEqualToString:@"002"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([_CheckProfileStatus isEqualToString:@"000"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([_checkdrawermenu isEqualToString:@"2222"])
    {
        //[self.navigationController popViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
        mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC" bundle:nil];
        [self.navigationController pushViewController:mainCategoryVC animated:NO];
    }
    else if ([_sessionExpireStr isEqualToString:@"session"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        yourLocationVC = [[YourLocationVC alloc] initWithNibName:@"YourLocationVC" bundle:nil];
        [self.navigationController pushViewController:yourLocationVC animated:NO];
    }
}

-(IBAction)signUpBtnAct:(UIButton *)sender
{
    [self.navigationController pushViewController:registrationVC animated:NO];
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(IBAction)forgot_butt:(id)sender
{
    
    ForgotVC *regpage;
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
        regpage = [[ForgotVC alloc]initWithNibName:@"ForgotVC1" bundle:nil];
//    }
//    else
//    {
//        regpage = [[ForgotVC alloc]initWithNibName:@"ForgotVC1~iPad" bundle:nil];
//    }
    [self.navigationController pushViewController:regpage animated:NO];
}



- (IBAction)otpCancelBtnAct:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oauth_token"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oauth_token_secret"];
    enterOTPTxtFld.text = @"";
    [otpView removeFromSuperview];
    [mobileNoVew removeFromSuperview];
}

- (IBAction)otpVerifyBtnAct:(UIButton *)sender {
    
    
    //
    otpStr = enterOTPTxtFld.text;
    if (otpStr.length > 3 )
    {
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO)
        {
            return ;
        }
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating22:) toTarget:self withObject:nil];
        
        NSString * Requrl= [NSString stringWithFormat:@"%@/profile/", baseUrl1];
        NSString *Finalurl=[Requrl stringByAppendingString:customerIdStr];
        NSDictionary * UpdateCustomer_Dict= [Webmethods UpdateCustomer:Finalurl andDict:firstNameStr andLastName:lastNameStr andEmail:emailStr crmid:crmIdStr mobile:mobileNumberStr otp:otpStr];
        [SVProgressHUD dismiss];
        
        if ([[UpdateCustomer_Dict valueForKey:@"status"] integerValue]==1)
        {
            
            NSMutableDictionary *customerDict = [[NSMutableDictionary alloc] init];
            NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithDictionary:[Customer_Dict valueForKey:@"data"]];
            //        [customerDict setObject:[Result_Dict valueForKey:@"customerData"] forKey:@"data"];
            [tempDict setObject:mobileNumberStr forKey:@"mobile"];
            [Customer_Dict setValue:tempDict forKey:@"data"];
            
            
            
            
            [[NSUserDefaults standardUserDefaults] setObject:Customer_Dict forKey:@"CustomerDict"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            [otpView removeFromSuperview];
            
            
            if ([_checkLoginFromCheckout isEqualToString:@"0011"] || [_CheckProfileStatus isEqualToString:@"002"] || [_CheckProfileStatus isEqualToString:@"000"])
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else if ([_checkdrawermenu isEqualToString:@"2222"])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateSideMenu" object:nil userInfo:nil];
                mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC" bundle:nil];
                [self.navigationController pushViewController:mainCategoryVC animated:NO];
                [SVProgressHUD dismiss];
            }
            else
            {
                yourLocationVC = [[YourLocationVC alloc] initWithNibName:@"YourLocationVC" bundle:nil];
                [self.navigationController pushViewController:yourLocationVC animated:NO];
                [SVProgressHUD dismiss];
                [[NSUserDefaults standardUserDefaults] setObject:Customer_Dict forKey:@"CustomerDict"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            
            //        otpView.center = self.view.center;
            //        [self.view addSubview:otpView];
        }
        else{
            [SVProgressHUD dismiss];
        }
        [self.view addSubview:[[ToastAlert alloc] initWithText:[UpdateCustomer_Dict valueForKey:@"message"]]];
        

    }
    
    
}
- (IBAction)resendOtpBtnAct:(UIButton *)sender
{
    
    
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO)
    {
        return ;
    }
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating22:) toTarget:self withObject:nil];
    
    NSString * Requrl= [NSString stringWithFormat:@"%@/profile/", baseUrl1];
    NSString *Finalurl=[Requrl stringByAppendingString:[[Customer_Dict valueForKey:@"data"] valueForKey:@"customerid"]];
    NSDictionary * UpdateCustomer_Dict1= [Webmethods UpdateCustomer:Finalurl andDict:firstNameStr andLastName:lastNameStr andEmail:emailStr crmid:crmIdStr mobile:mobileNumberStr];
    
    if ([[UpdateCustomer_Dict1 valueForKey:@"status"] integerValue]==1)
    {
        //        otpView.center = self.view.center;
        //        [self.view addSubview:otpView];
    }
    else{
    }
    
    [self.view addSubview:[[ToastAlert alloc] initWithText:[UpdateCustomer_Dict1 valueForKey:@"message"]]];
    
    [SVProgressHUD dismiss];
    
}


-(void)threadStartAnimating22:(id)sender
{
    [SVProgressHUD show];
}


@end
