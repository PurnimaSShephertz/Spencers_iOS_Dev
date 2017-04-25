//
//  DEMONavigationController.m
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMONavigationController.h"
#import "DEMOMenuViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "AppDelegate.h"
#import "Const.h"

@interface DEMONavigationController ()
{
    AppDelegate *appDele;
}
@property (strong, readwrite, nonatomic) DEMOMenuViewController *menuViewController;

@end

@implementation DEMONavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
    //[self.navigationBar setBackgroundImage:[UIImage imageNamed:@"star_basic_red.png"] forBarMetrics:UIBarMetricsDefault];
    
    appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDele.navigationBool == 10)
    {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:84/255.0 green:88/255.0 blue:93/255.0 alpha:1]];
    }
    else
    {
//        UIGraphicsBeginImageContext(self.view.frame.size);
//        [[UIImage imageNamed:@"firstBack_img.png"] drawInRect:self.view.bounds];
//        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        [UIColor colorWithPatternImage:image];
//        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithPatternImage:image]];
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:230/255.0 green:149/255.0 blue:59/255.0 alpha:1]];
    }
    
    
}

- (void)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
     [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"compareview"];
    [self.frostedViewController presentMenuViewController];
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    
    
    typedef NS_ENUM(NSUInteger, UIPanGestureRecognizerDirection) {
        UIPanGestureRecognizerDirectionUndefined,
        UIPanGestureRecognizerDirectionUp,
        UIPanGestureRecognizerDirectionDown,
        UIPanGestureRecognizerDirectionLeft,
        UIPanGestureRecognizerDirectionRight
    };
    
    static UIPanGestureRecognizerDirection direction = UIPanGestureRecognizerDirectionUndefined;
    
    switch (sender.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            if (direction == UIPanGestureRecognizerDirectionUndefined) {
                
                CGPoint velocity = [sender velocityInView:self.view];
                
                BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
                
                if (isVerticalGesture) {
                    if (velocity.y > 0) {
                        direction = UIPanGestureRecognizerDirectionDown;
                    } else {
                        direction = UIPanGestureRecognizerDirectionUp;
                    }
                }
                
                else {
                    if (velocity.x > 0) {
                        direction = UIPanGestureRecognizerDirectionRight;
                    } else {
                        direction = UIPanGestureRecognizerDirectionLeft;
                    }
                }
            }
            
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            switch (direction) {
                case UIPanGestureRecognizerDirectionUp: {
                    [self handleUpwardsGesture:sender];
                    break;
                }
                case UIPanGestureRecognizerDirectionDown: {
                    [self handleDownwardsGesture:sender];
                    break;
                }
                case UIPanGestureRecognizerDirectionLeft: {
                    [self handleLeftGesture:sender];
                    break;
                }
                case UIPanGestureRecognizerDirectionRight: {
                    [self handleRightGesture:sender];
                    break;
                }
                default: {
                    break;
                }
            }
        }
            
        case UIGestureRecognizerStateEnded: {
            direction = UIPanGestureRecognizerDirectionUndefined;
            break;
        }
            
        default:
            break;
    }

    
    
    // Dismiss keyboard (optional)
    //

}


- (void)handleUpwardsGesture:(UIPanGestureRecognizer *)sender
{
//    NSLog(@"Up");
}

- (void)handleDownwardsGesture:(UIPanGestureRecognizer *)sender
{
//    NSLog(@"Down");
}

- (void)handleLeftGesture:(UIPanGestureRecognizer *)sender
{
//    NSLog(@"Left");
}

- (void)handleRightGesture:(UIPanGestureRecognizer *)sender
{
//    NSLog(@"Right");
    
//    [self.view endEditing:YES];
//    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController panGestureRecognized:sender];
}

@end
