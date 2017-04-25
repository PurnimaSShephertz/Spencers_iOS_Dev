//
//  ProductDetailPage.h
//  Spencer
//
//  Created by Binary Semantics on 7/2/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACPScrollMenu.h"
#import "SearchVC.h"
#import "GAI.h"

@interface ProductDetailPage : GAITrackedViewController <ACPScrollDelegate, UIAlertViewDelegate,UIScrollViewDelegate>
{
    IBOutlet UIImageView * Header_img,*Product_img,*rate1_img,*rate2_img,*rate3_img,*rate4_img,*rate_img5;
    IBOutlet UILabel * Product_name_lbl,*Review_name_lbl;
    IBOutlet UIButton * Writereview_obj;
    IBOutlet UITextView * Description_Txt,*Tab_Description_txt;
    
    IBOutlet UIScrollView * Pagescroll;
    NSUInteger width;
    NSUInteger height;
    IBOutlet UIView * Qty_View;
    CGFloat ScreenWidth,ScreenHeight;
    IBOutlet UIView * Varient_view;
    IBOutlet UIButton * Plusminus_button,*plus_button,*minus_button;
    IBOutlet UILabel * Qty_lbl,*Price_lbl,*SpecilaPrice_lbl,*price_line_lbl;
    IBOutlet UIButton *currentLocationBtnObj;
    SearchVC *searchVC;
    IBOutlet UISearchBar *searchBar1;
    UILabel *bangeLbl;
    IBOutlet UIImageView *seperatorImg;
    IBOutlet UIImageView * tabimg;
    IBOutlet UILabel *inCartLbl;
    IBOutlet UIView * writereview_view,*review_page;
    IBOutlet UIButton * ratelist_Obj;
    IBOutlet UIButton * writereview_Obj;
    CGPoint lastTouchLocation;
    CGRect originalFrame;
    BOOL isShown;
    NSDictionary *result;
}
    // The scroll view used for zooming.
    @property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign) int pushedFlag;
@property (nonatomic, retain) NSString *inCartStr;
@property (nonatomic, retain) NSString *entity_id;
@property (weak, nonatomic) IBOutlet ACPScrollMenu *scrollMenu;
@property (nonatomic) BOOL isShown;
-(IBAction)Writereview_Act:(id)sender;
-(IBAction)review_Act:(id)sender;
-(IBAction)Plus_Act:(id)sender;
-(IBAction)Minus_Act:(id)sender;
- (IBAction)backBtnAct:(UIButton *)sender;
- (IBAction)currentLocationBtnAct:(UIButton *)sender;


@property (nonatomic, retain) NSDictionary *counterDict;
@property (nonatomic, assign) int indexNumber;


- (void)show;
- (void)hide;
- (void)toggle;
@end
