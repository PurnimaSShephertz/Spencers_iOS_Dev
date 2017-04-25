//
//  ACPItem.m
//  ACPScrollMenu
//
//  Created by Antonio Casero Palmero on 8/4/13.
//  Copyright (c) 2013 ACP. All rights reserved.
//

#import "ACPItem.h"

#import "Const.h"

#import "AppDelegate.h"


static inline CGRect ScaleRect(CGRect rect, float n) {
	return CGRectMake((rect.size.width - rect.size.width * n) / 2, (rect.size.height - rect.size.height * n) / 2, rect.size.width * n, rect.size.height * n);
}

@implementation ACPItem

# pragma mark -
# pragma mark Initialization method
# pragma mark -


- (id)initACPItem:(UIImage *)backgroundImage iconImage:(UIImage *)iconImage andLabel:(NSString *)labelItem
{
    
    AppDelegate *appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDele.ACPBool == 2)
    {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ACPItem_05" owner:self options:nil] lastObject];
    }
    else if (appDele.ACPBool == 1)
    {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ACPItem" owner:self options:nil] lastObject];
    }
    
//    if (IS_IPAD)
//    {
//        self = [[[NSBundle mainBundle] loadNibNamed:@"ACPItem~iPad" owner:self options:nil] lastObject];
//    }
//    else if (ITS_IPHONE5)
//    {
    
//    }
//    
//    else
//    {
//        self = [[[NSBundle mainBundle] loadNibNamed:@"ACPItem" owner:self options:nil] lastObject];
//    }
	if (self)
    {
        self.bgImage.image = backgroundImage;
        self.labelItem.preferredMaxLayoutWidth = CGRectGetWidth(self.labelItem.frame);
        self.labelItem.text = labelItem;
        self.labelItem.numberOfLines=3;
	}
	return self;
}


- (id)initACPItem:(UIImage* )backgroundImage iconImage:(UIImage *)iconImage label:(NSString *)labelItem andAction:(actionBlock)block
{
    AppDelegate *appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDele.ACPBool == 2)
    {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ACPItem_05" owner:self options:nil] lastObject];
    }
    else if (appDele.ACPBool == 1)
    {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ACPItem" owner:self options:nil] lastObject];
    }
    
    
//    if (IS_IPAD)
//    {
//        self = [[[NSBundle mainBundle] loadNibNamed:@"ACPItem~iPad" owner:self options:nil] lastObject];
//    }
//    else if (ITS_IPHONE5)
//    {
//      self = [[[NSBundle mainBundle] loadNibNamed:@"ACPItem_05" owner:self options:nil] lastObject];
//    }
//   
//    else
//    {
//        self = [[[NSBundle mainBundle] loadNibNamed:@"ACPItem" owner:self options:nil] lastObject];
//    }
    
    if (self) {
      
        self.labelItem.text = labelItem;
       
        self.labelItem.numberOfLines=3;
        self.labelItem.preferredMaxLayoutWidth = CGRectGetWidth(self.labelItem.frame);
        

        
        self.block = block;
        
        self.selected_img.tag = 10;
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"checkbacground_img"] boolValue] == NO)
        {
            self.selected_img.image=[UIImage imageNamed:@"line_img.png"];
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"checkbacground_img"];
        }
    }
    return self;
}

# pragma mark -
# pragma mark UIView methods
# pragma mark -


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	self.highlighted = YES;
    
	if ([_delegate respondsToSelector:@selector(itemTouchesBegan:)]) {
		[_delegate itemTouchesBegan:self];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	// if move out of 2x rect, cancel select menu...
	CGPoint location = [[touches anyObject] locationInView:self];
	if (!CGRectContainsPoint(ScaleRect(self.bounds, 2.0f), location)) {
		self.highlighted = NO;
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //    self.highlighted = NO;
	CGPoint location = [[touches anyObject] locationInView:self];
	if (CGRectContainsPoint(ScaleRect(self.bounds, 2.0f), location)) {
		if ([_delegate respondsToSelector:@selector(itemTouchesEnd:)]) {
			[_delegate itemTouchesEnd:self];
		}
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	self.highlighted = NO;
}


# pragma mark -
# pragma mark Highlighted state
# pragma mark -

- (void)setHighlightedBackground:(UIImage *)backgroundImageHightlighted iconHighlighted:(UIImage *)iconImageHighlighted textColorHighlighted:(UIColor *)texColorHighlighted
{
	if (backgroundImageHightlighted)
    {
		self.bgImage.highlightedImage = backgroundImageHightlighted;
	}
    
	if (iconImageHighlighted)
    {
		self.iconImage.highlightedImage = iconImageHighlighted;
	}
    
	if (texColorHighlighted)
    {
		[self.labelItem setHighlightedTextColor:texColorHighlighted];
       // [self.labelItem setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"choose_area_bg.png"]]];
	}
}

- (void)setHighlighted:(BOOL)highlighted
{
	// [super setHighlighted:highlighted];
	[_bgImage setHighlighted:highlighted];
	[_iconImage setHighlighted:highlighted];
	[_labelItem setHighlighted:highlighted];
    
}

@end
