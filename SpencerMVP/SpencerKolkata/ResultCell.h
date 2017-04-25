//
//  ResultCell.h
//  Spencer
//
//  Created by binary on 27/07/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *img;
@property (strong, nonatomic) IBOutlet UIImageView *productimg;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *mrp;
@property (strong, nonatomic) IBOutlet UILabel *sp;
@property (strong, nonatomic) IBOutlet UILabel *count;

@end
