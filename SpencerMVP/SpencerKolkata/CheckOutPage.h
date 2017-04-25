//
//  CheckOutPage.h
//  Spencer
//
//  Created by Binary Semantics on 7/8/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressCustCell.h"
#import "GAI.h"

@interface CheckOutPage : GAITrackedViewController <UIPickerViewDataSource, UIPickerViewDelegate,UITableViewDelegate,UITableViewDataSource, UIGestureRecognizerDelegate>
{
    IBOutlet UIButton * ConfirmAll_Obj;
    IBOutlet UILabel * Deliveryslot_lbl;
    IBOutlet UIView * slot_Picker_View,*Addaddressview;
    NSMutableArray * fetchID_Arry;
    NSMutableArray * finalarr;
    NSUserDefaults *temp;
    NSMutableArray * finalarr3,*reloadarray,*reloadmainArr;
    IBOutlet UIButton * addnewAddress_obj;
    IBOutlet UITableView * AddressTable_View;
    IBOutlet UITextView * AddtesstextView;
    IBOutlet UIView * deliveryView;
    IBOutlet UIView * orderReviewView;
    IBOutlet UIView * paymentView;
    IBOutlet UIScrollView * pagescroll;
     NSDictionary *DictFinal;
    NSMutableArray * GetAllAddress_Array;
    int selectedTag;
    NSString *selectedEntity_Id;
    UIAlertView *alertView1;
    CGFloat  ScreenWidth;
    IBOutlet UIView * Start_view1;
    NSString * fetchID;
    NSString *oauth_token, *oauth_token_secret;
    NSArray * DatesArr;
    NSMutableArray * fetch_Dict;
    NSURL *PinCheck_URL;
}
@property (weak, nonatomic) IBOutlet UIPickerView *picker,*picker2;
@property (strong, nonatomic)IBOutlet AddressCustCell * distcel;
-(IBAction)Confirm_All_Act:(id)sender;
-(IBAction)Edit_Deliveryslot_Act:(id)sender;
-(IBAction)Done_Act:(id)sender;
-(IBAction)addnewAddress_Act:(id)sender;
-(IBAction)Deleteaddress_Act:(UIButton*)sender;
-(IBAction)EditAddress_Act:(UIButton*)sender;
- (IBAction)footerBtnAct:(UIButton *)sender;
- (IBAction)selectionBtnAct:(UIButton *)sender;
@end
