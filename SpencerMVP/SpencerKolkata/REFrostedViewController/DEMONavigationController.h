//
//  DEMONavigationController.h
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DEMONavigationController : UINavigationController <UIGestureRecognizerDelegate>

- (void)showMenu;
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender;
@end
