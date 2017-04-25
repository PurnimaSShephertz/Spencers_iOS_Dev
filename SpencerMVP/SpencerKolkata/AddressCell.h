//
//  Address.h
//  MeraGrocer
//
//  Created by Binary Semantics on 6/17/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressCell : UITableViewCell
@property(nonatomic,retain) IBOutlet UILabel *CustomerDetails_Lbl;
@property(nonatomic,retain) IBOutlet UIButton * deletebutt,*editbut,*CheckBox_address_butt;
@end
