//
//  Reviews.h
//  Spencer
//
//  Created by Binary Semantics on 9/1/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Reviews : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
     UILabel *bangeLbl;
     NSMutableArray * reviewsarray;
     IBOutlet UITableView * reviewstable;
}
@property(nonatomic,retain) NSString * sku_Str;
@end
