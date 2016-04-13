//
//  UIView+Category.h
//  StructureProject
//
//  Created by ChenYJ on 14/5/20.
//  Copyright (c) 2014年 ChenYJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)
//sets frame.origin.x = left;
@property (nonatomic) CGFloat left;
//sets frame.origin.y = top;
@property (nonatomic) CGFloat top;
//sets frame.origin.x = right - frame.size.wigth;
@property (nonatomic) CGFloat right;
//sets frame.origin.y = botton - frmae.size.height;
@property (nonatomic) CGFloat bottom;
//sets frame.size.width = width;
@property (nonatomic) CGFloat width;
//sets frame.size.height = height;
@property (nonatomic) CGFloat height;
//sets center.x = centerX;
@property (nonatomic) CGFloat centerX;
//sets center.y = centerY;
@property (nonatomic) CGFloat centerY;
//frame.origin
@property (nonatomic) CGPoint origin;
//frame.size
@property (nonatomic) CGSize size;
//包含这个view的controller
-(UIViewController *)viewcontroller;

-(void)removeAllSubviews;

-(void)setbackgroundImage:(UIImage *)img;

- (void)bringToFront;

- (UIImage *)imageByRenderingView;
@end

/**
 UIView category relevant with UI
 */
@interface UIView (alert)

//center alert lable
@property (nonatomic, strong, readonly) UILabel *alertLable;
//center alert text
@property (nonatomic, strong) NSString *alert;

@end
