//
//  ProductDetailPage.m
//  Spencer
//
//  Created by Binary Semantics on 7/2/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "ProductDetailPage.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"
#import "Webmethods.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "AppDelegate.h"
#import "ManualLocationVC.h"
#import "ProductVC.h"
#import "SearchListVC.h"
#import "Reviews.h"
#import "writeReviewView.h"
#import "SH_TrackingUtility.h"


@interface ProductDetailPage ()
{
    AppDelegate *appDele;
    ManualLocationVC *manualLocationVC;
    int count1;
    NSMutableDictionary *productDetailsDict;
}
@end

@implementation ProductDetailPage
@synthesize pushedFlag;
@synthesize counterDict, indexNumber;


- (void)viewDidLoad {
    [super viewDidLoad];
    writereview_view.alpha = 0;
    
    self.scrollView.delegate=self;
    self.screenName = @"Product Details Screen";
    
//    Description_Txt.userInteractionEnabled = YES;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    inCartLbl.text = _inCartStr;
    ScreenWidth= [UIScreen mainScreen].bounds.size.width;
    ScreenHeight= [UIScreen mainScreen].bounds.size.height;
    [Header_img setBackgroundColor:[UIColor colorWithRed: 229/255.0 green:148/255.0 blue:60/255.0 alpha:1.0]];
    
    Qty_View.layer.borderColor=[UIColor colorWithRed: 237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0].CGColor;
    Qty_View.layer.borderWidth=1.0;
    appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDele.ACPBool = 2;
    
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO)
    {
        return ;
    }
    [SVProgressHUD show];

    [Pagescroll setHidden:YES];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl1]];
    
    NSString *storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
    
    NSLog(@"%@", [NSString stringWithFormat:@"%@/product/%@?cartid=%@&store=%@", baseUrl1,_entity_id, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], storeIdStr]);
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    
   
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        //            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&sort=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortStr];
        
        
        
            NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
            NSString *oauth_token = [temp objectForKey:@"oauth_token"];
            NSString * storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        
            NSString *cartIdStr = [NSString stringWithFormat:@"%@/product/%@?cartid=%@&store=%@", baseUrl1,_entity_id, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], storeIdStr];
            
//            if ([quantityId length] > 1 && [brandId length] > 1)
//            {
//                cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&sort=%@&quantity=%@&brand=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortString, quantityId, brandId];
//            }
//            else if ([quantityId length] > 1)
//            {
//                cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&sort=%@&quantity=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortString, quantityId];
//            }
//            else if ([brandId length] > 1)
//            {
//                cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&sort=%@&brand=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortString, brandId];
//            }
//            else
//            {
//                cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&sort=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortString];
//            }
            //            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&sort=%@&quantity=%@&brand=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortStr, quantityId, brandId];
            //            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&sort=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortStr];
//            NSLog(@"cartIdStr %@", cartIdStr);
        
            if(oauth_token==NULL || [oauth_token isEqual:@""])
            {
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:cartIdStr]];
                [NSURLConnection sendAsynchronousRequest:request
                                                   queue:[NSOperationQueue mainQueue]
                                       completionHandler:^(NSURLResponse *response,
                                                           NSData *data, NSError *connectionError)
                 {
                     if (data.length > 0 && connectionError == nil)
                     {
                         
                         NSError *jsonError = nil;
                         [SVProgressHUD dismiss];
                         [Pagescroll setHidden:NO];
                         
                         id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                         
                         productDetailsDict  = [[NSMutableDictionary alloc] initWithDictionary:result];
                         
                         NSString *urlEncoded = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                                      NULL,
                                                                                                                      (CFStringRef)[NSString stringWithFormat:@"%@",[[result valueForKey:@"data"] valueForKey:@"image"]],
                                                                                                                      NULL,
                                                                                                                      (CFStringRef)@"<>",
                                                                                                                      kCFStringEncodingUTF8));
                         
//                         [Product_img sd_setImageWithURL:[NSURL URLWithString:urlEncoded]];
                         [Product_img sd_setImageWithURL:[NSURL URLWithString:urlEncoded] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
                         if([[NSString stringWithFormat:@"%@",[[result valueForKey:@"data"] valueForKey:@"description"]] isKindOfClass:[NSNull class]] || [[NSString stringWithFormat:@"%@",[[result valueForKey:@"data"] valueForKey:@"description"]] isEqualToString:@"<null>"])
                         {
                             
                         }
                         else
                         {
                             [self Descriptionresize:[NSString stringWithFormat:@"%@",[[result valueForKey:@"data"]  valueForKey:@"description"]]];
                         }
                         
                         inCartLbl.text = [NSString stringWithFormat:@"%@", [[result valueForKey:@"data"] valueForKey:@"in_cart"]];
                         
                         if (pushedFlag == 2)
                         {
                             inCartLbl.text = [counterDict valueForKey:[NSString stringWithFormat:@"%i", indexNumber]];
                         }
                         
                         
                         
                         if ([inCartLbl.text integerValue] == 0)
                         {
                             inCartLbl.hidden = YES;
                         }
                         else
                         {
                             inCartLbl.hidden = NO;
                         }
                         
                         Qty_lbl.text=[NSString stringWithFormat:@"Qty: %@",[[result valueForKey:@"data"] valueForKey:@"quantity"]];
                         
                         Product_name_lbl.text=[[result valueForKey:@"data"] valueForKey:@"name"];
                         
                         NSString * spprice=[NSString stringWithFormat:@"%@",[[result valueForKey:@"data"] valueForKey:@"special_price"]];
                         
                         if([spprice isEqualToString:@"<null>"] || spprice.length == 0 )
                         {
                             [Price_lbl setHidden:YES];
                             [price_line_lbl setHidden:YES];
                             SpecilaPrice_lbl.text=[NSString stringWithFormat:@"Rs. %.2f",[[[result valueForKey:@"data"] valueForKey:@"price"] floatValue]];
                         // SpecilaPrice_lbl.text=[NSString stringWithFormat:@"Rs. %.2f",[[[result valueForKey:@"data"] valueForKey:@"special_price"] floatValue]];
                         }
                         else
                         {
                            [price_line_lbl setHidden:NO];
                             [Price_lbl setHidden:NO];
                             Price_lbl.text=[NSString stringWithFormat:@"Rs. %.2f",[[[result valueForKey:@"data"] valueForKey:@"price"] floatValue]];
                             SpecilaPrice_lbl.text=[NSString stringWithFormat:@"Rs. %.2f",[[[result valueForKey:@"data"] valueForKey:@"special_price"] floatValue]];
                         }
                         
                         
                         Qty_View.frame=CGRectMake(0, Product_img.frame.origin.y+Product_img.frame.size.height+Description_Txt.frame.size.height+35, ScreenWidth, 76);
                         
                         Plusminus_button.frame=CGRectMake(Qty_View.frame.size.width-110, Plusminus_button.frame.origin.y, 82, 45);
                         plus_button.frame=CGRectMake(Plusminus_button.frame.origin.x+Plusminus_button.frame.size.width/2, Plusminus_button.frame.origin.y, 46, 46);
                         minus_button.frame=CGRectMake(Plusminus_button.frame.origin.x+Plusminus_button.frame.size.width/2-46, Plusminus_button.frame.origin.y, 46, 46);
                         
                         self.scrollMenu.frame=CGRectMake(0, Product_img.frame.origin.y+Product_img.frame.size.height+Description_Txt.frame.size.height+Qty_View.frame.size.height+45, ScreenWidth, 50);
                         [self setUpACPScroll:result];
                         
                         Varient_view.frame=CGRectMake(19, self.scrollMenu.frame.origin.y+self.scrollMenu.frame.size.height, ScreenWidth-38, 197);
                     }
                     else
                     {
                         [SVProgressHUD dismiss];
                         //[self.view addSubview:[[ToastAlert alloc] initWithText:@"No Network Found"]];
                         //                         [HUD hide:YES];
                     }
                 }];
            }
            else
            {
                //                if ([quantityId length] > 1 && [brandId length] > 1)
                //                {
                //                    cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&sort=%@&dir=%@&quantity=%@&brand=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], sortString, descString, quantityId, brandId];
                //                }
                //                else
                //                {
                //                    cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&sort=%@&dir=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], sortString, descString];
                //                }
                
                //                NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&sort=%@&dir=%@&quantity=%@&brand=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], sortStr, descString, quantityId, brandId];
                
                //                NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&sort=%@&dir=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], sortStr, descString];
                
                
                result = [Webmethods product:cartIdStr];
                //                [HUD hide:YES];
                //NSLog(@"tempDict %@", tempDict);
                
                
                // NSLog(@"globalcartid %@", cartIdStr);
                
                [SVProgressHUD dismiss];
                
                if ([[result valueForKey:@"status"] integerValue] == 1)
                {
                    NSError *jsonError = nil;
                    [SVProgressHUD dismiss];
                    [Pagescroll setHidden:NO];
                    
//                    id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                    
                    productDetailsDict  = [[NSMutableDictionary alloc] initWithDictionary:result];
                    
                    
                    NSString *urlEncoded = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                                 NULL,
                                                                                                                 (CFStringRef)[NSString stringWithFormat:@"%@",[[result valueForKey:@"data"] valueForKey:@"image"]],
                                                                                                                 NULL,
                                                                                                                 (CFStringRef)@"<>",
                                                                                                                 kCFStringEncodingUTF8));
                    
                    
                    
                    [Product_img sd_setImageWithURL:[NSURL URLWithString:urlEncoded] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
                    if([[NSString stringWithFormat:@"%@",[[result valueForKey:@"data"] valueForKey:@"description"]] isKindOfClass:[NSNull class]] || [[NSString stringWithFormat:@"%@",[[result valueForKey:@"data"] valueForKey:@"description"]] isEqualToString:@"<null>"])
                    {
                        
                    }
                    else
                    {
                        [self Descriptionresize:[NSString stringWithFormat:@"%@",[[result valueForKey:@"data"]  valueForKey:@"description"]]];
                    }
                    
                    inCartLbl.text = [NSString stringWithFormat:@"%@", [[result valueForKey:@"data"] valueForKey:@"in_cart"]];
                    
                    if (pushedFlag == 2)
                    {
                        inCartLbl.text = [counterDict valueForKey:[NSString stringWithFormat:@"%i", indexNumber]];
                    }
                    
                    if ([inCartLbl.text integerValue] == 0)
                    {
                        inCartLbl.hidden = YES;
                    }
                    else
                    {
                        inCartLbl.hidden = NO;
                    }
                    
                    Qty_lbl.text=[NSString stringWithFormat:@"Qty: %@",[[result valueForKey:@"data"] valueForKey:@"quantity"]];
                    
                    Product_name_lbl.text=[[result valueForKey:@"data"] valueForKey:@"name"];
                    
                    NSString * spprice=[NSString stringWithFormat:@"%@",[[result valueForKey:@"data"] valueForKey:@"special_price"]];
                    
                    if([spprice isEqualToString:@"<null>"] || spprice.length == 0 )
                    {
                        [Price_lbl setHidden:YES];
                        [price_line_lbl setHidden:YES];
                        SpecilaPrice_lbl.text=[NSString stringWithFormat:@"Rs. %.2f",[[[result valueForKey:@"data"] valueForKey:@"price"] floatValue]];
                        //                             SpecilaPrice_lbl.text=[NSString stringWithFormat:@"Rs. %.2f",[[[result valueForKey:@"data"] valueForKey:@"special_price"] floatValue]];
                    }
                    else
                    {
                        [price_line_lbl setHidden:NO];
                        [Price_lbl setHidden:NO];
                        Price_lbl.text=[NSString stringWithFormat:@"Rs. %.2f",[[[result valueForKey:@"data"] valueForKey:@"price"] floatValue]];
                        SpecilaPrice_lbl.text=[NSString stringWithFormat:@"Rs. %.2f",[[[result valueForKey:@"data"] valueForKey:@"special_price"] floatValue]];
                    }
                    
                    
                    Qty_View.frame=CGRectMake(0, Product_img.frame.origin.y+Product_img.frame.size.height+Description_Txt.frame.size.height+35, ScreenWidth, 76);
                    
                    Plusminus_button.frame=CGRectMake(Qty_View.frame.size.width-110, Plusminus_button.frame.origin.y, 82, 45);
                    plus_button.frame=CGRectMake(Plusminus_button.frame.origin.x+Plusminus_button.frame.size.width/2, Plusminus_button.frame.origin.y, 46, 46);
                    minus_button.frame=CGRectMake(Plusminus_button.frame.origin.x+Plusminus_button.frame.size.width/2-46, Plusminus_button.frame.origin.y, 46, 46);
                    
                    self.scrollMenu.frame=CGRectMake(0, Product_img.frame.origin.y+Product_img.frame.size.height+Description_Txt.frame.size.height+Qty_View.frame.size.height+45, ScreenWidth, 50);
                    [self setUpACPScroll:result];
                    
                    Varient_view.frame=CGRectMake(19, self.scrollMenu.frame.origin.y+self.scrollMenu.frame.size.height, ScreenWidth-38, 197);
                }
                else
                {
                    [self.view addSubview:[[ToastAlert alloc] initWithText:[result valueForKey:@"message"]]];
                    [self performSelector:@selector(popVC) withObject:nil afterDelay:1];
                    //                    [HUD hide:YES];
                }
                
            }
        
    });
    

//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
//                                                            path:[NSString stringWithFormat:@"%@/product/%@?cartid=%@", baseUrl1, _entity_id, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]]
//                                                      parameters:nil];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         NSError *jsonError = nil;
//        [SVProgressHUD dismiss];
//         [Pagescroll setHidden:NO];
//         
//         id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
//         
//         productDetailsDict = result;
//         
//         [Product_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[result valueForKey:@"data"] valueForKey:@"image"]]]];
//         if([[NSString stringWithFormat:@"%@",[[result valueForKey:@"data"] valueForKey:@"description"]] isKindOfClass:[NSNull class]] || [[NSString stringWithFormat:@"%@",[[result valueForKey:@"data"] valueForKey:@"description"]] isEqualToString:@"<null>"])
//         {
//     
//         }
//         else
//         {
//             [self Descriptionresize:[NSString stringWithFormat:@"%@",[[result valueForKey:@"data"]  valueForKey:@"description"]]];
//         }
//         
//         inCartLbl.text = [NSString stringWithFormat:@"%@", [[result valueForKey:@"data"] valueForKey:@"in_cart"]];
//         
//        Qty_lbl.text=[NSString stringWithFormat:@"Qty: %@",[[result valueForKey:@"data"] valueForKey:@"quantity"]];
//      
//         Product_name_lbl.text=[[result valueForKey:@"data"] valueForKey:@"name"];
//         
//         NSString * spprice=[NSString stringWithFormat:@"%@",[[result valueForKey:@"data"] valueForKey:@"special_price"]];
//         
//         if(spprice == (id)[NSNull null] || spprice.length == 0 )
//         {
//             Price_lbl.text=[NSString stringWithFormat:@"Rs. %.2f",[[[result valueForKey:@"data"] valueForKey:@"price"] floatValue]];
//             SpecilaPrice_lbl.text=[NSString stringWithFormat:@"Rs. %.2f",[[[result valueForKey:@"data"] valueForKey:@"special_price"] floatValue]];
//         }
//         else
//         {
//             [Price_lbl setHidden:YES];
//             [price_line_lbl setHidden:YES];
//             SpecilaPrice_lbl.text=[NSString stringWithFormat:@"Rs. %.2f",[[[result valueForKey:@"data"] valueForKey:@"price"] floatValue]];
//         }
//         
//
//         Qty_View.frame=CGRectMake(0, Product_img.frame.origin.y+Product_img.frame.size.height+Description_Txt.frame.size.height+35, ScreenWidth, 76);
//         
//         Plusminus_button.frame=CGRectMake(Qty_View.frame.size.width-110, Plusminus_button.frame.origin.y, 82, 45);
//         plus_button.frame=CGRectMake(Plusminus_button.frame.origin.x+Plusminus_button.frame.size.width/2, Plusminus_button.frame.origin.y, 46, 46);
//         minus_button.frame=CGRectMake(Plusminus_button.frame.origin.x+Plusminus_button.frame.size.width/2-46, Plusminus_button.frame.origin.y, 46, 46);
//         
//         self.scrollMenu.frame=CGRectMake(0, Product_img.frame.origin.y+Product_img.frame.size.height+Description_Txt.frame.size.height+Qty_View.frame.size.height+45, ScreenWidth, 50);
//         [self setUpACPScroll:result];
//         
//         Varient_view.frame=CGRectMake(19, self.scrollMenu.frame.origin.y+self.scrollMenu.frame.size.height, ScreenWidth-38, 197);
//        
//    }
//       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//           [SVProgressHUD dismiss];
//    }];
//    [operation start];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    bangeLbl.hidden = YES;
    
    [self navigationView];
    
    self.navigationController.navigationBar.barTintColor = kColor_Orange;
    
    [searchBar1 resignFirstResponder];
    [currentLocationBtnObj setTitle:[[NSUserDefaults standardUserDefaults] valueForKey:@"userLocation"] forState:UIControlStateNormal];
     [writereview_view setHidden:YES];
//    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
//    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
//    
//    if(oauth_token==NULL || [oauth_token isEqual:@""])
//    {
////        [writereview_view setHidden:YES];
////        [rate1_img setHidden:YES];
////        [rate2_img setHidden:YES];
////        [rate3_img setHidden:YES];
////        [rate4_img setHidden:YES];
////        [rate_img5 setHidden:YES];
////        [ratelist_Obj setHidden:YES];
//        [writereview_Obj setHidden:YES];
//        
//    }
//    else
//    {
////        [writereview_view setHidden:YES];
////        [rate1_img setHidden:NO];
////        [rate2_img setHidden:NO];
////        [rate3_img setHidden:NO];
////        [rate4_img setHidden:NO];
////        [rate_img5 setHidden:NO];
////        [ratelist_Obj setHidden:NO];
//        [writereview_Obj setHidden:NO];
//    }

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        LoginVC* loginpage;
        loginpage = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
        loginpage.CheckProfileStatus=@"002";
        [self.navigationController pushViewController:loginpage animated:NO];
    }
}

-(IBAction)Writereview_Act:(id)sender
{
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    
//    if(oauth_token==NULL || [oauth_token isEqual:@""])
//    {
//        [[[UIAlertView alloc] initWithTitle:@"" message:@"This is only for login users" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login", nil] show];
//    }
//    else
//    {
        writeReviewView * reviews=[[writeReviewView alloc]initWithNibName:@"writeReviewView" bundle:nil];
        UIViewController *top = [UIApplication sharedApplication].keyWindow.rootViewController;
        reviews.sku_Str=[[productDetailsDict valueForKey:@"data"] valueForKey:@"sku"];
        [top presentViewController:reviews animated:YES completion: nil];
   // }
   
}
-(IBAction)review_Act:(id)sender
{
    Reviews * reviews=[[Reviews alloc]initWithNibName:@"Reviews" bundle:nil];
    reviews.sku_Str=[[productDetailsDict valueForKey:@"data"] valueForKey:@"sku"];
    [self.navigationController pushViewController:reviews animated:YES];
}

//- (void)show
//{
//    NSLog(@"show");
//    isShown = YES;
//   
//    [writereview_view setHidden:NO];
//    writereview_view.transform = CGAffineTransformMakeScale(0.1, 0.1);
//    writereview_view.alpha = 0;
//    [UIView beginAnimations:@"showAlert" context:nil];
//    [UIView setAnimationDelegate:self];
//    writereview_view.transform = CGAffineTransformMakeScale(1.1, 1.1);
//    writereview_view.alpha = 1;
//     writereview_view.center = self.view.center;
//    [UIView commitAnimations];
//}
//
//- (void)hide
//{
//    NSLog(@"hide");
//    isShown = NO;
//    [UIView beginAnimations:@"hideAlert" context:nil];
//    [UIView setAnimationDelegate:self];
//    writereview_view.transform = CGAffineTransformMakeScale(0.1, 0.1);
//    writereview_view.alpha = 0;
//    [UIView commitAnimations];
//}

//- (void)toggle
//{
//    if (isShown) {
//        [self hide];
//    } else {
//        [self show];
//    }
//}

#pragma mark Animation delegate

//- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
//{
//    if ([animationID isEqualToString:@"showAlert"]) {
//        if (finished) {
//            [UIView beginAnimations:nil context:nil];
//            writereview_view.transform = CGAffineTransformMakeScale(1.0, 1.0);
//            [UIView commitAnimations];
//        }
//    } else if ([animationID isEqualToString:@"hideAlert"]) {
//        if (finished) {
//            writereview_view.transform = CGAffineTransformMakeScale(1.0, 1.0);
//            writereview_view.frame = originalFrame;
//        }
//    }
//}
//
//#pragma mark Touch methods
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    lastTouchLocation = [touch locationInView:writereview_view];
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    CGPoint newTouchLocation = [touch locationInView:writereview_view];
//    CGRect currentFrame = writereview_view.frame;
//    
//    CGFloat deltaX = lastTouchLocation.x - newTouchLocation.x;
//    CGFloat deltaY = lastTouchLocation.y - newTouchLocation.y;
//    
//    writereview_view.frame = CGRectMake(currentFrame.origin.x - deltaX, currentFrame.origin.y - deltaY, currentFrame.size.width, currentFrame.size.height);
//    lastTouchLocation = [touch locationInView:writereview_view];
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    
//}
//
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    
//}
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

-(void)Descriptionresize:(NSString *)Txt
{
    Description_Txt.text=Txt;
  
    
    CGSize  textSize = {ScreenWidth-16, 10000.0};
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.1"))
    {
        CGRect rect = [Description_Txt.text  boundingRectWithSize:textSize
                                                               options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                            attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:10]} context:nil];
        rect.size.width += 10;
        
        width = rect.size.width;
        height = rect.size.height;
    }
    else
    {
        //        CGSize size = [self.messageTextView.text sizeWithFont:[UIFont boldSystemFontOfSize:13]
        //                                            constrainedToSize:textSize
        //                                                lineBreakMode:NSLineBreakByWordWrapping];
        
        CGSize size = [Description_Txt.text sizeWithAttributes:
                       @{NSFontAttributeName: [UIFont systemFontOfSize:11.0f]}];
        size.width += 10.0;
        width = size.width;
        
        
        height = size.height;
    }
    [Description_Txt setFrame:CGRectMake(18, Product_img.frame.origin.y+Product_img.frame.size.height+40, ScreenWidth-32, height+20)];
    
    
    [Description_Txt sizeToFit];
}

-(void)Descriptionresize1:(NSString *)Txt
{
    Tab_Description_txt.text=Txt;
    
    
    CGSize  textSize = {ScreenWidth-16, 10000.0};
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.1"))
    {
        CGRect rect = [Tab_Description_txt.text  boundingRectWithSize:textSize
                                                          options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                       attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:10]} context:nil];
        rect.size.width += 10;
        
        width = rect.size.width;
        height = rect.size.height;
    }
    else
    {
        CGSize size = [Description_Txt.text sizeWithAttributes:
                       @{NSFontAttributeName: [UIFont systemFontOfSize:11.0f]}];
        size.width += 10.0;
        width = size.width;
        height = size.height;
    }
    [Tab_Description_txt setFrame:CGRectMake(58, _scrollMenu.frame.origin.y+_scrollMenu.frame.size.height+30, ScreenWidth-62, height)];
    tabimg.frame=CGRectMake(8, _scrollMenu.frame.origin.y+_scrollMenu.frame.size.height+40, 46, 46);
    
    
    [Tab_Description_txt sizeToFit];
}


- (void)setUpACPScroll:(NSDictionary
                        *)Tabs
{
    
    NSArray * TabsArr = [[[Tabs valueForKey:@"data"]valueForKey:@"tabs"] valueForKey:@"name"];
    NSArray * discriptionArr=[[[Tabs valueForKey:@"data"]valueForKey:@"tabs"] valueForKey:@"description"];
    
    NSMutableArray *finalTabsArr = [[NSMutableArray alloc] init];
     NSMutableArray *desArr = [[NSMutableArray alloc] init];
    NSArray *tabs = [[Tabs valueForKey:@"data"]valueForKey:@"tabs"];
    
    
    for (int j = 0; j < [tabs count]; j++ )
    {
        
        
        if([[NSString stringWithFormat:@"%@",[[tabs objectAtIndex:j] valueForKey:@"description"]] isKindOfClass:[NSNull class]] || [[NSString stringWithFormat:@"%@",[[tabs objectAtIndex:j] valueForKey:@"description"]] isEqualToString:@"<null>"])
        {
            
        }
        else
        {
            [finalTabsArr addObject:[[tabs objectAtIndex:j] valueForKey:@"name"]];
            [desArr addObject:[[tabs objectAtIndex:j] valueForKey:@"description"]];
            
        }
    }
    if (finalTabsArr.count < 1)
    {
        seperatorImg.hidden = YES;
    }
    else
    {
        seperatorImg.hidden = NO;
    }
//    NSLog(@"finalTabsArr %@", finalTabsArr);
    
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"checkbacground_img"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < [finalTabsArr count]; i++)
    {
        if (i==0)
        {
            tabimg.image=nil;
                [self Descriptionresize1:[NSString stringWithFormat:@"%@",[desArr objectAtIndex:i]]];
                
                NSString *newString = [[finalTabsArr objectAtIndex:0] stringByReplacingOccurrencesOfString:@" " withString:@""];
                if ([newString isEqualToString:@"Ingredients"])
                {
                    tabimg.image=[UIImage imageNamed:@"icon_ingredient1.png"];
                }
               else if ([[finalTabsArr objectAtIndex:0] isEqualToString:@"Nutrition Value"])
                {
                    tabimg.image=[UIImage imageNamed:@"img-nutritional2.png"];
                }
               else if ([[finalTabsArr objectAtIndex:0] isEqualToString:@"Country of Origin"])
               {
                  tabimg.image=[UIImage imageNamed:@"icon_country3.png"];
               }
               else if ([[finalTabsArr objectAtIndex:0] isEqualToString:@"Benefits"])
               {
                   tabimg.image=[UIImage imageNamed:@"img-benefits4.png"];
               }
               else if ([[finalTabsArr objectAtIndex:0] isEqualToString:@"Instructions/Directions of Use"])
               {
                   tabimg.image=[UIImage imageNamed:@"icon_instructions5.png"];
               }
           
             Pagescroll.contentSize = CGSizeMake(ScreenWidth,Tab_Description_txt.frame.origin.y+Tab_Description_txt.frame.size.height+100);
        }
        
        
        ACPItem *item = [[ACPItem alloc] initACPItem:nil
                                           iconImage:nil
                                               label:[[finalTabsArr objectAtIndex:i] uppercaseString]
                                           andAction: ^(ACPItem *item)
                         {
                            
                             NSString *newString = [[finalTabsArr objectAtIndex:i] stringByReplacingOccurrencesOfString:@" " withString:@""];
                             
                                 if ([newString isEqualToString:@"Ingredients"])
                                 {
                                     tabimg.image=nil;
                                     tabimg.image=[UIImage imageNamed:@"icon_ingredient1.png"];
                                 }
                                 else if ([[finalTabsArr objectAtIndex:i] isEqualToString:@"Nutrition Value"])
                                 {
                                     tabimg.image=nil;
                                     tabimg.image=[UIImage imageNamed:@"img-nutritional2.png"];
                                 }
                                 else if ([[finalTabsArr objectAtIndex:i] isEqualToString:@"Country of Origin"])
                                 {
                                    tabimg.image=nil;
                                     tabimg.image=[UIImage imageNamed:@"icon_country3.png"];
                                 }
                                 else if ([newString isEqualToString:@"Benefits"])
                                 {
                                     tabimg.image=nil;
                                     tabimg.image=[UIImage imageNamed:@"img-benefits4.png"];
                                 }
                                 else if ([[finalTabsArr objectAtIndex:i] isEqualToString:@"Instructions/Directions of Use"])
                                 {
                                     tabimg.image=nil;
                                     tabimg.image=[UIImage imageNamed:@"icon_instructions5.png"];
                                 }
                                 [self Descriptionresize1:[NSString stringWithFormat:@"%@",[desArr objectAtIndex:i]]];
                             
                              Pagescroll.contentSize = CGSizeMake(ScreenWidth,Tab_Description_txt.frame.origin.y+Tab_Description_txt.frame.size.height+100);
                                           }];
        
    [item setHighlightedBackground:nil iconHighlighted:nil textColorHighlighted:[UIColor darkGrayColor]];
        [array addObject:item];
        [_scrollMenu setUpACPScrollMenu:array];
        [_scrollMenu setAnimationType:ACPZoomOut];
        _scrollMenu.delegate = self;
        
        
    }
    
    
}
-(IBAction)Plus_Act:(id)sender
{
//    ProductCell *selectedCell = (ProductCell *)[productListTblVew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    count1 = (int)[inCartLbl.text integerValue];
    count1 ++;
    
    //    selectedCell.count.text = [NSString stringWithFormat:@"%i", count1];
    
//    if ([selectedCell.count.text integerValue] > 0)
//    {
//        selectedCell.addCartBtnObj.hidden = NO;
//    }
    
    [self addCartBtnAct:sender];
}
-(IBAction)Minus_Act:(id)sender
{
    count1 = (int)[inCartLbl.text integerValue];
    if (count1 > 0)
    {
        count1 --;
        [self addCartBtnAct:sender];
    }
    
}

#pragma mark CartDetails
- (IBAction)addCartBtnAct:(UIButton *)sender
{
    //    pageNumber = 1;
    
    
    if ([sender.titleLabel.text isEqualToString:@"OUT OF Stock"])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"OUT OF Stock"]];
        return ;
    }
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    
    NSString *pidStr = _entity_id;
    NSString *qtyStr ;
    
    NSString *storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
    _inCartStr = [[productDetailsDict valueForKey:@"data"] valueForKey:@"cart_itemid"];
    
    
    if ( [_inCartStr integerValue] < 1 )
    {
        
        
        
        
        NSString *urlStr = [NSString stringWithFormat:@"%@/cart/add/?pid=%@&qty=%d&store=%@", baseUrl1, pidStr, count1, storeIdStr];
        
        
        NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
        NSString * oauth_token =[temp objectForKey:@"oauth_token"];
        
        if(oauth_token==NULL || [oauth_token isEqual:@""])
        {
            
            //            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlStr , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
            
            NSString *cartIdStr;
            
            cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlStr , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
            
//            NSLog(@"add cart With Login url %@", cartIdStr);
            //            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlStr , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
            
            NSURL *url = [NSURL URLWithString:cartIdStr];
            
            [SVProgressHUD show];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response,
                                                       NSData *data, NSError *connectionError)
             {
                 if (data.length > 0 && connectionError == nil)
                 {
                     //                     [HUD hide:YES];
                     NSDictionary *currentArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                     if ([[currentArray valueForKey:@"status"] integerValue] == 1)
                     {
                         /***
                          Add To Cart Event Satrt
                          ***/
                         NSMutableDictionary *addtocartDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                               [currentArray valueForKey:@"cartid"], kCartIdProperty,
                                                               nil];
                         [SH_TrackingUtility trackEventOfSpencerEvents:addToCartEvent eventProp:addtocartDict];
                         /***
                          Add To Cart Event End
                          ***/
                         
//                         inCartLbl.text = [NSString stringWithFormat:@"%@",[currentArray valueForKey:@"item_count"]];
                         
                         inCartLbl.text = [NSString stringWithFormat:@"%i", count1 ];
                         [counterDict setValue:[NSString stringWithFormat:@"%i", count1] forKey:[NSString stringWithFormat:@"%i", indexNumber]];
                         [[NSUserDefaults standardUserDefaults] setObject:counterDict forKey:@"counterDict"];
                         if ([inCartLbl.text integerValue] == 0)
                         {
                             inCartLbl.hidden = YES;
                         }
                         else
                         {
                             inCartLbl.hidden = NO;
                         }
                             
                         if ([[currentArray valueForKey:@"cartid"] integerValue] > 0)
                         {
                             [[NSUserDefaults standardUserDefaults] setObject:[currentArray valueForKey:@"cartid"] forKey:@"globalcartid"];
                         }
                         
                         
                         
                         NSMutableDictionary *innertDict = [[NSMutableDictionary alloc] initWithDictionary:[productDetailsDict valueForKey:@"data"]];
                         [innertDict setObject:[currentArray valueForKey:@"item_id"] forKey:@"cart_itemid"];
                         [productDetailsDict setObject:innertDict forKey:@"data"];
                         
                         [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", [currentArray valueForKey:@"item_id"]] forKey:@"productDetailsItemId"];
                         
                         appDele.bangeStr = [NSString stringWithFormat:@"%@",[currentArray valueForKey:@"cart_count"]];
                         bangeLbl.text = [NSString stringWithFormat:@"%@",[currentArray valueForKey:@"cart_count"]];
                         
                         //                         NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:rowSeletcedIs inSection:0];
                         //                         NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload, nil];
                         //                         [itemDetailsTblVew reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
                         
                         
                         
                         if ([bangeLbl.text integerValue] > 0)
                         {
                             bangeLbl.hidden = NO;
                         }
                         else
                         {
                             bangeLbl.hidden = YES;
                         }
                         [self.view addSubview:[[ToastAlert alloc] initWithText:[currentArray valueForKey:@"message"]]];
                         
                     }
                     else{
                         [self.view addSubview:[[ToastAlert alloc] initWithText:[currentArray valueForKey:@"message"]]];
                     }
                     [SVProgressHUD dismiss];
                     
                 }
                 else{
                     //                     [HUD hide:YES];
                     [SVProgressHUD dismiss];
                 }
             }];
        }
        else
        {
            
            [SVProgressHUD show];
            
            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlStr , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
            
//            NSLog(@"add cart With Login url %@", cartIdStr);
            
            NSDictionary *tempDict = [Webmethods AddtoCart_Login:cartIdStr];
            
            [SVProgressHUD dismiss];
            
            if ([[tempDict valueForKey:@"cartid"] integerValue] > 0)
            {
                [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"cartid"] forKey:@"globalcartid"];
            }
            
            //            [HUD hide:YES];
            
            
            if ([[tempDict valueForKey:@"status"] integerValue] == 1)
            {
                
                
                NSMutableDictionary *innertDict = [[NSMutableDictionary alloc] initWithDictionary:[productDetailsDict valueForKey:@"data"]];
                [innertDict setObject:[tempDict valueForKey:@"item_id"] forKey:@"cart_itemid"];
                [productDetailsDict setObject:innertDict forKey:@"data"];
                
                
                appDele.bangeStr = [NSString stringWithFormat:@"%@",[tempDict valueForKey:@"cart_count"]];
                bangeLbl.text = [NSString stringWithFormat:@"%@",[tempDict valueForKey:@"cart_count"]];
                inCartLbl.text = [NSString stringWithFormat:@"%i", count1];
                [counterDict setValue:[NSString stringWithFormat:@"%i", count1] forKey:[NSString stringWithFormat:@"%i", indexNumber]];
                [[NSUserDefaults standardUserDefaults] setObject:counterDict forKey:@"counterDict"];
                if ([inCartLbl.text integerValue] == 0)
                {
                    inCartLbl.hidden = YES;
                }
                else
                {
                    inCartLbl.hidden = NO;
                }
                
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", [tempDict valueForKey:@"item_id"]] forKey:@"productDetailsItemId"];
                if ([bangeLbl.text integerValue] > 0)
                {
                    bangeLbl.hidden = NO;
                }
                else
                {
                    bangeLbl.hidden = YES;
                }
                //                if ([sortStr isEqualToString:@"Search"])
                //                {
                //                    [self search];
                //                }
                //                else
                //                {
                //                    [self refreshCategory];
                //                }
                
                
                //                NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:rowSeletcedIs inSection:0];
                //                NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload, nil];
                //                [itemDetailsTblVew reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
                
                
                
                [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
            }
            else
            {
                [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
            }
            
        }
        
        
    }
    else
    {
        [SVProgressHUD show];
        storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        NSString *URL=[NSString stringWithFormat:@"%@/cart/update/?cart[%@]=%i&store=%@", baseUrl1, _inCartStr, count1, storeIdStr];
        
        NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
        NSString * oauth_token =[temp objectForKey:@"oauth_token"];
        
        
        if(oauth_token==NULL || [oauth_token isEqual:@""])
        {
            //            @"cartid=%@"[[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]
            NSString *urlStr = [NSString stringWithFormat:@"%@&cartid=%@", URL, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
            NSURL *url = [NSURL URLWithString:urlStr];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response,
                                                       NSData *data, NSError *connectionError)
             {
                 if (data.length > 0 && connectionError == nil)
                 {
                     
                     
                     //                     [HUD hide:YES];
                     
                     
                     NSMutableDictionary *tempDict;
                     
                     
                     tempDict = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                     
                     [SVProgressHUD dismiss];
                     
                     //                     appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                     //                     bangeLbl.text = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                     //
                     //                     if ([bangeLbl.text integerValue] > 0)
                     //                     {
                     //                         bangeLbl.hidden = NO;
                     //                     }
                     //                     else
                     //                     {
                     //                         bangeLbl.hidden = YES;
                     //                     }
                     
                     
                     
                     if ([[tempDict valueForKey:@"cartid"] integerValue] > 0)
                     {
                         [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"cartid"] forKey:@"globalcartid"];
                     }
                     
                     
                     
                     
                     if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                     {
                         
                         appDele.bangeStr = [NSString stringWithFormat:@"%ld", (long)[[tempDict valueForKey:@"cart_count"] integerValue]];
                         bangeLbl.text = appDele.bangeStr;
                         
                         if (count1 == 0)
                         {
                             NSMutableDictionary *innertDict = [[NSMutableDictionary alloc] initWithDictionary:[productDetailsDict valueForKey:@"data"]];
                             [innertDict setObject:@"0" forKey:@"cart_itemid"];
                             [productDetailsDict setObject:innertDict forKey:@"data"];
                         }
//                         inCartLbl.text = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"item_count"]];
                         
                         inCartLbl.text = [NSString stringWithFormat:@"%i", count1 ];
                         
                         [counterDict setValue:[NSString stringWithFormat:@"%i", count1] forKey:[NSString stringWithFormat:@"%i", indexNumber]];
                         [[NSUserDefaults standardUserDefaults] setObject:counterDict forKey:@"counterDict"];
                         if ([inCartLbl.text integerValue] == 0)
                         {
                             inCartLbl.hidden = YES;
                         }
                         else
                         {
                             inCartLbl.hidden = NO;
                         }
                         
                         
                         if ([bangeLbl.text integerValue] > 0)
                         {
                             bangeLbl.hidden = NO;
                         }
                         else
                         {
                             bangeLbl.hidden = YES;
                         }
                         [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                         
                     }
                     else
                     {
                         [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                         [SVProgressHUD dismiss];
                     }
                     
                 }
             }];
        }
        else
        {
            
            [SVProgressHUD show];
            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", URL , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
            NSDictionary *tempDict = [Webmethods updateItemFromCart:cartIdStr];
            
            [SVProgressHUD dismiss];
            
            //            [HUD hide:YES];
            
            if ([[tempDict valueForKey:@"status"] integerValue] == 1)
            {
                
                
                inCartLbl.text = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"item_count"]];
                
                if ([inCartLbl.text integerValue] == 0)
                {
                    inCartLbl.hidden = YES;
                }
                else
                {
                    inCartLbl.hidden = NO;
                }
                
                [counterDict setValue:[NSString stringWithFormat:@"%i", count1] forKey:[NSString stringWithFormat:@"%i", indexNumber]];
                [[NSUserDefaults standardUserDefaults] setObject:counterDict forKey:@"counterDict"];
                appDele.bangeStr = [NSString stringWithFormat:@"%ld", (long)[[tempDict valueForKey:@"cart_count"] integerValue]];
                bangeLbl.text = appDele.bangeStr;
                
                if (count1 == 0)
                {
                    NSMutableDictionary *innertDict = [[NSMutableDictionary alloc] initWithDictionary:[productDetailsDict valueForKey:@"data"]];
                    [innertDict setObject:@"0" forKey:@"cart_itemid"];
                    [productDetailsDict setObject:innertDict forKey:@"data"];
                }
                
                
                //                NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:rowSeletcedIs inSection:0];
                //                NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload, nil];
                //                [itemDetailsTblVew reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
                
                
                if ([bangeLbl.text integerValue] > 0)
                {
                    bangeLbl.hidden = NO;
                }
                else
                {
                    bangeLbl.hidden = YES;
                }
                [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
            }
            else
            {
                [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                
            }
            
            
            
        }
        
    }
    
}



- (IBAction)backBtnAct:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
//    if (pushedFlag == 1)
//    {
//        [self dismissViewControllerAnimated:YES completion:nil];
////        BOOL flag = NO;
////        for (UIViewController *controller in self.navigationController.viewControllers)
////        {
////            if ([controller isKindOfClass:[ProductVC class]])
////            {
////                flag = YES;
////                [self.navigationController popToViewController:controller animated:NO];
////                break;
////            }
////        }
////        if (flag == NO)
////        {
////            ProductVC * productVC=[[ProductVC alloc] initWithNibName:@"ProductVC" bundle:nil];
////            [self.navigationController pushViewController:productVC animated:NO];
////        }
//    }
//    else if (pushedFlag == 2)
//    {
//        [self dismissViewControllerAnimated:YES completion:nil];
////        BOOL flag = NO;
////        for (UIViewController *controller in self.navigationController.viewControllers)
////        {
////            if ([controller isKindOfClass:[SearchListVC class]])
////            {
////                flag = YES;
////                [self.navigationController popToViewController:controller animated:NO];
////                //break;
////            }
////        }
////        if (flag == NO)
////        {
////            SearchListVC * searchListVC=[[SearchListVC alloc]initWithNibName:@"SearchListVC" bundle:nil];
////            [self.navigationController pushViewController:searchListVC animated:NO];
////        }
//    }
    [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark SearchBar

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchVC = [[SearchVC alloc] initWithNibName:@"SearchVC" bundle:nil];
    [self.navigationController pushViewController:searchVC animated:NO];
    [searchBar1 resignFirstResponder];
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

#pragma mark - UIScrollViewDelegate methods
    
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return Product_img;
}
    
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
