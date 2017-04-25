//
//  Result.m
//  MeraGrocer
//
//  Created by Binarysemantics  on 7/30/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import "Result.h"
#import "MainCategoryVC.h"
#import "CategoryPage.h"
#import "LoginVC.h"
#import "OfferVC.h"
#import "MyProfileVC.h"
#import "AppDelegate.h"

#import "ResultCell.h"
#import "UIImageView+WebCache.h"
#import "ProductVC.h"

#import "GAI.h"
#import "GAIFields.h"
#import "GAITracker.h"

#import "GAIEcommerceProduct.h"
#import "GAIDictionaryBuilder.h"
#import "GAIEcommerceFields.h"

#import "SH_TrackingUtility.h"


@interface Result ()
{
    LoginVC *loginpage;
    MyProfileVC *myProfile;
    AppDelegate *appDele;
    NSArray *inCartArr;
    ProductVC *productVC;
    NSDictionary *finalCartDict;
}
@end

@implementation Result
@synthesize paymentMethodStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"Result Screen";
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    screenX = [UIScreen mainScreen].bounds.origin.x;
    screenY =[UIScreen mainScreen].bounds.origin.y;
    appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    NSLog(@"%@", appDele.orderConfirmationDict);
    
    inCartArr = [appDele.orderConfirmationDict valueForKey:@"cartData"];
    
    //self.screenName = @"Result Screen";
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * orderIdStr =[temp objectForKey:@"OrderIDToken"];
    
    orderNoLbl.text = orderIdStr;
    deliveryAddressLbl.text = [NSString stringWithFormat:@"%@", [appDele.orderConfirmationDict valueForKey:@"deliveryAddress"]];
    deliveryScheduleLbl.text = [NSString stringWithFormat:@"%@", [appDele.orderConfirmationDict valueForKey:@"deliverySchedule"]];
    billingEmailLbl.text = [NSString stringWithFormat:@"%@", [appDele.orderConfirmationDict valueForKey:@"email"]];
    if ([[appDele.orderConfirmationDict valueForKey:@"paymentMethod"] isEqualToString:@"cashondelivery"])
    {
        paymentMethodLbl.text = [NSString stringWithFormat:@"%@", @"Cash On Delivery"];
    }
    else
    {
        paymentMethodLbl.text = [NSString stringWithFormat:@"%@", [appDele.orderConfirmationDict valueForKey:@"paymentMethod"]];
    }
    
    if (paymentMethodStr.length > 0)
    {
        paymentMethodLbl.text = paymentMethodStr;
    }
    
    
    
    Continue_obj.layer.cornerRadius = 20;
    Continue_obj.layer.masksToBounds = YES;
    Continue_obj.layer.borderColor = [UIColor whiteColor].CGColor;
    Continue_obj.layer.borderWidth = 1;
    Continue_obj.backgroundColor = kColor_Orange;
    
    
    /***
     Payment Mode Success Event Start
     ***/
    NSMutableDictionary *paymentSuccessDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                               orderIdStr, kOrderNoProperty,
                                               paymentMethodLbl.text, kPaymentModeProperty,
                                               deliveryScheduleLbl.text, kDeliveryScheduleProperty,
                                               deliveryAddressLbl.text, kDeliveryAddressProperty,
                                               nil];
    [SH_TrackingUtility trackEventOfSpencerEvents:paymentModeSuccessEvent eventProp:paymentSuccessDict];
    /***
     Payment Event Success Event End
     ***/
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 120;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return inCartArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResultCell *cell;
    if (cell == nil)
    {
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            [[NSBundle mainBundle] loadNibNamed:@"ResultCell" owner:self options:nil];
//        }
//        else
//        {
//            [[NSBundle mainBundle] loadNibNamed:@"ResultCell~iPad" owner:self options:nil];
//        }
        cell = resultCel;
    }
    
    UIImageView *seperatorImg = [[UIImageView alloc] initWithFrame:CGRectMake(screenX+10, 119, width-20, 1)];
    seperatorImg.backgroundColor = kColor_gray;
    [cell addSubview:seperatorImg];
    cell.backgroundColor=[UIColor whiteColor];
    [myOrderTblVew setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [ResultView setHidden:YES];
 
}

-(IBAction)backBtnAct:(UIButton *)sender
{
    
}

-(void)navigationView
{
    
    
    UIButton *backBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0f, -30.0f, 0.0f, 0.0f);
    UIImage *backBtnImage = [UIImage imageNamed:@"menu.png"];
    //    [backBtn setBackgroundColor:[UIColor redColor]];
//    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *menubutton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:menubutton , nil]];
    self.navigationItem.leftBarButtonItem = menubutton;
    
    UIButton *titleLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleLabelButton setTitle:@"Order Confirmation" forState:UIControlStateNormal];
    titleLabelButton.frame = CGRectMake(0, 0, 200, 44);
    titleLabelButton.titleLabel.numberOfLines=1;
    [titleLabelButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [titleLabelButton setTitleColor:[UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    titleLabelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    //    [titleLabelButton addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleLabelButton;
    
    NSMutableArray *arrRightBarItems = [[NSMutableArray alloc] init];
    
    
//    UIButton *btnLib = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnLib setImage:[UIImage imageNamed:@"ic_cart.png"] forState:UIControlStateNormal];
//    btnLib.frame = CGRectMake(0, 0, 32, 32);
//    ////btnLib.showsTouchWhenHighlighted=YES;
//    [btnLib addTarget:self action:@selector(inCartBtnAct:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *barButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:btnLib];
//    [arrRightBarItems addObject:barButtonItem2];
    
    //    UIButton *btnSetting = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [btnSetting setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
    //    btnSetting.frame = CGRectMake(0, 0, 32, 32);
    //    //btnSetting.showsTouchWhenHighlighted=YES;
    ////    [btnSetting addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSetting];
    //    [arrRightBarItems addObject:barButtonItem];
    
//    bangeLbl = [[UILabel alloc] initWithFrame:CGRectMake(20,-5 , 18, 18)];
//    bangeLbl.text = appDelegate.bangeStr;
//    bangeLbl.font = [UIFont fontWithName:@"Helvetica" size:11];
//    bangeLbl.backgroundColor = [UIColor clearColor];
//    bangeLbl.textColor = [UIColor whiteColor];
//    bangeLbl.textAlignment = NSTextAlignmentCenter;
//    bangeLbl.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:149.0/255.0 blue:59.0/255.0 alpha:1];
//    bangeLbl.layer.cornerRadius = 9;
//    bangeLbl.layer.masksToBounds = YES;
//    bangeLbl.layer.borderColor = [UIColor whiteColor].CGColor;
//    bangeLbl.layer.borderWidth = 1;
//    
//    [btnLib addSubview:bangeLbl];
//    
//    if ([bangeLbl.text integerValue] > 0)
//    {
//        bangeLbl.hidden = NO;
//    }
//    else
//    {
//        bangeLbl.hidden = YES;
//    }
    
    self.navigationItem.rightBarButtonItems=arrRightBarItems;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//    [ResultView setHidden:NO];
    
    [self navigationView];
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * orderIdStr =[temp objectForKey:@"OrderIDToken"];
    
    self.lbl3.font = [UIFont fontWithName:@"calibrib" size:15];
    
    self.lbl3.text = [NSString stringWithFormat:@"ORDER NO: %@", orderIdStr];
    
    
    finalCartDict = appDele.finalCartDict;
    
    NSString *kTrackingId = [[NSUserDefaults standardUserDefaults] valueForKey:@"kTrackingId"] ;
        
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:kTrackingId];
        
    GAIEcommerceProduct *product;
    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createEventWithCategory:@"Ecommerce"
                                                                               action:@"Purchase"
                                                                                label:nil
                                                                                value:nil];
        
    for (int i = 0; i < inCartArr.count; i++)
    {
        product = [[GAIEcommerceProduct alloc] init];
        [product setId:[[inCartArr objectAtIndex:i] valueForKey:@"sku"]];
        [product setName:[[inCartArr objectAtIndex:i] valueForKey:@"name"]];
        [product setCategory:[[[inCartArr objectAtIndex:i] valueForKey:@"category"] objectAtIndex:0]];
        [product setBrand:[[inCartArr objectAtIndex:i] valueForKey:@"brand"]];
            //                [product setVariant:[[inCartArr objectAtIndex:i] valueForKey:@"sku"]];
        [product setPrice:[[inCartArr objectAtIndex:i] valueForKey:@"price_incl_tax"]];
        
//        [product setCouponCode:@""];
        [product setQuantity:[[inCartArr objectAtIndex:i] valueForKey:@"qty"]];
//        if ( [[[finalCartDict valueForKey:@"discount"] valueForKey:@"title"] length] > 0)
//        {
//            [product setCouponCode:[[finalCartDict valueForKey:@"discount"] valueForKey:@"title"]];
//        }
        [builder addProduct:product];
    }
    
    [builder addProductImpression:product
                   impressionList:@"Products"
                 impressionSource:@"Products"];
        
    GAIEcommerceProductAction *action = [[GAIEcommerceProductAction alloc] init];
    [action setAction:kGAIPAPurchase];
    [action setTransactionId:orderNoLbl.text];
    [action setAffiliation:@"Spencer's App - Online"];
    [action setRevenue:[NSNumber numberWithFloat:[[[finalCartDict valueForKey:@"grand_total"] valueForKey:@"value"] floatValue]]];
    [action setTax:[NSNumber numberWithFloat:[[[finalCartDict valueForKey:@"tax"] valueForKey:@"value"] floatValue]]];
    [action setShipping:[NSNumber numberWithFloat:[[[finalCartDict valueForKey:@"shipping"] valueForKey:@"value"] floatValue]]];
    [action setCheckoutOption:paymentMethodLbl.text];
    
    if ( [[[finalCartDict valueForKey:@"discount"] valueForKey:@"title"] length] > 0)
    {
        [action setCouponCode:[[finalCartDict valueForKey:@"discount"] valueForKey:@"title"]];
    }
    
    
    
    [builder setProductAction:action];
        
        // Sets the product for the next available slot, starting with 1
        //            tracker.screenName = @"Order Confirmation";
        
    [tracker send:[builder build]];
    
    
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

- (IBAction)backToShoppingBtnAct:(UIButton *)sender {
    
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
@end
