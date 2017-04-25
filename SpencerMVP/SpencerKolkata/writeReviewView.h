//
//  writeReviewViewController.h
//  Spencer
//
//  Created by Binary Semantics on 9/2/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"
@interface writeReviewView : UIViewController<RateViewDelegate,UITextViewDelegate>
{
    IBOutlet UILabel * ratecount;
    IBOutlet UITextView * CommenttextView;
    IBOutlet UITextField * title_txt;
    IBOutlet UIImageView * topimage;
    IBOutlet UIButton *sendBtnObj;
    int result;
}
@property (weak, nonatomic) IBOutlet RateView *rateView;
@property(nonatomic,retain) NSString *sku_Str;
-(IBAction)cancle_act:(id)sender;
-(IBAction)Send_act:(id)sender;
@end
