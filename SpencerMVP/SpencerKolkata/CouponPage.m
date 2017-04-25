//
//  CouponPage.m
//  Spencer
//
//  Created by Binary Semantics on 8/4/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "CouponPage.h"
#import "Const.h"
#import "Webmethods.h"
#import "SVProgressHUD.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"
#import "MainCategoryVC.h"
#import "MyProfileVC.h"
#import "CategoryPage.h"
#import "OfferVC.h"
#import "ProductVC.h"

@interface CouponPage ()

{
    ManualLocationVC *manualLocationVC;
    CategoryPage *Categoryvc;
    ProductVC *productVC;
}
@end

@implementation CouponPage
@synthesize resultCel;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"Coupon Screen";
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO)
    {
        return ;
    }
    [SVProgressHUD show];
    
    
    [Apply_obj setImage:[UIImage imageNamed:@"ic_go.png"] forState:UIControlStateNormal];
    
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl1]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                            path:[NSString stringWithFormat:@"%@/cart/getcoupons", baseUrl1]
                                                      parameters:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *jsonError = nil;
         id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
         if([[result valueForKey:@"status"] integerValue] == 1)
         {
            //NSDictionary *coupondict=  [result valueForKey:@"data"];
             
               values = [result valueForKey:@"data"];
//             name = [values valueForKeyPath:@"name"];
//             description = [values valueForKeyPath:@"description"];
//             code = [values valueForKeyPath:@"code"];
             [coupon_tbl reloadData];
             
         }
         else
         {
             [self.view addSubview:[[ToastAlert alloc] initWithText:@"No Coupons available"]];
         }
         
         [SVProgressHUD dismiss];
     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                         NSLog(@"Error: %@", error);
                                     }];
    [operation start];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
   coupon_tbl.contentInset = UIEdgeInsetsZero;
    coupon_tbl.scrollIndicatorInsets = UIEdgeInsetsZero;
    coupon_tbl.contentOffset = CGPointMake(0.0, 0.0);
    // Do any additional setup after loading the view from its nib.
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
    
    
    [titleLabelButton setTitle:@"Coupons" forState:UIControlStateNormal];
    titleLabelButton.frame = CGRectMake(0, 0, 200, 44);
    titleLabelButton.titleLabel.numberOfLines=1;
    [titleLabelButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [titleLabelButton setTitleColor:[UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    titleLabelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    //    [titleLabelButton addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleLabelButton;
    
    NSMutableArray *arrRightBarItems = [[NSMutableArray alloc] init];
    
    
    //    UIButton *btnSetting = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //    UIButton *btnLib = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [btnLib setImage:[UIImage imageNamed:@"ic_cart.png"] forState:UIControlStateNormal];
    //    btnLib.frame = CGRectMake(0, 0, 32, 32);
    //    ////btnLib.showsTouchWhenHighlighted=YES;
    //    [btnLib addTarget:self action:@selector(inCartBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:btnLib];
    //    [arrRightBarItems addObject:barButtonItem2];
    
    
    //    [btnSetting setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
    //    btnSetting.frame = CGRectMake(0, 0, 32, 32);
    //    //btnSetting.showsTouchWhenHighlighted=YES;
    //    [btnSetting addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSetting];
    //    [arrRightBarItems addObject:barButtonItem];
    
    //    bangeLbl = [[UILabel alloc] initWithFrame:CGRectMake(20,-5 , 18, 18)];
    //    bangeLbl.text = appDele.bangeStr;
    //    bangeLbl.font = [UIFont fontWithName:@"Helvetica" size:11];
    //    bangeLbl.backgroundColor = [UIColor clearColor];
    //    bangeLbl.textColor = [UIColor whiteColor];
    //    bangeLbl.textAlignment = NSTextAlignmentCenter;
    //    bangeLbl.backgroundColor = kColor_gray;
    //    bangeLbl.layer.cornerRadius = 9;
    //    bangeLbl.layer.masksToBounds = YES;
    //    bangeLbl.layer.borderColor = [UIColor whiteColor].CGColor;
    //    bangeLbl.layer.borderWidth = 1;
    //    if ([bangeLbl.text integerValue] > 0)
    //    {
    //        bangeLbl.hidden = NO;
    //    }
    //    else
    //    {
    //        bangeLbl.hidden = YES;
    //    }
    //    [btnLib addSubview:bangeLbl];
    
    self.navigationItem.rightBarButtonItems=arrRightBarItems;
}

-(IBAction)Coupon_Act:(UIButton *)sender
{
    Coupon_TXT.text = [NSString stringWithFormat:@"%@", [[values objectAtIndex:sender.tag] valueForKey:@"code"]];
//    [Apply_obj setImage:[UIImage imageNamed:@"ic_tick.png"] forState:UIControlStateNormal];
    [Apply_obj setImage:[UIImage imageNamed:@"ic_go.png"] forState:UIControlStateNormal];
}

- (IBAction)Apply_act:(UIButton *)sender
{
    
    [Coupon_TXT resignFirstResponder];
    
    
    
    if (Coupon_TXT.text.length < 1)
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter coupon code"]];
        return ;
    }
    else
    {
        [Apply_obj setImage:[UIImage imageNamed:@"ic_tick.png"] forState:UIControlStateNormal];
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
    NSString *couponStr = [Coupon_TXT.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    temp =[NSUserDefaults standardUserDefaults];
    
    oauth_token =[temp objectForKey:@"oauth_token"];
    
    
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
                     
                     
                 }
                 else
                 {
                     [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"applyremove"];
                     [self.view addSubview:[[ToastAlert alloc] initWithText:[dict valueForKey:@"message"]]];
                     [self performSelector:@selector(pop) withObject:nil afterDelay:1];
                     
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
            
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"applyremove"];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"applyremove"];
            [self.view addSubview:[[ToastAlert alloc] initWithText:[CouPonResponse_Dict valueForKey:@"message"]]];
            [self performSelector:@selector(pop) withObject:nil afterDelay:1];
        }
        
        
    }
    Coupon_TXT.text=@"";

}

-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backBtnAct:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    [[UINavigationBar appearance] setBarTintColor:kColor_gray];
    
    self.navigationController.navigationBar.barTintColor = kColor_gray;
    
    self.navigationController.navigationBar.hidden = NO;
    

    [self navigationView];
    
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 110;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return values.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CouponCell *cell;
    if (cell == nil)
    {
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            [[NSBundle mainBundle] loadNibNamed:@"CouponCell" owner:self options:nil];
//        }
//        else
//        {
//            [[NSBundle mainBundle] loadNibNamed:@"CouponCell~iPad" owner:self options:nil];
//        }
        cell = resultCel;
        
         cell.name_lbl.text = [NSString stringWithFormat:@"%@",[[values objectAtIndex:indexPath.row] valueForKey:@"name"]];
        
        
        if ([[NSString stringWithFormat:@"%@",[[values objectAtIndex:indexPath.row] valueForKey:@"description"]] isEqualToString:@"<null>"])
        {
            
        }
        else{
            cell.description_lbl.text = [NSString stringWithFormat:@"%@",[[values objectAtIndex:indexPath.row] valueForKey:@"description"]];
        }
        
         cell.description_lbl.numberOfLines=3;
        
        [cell.coupon_obj setTitleColor:kColor_Orange forState:UIControlStateNormal];
        cell.coupon_obj.layer.borderColor = kColor_Orange.CGColor;
        //cell.coupon_obj.titleLabel.text=[NSString stringWithFormat:@"%@",[code objectAtIndex:indexPath.row]];
        [cell.coupon_obj setTitle:[NSString stringWithFormat:@"%@",[[values objectAtIndex:indexPath.row] valueForKey:@"code"]] forState:UIControlStateNormal];
        cell.coupon_obj.layer.borderWidth = 1;
        cell.coupon_obj.layer.cornerRadius = 2;
        cell.coupon_obj.tag = indexPath.row;
        
        
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView reloadData];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * searchStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    NSLog(@"%@",searchStr);
    
    
//    if ([searchStr length] > 0)
//    {
//        [Apply_obj setImage:[UIImage imageNamed:@"ic_tick.png"] forState:UIControlStateNormal];
//    }
//    else
//    {
//        [Apply_obj setImage:[UIImage imageNamed:@"ic_go.png"] forState:UIControlStateNormal];
//    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
