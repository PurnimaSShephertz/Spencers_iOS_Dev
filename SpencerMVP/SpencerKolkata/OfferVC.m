//
//  OfferVC.m
//  Spencer
//
//  Created by binary on 21/07/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "OfferVC.h"
#import "AppDelegate.h"
#import "MainCategoryVC.h"
#import "MyProfileVC.h"
#import "LoginVC.h"
#import "CategoryPage.h"
#import "SearchVC.h"
#import "UIImageView+WebCache.h"
#import "ProductVC.h"


@interface OfferVC ()
{
    UILabel *bangeLbl;
    AppDelegate *appDele;
    InCartVC *inCartVC;
    SearchVC *searchVC;
    NSArray *colorArray;
}
@end

@implementation OfferVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"Offer Screen";
    appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    screenX = [UIScreen mainScreen].bounds.origin.x;
    screenY =[UIScreen mainScreen].bounds.origin.y;
    
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO)
    {
        return ;
    }
        [SVProgressHUD show];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                            path:[NSString stringWithFormat:@"%@/offers", baseUrl1]
                                                      parameters:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *jsonError = nil;
                 [SVProgressHUD dismiss];
         id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
         
         colorArray=[[result valueForKey:@"data"] valueForKey:@"offers"];
         
         for (int i = 0; i <= colorArray.count; i++)
         {
             UIImageView *imageView = [[UIImageView alloc] init];
             //                     imageView.backgroundColor = [colorArray objectAtIndex:i];
             int count = i/2;
             imageView.tag = i;
             
             if (i == 0)
             {
                 imageView.frame = CGRectMake(screenX+10, self.view.frame.origin.y, width-20, scr.frame.size.height/3+5);
                 imageView.tag = -10;
             }
             else
             {
                 if (height == 480)
                 {
                     if (i % 2 == 1)
                     {
                         imageView.frame = CGRectMake(screenX+10, (height/5.0*(count+1))+170, width/2-15, width/3+30);
                         //titleLabel.frame = CGRectMake(0, imageView.frame.size.height-25, imageView.frame.size.width, 50);
//                         imageView.backgroundColor = [UIColor greenColor];
                     }
                     else
                     {
                         imageView.frame = CGRectMake(width/2+5, (height/5.0*(count))+170, width/2-15, width/3+30);
                         //titleLabel.frame = CGRectMake(0, imageView.frame.size.height-25, imageView.frame.size.width-5, 50);
//                         imageView.backgroundColor = [UIColor redColor];
                     }
                 }
                 else
                 {
                     if (i % 2 == 1)
                     {
                         imageView.frame = CGRectMake(screenX+10, (height/4.0*(count+1))+20, width/2-15, width/3+30);
                         // titleLabel.frame = CGRectMake(0, imageView.frame.size.height-25, imageView.frame.size.width, 50);
//                         imageView.backgroundColor = [UIColor greenColor];
                     }
                     else
                     {
                         imageView.frame = CGRectMake(width/2+5, (height/4.0*(count))+20, width/2-15, width/3+30);
                         //titleLabel.frame = CGRectMake(0, imageView.frame.size.height-25, imageView.frame.size.width, 50);
//                         imageView.backgroundColor = [UIColor redColor];
                     }
                 }
             }
             
             if (i == 0)
             {
                 
                 
                 BOOL reach = [Webmethods checkNetwork];
                 if (reach == NO) {
                     //                             return ;
                 }
                 
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     NSString *imgUrl = [[result valueForKey:@"data"] valueForKey:@"banner"];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
                     //titleLabel.text = [NSString stringWithFormat:@"  %i", i];
                 });
                 
                 
                 //                         NSArray *imageArray  = [[[currentArray valueForKey:@"offer"] valueForKey:@"thumb_img"] componentsSeparatedByString:@"/"];
                 
                 
                 UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getTag:)];
                 imageView.contentMode=UIViewContentModeScaleToFill;
                 [imageView setUserInteractionEnabled:YES];
                 [imageView addGestureRecognizer: singleTap];
                 
             }
             else
             {
                 
                 
                 //titleLabel.text = [NSString stringWithFormat:@"  %i", i];
                 imageView.tag=i-1;
                 UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (getTag:)];
                 imageView.contentMode=UIViewContentModeScaleToFill;
                 [imageView setUserInteractionEnabled:YES];
                 [imageView addGestureRecognizer: singleTap];
//                 [cell.img sd_setImageWithURL:[NSURL URLWithString:[[productArr objectAtIndex:indexPath.row] valueForKey:@"image_url"]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]]
                 [imageView sd_setImageWithURL:[NSURL URLWithString:[[colorArray objectAtIndex:i-1] valueForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
             }
             [scr setContentSize:CGSizeMake(width-20, 530 )];
             [scr addSubview:imageView];
             //[imageView addSubview:titleLabel];
         }
         
     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
//         NSLog(@"Error: %@", error);
                [SVProgressHUD dismiss];
     }];
    [operation start];
    
    
}
-(void)getTag:(id) sender
{
    
    
    UIGestureRecognizer *recognizer = (UIGestureRecognizer*)sender;
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
//    NSLog(@"imageView.tag %li", (long)imageView.tag);
    if (imageView.tag < 0)
    {
        
    }
    else
    {
        NSString * storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        NSString *urlStr = [NSString stringWithFormat:@"%@/category/products/%@?page=%@&store=%@", baseUrl1, [[colorArray objectAtIndex:imageView.tag] valueForKey:@"url"], @"1", storeIdStr];
        ProductVC *productVC;
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            productVC = [[ProductVC alloc] initWithNibName:@"ProductVC" bundle:nil];
//        }
//        else
//        {
//            productVC = [[ProductVC alloc] initWithNibName:@"ProductVC~iPad" bundle:nil];
//        }
        productVC.productHeader = @"Offers";
        productVC.categoryUrl = urlStr;
        [self.navigationController pushViewController:productVC animated:YES];
    }
    
    
}

- (IBAction)backBtnAct:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    bangeLbl.hidden = YES;
    [searchBar1 resignFirstResponder];
    [self navigationView];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = kColor_Orange;
}
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
-(void)navigationView
{
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
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
    [titleLabelButton setTitle:[[NSUserDefaults standardUserDefaults] valueForKey:@"userLocation"] forState:UIControlStateNormal];
    titleLabelButton.frame = CGRectMake(0, 0, 200, 44);
    titleLabelButton.titleLabel.numberOfLines=1;
    [titleLabelButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [titleLabelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    titleLabelButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    [titleLabelButton addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleLabelButton;
    
    NSMutableArray *arrRightBarItems = [[NSMutableArray alloc] init];
    
    
    UIButton *btnSetting = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIButton *btnLib = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLib setImage:[UIImage imageNamed:@"ic_cart.png"] forState:UIControlStateNormal];
    btnLib.frame = CGRectMake(0, 0, 32, 32);
    //btnLib.showsTouchWhenHighlighted=YES;
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
    bangeLbl.text =appDele.bangeStr;
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
    
    
    //    UIButton *btnRefresh = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [btnRefresh setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
    //    btnRefresh.frame = CGRectMake(0, 0, 32, 32);
    //    btnRefresh.showsTouchWhenHighlighted=YES;
    //    [btnRefresh addTarget:self action:@selector(onRefreshBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:btnRefresh];
    //
    //    [arrRightBarItems addObject:barButtonItem1];
    
    self.navigationItem.rightBarButtonItems=arrRightBarItems;
}


- (IBAction)currentLocationBtnAct:(UIButton *)sender
{
    manualLocationVC = [[ManualLocationVC alloc] initWithNibName:@"ManualLocationVC" bundle:nil];
    manualLocationVC.headercheck=@"1001";
    [self.navigationController pushViewController:manualLocationVC animated:YES];
}

- (IBAction)inCartBtnAct:(UIButton *)sender
{
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
                CategoryPage * Categoryvc=[[CategoryPage alloc]initWithNibName:@"CategoryPage" bundle:nil];
                [self.navigationController pushViewController:Categoryvc animated:YES];
            }
        }
            break;
        case 13:
            
            break;
        case 14:
        {
            NSUserDefaults * temp=[NSUserDefaults standardUserDefaults];
            NSString * oauth_token =[temp objectForKey:@"oauth_token"];
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
            
        }
            
            break;
            
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
