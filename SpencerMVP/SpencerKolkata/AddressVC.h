//
//  AddressVC.h
//  MeraGrocer
//
//  Created by Binary Semantics on 6/15/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressCell.h"
#import "UIKeyboardViewController.h"
#import "GAI.h"

@interface AddressVC : GAITrackedViewController<UITableViewDataSource,UITableViewDelegate,UIKeyboardViewControllerDelegate, UIAlertViewDelegate, UITextFieldDelegate>

{
    NSMutableArray * GetAllAddress_Array;
    NSString * Address_Str;
    IBOutlet UITableView * Address_TableView;
    NSArray * addressarray;
    NSDictionary * dict1;
    IBOutlet UIButton * backBtnObj;
    NSMutableArray * addarray;
    IBOutlet UIView * AddView, * EditView;
    IBOutlet UITextField * field1,*field2,*field3,*field4,*field5,*field6,*field7,*field8,*field9;
    IBOutlet UITextField * field11,*field12,*field13,*field14,*field15,*field16,*field17,*field18,*field19;
    IBOutlet UIButton *Save_Butt;
    UIKeyboardViewController *keyBoardController;
    IBOutlet UIView * mainview;
    NSString * Entity_ID_Update;
    int selectedindex;
    NSString * Selectedstr;
    NSDictionary *Customer_Dict;
    IBOutlet UILabel * YourAdded_lbl;
    IBOutlet UIImageView * footerImg;
    IBOutlet UIImageView * back_image;
    IBOutlet UIView * footer_View;
    IBOutlet UIButton * Add_button;
    IBOutlet UIImageView * addresssmall_img;
    
    int selectedTag;
    NSString *selectedEntity_Id;
    UIAlertView *alertView1;
    
    IBOutlet UIButton *offerObj;
    IBOutlet UILabel *locationLbl;
    NSDictionary * DictFinal;
    IBOutlet UIView *headerView;
    IBOutlet UIImageView *headerImg;
    
    IBOutlet UIButton *updateBtnObj;
    IBOutlet UIButton *cancelUpdateBtnObj;
    IBOutlet UIButton *cancelSaveBtnObj;
    IBOutlet UIView *stateView;
    IBOutlet UITableView *stateTblVew;
    NSArray *stateArr, *cityArr;
    NSMutableArray *stateSelectionArr, *citySelectionArr;
    IBOutlet UIView *myStateBg;
    IBOutlet UILabel *cityStateLbl;
}
@property (nonatomic, assign) BOOL isKeyboradShow;

@property (nonatomic, retain) IBOutlet UIButton *menuBtnObj, *searchBtnObj, *cartBtnObj, *myProfileBtnObj;
@property(nonatomic,retain) NSString *CustmoorID;
@property (strong, nonatomic) IBOutlet AddressCell *addressCell;
@property (strong, nonatomic) IBOutlet UIButton *logoLargeBtn;
@property (strong, nonatomic) NSString *addressbookcheck;
@property (strong, nonatomic) IBOutlet UILabel *addressbookLbl;
@property (strong, nonatomic) IBOutlet UILabel *bangeLbl;
- (IBAction)CheckBox_address_butt:(UIButton *)sender;

-(IBAction)AddAddress:(id)sender;
-(IBAction)DeleteButtonObj:(UIButton *)sender;
-(IBAction)EditButtonObj:(UIButton *)sender;
- (IBAction)menuBtnAct:(UIButton *)sender;
- (IBAction)Save_Butt:(id)sender;
- (IBAction)Cancel_Butt:(id)sender;

- (IBAction)Update_Butt:(id)sender;
- (IBAction)Edit_Cancel_Butt:(id)sender;

- (IBAction)stateBtnAct:(UIButton *)sender;
@end
