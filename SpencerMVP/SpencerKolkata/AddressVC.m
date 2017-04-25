//
//  AddressVC.m
//  MeraGrocer
//
//  Created by Binary Semantics on 6/15/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import "AddressVC.h"
#import "Webmethods.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "ProductVC.h"
#import "MyProfileVC.h"
#import "IQKeyboardManager.h"
#import "MainCategoryVC.h"
#import "CategoryPage.h"
#import "Const.h"
#import "OfferVC.h"

@interface AddressVC ()
{
    AppDelegate *appDelegate;
    MainCategoryVC *mainCategoryVC;
    CategoryPage *Categoryvc;
    NSUserDefaults *temp;
    UILabel *bangeLbl;
    InCartVC *inCartVC;
    ProductVC * productVC;
    int addressTag;
}

@end

@implementation AddressVC
@synthesize addressCell;

-(void)threadStartAnimating2:(id)dat
{
    [SVProgressHUD show];
}
-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    [SVProgressHUD dismiss];
    [[IQKeyboardManager sharedManager] setEnable:FALSE];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:FALSE];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Addaddress"];
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch1 = [touches anyObject];
    CGPoint touchLocation = [touch1 locationInView:stateView];
    CGRect startRect = [[[stateView layer] presentationLayer] frame];
    CGRectContainsPoint(startRect, touchLocation);
    stateView.hidden = YES;
}

- (IBAction)backBtnAct:(UIButton *)sender
{
    if (addressTag == 10)
    {
        addressTag = 0;
        [AddView setHidden:YES];
        [EditView setHidden:YES];
        [Address_TableView setHidden: NO];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
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
    
    
    [titleLabelButton setTitle:@"Address Book" forState:UIControlStateNormal];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.screenName = @"Address Screen";
    
//    stateTblVew.scrollEnabled = NO;
    myStateBg.clipsToBounds = NO;
    myStateBg.layer.shadowColor = [[UIColor blackColor] CGColor];
    myStateBg.layer.shadowOffset = CGSizeMake(0,5);
    myStateBg.layer.shadowOpacity = 0.5;
    
    
    stateSelectionArr = [[NSMutableArray alloc] init];
    citySelectionArr = [[NSMutableArray alloc] init];
    stateView.hidden = YES;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    
    stateArr = [[NSArray alloc] initWithObjects:@"Delhi", @"Haryana", @"Uttar Pradesh", @"West Bengal", nil];
    
    cityArr = [[NSArray alloc] initWithObjects: @"Greater Noida", @"Gurgaon", @"Kolkata", @"New Delhi", @"Noida", nil];
    
    
    //self.screenName = @"Address Screen";
    
    Save_Butt.layer.cornerRadius = 25;
    Save_Butt.layer.masksToBounds = YES;
    Save_Butt.backgroundColor = kColor_Orange;
    
    
    cancelSaveBtnObj.layer.cornerRadius = 24;
    cancelSaveBtnObj.layer.masksToBounds = YES;
    cancelSaveBtnObj.backgroundColor = [UIColor clearColor];
    
    updateBtnObj.layer.cornerRadius = 22;
    updateBtnObj.layer.masksToBounds = YES;
    updateBtnObj.backgroundColor = kColor_Orange;
    
    
    cancelUpdateBtnObj.layer.cornerRadius = 22;
    cancelUpdateBtnObj.layer.masksToBounds = YES;
    cancelUpdateBtnObj.backgroundColor = [UIColor clearColor];
    
    
    field1.delegate = self;
    field2.delegate = self;
    field3.delegate = self;
    field4.delegate = self;
    field5.delegate = self;
    field6.delegate = self;
    field7.delegate = self;
    field8.delegate = self;
    field9.delegate = self;
    
    field11.delegate = self;
    field12.delegate = self;
    field13.delegate = self;
    field14.delegate = self;
    field15.delegate = self;
    field16.delegate = self;
    field17.delegate = self;
    field18.delegate = self;
    field19.delegate = self;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"LoginCheck"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"registrationpagecheck"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"profilecheck"];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"Addaddress"];
    
//    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
//    [keyBoardController addToolbarToKeyboard];
    [back_image setHidden:YES];
    [Address_TableView setHidden:YES];
    
    [[IQKeyboardManager sharedManager] setEnable:TRUE];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:TRUE];
    DictFinal=[[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"];
    
    
    if ([_addressbookcheck isEqualToString:@"006"])
    {
        [AddView setHidden:NO];
        [EditView setHidden:YES];
    }
    else if ([_addressbookcheck isEqualToString:@"007"])
    {
        [self getaddressBook];
        [AddView setHidden:YES];
        [EditView setHidden:NO];
    }
    else
    {
//        [self getaddressBook];
        [AddView setHidden:YES];
        [EditView setHidden:YES];
        
    }
//  [HUD show:YES];
    [footer_View setHidden:YES];
    [Add_button setHidden:YES];
    [addresssmall_img setHidden:YES];
    [YourAdded_lbl setHidden:YES];
    

            
    
    
    
            
            
            if ([_addressbookcheck isEqualToString:@"006"])
            {
                [AddView setHidden:NO];
                [EditView setHidden:YES];
            }
            else if ([_addressbookcheck isEqualToString:@"007"])
            {
                [AddView setHidden:YES];
                [EditView setHidden:NO];
            }
            else{
                [AddView setHidden:YES];
                [EditView setHidden:YES];
                
                BOOL reach = [Webmethods checkNetwork];
                if (reach == NO) {
                    return ;
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                     [NSThread detachNewThreadSelector:@selector(threadStartAnimating22:) toTarget:self withObject:nil];
                     [self getaddressBook];
                    [SVProgressHUD dismiss];
                });
               
            }
            [back_image setHidden:NO];
            [Address_TableView setHidden:YES];
            appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [Address_TableView setBackgroundView:nil];
            [Address_TableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_all.png"]]
             ];
            _bangeLbl.text = appDelegate.bangeStr;
            
            if ([_bangeLbl.text integerValue] > 0)
            {
                _bangeLbl.hidden = NO;
            }
            else
            {
                _bangeLbl.hidden = YES;
            }
            
            _bangeLbl.layer.cornerRadius = 12;
            _bangeLbl.layer.masksToBounds = YES;
            
            footerImg.backgroundColor = [UIColor colorWithRed:3.0/255.0 green:132.0/255.0 blue:36.0/255.0 alpha:1];
            [SVProgressHUD dismiss];
            [footer_View setHidden:NO];
            [Add_button setHidden:NO];
            [addresssmall_img setHidden:NO];
            [YourAdded_lbl setHidden:NO];
            [Address_TableView reloadData];
    
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        _addressbookLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
        YourAdded_lbl.font = [UIFont fontWithName:@"Helvetica" size:16];
        
        
        field1.font = [UIFont fontWithName:@"Helvetica" size:13];
        field2.font = [UIFont fontWithName:@"Helvetica" size:13];
        field3.font = [UIFont fontWithName:@"Helvetica" size:13];
        field4.font = [UIFont fontWithName:@"Helvetica" size:13];
        field5.font = [UIFont fontWithName:@"Helvetica" size:13];
        field6.font = [UIFont fontWithName:@"Helvetica" size:13];
        field7.font = [UIFont fontWithName:@"Helvetica" size:13];
        field8.font = [UIFont fontWithName:@"Helvetica" size:13];
        field9.font = [UIFont fontWithName:@"Helvetica" size:13];
        
        field11.font = [UIFont fontWithName:@"Helvetica" size:13];
        field12.font = [UIFont fontWithName:@"Helvetica" size:13];
        field13.font = [UIFont fontWithName:@"Helvetica" size:13];
        field14.font = [UIFont fontWithName:@"Helvetica" size:13];
        field15.font = [UIFont fontWithName:@"Helvetica" size:13];
        field16.font = [UIFont fontWithName:@"Helvetica" size:13];
        field17.font = [UIFont fontWithName:@"Helvetica" size:13];
        field18.font = [UIFont fontWithName:@"Helvetica" size:13];
        field19.font = [UIFont fontWithName:@"Helvetica" size:13];
        
        
        locationLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
    }
    else
    {
        _addressbookLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
        YourAdded_lbl.font = [UIFont fontWithName:@"Helvetica" size:20];
        
        
        field1.font = [UIFont fontWithName:@"Helvetica" size:17];
        field2.font = [UIFont fontWithName:@"Helvetica" size:17];
        field3.font = [UIFont fontWithName:@"Helvetica" size:17];
        field4.font = [UIFont fontWithName:@"Helvetica" size:17];
        field5.font = [UIFont fontWithName:@"Helvetica" size:17];
        field6.font = [UIFont fontWithName:@"Helvetica" size:17];
        field7.font = [UIFont fontWithName:@"Helvetica" size:17];
        field8.font = [UIFont fontWithName:@"Helvetica" size:17];
        field9.font = [UIFont fontWithName:@"Helvetica" size:17];
        
        field11.font = [UIFont fontWithName:@"Helvetica" size:17];
        field12.font = [UIFont fontWithName:@"Helvetica" size:17];
        field13.font = [UIFont fontWithName:@"Helvetica" size:17];
        field14.font = [UIFont fontWithName:@"Helvetica" size:17];
        field15.font = [UIFont fontWithName:@"Helvetica" size:17];
        field16.font = [UIFont fontWithName:@"Helvetica" size:17];
        field17.font = [UIFont fontWithName:@"Helvetica" size:17];
        field18.font = [UIFont fontWithName:@"Helvetica" size:17];
        field19.font = [UIFont fontWithName:@"Helvetica" size:17];
        
        
        locationLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
    }

    
    
    

    
    NSString *rstring = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_name_token"];
//    locationLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
    [locationLbl setText:rstring];
    
    
    
//    NSString *stringColor = @"#C1CDCD";
//    NSUInteger red, green, blue;
//    sscanf([stringColor UTF8String], "#%02X%02X%02X", &red, &green, &blue);
//    
//    UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
//    field1.layer.borderColor= color.CGColor;
//    field1.layer.borderWidth=1.0;
//    field2.layer.borderColor= color.CGColor;
//    field2.layer.borderWidth=1.0;
    
    
    
//    field1.layer.borderColor=[[appDelegate colorWithHexString:@"C1CDC1"]CGColor];
//    field2.layer.borderColor=[[appDelegate colorWithHexString:@"C1CDC1"]CGColor];
//    field3.layer.borderColor=[[appDelegate colorWithHexString:@"C1CDC1"]CGColor];
//    field4.layer.borderColor=[[appDelegate colorWithHexString:@"C1CDC1"]CGColor];
//    field5.layer.borderColor=[[appDelegate colorWithHexString:@"C1CDC1"]CGColor];
//    field6.layer.borderColor=[[appDelegate colorWithHexString:@"C1CDC1"]CGColor];
//    field7.layer.borderColor=[[appDelegate colorWithHexString:@"C1CDC1"]CGColor];
//    field8.layer.borderColor=[[appDelegate colorWithHexString:@"C1CDC1"]CGColor];
//    field9.layer.borderColor=[[appDelegate colorWithHexString:@"C1CDC1"]CGColor];
//    field11.layer.borderColor=[[appDelegate colorWithHexString:@"C1CDC1"]CGColor];
//    field12.layer.borderColor=[[appDelegate colorWithHexString:@"C1CDC1"]CGColor];
//    field13.layer.borderColor=[[appDelegate colorWithHexString:@"C1CDC1"]CGColor];
//    field14.layer.borderColor=[[appDelegate colorWithHexString:@"C1CDC1"]CGColor];
//    field15.layer.borderColor=[[appDelegate colorWithHexString:@"C1CDC1"]CGColor];
//    field16.layer.borderColor=[[appDelegate colorWithHexString:@"C1CDC1"]CGColor];
//    field17.layer.borderColor=[[appDelegate colorWithHexString:@"C1CDC1"]CGColor];
//    field18.layer.borderColor=[[appDelegate colorWithHexString:@"C1CDC1"]CGColor];
//    field19.layer.borderColor=[[appDelegate colorWithHexString:@"C1CDC1"]CGColor];
    

//     field1.layer.borderWidth=1.0;
//     field2.layer.borderWidth=1.0;
//     field3.layer.borderWidth=1.0;
//     field4.layer.borderWidth=1.0;
//     field5.layer.borderWidth=0.5;
//     field6.layer.borderWidth=0.5;
//     field7.layer.borderWidth=0.5;
//     field8.layer.borderWidth=0.5;
//     field9.layer.borderWidth=0.5;
//     field11.layer.borderWidth=0.5;
//     field12.layer.borderWidth=0.5;
//     field13.layer.borderWidth=0.5;
//     field14.layer.borderWidth=0.5;
//     field15.layer.borderWidth=0.5;
//     field16.layer.borderWidth=0.5;
//     field17.layer.borderWidth=0.5;
//     field18.layer.borderWidth=0.5;
//     field19.layer.borderWidth=0.5;
    
    
}
-(void)getaddressBook
{
    
      NSString * URL=[NSString stringWithFormat:@"%@/customers/%@/addresses", baseUrl1, [[DictFinal valueForKey:@"data"]valueForKey:@"customerid"]];
    GetAllAddress_Array=[Webmethods GetAll_Address:URL];
//    NSDictionary * dict = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"dictionaryKey"];

    //[HUD hide:YES];
    
    if ([GetAllAddress_Array count] > 0 && appDelegate.addressIndex > -1) {
        
        if ([_addressbookcheck isEqualToString:@"006"])
        {
            [AddView setHidden:NO];
            [EditView setHidden:YES];
        }
        else if ([_addressbookcheck isEqualToString:@"007"])
        {
            [self EditButtonObj:nil];
            [AddView setHidden:YES];
            [EditView setHidden:NO];
        }
        else
        {
            [AddView setHidden:YES];
            [EditView setHidden:YES];
            [Address_TableView reloadData];
            [Address_TableView setHidden:NO];
            
        }
        [Address_TableView reloadData];
        
    }
    
    if (GetAllAddress_Array.count < 15)
    {
        Add_button.hidden = NO;
    }
    else
    {
        Add_button.hidden = YES;
    }
    
    
        if ([GetAllAddress_Array count]>0)
        {

            [Address_TableView reloadData];
            [Address_TableView setDelegate:self];
            [Address_TableView setDataSource:self];
           
        }
        else{
            
            [Address_TableView reloadData];
            [[[UIAlertView alloc] initWithTitle:@"Message" message:@"Address Book Empty" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];

        }
       
   
    
}
- (void)alttextFieldDidEndEditing:(UITextField *)textField
{
    ////NSLog(@"%@", textField.text);
}

- (void)alttextViewDidEndEditing:(UITextView *)textView
{
    ////NSLog(@"%@", textView.text);
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self navigationView];
    self.navigationController.navigationBar.barTintColor = kColor_Orange;
    
    self.navigationController.navigationBar.hidden = NO;
    
    _bangeLbl.hidden = YES;
    
    headerView.hidden = NO;
    [headerView addSubview:headerImg];
    [headerView addSubview:backBtnObj];
    [headerView addSubview:_menuBtnObj];
    [self.view addSubview:headerView];
    
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
//    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, width, 50)];
//    numberToolbar.barStyle = UIBarStyleDefault;
//    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:nil],
//                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
//    [numberToolbar sizeToFit];
//    field9.inputAccessoryView = numberToolbar;
//    field8.inputAccessoryView = numberToolbar;
//    field19.inputAccessoryView = numberToolbar;
//    field18.inputAccessoryView = numberToolbar;
//    field9.delegate=self;
//    field8.delegate=self;
//    field4.delegate=self;
//    
//    field19.delegate=self;
//    field18.delegate=self;
//    field14.delegate=self;
    Address_TableView.tag=0;
    Address_TableView.hidden = NO;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
//                                                 name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
//                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
      [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SelectedIndex"];
    [self.view addSubview:headerView];
}



-(IBAction)AddAddress:(id)sender
{
    addressTag = 10;
    [AddView setHidden:NO];
    [EditView setHidden:YES];
//    [Address_TableView setHidden: YES];
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"Addaddress"];
    [self  addSubviewWithZoomInAnimation:AddView duration:0.3 option:0];
}

- (IBAction)Save_Butt:(id)sender
{
    [self.view endEditing:YES];
  if ([field1.text isEqualToString:@""])
  {
      [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter first name"]];
  }
  else if ([field2.text isEqualToString:@""])
  {
       [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter last name"]];
  }
  else if ([field5.text isEqualToString:@""])
  {
      [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter address1"]];
  }
  else if ([field3.text isEqualToString:@""])
  {
       [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter city"]];
  }
  else if ([field4.text isEqualToString:@""])
  {
       [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter state"]];
  }
  else if ([field8.text isEqualToString:@""])
  {
       [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter pin code"]];
  }
  else if (field8.text.length != 6)
  {
      [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter six digit pin code"]];
  }
  else if ([field9.text isEqualToString:@""])
  {
      [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter phone number"]];
  }
  else if (field9.text.length != 10)
  {
      [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter ten digit phone number"]];
  }
  else
  {
      if ([self validateAlphabets:field1.text] == NO)
      {
          [self.view addSubview:[[ToastAlert alloc] initWithText:@"First name is not valid"]];
          return ;
      }
      if ([self validateAlphabets:field2.text] == NO)
      {
          [self.view addSubview:[[ToastAlert alloc] initWithText:@"Last name is not valid"]];
          return ;
      }
      
      
      if ([field8.text length] != 6)
      {
          [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter valid pin code"]];
          return ;
      }
      
      NSString *prefix = [field9.text substringToIndex:1];
      if ([prefix integerValue] < 7)
      {
          [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter valid phone number"]];
          return ;
      }
      if ([field9.text length] != 10)
      {
          [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter valid phone number"]];
          return ;
      }
      
      
      
      BOOL reach = [Webmethods checkNetwork];
      if (reach == NO) {
          return ;
      }
      
      [NSThread detachNewThreadSelector:@selector(threadStartAnimating22:) toTarget:self withObject:nil];
      NSString * URL=[NSString stringWithFormat:@"%@/customers/%@/addresses", baseUrl1, [[DictFinal valueForKey:@"data"]valueForKey:@"customerid"]];
      NSMutableArray * street_Array=[[NSMutableArray alloc] initWithObjects:field5.text,field6.text, nil];
      NSDictionary * dict=   [Webmethods Addaddress:URL andDict:field1.text andLastName:field2.text andcity:field3.text andregion:field4.text andpostcode:field8.text andcountry_id:@"IN" andtelephone:field9.text andstreet:street_Array];
      
      
      if ([[dict valueForKey:@"status"] integerValue]==0)
      {
          [SVProgressHUD dismiss];
         [self.view addSubview:[[ToastAlert alloc] initWithText:[[dict valueForKey:@"message"] objectAtIndex:0]]];
          return ;
      }
     if ([[[[dict valueForKey:@"messages"] valueForKey:@"error"] objectAtIndex:0] valueForKey:@"message"]!=nil)
      {
          [SVProgressHUD dismiss];
          return;
      }
      else
      {
          [self performSelector:@selector(popVC) withObject:nil afterDelay:1.5];
          [self.view addSubview:[[ToastAlert alloc] initWithText:[dict valueForKey:@"message"]]];
          
//          [self performSelector:@selector(getDataSelector) withObject:nil afterDelay:2];
      }
    
        [SVProgressHUD dismiss];
    }
}
-(void)getDataSelector
{
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
 
     NSString * URL = [NSString stringWithFormat:@"%@/customers/%@/addresses", baseUrl1, _CustmoorID];
    GetAllAddress_Array=[Webmethods GetAll_Address:URL];
    
       [self getaddressBook];
       [SVProgressHUD dismiss];
    [AddView setHidden:YES];
    field1.text=@"";
    field2.text=@"";
    field3.text=@"";
    field4.text=@"";
    field5.text=@"";
    field6.text=@"";
    //field7.text=@"";
    field8.text=@"";
    field9.text=@"";
    [Address_TableView reloadData];
}
- (IBAction)Cancel_Butt:(id)sender {
    
    if (addressTag == 10)
    {
        addressTag = 0;
        [AddView setHidden:YES];
        [EditView setHidden:YES];
        [Address_TableView setHidden: NO];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
//    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Addaddress"];
//    if ([_addressbookcheck isEqualToString:@"006"])
//    {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    else{
//        NSArray *windows = [UIApplication sharedApplication].windows;
//        UIView *_viewController;
//        UIWindow *_window;
//        UIView *_parentView;
//        if(windows.count > 0)
//        {
//            _parentView=nil;
//            _window = [windows objectAtIndex:0];
//            //keep the first subview
//            if(_window.subviews.count > 0)
//            {
//                _parentView = [_window.subviews objectAtIndex:0];
//                if ([_parentView.subviews count] == 3) {
//                    _viewController = [_parentView.subviews objectAtIndex:2];
//                    [_viewController removeFromSuperview];
//                }
//                
//                //            [_viewController viewDidAppear:YES];
//            }
//            
//        }
//        //    [self removeWithZoomOutAnimation:0.3 option:0];
//        [AddView setHidden:YES];
//    }
   
} 
- (IBAction)Update_Butt:(id)sender
{
    
    [self.view endEditing:YES];
    
    if ([field11.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Pleas enter first name"]];
    }
    else if ([field12.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Pleas enter last name"]];
    }
    else if ([field15.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter address1"]];
    }
    else if ([field13.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter city"]];
    }
    else if ([field14.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter state"]];
    }
    
//    else if ([field16.text isEqualToString:@""])
//    {
//        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please Enter Street2"]];
//    }
//    else if ([field17.text isEqualToString:@""])
//    {
//        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please Enter Country Code"]];
//    }
    else if ([field18.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter pin code"]];
    }
    else if ([field19.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter phone number"]];
    }
    else if (field18.text.length != 6)
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter six digit pin code"]];
    }
    else if (field19.text.length != 10)
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter ten digit phone number"]];
    }
    else
    {
        if ([self validateAlphabets:field11.text] == NO)
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"First name is not valid"]];
            return ;
        }
        if ([self validateAlphabets:field12.text] == NO)
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Last name is not valid"]];
            return ;
        }
        
        if ([field18.text length] != 6)
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter valid pin code"]];
            return ;
        }
        
        NSString *prefix = [field19.text substringToIndex:1];
        if ([prefix integerValue] < 7)
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter valid phone number"]];
            return ;
        }
        
        if ([field19.text length] != 10)
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter valid phone number"]];
            return ;
        }
        
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating22:) toTarget:self withObject:nil];
    NSString * URL=[NSString stringWithFormat:@"%@/customers/addresses/%@", baseUrl1,Entity_ID_Update];
    NSMutableArray * street_Array=[[NSMutableArray alloc] initWithObjects:field15.text,field16.text, nil];
    NSDictionary *addressDict = [Webmethods UpdateAddress:URL andDict:field11.text andLastName:field12.text andcity:field13.text andregion:field14.text andpostcode:field18.text andcountry_id:@"IN" andtelephone:field19.text andstreet:street_Array];
        
        if ([[addressDict valueForKey:@"status"] integerValue] == 1)
        {
            [self.view addSubview:[[ToastAlert alloc]initWithText:[addressDict valueForKey:@"message"]]];
//            [self getaddressBook];
//            [EditView setHidden:YES];
            
            [self performSelector:@selector(popVC) withObject:nil afterDelay:1.5];
            
        }
        else
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:[[addressDict valueForKey:@"message"] objectAtIndex:0]]];
        }
        
        [SVProgressHUD dismiss];
    }
}

-(void)popVC
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)Edit_Cancel_Butt:(id)sender
{
    if (addressTag == 10)
    {
        addressTag = 0;
        [AddView setHidden:YES];
        [EditView setHidden:YES];
        [Address_TableView setHidden: NO];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
//    [EditView setHidden:YES];
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Addaddress"];
 
}

- (IBAction)stateBtnAct:(UIButton *)sender
{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Select State" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Delhi", @"Haryana", @"Uttar Pradesh", @"West Bengal", nil] ;
//    alertView.tag = 10;
//    [alertView show];
    [self.view endEditing:YES];
    [stateTblVew setContentOffset:CGPointZero animated:YES];
    
    if (sender.tag == 10)
    {
        cityStateLbl.text = @"Select Your State";
//        stateTblVew.scrollEnabled = NO;
    }
    else if (sender.tag == 11)
    {
        cityStateLbl.text = @"Select Your City";
//        stateTblVew.scrollEnabled = YES;
    }
    stateTblVew.tag = sender.tag;
    
    [stateSelectionArr removeAllObjects];
    [citySelectionArr removeAllObjects];
    [stateTblVew reloadData];
    stateView.hidden = !stateView.hidden;
    [self  addSubviewWithZoomInAnimation:stateView duration:0.01 option:0];
}

- (void) removeWithZoomOutAnimation:(float)secs option:(UIViewAnimationOptions)option
{
    [UIView animateWithDuration:secs delay:0.0 options:0
                     animations:^{
                         
                         AddView.transform = CGAffineTransformScale(self.view.transform, 0.001, 0.001);
                         
                     }
                     completion:^(BOOL finished)
     {
         [AddView removeFromSuperview];
         
         
     }];
}
- (void) addSubviewWithZoomInAnimation:(UIView*)view duration:(float)secs option:(UIViewAnimationOptions)option
{
    // first reduce the view to 1/100th of its original dimension
    CGAffineTransform trans = CGAffineTransformScale(view.transform, 0.01, 0.01);
    view.transform = trans;	// do it instantly, no animation
    [self.view addSubview:view];
    // now return the view to normal dimension, animating this tranformation
    [UIView animateWithDuration:secs delay:0.0 options:0
                     animations:^{
                         view.transform = CGAffineTransformScale(view.transform, 100.0,100.0);
                     }
                     completion:nil];
}

#pragma mark UITableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 55 || tableView.tag == 0)
    {
        return 40;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 55 || tableView.tag == 0)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, tableView.frame.size.width, 40)];
        view.backgroundColor = [UIColor whiteColor];
        UIButton *addAddressButObj = [UIButton buttonWithType:UIButtonTypeCustom];
        addAddressButObj.titleLabel.textAlignment = NSTextAlignmentRight;
        addAddressButObj.frame = CGRectMake(tableView.frame.size.width/3, 0, tableView.frame.size.width/1.5, 40);
        [addAddressButObj setTitle:@"+Add a new address" forState:UIControlStateNormal];
        [addAddressButObj setTitleColor:[UIColor colorWithRed:167.0/255.0 green:167.0/255.0 blue:167.0/255.0 alpha:1] forState:UIControlStateNormal];
        [addAddressButObj addTarget:self action:@selector(AddAddress:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:addAddressButObj];
        
        return view;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 10)
    {
        return  [stateArr count];
    }
    else if (tableView.tag == 11)
    {
        return  [cityArr count];
    }
    else if (tableView.tag == 55)
    {
        return [GetAllAddress_Array count];
    }
    else
    {
        return [GetAllAddress_Array count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 10)
    {
        NSString *cellIdentifier = @"cell";
        UITableViewCell *cell ;
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = [stateArr objectAtIndex:indexPath.row];
        
        
        for (int i = 0; i < stateSelectionArr.count; i++)
        {
            if ([[stateSelectionArr objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%li", (long)indexPath.row]])
            {
                UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width-50, 12, 20, 20)];
                [image setImage:[UIImage imageNamed:@"ic_tick.png"]];
                [cell addSubview:image];
                break;
            }
            
        }
        
        
        return cell;
    }
    
    if (tableView.tag == 11)
    {
        NSString *cellIdentifier = @"cell";
        UITableViewCell *cell ;
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = [cityArr objectAtIndex:indexPath.row];
        
        
        for (int i = 0; i < citySelectionArr.count; i++)
        {
            if ([[citySelectionArr objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%li", (long)indexPath.row]])
            {
                UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width-50, 12, 20, 20)];
                [image setImage:[UIImage imageNamed:@"ic_tick.png"]];
                [cell addSubview:image];
                break;
            }
            
        }
        
        
        return cell;
    }
    else if (tableView.tag == 55)
    {
        static NSString *CellIdentifier = @"Cell";
        
        AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                [[NSBundle mainBundle] loadNibNamed:@"AddressCell" owner:self options:nil];
            }
            else
            {
                [[NSBundle mainBundle] loadNibNamed:@"AddressCell~iPad" owner:self options:nil];
            }
            
            cell =addressCell;
        }
        
        if ([[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"firstname"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"firstname"] isEqual:@""])
        {
            
            
        }
        else
        {
            Address_Str=[NSString stringWithFormat:@"%@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"firstname"]];
            
        }
        if ([[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"lastname"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"lastname"] isEqual:@""])
        {
            
        }
        
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@" %@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"lastname"]];
        }
        if ([[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"street"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"street"] isEqual:@""])
        {
            
        }
        else
        {
            NSArray *arr = [[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"street"];
            if ([arr count]==1)
            {
                Address_Str=[Address_Str stringByAppendingFormat:@",  \r%@",[[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"street"] objectAtIndex:0]];
            }
            else if ([arr count]==2)
            {
                Address_Str=[Address_Str stringByAppendingFormat:@",  \r%@,%@",[[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"street"] objectAtIndex:0], [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"street"] objectAtIndex:1]];
            }
        }
        if ([[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"city"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"city"] isEqual:@""])
        {
            
        }
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@",  \r%@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"city"]];
        }
        
        if ([[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"postcode"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"postcode"] isEqual:@""])
        {
            
        }
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@"- %@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"postcode"]];
        }
        
        
        if ([[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"region"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"region"] isEqual:@""])
        {
            
        }
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@",  \r%@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"region"]];
        }
        
        //    if ([[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"country_id"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"country_id"] isEqual:@""])
        //    {
        //
        //    }
        //    else
        //    {
        //        Address_Str=[Address_Str stringByAppendingFormat:@",  \r%@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"country_id"]];
        //    }
        
        
        if ([[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"telephone"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"telephone"] isEqual:@""])
        {
            
        }
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@",\n\rPhone: %@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"telephone"]];
        }
        cell.CustomerDetails_Lbl.numberOfLines=7;
        
        
        
        
        
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            cell.CustomerDetails_Lbl.font = [UIFont fontWithName:@"Helvetica" size:12];
        }
        else
        {
            cell.CustomerDetails_Lbl.font = [UIFont fontWithName:@"Helvetica" size:16];
        }
        
        
        
        
        cell.CustomerDetails_Lbl.text=Address_Str;
        cell.editbut.tag=indexPath.row;
        cell.deletebutt.tag=indexPath.row;
        cell.CheckBox_address_butt.tag=indexPath.row;
        NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
        Selectedstr =[temp objectForKey:@"SelectedIndex"];
        selectedindex = [Selectedstr intValue];
        
        
        return cell;
    }
    
    else
    {
        Address_TableView.hidden = NO;
        static NSString *CellIdentifier = @"Cell";
        
        AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            
//            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//            {
                [[NSBundle mainBundle] loadNibNamed:@"AddressCell" owner:self options:nil];
//            }
//            else
//            {
//                [[NSBundle mainBundle] loadNibNamed:@"AddressCell~iPad" owner:self options:nil];
//            }
            
            cell =addressCell;
        }
        
        if ([[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"firstname"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"firstname"] isEqual:@""])
        {
            
            
        }
        else
        {
            Address_Str=[NSString stringWithFormat:@"%@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"firstname"]];
            
        }
        if ([[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"lastname"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"lastname"] isEqual:@""])
        {
            
        }
        
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@" %@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"lastname"]];
        }
        if ([[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"street"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"street"] isEqual:@""])
        {
            
        }
        else
        {
            NSArray *arr = [[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"street"];
            if ([arr count]==1)
            {
                Address_Str=[Address_Str stringByAppendingFormat:@",  \r%@",[[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"street"] objectAtIndex:0]];
            }
            else if ([arr count]==2)
            {
                Address_Str=[Address_Str stringByAppendingFormat:@",  \r%@,%@",[[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"street"] objectAtIndex:0], [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"street"] objectAtIndex:1]];
            }
        }
        if ([[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"city"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"city"] isEqual:@""])
        {
            
        }
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@",  \r%@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"city"]];
        }
        
        if ([[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"postcode"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"postcode"] isEqual:@""])
        {
            
        }
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@"- %@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"postcode"]];
        }
        
        
        if ([[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"region"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"region"] isEqual:@""])
        {
            
        }
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@",  \r%@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"region"]];
        }
        
        //    if ([[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"country_id"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"country_id"] isEqual:@""])
        //    {
        //
        //    }
        //    else
        //    {
        //        Address_Str=[Address_Str stringByAppendingFormat:@",  \r%@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"country_id"]];
        //    }
        
        
        if ([[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"telephone"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"telephone"] isEqual:@""])
        {
            
        }
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@",\n\rPhone: %@",[[GetAllAddress_Array objectAtIndex:indexPath.row]valueForKey:@"telephone"]];
        }
        cell.CustomerDetails_Lbl.numberOfLines=7;
        
        
        
        
        
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            cell.CustomerDetails_Lbl.font = [UIFont fontWithName:@"Helvetica" size:12];
        }
        else
        {
            cell.CustomerDetails_Lbl.font = [UIFont fontWithName:@"Helvetica" size:16];
        }
        
        
        
        
        cell.CustomerDetails_Lbl.text=Address_Str;
        cell.editbut.tag=indexPath.row;
        cell.deletebutt.tag=indexPath.row;
        cell.CheckBox_address_butt.tag=indexPath.row;
        NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
        Selectedstr =[temp objectForKey:@"SelectedIndex"];
        selectedindex = [Selectedstr intValue];
        
        
        return cell;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView.tag == 10)
    {
        UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
        return footer;
    }
    else if (tableView.tag == 11)
    {
        UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
        return footer;
    }
    else if (tableView.tag == 55)
    {
        UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
        return footer;
    }
    else
    {
        UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
        return footer;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10)
    {
        [stateSelectionArr  removeAllObjects];
        BOOL exist = NO;
        for (int i = 0; i < stateSelectionArr.count; i++)
        {
            if ([[stateSelectionArr objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%li", (long)indexPath.row]])
            {
                exist = YES;
                [stateSelectionArr removeObjectAtIndex:i];
                break;
            }
        }
        if (exist == NO)
        {
            [stateSelectionArr addObject:[NSString stringWithFormat:@"%li", (long)indexPath.row]];
        }
        [tableView reloadData];
        field4.text = [stateArr objectAtIndex:indexPath.row];
        field14.text = [stateArr objectAtIndex:indexPath.row];
        [self performSelector:@selector(hideView) withObject:nil afterDelay:.8];
    }
    
    else if (tableView.tag == 11)
    {
        [citySelectionArr  removeAllObjects];
        BOOL exist = NO;
        for (int i = 0; i < citySelectionArr.count; i++)
        {
            if ([[citySelectionArr objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%li", (long)indexPath.row]])
            {
                exist = YES;
                [citySelectionArr removeObjectAtIndex:i];
                break;
            }
        }
        if (exist == NO)
        {
            [citySelectionArr addObject:[NSString stringWithFormat:@"%li", (long)indexPath.row]];
        }
        [tableView reloadData];
        field3.text = [cityArr objectAtIndex:indexPath.row];
        field13.text = [cityArr objectAtIndex:indexPath.row];
        [self performSelector:@selector(hideView) withObject:nil afterDelay:.8];
    }
    else if (tableView.tag == 55)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (aTableView.tag == 10 || aTableView.tag == 11)
    {
        return 44;
    }
    else if (aTableView.tag == 55)
    {
        return 122;
    }
    else
    {
        return 122;
    }
    return 0;
}


-(void) hideView
{
    stateView.hidden = YES;
}


-(IBAction)DeleteButtonObj:(UIButton *)sender
{

    if (GetAllAddress_Array.count > 1)
    {
        selectedTag = (int)sender.tag;
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
-(IBAction)EditButtonObj:(UIButton *)sender
{
//    UIButton *button = (UIButton *)sender;
    int row = appDelegate.addressIndex;
    [[GetAllAddress_Array objectAtIndex:appDelegate.addressIndex] valueForKey:@"entity_id"];
    //NSLog(@"%@",Entity_ID);
    if (sender != nil)
    {
        row = (int)sender.tag;
    }
    
    //=[NSString stringWithFormat:@"http://apis.spencers.in/api/rest/customers/addresses/%@",Entity_ID];
    [EditView setHidden:NO];
    [AddView setHidden:YES];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"Addaddress"];
    
    field11.text  =  [[GetAllAddress_Array objectAtIndex:row]valueForKey:@"firstname"];
    field12.text  =  [[GetAllAddress_Array objectAtIndex:row]valueForKey:@"lastname"];
    field13.text  =  [[GetAllAddress_Array objectAtIndex:row]valueForKey:@"city"];
    if ([[[GetAllAddress_Array objectAtIndex:row]valueForKey:@"region"] isKindOfClass:[NSNull class]])
    {
        field14.text  =  @"";
    }
    else
    {
        field14.text  =  [[GetAllAddress_Array objectAtIndex:row]valueForKey:@"region"];
    }
    
    
    
    NSArray *streetArr = [[GetAllAddress_Array objectAtIndex:row]valueForKey:@"street"];
    
    if ([streetArr count]==1)
    {
        field15.text=[[[GetAllAddress_Array objectAtIndex:row]valueForKey:@"street"] objectAtIndex:0];
    }
    else if ([streetArr count]==2)
    {
         field15.text=[[[GetAllAddress_Array objectAtIndex:row]valueForKey:@"street"] objectAtIndex:0];
         field16.text=[[[GetAllAddress_Array objectAtIndex:row]valueForKey:@"street"] objectAtIndex:1];
    }
    
   
    field17.text= [[GetAllAddress_Array objectAtIndex:row]valueForKey:@"country_id"];
    field18.text= [[GetAllAddress_Array objectAtIndex:row]valueForKey:@"postcode"];
    field19.text= [[GetAllAddress_Array objectAtIndex:row]valueForKey:@"telephone"];
    
    
  
    
    Entity_ID_Update=[[GetAllAddress_Array objectAtIndex:row]valueForKey:@"entity_id"];
    
    [self  addSubviewWithZoomInAnimation:EditView duration:0.01 option:0];
    
    
}
- (NSIndexPath *)indexPathWithSubview:(UIView *)subview {
    
    while (![subview isKindOfClass:[UITableViewCell self]] && subview) {
        subview = subview.superview;
    }
    return [Address_TableView indexPathForCell:(UITableViewCell *)subview];
}
- (IBAction)CheckBox_address_butt:(UIButton *)sender
{
    
    [[NSUserDefaults standardUserDefaults]  removeObjectForKey:@"pin"];
    UIButton *button = (UIButton *)sender;
    selectedindex = (int)button.tag;
    
    [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%i",selectedindex] forKey:@"SelectedIndex"];
    
    [Address_TableView reloadData];
    
   AddressCell *selectedCell = (AddressCell *)[Address_TableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    
//    [selectedCell.CheckBox_address_butt setImage:[UIImage imageNamed:@"selected_address_radio.png"] forState:UIControlStateNormal];
    
         
    if ([_addressbookcheck isEqualToString:@"006"]||[_addressbookcheck isEqualToString:@"007"])
    {
        
        if ([[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"firstname"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"firstname"] isEqual:@""])
        {
            
            
        }
        else
        {
            Address_Str=[NSString stringWithFormat:@"%@",[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"firstname"]];
            
        }
        if ([[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"lastname"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"lastname"] isEqual:@""])
        {
            
        }
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@" %@",[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"lastname"]];
        }
        if ([[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"street"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"street"] isEqual:@""])
        {
            
        }
        else
        {
//            if ([[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"street"] count] < 2 ) {
//                
//                Address_Str=[Address_Str stringByAppendingFormat:@",  \r%@",[[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"street"] objectAtIndex:0]];
//            }
//            else{
//               Address_Str=[Address_Str stringByAppendingFormat:@",  \r%@,%@",[[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"street"] objectAtIndex:0], [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"street"] objectAtIndex:1]];
//            }
        }
        if ([[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"city"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"city"] isEqual:@""])
        {
            
        }
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@", %@",[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"city"]];
        }
        
        if ([[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"postcode"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"postcode"] isEqual:@""])
        {
            
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"postcode"] forKey:@"pin"];
            Address_Str=[Address_Str stringByAppendingFormat:@", \n%@",[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"postcode"]];
        }

        if ([[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"region"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"region"] isEqual:@""])
        {
            
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"region"] forKey:@"region"];
            Address_Str=[Address_Str stringByAppendingFormat:@", %@",[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"region"]];
        }
        
        
//        if ([[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"region"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"region"] isEqual:@""])
//        {
//            
//        }
//        else
//        {
//            Address_Str=[Address_Str stringByAppendingFormat:@",  \r%@",[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"region"]];
//        }
        
//        if ([[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"country_id"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"country_id"] isEqual:@""])
//        {
//            
//        }
//        else
//        {
//            Address_Str=[Address_Str stringByAppendingFormat:@",  \r%@",[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"country_id"]];
//        }
        
        if ([[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"telephone"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"telephone"] isEqual:@""])
        {
            
        }
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@", %@",[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"telephone"]];
        }
        
        
        
//        CheckOutViewViewController * checkoutpage ;
//        
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
//            checkoutpage=[[CheckOutViewViewController alloc]initWithNibName:@"CheckOutViewViewController" bundle:nil];
//        }
//        else
//        {
//            checkoutpage=[[CheckOutViewViewController alloc]initWithNibName:@"CheckOutViewViewController~iPad" bundle:nil];
//        }
//
//        
//        
//       // checkoutpage.CurrentBillingAddress=Address_Str;
//         checkoutpage.checkBands_str=@"111";
        //checkoutpage.Billingaddredd_ID= [[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"entity_id"];
        
        [[NSUserDefaults standardUserDefaults]setValue:Address_Str forKey:@"Billingaddress"];
        [[NSUserDefaults standardUserDefaults]setValue:[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"entity_id"] forKey:@"Billingaddress_ID"];
        
        
//        [self.navigationController pushViewController:checkoutpage animated:NO];
        
        [self.navigationController popViewControllerAnimated:NO];
        
    }
    if ([_addressbookcheck isEqualToString:@"008"]||[_addressbookcheck isEqualToString:@"009"])
    {
        if ([[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"firstname"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"firstname"] isEqual:@""])
        {
            
        }
        else
        {
            Address_Str=[NSString stringWithFormat:@"%@",[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"firstname"]];
            
        }
        if ([[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"lastname"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"lastname"] isEqual:@""])
        {
            
        }
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@" %@",[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"lastname"]];
        }
        if ([[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"street"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"street"] isEqual:@""])
        {
            
        }
        else
        {
//            if ([[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"street"] count]==1)
//            {
//                Address_Str=[Address_Str stringByAppendingFormat:@",  \r%@",[[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"street"] objectAtIndex:0]];
//            }
//            else if ([[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"street"] count]==2)
//            {
//                Address_Str=[Address_Str stringByAppendingFormat:@",  \r%@,%@",[[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"street"] objectAtIndex:0], [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"street"] objectAtIndex:1]];
//            }
        }
        if ([[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"city"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"city"] isEqual:@""])
        {
            
        }
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@", %@",[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"city"]];
        }
        if ([[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"region"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"region"] isEqual:@""])
        {
            
        }
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@", %@",[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"region"]];
        }
        
        if ([[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"country_id"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"country_id"] isEqual:@""])
        {
            
        }
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@", %@",[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"country_id"]];
        }
        if ([[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"postcode"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"postcode"] isEqual:@""])
        {
            
        }
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@", %@",[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"postcode"]];
        }
        
        if ([[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"telephone"] ==NULL  || [[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"telephone"] isEqual:@""])
        {
            
        }
        else
        {
            Address_Str=[Address_Str stringByAppendingFormat:@", %@",[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"telephone"]];
        }
        
        
        
//        CheckOutViewViewController * checkoutpage ;
//        
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
//            checkoutpage=[[CheckOutViewViewController alloc]initWithNibName:@"CheckOutViewViewController" bundle:nil];
//        }
//        else
//        {
//            checkoutpage=[[CheckOutViewViewController alloc]initWithNibName:@"CheckOutViewViewController~iPad" bundle:nil];
//        }
//        
////        checkoutpage.CurrentBillingAddress=Address_Str;
////        checkoutpage.Billingaddredd_ID= [[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"entity_id"];
//        
        [[NSUserDefaults standardUserDefaults]setValue:Address_Str forKey:@"shippingaddress"];
        [[NSUserDefaults standardUserDefaults]setValue:[[GetAllAddress_Array objectAtIndex:selectedindex]valueForKey:@"entity_id"] forKey:@"shippingaddress_ID"];
//        checkoutpage.checkBands_str=@"112";
//        [self.navigationController pushViewController:checkoutpage animated:NO];
        
        
        [self.navigationController popViewControllerAnimated:NO];
        
    }
    
}


- (IBAction)menuBtnAct:(UIButton *)sender {
    
    if (sender == backBtnObj)
    {
        if (AddView.hidden == NO)
        {
            AddView.hidden = YES;
            return ;
        }
        else if (EditView.hidden == NO)
        {
            EditView.hidden = YES;
            return ;
        }
        [self.navigationController popViewControllerAnimated:NO];
        
    }
    else if (sender==  offerObj)
    {
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        
        ProductVC *itemDetailsVC ;
        
        
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            itemDetailsVC = [[ProductVC alloc] initWithNibName:@"ProductVC" bundle:nil];
//        }
//        else
//        {
//            itemDetailsVC = [[ProductVC alloc] initWithNibName:@"ProductVC~iPad" bundle:nil];
//        }
        
        
        itemDetailsVC.productHeader = appDelegate.GlobalOfferName;
        itemDetailsVC.categoryUrl = appDelegate.GlobalofferURL;
        //            itemDetailsVC.offerCheckBool = YES;
        itemDetailsVC.productDetailsDict = [appDelegate.offerUrlDict valueForKey:@"data"];
        [self.navigationController pushViewController:itemDetailsVC animated:YES];
    }
    else if (sender == _myProfileBtnObj)
    {
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        
        NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
        NSString * oauth_token =[temp objectForKey:@"oauth_token"];
        
        if(oauth_token==NULL || [oauth_token isEqual:@""])
        {
            
            LoginVC* loginpage;
//            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//            {
                loginpage = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
//            }
//            else
//            {
//                loginpage = [[LoginVC alloc]initWithNibName:@"LoginVC~iPad" bundle:nil];
//            }
            
//            loginpage.CheckProfileStatus=@"000";
            [self.navigationController pushViewController:loginpage animated:NO];
        }
        else
        {
            MyProfileVC *myProfile;
            
//            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//            {
                myProfile = [[MyProfileVC alloc] initWithNibName:@"MyProfileVC" bundle:nil];
//            }
//            else
//            {
//                myProfile = [[MyProfileVC alloc] initWithNibName:@"MyProfileVC~iPad" bundle:nil];
//            }
            
            
            [self.navigationController pushViewController:myProfile animated:NO];
        }
        
    }
    else if (sender == _cartBtnObj)
    {
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        
        if ([_bangeLbl.text integerValue] == 0)
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Your Cart is Empty"]];
        }
        else
        {
            InCartVC *placeOrderVC ;
//            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//            {
                placeOrderVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
//            }
//            else
//            {
//                placeOrderVC = [[InCartVC alloc] initWithNibName:@"InCartVC~iPad" bundle:nil];
//            }
            
            [self.navigationController pushViewController:placeOrderVC animated:NO];
        }
        
    }
    else if (sender == _logoLargeBtn)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
    {
        if (buttonIndex == 0)
        {
            
            BOOL reach = [Webmethods checkNetwork];
            if (reach == NO) {
                return ;
            }
            
            [NSThread detachNewThreadSelector:@selector(threadStartAnimating22:) toTarget:self withObject:nil];

            NSString * Entity_ID= [[GetAllAddress_Array objectAtIndex:selectedTag] valueForKey:@"entity_id"];
                NSString * URL=[NSString stringWithFormat:@"%@/customers/addresses/%@", baseUrl1, Entity_ID];
                NSMutableDictionary *deleteAddress = [Webmethods DeleteAddress:URL];
                [self getaddressBook];
                [SVProgressHUD dismiss];
                [self.view addSubview:[[ToastAlert alloc]initWithText:[deleteAddress valueForKey:@"message"]]];
            
        }
    }
    else if (alertView.tag == 10)
    {
        if (buttonIndex == 0)
        {
            field4.text = @"Delhi";
            field14.text = @"Delhi";
        }
        else if (buttonIndex == 1)
        {
            field4.text = @"Haryana";
            field14.text = @"Haryana";
        }
        else if (buttonIndex == 2)
        {
            field4.text = @"Uttar Pradesh";
            field14.text = @"Uttar Pradesh";
        }
        else if (buttonIndex == 3)
        {
            field4.text = @"West Bengal";
            field14.text = @"West Bengal";
        }
    }
}
-(BOOL) validateAlphabets: (NSString *)alpha
{
    NSString *abnRegex = @"[A-Za-z ]+";
    #define ACCEPTABLE_CHARACTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_."// check for one or more occurrence of string you can also use * instead + for ignoring null value
    NSPredicate *abnTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", abnRegex];
    BOOL isValid = [abnTest evaluateWithObject:alpha];
    return isValid;
}



-(void)threadStartAnimating22:(id)dat
{
    [SVProgressHUD show];
}







- (void)keyboardWillShow:(NSNotification *)note
{
    if ([field4 isFirstResponder] == YES || [field8 isFirstResponder] == YES || [field9 isFirstResponder] == YES)
    {
        CGRect keyboardBounds = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [UIView animateWithDuration:0.3 animations:^{
            AddView.transform = CGAffineTransformMakeTranslation(0, -keyboardBounds.size.height+140);
            EditView.transform = CGAffineTransformMakeTranslation(0, -keyboardBounds.size.height+140);
        }];
        self.isKeyboradShow = YES;
    }
    if ([field14 isFirstResponder] == YES || [field18 isFirstResponder] == YES || [field19 isFirstResponder] == YES)
    {
        CGRect keyboardBounds = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [UIView animateWithDuration:0.3 animations:^{
            AddView.transform = CGAffineTransformMakeTranslation(0, -keyboardBounds.size.height+140);
            EditView.transform = CGAffineTransformMakeTranslation(0, -keyboardBounds.size.height+140);
        }];
        self.isKeyboradShow = YES;
    }
    headerView.hidden = NO;
    [headerView addSubview:headerImg];
    [headerView addSubview:backBtnObj];
    [headerView addSubview:_menuBtnObj];
    [self.view addSubview:headerView];
}



- (void)keyboardWillHide:(NSNotification *)note
{
    self.isKeyboradShow = NO;
    [UIView animateWithDuration:0.3 animations:^{
        EditView.transform = CGAffineTransformIdentity;
        AddView.transform = CGAffineTransformIdentity;
        
    }];
}
-(void)doneWithNumberPad{
    [field8 resignFirstResponder];
    [field9 resignFirstResponder];
    [field18 resignFirstResponder];
    [field19 resignFirstResponder];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.tag == 5 || textField.tag == 6)
    {
        if (textField.text.length < 30) {
            return YES;
        }
        else
        {
//            if (string.length>0)
//            {
//                return NO;
//            }
//            else
//            {
//                return YES;
//            }
            
        }
        
    }
    if(textField.tag==8)
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 6) ? NO : YES;
    }
    if(textField.tag==9)
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 10) ? NO : YES;
    }

    
    return YES; //we allow the user to enter anything
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
                 mainCategoryVC=[[MainCategoryVC alloc]initWithNibName:@"MainCategoryVC" bundle:nil];
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
            
            
            
            
//            BOOL flag = NO;
//            for (UIViewController *controller in self.navigationController.viewControllers)
//            {
//                if ([controller isKindOfClass:[OfferVC class]])
//                {
//                    flag = YES;
//                    [self.navigationController popToViewController:controller animated:YES];
//                    break;
//                }
//            }
//            if (flag == NO)
//            {
//                OfferVC * offerVC= [[OfferVC alloc]initWithNibName:@"OfferVC" bundle:nil];
//                [self.navigationController pushViewController:offerVC animated:YES];
//            }
        }
            break;
        case 14:
            temp=[NSUserDefaults standardUserDefaults];
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
            
            break;
            
    }
}


@end
