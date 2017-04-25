//
//  ForgotVC.m
//  MeraGrocer
//
//  Created by binary on 27/06/16.
//  Copyright © 2016 Binarysemantics . All rights reserved.
//

#import "ForgotVC.h"
#import "Webmethods.h"
#import "AppDelegate.h"
#import "ToastAlert.h"
#import "SVProgressHUD.h"

@interface ForgotVC ()
{
    AppDelegate *appDelegate;
    ToastAlert *toastAlert;
}
@end

@implementation ForgotVC
@synthesize menuBtnObj;
@synthesize myProfileBtnObj;
@synthesize cartBtnObj;
@synthesize logoLargeBtn;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"Forgot Password Screen";
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self setupView];
    
    
    UIColor *color = [UIColor colorWithRed:114.0/255.0 green:116.0/255.0 blue:121.0/255.0 alpha:1];
    [sendBtnObj setTitleColor:color forState:UIControlStateNormal];
    sendBtnObj.layer.borderColor = kColor_gray.CGColor;
    sendBtnObj.layer.borderWidth = 1;
    sendBtnObj.layer.cornerRadius = 22;
    
    [cancelBtnObj setTitleColor:color forState:UIControlStateNormal];
//    cancelBtnObj.layer.borderColor = kColor_gray.CGColor;
//    cancelBtnObj.layer.borderWidth = 1;
//    cancelBtnObj.layer.cornerRadius = 22;
    
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
    [titleLabelButton setTitle:@"Forgot Password" forState:UIControlStateNormal];
    titleLabelButton.frame = CGRectMake(0, 0, 200, 44);
    titleLabelButton.titleLabel.numberOfLines=1;
    [titleLabelButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [titleLabelButton setTitleColor:[UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    titleLabelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    //    [titleLabelButton addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleLabelButton;
    
    NSMutableArray *arrRightBarItems = [[NSMutableArray alloc] init];
    
    
    
    //    UIButton *btnSetting = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [btnSetting setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
    //    btnSetting.frame = CGRectMake(0, 0, 32, 32);
    //    //btnSetting.showsTouchWhenHighlighted=YES;
    ////    [btnSetting addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSetting];
    //    [arrRightBarItems addObject:barButtonItem];
    
    self.navigationItem.rightBarButtonItems=arrRightBarItems;
}

- (IBAction)backBtnAct:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self navigationView];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = kColor_Orange;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}
-(void) setupView
{
    self.footerImg.backgroundColor = [UIColor colorWithRed:3.0/255.0 green:132.0/255.0 blue:36.0/255.0 alpha:1];
//    sendBtnObj.backgroundColor = [UIColor colorWithRed:3.0/255.0 green:132.0/255.0 blue:36.0/255.0 alpha:1];
//    sendBtnObj.layer.cornerRadius = 5;
//    sendBtnObj.layer.masksToBounds = YES;
}

- (BOOL) validateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

-(void)threadStartAnimating22:(id)dat
{
    [SVProgressHUD show];
}

- (IBAction)sendBtnAct:(UIButton *)sender
{
    [forgotTxtFld resignFirstResponder];
    
    
    if ([forgotTxtFld.text length] != 0)
    {
        if ([self validateEmail:forgotTxtFld.text] == NO)
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter a valid email ID e.g. xyz@abc.com"]];
            return ;
        }
        
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating22:) toTarget:self withObject:nil];
        
        NSDictionary *forgetDict = [Webmethods forgotpassword:forgotTxtFld.text];
        //NSLog(@"");
        NSString * Status_str=[forgetDict valueForKey:@"status"];
        NSString * Message_str=[forgetDict valueForKey:@"message"];
        if ([[[[forgetDict valueForKey:@"messages"]valueForKey:@"error"]objectAtIndex:0]valueForKey:@"message"]!=nil)
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:[[[[forgetDict valueForKey:@"messages"]valueForKey:@"error"]objectAtIndex:0]valueForKey:@"message"]]];
        }
        else
        {
            if ( [Status_str integerValue] == 1 )
            {
                [self.view addSubview:[[ToastAlert alloc] initWithText:Message_str]];
                [self performSelector:@selector(pop) withObject:nil afterDelay:2];
            }
            else
            {
                [self.view addSubview:[[ToastAlert alloc] initWithText:Message_str]];
            }
        }
        
        [SVProgressHUD dismiss];
    }
    else
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter a valid email ID e.g. xyz@abc.com"]];
        //                     [alertView setUseMotionEffects:false];
        //                     [alertView show];
        //return;
        //                     [self forgotPassBtnAct:sender];
    }
}

- (IBAction)cancelBtnAct:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

-(void) pop
{
    [self.navigationController popViewControllerAnimated:NO];
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
