//
//  UIHelper+Extension.h
//  StructureProject
//
//  Created by ChenYJ on 14/5/20.
//  Copyright (c) 2014年 ChenYJ. All rights reserved.
//

#import "UIHelper.h"
#import "XBVSTextField.h"

typedef NS_ENUM(NSUInteger, VSNavBarStyle) {
    
    VSNavBarStyleBack,
    VSNavBarStyleCancel,
    VSNavBarStyleOK,
    VSNavBarStyleMenu,
    VSNavBarStyleAddFriend,
    VSNavBarStyleSeek,
    VSNavBarStyleSet,
    VSNavBarStylePlus,
    VSNavBarStyleGo,
};

@interface UIHelper (Extension)

+ (UIBarButtonItem *)navBarButtonWithStyle:(VSNavBarStyle)barStyle target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)navBarButtonWithNormalImage:(UIImage *)image target:(id)target action:(SEL)action;

+ (XBVSTextField *)textFieldWithSuperFrame:(CGRect)frame limitTextLong:(NSUInteger)textLong placeHolder:(NSString *)placeHolder;

+ (XBVSTextField *)passwordFieldWithSuperFrame:(CGRect)frame limitTextLong:(NSUInteger)textLong placeHolder:(NSString *)placeHolder;

+ (UILabel *)underLineStyleLable:(CGRect)frame withTitle:(NSString *)title;

+ (void)showHasOKButtonAlertViewWithTitle:(NSString *)title tapped:(void (^) (void))tapped;

+ (void)showHasOKAndCancelButtonAlertViewWithTitle:(NSString *)title tapped:(void (^) (NSUInteger idx))tapped;

+ (UIImageView *)avatarImageWithFrame:(CGRect)frame image:(UIImage *)image;

+ (UIButton*)commomButtonWithFrame:(CGRect)frame
                             title:(NSString*)title titleColor:(UIColor*)color
                         titleFont:(UIFont*)font bgImage:(UIImage*)bgImage bgImageS:(UIImage*)bgImageS;

@end
