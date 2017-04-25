//
//  ACPScrollContainer.m
//  ACPScrollMenu
//
//  Created by Antonio Casero Palmero on 8/4/13.
//  Copyright (c) 2013 ACP. All rights reserved.
//

#import "ACPScrollMenu.h"
#import <QuartzCore/QuartzCore.h>
#import "Const.h"
#import "AppDelegate.h"


#define  CalloutYOffsetnew1111 = 20.0f;
static CGFloat const kScrollViewFirstWidth = 0.0f;
static CGFloat const kScrollViewItemMarginWidth = 1.0f;

@implementation ACPScrollMenu



# pragma mark -
# pragma mark Initialization
# pragma mark -


- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		// Do something
	}
	return self;
}

- (id)initACPScrollMenuWithFrame:(CGRect)frame withBackgroundColor:(UIColor *)bgColor menuItems:(NSArray *)menuItems {
	self = [super initWithFrame:frame];
	if (!self) {
		return nil;
	}
    
	if (menuItems.count == 0) {
		return nil;
	}
    
	[self setUpACPScrollMenu:menuItems];
	[self setACPBackgroundColor:bgColor];
    
	return self;
}

- (void)setUpACPScrollMenu:(NSArray *)menuItems
{
	if (menuItems.count == 0) {
		return;
	}
	int menuItemsArrayCount = menuItems.count;
   ScreenWidth= [UIScreen mainScreen].bounds.size.width;

    AppDelegate *appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDele.ACPBool == 1)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-20, self.frame.size.height)];
    }
    else if (appDele.ACPBool == 2)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.frame.size.height)];
    }
  
    
	ACPItem *menuItem = menuItems[0];
  
    
    
    _scrollView.contentSize = CGSizeMake(kScrollViewFirstWidth * 2 + (kScrollViewItemMarginWidth * (menuItemsArrayCount - 1)) + menuItem.frame.size.width * menuItemsArrayCount, self.frame.size.height);
    
    // Do not show scrollIndicator
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    _scrollView.backgroundColor = [UIColor clearColor];
    [_scrollView setUserInteractionEnabled:YES];
    [self addSubview:_scrollView];
    
    self.menuArray = menuItems;
    [self setMenu];
    
    
    _animationType = ACPZoomOut;
    
//    [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//        [_scrollView setContentOffset:maximumOffsetPoint]; //spin all the way up?
//    }completion:^(BOOL finished){
//        if (finished)
//            //kick off another animation, to spin it back down:
//            [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//                [_scrollView setContentOffset:CGPointMake(jumpX, jumpY+randShuffle*sepValue)];
//            }completion:nil];
//    }
//     }];
    
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
   
}


- (void)setMenu {
	int i = 0;
	for (ACPItem *menuItem in _menuArray)
    {
		menuItem.tag = 1000 + i;
		menuItem.center = CGPointMake(menuItem.frame.size.width / 2 + kScrollViewFirstWidth + kScrollViewItemMarginWidth * i + menuItem.frame.size.width * i, self.frame.size.height / 2);
		menuItem.delegate = self;
		[_scrollView addSubview:menuItem];
        
		i++;
	}
}


# pragma mark -
# pragma mark Delegate Methods
# pragma mark -

- (void)itemTouchesBegan:(ACPItem *)item
{
    AppDelegate *appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDele.ACPBool == 1)
    {
        if (item.frame.origin.x < 100)
        {
            item.highlighted = YES;
            CGPoint point  = CGPointMake(item.frame.origin.x,item.frame.origin.y);
            [self.scrollView setContentOffset:point animated:YES];
        }
        else
        {
            item.highlighted = YES;
            CGPoint point  = CGPointMake(item.frame.origin.x-item.frame.size.width,item.frame.origin.y);
            [self.scrollView setContentOffset:point animated:YES];
        }
    }
    else if (appDele.ACPBool == 2)
    {
        if (item.frame.origin.x < 100)
        {
            item.highlighted = YES;
            CGPoint point  = CGPointMake(item.frame.origin.x,item.frame.origin.y);
            [self.scrollView setContentOffset:point animated:YES];
        }
        else
        {
            item.highlighted = YES;
            CGPoint point  = CGPointMake(item.frame.origin.x-item.frame.size.width,item.frame.origin.y);
            [self.scrollView setContentOffset:point animated:YES];
        }
    }
}

- (void)itemTouchesEnd:(ACPItem *)item {
    // blowUp animation
    for (UIView *view in [_scrollView subviews] )
    {
        if ([view isKindOfClass:[ACPItem class]])
        {
            for (UIView *imgView in [view subviews] )
            {
                if (imgView.tag == 10)
                {
                    UIImageView * imageView = (UIImageView *)imgView;
                    imageView.image=[UIImage imageNamed:@"abc.png"];
                    //            [view removeFromSuperview];
                }
            }
        }
    }
    [self startAnimation:item];
    
    if(item.block)
    {
        item.block(item);
    }
    if ([_delegate respondsToSelector:@selector(scrollMenu:didSelectIndex:)])
    {
        [_delegate scrollMenu:(id)self didSelectIndex:item.tag - 1000];
    }
}

# pragma mark -
# pragma mark Animation & behaviour
# pragma mark -

- (void)startAnimation:(ACPItem *)item
{
    
    for (UIView *view in [item subviews] )
    {
        if (view.tag == 10)
        {
            UIImageView * imageView = (UIImageView *)view;
            imageView.image=[UIImage imageNamed:@"line_img.png"];
            //            [view removeFromSuperview];
        }
    }
    
    [self removeHighlighted];
    item.highlighted = YES;
    switch (_animationType) {
        case ACPFadeZoomIn: {
            [UIView animateWithDuration:0.25f animations: ^{
                CGAffineTransform scaleUpAnimation = CGAffineTransformMakeScale(1.9f, 1.9f);
                item.transform = scaleUpAnimation;
                item.alpha = 0.2;
            } completion: ^(BOOL finished) {
                [UIView animateWithDuration:0.25f animations: ^{
                    item.transform = CGAffineTransformIdentity;
                    item.alpha = 1.0f;
                } completion: ^(BOOL finished) {
                    item.highlighted = YES;
                }];
            }];
            break;
        }
            
        case ACPFadeZoomOut: {
            [UIView animateWithDuration:0.1f animations: ^{
                CGAffineTransform scaleDownAnimation = CGAffineTransformMakeScale(0.9f, 0.9f);
                item.transform = scaleDownAnimation;
                item.alpha = 0.2;
            } completion: ^(BOOL finished) {
                [UIView animateWithDuration:0.1f animations: ^{
                    item.transform = CGAffineTransformIdentity;
                    item.alpha = 1.0f;
                } completion: ^(BOOL finished) {
                    item.highlighted = YES;
                }];
            }];
            break;
        }
            
        case ACPZoomOut: {
            [UIView animateWithDuration:0.1f animations: ^{
                CGAffineTransform scaleDownAnimation = CGAffineTransformMakeScale(0.9f, 0.9f);
                item.transform = scaleDownAnimation;
            } completion: ^(BOOL finished) {
                [UIView animateWithDuration:0.1f animations: ^{
                    item.transform = CGAffineTransformIdentity;
                } completion: ^(BOOL finished) {
                    item.highlighted = YES;
                }];
            }];
            break;
        }
            
        default: {
            [UIView animateWithDuration:0.25f animations: ^{
                CGAffineTransform scaleUpAnimation = CGAffineTransformMakeScale(1.9f, 1.9f);
                item.transform = scaleUpAnimation;
                item.alpha = 0.2;
            } completion: ^(BOOL finished) {
                [UIView animateWithDuration:0.25f animations: ^{
                    item.transform = CGAffineTransformIdentity;
                    item.alpha = 1.0f;
                } completion: ^(BOOL finished) {
                    item.highlighted = YES;
                }];
            }];
            break;
        }
    }
}

- (void)removeHighlighted
{
	for (ACPItem *menuItem in self.menuArray)
    {
		menuItem.highlighted = NO;
	}
}

- (void)setThisItemHighlighted:(NSInteger)itemNumber
{
	[self removeHighlighted];
	[[self.menuArray objectAtIndex:itemNumber] setHighlighted:YES];
}

# pragma mark -
# pragma mark Extra configuration
# pragma mark -


- (void)setACPBackgroundColor:(UIColor *)color
{
	self.backgroundColor = color;
}

@end
