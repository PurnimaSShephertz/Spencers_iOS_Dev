//
//  OfferVC.h
//  Spencer
//
//  Created by binary on 21/07/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManualLocationVC.h"
#import "GAI.h"

@interface OfferVC : GAITrackedViewController
{
    IBOutlet UIScrollView *scr;
    float width, height, screenX, screenY ;
    ManualLocationVC *manualLocationVC;
     IBOutlet UISearchBar *searchBar1;
}
- (IBAction)footerBtnAct:(UIButton *)sender;

@end
