//
//  InCartVC.m
//  Spencer
//
//  Created by binary on 02/07/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "InCartVC.h"
#import "Const.h"
#import "UIImageView+WebCache.h"
#import "Webmethods.h"
#import "SearchVC.h"
#import "AppDelegate.h"
#import "MainCategoryVC.h"
#import "ProductVC.h"
#import "ManualLocationVC.h"
#import "MyProfileVC.h"
#import "CategoryPage.h"
#import "CheckOutPage.h"
#import "OfferVC.h"
#import "CouponPage.h"
#import "ProductVC.h"

#import "GAIEcommerceProduct.h"
#import "GAIDictionaryBuilder.h"


#import "SH_TrackingUtility.h"

@interface InCartVC ()
{
    SearchVC *searchVC;
    AppDelegate *appDele;
    ManualLocationVC *manualLocationVC;
    CategoryPage *Categoryvc;
    int count1;
    ProductVC *productVC;
}
@end

@implementation InCartVC

#pragma mark ViewLifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"In Cart Screen";
    
    [_applyBtnobj.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
//    [_applyBtnobj.layer setBorderWidth:4.0];
//    [_applyBtnobj.layer setBorderColor:[[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon-gri-black-dot.png"]] CGColor]];
    
    
    cartItemCountDict = [[NSMutableDictionary alloc] init];
    
    _RemoveCouonObj.hidden = YES;
    
    appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    bangeLbl.layer.cornerRadius = 9;
    bangeLbl.layer.masksToBounds = YES;
    bangeLbl.layer.borderColor = [UIColor whiteColor].CGColor;
    bangeLbl.layer.borderWidth = 1;
    
    storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    screenX = [UIScreen mainScreen].bounds.origin.x;
    screenY =[UIScreen mainScreen].bounds.origin.y;
    // Do any additional setup after loading the view from its nib.
    
    
    /***
        Cart Screen event satrt
     ***/
    
    NSMutableDictionary *cartProp = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], kCartIdProperty,
                                     storeIdStr, kStoreIdProperty,
                                     nil];
    [SH_TrackingUtility trackEventOfSpencerEvents:cartsScreenEvent eventProp:cartProp];
    
    /***
        Cart Screen event end
     ***/
    
}
-(IBAction)inCartBtnAct:(id)sender
{
    
}

-(void)navigationView
{
    UIButton *backBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"ic_left_arw.png"];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0f, -30.0f, 0.0f, 0.0f);
    //    [backBtn setBackgroundColor:[UIColor redColor]];
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *menubutton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:menubutton , nil]];
    self.navigationItem.leftBarButtonItem = menubutton;
    
    UIButton *titleLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [titleLabelButton setTitle:[[NSUserDefaults standardUserDefaults] valueForKey:@"userLocation"] forState:UIControlStateNormal];
    titleLabelButton.frame = CGRectMake(0, 0, 200, 44);
    titleLabelButton.titleLabel.numberOfLines=1;
    [titleLabelButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [titleLabelButton setTitleColor:[UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    titleLabelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    [titleLabelButton addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleLabelButton;
    
    NSMutableArray *arrRightBarItems = [[NSMutableArray alloc] init];
    
    
    UIButton *btnSetting = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIButton *btnLib = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLib setImage:[UIImage imageNamed:@"ic_cart.png"] forState:UIControlStateNormal];
    btnLib.frame = CGRectMake(0, 0, 32, 32);
    ////btnLib.showsTouchWhenHighlighted=YES;
    [btnLib addTarget:self action:@selector(inCartBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:btnLib];
    [arrRightBarItems addObject:barButtonItem2];
    
    
    [btnSetting setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
    btnSetting.frame = CGRectMake(0, 0, 32, 32);
    //btnSetting.showsTouchWhenHighlighted=YES;
    [btnSetting addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSetting];
    [arrRightBarItems addObject:barButtonItem];
    
    bangeLbl = [[UILabel alloc] initWithFrame:CGRectMake(20,-5 , 18, 18)];
    bangeLbl.text = appDele.bangeStr;
    bangeLbl.font = [UIFont fontWithName:@"Helvetica" size:11];
    bangeLbl.backgroundColor = [UIColor clearColor];
    bangeLbl.textColor = [UIColor whiteColor];
    bangeLbl.textAlignment = NSTextAlignmentCenter;
    bangeLbl.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:149.0/255.0 blue:59.0/255.0 alpha:1];
    bangeLbl.layer.cornerRadius = 9;
    bangeLbl.layer.masksToBounds = YES;
    bangeLbl.layer.borderColor = [UIColor whiteColor].CGColor;
    bangeLbl.layer.borderWidth = 1;
    if ([bangeLbl.text integerValue] > 0)
    {
        bangeLbl.hidden = NO;
    }
    else
    {
        bangeLbl.hidden = YES;
    }
    [btnLib addSubview:bangeLbl];
    
    self.navigationItem.rightBarButtonItems=arrRightBarItems;
    
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = kColor_Orange;
    bangeLbl.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    
    [self navigationView];
    
    [currentLocationBtnObj setTitle:[[NSUserDefaults standardUserDefaults] valueForKey:@"userLocation"] forState:UIControlStateNormal];
    
    [searchBar1 resignFirstResponder];
    [self getCartData];
    
    NSLog(@"in cart dict %@", inCartDict);
    
    
    
    
    
    
    
    
    
    
    
//    _applyBtnobj.layer.cornerRadius=17.0;
//    _applyBtnobj.layer.masksToBounds=YES;
    width=[UIScreen mainScreen].bounds.size.width;
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame: CGRectMake(0, 0, width, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:nil],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    Coupon_TXT.inputAccessoryView = numberToolbar;
    Coupon_TXT.delegate=self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark CartDetails

-(void) cartTotal
{
    
    int y = 5;
    
    if (inCartArr.count > 0)
    {
        for (id view in [priceView subviews])
        {
            [view removeFromSuperview];
        }
        
        UILabel *totalTitLbl = [[UILabel alloc] initWithFrame:CGRectMake(width/40, y, 180, 18)];
        
        totalTitLbl.text = @"Total";
        [priceView addSubview:totalTitLbl];
        
        UILabel *totalLbl = [[UILabel alloc] initWithFrame:CGRectMake(width-150, y, 110, 18)];
        totalLbl.textAlignment = NSTextAlignmentRight;
        totalLbl.text = [NSString stringWithFormat:@" Rs. %.2f", [[[inCartDict valueForKey:@"subtotal"] valueForKey:@"value"] floatValue]];
        [priceView addSubview:totalLbl];
        
        
        if ([[[inCartDict valueForKey:@"discount"] valueForKey:@"value"] integerValue] != 0)
        {
            y += 19;
        }
        UILabel *discountTitLbl1;
        UILabel *discountLbl1;
        if ([[[inCartDict valueForKey:@"discount"] valueForKey:@"value"] integerValue] != 0)
        {
            discountTitLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(width/40, y, 180, 18)];
            
            discountTitLbl1.text = [NSString stringWithFormat:@"%@", [[inCartDict valueForKey:@"discount"] valueForKey:@"title"]];
            discountTitLbl1.textColor = [UIColor orangeColor];
            [priceView addSubview:discountTitLbl1];
            
            discountLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(width-150, y, 110, 18)];
            discountLbl1.textAlignment = NSTextAlignmentRight;
            discountLbl1.text = [NSString stringWithFormat:@"Rs. %.2f", [[[inCartDict valueForKey:@"discount"] valueForKey:@"value"] floatValue]];
            discountLbl1.textColor = [UIColor orangeColor];
            [priceView addSubview:discountLbl1];
        }
        
        
        
        y += 19;
        UILabel *shippingTitLbl = [[UILabel alloc] initWithFrame:CGRectMake(width/40, y, 180, 18)];
        shippingTitLbl.text = @"Shipping";
        [priceView addSubview:shippingTitLbl];
        
        UILabel *shippingLbl = [[UILabel alloc] initWithFrame:CGRectMake(width-150, y, 110, 18)];
        shippingLbl.textAlignment = NSTextAlignmentRight;
        shippingLbl.text = @"Rs 0.00";
        [priceView addSubview:shippingLbl];
        
        
        
        
        if ([[[inCartDict valueForKey:@"customercredit"] valueForKey:@"value"] integerValue] != 0)
        {
            y += 19;
        }
        
        UILabel *walletTitLbl;
        UILabel *walletLbl;
        if ([[[inCartDict valueForKey:@"customercredit"] valueForKey:@"value"] integerValue] != 0)
        {
            walletTitLbl = [[UILabel alloc] initWithFrame:CGRectMake(width/40, y, 180, 18)];
            walletTitLbl.text = @"Wallet";
            [priceView addSubview:walletTitLbl];
            
            
            walletLbl = [[UILabel alloc] initWithFrame:CGRectMake(width-150, y, 110, 18)];
            walletLbl.textAlignment = NSTextAlignmentRight;
            walletLbl.text = [NSString stringWithFormat:@" Rs. %.2f", [[[inCartDict valueForKey:@"customercredit"] valueForKey:@"value"] floatValue]];
            [priceView addSubview:walletLbl];
        }
        
        y += 19;
        
        UILabel *payableTitLbl = [[UILabel alloc] initWithFrame:CGRectMake(width/40, y, 180, 18)];
        payableTitLbl.text = @"Payable";
        [priceView addSubview:payableTitLbl];
        
        
        UILabel *payableLbl = [[UILabel alloc] initWithFrame:CGRectMake(width-150, y, 110, 18)];
        payableLbl.textAlignment = NSTextAlignmentRight;
        payableLbl.text = [NSString stringWithFormat:@" Rs. %.2f", [[[inCartDict valueForKey:@"grand_total"] valueForKey:@"value"] floatValue]];
        [priceView addSubview:payableLbl];
        
        subTotalLbl.text = [NSString stringWithFormat:@" Rs. %.2f", [[[inCartDict valueForKey:@"grand_total"] valueForKey:@"value"] floatValue]];
        
//        if ([discountLbl1.text floatValue]> - 0.1)
//        {
//            discountLbl1.hidden = YES;
//            discountTitLbl1.hidden = YES;
//        }
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            totalTitLbl.font = [UIFont boldSystemFontOfSize:12];
            totalLbl.font = [UIFont boldSystemFontOfSize:12];
            shippingTitLbl.font = [UIFont boldSystemFontOfSize:12];
            shippingLbl.font = [UIFont boldSystemFontOfSize:12];
            discountTitLbl1.font = [UIFont boldSystemFontOfSize:12];
            discountLbl1.font = [UIFont boldSystemFontOfSize:12];
            walletTitLbl.font = [UIFont boldSystemFontOfSize:12];
            walletLbl.font = [UIFont boldSystemFontOfSize:12];
            payableTitLbl.font = [UIFont boldSystemFontOfSize:12];
            payableLbl.font = [UIFont boldSystemFontOfSize:12];
            
            totalTitLbl.textColor = [UIColor darkGrayColor];
            totalLbl.textColor = [UIColor darkGrayColor];
            shippingTitLbl.textColor = [UIColor darkGrayColor];
            shippingLbl.textColor = [UIColor darkGrayColor];
            discountTitLbl1.textColor = [UIColor orangeColor];
            discountLbl1.textColor = [UIColor orangeColor];
            walletTitLbl.textColor = [UIColor darkGrayColor];
            walletLbl.textColor = [UIColor darkGrayColor];
            payableTitLbl.textColor = [UIColor darkGrayColor];
            payableLbl.textColor = [UIColor darkGrayColor];
            
        }
        else
        {
            
            totalTitLbl.font = [UIFont boldSystemFontOfSize:16];
            totalLbl.font = [UIFont boldSystemFontOfSize:16];
            shippingTitLbl.font = [UIFont boldSystemFontOfSize:16];
            shippingLbl.font = [UIFont boldSystemFontOfSize:16];
            discountTitLbl1.font = [UIFont boldSystemFontOfSize:16];
            discountLbl1.font = [UIFont boldSystemFontOfSize:16];
            walletTitLbl.font = [UIFont boldSystemFontOfSize:16];
            walletLbl.font = [UIFont boldSystemFontOfSize:16];
            payableTitLbl.font = [UIFont boldSystemFontOfSize:16];
            payableLbl.font = [UIFont boldSystemFontOfSize:16];
            
            totalTitLbl.textColor = [UIColor darkGrayColor];
            totalLbl.textColor = [UIColor darkGrayColor];
            shippingTitLbl.textColor = [UIColor darkGrayColor];
            shippingLbl.textColor = [UIColor darkGrayColor];
            discountTitLbl1.textColor = [UIColor orangeColor];
            discountLbl1.textColor = [UIColor orangeColor];
            walletTitLbl.textColor = [UIColor darkGrayColor];
            walletLbl.textColor = [UIColor darkGrayColor];
            payableTitLbl.textColor = [UIColor darkGrayColor];
            payableLbl.textColor = [UIColor darkGrayColor];
            
        }

    }
    
}


-(void)getCartDataCheckOut
{
    
    NSLog(@"in cart dict %@", inCartDict);
    
    
    
    
    
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token_str =[temp objectForKey:@"oauth_token"];
    if(oauth_token_str==NULL || [oauth_token_str isEqual:@""])
    {
        
        storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        
        //        [NSThread detachNewThreadSelector:@selector(threadStartAnimating33:) toTarget:self withObject:nil];
        [SVProgressHUD show];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/cart?store=%@&cartid=%@", baseUrl1, storeIdStr, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]] ];
        
        //        [NSString stringWithFormat:@"%@&cartid=%@", urlEncoded , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]]
        
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 [SVProgressHUD dismiss];
                 //                 [HUD hide:YES];
                 inCartDict = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                 inCartArr = [[NSMutableArray alloc ] initWithArray:[inCartDict valueForKey:@"data"]];
                 
                 
                 BOOL inCartFlag = NO;
                 for (int i = 0; i < inCartArr.count; i++)
                 {
                     NSDictionary *inCartDict1 = [inCartArr objectAtIndex:i];
                     if ([[inCartDict1 valueForKey:@"has_error"] integerValue] != 0)
                     {
                         inCartFlag = YES;
                         [self.view addSubview:[[ToastAlert alloc] initWithText:@"Some products are not available"]];
                         break ;
                     }
                 }
                 
                 if (inCartFlag == NO)
                 {
                     /***
                        Place_Order Event Start
                      ***/
                     NSString *couponCode = [[[[inCartDict valueForKey:@"discount"] valueForKey:@"title"] componentsSeparatedByString:@" "] objectAtIndex:1];
                     
                     couponCode = [couponCode stringByReplacingOccurrencesOfString:@"(" withString:@"'"];
                     couponCode = [couponCode stringByReplacingOccurrencesOfString:@")" withString:@"'"];
  
                     
                     NSString *minimumCartAmount = [NSString stringWithFormat:@"%@", [inCartDict valueForKey:@"mincartamt"]];
                     NSString *subTotal = [NSString stringWithFormat:@"%@", [[inCartDict valueForKey:@"subtotal"] valueForKey:@"value"]];
                     NSString *grandTotal = [NSString stringWithFormat:@" Rs. %.2f", [[[inCartDict valueForKey:@"grand_total"] valueForKey:@"value"] floatValue]];
                     
                     NSMutableDictionary *orderPlaceDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                            [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], kCartIdProperty,
                                                            storeIdStr, kStoreIdProperty,
                                                            couponCode, kCouponCodeProperty,
                                                            minimumCartAmount, kMinimumCartAmountProperty,
                                                            subTotal, ksubTotalProperty,
                                                            couponCode, kDiscountProperty,
                                                            grandTotal, kGrandTotalProperty,
                                                            nil];
                     [SH_TrackingUtility trackEventOfSpencerEvents:placeOrderEvent eventProp:orderPlaceDict];
                     /***
                        Place_Order Event End
                      ***/
                     
                     
                     CheckOutPage * checkoutpage ;
//                     if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//                     {
                         checkoutpage=[[CheckOutPage alloc]initWithNibName:@"CheckOutPage" bundle:nil];
//                     }
//                     else
//                     {
//                         checkoutpage=[[CheckOutPage alloc]initWithNibName:@"CheckOutPage~iPad" bundle:nil];
//                     }
                     [self.navigationController pushViewController:checkoutpage animated:NO];
                 }
                 
             }
             else
             {
                 
             }
         }];
    }
    else
    {
        inCartDict=  [[NSMutableDictionary alloc] initWithDictionary:[Webmethods GetcartData_Login]];
        inCartArr = [[NSMutableArray alloc ] initWithArray:[inCartDict valueForKey:@"data"]];
        
        
        
        BOOL inCartFlag = NO;
        for (int i = 0; i < inCartArr.count; i++)
        {
            NSDictionary *inCartDict1 = [inCartArr objectAtIndex:i];
            if ([[inCartDict1 valueForKey:@"has_error"] integerValue] != 0)
            {
                inCartFlag = YES;
                [self.view addSubview:[[ToastAlert alloc] initWithText:@"Some products are not available"]];
                break ;
            }
        }
        
        if (inCartFlag == NO)
        {
            CheckOutPage * checkoutpage ;
//            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//            {
                checkoutpage=[[CheckOutPage alloc]initWithNibName:@"CheckOutPage" bundle:nil];
//            }
//            else
//            {
//                checkoutpage=[[CheckOutPage alloc]initWithNibName:@"CheckOutPage~iPad" bundle:nil];
//            }
            [self.navigationController pushViewController:checkoutpage animated:NO];
        }
        
        
        
        
    }
}


-(void)getCartData
{
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token_str =[temp objectForKey:@"oauth_token"];
    if(oauth_token_str==NULL || [oauth_token_str isEqual:@""])
    {
        
        storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        
//        [NSThread detachNewThreadSelector:@selector(threadStartAnimating33:) toTarget:self withObject:nil];
        [SVProgressHUD show];
        
        
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/cart?store=%@&cartid=%@", baseUrl1, storeIdStr, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]] ];
        
        //        [NSString stringWithFormat:@"%@&cartid=%@", urlEncoded , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]]
        
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 [SVProgressHUD dismiss];
//                 [HUD hide:YES];
                 inCartDict = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                 inCartArr = [[NSMutableArray alloc ] initWithArray:[inCartDict valueForKey:@"data"]];
                 
                 myCartCountLbl.text = [NSString stringWithFormat:@"MY CART (%lu)", (unsigned long)[inCartArr count]];
                 
                 for (int i = 0; i < inCartArr.count; i++)
                 {
                     [cartItemCountDict setObject:[[inCartArr objectAtIndex:i] valueForKey:@"qty"] forKey:[[inCartArr objectAtIndex:i] valueForKey:@"item_id"]];
                 }
                 if ([[inCartDict valueForKey:@"status"] integerValue] == 1)
                 {
                     if ([[inCartDict valueForKey:@"coupon_applied"] integerValue] == 1)
                     {
                         coupanLbl.hidden = NO;
                         Coupon_TXT.hidden = YES;
                         self.applyBtnobj.hidden = YES;
                         self.RemoveCouonObj.hidden = NO;
                         
                         NSString *coupon = [[[[inCartDict valueForKey:@"discount"] valueForKey:@"title"] componentsSeparatedByString:@" "] objectAtIndex:1];
                         
                         coupon = [coupon stringByReplacingOccurrencesOfString:@"(" withString:@"'"];
                         coupon = [coupon stringByReplacingOccurrencesOfString:@")" withString:@"'"];
                         
                         coupanLbl.text = [NSString stringWithFormat:@"Coupon code '%@' applied.", coupon];
                         
                     }
                     else
                     {
                         coupanLbl.hidden = YES;
                         Coupon_TXT.hidden = NO;
                         self.applyBtnobj.hidden = NO;
                         self.RemoveCouonObj.hidden = YES;
                     }
                     appDele.bangeStr = [NSString stringWithFormat:@"%li",[[inCartDict valueForKey:@"cart_count"] integerValue]];
                     bangeLbl.text = appDele.bangeStr;
                     
                     if ([bangeLbl.text integerValue] > 0)
                     {
                         bangeLbl.hidden = NO;
                     }
                     else
                     {
                         bangeLbl.hidden = YES;
                     }
                     if ([[inCartDict valueForKey:@"message"] isEqualToString:@"empty cart"])
                     {
                         [[[UIAlertView alloc] initWithTitle:@"Message" message:[inCartDict valueForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
                     }
                     else
                     {
                         
                     }
                     [self cartTotal];
                     [inCartTblVew reloadData];
                     
                     
                 }
                 else
                 {
                     appDele.bangeStr = [NSString stringWithFormat:@"%i",0];
                     bangeLbl.text = appDele.bangeStr;
                     if ([bangeLbl.text integerValue] > 0)
                     {
                         bangeLbl.hidden = NO;
                     }
                     else
                     {
                         bangeLbl.hidden = YES;
                     }
                     
//                     [self.view addSubview:[[ToastAlert alloc] initWithText:[inCartDict valueForKey:@"message"]]];
                     
                     [self performSelector:@selector(pop) withObject:nil afterDelay:2];
                 }
             }
             else
             {
                 [SVProgressHUD dismiss];
             }
         }];
    }
    else
    {
        inCartDict=  [[NSMutableDictionary alloc] initWithDictionary:[Webmethods GetcartData_Login]];
        
        if ([[inCartDict valueForKey:@"mincartamt"] integerValue] > 10)
        {
            [[NSUserDefaults standardUserDefaults] setObject:[inCartDict valueForKey:@"mincartamt"] forKey:@"mincartamt"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [self cartTotal];
        if ([[inCartDict valueForKey:@"status"] integerValue] == 1)
        {
            inCartArr = [[NSMutableArray alloc ] initWithArray:[inCartDict valueForKey:@"data"]];
            myCartCountLbl.text = [NSString stringWithFormat:@"MY CART (%lu)", (unsigned long)[inCartArr count]];
            [self cartTotal];
            for (int i = 0; i < inCartArr.count; i++)
            {
                [cartItemCountDict setObject:[[inCartArr objectAtIndex:i] valueForKey:@"qty"] forKey:[[inCartArr objectAtIndex:i] valueForKey:@"item_id"]];
            }
            
            
            if ([[inCartDict valueForKey:@"status"] integerValue] == 1)
            {
                bottomView.hidden = NO;
                if ([[inCartDict valueForKey:@"coupon_applied"] integerValue] == 1)
                {
                    coupanLbl.hidden = NO;
                    Coupon_TXT.hidden = YES;
                    self.applyBtnobj.hidden = YES;
                    self.RemoveCouonObj.hidden = NO;
//                    coupanLbl.text = @"Coupon code applied";
                    
//                    coupanLbl.text = [NSString stringWithFormat:@"Coupon code applied %@", [[[[inCartDict valueForKey:@"discount"] valueForKey:@"title"] componentsSeparatedByString:@" "] objectAtIndex:1]];
                    
                    
                    NSString *coupon = [[[[inCartDict valueForKey:@"discount"] valueForKey:@"title"] componentsSeparatedByString:@" "] objectAtIndex:1];
                    
                    coupon = [coupon stringByReplacingOccurrencesOfString:@"(" withString:@"'"];
                    coupon = [coupon stringByReplacingOccurrencesOfString:@")" withString:@"'"];
                    
                    coupanLbl.text = [NSString stringWithFormat:@"Coupon code '%@' applied.", coupon];
                    
                }
                else
                {
                    coupanLbl.hidden = YES;
                    Coupon_TXT.hidden = NO;
                    self.applyBtnobj.hidden = NO;
                    self.RemoveCouonObj.hidden = YES;
                }
                
                appDele.bangeStr = [NSString stringWithFormat:@"%li",[[inCartDict valueForKey:@"cart_count"] integerValue]];
                bangeLbl.text = appDele.bangeStr;
                
                if ([bangeLbl.text integerValue] > 0)
                {
                    bangeLbl.hidden = NO;
                }
                else
                {
                    bangeLbl.hidden = YES;
                }
                
                
                if ([[inCartDict valueForKey:@"message"] isEqualToString:@"empty cart"])
                {
                    [[[UIAlertView alloc] initWithTitle:@"Message" message:[inCartDict valueForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
                }
                
                
                [inCartTblVew reloadData];
                
            }
            else
            {
                
            }
            
        }
        else
        {
            
            appDele.bangeStr = [NSString stringWithFormat:@"%@",@"0"];
            inCartDict = [inCartDict valueForKey:@"data"];
            bangeLbl.text = appDele.bangeStr;
            if ([bangeLbl.text integerValue] > 0)
            {
                bangeLbl.hidden = NO;
            }
            else
            {
                bangeLbl.hidden = YES;
            }
//            self.payableLbl.text = @"0.00";
//            Total_lbl.text = [NSString stringWithFormat:@"Total: Rs. %@", @"0.00"];
//            _totalAmountLbl.text = @"0.00";
            
            [inCartTblVew reloadData];
            
//            [self.view addSubview:[[ToastAlert alloc] initWithText:[inCartDict valueForKey:@"message"]]];
            
//            [self performSelector:@selector(pop) withObject:nil afterDelay:2];
        }
    }
}




#pragma mark UITableView Delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    InCartCell *cell;
    if (cell == nil)
    {
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            [[NSBundle mainBundle] loadNibNamed:@"InCartCell" owner:self options:nil];
//        }
//        else
//        {
//            [[NSBundle mainBundle] loadNibNamed:@"InCartCell~iPad" owner:self options:nil];
//        }
        cell = inCartCell;
    }
    
    UIImageView *seperatorImg = [[UIImageView alloc] initWithFrame:CGRectMake(screenX+10, 119, width-20, 1)];
    seperatorImg.backgroundColor = kColor_gray;
    [cell addSubview:seperatorImg];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([[[inCartArr objectAtIndex:indexPath.row] valueForKey:@"has_error"] integerValue] == 1)
    {
        cell.statusLbl.text = @"Out of stock";
    }
    
    cell.deleteBtnObj.tag = indexPath.row;
    
    NSString *trimmedString = [[[inCartArr  objectAtIndex:indexPath.row] valueForKey:@"name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    cell.name.text = trimmedString;
    [cell.img sd_setImageWithURL:[NSURL URLWithString:[[inCartArr objectAtIndex:indexPath.row] valueForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
//    cell.count.text = [NSString stringWithFormat:@"%@", [[inCartArr objectAtIndex:indexPath.row] valueForKey:@"qty"]];
    
    cell.count.text = [NSString stringWithFormat:@"%li", (long)[[cartItemCountDict valueForKey:[[inCartArr objectAtIndex:indexPath.row] valueForKey:@"item_id"]] integerValue]];
    
    cell.plusObj.tag = indexPath.row;
    cell.minusObj.tag = indexPath.row;
    cell.modifyBtnObj.tag = indexPath.row;
    cell.count.tag = indexPath.row;
    cell.mrpCrossLbl.hidden = YES;
    
    if ([[[inCartArr objectAtIndex:indexPath.row] valueForKey:@"price_incl_tax"] isKindOfClass:[NSNull class]])
    {
//        cell.mrp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[inCartArr objectAtIndex:indexPath.row] valueForKey:@"price_incl_tax"] floatValue]];
        cell.sp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[inCartArr objectAtIndex:indexPath.row] valueForKey:@"price_incl_tax"] floatValue]];
    }
    else
    {
//        cell.mrp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[inCartArr objectAtIndex:indexPath.row] valueForKey:@"price_incl_tax"] floatValue]];
        cell.sp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[inCartArr objectAtIndex:indexPath.row] valueForKey:@"price_incl_tax"] floatValue]];
    }
    
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [inCartArr count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (inCartArr.count > 0)
    {
        return 10;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}

#pragma mark ButtonAction

- (IBAction)minusAct:(UIButton *)sender
{
    InCartCell *selectedCell = (InCartCell *)[inCartTblVew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    count1 = (int)[selectedCell.count.text integerValue];
    
    if (count1 == 1)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure you want to delete?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        alertView.tag = sender.tag;
        [alertView show];
        return ;
    }
    else if (count1 == 0)
    {
        return ;
    }
        
    if (count1 > 0)
    {
        count1 --;
    }
    
    
    selectedCell.count.text = [NSString stringWithFormat:@"%i",count1];
    
    
    if (count1 == 0)
    {
        [selectedCell.modifyBtnObj setHidden:YES];
    }
    else{
        [selectedCell.modifyBtnObj setHidden:NO];
    }
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    
    
    if (count1 == 0)
    {
        [SVProgressHUD show];
        storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
//        [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
        NSString *URL=[NSString stringWithFormat:@"%@/cart/delete/?itemid=%@&store=%@&cartid=%@", baseUrl1, [[inCartArr objectAtIndex:sender.tag] valueForKey:@"item_id"], storeIdStr, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
        temp=[NSUserDefaults standardUserDefaults];
        oauth_token =[temp objectForKey:@"oauth_token"];
        
        if(oauth_token==NULL || [oauth_token isEqual:@""])
        {
            NSURL *url = [NSURL URLWithString:URL];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response,
                                                       NSData *data, NSError *connectionError)
             {
                 if (data.length > 0 && connectionError == nil)
                 {
                     
                     NSMutableDictionary *tempDict;
                     tempDict = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                     
                     if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                     {
                         appDele.bangeStr = [NSString stringWithFormat:@"%ld", (long)[[tempDict valueForKey:@"cart_count"] integerValue]];
                         bangeLbl.text = appDele.bangeStr;
                         [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                         //                     [HUD hide:YES];
                         
                         [self getCartData];
                         //                     [placeOrderTblVew reloadData];
                         
                         if ([bangeLbl.text integerValue] > 0)
                         {
                             bangeLbl.hidden = NO;
                         }
                         else
                         {
                             bangeLbl.hidden = YES;
                         }
                         
                         if ([appDele.bangeStr isEqualToString:@"0"])
                         {
                             [self performSelector:@selector(popVC) withObject:nil afterDelay:1];
                         }
                         
                         [SVProgressHUD dismiss];

                     }
                     
                 }
                 else
                 {
                     [SVProgressHUD dismiss];
                 }
             }];
        }
        else
        {
            
            [SVProgressHUD show];
            NSDictionary *tempDict = [Webmethods DeleteItemFromCart:URL];
            //NSLog(@"tempDict %@", tempDict);
            
            if ([[tempDict valueForKey:@"status"] integerValue] == 1)
            {
                appDele.bangeStr = [NSString stringWithFormat:@"%ld", (long)[[tempDict valueForKey:@"cart_count"] integerValue]];
                bangeLbl.text = appDele.bangeStr;
                
                [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                
                //            [HUD hide:YES];
                
                [self getCartData];
                //            [placeOrderTblVew reloadData];
                
                if ([bangeLbl.text integerValue] > 0)
                {
                    bangeLbl.hidden = NO;
                }
                else
                {
                    bangeLbl.hidden = YES;
                }
                
                
                if ([appDele.bangeStr isEqualToString:@"0"])
                {
                    [self performSelector:@selector(popVC) withObject:nil afterDelay:1];
                }
                
                [SVProgressHUD dismiss];

            }
            else
            {
                [SVProgressHUD dismiss];
            }
        }
    }
    else
    {
        [self modifyBtnAct:sender];
    }
}

- (IBAction)plusAct:(UIButton *)sender
{
    
    
    
    InCartCell *selectedCell = (InCartCell *)[inCartTblVew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    
    count1 = (int)[selectedCell.count.text integerValue];
    
    if (count1 == 0)
    {
        return ;
    }
    
    count1 ++;
    
    
    [self modifyBtnAct:sender];

    //    [selectedCell.modifyBtnObj setHidden:NO];
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
                Categoryvc=[[CategoryPage alloc]initWithNibName:@"CategoryPage" bundle:nil];
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
            temp=[NSUserDefaults standardUserDefaults];
            oauth_token =[temp objectForKey:@"oauth_token"];
            if(oauth_token==NULL || [oauth_token isEqual:@""])
            {
                
                LoginVC* loginpage;
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
                
                MyProfileVC *myProfile;
                
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

            break;
            
            
        default:
            break;
    }
}


-(void)popVC
{
//    [self.view addSubview:[[ToastAlert alloc] initWithText:@"Cart empty"]];
    [self performSelector:@selector(popVC1) withObject:nil afterDelay:1];
}

-(void) popVC1
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
    //[self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)backBtnAct:(UIButton *)sender
{
    if ([_loginNav isEqualToString:@"10"])
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
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)pop
{
    
//    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)menuBtnAct:(UIButton *)sender {
    
        
    /***
     Proceed-to-Checkout Event Start
     ***/
    
    NSString *cartId = [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"];
    NSString *couponCode = [NSString stringWithFormat:@"%@", Coupon_TXT.text];
    NSString *minimumCartAmount = [NSString stringWithFormat:@"%@", [inCartDict valueForKey:@"mincartamt"]];
    NSString *subTotal = [[inCartDict valueForKey:@"subtotal"] valueForKey:@"value"];
    NSString *discount = [[inCartDict valueForKey:@"discount"] valueForKey:@"value"];
    NSString *grandTotal = [NSString stringWithFormat:@" Rs. %.2f", [[[inCartDict valueForKey:@"grand_total"] valueForKey:@"value"] floatValue]];
    
//    NSString *orderid = [NSString stringWithFormat:@"%li", (long)[[Data valueForKey:@"incrementid"] integerValue]];
    
    
    NSMutableDictionary *proceedToCheckOutDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                            cartId, kCartIdProperty,
                                            storeIdStr, kStoreIdProperty,
                                            couponCode, kCouponCodeProperty,
                                            minimumCartAmount, kMinimumCartAmountProperty,
                                            subTotal, ksubTotalProperty,
                                            discount, kDiscountProperty,
                                            grandTotal, kGrandTotalProperty,
                                            nil];
    
    [SH_TrackingUtility trackEventOfSpencerEvents:proceedToCheckOutEvent eventProp:proceedToCheckOutDict];
    
    /***
     Proceed-to-Checkout Event End
     ***/
    
    
    temp=[NSUserDefaults standardUserDefaults];
    oauth_token =[temp objectForKey:@"oauth_token"];
    if (sender == _backBtnObj)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    else if (sender == _placeToOrderObj)
    {
        
//        if (inCartArr.count > 0)
//        {
//            NSString *kTrackingId = [[NSUserDefaults standardUserDefaults] valueForKey:@"kTrackingId"] ;
//            
//            id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:kTrackingId];
//            
//            GAIEcommerceProduct *product;
//            GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createEventWithCategory:@"cart"
//                                                                                   action:@"Purchase"
//                                                                                    label:nil
//                                                                                    value:nil];
//            
//            for (int i = 0; i < inCartArr.count; i++)
//            {
//                product = [[GAIEcommerceProduct alloc] init];
//                [product setId:[[inCartArr objectAtIndex:i] valueForKey:@"sku"]];
//                [product setName:[[inCartArr objectAtIndex:i] valueForKey:@"name"]];
//                [product setCategory:[[[inCartArr objectAtIndex:i] valueForKey:@"category"] objectAtIndex:0]];
//                [product setBrand:[[inCartArr objectAtIndex:i] valueForKey:@"brand"]];
////                [product setVariant:[[inCartArr objectAtIndex:i] valueForKey:@"sku"]];
//                [product setPrice:[[inCartArr objectAtIndex:i] valueForKey:@"price_incl_tax"]];
//                [product setCouponCode:@""];
//                [product setQuantity:[[inCartArr objectAtIndex:i] valueForKey:@"qty"]];
//                
//                [builder addProduct:product];
//            }
//            
//            
//            GAIEcommerceProductAction *action = [[GAIEcommerceProductAction alloc] init];
//            [action setAction:[[inCartArr objectAtIndex:0] valueForKey:@"sku"]];
//            [action setTransactionId:[[inCartArr objectAtIndex:0] valueForKey:@"sku"]];
//            [action setAffiliation:@"Spencer's App - Online"];
//            [action setRevenue:[[inCartDict valueForKey:@"subtotal"] valueForKey:@"value"]];
//            [action setTax:[[inCartDict valueForKey:@"tax"] valueForKey:@"value"]];
//            [action setShipping:[[inCartDict valueForKey:@"shipping"] valueForKey:@"value"]];
//            [action setCouponCode:@""];
//            [builder setProductAction:action];
//            
//            // Sets the product for the next available slot, starting with 1
////            tracker.screenName = @"Order Confirmation";
//            
//            [tracker send:[builder build]];
//        }
        
        
        
        
        
        
        
        
        
        
        [_placeToOrderObj setEnabled:NO];
        
        [Coupon_TXT resignFirstResponder];
        if (inCartArr.count < 1) {
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Cart is empty"]];
            return ;
        }
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Billingaddress"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Billingaddress_ID"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shippingaddress"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shippingaddress_ID"];
        
        
        if(oauth_token==NULL || [oauth_token isEqual:@""])
        {
            [_placeToOrderObj setEnabled:YES];
            LoginVC* loginpage;
//            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//            {
                loginpage = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
//            }
//            else
//            {
//                loginpage = [[LoginVC alloc]initWithNibName:@"LoginVC~iPad" bundle:nil];
//            }
            
            
            loginpage.checkLoginFromCheckout=@"0011";
            [self.navigationController pushViewController:loginpage animated:NO];
            
        }
        else{
            //            NSString *cost = _payableLbl.text;
            
             [_placeToOrderObj setEnabled:YES];
            if ([[inCartDict valueForKey:@"minsubtotal"] integerValue] > 0)
            {
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%li", [[inCartDict valueForKey:@"minsubtotal"] integerValue]] forKey:@"minamount"];
            }
            //            if ([[[cartDict valueForKey:@"subtotal"] valueForKey:@"value"] integerValue] >= [[cartDict valueForKey:@"mincartamt"] integerValue])
            if ([[[inCartDict valueForKey:@"subtotal"] valueForKey:@"value"] integerValue] >= [[[NSUserDefaults standardUserDefaults] valueForKey:@"minamount"] integerValue])
            {
                
                
                [self getCartDataCheckOut];
                
            }
            else
                [self.view addSubview:[[ToastAlert alloc] initWithText:[NSString stringWithFormat:@"Minimum order value should be more than %@", [[NSUserDefaults standardUserDefaults] valueForKey:@"minamount"]]]];
            
        }
    }
    else if (sender == _applyBtnobj)
    {
        
//        CouponPage* coupon=[[CouponPage alloc]initWithNibName:@"CouponPage" bundle:nil];
//        [self.navigationController pushViewController:coupon animated:YES];
        [Coupon_TXT resignFirstResponder];
        if (Coupon_TXT.text.length < 1)
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter coupon code"]];
            return ;
        }
        
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        
        //        if ([Coupon_TXT.text containsString:@" "])
        //        {
        //            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Space not allowed in coupon code"]];
        //            return ;
        //        }
        NSString *couponStr = [Coupon_TXT.text stringByReplacingOccurrencesOfString:@" "
                                                                         withString:@"%20"];
        
        storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        NSString * URL=[NSString stringWithFormat:@"%@/cart/coupon?couponcode=%@&store=%@&cartid=%@", baseUrl1,couponStr, storeIdStr, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
        
        if(oauth_token==NULL || [oauth_token isEqual:@""])
        {
            NSURL *url = [NSURL URLWithString:URL];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response,
                                                       NSData *data, NSError *connectionError)
             {
                 if (data.length > 0 && connectionError == nil)
                 {
                     
                     
                     NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                     
                     NSString * status=[dict valueForKey:@"status"];
                     
                     
                     if ([status integerValue]==0)
                     {
                         
                         [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"applyremove"];
                         [self.view addSubview:[[ToastAlert alloc] initWithText:[dict valueForKey:@"message"]]];
                         [_RemoveCouonObj setHidden:YES];
                         [_applyBtnobj setHidden:NO];
                         
                     }
                     else
                     {
                         [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"applyremove"];
                         [self.view addSubview:[[ToastAlert alloc] initWithText:[dict valueForKey:@"message"]]];
                         [_RemoveCouonObj setHidden:NO];
                         [_applyBtnobj setHidden:YES];
                         
                         applyBool = YES;
                         [self getCartData];
                         inCartDict = [dict objectForKey:@"data"];
                         
                         coupanLbl.hidden = NO;
                         Coupon_TXT.hidden = YES;
                         self.applyBtnobj.hidden = YES;
                         self.RemoveCouonObj.hidden = NO;
                         coupanLbl.text = @"Coupon code applied";
                         
                         
                         
                     }
                     
                 }
                 else{
                     
                 }
             }];
        }
        else
        {
            
            
            
            //                    [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
            CouPonResponse_Dict=   [Webmethods AddCoupon:URL];
            NSString * status=[CouPonResponse_Dict valueForKey:@"status"];
            
            if ([status integerValue]==0)
            {
                [self.view addSubview:[[ToastAlert alloc] initWithText:[CouPonResponse_Dict valueForKey:@"message"]]];
                [_RemoveCouonObj setHidden:YES];
                [_applyBtnobj setHidden:NO];
                
                //                         [NSThread detachNewThreadSelector:@selector(threadStartAnimating23:) toTarget:self withObject:nil];
                [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"applyremove"];
            }
            else
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"applyremove"];
                [self.view addSubview:[[ToastAlert alloc] initWithText:[CouPonResponse_Dict valueForKey:@"message"]]];
                [_RemoveCouonObj setHidden:NO];
                [_applyBtnobj setHidden:YES];
                coupanLbl.hidden = NO;
                Coupon_TXT.hidden = YES;
                coupanLbl.text = @"Coupon code applied";
                applyBool = YES;
                [self getCartData];
                inCartDict = [CouPonResponse_Dict objectForKey:@"data"];
                
                
                
            }
            
            
        }
        Coupon_TXT.text=@"";
        
        
        
        
    }
    
    else if (sender==  _RemoveCouonObj)
    {
        
        
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        
        
        storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        NSString * URL=[NSString stringWithFormat:@"%@/cart/coupon?task=remove&store=%@&cartid=%@", baseUrl1, storeIdStr, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
        
        if(oauth_token==NULL || [oauth_token isEqual:@""])
        {
            NSURL *url = [NSURL URLWithString:URL];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response,
                                                       NSData *data, NSError *connectionError)
             {
                 if (data.length > 0 && connectionError == nil)
                 {
                     
                     NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                     //                     dict=   [Webmethods AddCoupon:URL];
                     NSString * status=[dict valueForKey:@"status"];
                     
                     if ([status integerValue]==0)
                     {
                         [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"applyremove"];
                         [self.view addSubview:[[ToastAlert alloc] initWithText:[dict valueForKey:@"message"]]];
                     }
                     else
                     {
                         [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"applyremove"];
                         [self.view addSubview:[[ToastAlert alloc] initWithText:[dict valueForKey:@"message"]]];
                         [self getCartData];
                         coupanLbl.hidden = YES;
                         Coupon_TXT.hidden = NO;
                         self.applyBtnobj.hidden = NO;
                         self.RemoveCouonObj.hidden = YES;
                     }
                     
                 }
                 else
                 {
                     
                 }
             }];
        }
        else
        {
            
            //            [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
            
            
            CouPonResponse_Dict=   [Webmethods RemoveCoupon_Login];
            
            NSString * status=[CouPonResponse_Dict valueForKey:@"status"];
            
            if ([status integerValue]==0)
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"applyremove"];
                [self.view addSubview:[[ToastAlert alloc] initWithText:[CouPonResponse_Dict valueForKey:@"message"]]];
                //[self getcartdata];
                
            }
            else
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"applyremove"];
                [self.view addSubview:[[ToastAlert alloc] initWithText:[CouPonResponse_Dict valueForKey:@"message"]]];
                [self getCartData];
                coupanLbl.hidden = YES;
                
                Coupon_TXT.hidden = NO;
                self.applyBtnobj.hidden = NO;
                self.RemoveCouonObj.hidden = YES;
                
            }
            
        }
        
        
    }
    
    else if (sender == _continueShopingBtnObj)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

#pragma mark SearchBar

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchVC = [[SearchVC alloc] initWithNibName:@"SearchVC" bundle:nil];
    [self.navigationController pushViewController:searchVC animated:NO];
    [searchBar resignFirstResponder];
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}


#pragma mark KeyBoard
- (void)keyboardWillShow:(NSNotification *)note
{
    
    CGRect keyboardBounds = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:0.3 animations:^{
        bottomView.transform = CGAffineTransformMakeTranslation(0, -keyboardBounds.size.height+95);
        
    }];
    
    self.isKeyboradShow = YES;
}



- (void)keyboardWillHide:(NSNotification *)note
{
    self.isKeyboradShow = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        bottomView.transform = CGAffineTransformIdentity;
        
    }];
}
-(void)doneWithNumberPad{
    
    [Coupon_TXT resignFirstResponder];
    
}

- (IBAction)currentLocationBtnAct:(UIButton *)sender
{
    manualLocationVC = [[ManualLocationVC alloc] initWithNibName:@"ManualLocationVC" bundle:nil];
    manualLocationVC.headercheck=@"1001";
    [self.navigationController pushViewController:manualLocationVC animated:YES];
}



- (IBAction)modifyBtnAct:(UIButton *)sender
{
    
    oauth_token =[temp objectForKey:@"oauth_token"];
    
    InCartCell *selectedCell = (InCartCell *)[inCartTblVew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    [selectedCell.modifyBtnObj setEnabled:NO];
    
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    
    //    NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlStr , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
    
//    [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
    
    storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
    NSString *URL=[NSString stringWithFormat:@"%@/cart/update/?cart[%@]=%i&store=%@&cartid=%@", baseUrl1, [[inCartArr objectAtIndex:sender.tag] valueForKey:@"item_id"], count1, storeIdStr, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
    

    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        [SVProgressHUD show];
        
        NSURL *url = [NSURL URLWithString:URL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 
//                 if ([selectedCell.count.text intValue] == 0)
//                 {
//                     [inCartArr removeObjectAtIndex:selectedCell.placeOrderDelete.tag];
//                 }
                 
                 
//                 [HUD hide:YES];
                 NSMutableDictionary *tempDict;
                 tempDict = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                 
                 [SVProgressHUD dismiss];
                 
                 if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                 {
                     selectedCell.count.text = [NSString stringWithFormat:@"%i",count1];
                     
                     appDele.bangeStr = [NSString stringWithFormat:@"%ld", (long)[[tempDict valueForKey:@"cart_count"] integerValue]];
                     bangeLbl.text = appDele.bangeStr;
                     inCartDict = [tempDict valueForKey:@"data"];
                     [cartItemCountDict setObject:selectedCell.count.text forKey:[[inCartArr objectAtIndex:sender.tag] valueForKey:@"item_id"]];
                     
                     [self cartTotal];
                     
                     if ([bangeLbl.text integerValue] > 0)
                     {
                         bangeLbl.hidden = NO;
                     }
                     else
                     {
                         bangeLbl.hidden = YES;
                     }
                     [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                     [selectedCell.modifyBtnObj setEnabled:YES];
                     [inCartTblVew reloadData];
                 }
                 else
                 {
                     [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                 }
                 
                 
//                 Total_lbl.text = [NSString stringWithFormat:@"Total: Rs. %.2f", [[[tempDict valueForKey:@"grand_total"] valueForKey:@"value"] floatValue]];
                 
                 //                [self getcartdata];
                 
                 
                 
                 
                 
             }
             else
             {
                 [SVProgressHUD dismiss];
                 [selectedCell.modifyBtnObj setEnabled:YES];
             }
         }];
    }
    else
    {
        
        [SVProgressHUD show];
        NSDictionary *tempDict = [Webmethods updateItemFromCart:URL];
//        [HUD hide:YES];
        
        
        
        
        
//        if ([selectedCell.count.text intValue] == 0)
//        {
//            [inCartArr removeObjectAtIndex:selectedCell.placeOrderDelete.tag];
//        }
        
        
//        Total_lbl.text = [NSString stringWithFormat:@"Total: Rs. %.2f", [[[tempDict valueForKey:@"grand_total"] valueForKey:@"value"] floatValue]];
        
        
        if ([[tempDict valueForKey:@"status"] integerValue] == 1)
        {
            selectedCell.count.text = [NSString stringWithFormat:@"%i",count1];
            
            [cartItemCountDict setObject:selectedCell.count.text forKey:[[inCartArr objectAtIndex:sender.tag] valueForKey:@"item_id"]];
            
            
            appDele.bangeStr = [NSString stringWithFormat:@"%ld", (long)[[tempDict valueForKey:@"cart_count"] integerValue]];
            bangeLbl.text = appDele.bangeStr;
            inCartDict = [tempDict valueForKey:@"data"];
            [self cartTotal];
        }
        else
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
        }
        
        if ([bangeLbl.text integerValue] > 0)
        {
            bangeLbl.hidden = NO;
        }
        else
        {
            bangeLbl.hidden = YES;
        }
        
        //        [self getcartdata];
        [SVProgressHUD dismiss];
        [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
        [selectedCell.modifyBtnObj setEnabled:YES];
        [inCartTblVew reloadData];
    }
}

- (IBAction)addMoreProductInCartBtnAct:(UIButton *)sender
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
        MainCategoryVC *mainCategoryVC=[[MainCategoryVC alloc]initWithNibName:@"MainCategoryVC" bundle:nil];
        [self.navigationController pushViewController:mainCategoryVC animated:YES];
    }
}

- (IBAction)deleteBtnObj:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure you want to delete ?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alert.tag = 10;
    [alert show];
    deleteIndex = (int)sender.tag;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10)
    {
        if (buttonIndex == 1)
        {
            InCartCell *selectedCell = (InCartCell *)[inCartTblVew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:alertView.tag inSection:0]];
            //selectedCell.plusObj.userInteractionEnabled = NO;
            //selectedCell.minusObj.userInteractionEnabled = NO;
            storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
            [SVProgressHUD show];
            NSString *URL=[NSString stringWithFormat:@"%@/cart/delete/?itemid=%@&store=%@&cartid=%@", baseUrl1, [[inCartArr objectAtIndex:deleteIndex] valueForKey:@"item_id"], storeIdStr, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
            temp=[NSUserDefaults standardUserDefaults];
            oauth_token =[temp objectForKey:@"oauth_token"];
            
            if(oauth_token==NULL || [oauth_token isEqual:@""])
            {
                NSURL *url = [NSURL URLWithString:URL];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                [NSURLConnection sendAsynchronousRequest:request
                                                   queue:[NSOperationQueue mainQueue]
                                       completionHandler:^(NSURLResponse *response,
                                                           NSData *data, NSError *connectionError)
                 {
                     if (data.length > 0 && connectionError == nil)
                     {
                         NSMutableDictionary *tempDict;
                         tempDict = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                         [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                         [SVProgressHUD dismiss];
                         [self getCartData];
                         
                         
                         if ([[tempDict valueForKey:@"cart_count"] integerValue] == 0)
                         {
                             [self performSelector:@selector(popVC) withObject:nil afterDelay:2];
                         }
                         
                         
                     }
                 }];
            }
            else
            {
                NSDictionary *tempDict = [Webmethods DeleteItemFromCart:URL];
                [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                [SVProgressHUD dismiss];
                [self getCartData];
                
                if ([[tempDict valueForKey:@"cart_count"] integerValue] == 0)
                {
                    [self performSelector:@selector(popVC) withObject:nil afterDelay:2];
                }
            }

        }
        
    }
    else
    {
        InCartCell *selectedCell = (InCartCell *)[inCartTblVew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:alertView.tag inSection:0]];
        
        if (buttonIndex == 1)
        {
            if (count1 > 0)
            {
                count1 --;
                selectedCell.count.hidden = YES;
            }
            
            
            selectedCell.count.text = [NSString stringWithFormat:@"%i",count1];
            
            
            if (count1 == 0)
            {
                [selectedCell.modifyBtnObj setHidden:YES];
            }
            else{
                [selectedCell.modifyBtnObj setHidden:NO];
            }
            
            BOOL reach = [Webmethods checkNetwork];
            if (reach == NO) {
                return ;
            }
            
            
            
            if (count1 == 0)
            {
                [SVProgressHUD show];
                //        [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
                storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
                NSString *URL=[NSString stringWithFormat:@"%@/cart/delete/?itemid=%@&store=%@&cartid=%@", baseUrl1, [[inCartArr objectAtIndex:alertView.tag] valueForKey:@"item_id"], storeIdStr, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
                temp=[NSUserDefaults standardUserDefaults];
                oauth_token =[temp objectForKey:@"oauth_token"];
                
                if(oauth_token==NULL || [oauth_token isEqual:@""])
                {
                    NSURL *url = [NSURL URLWithString:URL];
                    NSURLRequest *request = [NSURLRequest requestWithURL:url];
                    [NSURLConnection sendAsynchronousRequest:request
                                                       queue:[NSOperationQueue mainQueue]
                                           completionHandler:^(NSURLResponse *response,
                                                               NSData *data, NSError *connectionError)
                     {
                         if (data.length > 0 && connectionError == nil)
                         {
                             
                             NSMutableDictionary *tempDict;
                             tempDict = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                             
                             if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                             {
                                 appDele.bangeStr = [NSString stringWithFormat:@"%ld", (long)[[tempDict valueForKey:@"cart_count"] integerValue]];
                                 bangeLbl.text = appDele.bangeStr;
                                 if ([appDele.bangeStr intValue] > 0)
                                 {
                                     [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                                     [self getCartData];
                                 }
                                 else
                                 {
                                     [self.view addSubview:[[ToastAlert alloc] initWithText:@"Your cart is empty"]];
                                 }
                                 //                     [HUD hide:YES];
                                 
                                 
                                 //                     [placeOrderTblVew reloadData];
                                 
                                 if ([bangeLbl.text integerValue] > 0)
                                 {
                                     bangeLbl.hidden = NO;
                                 }
                                 else
                                 {
                                     bangeLbl.hidden = YES;
                                 }
                                 
                                 if ([appDele.bangeStr isEqualToString:@"0"])
                                 {
                                     [self performSelector:@selector(popVC) withObject:nil afterDelay:.5];
                                 }
                                 
                                 [SVProgressHUD dismiss];
                                 
                             }
                             
                         }
                         else
                         {
                             [SVProgressHUD dismiss];
                         }
                     }];
                }
                else
                {
                    
                    [SVProgressHUD show];
                    NSDictionary *tempDict = [Webmethods DeleteItemFromCart:URL];
                    //NSLog(@"tempDict %@", tempDict);
                    
                    if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                    {
                        appDele.bangeStr = [NSString stringWithFormat:@"%ld", (long)[[tempDict valueForKey:@"cart_count"] integerValue]];
                        bangeLbl.text = appDele.bangeStr;
                        
                        if ([appDele.bangeStr intValue] > 0)
                        {
                            [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                            [self getCartData];
                        }
                        else
                        {
                            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Your cart is empty"]];
                        }
                        
                        
                        //            [HUD hide:YES];
                        
                        
                        //            [placeOrderTblVew reloadData];
                        
                        if ([bangeLbl.text integerValue] > 0)
                        {
                            bangeLbl.hidden = NO;
                        }
                        else
                        {
                            bangeLbl.hidden = YES;
                        }
                        
                        
                        if ([appDele.bangeStr isEqualToString:@"0"])
                        {
                            [self performSelector:@selector(popVC) withObject:nil afterDelay:1];
                        }
                        
                        [SVProgressHUD dismiss];
                        
                    }
                    else
                    {
                        [SVProgressHUD dismiss];
                    }
                }
            }
            else
            {
                //            [self modifyBtnAct:se];
            }
            
        }

    }
}
@end
