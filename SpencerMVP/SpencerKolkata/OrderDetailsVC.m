//
//  OrderDetailsVC.m
//  MeraGrocer
//
//  Created by Binarysemantics  on 6/25/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import "OrderDetailsVC.h"
#import "AppDelegate.h"
#import "Webmethods.h"
#import "InCartVC.h"
#import "Const.h"

@interface OrderDetailsVC ()
{
    AppDelegate *appDelegate;
    UILabel *bangeLbl;
    InCartVC *inCartVC;
}
@end

@implementation OrderDetailsVC

@synthesize orderDateLbl, orderDateTitLbl, orderDetailsTblVew, orderNumberLbl, orderNumberTitLbl, customerNameLbl, customerNameTitLbl, statusLbl, statusTitLbl, shippingAddressTitLbl, shippingAddressTxtVew, shippingMethodLbl, shippingMethodTitLbl, itemsOrderedLbl, billingAddressTxtVew, billingAddresTitLbl, paymentMethodLbl, paymentMethodTitLbl;

@synthesize orderArr, orderkeyStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenName = @"Order Details Screen";
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    //NSLog(@"orderDict %@", orderArr);
    //self.screenName = @"Order Details Screen";
    
    orderDetailsTblVew.sectionFooterHeight = 0.0;
    
    _reorderBtnObj.layer.cornerRadius = 5;
    _reorderBtnObj.layer.masksToBounds = YES;
    _reorderBtnObj.backgroundColor = kColor_Orange;
    
    editOrderBtnObj.layer.cornerRadius = 5;
    editOrderBtnObj.layer.masksToBounds = YES;
    editOrderBtnObj.backgroundColor = kColor_Orange;
}

- (IBAction)backBtnAct:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)inCartBtnAct:(UIButton *)sender {
    sender.userInteractionEnabled = NO;
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    if ([bangeLbl.text integerValue] == 0)
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Your Cart is Empty"]];
    }
    else
    {
        inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
        [self.navigationController pushViewController:inCartVC animated:YES];
    }
}

-(void)navigationView
{
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
    
    
    [titleLabelButton setTitle:@"My Order" forState:UIControlStateNormal];
    titleLabelButton.frame = CGRectMake(0, 0, 200, 44);
    titleLabelButton.titleLabel.numberOfLines=1;
    [titleLabelButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [titleLabelButton setTitleColor:[UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    titleLabelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    //    [titleLabelButton addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleLabelButton;
    
    NSMutableArray *arrRightBarItems = [[NSMutableArray alloc] init];
    
    
    //    UIButton *btnSetting = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIButton *btnLib = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLib setImage:[UIImage imageNamed:@"ic_cart.png"] forState:UIControlStateNormal];
    btnLib.frame = CGRectMake(0, 0, 32, 32);
    //btnLib.showsTouchWhenHighlighted=YES;
    [btnLib addTarget:self action:@selector(inCartBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:btnLib];
    [arrRightBarItems addObject:barButtonItem2];
    
    
    //    [btnSetting setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
    //    btnSetting.frame = CGRectMake(0, 0, 32, 32);
    //    //btnSetting.showsTouchWhenHighlighted=YES;
    //    [btnSetting addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSetting];
    //    [arrRightBarItems addObject:barButtonItem];
    
    bangeLbl = [[UILabel alloc] initWithFrame:CGRectMake(20,-5 , 18, 18)];
    bangeLbl.text = appDelegate.bangeStr;
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
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self navigationView];
    
    self.navigationController.navigationBar.barTintColor = kColor_Orange;
    
    self.navigationController.navigationBar.hidden = NO;
    
    NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"];
    totalAmountLbl.text = [NSString stringWithFormat:@"Rs. %.1f", [[orderArr valueForKey:@"subtotal_incl_tax"] floatValue]];
    
    float discountValue = [[orderArr valueForKey:@"discount_amount"] floatValue];
    if (discountValue > 0)
    {
        
    }
    else if (discountValue < 0)
    {
        discountValue = (0 - discountValue);
    }
    
    
    if ([[orderArr valueForKey:@"discount_amount"] floatValue] == 0)
    {
        DiscountLbl.hidden = YES;
    }
    else
    {
        DiscountLbl.text = [NSString stringWithFormat:@"Discount Rs. %.1f", discountValue];
    }
    
    _mobileNoLbl.text = [NSString stringWithFormat:@"#  %@", [[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"telephone"]];
    orderNumberLbl.text = [NSString stringWithFormat:@"#  %@", [orderArr valueForKey:@"increment_id"]];
    customerNameLbl.text = [NSString stringWithFormat:@"#  %@", [[userDict valueForKey:@"data"] valueForKey:@"email"]];
    statusLbl.text = [NSString stringWithFormat:@"#  %@", [orderArr valueForKey:@"status"]];
    orderDateLbl.text = [NSString stringWithFormat:@"#  %@", [[[orderArr valueForKey:@"created_at"] componentsSeparatedByString:@" "] objectAtIndex:0]];
    deliveryDateLbl.text = [NSString stringWithFormat:@"#  %@", [orderArr valueForKey:@"delivery_date"] ];
    deliveryTimeLbl.text = [NSString stringWithFormat:@"#  %@", [orderArr valueForKey:@"delivery_time"] ];
    
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    if ([[orderArr valueForKey:@"can_edit"] integerValue] == 1)
    {
        editOrderBtnObj.hidden = NO;
    }
    else
    {
        editOrderBtnObj.hidden = YES;
        _reorderBtnObj.frame = CGRectMake(self.view.frame.size.width/2 - _reorderBtnObj.frame.size.width/2, _reorderBtnObj.frame.origin.y, _reorderBtnObj.frame.size.width, _reorderBtnObj.frame.size.height);
        
//        _reorderBtnObj.center = CGPointMake(screenWidth/2, _reorderBtnObj.frame.origin.y);
    }
    NSString *firstname, *lastname, *street, *city, *region, *telephone;
    firstname = [[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"firstname"];
    lastname = [[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"lastname"];
    street = [[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"street"];
    city = [[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"city"];
    region = [[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"region"];
    telephone = [[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"telephone"];
    
    if ([firstname isKindOfClass:[NSNull class]])
    {
        firstname = @"";
    }
    if ([lastname isKindOfClass:[NSNull class]])
    {
        lastname = @"";
    }
    if ([street isKindOfClass:[NSNull class]])
    {
        street = @"";
    }
    if ([city isKindOfClass:[NSNull class]])
    {
        city = @"";
    }
    if ([region isKindOfClass:[NSNull class]])
    {
        region = @"";
    }
    if ([telephone isKindOfClass:[NSNull class]])
    {
        telephone = @"";
    }
    
    
    if ([[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"firstname"]) {
        
    }
    shippingAddressTxtVew.text = [NSString stringWithFormat:@"%@ %@ \n%@ \n%@ \n%@ \nMobile No:- %@ ", firstname, lastname, street, city, region, telephone];
    
    
    billingAddressTxtVew.text = [NSString stringWithFormat:@"%@ %@ \n%@ \n%@ \n%@ \nMobile No:- %@ ", firstname, lastname, street, city, region, telephone];
    
    //shippingMethodLbl.text = [orderArr  valueForKey:@"shipping_description"];
    if ([[orderArr  valueForKey:@"payment_method"] isEqualToString:@"cashondelivery"])
    {
        paymentMethodLbl.text = [NSString stringWithFormat:@"%@", @"Cash on delivery"];
    }
   else if ([[orderArr  valueForKey:@"payment_method"] isEqualToString:@"customercredit"])
    {
        paymentMethodLbl.text = [NSString stringWithFormat:@"%@", @"Customer Credit"];
    }
    else
    {
        paymentMethodLbl.text = [NSString stringWithFormat:@"%@", [orderArr  valueForKey:@"payment_method"]];
    }

//    paymentMethodLbl.text = [orderArr  valueForKey:@"payment_method"];
    
    
    billingStr = [[NSString alloc] init];
    shippingStr = [[NSString alloc] init];
    
    
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
//        orderNumberLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
//        orderNumberTitLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
//        customerNameLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
//        customerNameTitLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
//        statusLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
//        statusTitLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
//        orderDateLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
//        orderDateTitLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
//        shippingAddressTxtVew.font = [UIFont fontWithName:@"Helvetica" size:12];
//        billingAddressTxtVew.font = [UIFont fontWithName:@"Helvetica" size:12];
//        shippingAddressTitLbl.font = [UIFont fontWithName:@"Helvetica" size:15];
//        billingAddresTitLbl.font = [UIFont fontWithName:@"Helvetica" size:15];
    }
    else
    {
//        orderNumberLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
//        orderNumberTitLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
//        customerNameLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
//        customerNameTitLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
//        statusLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
//        statusTitLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
//        orderDateLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
//        orderDateTitLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
//        shippingAddressTxtVew.font = [UIFont fontWithName:@"Helvetica" size:16];
//        billingAddressTxtVew.font = [UIFont fontWithName:@"Helvetica" size:16];
//        shippingAddressTitLbl.font = [UIFont fontWithName:@"Helvetica" size:19];
//        billingAddresTitLbl.font = [UIFont fontWithName:@"Helvetica" size:19];
    }
    
    
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"firstname"] ==NULL  || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"firstname"] isEqual:@""]  || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"firstname"] isKindOfClass:[NSNull class]] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"firstname"] isEqualToString:@"<null>"])
    {
        
        
    }
    else
    {
        billingStr=[NSString stringWithFormat:@"%@",[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"firstname"]];
        
    }
    if ([[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"lastname"] ==NULL  || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"lastname"] isEqual:@""] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"lastname"] isKindOfClass:[NSNull class]] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"lastname"] isEqualToString:@"<null>"])
    {
        
    }
    else
    {
        billingStr=[billingStr stringByAppendingFormat:@" %@",[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"lastname"]];
    }
    if ([[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"street"] ==NULL  || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"street"] isEqual:@""] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"street"] isKindOfClass:[NSNull class]] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"street"] isEqualToString:@"<null>"])
    {
        
    }
    else
    {
        billingStr=[billingStr stringByAppendingFormat:@",  \r%@",[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"street"]];
    }
    
    if ([[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"city"] ==NULL  || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"city"] isEqual:@""] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"city"] isKindOfClass:[NSNull class]] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"city"] isEqualToString:@"<null>"])
    {
        
    }
    else
    {
        billingStr=[billingStr stringByAppendingFormat:@",  \r%@",[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"city"]];
    }
    if ([[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"region"] ==NULL  || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"region"] isEqual:@""] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"region"] isKindOfClass:[NSNull class]] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"region"] isEqualToString:@"<null>"])
    {
        
    }
    else
    {
        billingStr=[billingStr stringByAppendingFormat:@",  \r%@",[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"region"]];
    }
    if ([[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"telephone"] ==NULL  || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"telephone"] isEqual:@""] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"telephone"] isKindOfClass:[NSNull class]] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"telephone"] isEqualToString:@"<null>"])
    {
        
    }
    else
    {
        billingStr=[billingStr stringByAppendingFormat:@",  \r%@",[[[orderArr valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"telephone"]];
    }
    
    
    if ([[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"firstname"] ==NULL  || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"firstname"] isEqual:@""] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"firstname"] isKindOfClass:[NSNull class]] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"firstname"] isEqualToString:@"<null>"])
    {
        
        
    }
    else
    {
        shippingStr=[NSString stringWithFormat:@"%@",[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"firstname"]];
        
    }
    if ([[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"lastname"] ==NULL  || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"lastname"] isEqual:@""] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"lastname"] isKindOfClass:[NSNull class]] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"lastname"] isEqualToString:@"<null>"])
    {
        
    }
    else
    {
        shippingStr=[shippingStr stringByAppendingFormat:@" %@",[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"lastname"]];
    }
    if ([[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"street"] ==NULL  || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"street"] isEqual:@""]  || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"street"] isKindOfClass:[NSNull class]] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"street"] isEqualToString:@"<null>"])
    {
        
    }
    else
    {
        shippingStr=[shippingStr stringByAppendingFormat:@",  \r%@",[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"street"]];
        
    }
    if ([[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"city"] ==NULL  || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"city"] isEqual:@""]  || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"city"] isKindOfClass:[NSNull class]] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"city"] isEqualToString:@"<null>"])
    {
        
    }
    else
    {
        shippingStr =[shippingStr stringByAppendingFormat:@",  \r%@",[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"city"]];
    }
    if ([[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"region"] ==NULL  || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"region"] isEqual:@""] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"region"] isKindOfClass:[NSNull class]] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"region"] isEqualToString:@"<null>"])
    {
        
    }
    else
    {
        shippingStr=[shippingStr stringByAppendingFormat:@",  \r%@",[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"region"]];
    }
    if ([[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"telephone"] ==NULL  || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"telephone"] isEqual:@""] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"telephone"] isKindOfClass:[NSNull class]] || [[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"telephone"] isEqualToString:@"<null>"])
    {
        
    }
    else
    {
        shippingStr=[shippingStr stringByAppendingFormat:@",  \r%@",[[[orderArr valueForKey:@"addresses"] objectAtIndex:1] valueForKey:@"telephone"]];
    }
    
    billingAddressTxtVew.text = billingStr;
    shippingAddressTxtVew.text = shippingStr;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *orderArray = [orderArr valueForKey:@"order_items"];
    return [orderArray count];
//    return [[orderArr valueForKey:@"order_items"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderDetailsCell *cell;
    if (cell == nil)
    {
        
        
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            [[NSBundle mainBundle] loadNibNamed:@"OrderDetailsCell" owner:self options:nil];
//        }
//        else
//        {
//            [[NSBundle mainBundle] loadNibNamed:@"OrderDetailsCell~iPad" owner:self options:nil];
//        }
        
        cell = _orderDetailsCell;
    }
    
    cell.nameLbl.numberOfLines = 4;
    
    cell.nameLbl.text = [[[orderArr valueForKey:@"order_items"] objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    cell.priceLbl.textAlignment = NSTextAlignmentRight;
    
    cell.priceLbl.text = [NSString stringWithFormat:@"Rs.  %.2f", [[[[orderArr valueForKey:@"order_items"] objectAtIndex:indexPath.row] valueForKey:@"price_incl_tax"] floatValue]];
    cell.quantityLbl.text = [NSString stringWithFormat:@"%.0f items", [[[[orderArr valueForKey:@"order_items"] objectAtIndex:indexPath.row] valueForKey:@"qty_ordered"] floatValue]];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        cell.nameLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
        cell.priceLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
        cell.quantityLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
    }
    else
    {
        cell.nameLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
        cell.priceLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
        cell.quantityLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
    }
    
    return cell;
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0;
}

- (IBAction)menuBtnAct:(UIButton *)sender {
    if (sender == _menuBtnObj)
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
    else if (sender == _logoLargeBtn)
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

- (IBAction)reorderBtnAct:(UIButton *)sender {
//    [HUD show:YES];
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
    NSDictionary *dict = [Webmethods reorderOrder:[orderArr valueForKey:@"entity_id"]];
    //NSLog(@"dict %@", dict);
    if ([[dict valueForKey:@"status"] integerValue] == 1)
    {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:[dict valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles: @"Ok", nil];
        alertView.tag = 20;
        [alertView show];
        
//        [self.view addSubview:[[ToastAlert alloc] initWithText:[dict valueForKey:@"message"]]];
//        [self performSelector:@selector(popVC) withObject:nil afterDelay:2];
    }
    else
    {
//        [self.view addSubview:[[ToastAlert alloc] initWithText:[dict valueForKey:@"message"]]];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:[dict valueForKey:@"message"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//        alertView.tag = 20;
        [alertView show];
    }
    
    [SVProgressHUD dismiss];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10)
    {
        if (buttonIndex == 1)
        {
            BOOL reach = [Webmethods checkNetwork];
            if (reach == NO) {
                return ;
            }
            
            [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
            NSDictionary *dict = [Webmethods editOrder:[orderArr valueForKey:@"entity_id"]];
            //NSLog(@"dict %@", dict);
            if ([[dict valueForKey:@"status"] integerValue] == 1)
            {
                
                //        [self.view addSubview:[[ToastAlert alloc] initWithText:[dict valueForKey:@"message"]]];
                [self performSelector:@selector(popVC) withObject:nil afterDelay:2];
            }
            else
            {
                //        [self.view addSubview:[[ToastAlert alloc] initWithText:[dict valueForKey:@"message"]]];
            }
            
            [SVProgressHUD dismiss];
        }
    }
    else if (alertView.tag == 20)
    {
        [self popVC];
    }
}

- (IBAction)editOrderBtnAct:(UIButton *)sender
{
//    #define baseUrl1 @"http://52.77.39.21/api/rest"
//    #define area @"http://52.77.39.21/js/areasearch/searchArea.json"
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Edit Order" message:@"Edit order will cancel your previous order and place a new order." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Cancel", @"Submit", nil];
    alertView.tag = 10;
    [alertView show];
    
    
}

-(void) popVC
{
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
        inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
        [self.navigationController pushViewController:inCartVC animated:YES];
    
//    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)threadStartAnimating2:(id)dat
{
    [SVProgressHUD show];
    
    
}


@end
