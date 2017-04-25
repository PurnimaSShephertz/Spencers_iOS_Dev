//
//  MyCreditsView.h
//  MeraGrocer
//
//  Created by Binary Semantics on 6/29/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MycreditCell.h"

//#import "UIKeyboardViewController.h"
//#import "GAI.h"
#import "GAI.h"

@interface MyCreditsView : GAITrackedViewController <UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate, UITextFieldDelegate>{
    
    IBOutlet UILabel *YourCreditheader_Lbl;
    IBOutlet UILabel *Mycredit_Lbl;
    IBOutlet UILabel *TopupHeader_Lbl;
    IBOutlet UILabel *Recentactions_Lbl;
    IBOutlet UILabel *CretbalenceHeader_Lbl;
    IBOutlet UILabel *addedHeader_Lbl;
    IBOutlet UILabel *DateHeader_Lbl;
    IBOutlet UILabel *Actionheadet_Lbl;
    NSArray * Creditlog_Atrray;
    IBOutlet UIView * footerview;
    IBOutlet UITextField *amountTxtFld;
    IBOutlet UIButton *offerObj;
    IBOutlet UILabel *locationLbl;
    NSString *oauth_token;
    IBOutlet UILabel *mySRCLbl;
    IBOutlet UILabel *mySRCHeaderLbl;
}
@property (strong, nonatomic) IBOutlet UIButton *Recharge_Button;
@property (strong, nonatomic) IBOutlet UITableView *Mycredits_Table;

@property (nonatomic, retain) IBOutlet UIButton *logoLargeBtn;
@property (strong, nonatomic) IBOutlet MycreditCell *addressCell;
@property (nonatomic, retain) IBOutlet UIButton *menuBtnObj, *searchBtnObj, *cartBtnObj, *myProfileBtnObj;
@property (strong, nonatomic) IBOutlet UILabel *bangeLbl;
@property (strong, nonatomic) IBOutlet UIImageView *footerImg;
- (IBAction)Recharge_Button:(id)sender;
- (IBAction)menuBtnAct:(UIButton *)sender;
@end
