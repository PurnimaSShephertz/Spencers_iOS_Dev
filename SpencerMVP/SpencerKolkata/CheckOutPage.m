//
//  CheckOutPage.m
//  Spencer
//
//  Created by Binary Semantics on 7/8/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "CheckOutPage.h"
#import "Webmethods.h"
#import "Const.h"
#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "SVProgressHUD.h"
#import "OrderReviewVC.h"
#import "CategoryPage.h"
#import "MyProfileVC.h"
#import "OfferVC.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"
#import "OrderedDictionary.h"
#import "ProductVC.h"
#import "SH_TrackingUtility.h"


@interface CheckOutPage ()
{
    OrderReviewVC * ordervc;
    CategoryPage*Categoryvc;
    NSString *billingAddressStr;
    AppDelegate *appDele;
    int addressSelectionIndex;
    int leftPickerIndex, rightPickerIndex;
    
    ProductVC *productVC;
}
@end

@implementation CheckOutPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.screenName = @"CheckOut Screen";
    
    leftPickerIndex = 0;
    rightPickerIndex = 0;
    Deliveryslot_lbl.text = @"Select Preferred Delivery Slot";
    
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //seconds
    lpgr.delegate = self;
    [AddressTable_View addGestureRecognizer:lpgr];
    
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Getslot_index"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Getslot_index"];
    // Do any additional setup after loading the view from its nib.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    addressSelectionIndex = (int)indexPath.row;
    [AddressTable_View reloadData];
    
    [[NSUserDefaults standardUserDefaults] setValue:[[GetAllAddress_Array objectAtIndex:addressSelectionIndex] valueForKey:@"entity_id"] forKey:@"Billingaddress_ID"];
    
    
    [[NSUserDefaults standardUserDefaults] setValue:[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"postcode"] forKey:@"pin"];
    
//    AddressCustCell *selectedCell = (AddressCustCell *)[Address_TableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:AddressTable_View];
    
    NSIndexPath *indexPath = [AddressTable_View indexPathForRowAtPoint:p];
    if (indexPath == nil) {
//        NSLog(@"long press on table view but not on a row");
    } else if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
//        NSLog(@"long press on table view at row %ld", indexPath.row);
        addressSelectionIndex = (int)indexPath.row;
        [AddressTable_View reloadData];
    } else {
//        NSLog(@"gestureRecognizer.state = %ld", gestureRecognizer.state);
    }
}

-(void)getaddressBook
{
    
    
    billingAddressStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"Billingaddress"];
    
    
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating123) toTarget:self withObject:nil];
    NSString * URL=[NSString stringWithFormat:@"%@/customers/%@/addresses", baseUrl1, [[DictFinal valueForKey:@"data"]valueForKey:@"customerid"]];
    //GetAllAddress_Array=[[NSMutableArray alloc]initWithObjects:@"ejwfhwefhowefhiowefhiowefhiofheiowfhiowefhowefh jwebfuwegfiuwefguw bfwebfwuebf",@"wehowefhiouwef uehfbefufgef iu fqef ",@"hohwofhwohw hiwehfoiwhef bniowehf",@"hohwofhwohw hiwehfoiwhef bniowehf",@"hohwofhwohw hiwehfoiwhef bniowehf",@"hohwofhwohw hiwehfoiwhef bniowehf",@"hohwofhwohw hiwehfoiwhef bniowehf",@"hohwofhwohw hiwehfoiwhef bniowehf",@"hohwofhwohw hiwehfoiwhef bniowehf", nil];
    GetAllAddress_Array=[Webmethods GetAll_Address:URL];
    
    
    
    if (GetAllAddress_Array.count > 0)
    {
        [[NSUserDefaults standardUserDefaults] setValue:[[GetAllAddress_Array objectAtIndex:0] valueForKey:@"entity_id"] forKey:@"Billingaddress_ID"];
        
        
        [pagescroll setContentSize:CGSizeMake(ScreenWidth, GetAllAddress_Array.count*97+ 150)];
        AddressTable_View.frame=CGRectMake(0, Deliveryslot_lbl.frame.origin.y+ Deliveryslot_lbl.frame.size.height+1, pagescroll.frame.size.width, GetAllAddress_Array.count+30*97);
        
        
        [AddressTable_View reloadData];
        [AddressTable_View setDelegate:self];
        [AddressTable_View setDataSource:self];
        
    }
    
    [SVProgressHUD dismiss];
    
    
    
    
        
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:UIKeyboardWillShowNotification
//                                                  object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:UIKeyboardWillHideNotification
//                                                  object:nil];
}
- (IBAction)backBtnAct:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view endEditing:YES];
    
    
    
    
    self.navigationController.navigationBar.hidden = NO;
    
    billingAddressStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"Billingaddress"];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
//                                                 name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
//                                                 name:UIKeyboardWillHideNotification object:nil];
    
    

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
    
    [slot_Picker_View setHidden:YES];
    [Addaddressview setHidden:YES];
    [[IQKeyboardManager sharedManager] setEnable:FALSE];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:FALSE];
    ScreenWidth= [UIScreen mainScreen].bounds.size.width;
    DictFinal=[[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"];
    [self getaddressBook];
    if ([GetAllAddress_Array count] > 0)
    {
        [[NSUserDefaults standardUserDefaults] setValue:[[GetAllAddress_Array objectAtIndex:0]valueForKey:@"postcode"] forKey:@"pin"];
    }
    
    ConfirmAll_Obj.layer.cornerRadius=23.0;
    ConfirmAll_Obj.layer.masksToBounds=YES;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSDictionary * Slots_dict=  [Webmethods GetSlots];
        
        
        
        
        
        
        fetch_Dict = [[NSMutableArray alloc] initWithArray:[[Slots_dict valueForKey:@"data"] allKeys]];
        
        
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MM-yyyy"];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        // fast enumeration of the array
        for (NSString *dateString in fetch_Dict) {
            NSDate *date = [formatter dateFromString:dateString];
            [tempArray addObject:date];
        }
        
        // sort the array of dates
        [tempArray sortUsingComparator:^NSComparisonResult(NSDate *date1, NSDate *date2) {
            // return date2 compare date1 for descending. Or reverse the call for ascending.
            return [date2 compare:date1];
        }];
        
//        NSLog(@"%@", tempArray);

        
        
        NSMutableArray *correctOrderStringArray = [NSMutableArray array];
        
        for (NSDate *date in tempArray) {
            NSString *dateString = [formatter stringFromDate:date];
            [correctOrderStringArray addObject:dateString];
        }
        
//        NSLog(@"%@", correctOrderStringArray);
        
        fetch_Dict=[[[correctOrderStringArray reverseObjectEnumerator] allObjects] mutableCopy];

        
//        NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
//        
//        NSArray *sorters = [[NSArray alloc] initWithObjects:sorter, nil];
        
//        NSArray *sortedArray = [fetch_Dict sortedArrayUsingDescriptors:sorters];
//        NSLog(@"sortedArray %@", sortedArray);
//        fetch_Dict = [[NSMutableArray alloc] initWithArray:sortedArray];
        
        reloadarray=[[NSMutableArray alloc]init];
        reloadmainArr=[[NSMutableArray alloc]init];
        
        finalarr = [[NSMutableArray alloc]init];
        
        NSMutableArray *tempKeyArr = [[NSMutableArray alloc] init];
        
        for (int i=0; i<fetch_Dict.count ; i++)
        {
//            [finalarr3 removeAllObjects];
//            [fetchID_Arry removeAllObjects];
            fetchID_Arry=[[NSMutableArray alloc]init];
            finalarr3 = [[NSMutableArray alloc]init];
            
            
            
            NSDictionary *temparr = [[Slots_dict valueForKey:@"data"] valueForKey:[fetch_Dict objectAtIndex:i]];
            NSSortDescriptor *sorter1 = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
            NSArray *sorters1 = [[NSArray alloc] initWithObjects:sorter1, nil];
            NSArray *sortedArray1 = [[temparr allKeys] sortedArrayUsingDescriptors:sorters1];
            
            
            
            NSArray *allKeysArr = [Slots_dict valueForKey:@"slotTime"];
            
            for (int j = 0; j < [allKeysArr count]; j ++)
            {
                
                
                if ([[[temparr valueForKey:[allKeysArr objectAtIndex:j]] valueForKey:@"is_active"] integerValue] == 1)
                {
                    [finalarr3 addObject:[allKeysArr objectAtIndex:j]];
                    [fetchID_Arry addObject:[[temparr valueForKey:[allKeysArr objectAtIndex:j]] valueForKey:@"id"]];
                }
                
                
                
            }
            if (finalarr3.count > 0)
            {
                [tempKeyArr addObject:[fetch_Dict objectAtIndex:i]];
                [reloadarray addObject:finalarr3];
                [finalarr addObject:fetchID_Arry];
//
            }
            
        }
        
        fetch_Dict  = [[NSMutableArray alloc] initWithArray:tempKeyArr];
        if (finalarr.count > 0)
        {
            [[NSUserDefaults standardUserDefaults] setValue:[[finalarr objectAtIndex:leftPickerIndex] objectAtIndex:0] forKey:@"Sloat_ID_Str"];
        }
       

        self.picker.dataSource = self;
        self.picker.delegate = self;
        self.picker2.dataSource = self;
        self.picker2.delegate = self;
        
    });
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [textView setInputAccessoryView:[self getTextFieldAccessoryView]];
    
    return YES;
}
-(UIView *)getTextFieldAccessoryView
{
    //create your own custom view here...
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:
                           
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButton:)],
                           nil];
    [numberToolbar sizeToFit];
    return numberToolbar;
}

-(void)doneButton:(id)sender
{
    [self.view endEditing:YES];
    [Addaddressview setHidden:YES];
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating123) toTarget:self withObject:nil];
    NSString * URL=[NSString stringWithFormat:@"%@/customers/%@/addresses", baseUrl1, [[DictFinal valueForKey:@"data"]valueForKey:@"customerid"]];
   // NSMutableArray * street_Array=[[NSMutableArray alloc] initWithObjects:@"ABC",@"BZA", nil];
    NSDictionary * dict=   [Webmethods Addaddress:URL andDict:AddtesstextView.text andLastName:@"" andcity:@"" andregion:@"" andpostcode:@"" andcountry_id:@"IN" andtelephone:@"" andstreet:nil];
    
    
    if ([[dict valueForKey:@"status"] integerValue]==0)
    {
            [SVProgressHUD dismiss];
//        [self.view addSubview:[[ToastAlert alloc] initWithText:[[dict valueForKey:@"message"] objectAtIndex:0]]];
        return ;
    }
    if ([[[[dict valueForKey:@"messages"]valueForKey:@"error"]objectAtIndex:0]valueForKey:@"message"]!=nil)
    {
        [SVProgressHUD dismiss];
        return;
    }
    else
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:[dict valueForKey:@"message"]]];
        [self getaddressBook];
        
        
    }
    AddtesstextView.text=@"";
}

-(void)threadStartAnimating123
{
    [SVProgressHUD show];
}

- (IBAction)Billing_Next_butObj:(id)sender
{
    BOOL reach = [Webmethods checkNetwork];
    
    if (reach == NO)
    {
        return ;
    }
    
    
    if ([GetAllAddress_Array count] == 0)
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Billing Address Empty"]];
    }
    else
    {
        
        [SVProgressHUD show];
        NSString *pincodeStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"pin"];
        
        NSString *pincheckStr = [NSString stringWithFormat:@"%@/validate/pincode?pincode=%@", baseUrl1 , pincodeStr];
        
      //  PinCheck_URL = [NSURL URLWithString:pincheckStr];
//        
//        
         //   [SVProgressHUD show];
        
        
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO)
        {
            return ;
        }
        [SVProgressHUD show];
      
         NSUserDefaults *temp1=[NSUserDefaults standardUserDefaults];
         oauth_token =[temp1 objectForKey:@"oauth_token"];
         oauth_token_secret =[temp1 objectForKey:@"oauth_token_secret"];

        AFOAuth1Client *oAuth1Client;
        
        oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
        
        [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
        
        [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
        [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
        [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
        
        NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", pincheckStr] parameters:nil];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
       // [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSError *jsonError = nil;
             [SVProgressHUD dismiss];
             id tempDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
             
             
             
             
            // NSDictionary *tempDict = [Webmethods pin:pincheckStr];
             
             if ([[tempDict valueForKey:@"status"] integerValue] == 1)
             {
                 
                 [SVProgressHUD dismiss];
                 
                 NSString * storeID=[[tempDict valueForKey:@"data"] valueForKey:@"store_id"];
                 if ([storeID isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"]])
                 {
                     if ([Deliveryslot_lbl.text length] > 1)
                     {
                         if ([Deliveryslot_lbl.text isEqualToString:@"Select Preferred Delivery Slot"])
                         {
                             [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please select delivery slot"]];
                         }
                         else
                         {
                             ordervc=[[OrderReviewVC alloc]initWithNibName:@"OrderReviewVC" bundle:nil];
                             [self.navigationController pushViewController:ordervc animated:NO];
                         }
                         
                     }
                     else
                     {
                         [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please select delivery slot"]];
                     }
                     
                     if (GetAllAddress_Array.count < 1)
                     {
                         [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please add new address"]];
                     }
                 }
                 else
                 {
                     [[[UIAlertView alloc] initWithTitle:@"spencer's" message:@"The selected address is not serviced by the selected location. Please select alternate address or create new address." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
                     [SVProgressHUD dismiss];
                     return ;
                 }
                 
             }
             else
             {
                 
                 
                 [[[UIAlertView alloc] initWithTitle:@"spencer's" message:@"The selected address is not serviced by the selected location. Please select alternate address or create new address." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
                 [SVProgressHUD dismiss];
                 return ;
                 
             }
             [SVProgressHUD dismiss];
         }
         
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
//            NSLog(@"Error: %@", error);
            [SVProgressHUD dismiss];
        
        }];
        [operation start];

            
        
        
            
//            NSDictionary *tempDict = [Webmethods pin:pincheckStr];
//            
//            if ([[tempDict valueForKey:@"status"] integerValue] == 1)
//            {
//                
//                [SVProgressHUD dismiss];
//                
//                NSString * storeID=[[tempDict valueForKey:@"data"] valueForKey:@"store_id"];
//                
//                if ([storeID isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"]])
//                {
//                    if ([Deliveryslot_lbl.text length] > 1)
//                    {
//                        if ([Deliveryslot_lbl.text isEqualToString:@"Select Preferred Delivery Slot"])
//                        {
//                            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please select delivery slot"]];
//                        }
//                        else
//                        {
//                            ordervc=[[OrderReviewVC alloc]initWithNibName:@"OrderReviewVC" bundle:nil];
//                            [self.navigationController pushViewController:ordervc animated:NO];
//                        }
//                        
//                    }
//                    else
//                    {
//                        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please select delivery slot"]];
//                    }
//                    
//                    if (GetAllAddress_Array.count < 1)
//                    {
//                        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please add new address"]];
//                    }
//                }
//                else
//                {
//                    [[[UIAlertView alloc] initWithTitle:@"spencer's" message:@"The selected address is not serviced by the selected location. Please select alternate address or create new address." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
//                    [SVProgressHUD dismiss];
//                    return ;
//                }
//                
//            }
//            else
//            {
//                
//                
//                [[[UIAlertView alloc] initWithTitle:@"spencer's" message:@"The selected address is not serviced by the selected location. Please select alternate address or create new address." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
//                [SVProgressHUD dismiss];
//                return ;
//                
//            }
//            [SVProgressHUD dismiss];
        
            
            //            NSURLRequest *request = [NSURLRequest requestWithURL:PinCheck_URL];
            //            [NSURLConnection sendAsynchronousRequest:request
            //                                               queue:[NSOperationQueue mainQueue]
            //                                   completionHandler:^(NSURLResponse *response,
            //                                                       NSData *data, NSError *connectionError)
            //             {
            //                 if (data.length > 0 && connectionError == nil)
            //                 {
            //                     NSMutableDictionary *tempDict;
            //                     tempDict = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
            //
            //
            //
            //                 }
            //             }];
       
        
        
    }
    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Sloat_ID_Str"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SloatDate_str"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Title_str"];
    
    
}




-(IBAction)Confirm_All_Act:(id)sender
{
    [self Billing_Next_butObj:sender];
    
//    orderReviewVC = [[OrderReviewVC alloc] initWithNibName:@"OrderReviewVC" bundle:nil];
//    [self.navigationController pushViewController:orderReviewVC animated:NO]
//    []
//    [slot_Picker_View setHidden:YES];
//    [Addaddressview setHidden:YES];
//    [Start_view1 setHidden:YES];
//    if ([Deliveryslot_lbl.text length] > 1)
//    {
//        if ([Deliveryslot_lbl.text isEqualToString:@"Select Preferred Delivery Slot"])
//        {
//            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please select delivery slot"]];
//        }
//        else
//        {
//            ordervc=[[OrderReviewVC alloc]initWithNibName:@"OrderReviewVC" bundle:nil];
//            [self.navigationController pushViewController:ordervc animated:NO];
//        }
//        
//    }
//    else
//    {
//        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please select delivery slot"]];
//    }
//    
//    if (GetAllAddress_Array.count < 1)
//    {
//        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please add new address"]];
//    }
    
}
-(IBAction)Edit_Deliveryslot_Act:(id)sender
{
    if (fetch_Dict.count > 0 && reloadarray.count > 0)
    {
        [slot_Picker_View setHidden:NO];
        [Addaddressview setHidden:YES];
    }
    
    
}
-(IBAction)Done_Act:(id)sender
{
    [slot_Picker_View setHidden:YES];
    
//    NSString *YourselectedTitle = [fetch_Dict objectAtIndex:[_picker selectedRowInComponent:0]];
    
    
    
    NSInteger highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"Getslot_index"];
    
    NSArray *tempArr = [reloadarray objectAtIndex:leftPickerIndex];
    if ([tempArr count] > rightPickerIndex)
    {
        Deliveryslot_lbl.text = [NSString stringWithFormat:@"%@,%@",[fetch_Dict objectAtIndex:leftPickerIndex],[[reloadarray objectAtIndex:leftPickerIndex] objectAtIndex:rightPickerIndex]];
        [[NSUserDefaults standardUserDefaults] setValue:[[finalarr objectAtIndex:leftPickerIndex] objectAtIndex:rightPickerIndex] forKey:@"Sloat_ID_Str"];
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", [fetch_Dict objectAtIndex:leftPickerIndex]] forKey:@"SloatDate_str"];
    }
    else
    {
        Deliveryslot_lbl.text = [NSString stringWithFormat:@"%@,%@",[fetch_Dict objectAtIndex:leftPickerIndex],[[reloadarray objectAtIndex:leftPickerIndex] objectAtIndex:0]];
        [[NSUserDefaults standardUserDefaults] setValue:[[finalarr objectAtIndex:leftPickerIndex] objectAtIndex:0] forKey:@"Sloat_ID_Str"];
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", [fetch_Dict objectAtIndex:leftPickerIndex]] forKey:@"SloatDate_str"];
    }
    
    
    
//    NSArray *dateArr = [[relo objectAtIndex:0] componentsSeparatedByString:@"-"];
    
//    [[NSUserDefaults standardUserDefaults] setValue:[fetchID_Arry objectAtIndex:0] forKey:@"Sloat_ID_Str"];
    
    /***
        Delivery Slot Selection event satrt
     ***/
    
    NSMutableDictionary *orderConfirmationDict = [[NSMutableDictionary alloc] initWithDictionary:appDele.orderConfirmationDict];
    [orderConfirmationDict setObject:Deliveryslot_lbl.text forKey:@"deliverySchedule"];
    appDele.orderConfirmationDict = orderConfirmationDict;
    
    
    NSMutableDictionary *deliverySlotDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                             [fetch_Dict objectAtIndex:leftPickerIndex], kDateProperty,
                                             [[reloadarray objectAtIndex:leftPickerIndex] objectAtIndex:0], kTimeProperty,
                                             [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], kCartIdProperty,
                                             [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"], kStoreIdProperty,
                                             nil];
    [SH_TrackingUtility trackEventOfSpencerEvents:deliverySlotSelectionEvent eventProp:deliverySlotDict];
    
    /***
        Delivery Slot Selection event end
     ***/
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    if ([thePickerView isEqual: _picker])
    {
        return fetch_Dict.count;
    }
    else if ([thePickerView isEqual: _picker2])
    {
        NSArray *tempArr;
        if (reloadarray.count > 0)
        {
            tempArr = [reloadarray objectAtIndex:leftPickerIndex];
        }
        return [tempArr count];
    }
    return 0;
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
        tView.textColor=[UIColor colorWithRed: 0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
        //[tView setBackgroundColor:[UIColor colorWithRed: 237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0]];
        [tView setMinimumScaleFactor:12];
        [tView setTextAlignment:NSTextAlignmentCenter];
        tView.numberOfLines=3;
    }
    // Fill the label text here
    NSString *pickerTitle = @"";
    if (pickerView == _picker)
    {
        tView.text =  [fetch_Dict objectAtIndex:row];
        //assigns the country title if pickerView is countryPicker
    }
    else if (pickerView == _picker2)
    {
        
        NSArray *tempArr = [reloadarray objectAtIndex:leftPickerIndex];
        tView.text = [tempArr objectAtIndex:row];
//        tView.text =  [NSString stringWithFormat:@"%ld", (long)row];
        //assigns the region title if pickerView is regionPicker
    }
    return tView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == _picker)
    {
        
//        [reloadmainArr removeAllObjects];
//        NSArray *tempArr = [reloadarray objectAtIndex:row];
//        for (int j=0; j<[tempArr count]; j++)
//        {
//            //            NSString *str = [[[[reloadarray objectAtIndex:i] objectAtIndex:j] allKeys] objectAtIndex:0];
//            //
////            [reloadmainArr addObject:[reloadarray objectAtIndex:row]];
//            
//            //
//        }
        
        leftPickerIndex = row;
//        rightPickerIndex = 0;
        
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", [fetch_Dict objectAtIndex:row]] forKey:@"SloatDate_str"];
        
        [[NSUserDefaults standardUserDefaults]setInteger:row forKey:@"Getslot_index"];
        
//        [[NSUserDefaults standardUserDefaults] setValue:[reloadmainArr objectAtIndex:row] forKey:@"SloatDate_str"];
        self.picker2.dataSource = self;
        self.picker2.delegate = self;
        [_picker2 reloadAllComponents];
    }
    else if (pickerView == _picker2)
    {
        rightPickerIndex = row;
        [[NSUserDefaults standardUserDefaults] setValue:[[finalarr objectAtIndex:leftPickerIndex] objectAtIndex:row] forKey:@"Sloat_ID_Str"];
        [[NSUserDefaults standardUserDefaults]setInteger:row forKey:@"Getslot_index"];
    }
}


-(IBAction)addnewAddress_Act:(id)sender
{
//    [Addaddressview setHidden:NO];
//    [slot_Picker_View setHidden:YES];
//    [AddtesstextView becomeFirstResponder];
//    AddtesstextView.text=@"";
    
    appDele.addressIndex = -1;
    AddressVC * Addressvc;
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
        Addressvc = [[AddressVC alloc]initWithNibName:@"AddressVC" bundle:nil];
//    }
//    else
//    {
//        Addressvc = [[AddressVC alloc]initWithNibName:@"AddressVC~iPad" bundle:nil];
//    }
    
    Addressvc.addressbookcheck=@"006";
    [self.navigationController pushViewController:Addressvc animated:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return GetAllAddress_Array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    AddressCustCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"AddressCustCell" owner:self options:nil];
        cell = _distcel;
    }
    UIImageView *seperatorImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 96, ScreenWidth-20, 1)];
    seperatorImg.backgroundColor = kColor_gray;
    [cell addSubview:seperatorImg];
    NSMutableString *newArray = [[NSMutableString alloc] init];
    
    if ([[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"firstname"] isKindOfClass:[NSString class]])
    {
        
        NSMutableString *newArray1 = [NSMutableString stringWithFormat:@"%@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"firstname"]];
        if ([newArray1 length] > 0 && (![newArray1 isEqualToString:@"(null)"]))
        {
            [newArray appendFormat:@"%@",newArray1];
        }
        
    }
    if ([[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"lastname"] isKindOfClass:[NSString class]])
    {
        NSMutableString *newArray1 = [NSMutableString stringWithFormat:@"%@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"lastname"]];
        if ([newArray1 length] > 0 && (![newArray1 isEqualToString:@"(null)"]))
        {
            [newArray appendFormat:@" %@ ,",newArray1];
        }
    }
    if ([[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"street"] isKindOfClass:[NSArray class]])
    {
        NSMutableString *newArray1 = [NSMutableString stringWithFormat:@"%@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"street"]];
        if ([newArray1 length] > 0 && (![newArray1 isEqualToString:@"(null)"]))
        {
            //            [newArray appendFormat:@" ,%@",newArray1];
        }
        
        NSArray *arr = [[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"street"];
        if ([arr count]==1)
        {
            [newArray appendFormat:@"\r%@",[[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"street"] objectAtIndex:0]];
        }
        else if ([arr count]==2)
        {
            [newArray appendFormat:@"\r%@ ,%@",[[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"street"] objectAtIndex:0], [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"street"] objectAtIndex:1]];
        }
        
    }
    if ([[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"city"] isKindOfClass:[NSString class]])
    {
        NSMutableString *newArray1 = [NSMutableString stringWithFormat:@"%@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"city"]];
        if ([newArray1 length] > 0 && (![newArray1 isEqualToString:@"(null)"]))
        {
            [newArray appendFormat:@" ,%@",newArray1];
        }
        
    }
    if ([[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"postcode"] isKindOfClass:[NSString class]])
    {
        NSMutableString *newArray1 = [NSMutableString stringWithFormat:@"%@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"postcode"]];
        if ([newArray1 length] > 0 && (![newArray1 isEqualToString:@"(null)"]))
        {
            [newArray appendFormat:@" ,%@ ,",newArray1];
        }
        
    }
    if ([[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"region"] isKindOfClass:[NSString class]])
    {
        NSMutableString *newArray1 = [NSMutableString stringWithFormat:@"%@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"region"]];
        if ([newArray1 length] > 0 && (![newArray1 isEqualToString:@"(null)"]))
        {
            [newArray appendFormat:@"\r%@",newArray1];
        }
        
    }
    if ([[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"telephone"] isKindOfClass:[NSString class]])
    {
        NSMutableString *newArray1 = [NSMutableString stringWithFormat:@"%@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"telephone"]];
        if ([newArray1 length] > 0 && (![newArray1 isEqualToString:@"(null)"]))
        {
            [newArray appendFormat:@" ,%@",newArray1];
        }
        
    }
    
    
    cell.Address_lbl.text=newArray;
//    cell.Address_lbl.text=[GetAllAddress_Array objectAtIndex:indexPath.row];
    cell.Delete_obj.tag=indexPath.row;
    cell.Edir_obj.tag=indexPath.row;
    cell.Address_lbl.numberOfLines=4;
    cell.selectionBtnObj.tag = indexPath.row;
//    if ([billingAddressStr length] < 1)
//    {
//        
//    }
//    else
//    {
//        cell.Address_lbl.text = billingAddressStr;
//    }
    
    
    if (indexPath.row == addressSelectionIndex)
    {
        cell.selectionBtnObj.hidden = NO;
        cell.Delete_obj.hidden = YES;
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        [cell.bgImgVew setBackgroundColor:[UIColor whiteColor]];
        
        NSMutableDictionary *orderConfirmationDict = [[NSMutableDictionary alloc] initWithDictionary:appDele.orderConfirmationDict];
        [orderConfirmationDict setObject:newArray forKey:@"deliveryAddress"];
        appDele.orderConfirmationDict = orderConfirmationDict;
        
//        [cell.selectionBtnObj setImage:[UIImage imageNamed:@"ic_tick.png"] forState:UIControlStateNormal];
    }
    else
    {
        cell.selectionBtnObj.hidden = YES;
        cell.Delete_obj.hidden = NO;
        [cell.bgImgVew setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 97;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0)
    {
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.frame = CGRectMake(18, 8, ScreenWidth, 20);
    myLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    myLabel.textColor=[UIColor colorWithRed: 83/255.0 green:88/255.0 blue:95/255.0 alpha:1.0];
    [myLabel setBackgroundColor:[UIColor clearColor]];
    myLabel.text = @"Addresses";
    
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, ScreenWidth, 40);
    headerView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    [headerView addSubview:myLabel];
    
    return headerView;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
    return footer;
}
-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40; //play around with this value
}
-(IBAction)Deleteaddress_Act:(UIButton*)sender
{
    if (GetAllAddress_Array.count > 1)
    {
        selectedTag = sender.tag;
        selectedEntity_Id = [[GetAllAddress_Array objectAtIndex:selectedTag] valueForKey:@"entity_id"];
        
        alertView1 = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Do you want to delete this address?" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        alertView1.tag = 1;
        [alertView1 show];
    }
    else
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Default address cannot be deleted"]];
    }
    
}
-(IBAction)EditAddress_Act:(UIButton*)sender
{
    
    appDele.addressIndex = (int)sender.tag;
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:AddressTable_View];
    NSIndexPath *indexPath = [AddressTable_View indexPathForRowAtPoint:buttonPosition];
    AddressCustCell *customCell = (AddressCustCell*)[AddressTable_View cellForRowAtIndexPath:indexPath];
    NSString *labelText = [[customCell Address_lbl] text];
    AddtesstextView.text=labelText;
    [Addaddressview setHidden:NO];
    [slot_Picker_View setHidden:YES];
//    [AddtesstextView becomeFirstResponder];
    
    
    
    AddressVC * Addressvc;
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
        Addressvc = [[AddressVC alloc]initWithNibName:@"AddressVC" bundle:nil];
//    }
//    else
//    {
//        Addressvc = [[AddressVC alloc]initWithNibName:@"AddressVC~iPad" bundle:nil];
//    }
    
    Addressvc.addressbookcheck=@"007";
    [self.navigationController pushViewController:Addressvc animated:NO];
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
    {
        if (buttonIndex == 0)
        {
            [NSThread detachNewThreadSelector:@selector(threadStartAnimating123) toTarget:self withObject:nil];
            BOOL reach = [Webmethods checkNetwork];
            if (reach == NO)
            {
                return ;
            }
        
           // [NSThread detachNewThreadSelector:@selector(threadStartAnimating22:) toTarget:self withObject:nil];
            
            NSString * Entity_ID= [[GetAllAddress_Array objectAtIndex:selectedTag] valueForKey:@"entity_id"];
            
            NSString * URL=[NSString stringWithFormat:@"%@/customers/addresses/%@", baseUrl1, Entity_ID];
            
            NSMutableDictionary *deleteAddress = [Webmethods DeleteAddress:URL];
            [self getaddressBook];
            [SVProgressHUD dismiss];
            [self.view addSubview:[[ToastAlert alloc]initWithText:[deleteAddress valueForKey:@"message"]]];
            
        }
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

- (IBAction)selectionBtnAct:(UIButton *)sender
{
    addressSelectionIndex = (int)sender.tag;
    [AddressTable_View reloadData];
}

- (void)didReceiveMemoryWarning
{
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
