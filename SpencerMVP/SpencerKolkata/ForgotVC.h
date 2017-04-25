//
//  ForgotVC.h
//  MeraGrocer
//
//  Created by binary on 27/06/16.
//  Copyright © 2016 Binarysemantics . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAI.h"

@interface ForgotVC : GAITrackedViewController <UITextFieldDelegate>
{
    IBOutlet UITextField *forgotTxtFld;
    UIWindow* mainWindow;
    IBOutlet UIButton *sendBtnObj;
    IBOutlet UIButton *cancelBtnObj;
}

@property (strong, nonatomic) IBOutlet UIImageView *logoLargeImg,*logoSmallImg, *footerImg, *myProfileImg;
@property (nonatomic, retain) IBOutlet UIButton *menuBtnObj, *searchBtnObj, *cartBtnObj, *myProfileBtnObj, *logoLargeBtn;
- (IBAction)sendBtnAct:(UIButton *)sender;
- (IBAction)cancelBtnAct:(UIButton *)sender;

@end
