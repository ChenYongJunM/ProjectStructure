//
//  UIHelper.h
//  StructureProject
//
//  Created by ChenYJ on 14/5/20.
//  Copyright (c) 2014年 ChenYJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTAttributedLabel.h"
#import "MBProgressHUD.h"

@interface UIHelper : NSObject

+ (UILabel *)commonLabelWithFrame:(CGRect)frame font:(UIFont*)font textColor:(UIColor*)color lineBreakMode:(NSLineBreakMode)lineBreakMode;
+ (UIImageView *)commomImageViewWithFrame:(CGRect)frame image:(UIImage*)image;
+ (UIButton*)commomButtonWithFrame:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)color titleFont:(UIFont*)font bgImage:(UIImage*)bgImage image:(UIImage*)image;
+ (TTTAttributedLabel*)commomTTTAttributedLabelWithFrame:(CGRect)frame font:(UIFont*)font textColor:(UIColor*)color lineBreakMode:(NSLineBreakMode)lineBreakMode numberOfLines:(NSInteger)numberOfLines;

+ (UIBarButtonItem *)navBackBarBtn:(NSString *)title target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)navBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)navBarLeftButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)navBarButtonWithImage:(UIImage *)image target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)navBarButtonLeftWithImage:(UIImage *)image target:(id)target action:(SEL)action;

+ (void)showAutoHideHUDforView:(UIView*)view title:(NSString*)title subTitle:(NSString*)subTitle;

//+ (void)dealWithNetError:(NSError *)error withView:(UIView *)view;

+ (void)showAutoHideHUDforView:(UIView*)view title:(NSString*)title subTitle:(NSString*)subTitle completeBlock:(void (^)(void))completion;

+ (MBProgressHUD*)showHUDAddedTo:(UIView*)view animated:(BOOL)animated;

+ (void)hideAllHUDsForView:(UIView*)view animated:(BOOL)animated;

+ (UIImageView *)inputTextView:(CGRect)frame;
+ (UIImageView *)loginTextView:(CGRect)frame;
+ (UIButton *)blueButton:(CGRect)frame withTitle:(NSString *)title;
+ (UIButton *)greenButton:(CGRect)frame withTitle:(NSString *)title;
+ (UIButton *)circleButton:(CGRect)frame withTitle:(NSString *)title;
+ (void)showAlert:(NSString *)message;
+ (void)showAlertTwoTip;

+ (void)showMenuControllerWithItems:(NSArray *)items targetRect:(CGRect)targetRect inView:(UIView *)view;
+ (void)showMenuControllerWithItems:(NSArray *)items targetRect:(CGRect)targetRect inView:(UIView *)view afterDelay:(NSTimeInterval)afterDelay;

+ (NSMutableAttributedString *)withFont:(UIFont *)font
                            andKeyColor:(UIColor *)keyColor
                                 keyStr:(NSString *)colorStr
                             fullString:(NSString *)fullStr
                              fullColor:(UIColor *)fullColor;

+ (NSMutableAttributedString *)withFullFont:(UIFont *)font
                                 fullString:(NSString *)fullStr
                                  fullColor:(UIColor *)fullColor
                                andKeyColor:(UIColor *)keyColor
                                     keyStr:(NSString *)colorStr
                                    keyFont:(UIFont *)keyFont;

+ (BOOL)isFourInchDevice;

@end
