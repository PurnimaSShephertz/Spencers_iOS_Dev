//
//  OrderReviewVC.m
//  Spencer
//
//  Created by Binary Semantics on 7/9/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "OrderReviewVC.h"
#import "Const.h"

#import "UIImageView+WebCache.h"
#import "Webmethods.h"

#import "SVProgressHUD.h"
#import "PaymentInfoVC.h"

#import "OfferVC.h"
#import "AppDelegate.h"
#import "ProductVC.h"
#import "SH_TrackingUtility.h"


@interface OrderReviewVC ()
{
    PaymentInfoVC *paymentInfoVC;
    NSDictionary *inCartDict;
    NSArray *inCartArr;
    
    AppDelegate *appDele;
    ProductVC *productVC;
}
@end

@implementation OrderReviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"Order Review Screen";
    
    appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
      ScreenWidth= [UIScreen mainScreen].bounds.size.width;
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    screenX = [UIScreen mainScreen].bounds.origin.x;
    screenY =[UIScreen mainScreen].bounds.origin.y;
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)backBtnAct:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ConfirmAll_Obj.layer.cornerRadius=23.0;
    ConfirmAll_Obj.layer.masksToBounds=YES;
    
    self.navigationController.navigationBar.hidden = NO;
    
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

    [self getCartData];
}
-(IBAction)Confirm_All_Act:(id)sender
{
 
    /***
        Order Review Event Start
     ***/
    NSMutableDictionary *orderReviewDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                            [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"], kStoreIdProperty,
                                            [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], kCartIdProperty
                                            , nil];
    [SH_TrackingUtility trackEventOfSpencerEvents:orderReviewEvent eventProp:orderReviewDict];
   
    /***
        Order Review Event End
     ***/
    
    
    paymentInfoVC = [[PaymentInfoVC alloc] initWithNibName:@"PaymentInfoVC" bundle:nil];
    paymentInfoVC.grandTotalStr = [NSString stringWithFormat:@"%@", [[inCartDict valueForKey:@"grand_total"] valueForKey:@"value"]];
    [self.navigationController pushViewController:paymentInfoVC animated:NO];
    
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
//    UIViewController *initViewController = [storyBoard instantiateInitialViewController];
    
    
//    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
//    [self.navigationController pushViewController:vc animated:YES];
    
//    PaymentInfoVC *paymentInfoVC = [[PaymentInfoVC alloc] initWithNibName:@"HomeViewController" bundle:nil];
//    [self.navigationController pushViewController:paymentInfoVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ProductDetailPage *productDetailPage= [[ProductDetailPage alloc] initWithNibName:@"ProductDetailPage" bundle:nil];
//    productDetailPage.entity_id = [[productArr objectAtIndex:indexPath.row] valueForKey:@"entity_id"];
//    [self.navigationController pushViewController:productDetailPage animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    OrderReviewCell *cell;
    if (cell == nil)
    {
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            [[NSBundle mainBundle] loadNibNamed:@"OrderReviewCell" owner:self options:nil];
//        }
//        else
//        {
//            [[NSBundle mainBundle] loadNibNamed:@"OrderReviewCell~iPad" owner:self options:nil];
//        }
        cell = orderReviewCell;
    }
    
    UIImageView *seperatorImg = [[UIImageView alloc] initWithFrame:CGRectMake(screenX+10, 119, width-20, 1)];
    seperatorImg.backgroundColor = kColor_gray;
    [cell addSubview:seperatorImg];
    cell.backgroundColor=[UIColor whiteColor];
    [orderReviewTblVew setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //[orderReviewTblVew setBackgroundColor:[UIColor clearColor]];
    
    NSString *trimmedString = [[[inCartArr  objectAtIndex:indexPath.row] valueForKey:@"name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    cell.name.text = trimmedString;
    [cell.productimg sd_setImageWithURL:[NSURL URLWithString:[[inCartArr objectAtIndex:indexPath.row] valueForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    //    cell.count.text = [NSString stringWithFormat:@"%@", [[inCartArr objectAtIndex:indexPath.row] valueForKey:@"qty"]];
    
    cell.count.text = [NSString stringWithFormat:@"%li", (long)[[[inCartArr objectAtIndex:indexPath.row] valueForKey:@"qty"] integerValue]];
    
    cell.count.tag = indexPath.row;
    
    if ([[[inCartArr objectAtIndex:indexPath.row] valueForKey:@"price_incl_tax"] isKindOfClass:[NSNull class]])
    {
        cell.mrp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[inCartArr objectAtIndex:indexPath.row] valueForKey:@"price_incl_tax"] floatValue]];
        cell.sp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[inCartArr objectAtIndex:indexPath.row] valueForKey:@"price_incl_tax"] floatValue]];
    }
    else
    {
        cell.mrp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[inCartArr objectAtIndex:indexPath.row] valueForKey:@"price_incl_tax"] floatValue]];
        cell.sp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[inCartArr objectAtIndex:indexPath.row] valueForKey:@"price_incl_tax"] floatValue]];
    }
    
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return inCartArr.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(void)getCartData
{
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    NSUserDefaults * temp=[NSUserDefaults standardUserDefaults];
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
                 
                 //                 [HUD hide:YES];
                 inCartDict = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                 appDele.finalCartDict = inCartDict;
                 inCartArr = [[NSMutableArray alloc ] initWithArray:[inCartDict valueForKey:@"data"]];
                 [orderReviewTblVew reloadData];
                 
                 NSMutableDictionary *orderConfirmationDict = [[NSMutableDictionary alloc] initWithDictionary:appDele.orderConfirmationDict];
                 [orderConfirmationDict setObject:inCartArr forKey:@"cartData"];
                 appDele.orderConfirmationDict = orderConfirmationDict;
                 
                 
                 
                _totalLbl.text= [NSString stringWithFormat:@"Rs.%@",[[inCartDict valueForKey:@"grand_total"] valueForKey:@"value"]];
//                 for (int i = 0; i < inCartArr.count; i++)
//                 {
//                     [cartItemCountDict setObject:[[inCartArr objectAtIndex:i] valueForKey:@"qty"] forKey:[[inCartArr objectAtIndex:i] valueForKey:@"item_id"]];
//                 }
                 //                 NSLog(@"cartItemCountDict %@", cartItemCountDict);
                 
//                 if ([[inCartDict valueForKey:@"status"] integerValue] == 1)
//                 {
//                     
//                     if ([[inCartDict valueForKey:@"coupon_applied"] integerValue] == 1)
//                     {
//                         coupanLbl.hidden = NO;
//                         Coupon_TXT.hidden = YES;
//                         self.applyBtnobj.hidden = YES;
//                         self.RemoveCouonObj.hidden = NO;
//                         coupanLbl.text = @"Coupon code applied";
//                         
//                     }
//                     else
//                     {
//                         coupanLbl.hidden = YES;
//                         Coupon_TXT.hidden = NO;
//                         self.applyBtnobj.hidden = NO;
//                         self.RemoveCouonObj.hidden = YES;
//                     }
//                     
//                     
//                     appDele.bangeStr = [NSString stringWithFormat:@"%li",[[inCartDict valueForKey:@"cart_count"] integerValue]];
//                     bangeLbl.text = appDele.bangeStr;
//                     
//                     if ([bangeLbl.text integerValue] > 0)
//                     {
//                         bangeLbl.hidden = NO;
//                     }
//                     else
//                     {
//                         bangeLbl.hidden = YES;
//                     }
//                     if ([[inCartDict valueForKey:@"message"] isEqualToString:@"empty cart"])
//                     {
//                         [[[UIAlertView alloc] initWithTitle:@"Message" message:[inCartDict valueForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
//                     }
//                     else
//                     {
//                         
//                     }
//                     [self cartTotal];
//                     [inCartTblVew reloadData];
//                     
//                     
//                 }
//                 else
//                 {
//                     appDele.bangeStr = [NSString stringWithFormat:@"%i",0];
//                     bangeLbl.text = appDele.bangeStr;
//                     //                     [inCartTblVew reloadData];
//                     if ([bangeLbl.text integerValue] > 0)
//                     {
//                         bangeLbl.hidden = NO;
//                     }
//                     else
//                     {
//                         bangeLbl.hidden = YES;
//                     }
//                     
//                     [self.view addSubview:[[ToastAlert alloc] initWithText:[inCartDict valueForKey:@"message"]]];
//                     
//                     [self performSelector:@selector(pop) withObject:nil afterDelay:2];
//                 }
             }
             else
             {
                 
             }
         }];
    }
    else
    {
        
        
        
        inCartDict=  [[NSMutableDictionary alloc] initWithDictionary:[Webmethods GetcartData_Login]];
        appDele.finalCartDict = inCartDict;
        inCartArr = [[NSMutableArray alloc ] initWithArray:[inCartDict valueForKey:@"data"]];
        
        NSMutableDictionary *orderConfirmationDict = [[NSMutableDictionary alloc] initWithDictionary:appDele.orderConfirmationDict];
        [orderConfirmationDict setObject:inCartArr forKey:@"cartData"];
        appDele.orderConfirmationDict = orderConfirmationDict;
        
        [orderReviewTblVew reloadData];
        if ([[inCartDict valueForKey:@"mincartamt"] integerValue] > 10)
        {
            [[NSUserDefaults standardUserDefaults] setObject:[inCartDict valueForKey:@"mincartamt"] forKey:@"mincartamt"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        _totalLbl.text= [NSString stringWithFormat:@"Rs.%@",[[inCartDict valueForKey:@"grand_total"] valueForKey:@"value"]];
//        [self cartTotal];
        //        [HUD hide:YES];
//        if ([[inCartDict valueForKey:@"status"] integerValue] == 1)
//        {
//            inCartArr = [[NSMutableArray alloc ] initWithArray:[inCartDict valueForKey:@"data"]];
//            //             placeOrderTblVew.tag = 4;
//            
//            [self cartTotal];
//            for (int i = 0; i < inCartArr.count; i++)
//            {
//                [cartItemCountDict setObject:[[inCartArr objectAtIndex:i] valueForKey:@"qty"] forKey:[[inCartArr objectAtIndex:i] valueForKey:@"item_id"]];
//            }
//            
//            
//            if ([[inCartDict valueForKey:@"status"] integerValue] == 1)
//            {
//                
//                
//                if ([[inCartDict valueForKey:@"coupon_applied"] integerValue] == 1)
//                {
//                    coupanLbl.hidden = NO;
//                    Coupon_TXT.hidden = YES;
//                    self.applyBtnobj.hidden = YES;
//                    self.RemoveCouonObj.hidden = NO;
//                    coupanLbl.text = @"Coupon code applied";
//                    
//                }
//                else
//                {
//                    coupanLbl.hidden = YES;
//                    Coupon_TXT.hidden = NO;
//                    self.applyBtnobj.hidden = NO;
//                    self.RemoveCouonObj.hidden = YES;
//                }
//                appDele.bangeStr = [NSString stringWithFormat:@"%li",[[inCartDict valueForKey:@"cart_count"] integerValue]];
//                bangeLbl.text = appDele.bangeStr;
//                
//                if ([bangeLbl.text integerValue] > 0)
//                {
//                    bangeLbl.hidden = NO;
//                }
//                else
//                {
//                    bangeLbl.hidden = YES;
//                }
//                
//                
//                
//                //appDelegate.wishlistBangeStr = [NSString stringWithFormat:@"%i",[[cartDict valueForKey:@"wishlist_count"] integerValue]];
//                //  wishlistBangeLbl.text = appDelegate.wishlistBangeStr;
//                
//                
//                if ([[inCartDict valueForKey:@"message"] isEqualToString:@"empty cart"])
//                {
//                    [[[UIAlertView alloc] initWithTitle:@"Message" message:[inCartDict valueForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
//                }
//                
//                
//                [inCartTblVew reloadData];
//                
//            }
//            else
//            {
//                
//            }
//            
//        }
//        else
//        {
//            
//            appDele.bangeStr = [NSString stringWithFormat:@"%@",@"0"];
//            inCartDict = [inCartDict valueForKey:@"data"];
//            bangeLbl.text = appDele.bangeStr;
//            if ([bangeLbl.text integerValue] > 0)
//            {
//                bangeLbl.hidden = NO;
//            }
//            else
//            {
//                bangeLbl.hidden = YES;
//            }
//            //            self.payableLbl.text = @"0.00";
//            //            Total_lbl.text = [NSString stringWithFormat:@"Total: Rs. %@", @"0.00"];
//            //            _totalAmountLbl.text = @"0.00";
//            
//            [inCartTblVew reloadData];
//            
//            [self.view addSubview:[[ToastAlert alloc] initWithText:[inCartDict valueForKey:@"message"]]];
//            
//            [self performSelector:@selector(pop) withObject:nil afterDelay:2];
//        }
    }
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
        {
            temp=[NSUserDefaults standardUserDefaults];
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



@end
