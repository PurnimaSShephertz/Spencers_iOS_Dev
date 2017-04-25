//
//  Reviews.m
//  Spencer
//
//  Created by Binary Semantics on 9/1/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "Reviews.h"
#import "AppDelegate.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"
#import "Webmethods.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "ManualLocationVC.h"
#import "InCartVC.h"
#import "DynamicTableViewCell.h"
static NSString *ChatMessageCellIdentifier = @"DynamicCell";
@interface Reviews ()
{
    AppDelegate *appDele;
    ManualLocationVC *manualLocationVC;
   
}
@end

@implementation Reviews

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [reviewstable registerClass:[DynamicTableViewCell class] forCellReuseIdentifier:ChatMessageCellIdentifier];
    
    
//    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
//    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
//    if(oauth_token==NULL || [oauth_token isEqual:@""])
   //{
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO)
        {
            return ;
        }
        [SVProgressHUD show];
    NSString *reviewStr = [NSString stringWithFormat:@"%@/review/?sku=%@",baseUrl1,_sku_Str];
    
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseBannerUrl1]];
        [httpClient setParameterEncoding:AFFormURLParameterEncoding];
        NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                                path:reviewStr
                                                          parameters:nil];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSError *jsonError = nil;
             id result = [NSJSONSerialization JSONObjectWithData:responseObject options:2 error:&jsonError];
             [SVProgressHUD dismiss];
             if ([result isKindOfClass:[NSDictionary class]])
             {
                 if([[result valueForKey:@"status"] integerValue] == 1)
                 {
                     
                     reviewsarray=[[NSMutableArray alloc]init];
                     if ([[result valueForKey:@"data"] isKindOfClass:[NSArray class]])
                     {
                         reviewsarray = [result valueForKey:@"data"];
//                         [self.view addSubview:[[ToastAlert alloc] initWithText:[result valueForKey:@"message"]]];
                     }
                     else
                     {
                         [reviewstable reloadData];
                         [self.view addSubview:[[ToastAlert alloc] initWithText:@"No Reviews found for this product"]];
                         
                         [self performSelector:@selector(popVC) withObject:nil afterDelay:1];
                     }
                     
                     [reviewstable reloadData];
                     
                     
                 }
                 else
                 {
                     [self.view addSubview:[[ToastAlert alloc] initWithText:[result valueForKey:@"message"]]];
                 }
             }
             else
             {
                 [self.view addSubview:[[ToastAlert alloc] initWithText:[result valueForKey:@"message"]]];
             }
             
             
             [SVProgressHUD dismiss];
         }
         
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             [SVProgressHUD dismiss];
//                NSLog(@"Error: %@", error);
         }];
        
        [operation start];
//    }
//    else
//    {
//        [SVProgressHUD show];
//        NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
//        
//        dict=[Webmethods AllReviews:[NSString stringWithFormat:@"%@/review/?sku=%@",baseUrl1,_sku_Str]];
//        [SVProgressHUD dismiss];
//        reviewsarray=[[NSMutableArray alloc]init];
//
//        if ([dict isKindOfClass:[NSDictionary class]])
//        {
//            if([[dict valueForKey:@"status"] integerValue] == 1)
//            {
//                [SVProgressHUD dismiss];
//                reviewsarray=[[NSMutableArray alloc]init];
//                if ([[dict valueForKey:@"data"] isKindOfClass:[NSArray class]])
//                {
//                    reviewsarray = [dict valueForKey:@"data"];
//                }
//                
//                [reviewstable reloadData];
//                [self.view addSubview:[[ToastAlert alloc] initWithText:[dict valueForKey:@"message"]]];
//                
//            }
//            else
//            {
//                [self.view addSubview:[[ToastAlert alloc] initWithText:[dict valueForKey:@"message"]]];
//            }
//        }
//        else
//        {
//            [self.view addSubview:[[ToastAlert alloc] initWithText:[dict valueForKey:@"message"]]];
//        }
//        
//    }
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    reviewstable.contentInset = UIEdgeInsetsZero;
    reviewstable.scrollIndicatorInsets = UIEdgeInsetsZero;
    reviewstable.contentOffset = CGPointMake(0.0, 0.0);
    // Do any additional setup after loading the view from its nib.
}

-(void)popVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)navigationView
{
    UIButton *backBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0f, -30.0f, 0.0f, 0.0f);
    UIImage *backBtnImage = [UIImage imageNamed:@"ic_left_arw.png"];
    //    [backBtn setBackgroundColor:[UIColor redColor]];
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *menubutton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:menubutton , nil]];
    self.navigationItem.leftBarButtonItem = menubutton;
    
    UIButton *titleLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [titleLabelButton setTitle:@"All Reviews" forState:UIControlStateNormal];
    titleLabelButton.frame = CGRectMake(0, 0, 200, 44);
    titleLabelButton.titleLabel.numberOfLines=1;
    [titleLabelButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [titleLabelButton setTitleColor:[UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    titleLabelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    [titleLabelButton addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleLabelButton;
    
    NSMutableArray *arrRightBarItems = [[NSMutableArray alloc] init];
    
    
//    UIButton *btnSetting = [UIButton buttonWithType:UIButtonTypeCustom];
//    
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
//    bangeLbl.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:149.0/255.0 blue:59.0/255.0 alpha:1];
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
    
    //self.navigationItem.rightBarButtonItems=arrRightBarItems;
}
- (IBAction)backBtnAct:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    bangeLbl.hidden = YES;
    [self navigationView];
    self.navigationController.navigationBar.barTintColor = kColor_Orange;
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //assuming some_table_data respresent the table data
    reviewstable.backgroundView = nil;
    reviewstable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return reviewsarray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DynamicTableViewCell *cell ;
    
    cell = [[DynamicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ChatMessageCellIdentifier];
    NSDictionary *commentDic =  [reviewsarray objectAtIndex:indexPath.row];
    
   
    
    NSInteger value=indexPath.row;
    
    NSInteger value2=value+1;
    
     NSString * str=[NSString stringWithFormat:@"%ld",(long)value2];
    
    
    [cell configureCellWithMessage:commentDic and:str];
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *commentDic =  [reviewsarray objectAtIndex:indexPath.row];
    NSString *AppendString=[NSString stringWithFormat:@"%@",[commentDic valueForKey:@"detail"]];
    
    NSString * str2=[NSString stringWithFormat:@"%@%@",AppendString,[NSString stringWithFormat:@"%@",[commentDic valueForKey:@"nickname"]]];
    NSString * str3=[NSString stringWithFormat:@"%@%@",str2,[NSString stringWithFormat:@"%@",[commentDic valueForKey:@"title"]]];
    
    CGFloat cellHeight = [DynamicTableViewCell heightForCellWithMessage:str3];
    
    return cellHeight;
    
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
    return footer;
}

- (IBAction)inCartBtnAct:(UIButton *)sender
{
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
        InCartVC *inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
        [self.navigationController pushViewController:inCartVC animated:YES];
    }
}
- (IBAction)currentLocationBtnAct:(UIButton *)sender
{
    manualLocationVC = [[ManualLocationVC alloc] initWithNibName:@"ManualLocationVC" bundle:nil];
    manualLocationVC.headercheck=@"1001";
    [self.navigationController pushViewController:manualLocationVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
