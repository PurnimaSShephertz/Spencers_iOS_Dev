//
//  PaymentInfoVC.m
//  Spencer
//
//  Created by binary on 13/07/16.
//  Copyright © 2016 Binary. All rights reserved.
//

// 011 45057181



#import "PaymentInfoVC.h"
#import "AppDelegate.h"
#import "Webmethods.h"
#import "Result.h"
#import "SVProgressHUD.h"
#import "MainCategoryVC.h"
#import "CategoryPage.h"
#import "OfferVC.h"
#import "LoginVC.h"
#import "MyProfileVC.h"
#import "CardsViewController.h"
#import "ProductVC.h"
#import "IQKeyboardManager.h"
#import "SH_TrackingUtility.h"


@interface PaymentInfoVC ()
{
    AppDelegate *appDele;
    NSArray *payemntTypeArr;
    CitrusSiginType signInType;
    NSString *responseMessage;
    NSString *walletValueStr, *srcValueStr;;
    
    NSString *PaymentType_Str;
    NSDictionary *FinalResult_Dict;
    BOOL internalCheckBool;
    NSString * credits, *srcCredits;
    LoginVC *loginpage;
    MyProfileVC *myProfile;
    CardsViewController *vc;
    ProductVC *productVC;
    
    NSDictionary *userInfo;
}
@end

@implementation PaymentInfoVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    200000001733

    paymentTblVew.hidden = YES;
    smartRewardVew.hidden = YES;
    
    
//    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Addaddress"];
    
    smartRewardFlag = NO;
    
    userProfileData = [[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"];
    
    finalAmount = @"0.00";
    
    checkstatus=@"1";
    ScreenWidth= [UIScreen mainScreen].bounds.size.width;
    ScreenHeight= [UIScreen mainScreen].bounds.size.height;

    appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    NSString *emailId = [[userProfileData valueForKey:@"data"] valueForKey:@"email"];
    NSString *mobileNo = [[userProfileData valueForKey:@"data"] valueForKey:@"mobile"];
    
    NSMutableDictionary *orderConfirmationDict = [[NSMutableDictionary alloc] initWithDictionary:appDele.orderConfirmationDict];
    [orderConfirmationDict setObject:emailId forKey:@"email"];
    appDele.orderConfirmationDict = orderConfirmationDict;
    
//    [super viewDidLoad];
    
//    [self walletMethod];
//    [self getBalance:nil];
    if (ScreenHeight<570)
    {
        paymentTblVew.frame=CGRectMake(0, paymentTblVew.frame.origin.y, self.view.frame.size.width, paymentTblVew.frame.size.height-45);
    }
    
    remove_obj.layer.cornerRadius=16.0;
    remove_obj.layer.masksToBounds=YES;
    
    reedem_obj.layer.cornerRadius=16.0;
    reedem_obj.layer.masksToBounds=YES;
    
    srcRemove_Obj.layer.cornerRadius=16.0;
    srcRemove_Obj.layer.masksToBounds=YES;
    
    srcReedem_Obj.layer.cornerRadius=16.0;
    srcReedem_Obj.layer.masksToBounds=YES;
    
    enrolSubmitBtnObj.layer.cornerRadius=16.0;
    enrolSubmitBtnObj.layer.masksToBounds=YES;
    
    
    
//    [self linkUser];

    [SVProgressHUD show];
    dispatch_async(dispatch_get_main_queue(), ^{
        
//        NSDictionary * Customer_Dict=[Webmethods Getcustmer];
//        
//        
//        NSMutableDictionary * userDict = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"]];
//        NSMutableDictionary *userInfoDict = [[NSMutableDictionary alloc] initWithDictionary:[Customer_Dict valueForKey:@"data"]];
//        if ([[userInfoDict valueForKey:@"crmid"] isKindOfClass:[NSNull class]] || [[userInfoDict valueForKey:@"crmid"] isEqualToString:@"<null>"])
//        {
//            [userInfoDict setObject:@"" forKey:@"crmid"];
//        }
//        if ([[userInfoDict valueForKey:@"email"] isKindOfClass:[NSNull class]] || [[userInfoDict valueForKey:@"email"] isEqualToString:@"<null>"])
//        {
//            [userInfoDict setObject:@"" forKey:@"email"];
//        }
//        if ([[userInfoDict valueForKey:@"firstname"] isKindOfClass:[NSNull class]] || [[userInfoDict valueForKey:@"firstname"] isEqualToString:@"<null>"])
//        {
//            [userInfoDict setObject:@"" forKey:@"firstname"];
//        }
//        if ([[userInfoDict valueForKey:@"lastname"] isKindOfClass:[NSNull class]] || [[userInfoDict valueForKey:@"lastname"] isEqualToString:@"<null>"])
//        {
//            [userInfoDict setObject:@"" forKey:@"lastname"];
//        }
//        if ([[userInfoDict valueForKey:@"mobile"] isKindOfClass:[NSNull class]] || [[userInfoDict valueForKey:@"mobile"] isEqualToString:@"<null>"])
//        {
//            [userInfoDict setObject:@"" forKey:@"mobile"];
//        }
//        [userDict setObject:userInfoDict forKey:@"data"];
//        [[NSUserDefaults standardUserDefaults] setValue:userDict forKey:@"CustomerDict"];
        
        
        
        NSDictionary * Wallet_Dict=   [Webmethods getwallet];
        NSString * status = [Wallet_Dict valueForKey:@"status"];
        if ([status integerValue]==1)
        {
            [remove_obj setHidden:YES];
            [reedem_obj setHidden:NO];
            [back_obj setHidden:YES];
            credits = [[Wallet_Dict valueForKey:@"data"] valueForKey:@"mycredits"];
            if ([[[Wallet_Dict valueForKey:@"data"] valueForKey:@"srcpoints"] isKindOfClass:[NSNull class]])
            {
                srcCredits = @"0.0";
            }
            else
            {
                srcCredits = [[Wallet_Dict valueForKey:@"data"] valueForKey:@"srcpoints"];
            }
            
            
            walletAmountLbl.text = [NSString stringWithFormat:@"Rs. %.2f",[credits floatValue]];
            srcAmountLbl.text = [NSString stringWithFormat:@"Rs. %.2f",[srcCredits floatValue]];
            
            walletValueStr = credits;
            srcValueStr = srcCredits;
            
            //abc@rp-sg.in
           // 1234567
//            finalAmount=_grandTotalStr;
            grandTotalLbl.text = [NSString stringWithFormat:@"Rs. %@", _grandTotalStr];
            
            userInfo = [[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"];
            
            
            NSString *srcPointStrIs = [NSString stringWithFormat:@"%@", [[Wallet_Dict valueForKey:@"data"] valueForKey:@"srcpoints"]];
            
            if ([srcPointStrIs isEqualToString:@"NA"])
            {
                smartRewardVew.hidden = NO;
            }
            else
            {
                smartRewardVew.hidden = YES;
            }

            
            if ([srcValueStr integerValue] == 0)
            {
                [srcRemove_Obj setHidden:YES];
                [srcReedem_Obj setHidden:YES];
                [srcBackobj setHidden:YES];
                [srcCheckBoxBtnObj setImage:[UIImage imageNamed:@"checkbox_unchecked@2x.png"] forState:UIControlStateNormal];
                [paymentTblVew setHidden:NO];
                srcRedeemRemoveBool=NO;
            }
            else
            {
                [srcRemove_Obj setHidden:NO];
                [srcReedem_Obj setHidden:YES];
                srcRedeemRemoveBool=YES;
                [srcCheckBoxBtnObj setImage:[UIImage imageNamed:@"checkbox_checked@2x.png"] forState:UIControlStateNormal];
                
                if ([_grandTotalStr integerValue] == ([walletValueStr integerValue] + [srcValueStr integerValue]))
                {
                    [paymentTblVew setHidden:YES];
                    [srcBackobj setHidden:NO];
                    [srcBack_obj setHidden:NO];
                    chekSRCstatus = @"101";
                    //                    [self applyWallet];
                }
                else if (([walletValueStr integerValue] + [srcValueStr integerValue]) > [_grandTotalStr integerValue])
                {
                    [paymentTblVew setHidden:YES];
                    chekSRCstatus=@"101";
                    [srcBackobj setHidden:NO];
                    [srcBack_obj setHidden:NO];
                    //                    [self applyWallet];
                }
                else
                {
                    [paymentTblVew setHidden:NO];
                    [srcBackobj setHidden:YES];
                    [srcBack_obj setHidden:YES];
                    chekSRCstatus=@"100";
                    //                    [self applyWallet];
                }

                NSDictionary * tempDict = [Webmethods applySRC:srcValueStr];
//                [NSString stringWithFormat:@"Rs. %.2f",[[[[tempDict valueForKey:@"data"] valueForKey:@"discount"] valueForKey:@"value"] floatValue]];
                srcFinalAmount = [NSString stringWithFormat:@"%.0f",[[[[tempDict valueForKey:@"data"] valueForKey:@"discount"] valueForKey:@"value"] floatValue]];
                
            }
            
            
            
            if ([walletValueStr integerValue] == 0)
            {
                [remove_obj setHidden:YES];
                [reedem_obj setHidden:YES];
                [backobj setHidden:YES];
               
                [walletCheckBoxBtnObj setImage:[UIImage imageNamed:@"checkbox_unchecked@2x.png"] forState:UIControlStateNormal];
                if ([srcValueStr integerValue] > [_grandTotalStr integerValue]) {
                    [paymentTblVew setHidden:YES];
                    redeemRemoveBool=YES;
                }
                else
                {
                    [paymentTblVew setHidden:NO];
                    redeemRemoveBool=NO;
                }
                
            }
            else
            {
                
                [remove_obj setHidden:NO];
                [reedem_obj setHidden:YES];
                redeemRemoveBool=YES;
                [walletCheckBoxBtnObj setImage:[UIImage imageNamed:@"checkbox_checked@2x.png"] forState:UIControlStateNormal];
                
                if ([_grandTotalStr integerValue] == ([walletValueStr integerValue] + [srcValueStr integerValue]))
                {
                    [paymentTblVew setHidden:YES];
                    [backobj setHidden:NO];
                    [back_obj setHidden:NO];
                    chekWalletstatus=@"101";
                    redeemRemoveBool = YES;
                    srcRedeemRemoveBool = YES;
//                    [self applyWallet];
                }
                else if (([walletValueStr integerValue] + [srcValueStr integerValue]) > [_grandTotalStr integerValue])
                {
                    redeemRemoveBool = YES;
                    srcRedeemRemoveBool = YES;
                    [paymentTblVew setHidden:YES];
                    chekWalletstatus=@"101";
                    [backobj setHidden:NO];
                    [back_obj setHidden:NO];
//                    [self applyWallet];
                }
                else
                {
                    [paymentTblVew setHidden:NO];
                    [backobj setHidden:YES];
                    [back_obj setHidden:YES];
                    chekWalletstatus=@"100";
//                    [self applyWallet];
                }
                
            }
        }
        [SVProgressHUD dismiss];
    });
    
//    [reedem_obj setHidden:YES];
    
    rewardCheck = NO;
    payemntTypeArr = [[NSArray alloc] initWithObjects:@"Cash on Delivery", @"Card on Delivery",  @"Debit / Credit Card", @"NetBanking", @"Paytm", nil];
    
//    payemntTypeArr = [[NSArray alloc] initWithObjects:@"Cash on Delivery", @"Citrus Wallet", @"Debit / Credit Card", @"NetBanking", nil];
    
    walletFlag = NO;
    
    creditTxtFld.hidden = YES;
    
    // Do any additional setup after loading the view from its nib.
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:FALSE];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:FALSE];
}

-(void)getwallet
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSDictionary * Wallet_Dict=   [Webmethods getwallet];
        NSString * status = [Wallet_Dict valueForKey:@"status"];
        if ([status integerValue]==1)
        {
            [remove_obj setHidden:YES];
            [reedem_obj setHidden:NO];
            [back_obj setHidden:YES];
            credits = [[Wallet_Dict valueForKey:@"data"] valueForKey:@"mycredits"];
            srcCredits = [[Wallet_Dict valueForKey:@"data"] valueForKey:@"srcpoints"];
            smartRewardVew.hidden = YES;
            
            if ([[[Wallet_Dict valueForKey:@"data"] valueForKey:@"srcpoints"] isKindOfClass:[NSNull class]])
            {
                srcCredits = @"0.0";
            }
            else
            {
                srcCredits = [[Wallet_Dict valueForKey:@"data"] valueForKey:@"srcpoints"];
            }
            
            walletAmountLbl.text = [NSString stringWithFormat:@"Rs. %.2f",[credits floatValue]];
            srcAmountLbl.text = [NSString stringWithFormat:@"Rs. %.2f",[srcCredits floatValue]];
            
            walletValueStr = credits;
            srcValueStr = srcCredits;
            
            //abc@rp-sg.in
            // 1234567
            //            finalAmount=_grandTotalStr;
            grandTotalLbl.text = [NSString stringWithFormat:@"Rs. %@",_grandTotalStr];
            
            NSString *srcPointStrIs = [NSString stringWithFormat:@"%@", [[Wallet_Dict valueForKey:@"data"] valueForKey:@"srcpoints"]];
            
            if ([srcPointStrIs isEqualToString:@"NA"])
            {
                smartRewardVew.hidden = NO;
            }
            else
            {
                smartRewardVew.hidden = YES;
            }

            
            
            if ([srcValueStr integerValue] == 0)
            {
                [srcRemove_Obj setHidden:YES];
                [srcReedem_Obj setHidden:YES];
                [srcBackobj setHidden:YES];
                [srcCheckBoxBtnObj setImage:[UIImage imageNamed:@"checkbox_unchecked@2x.png"] forState:UIControlStateNormal];
                [paymentTblVew setHidden:NO];
                srcRedeemRemoveBool=NO;
            }
            else
            {
                [srcRemove_Obj setHidden:NO];
                [srcReedem_Obj setHidden:YES];
                srcRedeemRemoveBool=YES;
                [srcCheckBoxBtnObj setImage:[UIImage imageNamed:@"checkbox_checked@2x.png"] forState:UIControlStateNormal];
                
                if ([_grandTotalStr integerValue] == ([walletValueStr integerValue] + [srcValueStr integerValue]))
                {
                    [paymentTblVew setHidden:YES];
                    [srcBackobj setHidden:NO];
                    [srcBack_obj setHidden:NO];
                    chekSRCstatus = @"101";
                    //                    [self applyWallet];
                }
                else if (([walletValueStr integerValue] + [srcValueStr integerValue]) > [_grandTotalStr integerValue])
                {
                    [paymentTblVew setHidden:YES];
                    chekSRCstatus=@"101";
                    [srcBackobj setHidden:NO];
                    [srcBack_obj setHidden:NO];
                    //                    [self applyWallet];
                }
                else
                {
                    [paymentTblVew setHidden:NO];
                    [srcBackobj setHidden:YES];
                    [srcBack_obj setHidden:YES];
                    chekSRCstatus=@"100";
                    //                    [self applyWallet];
                }
                
                NSDictionary * tempDict = [Webmethods applySRC:srcValueStr];
                //                [NSString stringWithFormat:@"Rs. %.2f",[[[[tempDict valueForKey:@"data"] valueForKey:@"discount"] valueForKey:@"value"] floatValue]];
                srcFinalAmount = [NSString stringWithFormat:@"%.0f",[[[[tempDict valueForKey:@"data"] valueForKey:@"discount"] valueForKey:@"value"] floatValue]];
                
            }
            
            
            
            if ([walletValueStr integerValue] == 0)
            {
                [remove_obj setHidden:YES];
                [reedem_obj setHidden:YES];
                [backobj setHidden:YES];
                
                [walletCheckBoxBtnObj setImage:[UIImage imageNamed:@"checkbox_unchecked@2x.png"] forState:UIControlStateNormal];
                [paymentTblVew setHidden:NO];
                redeemRemoveBool=NO;
            }
            else
            {
                
                [remove_obj setHidden:NO];
                [reedem_obj setHidden:YES];
                redeemRemoveBool=YES;
                [walletCheckBoxBtnObj setImage:[UIImage imageNamed:@"checkbox_checked@2x.png"] forState:UIControlStateNormal];
                
                if ([_grandTotalStr integerValue] == ([walletValueStr integerValue] + [srcValueStr integerValue]))
                {
                    [paymentTblVew setHidden:YES];
                    [backobj setHidden:NO];
                    [back_obj setHidden:NO];
                    chekWalletstatus=@"101";
                    //                    [self applyWallet];
                }
                else if (([walletValueStr integerValue] + [srcValueStr integerValue]) > [_grandTotalStr integerValue])
                {
                    [paymentTblVew setHidden:YES];
                    chekWalletstatus=@"101";
                    [backobj setHidden:NO];
                    [back_obj setHidden:NO];
                    //                    [self applyWallet];
                }
                else
                {
                    [paymentTblVew setHidden:NO];
                    [backobj setHidden:YES];
                    [back_obj setHidden:YES];
                    chekWalletstatus=@"100";
                    //                    [self applyWallet];
                }
                
            }
        }
        [SVProgressHUD dismiss];
    });

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:TRUE];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:TRUE];
    
//    [self walletMethod];
    
    UIButton *backBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"ic_left_arw.png"];
    //    [backBtn setBackgroundColor:[UIColor redColor]];
    
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0f, -30.0f, 0.0f, 0.0f);
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *menubutton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:menubutton , nil]];
    self.navigationItem.leftBarButtonItem = menubutton;
    
    UIButton *titleLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleLabelButton setTitle:@"Checkout" forState:UIControlStateNormal];
    titleLabelButton.frame = CGRectMake(0, 0, 200, 44);
    titleLabelButton.titleLabel.numberOfLines=1;
    [titleLabelButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [titleLabelButton setTitleColor:[UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    titleLabelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    //    [titleLabelButton addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleLabelButton;
}
-(IBAction)reedem_Act:(id)sender
{

    [walletCheckBoxBtnObj setImage:[UIImage imageNamed:@"checkbox_checked@2x.png"] forState:UIControlStateNormal];

    redeemRemoveBool = YES;
    if ([chekWalletstatus isEqualToString:@"100"])
    {
          [paymentTblVew setHidden:NO];
          [backobj setHidden:YES];
          [back_obj setHidden:YES];
//          [self applyWallet];
    }
   else if ([chekWalletstatus isEqualToString:@"101"])
    {
        [paymentTblVew setHidden:YES];
        [backobj setHidden:NO];
        [back_obj setHidden:NO];
//        [self applyWallet];
    }
    else
    {
          [paymentTblVew setHidden:YES];
          [backobj setHidden:NO];
          [back_obj setHidden:NO];
//          [self applyWallet];
    }
    
    
    if (srcRedeemRemoveBool == YES)
    {
        if (([_grandTotalStr integerValue] > ([walletValueStr integerValue] + [srcValueStr integerValue])))
        {
            paymentTblVew.hidden = NO;
        }
        else
        {
            paymentTblVew.hidden = YES;
        }
    }
    else if (srcRedeemRemoveBool == NO)
    {
        if (([_grandTotalStr integerValue] > ([walletValueStr integerValue] )))
        {
            paymentTblVew.hidden = NO;
        }
        else
        {
            paymentTblVew.hidden = YES;
        }
    }
  
    
   
    [remove_obj setHidden:NO];
    [reedem_obj setHidden:YES];
}
-(IBAction)Remove_Act:(id)sender
{
    
    
    [walletCheckBoxBtnObj setImage:[UIImage imageNamed:@"checkbox_unchecked@2x.png"] forState:UIControlStateNormal];
    
    redeemRemoveBool = NO;
    [paymentTblVew setHidden:NO];
   
    [remove_obj setHidden:YES];
    [reedem_obj setHidden:NO];
    [backobj setHidden:YES];
    [back_obj setHidden:YES];
    
    if (srcRedeemRemoveBool == YES)
    {
        if (([_grandTotalStr integerValue] > [srcValueStr integerValue] ) )
        {
            paymentTblVew.hidden = NO;
        }
        else
        {
            paymentTblVew.hidden = YES;
        }
    }
    else if (srcRedeemRemoveBool == NO)
    {
        paymentTblVew.hidden = NO;
    }
    
//    NSDictionary * tempDict = [Webmethods applyWallet:@"0.00"];
//    NSLog(@"tempDict %@", tempDict);
//    NSDictionary * cartDict = [tempDict valueForKey:@"data"];
//    
//    NSString * value =[NSString stringWithFormat:@"Rs. %.2f",[[[cartDict valueForKey:@"grand_total"] valueForKey:@"value"] floatValue]];
//    
//    finalAmount = @"0.00";
    
    //grandTotalLbl.text=value;
    
}
-(void)loaderMethod
{
    [SVProgressHUD show];
}
-(IBAction)Proceed_Act:(id)sender
{
    PaymentType_Str = @"cashondelivery";
//    [SVProgressHUD show];
    
    if (redeemRemoveBool == YES)
    {
        if ([_grandTotalStr integerValue] < [srcValueStr integerValue])
        {
            [self PlaceorderthroughSpencerWallet];
        }
        else
        {
            [self applyWallet];
            [self PlaceorderthroughSpencerWallet];
        }
    }
    else
    {
        [self PlaceorderthroughSpencerWallet];
    }
}

- (IBAction)srcReedem_Act:(UIButton *)sender
{
    [srcCheckBoxBtnObj setImage:[UIImage imageNamed:@"checkbox_checked@2x.png"] forState:UIControlStateNormal];
    
    srcRedeemRemoveBool = YES;
    
    if ([_grandTotalStr integerValue] < [srcValueStr integerValue])
    {
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating224) toTarget:self withObject:nil];
        NSDictionary * tempDict = [Webmethods applySRC:_grandTotalStr];
        [SVProgressHUD dismiss];
        
        if ([[NSString stringWithFormat:@"%@",[tempDict valueForKey:@"status"]] isEqualToString:@"1"])
        {
            NSDictionary * cartDict = [tempDict valueForKey:@"data"];
            NSString * value =[NSString stringWithFormat:@"Rs. %.2f",[[[cartDict valueForKey:@"discount"] valueForKey:@"value"] floatValue]];
            
            srcRedeemRemoveBool = YES;
            
            int number = [[[cartDict valueForKey:@"discount"] valueForKey:@"value"] floatValue];
            if (number < 0) {
                number = (0 - number);
            }
            
            srcFinalAmount = [NSString stringWithFormat:@"%i", number];
            
            
        }
        else
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
            return ;
        }
    }
    else
    {
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating224) toTarget:self withObject:nil];
        NSDictionary * tempDict = [Webmethods applySRC:srcValueStr];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",[tempDict valueForKey:@"status"]] isEqualToString:@"1"])
        {
            NSDictionary * cartDict = [tempDict valueForKey:@"data"];
            NSString * value =[NSString stringWithFormat:@"Rs. %.2f",[[[cartDict valueForKey:@"grand_total"] valueForKey:@"value"] floatValue]];
            int number = [[[cartDict valueForKey:@"discount"] valueForKey:@"value"] floatValue];
            if (number < 0) {
                number = (0 - number);
            }
            
            srcFinalAmount = [NSString stringWithFormat:@"%i", number];
            //grandTotalLbl.text = value;
        }
        else
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
            return ;
        }
        [SVProgressHUD dismiss];
    }

    
    
    if ([chekSRCstatus isEqualToString:@"100"])
    {
        [paymentTblVew setHidden:NO];
        [srcBackobj setHidden:YES];
        [srcBack_obj setHidden:YES];
        //          [self applyWallet];
    }
    else if ([chekSRCstatus isEqualToString:@"101"])
    {
        [paymentTblVew setHidden:YES];
        [srcBackobj setHidden:NO];
        [srcBack_obj setHidden:NO];
        //        [self applyWallet];
    }
    else
    {
        [paymentTblVew setHidden:YES];
        [srcBackobj setHidden:NO];
        [srcBack_obj setHidden:NO];
        //          [self applyWallet];
    }

    
    
    
    if (redeemRemoveBool == YES)
    {
        if (([_grandTotalStr integerValue] > ([walletValueStr integerValue] + [srcValueStr integerValue])))
        {
            paymentTblVew.hidden = NO;
        }
        else
        {
            paymentTblVew.hidden = YES;
        }
    }
    else if (redeemRemoveBool == NO)
    {
        if (([_grandTotalStr integerValue] > ([srcValueStr integerValue] )))
        {
            paymentTblVew.hidden = NO;
        }
        else
        {
            paymentTblVew.hidden = YES;
        }
    }

    
    [srcRemove_Obj setHidden:NO];
    [srcReedem_Obj setHidden:YES];
}

- (IBAction)srcRemove_Act:(UIButton *)sender
{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating224) toTarget:self withObject:nil];
    NSDictionary * tempDict = [Webmethods applySRC:@"0.00"];
    [SVProgressHUD dismiss];
    srcFinalAmount = @"0.00";
//    srcValueStr = @"0.00";
    [srcCheckBoxBtnObj setImage:[UIImage imageNamed:@"checkbox_unchecked@2x.png"] forState:UIControlStateNormal];
    
    srcRedeemRemoveBool = NO;
    [paymentTblVew setHidden:NO];
    
    [srcRemove_Obj setHidden:YES];
    [srcReedem_Obj setHidden:NO];
    [srcBackobj setHidden:YES];
    [srcBack_obj setHidden:YES];
    
    
    if (redeemRemoveBool == YES)
    {
        if (([_grandTotalStr integerValue] > [walletValueStr integerValue] ) )
        {
            paymentTblVew.hidden = NO;
        }
        else
        {
            paymentTblVew.hidden = YES;
        }
    }
    else if (redeemRemoveBool == NO)
    {
        paymentTblVew.hidden = NO;
    }
    
//    NSDictionary * tempDict = [Webmethods applyWallet:@"0.00"];
//    NSLog(@"tempDict %@", tempDict);
//    NSDictionary * cartDict = [tempDict valueForKey:@"data"];
    
//    NSString * value =[NSString stringWithFormat:@"Rs. %.2f",[[[cartDict valueForKey:@"grand_total"] valueForKey:@"value"] floatValue]];
    
//    finalAmount = @"0.00";
    
}

- (IBAction)srcProceed_Act:(UIButton *)sender
{
    PaymentType_Str = @"cashondelivery";
//    [SVProgressHUD show];
    
    if (redeemRemoveBool == YES)
    {
        
        [self applyWallet];
        [self PlaceorderthroughSpencerSRC];
    }
    else if (redeemRemoveBool == NO)
    {
       [self PlaceorderthroughSpencerSRC];
    }
   
    else
    {
        
    }
}

- (IBAction)enrollSmartRewardBtnAct:(UIButton *)sender
{
//    if (smartRewardFlag == YES)
//    {
        [smartRewardImgVew setImage:[UIImage imageNamed:@"toggle_active.png"]];
        smartRewardFlag = !smartRewardFlag;
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating224) toTarget:self withObject:nil];
        NSDictionary *crmDict = [Webmethods crmEnroll];
        if ([[crmDict valueForKey:@"status"] integerValue] == 0)
        {
//            NSDictionary * Customer_Dict = [Webmethods Getcustmer];
//            NSLog(@"%@", Customer_Dict);
//            [[NSUserDefaults standardUserDefaults] setValue:Customer_Dict forKey:@"CustomerDict"];
            [self.view addSubview:[[ToastAlert alloc] initWithText:[crmDict valueForKey:@"message"]]];
//            [self getwallet];
        }
        else
        {
            NSDictionary * Customer_Dict=[Webmethods Getcustmer];
            NSLog(@"%@", Customer_Dict);
            [[NSUserDefaults standardUserDefaults] setValue:Customer_Dict forKey:@"CustomerDict"];
            NSLog(@"%@", Customer_Dict);
            [self getwallet];
        }
        
        
        [self performSelector:@selector(enrollMethod) withObject:nil afterDelay:1];
        [SVProgressHUD dismiss];
//    }
//    else
//    {
//        [smartRewardImgVew setImage:[UIImage imageNamed:@"toggle_inactive.png"]];
//        smartRewardFlag = !smartRewardFlag;
//    }
}

-(void)enrollMethod
{
    [smartRewardImgVew setImage:[UIImage imageNamed:@"toggle_inactive.png"]];
}

- (IBAction)rewardSubmitBtnAct:(UIButton *)sender
{
    [crmTxtFld resignFirstResponder];
    if (crmTxtFld.text.length < 1)
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please Enter Smart Reward Card number"]];
    }
    else
    {
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating224) toTarget:self withObject:nil];
        NSDictionary *Customer_Dict = [[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"];
        NSString * Requrl= [NSString stringWithFormat:@"%@/profile/", baseUrl1];
        NSString *Finalurl=[Requrl stringByAppendingString:[[Customer_Dict valueForKey:@"data"] valueForKey:@"customerid"]];
        NSDictionary *crmDict = [Webmethods UpdateCustomer:Finalurl andDict:[[Customer_Dict valueForKey:@"data"] valueForKey:@"firstname"] andLastName:[[Customer_Dict valueForKey:@"data"] valueForKey:@"lastname"] andEmail:[[Customer_Dict valueForKey:@"data"] valueForKey:@"email"] crmid:crmTxtFld.text mobile:[[Customer_Dict valueForKey:@"data"] valueForKey:@"mobile"]];
        
        if ([[crmDict valueForKey:@"status"] integerValue] == 0)
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:[crmDict valueForKey:@"message"]]];
        }
        else {
            
            NSMutableDictionary * userDict = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"]];
            NSMutableDictionary *userInfoDict = [[NSMutableDictionary alloc] initWithDictionary:[userDict valueForKey:@"data"]];
            [userInfoDict setObject:[[Customer_Dict valueForKey:@"data"] valueForKey:@"firstname"] forKey:@"firstname"];
            [userInfoDict setObject:[[Customer_Dict valueForKey:@"data"] valueForKey:@"lastname"] forKey:@"lastname"];
            [userInfoDict setObject:[[Customer_Dict valueForKey:@"data"] valueForKey:@"email"] forKey:@"email"];
            [userInfoDict setObject:crmTxtFld.text forKey:@"crmid"];
            [userInfoDict setObject:[[Customer_Dict valueForKey:@"data"] valueForKey:@"mobile"] forKey:@"mobile"];
            [userDict setObject:userInfoDict forKey:@"data"];
            [[NSUserDefaults standardUserDefaults] setValue:userDict forKey:@"CustomerDict"];
            
            
//            smartRewardVew.hidden = YES;
            [self getwallet];
        }
        [SVProgressHUD dismiss];
    }
    
    
    
}

-(void)applyWallet
{
        
        
//    if (([_grandTotalStr integerValue] > ([walletValueStr integerValue] + [srcValueStr integerValue])))
    
        
        
        
    if ([_grandTotalStr integerValue] < [credits integerValue])
    {
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating224) toTarget:self withObject:nil];
        NSDictionary * tempDict = [Webmethods applyWallet:_grandTotalStr];
        if ([[NSString stringWithFormat:@"%@",[tempDict valueForKey:@"status"]] isEqualToString:@"1"])
        {
            NSDictionary * cartDict = [tempDict valueForKey:@"data"];
            NSString * value =[NSString stringWithFormat:@"Rs. %.2f",[[[cartDict valueForKey:@"customercredit"] valueForKey:@"value"] floatValue]];
            
            redeemRemoveBool = YES;
            
            int number = [[[cartDict valueForKey:@"customercredit"] valueForKey:@"value"] floatValue];
            if (number < 0) {
                number = (0 - number);
            }
            
            finalAmount = [NSString stringWithFormat:@"%i", number];
            
            if (redeemRemoveBool == YES)
            {
            }
            else
            {
            }
            
            finalAmount = _grandTotalStr;
            
        }
        else
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
//            return ;
        }
//        [SVProgressHUD dismiss];
    }
    
    else
    {
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating224) toTarget:self withObject:nil];
        NSDictionary * tempDict = [Webmethods applyWallet:credits];
        if ([[NSString stringWithFormat:@"%@",[tempDict valueForKey:@"status"]] isEqualToString:@"1"])
        {
            NSDictionary * cartDict = [tempDict valueForKey:@"data"];
            NSString * value =[NSString stringWithFormat:@"Rs. %.2f",[[[cartDict valueForKey:@"grand_total"] valueForKey:@"value"] floatValue]];
            int number = [[[cartDict valueForKey:@"customercredit"] valueForKey:@"value"] floatValue];
            if (number < 0) {
                number = (0 - number);
            }
            
            finalAmount = [NSString stringWithFormat:@"%i", number];
            if (srcRedeemRemoveBool == YES)
            {
                srcFinalAmount = srcValueStr;
            }
            if (redeemRemoveBool == YES)
            {
                int creditIs = ([srcFinalAmount integerValue] + [credits integerValue]) - [_grandTotalStr integerValue];
                if (creditIs > 0)
                {
                    int finalCreditIs = [credits integerValue] - creditIs;
                    finalAmount = [NSString stringWithFormat:@"%i", finalCreditIs];
                }
                else
                {
                    finalAmount = credits;
                }
                
            }
            else
            {
                int creditIs = ([credits integerValue]) - [_grandTotalStr integerValue];
                
                if (creditIs > 0)
                {
                    int finalCreditIs = [credits integerValue] - creditIs;
                    finalAmount = [NSString stringWithFormat:@"%i", finalCreditIs];
                }
                else
                {
                    finalAmount = credits;
                }

                
//                finalAmount = [NSString stringWithFormat:@"%i", finalCreditIs];
            }
            
//            finalAmount = credits;
            //grandTotalLbl.text = value;
        }
        else
        {
            
            if (redeemRemoveBool == YES)
            {
                
                srcFinalAmount = srcValueStr;
                int number = (int)[srcFinalAmount integerValue];
                if (number < 0) {
                    number = (0 - number);
                }
                srcFinalAmount = [NSString stringWithFormat:@"%i", number];
                int creditIs = ([srcFinalAmount integerValue] + [credits integerValue]) - [_grandTotalStr integerValue];
                if (creditIs > 0)
                {
                    int finalCreditIs = [credits integerValue] - creditIs;
                    finalAmount = [NSString stringWithFormat:@"%i", finalCreditIs];
                }
                else
                {
                    finalAmount = credits;
                }
                
            }
            else
            {
                int creditIs = ([credits integerValue]) - [_grandTotalStr integerValue];
                
                if (creditIs > 0)
                {
                    int finalCreditIs = [credits integerValue] - creditIs;
                    finalAmount = [NSString stringWithFormat:@"%i", finalCreditIs];
                }
                else
                {
                    finalAmount = credits;
                }
                
                
                //                finalAmount = [NSString stringWithFormat:@"%i", finalCreditIs];
            }

//            [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
//            return ;
        }
//        [SVProgressHUD dismiss];
    }
    
}


- (IBAction)backBtnAct:(UIButton *)sender
{
    NSDictionary * srcTempDict = [Webmethods applySRC:@"0.00"];
    NSDictionary * tempDict = [Webmethods applyWallet:@"0.00"];
//    NSLog(@"tempDict %@", tempDict);
    NSDictionary * cartDict = [tempDict valueForKey:@"data"];
    if ([[[cartDict valueForKey:@"grand_total"] valueForKey:@"value"] isKindOfClass:[NSNull class]])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        NSString * value =[NSString stringWithFormat:@"Rs. %.2f",[[[cartDict valueForKey:@"grand_total"] valueForKey:@"value"] floatValue]];
        [self.navigationController popViewControllerAnimated:NO];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifer = @"cell";
    UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [payemntTypeArr objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    [paymentTblVew setBackgroundColor:[UIColor clearColor]];
     cell.backgroundColor = [UIColor clearColor];
    
//    if (indexPath.row == 1)
//    {
//        walletLbl = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width-100, 0, 44, 44)];
//        walletLbl.text = walletValueStr;
//        [cell addSubview:walletLbl];
//    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return payemntTypeArr.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.frame = CGRectMake(12, 0, ScreenWidth, 20);
    myLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    myLabel.text = @"Other Payment Options";
    myLabel.textColor=[UIColor colorWithRed: 83/255.0 green:88/255.0 blue:95/255.0 alpha:1.0];
    [myLabel setBackgroundColor:[UIColor colorWithRed: 237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0]];
    UIView *headerView = [[UIView alloc] init];
    [headerView addSubview:myLabel];
    
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(void) threadStartAnimating224
{
    [SVProgressHUD show];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    if (indexPath.row == 0)
    {
        PaymentType_Str = @"cashondelivery";
        if (redeemRemoveBool == YES)
        {
            
            [self applyWallet];
            [self myorderReviewMethod_NextbutObj:0];
        }
        else
        {
            [self myorderReviewMethod_NextbutObj:0];
        }
        
    }
    if (indexPath.row == 1)
    {
        PaymentType_Str = @"cashondelivery";
        if (redeemRemoveBool == YES)
        {
            
            [self applyWallet];
            [self myorderReviewMethod_NextbutObj:(int)indexPath.row];
        }
        else
        {
            [self myorderReviewMethod_NextbutObj:(int)indexPath.row];
        }
        
    }
//    else if (indexPath.row==2)
//    {
//        PaymentType_Str=@"moto";
//        if (redeemRemoveBool == YES)
//        {
//            
//            [self applyWallet];
//            [self myorderReviewMethod_NextbutObj:(int)indexPath.row];
//        }
//        else
//        {
//            [self myorderReviewMethod_NextbutObj:(int)indexPath.row];
//        }
//        
//        appDele.creditCardNetbankingFlag = 1;
//
//    }
    else if (indexPath.row == 2)
    {
        PaymentType_Str=@"creditcard";
        if (redeemRemoveBool == YES)
        {
            [self applyWallet];
            [self myorderReviewMethod_NextbutObj:(int)indexPath.row];
        }
        else
        {
            [self myorderReviewMethod_NextbutObj:(int)indexPath.row];
        }
        
        
        appDele.creditCardNetbankingFlag = 2;
        
    }
    else if (indexPath.row == 3)
    {
//        [self walletMethod];
        PaymentType_Str=@"moto";
        if (redeemRemoveBool == YES)
        {
            [self applyWallet];
            [self myorderReviewMethod_NextbutObj:(int)indexPath.row];
        }
        else
        {
            [self myorderReviewMethod_NextbutObj:(int)indexPath.row];
        }
        appDele.creditCardNetbankingFlag = 3;
        
    }
    
    else if (indexPath.row == 4)
    {
        //        [self walletMethod];
        PaymentType_Str=@"paytm_cc";
        if (redeemRemoveBool == YES)
        {
            [self applyWallet];
            [self myorderReviewMethod_NextbutObj:(int)indexPath.row];
        }
        else
        {
            [self myorderReviewMethod_NextbutObj:(int)indexPath.row];
        }
        appDele.creditCardNetbankingFlag = 4;
        
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
    return footer;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}
- (IBAction)myorderReviewMethod_NextbutObj:(int)tag
{
    
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating224) toTarget:self withObject:nil];
   
    NSString *Billingaddredd_ID = [[NSUserDefaults standardUserDefaults] valueForKey:@"Billingaddress_ID"];
    
    NSString *sloat_id_str = [[NSUserDefaults standardUserDefaults] valueForKey:@"Sloat_ID_Str"];
    NSString *newString = [[NSUserDefaults standardUserDefaults] valueForKey:@"SloatDate_str"];
    
    
    NSMutableDictionary *orderConfirmationDict = [[NSMutableDictionary alloc] initWithDictionary:appDele.orderConfirmationDict];
    [orderConfirmationDict setObject:PaymentType_Str forKey:@"paymentMethod"];
    appDele.orderConfirmationDict = orderConfirmationDict;
    
    appDele.bangeStr = @"0";
    
    NSString * storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
    
    if (tag==0)
    {
        
        int number = [srcFinalAmount floatValue];
        if (number < 0) {
            number = (0 - number);
        }
        srcFinalAmount = [NSString stringWithFormat:@"%d", number];
        if (srcRedeemRemoveBool == YES)
        {
            srcFinalAmount = srcValueStr;
        }
        
        FinalResult_Dict=[Webmethods createorder:Billingaddredd_ID andshiptoid:Billingaddredd_ID andpayby:PaymentType_Str anddate:newString andslotid:sloat_id_str andcredits:finalAmount andCrmCredit:srcFinalAmount is_card:@"0"];
        
//        FinalResult_Dict=[Webmethods createorder:Billingaddredd_ID andshiptoid:Billingaddredd_ID andpayby:PaymentType_Str anddate:newString andslotid:sloat_id_str andcredits:finalAmount andCrmCredit:srcFinalAmount is_card:@"1"];
      
        [[NSUserDefaults standardUserDefaults] setObject:FinalResult_Dict forKey:@"PaymentDict"];
        NSString * Status=[FinalResult_Dict valueForKey:@"status"];
        
        [super viewDidLoad];
        
        if ([FinalResult_Dict valueForKey:@"data"]!=nil)
        {
            Data=[FinalResult_Dict valueForKey:@"data"];
            
        }
        
         [SVProgressHUD dismiss];
        if ([Status intValue] == 1 )
        {
            
            
            [self.view addSubview:[[ToastAlert alloc] initWithText:[FinalResult_Dict valueForKey:@"message"]]];
            appDele.bangeStr = @"0";
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"OrderIDToken"];
            
            Result* result;
            
//            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//            {
                result=[[Result alloc]initWithNibName:@"Result" bundle:nil];
//            }
//            else
//            {
//                result=[[Result alloc] initWithNibName:@"Result~iPad" bundle:nil];
//            }
            
            
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"incrementid"] integerValue]] forKey:@"OrderIDToken"];
            
            
            /***
                choosePaymentCODEvent Event Start
             ***/
            
            NSString *orderid = [NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"incrementid"] integerValue]];
            
            
            NSMutableDictionary *paymentModeDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                    orderid, kOrderNoProperty,
                                                    storeIdStr, kStoreIdProperty,
                                                    nil];
            
            [SH_TrackingUtility trackEventOfSpencerEvents:choosePaymentCODEvent eventProp:paymentModeDict];
            
            /***
                choosePaymentCODEvent Event End
             ***/
            
            //result.orderIdStr = [NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"orderid"] integerValue]];
            [self.navigationController pushViewController:result animated:YES];
        }
        else{
            [self.view addSubview:[[ToastAlert alloc] initWithText:[FinalResult_Dict valueForKey:@"message"]]];
            
        }
        //
        //        [HUD hide:YES];
        //[self performSelector:@selector(getDataSelector) withObject:nil afterDelay:0];
        
    }

    if (tag==1)
    {
        
        int number = [srcFinalAmount floatValue];
        if (number < 0) {
            number = (0 - number);
        }
        srcFinalAmount = [NSString stringWithFormat:@"%d", number];
        if (srcRedeemRemoveBool == YES)
        {
            srcFinalAmount = srcValueStr;
        }
//        FinalResult_Dict=[Webmethods createorder:Billingaddredd_ID andshiptoid:Billingaddredd_ID andpayby:PaymentType_Str anddate:newString andslotid:sloat_id_str andcredits:finalAmount andCrmCredit:srcFinalAmount];
        
        FinalResult_Dict=[Webmethods createorder:Billingaddredd_ID andshiptoid:Billingaddredd_ID andpayby:PaymentType_Str anddate:newString andslotid:sloat_id_str andcredits:finalAmount andCrmCredit:srcFinalAmount is_card:@"1"];
        
        [[NSUserDefaults standardUserDefaults] setObject:FinalResult_Dict forKey:@"PaymentDict"];
        NSString * Status=[FinalResult_Dict valueForKey:@"status"];
        
        [super viewDidLoad];
        
        if ([FinalResult_Dict valueForKey:@"data"]!=nil)
        {
            Data=[FinalResult_Dict valueForKey:@"data"];
            
        }
        
        [SVProgressHUD dismiss];
        if ([Status intValue] == 1 )
        {
            
            
            [self.view addSubview:[[ToastAlert alloc] initWithText:[FinalResult_Dict valueForKey:@"message"]]];
            appDele.bangeStr = @"0";
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"OrderIDToken"];
            
            Result* result;
            
            //            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            //            {
            result=[[Result alloc]initWithNibName:@"Result" bundle:nil];
            //            }
            //            else
            //            {
            //                result=[[Result alloc] initWithNibName:@"Result~iPad" bundle:nil];
            //            }
            
            
            
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"incrementid"] integerValue]] forKey:@"OrderIDToken"];
            
            
            /***
             choosePaymentCODEvent Event Start
             ***/
            
            NSString *orderid = [NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"incrementid"] integerValue]];
            
            
            NSMutableDictionary *paymentModeDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                    orderid, kOrderNoProperty,
                                                    storeIdStr, kStoreIdProperty,
                                                    nil];
            
            [SH_TrackingUtility trackEventOfSpencerEvents:choosePaymentCODEvent eventProp:paymentModeDict];
            
            /***
             choosePaymentCODEvent Event End
             ***/
            
            //result.orderIdStr = [NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"orderid"] integerValue]];
            [self.navigationController pushViewController:result animated:YES];
        }
        else{
            [self.view addSubview:[[ToastAlert alloc] initWithText:[FinalResult_Dict valueForKey:@"message"]]];
            
        }
        //
        //        [HUD hide:YES];
        //[self performSelector:@selector(getDataSelector) withObject:nil afterDelay:0];
        
    }

    
//    else if (tag==2)
//    {
//        
//        int number = [srcFinalAmount floatValue];
//        if (number < 0) {
//            number = (0 - number);
//        }
//        srcFinalAmount = [NSString stringWithFormat:@"%d", number];
//        
//        FinalResult_Dict=[Webmethods createorder:Billingaddredd_ID andshiptoid:Billingaddredd_ID andpayby:PaymentType_Str anddate:newString andslotid:sloat_id_str andcredits:finalAmount andCrmCredit:srcFinalAmount is_card:@"0"];
//        NSMutableDictionary *finalPaymentDictionary = [[FinalResult_Dict valueForKey:@"data"] valueForKey:@"moto"];
//        
//        if ([[finalPaymentDictionary valueForKey:@"City"] isKindOfClass:[NSNull class]])
//        {
//            [finalPaymentDictionary setObject:@"" forKey:@"City"];
//        }
//        if ([[finalPaymentDictionary valueForKey:@"Country"] isKindOfClass:[NSNull class]])
//        {
//            [finalPaymentDictionary setObject:@"" forKey:@"Country"];
//        }
//        if ([[finalPaymentDictionary valueForKey:@"Lastname"] isKindOfClass:[NSNull class]])
//        {
//            [finalPaymentDictionary setObject:@"" forKey:@"Lastname"];
//        }
//        if ([[finalPaymentDictionary valueForKey:@"State"] isKindOfClass:[NSNull class]])
//        {
//            [finalPaymentDictionary setObject:@"" forKey:@"State"];
//        }
//        if ([[finalPaymentDictionary valueForKey:@"Zipcode"] isKindOfClass:[NSNull class]])
//        {
//            [finalPaymentDictionary setObject:@"" forKey:@"Zipcode"];
//        }
//        if ([[finalPaymentDictionary valueForKey:@"amount"] isKindOfClass:[NSNull class]])
//        {
//            [finalPaymentDictionary setObject:@"" forKey:@"amount"];
//        }
//        if ([[finalPaymentDictionary valueForKey:@"email"] isKindOfClass:[NSNull class]])
//        {
//            [finalPaymentDictionary setObject:@"" forKey:@"email"];
//        }
//        if ([[finalPaymentDictionary valueForKey:@"firstname"] isKindOfClass:[NSNull class]])
//        {
//            [finalPaymentDictionary setObject:@"" forKey:@"firstname"];
//        }
//        if ([[finalPaymentDictionary valueForKey:@"phone"] isKindOfClass:[NSNull class]])
//        {
//            [finalPaymentDictionary setObject:@"" forKey:@"phone"];
//        }
//        
//        NSMutableDictionary *motodict = [[NSMutableDictionary alloc] init];
//        [motodict setObject:finalPaymentDictionary forKey:@"moto"];
//        [motodict setObject:[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"incrementid"] forKey:@"incrementid"];
//        [motodict setObject:[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"orderid"] forKey:@"orderid"];
//        
//        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
//        [dataDict setObject:motodict forKey:@"data"];
//        [dataDict setObject:[FinalResult_Dict valueForKey:@"message"] forKey:@"message"];
//        [dataDict setObject:[FinalResult_Dict valueForKey:@"status"] forKey:@"status"];
//        //        FinalResult_Dict = dataDict;
//        
//        [[NSUserDefaults standardUserDefaults] setObject:dataDict forKey:@"PaymentDict"];
//        
//        [SVProgressHUD dismiss];
//        NSString * Status=[FinalResult_Dict valueForKey:@"status"];
//        
//        if ([FinalResult_Dict valueForKey:@"data"]!=nil)
//        {
//            Data=[FinalResult_Dict valueForKey:@"data"];
//        }
//        
//        
//        if ([Status intValue] == 1)
//        {
//            appDele.citrusfinalamount = [[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"amount"];
//            appDele.citrusWalletAmount=[[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"amount"];
//            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"incrementid"] integerValue]] forKey:@"OrderIDToken"];
//            
//            if (authLayer.requestSignInOauthToken.length != 0) {
//                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                    appDele.citrusfinalamount = [[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"amount"];
//                    appDele.citrusWalletAmount=[[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"amount"];
//                    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
//                    appDele.paymentIndexNumber = tag;
//                    //            appDele.citrusfinalamount=_grandTotalStr;
//                    appDele.pushBool = 11;
//                    [self.navigationController pushViewController:vc animated:NO];
//                    //            [self performSegueWithIdentifier:@"HomeScreenIdentifier" sender:nil];
//                    return;
//                }];
//            }
//            else
//            {
////                [self walletMethod];
//                [self linkUser123];
//            }
////            [self walletMethod];
////
////            [self performSelector:@selector(walletPayment) withObject:nil afterDelay:5];
//            
//            
//            
//                    
//            
//        }
//        else
//        {
//            [self.view addSubview:[[ToastAlert alloc] initWithText:[FinalResult_Dict valueForKey:@"message"]]];
//            
//        }
//    }
    else if(tag==2)
    {
    
        int number = [srcFinalAmount floatValue];
        if (number < 0) {
            number = (0 - number);
        }
        srcFinalAmount = [NSString stringWithFormat:@"%d", number];
        
        if (srcRedeemRemoveBool == YES)
        {
            srcFinalAmount = srcValueStr;
        }
        FinalResult_Dict=[Webmethods createorder:Billingaddredd_ID andshiptoid:Billingaddredd_ID andpayby:PaymentType_Str anddate:newString andslotid:sloat_id_str andcredits:finalAmount andCrmCredit:srcFinalAmount is_card:@"0"];
        
        NSMutableDictionary *finalPaymentDictionary = [[FinalResult_Dict valueForKey:@"data"] valueForKey:@"moto"];
        
        if ([[finalPaymentDictionary valueForKey:@"City"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"City"];
        }
        if ([[finalPaymentDictionary valueForKey:@"Country"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"Country"];
        }
        if ([[finalPaymentDictionary valueForKey:@"Lastname"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"Lastname"];
        }
        if ([[finalPaymentDictionary valueForKey:@"State"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"State"];
        }
        if ([[finalPaymentDictionary valueForKey:@"Zipcode"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"Zipcode"];
        }
        if ([[finalPaymentDictionary valueForKey:@"amount"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"amount"];
        }
        if ([[finalPaymentDictionary valueForKey:@"email"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"email"];
        }
        if ([[finalPaymentDictionary valueForKey:@"firstname"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"firstname"];
        }
        if ([[finalPaymentDictionary valueForKey:@"phone"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"phone"];
        }
        
        NSMutableDictionary *motodict = [[NSMutableDictionary alloc] init];
        [motodict setObject:finalPaymentDictionary forKey:@"moto"];
        [motodict setObject:[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"incrementid"] forKey:@"incrementid"];
        [motodict setObject:[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"orderid"] forKey:@"orderid"];
        
        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
        [dataDict setObject:motodict forKey:@"data"];
        [dataDict setObject:[FinalResult_Dict valueForKey:@"message"] forKey:@"message"];
        [dataDict setObject:[FinalResult_Dict valueForKey:@"status"] forKey:@"status"];
//        FinalResult_Dict = dataDict;
        
        [[NSUserDefaults standardUserDefaults] setObject:dataDict forKey:@"PaymentDict"];
        
        
     
        [super viewDidLoad];
        
        [SVProgressHUD dismiss];
        
        
        
        
        
        
        if (tag == 2)
        {
            appDele.Checkpage = @"11";
            appDele.pageType = @"Credit / Debit Card";
//            appDele.Checkpage = @"12";
//            appDele.pageType = @"Debit Card";
            
        }
        else if (tag == 3)
        {
            appDele.Checkpage = @"13";
            appDele.pageType = @"Net Banking";
        }
//        NSLog(@"FinalResult_Dict %@", FinalResult_Dict);
        
        NSString * Status=[FinalResult_Dict valueForKey:@"status"];
        
        if ([FinalResult_Dict valueForKey:@"data"]!=nil)
        {
            Data = [FinalResult_Dict valueForKey:@"data"];
        }
        
        
        
        if ([Status intValue] == 1 )
        {
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"incrementid"] integerValue]] forKey:@"OrderIDToken"];
            appDele.citrusfinalamount = [NSString stringWithFormat:@"%.2f", [[[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"amount"] floatValue]];
            vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CardsViewController"];
            vc.landingScreen=1;
            appDele.paymentIndexNumber = tag;
            appDele.pushFlag = 20;
//            appDele.citrusfinalamount=_grandTotalStr;
            appDele.pushBool = 10;
            
            
            /***
             Choose Payment_Citrus Event Start
             ***/
            
            NSString *orderid = [NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"incrementid"] integerValue]];
            
            
            NSMutableDictionary *paymentModeDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                    orderid, kOrderNoProperty,
                                                    storeIdStr, kStoreIdProperty,
                                                    nil];
            
            [SH_TrackingUtility trackEventOfSpencerEvents:choosePaymentCitrusEvent eventProp:paymentModeDict];
            
            /***
             Choose Payment_Citrus Event End
             ***/
            
            
            
            [self.navigationController pushViewController:vc animated:NO];
        }
        else
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:[FinalResult_Dict valueForKey:@"message"]]];
            
        }
        
//        if (authLayer.requestSignInOauthToken.length != 0) {
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                return;
//            }];
//        }
//        else
//        {
////            [self linking];
//        }
        
    }
    else if (tag==3)
    {
        
        int number = [srcFinalAmount floatValue];
        if (number < 0) {
            number = (0 - number);
        }
        srcFinalAmount = [NSString stringWithFormat:@"%d", number];
        if (srcRedeemRemoveBool == YES)
        {
            srcFinalAmount = srcValueStr;
        }
        FinalResult_Dict=[Webmethods createorder:Billingaddredd_ID andshiptoid:Billingaddredd_ID andpayby:PaymentType_Str anddate:newString andslotid:sloat_id_str andcredits:finalAmount andCrmCredit:srcFinalAmount is_card:@"0"];
        
        NSMutableDictionary *finalPaymentDictionary = [[FinalResult_Dict valueForKey:@"data"] valueForKey:@"moto"];
        
        if ([[finalPaymentDictionary valueForKey:@"City"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"City"];
        }
        if ([[finalPaymentDictionary valueForKey:@"Country"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"Country"];
        }
        if ([[finalPaymentDictionary valueForKey:@"Lastname"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"Lastname"];
        }
        if ([[finalPaymentDictionary valueForKey:@"State"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"State"];
        }
        if ([[finalPaymentDictionary valueForKey:@"Zipcode"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"Zipcode"];
        }
        if ([[finalPaymentDictionary valueForKey:@"amount"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"amount"];
        }
        if ([[finalPaymentDictionary valueForKey:@"email"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"email"];
        }
        if ([[finalPaymentDictionary valueForKey:@"firstname"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"firstname"];
        }
        if ([[finalPaymentDictionary valueForKey:@"phone"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"phone"];
        }
        
        NSMutableDictionary *motodict = [[NSMutableDictionary alloc] init];
        [motodict setObject:finalPaymentDictionary forKey:@"moto"];
        [motodict setObject:[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"incrementid"] forKey:@"incrementid"];
        [motodict setObject:[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"orderid"] forKey:@"orderid"];
        
        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
        [dataDict setObject:motodict forKey:@"data"];
        [dataDict setObject:[FinalResult_Dict valueForKey:@"message"] forKey:@"message"];
        [dataDict setObject:[FinalResult_Dict valueForKey:@"status"] forKey:@"status"];
        //        FinalResult_Dict = dataDict;
        
        [[NSUserDefaults standardUserDefaults] setObject:dataDict forKey:@"PaymentDict"];
        
        
        
        [super viewDidLoad];
        
        [SVProgressHUD dismiss];
        
        
        
        if (tag == 2)
        {
            appDele.Checkpage = @"11";
            appDele.pageType = @"Credit / Debit Card";
            //            appDele.Checkpage = @"12";
            //            appDele.pageType = @"Debit Card";
            
        }
        else if (tag == 3)
        {
            appDele.Checkpage = @"13";
            appDele.pageType = @"Net Banking";
        }
        //        NSLog(@"FinalResult_Dict %@", FinalResult_Dict);
        
        NSString * Status=[FinalResult_Dict valueForKey:@"status"];
        
        if ([FinalResult_Dict valueForKey:@"data"]!=nil)
        {
            Data = [FinalResult_Dict valueForKey:@"data"];
        }
        
        
        
        if ([Status intValue] == 1 )
        {
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"incrementid"] integerValue]] forKey:@"OrderIDToken"];
            appDele.citrusfinalamount = [[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"amount"];
            vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CardsViewController"];
            vc.landingScreen=1;
            appDele.paymentIndexNumber = tag;
            appDele.pushFlag = 20;
            //            appDele.citrusfinalamount=_grandTotalStr;
            appDele.pushBool = 10;
            
            
            /***
             Choose Payment_Citrus Event Start
             ***/
            
            NSString *orderid = [NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"incrementid"] integerValue]];
            
            
            NSMutableDictionary *paymentModeDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                    orderid, kOrderNoProperty,
                                                    storeIdStr, kStoreIdProperty,
                                                    nil];
            
            [SH_TrackingUtility trackEventOfSpencerEvents:choosePaymentCitrusEvent eventProp:paymentModeDict];
            
            /***
             Choose Payment_Citrus Event End
             ***/
            
            
            [self.navigationController pushViewController:vc animated:NO];
        }
        else
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:[FinalResult_Dict valueForKey:@"message"]]];
            
        }
        
        //        if (authLayer.requestSignInOauthToken.length != 0) {
        //            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        //                return;
        //            }];
        //        }
        //        else
        //        {
        ////            [self linking];
        //        }
        
    }
    
    else if (tag == 4)
    {
        
        float number = [srcFinalAmount floatValue];
        if (number < 0) {
            number = (0 - number);
        }
        srcFinalAmount = [NSString stringWithFormat:@"%.2f", number];
        PaymentType_Str = @"paytm_cc";
        if (srcRedeemRemoveBool == YES)
        {
            srcFinalAmount = srcValueStr;
        }
        FinalResult_Dict=[Webmethods createorder:Billingaddredd_ID andshiptoid:Billingaddredd_ID andpayby:PaymentType_Str anddate:newString andslotid:sloat_id_str andcredits:finalAmount andCrmCredit:srcFinalAmount is_card:@"0"];
        NSMutableDictionary *finalPaymentDictionary = [[FinalResult_Dict valueForKey:@"data"] valueForKey:@"moto"];
        
        if ([[finalPaymentDictionary valueForKey:@"City"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"City"];
        }
        if ([[finalPaymentDictionary valueForKey:@"Country"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"Country"];
        }
        if ([[finalPaymentDictionary valueForKey:@"Lastname"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"Lastname"];
        }
        if ([[finalPaymentDictionary valueForKey:@"State"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"State"];
        }
        if ([[finalPaymentDictionary valueForKey:@"Zipcode"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"Zipcode"];
        }
        if ([[finalPaymentDictionary valueForKey:@"amount"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"amount"];
        }
        if ([[finalPaymentDictionary valueForKey:@"email"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"email"];
        }
        if ([[finalPaymentDictionary valueForKey:@"firstname"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"firstname"];
        }
        if ([[finalPaymentDictionary valueForKey:@"phone"] isKindOfClass:[NSNull class]])
        {
            [finalPaymentDictionary setObject:@"" forKey:@"phone"];
        }
        
        NSMutableDictionary *motodict = [[NSMutableDictionary alloc] init];
        [motodict setObject:finalPaymentDictionary forKey:@"moto"];
        [motodict setObject:[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"incrementid"] forKey:@"incrementid"];
        [motodict setObject:[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"orderid"] forKey:@"orderid"];
        
        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
        [dataDict setObject:motodict forKey:@"data"];
        [dataDict setObject:[FinalResult_Dict valueForKey:@"message"] forKey:@"message"];
        [dataDict setObject:[FinalResult_Dict valueForKey:@"status"] forKey:@"status"];
        //        FinalResult_Dict = dataDict;
        
        [[NSUserDefaults standardUserDefaults] setObject:dataDict forKey:@"PaymentDict"];
        
        [SVProgressHUD dismiss];
        NSString * Status=[FinalResult_Dict valueForKey:@"status"];
        
        if ([FinalResult_Dict valueForKey:@"data"]!=nil)
        {
            Data=[FinalResult_Dict valueForKey:@"data"];
        }
        
        if ([Status intValue] == 1)
        {
            
            /***
             Choose Payment_Paytm Event Start
             ***/
            
            NSString *orderid = [NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"incrementid"] integerValue]];
            
            
            NSMutableDictionary *paymentModeDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                    orderid, kOrderNoProperty,
                                                    storeIdStr, kStoreIdProperty,
                                                    nil];
            
            [SH_TrackingUtility trackEventOfSpencerEvents:choosePaymentPaytmEvent eventProp:paymentModeDict];
            
            /***
             Choose Payment_Paytm Event End
             ***/
            
            PGMerchantConfiguration *mc = [PGMerchantConfiguration defaultConfiguration];
            
            //Step 2: If you have your own checksum generation and validation url set this here. Otherwise use the default Paytm urls
            //            mc.checksumGenerationURL = @"https://pguat.paytm.com/paytmchecksum/paytmCheckSumGenerator.jsp";
            //            mc.checksumValidationURL = @"https://pguat.paytm.com/paytmchecksum/paytmCheckSumVerify.jsp";
            
            //            mc.checksumGenerationURL = @"https://pguat.paytm.com/paytmchecksum/paytmCheckSumGenerator.jsp";
            //            mc.checksumValidationURL = @"https://pguat.paytm.com/paytmchecksum/paytmCheckSumVerify.jsp";
            //
            //            //Step 3: Create the order with whatever params you want to add. But make sure that you include the merchant mandatory params
            //            NSMutableDictionary *orderDict = [NSMutableDictionary new];
            //            //Merchant configuration in the order object
            //            orderDict[@"MID"] = @"WorldP64425807474247";
            //            orderDict[@"CHANNEL_ID"] = @"WAP";
            //            orderDict[@"INDUSTRY_TYPE_ID"] = @"Retail";
            //            orderDict[@"WEBSITE"] = @"worldpressplg";
            //            //Order configuration in the order object
            //            orderDict[@"TXN_AMOUNT"] = @"1";
            //            orderDict[@"ORDER_ID"] = [[FinalResult_Dict valueForKey:@"data"] valueForKey:@"incrementid"];
            //            orderDict[@"REQUEST_TYPE"] = @"DEFAULT";
            //            orderDict[@"CUST_ID"] = @"1234567890";
            //
            //            PGOrder *order = [PGOrder orderWithParams:orderDict];
            
            
            //            http://52.77.39.21/PaytmChecksum/generateChecksum.php
            //            http://52.77.39.21/PaytmChecksum/verifyChecksum.php
            
            
            //        https://pguat.paytm.com/paytmchecksum/paytmCheckSumGenerator.jsp";
            //            mc.checksumValidationURL = @"https://pguat.paytm.com/paytmchecksum/paytmCheckSumVerify.jsp";
            
            
            
//            mc.checksumGenerationURL = @"http://52.77.39.21/PaytmChecksum/generateChecksum.php";
//            mc.checksumValidationURL = @"http://52.77.39.21/PaytmChecksum/verifyChecksum.php";
//            apis.spencers.in/upgrade/2017
            
            mc.checksumGenerationURL = @"http://www.spencers.in/PaytmChecksum/generateChecksum.php";
            mc.checksumValidationURL = @"http://www.spencers.in/PaytmChecksum/verifyChecksum.php";
            
            //Step 3: Create the order with whatever params you want to add. But make sure that you include the merchant mandatory params
            NSMutableDictionary *orderDict = [NSMutableDictionary new];
            //Merchant configuration in the order object
            orderDict[@"MID"] = @"Spence87651707897743";
            orderDict[@"CHANNEL_ID"] = @"WAP";
            orderDict[@"INDUSTRY_TYPE_ID"] = @"Retail";
            orderDict[@"WEBSITE"] = @"SpencersWAP";
            //Order configuration in the order object
            orderDict[@"TXN_AMOUNT"] = [NSString stringWithFormat:@"%.2f", [[[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"amount"] floatValue]];
            orderDict[@"ORDER_ID"] = [[FinalResult_Dict valueForKey:@"data"] valueForKey:@"incrementid"];
            orderDict[@"REQUEST_TYPE"] = @"DEFAULT";
            orderDict[@"CUST_ID"] = [[userInfo valueForKey:@"data"] valueForKey:@"customerid"];
            orderDict[@"THEME"] = @"merchant";
            
            orderDict[@"EMAIL"] = [[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"email"];
            orderDict[@"MOBILE_NO"] = [[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"phone"];
            //            orderDict[@"MERCHANT_KEY"]=@"KiBcIYmyRM9qNbZe";
            PGOrder *order = [PGOrder orderWithParams:orderDict];
            
            
            
            //Step 4: Choose the PG server. In your production build dont call selectServerDialog. Just create a instance of the
            //PGTransactionViewController and set the serverType to eServerTypeProduction
//            [PGServerEnvironment selectServerDialog:self.view completionHandler:^(ServerType type)
//             {
                 PGTransactionViewController *txnController = [[PGTransactionViewController alloc] initTransactionForOrder:order];
                 //                 if (type != eServerTypeNone) {
                 txnController.serverType = eServerTypeProduction;
                 txnController.merchant = mc;
                 txnController.delegate = self;
                 [self showController:txnController];
                 //                 }
//             }];
            
            //            appDele.citrusfinalamount = [[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"amount"];
            //            appDele.citrusWalletAmount=[[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"amount"];
            //            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"incrementid"] integerValue]] forKey:@"OrderIDToken"];
            //
            //            if (authLayer.requestSignInOauthToken.length != 0) {
            //                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //                    appDele.citrusfinalamount = [[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"amount"];
            //                    appDele.citrusWalletAmount=[[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"amount"];
            //                    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
            //                    appDele.paymentIndexNumber = tag;
            //                    //            appDele.citrusfinalamount=_grandTotalStr;
            //                    appDele.pushBool = 11;
            //                    [self.navigationController pushViewController:vc animated:NO];
            //                    //            [self performSegueWithIdentifier:@"HomeScreenIdentifier" sender:nil];
            //                    return;
            //                }];
            //            }
            //            else
            //            {
            ////                [self walletMethod];
            //                [self linkUser123];
            //            }
            ////            [self walletMethod];
            ////
            ////            [self performSelector:@selector(walletPayment) withObject:nil afterDelay:5];
            //            
            
            
            
            
        }
        else
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:[FinalResult_Dict valueForKey:@"message"]]];
            
        }
    }
}

-(void)walletPayment
{
    [SVProgressHUD show];
    
    
    [proifleLayer requestGetBalance:^(CTSAmount *amount, NSError *error) {
        
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            [UIUtility toastMessageOnScreen:[error localizedDescription]];
        }
        else{
            UITextField * alertTextField = [[UITextField alloc] init];
            alertTextField.text = [[[FinalResult_Dict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"amount"];
            if(alertTextField.text.length==0){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                [UIUtility toastMessageOnScreen:@"Amount should not be blank."];
                
            }
            
            else if ([alertTextField.text isEqualToString:@"0"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                [UIUtility toastMessageOnScreen:@"Amount should be greater than 0"];
            }
            else if([alertTextField.text doubleValue] > [amount.value doubleValue]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                [UIUtility toastMessageOnScreen:@"The balance in your Citrus Cash account is insufficient. Please load money."];
            }
            else{
                
                [CTSUtility requestBillAmount:alertTextField.text billURL:BillUrl callback:^(CTSBill *bill , NSError *error){
                    
                    if (error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [SVProgressHUD dismiss];
                        });
                        [UIUtility toastMessageOnScreen:[error localizedDescription]];
                    }
                    else{
                        [paymentLayer requestChargeCitrusWalletWithContact:contactInfo address:addressInfo bill:bill returnViewController:self withCompletionHandler:^(CTSCitrusCashRes *paymentInfo, NSError *error) {
                            
                            LogTrace(@"paymentInfo %@",paymentInfo);
                            LogTrace(@"error %@",error);
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [SVProgressHUD dismiss];
                                
                            });
                            if(error){
                                [UIUtility toastMessageOnScreen:[error localizedDescription]];
                            }
                            else{
                                LogTrace(@" isAnyoneSignedIn %d",[authLayer isLoggedIn]);
                                [UIUtility toastMessageOnScreen:[NSString stringWithFormat:@"TxnStatus: %@",[paymentInfo.responseDict valueForKey:@"TxStatus"]]];
                                [self getBalance:nil];
                            }
                        }];
                    }
                }];
            }
        }
    }];
}




-(void)PlaceorderthroughSpencerSRC
{
    NSString *Billingaddredd_ID = [[NSUserDefaults standardUserDefaults] valueForKey:@"Billingaddress_ID"];
    NSString *sloat_id_str = [[NSUserDefaults standardUserDefaults] valueForKey:@"Sloat_ID_Str"];
    NSString *newString = [[NSUserDefaults standardUserDefaults] valueForKey:@"SloatDate_str"];
    
    if (srcRedeemRemoveBool == YES)
    {
        if ([srcFinalAmount integerValue] >= [_grandTotalStr integerValue])
        {
            redeemRemoveBool = NO;
        }
    }
    
    
//    if (redeemRemoveBool == YES)
//    {
//        finalAmount=_grandTotalStr;
//    }
    
    
    int number = [srcFinalAmount floatValue];
    if (number < 0) {
        number = (0 - number);
    }
    srcFinalAmount = [NSString stringWithFormat:@"%d", number];
    
    PaymentType_Str = @"cashondelivery";
    
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating224) toTarget:self withObject:nil];
    if (srcRedeemRemoveBool == YES)
    {
        srcFinalAmount = srcValueStr;
    }
    
    FinalResult_Dict=[Webmethods createorder:Billingaddredd_ID andshiptoid:Billingaddredd_ID andpayby:PaymentType_Str anddate:newString andslotid:sloat_id_str andcredits:finalAmount andCrmCredit:srcFinalAmount is_card:@"0"];
    [SVProgressHUD dismiss];
    
    
    NSMutableDictionary *orderConfirmationDict = [[NSMutableDictionary alloc] initWithDictionary:appDele.orderConfirmationDict];
    [orderConfirmationDict setObject:PaymentType_Str forKey:@"paymentMethod"];
    appDele.orderConfirmationDict = orderConfirmationDict;
    
    
    NSString * Status=[FinalResult_Dict valueForKey:@"status"];
    
    if ([FinalResult_Dict valueForKey:@"data"]!=nil)
    {
        Data=[FinalResult_Dict valueForKey:@"data"];
    }
    
    
    if ([Status intValue] == 1 )
    {
        
        [self.view addSubview:[[ToastAlert alloc] initWithText:[FinalResult_Dict valueForKey:@"message"]]];
        appDele.bangeStr = @"0";
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"OrderIDToken"];
        
        Result* result;
        
        //        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        //        {
        result=[[Result alloc]initWithNibName:@"Result" bundle:nil];
        //        }
        //        else
        //        {
        //            result=[[Result alloc]initWithNibName:@"Result~iPad" bundle:nil];
        //        }
        
        
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"incrementid"] integerValue]] forKey:@"OrderIDToken"];
        
        //result.orderIdStr = [NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"orderid"] integerValue]];
        [self.navigationController pushViewController:result animated:YES];
    }
    else{
        [self.view addSubview:[[ToastAlert alloc] initWithText:[FinalResult_Dict valueForKey:@"message"]]];
        
    }
    
    
}


-(void)PlaceorderthroughSpencerWallet
{
    NSString *Billingaddredd_ID = [[NSUserDefaults standardUserDefaults] valueForKey:@"Billingaddress_ID"];
    NSString *sloat_id_str = [[NSUserDefaults standardUserDefaults] valueForKey:@"Sloat_ID_Str"];
    NSString *newString = [[NSUserDefaults standardUserDefaults] valueForKey:@"SloatDate_str"];
    
    if (srcRedeemRemoveBool == YES)
    {
        if ([srcFinalAmount integerValue] >= [_grandTotalStr integerValue])
        {
            redeemRemoveBool = NO;
        }
    }
    
//    if (redeemRemoveBool == YES)
//    {
//        finalAmount=_grandTotalStr;
//    }
    
    int number = [srcFinalAmount floatValue];
    if (number < 0) {
        number = (0 - number);
    }
    srcFinalAmount = [NSString stringWithFormat:@"%d", number];
    if (srcRedeemRemoveBool == YES)
    {
        srcFinalAmount = srcValueStr;
    }
    PaymentType_Str = @"customercredit";
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating224) toTarget:self withObject:nil];
    
    FinalResult_Dict=[Webmethods createorder:Billingaddredd_ID andshiptoid:Billingaddredd_ID andpayby:PaymentType_Str anddate:newString andslotid:sloat_id_str andcredits:finalAmount andCrmCredit:srcFinalAmount is_card:@"0"];
    [SVProgressHUD dismiss];
    
    
    NSMutableDictionary *orderConfirmationDict = [[NSMutableDictionary alloc] initWithDictionary:appDele.orderConfirmationDict];
    [orderConfirmationDict setObject:PaymentType_Str forKey:@"paymentMethod"];
    appDele.orderConfirmationDict = orderConfirmationDict;
    
    
    NSString * Status=[FinalResult_Dict valueForKey:@"status"];
    
    if ([FinalResult_Dict valueForKey:@"data"]!=nil)
    {
        Data=[FinalResult_Dict valueForKey:@"data"];
    }
    [SVProgressHUD dismiss];
    
    if ([Status intValue] == 1 )
    {
        
        [self.view addSubview:[[ToastAlert alloc] initWithText:[FinalResult_Dict valueForKey:@"message"]]];
        appDele.bangeStr = @"0";
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"OrderIDToken"];
        
        Result* result;
        
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            result=[[Result alloc]initWithNibName:@"Result" bundle:nil];
//        }
//        else
//        {
//            result=[[Result alloc]initWithNibName:@"Result~iPad" bundle:nil];
//        }
        
        
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"incrementid"] integerValue]] forKey:@"OrderIDToken"];
        
        //result.orderIdStr = [NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"orderid"] integerValue]];
        [self.navigationController pushViewController:result animated:YES];
    }
    else{
        [self.view addSubview:[[ToastAlert alloc] initWithText:[FinalResult_Dict valueForKey:@"message"]]];
        
    }
    
    
}
-(IBAction)getBalance:(id)sender
{
    
    
    [proifleLayer requestGetBalance:^(CTSAmount *amount, NSError *error)
     {
         LogTrace(@" value %@ ",amount.value);
         LogTrace(@" currency %@ ",amount.currency);
         dispatch_async(dispatch_get_main_queue(), ^{
         });
         
         if (error) {
             [UIUtility toastMessageOnScreen:[error localizedDescription]];
         }
         else{
             dispatch_async(dispatch_get_main_queue(), ^{
//                 walletAmountLbl.text = [NSString stringWithFormat:@"%@ %@",amount.currency,amount.value];
//                 NSLog(@"self.amountLbl %@", grandTotalLbl.text);
                 walletValueStr = amount.value;
                 
                 walletLbl.text = amount.value;
                 [paymentTblVew reloadData];
             });
             //            [UIUtility toastMessageOnScreen:[NSString stringWithFormat:@"Balance is %@ %@",amount.value,amount.currency]];
         }
     }];
}
-(IBAction)linkUser
{
    
    [self.view endEditing:YES];
//    self.indicatorView.hidden = FALSE;
//    [self.indicatorView startAnimating];
    
    NSString *emailId = [[userProfileData valueForKey:@"data"] valueForKey:@"email"];
    NSString *mobileNo = [[userProfileData valueForKey:@"data"] valueForKey:@"mobile"];
//    userProfileData
    
    [authLayer requestCitrusLink:emailId mobile:mobileNo completion:^(CTSCitrusLinkRes *linkResponse, NSError *error) {
    
    
    scopeType = CTSWalletScopeFull;
    
    
    [authLayer requestMasterLink:emailId  mobile:mobileNo scope:scopeType completionHandler:^(CTSMasterLinkRes *linkResponse, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.indicatorView stopAnimating];
//            self.indicatorView.hidden = TRUE;
        });
        
        if (error)
        {
            [UIUtility toastMessageOnScreen:[error localizedDescription]];
        }
        else{
            if (linkResponse.siginType == CitrusSiginTypeLimited) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self performSegueWithIdentifier:@"HomeScreenIdentifier" sender:self];
                }];
            }
            else {
                // [UIUtility toastMessageOnScreen:linkResponse.userMessage];
                signInType = linkResponse.siginType;
                responseMessage = linkResponse.userMessage;
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                    [self performSegueWithIdentifier:@"SignInScreenIdentifier" sender:self];
//                    [self getBalance:nil];
                    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignInViewController"];
                    appDele.pushBool = 10;
                    [self.navigationController pushViewController:vc animated:NO];
                }];
            }
            
        }
    }];
    }];
}


-(IBAction)linkUser123
{
    
    [self.view endEditing:YES];
//    self.indicatorView.hidden = FALSE;
//    [self.indicatorView startAnimating];
    
    NSDictionary *paymentDict = [[NSUserDefaults standardUserDefaults] valueForKey:@"PaymentDict"];
    
    NSString *emailId = [[[paymentDict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"email"];
    NSString *mobileNo = [[[paymentDict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"phone"];
    scopeType = CTSWalletScopeFull;
    
    [authLayer requestMasterLink:emailId  mobile:mobileNo scope:scopeType completionHandler:^(CTSMasterLinkRes *linkResponse, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.indicatorView stopAnimating];
//            self.indicatorView.hidden = TRUE;
        });
        if (error) {
            [UIUtility toastMessageOnScreen:[error localizedDescription]];
        }
        else{
            
            [UIUtility toastMessageOnScreen:linkResponse.userMessage];
            
            if (linkResponse.siginType == CitrusSiginTypeLimited)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"HomeScreenIdentifier" sender:self];
                });
            }
            else
            {
                
                signInType = linkResponse.siginType;
                responseMessage = linkResponse.userMessage;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignInViewController"];
                    //                        appDele.pushBool = 10;
                    [self.navigationController pushViewController:vc animated:NO];
                });
            }
            
        }
    }];
    
    
}

-(IBAction)walletMethod
{
    
    [self.view endEditing:YES];
    //    self.indicatorView.hidden = FALSE;
    //    [self.indicatorView startAnimating];
    
    NSString *emailId = @"test@mailinator.com";
    NSString *mobileNo = @"8750186300";
    
    [authLayer requestCitrusLink:emailId mobile:mobileNo completion:^(CTSCitrusLinkRes *linkResponse, NSError *error) {
        
        
        scopeType = CTSWalletScopeFull;
        
        
        [authLayer requestMasterLink:emailId  mobile:mobileNo scope:scopeType completionHandler:^(CTSMasterLinkRes *linkResponse, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //            [self.indicatorView stopAnimating];
                //            self.indicatorView.hidden = TRUE;
            });
            
            if (error)
            {
                [UIUtility toastMessageOnScreen:[error localizedDescription]];
            }
            else{
                if (linkResponse.siginType == CitrusSiginTypeLimited) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                        [self performSegueWithIdentifier:@"HomeScreenIdentifier" sender:self];
                    }];
                }
                else{
                    // [UIUtility toastMessageOnScreen:linkResponse.userMessage];
                    signInType = linkResponse.siginType;
                    responseMessage = linkResponse.userMessage;
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        //                    [self performSegueWithIdentifier:@"SignInScreenIdentifier" sender:self];
//                        [self getBalance:nil];
                        UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignInViewController"];
//                        appDele.pushBool = 10;
                        [self.navigationController pushViewController:vc animated:NO];
                    }];
                }
                
            }
        }];
    }];
}


- (IBAction)footerBtnAct:(UIButton *)sender {
    switch (sender.tag)
    {
        case 11:
        {
            BOOL flag = NO;
            for (UIViewController *controller in self.navigationController.viewControllers)
            {
                if ([controller isKindOfClass:[MainCategoryVC class]])
                {
                    flag = YES;
                    [self.navigationController popToViewController:controller animated:YES];
                    break;
                }
            }
            if (flag == NO)
            {
                MainCategoryVC * mainCategoryVC=[[MainCategoryVC alloc]initWithNibName:@"MainCategoryVC" bundle:nil];
                [self.navigationController pushViewController:mainCategoryVC animated:YES];
            }
        }
            break;
        case 12:
        {
            BOOL flag = NO;
            for (UIViewController *controller in self.navigationController.viewControllers)
            {
                if ([controller isKindOfClass:[CategoryPage class]])
                {
                    flag = YES;
                    [self.navigationController popToViewController:controller animated:YES];
                    break;
                }
            }
            if (flag == NO)
            {
                CategoryPage *Categoryvc=[[CategoryPage alloc]initWithNibName:@"CategoryPage" bundle:nil];
                [self.navigationController pushViewController:Categoryvc animated:YES];
            }
        }
            break;
        case 13:
        {
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cat_subcat" ofType:@"json"];
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            NSDictionary * currentArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSMutableArray *listNameArray = [[NSMutableArray alloc] initWithArray:[[currentArray valueForKey:@"data"] valueForKey:@"categories"]];
            
            NSString * storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
            
            NSString *urlStr = [NSString stringWithFormat:@"%@/category/products/%@?page=%@&store=%@", baseUrl1, [[listNameArray objectAtIndex:9] valueForKey:@"category_id"], @"1", storeIdStr];
//            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//            {
                productVC = [[ProductVC alloc] initWithNibName:@"ProductVC" bundle:nil];
//            }
//            else
//            {
//                productVC = [[ProductVC alloc] initWithNibName:@"ProductVC~iPad" bundle:nil];
//            }
            productVC.productHeader = [[listNameArray objectAtIndex:9] valueForKey:@"name"];
            productVC.categoryUrl = urlStr;
            [self.navigationController pushViewController:productVC animated:YES];
        }
            break;
        case 14:
        {
            NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
            NSString *oauth_token =[temp objectForKey:@"oauth_token"];
            if(oauth_token==NULL || [oauth_token isEqual:@""])
            {
//                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//                {
                    loginpage = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
//                }
//                else
//                {
//                    loginpage = [[LoginVC alloc]initWithNibName:@"LoginVC~iPad" bundle:nil];
//                }
                loginpage.CheckProfileStatus=@"002";
                [self.navigationController pushViewController:loginpage animated:NO];
            }
            else
            {
//                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//                {
                    myProfile = [[MyProfileVC alloc] initWithNibName:@"MyProfileVC" bundle:nil];
//                }
//                else
//                {
//                    myProfile = [[MyProfileVC alloc] initWithNibName:@"MyProfileVC~iPad" bundle:nil];
//                }
                [self.navigationController pushViewController:myProfile animated:NO];
                
            }
            
        }
            
            break;
            
            
        default:
            break;
    }
}

-(void)linking
{
    NSString *emailId = [[userProfileData valueForKey:@"data"] valueForKey:@"email"];
    NSString *mobileNo = [[userProfileData valueForKey:@"data"] valueForKey:@"mobile"];
    [authLayer requestCitrusLink:emailId mobile:mobileNo completion:^(CTSCitrusLinkRes *linkResponse, NSError *error) {
//        NSLog(@"linking done");
        
        scopeType = CTSWalletScopeFull;
        [authLayer requestMasterLink:emailId  mobile:mobileNo scope:scopeType completionHandler:^(CTSMasterLinkRes *linkResponse, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //            [self.indicatorView stopAnimating];
                //            self.indicatorView.hidden = TRUE;
            });
            
            if (error)
            {
                [UIUtility toastMessageOnScreen:[error localizedDescription]];
            }
            else{
                if (linkResponse.siginType == CitrusSiginTypeLimited) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        //                        [self performSegueWithIdentifier:@"HomeScreenIdentifier" sender:self];
                    }];
                }
                else{
                    // [UIUtility toastMessageOnScreen:linkResponse.userMessage];
                    signInType = linkResponse.siginType;
                    responseMessage = linkResponse.userMessage;
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        //                    [self performSegueWithIdentifier:@"SignInScreenIdentifier" sender:self];
                        //                        [self getBalance:nil];
                    }];
                }
                
            }
        }];
    }];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark PGTransactionViewController delegate

- (void)didSucceedTransaction:(PGTransactionViewController *)controller
                     response:(NSDictionary *)response
{
    
    
    /***
     Paytm_Successfull Event Start
     ***/
    
    NSString * storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
    NSString *orderid = [NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"incrementid"] integerValue]];
    
    ;
    
    
    NSMutableDictionary *paytmSuccessDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                            storeIdStr, kStoreIdProperty,
                                            orderid, kOrderNoProperty,
                                            @"TXN_SUCCESS", kTxnStatus,
                                            [[userProfileData valueForKey:@"data"] valueForKey:@"email"], kEmailProperty,
                                            [[userProfileData valueForKey:@"data"] valueForKey:@"mobile"], kMobileProperty,
                                            nil];
    [SH_TrackingUtility trackEventOfSpencerEvents:paytmSuccessfullEvent eventProp:paytmSuccessDict];
    
    /***
     Paytm_Successfull Event End
     ***/
    
    
    DEBUGLOG(@"ViewController::didSucceedTransactionresponse= %@", response);
    NSString *title = [NSString stringWithFormat:@"Your order  was completed successfully. \n %@", response[@"ORDERID"]];
    
    Result * result=[[Result alloc]initWithNibName:@"Result" bundle:nil];
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"incrementid"] integerValue]] forKey:@"OrderIDToken"];
    result.paymentMethodStr = @"Paytm";
    [self.navigationController pushViewController:result animated:YES];
    
//    [[[UIAlertView alloc] initWithTitle:title message:[response description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
//    BOOL flag = NO;
//    for (UIViewController *controller in self.navigationController.viewControllers)
//    {
//        if ([controller isKindOfClass:[MainCategoryVC class]])
//        {
//            flag = YES;
//            [self.navigationController popToViewController:controller animated:YES];
//            break;
//        }
//    }
//    if (flag == NO)
//    {
//        MainCategoryVC *mainCategoryVC = [[MainCategoryVC alloc]initWithNibName:@"MainCategoryVC" bundle:nil];
//        [self.navigationController pushViewController:mainCategoryVC animated:YES];
//    }
//    
//    [self removeController:controller];
    
}

- (void)didFailTransaction:(PGTransactionViewController *)controller error:(NSError *)error response:(NSDictionary *)response
{
    
    
    /***
     Paytm_Failed Event Start
     ***/
    
    NSString * storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
    NSString *orderid = [NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"incrementid"] integerValue]];
    
    ;
    
    
    NSMutableDictionary *paytmSuccessDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                             [error localizedDescription], kTxnErrorMessgae,
                                             storeIdStr, kStoreIdProperty,
                                             orderid, kOrderNoProperty,
                                             @"TXN_FAILED", kTxnStatus,
                                             [[userProfileData valueForKey:@"data"] valueForKey:@"email"], kEmailProperty,
                                             [[userProfileData valueForKey:@"data"] valueForKey:@"mobile"], kMobileProperty,
                                             nil];
    [SH_TrackingUtility trackEventOfSpencerEvents:paytmSuccessfullEvent eventProp:paytmSuccessDict];
    
    /***
     Paytm_Failed Event End
     ***/
    
    
    DEBUGLOG(@"ViewController::didFailTransaction error = %@ response= %@", error, response);
    if (response)
    {
        [[[UIAlertView alloc] initWithTitle:error.localizedDescription message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else if (error)
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    BOOL flag = NO;
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[MainCategoryVC class]])
        {
            flag = YES;
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
    if (flag == NO)
    {
        MainCategoryVC *mainCategoryVC = [[MainCategoryVC alloc]initWithNibName:@"MainCategoryVC" bundle:nil];
        [self.navigationController pushViewController:mainCategoryVC animated:YES];
    }
//    [self removeController:controller];
}

- (void)didCancelTransaction:(PGTransactionViewController *)controller error:(NSError*)error response:(NSDictionary *)response
{
    
    
    
    
    DEBUGLOG(@"ViewController::didCancelTransaction error = %@ response= %@", error, response);
    NSString *msg = nil;
    if (!error) msg = [NSString stringWithFormat:@"Successful"];
    else msg = [NSString stringWithFormat:@"UnSuccessful"];
    
    [[[UIAlertView alloc] initWithTitle:@"Transaction Cancel" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
    BOOL flag = NO;
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[MainCategoryVC class]])
        {
            flag = YES;
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
    if (flag == NO)
    {
        MainCategoryVC *mainCategoryVC = [[MainCategoryVC alloc]initWithNibName:@"MainCategoryVC" bundle:nil];
        [self.navigationController pushViewController:mainCategoryVC animated:YES];
    }
    
    
    
    
    /***
     Transaction_Cancel Event Start
     ***/
    
    NSString * storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        NSString *orderid = [NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"incrementid"] integerValue]];
    
    
    NSMutableDictionary *paymentModeDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                            error.description, kTxnErrorMessgae,
                                            orderid, kOrderNoProperty,
                                            @"TXN_FAILED", kTxnStatus,
                                            storeIdStr, kStoreIdProperty,
                                            PaymentType_Str, kPaymentModeProperty,
                                            nil];
    [SH_TrackingUtility trackEventOfSpencerEvents:transactionCancelEvent eventProp:paymentModeDict];
    
    /***
     Transaction_Cancel Event End
     ***/
    
    
//    [self removeController:controller];
}

- (void)didFinishCASTransaction:(PGTransactionViewController *)controller response:(NSDictionary *)response
{
    DEBUGLOG(@"ViewController::didFinishCASTransaction:response = %@", response);
}


+(NSString*)generateOrderIDWithPrefix:(NSString *)prefix
{
    srand ( (unsigned)time(NULL) );
    int randomNo = rand(); //just randomizing the number
    NSString *orderID = [NSString stringWithFormat:@"%@%d", prefix, randomNo];
    return orderID;
}
-(void)showController:(PGTransactionViewController *)controller
{
    if (self.navigationController != nil)
        [self.navigationController pushViewController:controller animated:YES];
    else
        [self presentViewController:controller animated:YES
                         completion:^{
                             
                         }];
}

-(void)removeController:(PGTransactionViewController *)controller
{
    if (self.navigationController != nil)
        [self.navigationController popViewControllerAnimated:YES];
    else
        [controller dismissViewControllerAnimated:YES
                                       completion:^{
                                       }];
}



@end
