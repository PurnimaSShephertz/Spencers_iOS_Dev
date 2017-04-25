//
//  OrderReviewVC.h
//  Spencer
//
//  Created by Binary Semantics on 7/9/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderReviewCell.h"
#import "MainCategoryVC.h"
#import "CategoryPage.h"
#import "LoginVC.h"
#import "MyProfileVC.h"
#import "CategoryPage.h"

#import "PaymentInfoVC.h"

#import "GAI.h"

@interface OrderReviewVC : GAITrackedViewController <UITableViewDataSource, UITableViewDelegate>
{
    
    IBOutlet UITableView *orderReviewTblVew;
    IBOutlet OrderReviewCell *orderReviewCell;
    CGFloat width ;
    CGFloat height ;
    CGFloat screenX ;
    CGFloat screenY ;
    IBOutlet UIButton * ConfirmAll_Obj;
    CGFloat ScreenWidth;
    
    CategoryPage *Categoryvc;
    NSUserDefaults * temp;
    LoginVC* loginpage;
    MyProfileVC *myProfile;
    
    NSString *storeIdStr;
    
}
@property (strong, nonatomic) IBOutlet UILabel *totalLbl;
- (IBAction)footerBtnAct:(UIButton *)sender;
-(IBAction)Confirm_All_Act:(id)sender;
@end
