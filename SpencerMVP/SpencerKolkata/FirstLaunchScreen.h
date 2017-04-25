//
//  FirstLaunchScreen.h
//  Spencer
//
//  Created by Binary Semantics on 7/4/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstLaunchScreen : UIViewController<UIScrollViewDelegate>
{
    CGFloat ScreenWidth,Height;
    UIPageControl *pageControl;
    UIScrollView *scrollview;
    
    UIView *view;
}

@end
