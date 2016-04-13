//
//  UIView+Category.m
//  StructureProject
//
//  Created by ChenYJ on 14/5/20.
//  Copyright (c) 2014年 ChenYJ. All rights reserved.
//

#import "UIView+Category.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Category)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (UIViewController *)viewcontroller
{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)removeAllSubviews
{
    while (self.subviews.count) {
        UIView *child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (void)setbackgroundImage:(UIImage *)img
{
    self.layer.contents = (id)[img CGImage];
}

- (void)bringToFront
{
	[self.superview bringSubviewToFront:self];
}

- (UIImage *)imageByRenderingView
{
    CGFloat oldAlpha = self.alpha;
    self.alpha = 1;
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.alpha = oldAlpha;
    return resultingImage;
}

@end


#import <objc/runtime.h>

static char alertKey, alertLableKey;

@implementation UIView (alert)

- (void)setAlertLable:(UILabel *)alertLable
{
    objc_setAssociatedObject(self, &alertLableKey, alertLable, OBJC_ASSOCIATION_RETAIN);
}

- (UILabel *)alertLable
{
    if (objc_getAssociatedObject(self, &alertLableKey) == nil) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 35)];
        lable.font = [UIFont systemFontOfSize:15];
        lable.textColor = RGB(127, 127, 127);
        lable.textAlignment = NSTextAlignmentCenter;
        lable.backgroundColor = [UIColor clearColor];
        lable.numberOfLines = 0;
        lable.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        self.alertLable = lable;
        [self addSubview:lable];
    }
    return objc_getAssociatedObject(self, &alertLableKey);
}

- (void)setAlert:(NSString *)alert
{
    objc_setAssociatedObject(self, &alertKey, alert, OBJC_ASSOCIATION_RETAIN);
    self.alertLable.text = alert;
    self.alertLable.height = [self.alertLable sizeThatFits:CGSizeMake(self.alertLable.width, self.height)].height;
    self.alertLable.centerY = self.height / 2;
    self.alertLable.centerX = self.width / 2;
    if (alert == nil) {
        [self.alertLable removeFromSuperview];
        self.alertLable = nil;
    }
}

- (NSString *)alert
{
    return objc_getAssociatedObject(self, &alertKey);
}

@end
