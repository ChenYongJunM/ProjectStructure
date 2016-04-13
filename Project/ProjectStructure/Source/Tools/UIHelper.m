//
//  UIHelper.m
//  StructureProject
//
//  Created by ChenYJ on 14/5/20.
//  Copyright (c) 2014年 ChenYJ. All rights reserved.
//

#import "UIHelper.h"
//#import "XBASIWrapper.h"

@implementation UIHelper

+ (UILabel *)commonLabelWithFrame:(CGRect)frame font:(UIFont*)font textColor:(UIColor*)color lineBreakMode:(NSLineBreakMode)lineBreakMode {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = color;
    label.font = font;
    label.backgroundColor = [UIColor clearColor];
    label.lineBreakMode = lineBreakMode;
    return label;
}

+ (UIImageView *)commomImageViewWithFrame:(CGRect)frame image:(UIImage*)image {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    return imageView;
}

+ (UIButton*)commomButtonWithFrame:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)color titleFont:(UIFont*)font bgImage:(UIImage*)bgImage image:(UIImage*)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = font;
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    return button;
}

+ (TTTAttributedLabel*)commomTTTAttributedLabelWithFrame:(CGRect)frame font:(UIFont*)font textColor:(UIColor*)color lineBreakMode:(NSLineBreakMode)lineBreakMode numberOfLines:(NSInteger)numberOfLines {
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = color;
    label.lineBreakMode = lineBreakMode;
    label.numberOfLines = numberOfLines;
    label.font = font;
    
    return label;
}


+ (UIBarButtonItem *)navBackBarBtn:(NSString *)title target:(id)target action:(SEL)action
{

	UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	UIImage *img = [UIImage imageNamed:@"nav_btn_back"];
	[customBtn setImage:img forState:UIControlStateNormal];
    customBtn.frame = CGRectMake(0, 0, img.size.width, img.size.height);
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        customBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    }
#endif
	[customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:customBtn];
	return item;
}

+ (UIBarButtonItem *)navBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:customBtn.titleLabel.font}];
	customBtn.frame = CGRectMake(0, 0, size.width+20, 44);
    [customBtn setTitle:title forState:UIControlStateNormal];
//	[customBtn setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal];
	customBtn.titleLabel.shadowOffset = CGSizeMake(0, 0);
//	customBtn.titleLabel.shadowColor = RGBA(0, 0, 0, 0.2);
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        customBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, -15);
    }
#endif
    [customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:customBtn];
    return item;
}

+ (UIBarButtonItem *)navBarLeftButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:customBtn.titleLabel.font}];
	customBtn.frame = CGRectMake(0, 0, size.width+20, 44);
    [customBtn setTitle:title forState:UIControlStateNormal];
	[customBtn setTitleShadowColor:RGBA(0, 0, 0, 0.2) forState:UIControlStateNormal];
	customBtn.titleLabel.shadowOffset = CGSizeMake(1, 1);
	customBtn.titleLabel.shadowColor = RGBA(0, 0, 0, 0.2);
    [customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        customBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 15);
    }
#endif
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:customBtn];
    return item;
}

+ (UIBarButtonItem *)navBarButtonWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
	UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[customBtn setImage:image forState:UIControlStateNormal];
	[customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    customBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        customBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        customBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    }
#endif
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:customBtn];
	return item;
}

+ (UIBarButtonItem *)navBarButtonLeftWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
	UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[customBtn setImage:image forState:UIControlStateNormal];
	[customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    customBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        customBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        customBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
#endif
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:customBtn];
	return item;
}


+ (void)showAutoHideHUDforView:(UIView*)view title:(NSString*)title subTitle:(NSString*)subTitle {
    [self showAutoHideHUDforView:view title:title subTitle:subTitle completeBlock:nil];
}

+ (void)showAutoHideHUDforView:(UIView*)view title:(NSString*)title subTitle:(NSString*)subTitle completeBlock:(void (^)(void))completion {
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (completion) {
        hud.completionBlock = completion;
    }
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    if (subTitle)
    {
        hud.detailsLabelText = subTitle;
    }
    
    [hud hide:YES afterDelay:1.0f];
}
//+ (void)dealWithNetError:(NSError*)error withView:(UIView *)view
//{
//    NSString *title;
//    switch (error.code) {
//        case XBASIWrapperNetWorkunavailable:
//            //网络不可用
//            title = @"网络好像不可用哦";
//            break;
//        case XBASIWrapperParamError:
//            //参数错误
//            title = @"网络错误，请重试";
//            break;
//        case XBASIWrapperReqestFailed:
//            //服务器请求失败
//            title = @"网络错误，请重试";
//            break;
//        case XBASIWrapperReturnFalse:
//            //服务器返回失败
//            title = @"网络错误,请重试";
//            break;
//            
//        default:
//            title = @"网络错误，请重试";
//            break;
//    }
//    [[self class] showAutoHideHUDforView:view title:title subTitle:nil];
//    
//}


+ (MBProgressHUD*)showHUDAddedTo:(UIView*)view animated:(BOOL)animated {
    [self hideAllHUDsForView:view animated:NO];
    return [MBProgressHUD showHUDAddedTo:view animated:animated];
}

+ (void)hideAllHUDsForView:(UIView*)view animated:(BOOL)animated {
    [MBProgressHUD hideAllHUDsForView:view animated:animated];
}


+ (UIImageView *)inputTextView:(CGRect)frame
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:frame];
    imageview.image = [[UIImage imageNamed:@"input_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    return imageview;
}

+ (UIImageView *)loginTextView:(CGRect)frame
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:frame];
    imageview.image = [[UIImage imageNamed:@"input_bg_login"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    return imageview;
}

+ (UIButton *)blueButton:(CGRect)frame withTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:[[UIImage imageNamed:@"login_regsiter_btn_test.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)] forState:UIControlStateNormal];
    [button normalTitle:title];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    return button;
}

+ (UIButton *)greenButton:(CGRect)frame withTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:[[UIImage imageNamed:@"login_btn_green_n"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)] forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:@"login_btn_green_s"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)] forState:UIControlStateHighlighted];
    [button normalTitle:title];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    return button;
}

+ (UIButton *)circleButton:(CGRect)frame withTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:[UIImage imageNamed:@"login_btn_round_n"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"login_btn_round_s"] forState:UIControlStateHighlighted];
    [button normalTitle:title];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    return button;
}

+ (void)showAlert:(NSString *)message
{
    static UIAlertView *alert = nil;
    if (alert.superview != nil) {
        return;
    }
    alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
    [alert show];
}

+ (void)showAlertTwoTip
{
    [UIHelper showAlert:@"此功能二期开放"];
}

//+ (void)showNetError:(NSError *)error
//{
//    if (error.code == XBASIWrapperNetWorkunavailable)
//    {
//        [UIHelper showAlert:@"你的网络不太好,请检查下网络"];
//    }
//    else if (error.code == XBASIWrapperReturnFalse)
//    {
//        [UIHelper showAlert:@"请求出错啦!"];
//    }
//}

+ (void)showMenuControllerWithItems:(NSArray *)items targetRect:(CGRect)targetRect inView:(UIView *)view
{
    //    [view.viewController becomeFirstResponder];
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    menuController.menuItems = nil;
    [menuController setMenuVisible:NO];
    menuController.menuItems = items;
    menuController.arrowDirection = UIMenuControllerArrowDown;
    [menuController setTargetRect:targetRect inView:view];
    [menuController setMenuVisible:YES animated:YES];
}

+ (void)showMenuControllerWithItems:(NSArray *)items targetRect:(CGRect)targetRect inView:(UIView *)view afterDelay:(NSTimeInterval)afterDelay {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:items forKeyIfNotNil:@"items"];
    [dic setObject:[NSValue valueWithCGRect:targetRect] forKeyIfNotNil:@"rect"];
    [dic setObject:view forKeyIfNotNil:@"view"];
    [self performSelector:@selector(showMenu:) withObject:dic afterDelay:afterDelay];
    
}

+ (void)showMenu:(NSDictionary*)obj {
    
    NSArray *items = obj[@"items"];
    CGRect targetRect = [obj[@"rect"] CGRectValue];
    UIView *view = obj[@"view"];
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    menuController.menuItems = nil;
    [menuController setMenuVisible:NO];
    menuController.menuItems = items;
    menuController.arrowDirection = UIMenuControllerArrowDown;
    [menuController setTargetRect:targetRect inView:view];
    [menuController setMenuVisible:YES animated:YES];
}


+ (NSMutableAttributedString *)withFont:(UIFont *)font
                            andKeyColor:(UIColor *)keyColor
                                 keyStr:(NSString *)colorStr
                             fullString:(NSString *)fullStr
                              fullColor:(UIColor *)fullColor;
{
    
    if  (fullStr && colorStr){
        NSString *fullString = [fullStr copy];
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName:fullColor,
                                  NSFontAttributeName: font
                                  };
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:fullStr
                                               attributes:attribs];
        
        NSRange redTextRange = [fullString rangeOfString:colorStr];
        //        [attributedText setAttributes:@{NSForegroundColorAttributeName:keyColor}
        //                                range:redTextRange];
        [attributedText addAttribute:NSForegroundColorAttributeName value:keyColor range:redTextRange];
        return attributedText;
    }
    else
        return nil;
    
}
+ (NSMutableAttributedString *)withFullFont:(UIFont *)font
                                 fullString:(NSString *)fullStr
                                  fullColor:(UIColor *)fullColor
                                andKeyColor:(UIColor *)keyColor
                                     keyStr:(NSString *)keyStr
                                    keyFont:(UIFont *)keyFont
{
    NSMutableAttributedString *attrbuteString = [[self class] withFont:font
                                                           andKeyColor:keyColor
                                                                keyStr:keyStr
                                                            fullString:fullStr
                                                             fullColor:fullColor];
    NSRange keyFontRange = [fullStr rangeOfString:keyStr];
    [attrbuteString addAttribute:NSFontAttributeName value:keyFont range:keyFontRange];
    return attrbuteString;
}

+ (BOOL)isFourInchDevice
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            // iPhone Classic
            return NO;
        }
        if(result.height == 568)
        {
            return YES;
        }
    }
    return YES;
}

@end
