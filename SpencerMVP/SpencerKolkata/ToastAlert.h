//
//  ToastAlert.h
//  IOTEX
//
//  Created by binary on 10/17/13.
//
//

#import <UIKit/UIKit.h>

@interface ToastAlert : UILabel

{
    int messLength;

}

- (id)initWithText: (NSString*) msg;

@end
