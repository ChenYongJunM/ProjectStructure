//
//  UIViewController+Extension.m
//  StructureProject
//
//  Created by ChenYJ on 14/5/20.
//  Copyright (c) 2014年 ChenYJ. All rights reserved.
//

#import "UIViewController+Extension.h"
#import <objc/runtime.h>
#import "COHUDView.h"

static char hudKey;

@implementation UIViewController (ProgressHUD)


- (void)setHud:(MBProgressHUD *)hud
{
    objc_setAssociatedObject(self, &hudKey, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBProgressHUD *)hud
{
    MBProgressHUD *hud = objc_getAssociatedObject(self, &hudKey);
    return hud;
}

- (void)showLoadHUD
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.removeFromSuperViewOnHide = YES;
}

- (void)showLoadHUDOnWinow
{
    self.hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    self.hud.removeFromSuperViewOnHide = YES;
}

- (void)dismissLoadHUD
{
    self.hud.hidden = YES;
    self.hud = nil;
}

- (void)dismissLoadHUDWithSuccessText:(NSString *)text
{
    if (!self.hud) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    self.hud.removeFromSuperViewOnHide = YES;
    self.hud.mode = MBProgressHUDModeText;
    self.hud.labelText = text;
    [self.hud hide:YES afterDelay:1.2];
    __weak typeof (self) weakSelf = self;
    [self.hud setCompletionBlock:^{
        weakSelf.hud = nil;
    }];
}

- (void)dismissLoadHUDWithFailureText:(NSString *)text
{
    [self dismissLoadHUDWithSuccessText:text];
}

- (void)dismissLoadHUDWithFailureText:(NSString *)text completion:(void (^)())completion
{
    if (!self.hud) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    self.hud.removeFromSuperViewOnHide = YES;
    self.hud.mode = MBProgressHUDModeText;
    self.hud.labelText = text;
    [self.hud hide:YES afterDelay:1.5];
    __weak typeof (self) weakSelf = self;
    [self.hud setCompletionBlock:^{
        weakSelf.hud = nil;
        if (completion) {
            completion();
        }
    }];
    
    [[COHUDView shareHud] stop];
}

- (void)dismissLoadHUDWithSuccessText:(NSString *)text completion:(void (^)())completion
{
    [self dismissLoadHUDWithFailureText:text completion:completion];
}

- (void)dismissHudWithText:(NSString *)text textFont:(UIFont *)textFont interval:(CGFloat)interval yOffset:(CGFloat)yOffset completion:(void (^)())completion
{
    if (!self.hud) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    self.hud.removeFromSuperViewOnHide = YES;
    self.hud.mode = MBProgressHUDModeText;
    self.hud.labelText = text;
    self.hud.labelFont = textFont;
    self.hud.yOffset   = yOffset;
    [self.hud hide:YES afterDelay:interval];
    __weak typeof (self) weakSelf = self;
    [self.hud setCompletionBlock:^{
        weakSelf.hud = nil;
        if (completion) {
            completion();
        }
    }];
    
    [[COHUDView shareHud] stop];
}

- (void) showAlertViewWithTitle:(NSString*) titleText andContent:(NSString*)contentText completion:(void (^)())completion
{
    UIView *alertView = [[UIView alloc] init];
    alertView.layer.cornerRadius = 5;
    alertView.layer.masksToBounds = YES;
    
    alertView.size = CGSizeMake(200, 100);
    alertView.center = CGPointMake(self.view.width/2,(self.view.height-100)/2);
    
    alertView.backgroundColor = RGB(38, 38, 38);
    alertView.alpha = 1.0;
    UILabel *title = [[UILabel alloc] init];
    title.text = titleText;
    title.font = [UIFont systemFontOfSize:17];
    title.textColor = [UIColor whiteColor];
    title.frame = CGRectMake(0, 10, alertView.width, 20);
    title.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:title];
    
    UILabel *content = [[UILabel alloc] init];
    content.text = contentText;
    content.font = [UIFont systemFontOfSize:15];
    content.textColor = [UIColor whiteColor];
    content.frame = CGRectMake(10, 35, alertView.width-20, 40);
    //content sizeThatFits:CGsi
    content.width = [content sizeThatFits:CGSizeMake(alertView.width-20, 40)].width;
    if (content.width > alertView.width) {
        content.width = alertView.width-20;
    }
    if (content.origin.x<10) {
        content.left = 10;
    }
    content.centerX = alertView.width/2;
    content.numberOfLines = 0;
    [alertView addSubview:content];
    self.view.userInteractionEnabled = NO;
    [self.view addSubview:alertView];
    
    // 几秒后消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 移除
        [alertView removeFromSuperview];
        self.view.userInteractionEnabled = YES;
        if (completion) {
            completion();
        }
    });
}
@end



@implementation UIViewController (Extension)

- (void)GOsetNavigationBarHidde:(BOOL)hidde
{
    self.navigationController.navigationBar.hidden = hidde;
}

- (void)GOpresentViewController:(UIViewController *)controller
{
//    ApplicationDelegate.viewwillAppearbool = NO;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)GOdismissView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)GOdismissViewWithNoAnimation
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)DlogInfomessage:(NSString*)atitle Message:(NSString*)amessage
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:atitle
                                                    message:amessage
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"知道了", nil];
    [alert show];
}

@end

@implementation UIViewController (NavigationControler)

- (void)GOpopView:(UIViewController*)acontroller
{
    [self.navigationController popToViewController:acontroller animated:YES];
}

- (void)GOpopView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)GOpopRootView
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)GOpopRootViewWithNoAnimation
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)GOpopViewWithNoAnimation
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)GOpushViewControllerNOAnimation:(UIViewController *)controller
{
//    ApplicationDelegate.viewwillAppearbool = NO;
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)GOpushViewController:(UIViewController *)controller
{
//    ApplicationDelegate.viewwillAppearbool = NO;
    if (self.navigationController.viewControllers.count > 0) {
        [controller setHidesBottomBarWhenPushed:YES];
    }
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)GOleftNavToRootButtonClicked:(UIButton*)abutton
{
    if (self.navigationController.viewControllers.count > 1 || self.presentingViewController)
    {
        if (self.navigationController.viewControllers.count > 1) {
            [self GOpopRootView];
        }
        else{
            [self GOdismissView];
        }
    }
}

- (void)GOleftNavButtonClicked:(UIButton*)abutton
{
    if (self.navigationController.viewControllers.count > 1 || self.presentingViewController)
    {
        if (self.navigationController.viewControllers.count > 1) {
            [self GOpopView];
        }
        else{
            [self GOdismissView];
        }
    }
}

- (void)GOleftNavButtonClickedWithNoAnimation
{
    if (self.navigationController.viewControllers.count > 1 || self.presentingViewController)
    {
        if (self.navigationController.viewControllers.count > 1) {
            [self GOpopViewWithNoAnimation];
        }
        else{
            [self GOdismissViewWithNoAnimation];
        }
    }
}


- (void)defaultNavigationControllerSetting
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg128"] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_blue"] forBarMetrics:UIBarMetricsDefault];
    }
    //
    //    self.navigationController.navigationBar.translucent = NO;
    //    self.navigationController.navigationBarHidden = NO;
    //    self.navigationController.hidesBottomBarWhenPushed = YES;
    //    NSDictionary *dic = @{
    //                          NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
    //                          NSForegroundColorAttributeName:[UIColor whiteColor],
    //                          NSShadowAttributeName:[UIColor clearColor]
    //                          };
    //    self.navigationController.navigationBar.titleTextAttributes = dic;
    //
    //    self.navigationItem.leftBarButtonItem = [self leftBarButtonWithStyle:VSNavBarStyleBack];
    //
    //    [[UITabBar appearance] setTintColor:VCT_COLOR_RED_NAVIGATION];
    //
    //    [[UITabBarItem appearance]
    //     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor], NSForegroundColorAttributeName, nil]
    //     forState:UIControlStateNormal];
    //
    //    [[UITabBarItem appearance]
    //     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:VCT_COLOR_RED_NAVIGATION, NSForegroundColorAttributeName, nil]
    //     forState:UIControlStateSelected];
    
    NSDictionary* textAttributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14.f] forKey:NSFontAttributeName];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view.
}

- (UIBarButtonItem *)leftBarButtonWithStyle:(VSNavBarStyle)barStyle
{
    if (self.navigationController.viewControllers.count > 1 && self.presentedViewController == nil)
    {
        return [UIHelper navBarButtonWithStyle:VSNavBarStyleBack target:self action:@selector(leftNavButtonClicked:)];
    }
    else
        return nil;
}
- (void)leftNavButtonClicked:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIBarButtonItem *)rightBarButtonWithStyle:(VSNavBarStyle)barStyle
{
    return [UIHelper navBarButtonWithStyle:barStyle target:self action:@selector(rightNavButtonClicked:)];
}

- (void)rightNavButtonClicked:(UIButton *)button
{
    // implemention in sub controller.
}


@end
