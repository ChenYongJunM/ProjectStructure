//
//  UIHelper+Extension.m
//  StructureProject
//
//  Created by ChenYJ on 14/5/20.
//  Copyright (c) 2014年 ChenYJ. All rights reserved.
//

#import "UIHelper+Extension.h"
#import "CYNavCustomButton.h"

@implementation UIHelper (Extension)

+ (UIBarButtonItem *)navBarButtonWithStyle:(VSNavBarStyle)barStyle target:(id)target action:(SEL)action
{
    NSString *imageName;
    switch (barStyle) {
        case VSNavBarStyleBack:
        {
            imageName = @"nav_btn_back";
        } break;
        case VSNavBarStyleAddFriend:
        {
            imageName = @"nav_btn_add";
        } break;
        case VSNavBarStyleMenu:
        {
            imageName = @"nav_btn_more";
        } break;
        case VSNavBarStyleOK:
        {
            imageName = @"nav_btn_right";
        } break;
        case VSNavBarStylePlus:
        {
            imageName = @"nav_btn_friend";
        } break;
        case VSNavBarStyleCancel:
        {
            imageName = @"nav_btn_wrong";
        } break;
        case VSNavBarStyleSeek:
        {
            imageName = @"nav_btn_search";
        } break;
        case VSNavBarStyleSet:
        {
            imageName = @"nav_btn_setting";
        } break;
        case VSNavBarStyleGo:
        {
            imageName = @"nav_btn_next";
        } break;
            
        default:
        {
            imageName = @"";
        }
            break;
    }
    return [self navBarButtonWithNormalImage:[UIImage imageNamed:imageName] target:target action:action];
}

+ (UIBarButtonItem *)navBarButtonWithNormalImage:(UIImage *)image target:(id)target action:(SEL)action
{
    CYNavCustomButton *customBtn = [CYNavCustomButton buttonWithType:UIButtonTypeCustom];
	[customBtn setImage:image forState:UIControlStateNormal];
	[customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    customBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:customBtn];
	return item;
}

+ (XBVSTextField *)textFieldWithSuperFrame:(CGRect)frame limitTextLong:(NSUInteger)textLong placeHolder:(NSString *)placeHolder
{
    XBVSTextField *textField = [[XBVSTextField alloc] initWithFrame:frame];
    textField.left = 11;
    textField.top = 0;
    textField.width = frame.size.width - 22;
    textField.limitWordsNum = textLong;
    textField.placeholder = placeHolder;
    textField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    textField.keyboardType = UIKeyboardTypeASCIICapable;
    return textField;
}

+ (XBVSTextField *)passwordFieldWithSuperFrame:(CGRect)frame limitTextLong:(NSUInteger)textLong placeHolder:(NSString *)placeHolder
{
    XBVSTextField *textField = [self textFieldWithSuperFrame:frame limitTextLong:textLong placeHolder:placeHolder];
    textField.secureTextEntry = YES;
    return textField;
}

+ (UILabel *)underLineStyleLable:(CGRect)frame withTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
#warning ?? textColor
    label.attributedText = [[NSAttributedString alloc] initWithString:title attributes:@{(NSString *)kCTUnderlineStyleAttributeName:@(1),NSForegroundColorAttributeName:RGB(232, 232, 203) ,NSFontAttributeName:[UIFont boldSystemFontOfSize:13.5f]}];
    label.userInteractionEnabled = YES;
    return label;
}

+ (void)showHasOKButtonAlertViewWithTitle:(NSString *)title tapped:(void (^) (void))tapped
{
    RIButtonItem *item0 = [RIButtonItem itemWithLabel:@"好的" action:^{
        if (tapped)
        {
            tapped();
        }
    }];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:title cancelButtonItem:item0 otherButtonItems:nil, nil];
    [alert show];
}

+ (void)showHasOKAndCancelButtonAlertViewWithTitle:(NSString *)title tapped:(void (^)(NSUInteger idx))tapped
{
    RIButtonItem *item0 = [RIButtonItem itemWithLabel:@"确定" action:^{
        if (tapped)
        {
            tapped(0);
        }
    }];
    RIButtonItem *item1 = [RIButtonItem itemWithLabel:@"取消" action:^{
        if (tapped)
        {
            tapped(1);
        }
    }];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:title cancelButtonItem:item0 otherButtonItems:item1, nil];
    [alert show];
}

+ (UIImageView *)avatarImageWithFrame:(CGRect)frame image:(UIImage *)image
{
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:frame];
    imageV.width = imageV.height;
    imageV.layer.masksToBounds = YES;
    imageV.layer.cornerRadius = frame.size.height / 2;
    if (image) {
        imageV.image = image;
    }
    return imageV;
}

+ (UIButton*)commomButtonWithFrame:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)color titleFont:(UIFont*)font bgImage:(UIImage*)bgImage bgImageS:(UIImage*)bgImageS
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = font;
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)] forState:UIControlStateNormal];
    [button setBackgroundImage:[bgImageS resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)] forState:UIControlStateHighlighted];
    return button;
}

@end
