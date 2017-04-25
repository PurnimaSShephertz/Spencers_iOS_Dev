//
//  CouponPage.h
//  Spencer
//
//  Created by Binary Semantics on 8/4/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponCell.h"
#import "GAI.h"

@interface CouponPage : GAITrackedViewController <UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate>
{
    NSArray *name;
    NSArray *description;
    NSArray *code;
    IBOutlet UITableView * coupon_tbl;
    NSArray *values;
    IBOutlet UIButton *Apply_obj;
    IBOutlet UITextField *Coupon_TXT;
    NSString *  storeIdStr;
    NSUserDefaults *temp;
    NSString * oauth_token;
    NSDictionary * CouPonResponse_Dict;
}
-(IBAction)Coupon_Act:(UIButton *)sender;
- (IBAction)Apply_act:(UIButton *)sender;
- (IBAction)footerBtnAct:(UIButton *)sender;
@property (nonatomic, retain)IBOutlet CouponCell *resultCel;
@end
