//
//  UIViewController+Extension.h
//  StructureProject
//
//  Created by ChenYJ on 14/5/20.
//  Copyright (c) 2014年 ChenYJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIHelper+Extension.h"

@interface UIViewController (Extension)

- (void)GOsetNavigationBarHidde:(BOOL)hidde;

- (void)GOpresentViewController:(UIViewController *)controller;

- (void)GOdismissView;

- (void)GOdismissViewWithNoAnimation;

-(void)DlogInfomessage:(NSString*)atitle Message:(NSString*)amessage;

@end


@interface UIViewController (NavigationControler)

- (void)GOpopRootViewWithNoAnimation;

- (void)GOpopRootView;

- (void)GOpopView:(UIViewController*)acontroller;

- (void)GOpopView;

- (void)GOpopViewWithNoAnimation;

- (void)GOpushViewController:(UIViewController *)controller;
- (void)GOleftNavToRootButtonClicked:(UIButton*)abutton;

- (void)GOleftNavButtonClicked:(UIButton *)button;
- (void)GOleftNavButtonClickedWithNoAnimation;

- (void)GOpushViewControllerNOAnimation:(UIViewController *)controller;




- (void)defaultNavigationControllerSetting;
//- (void)registerBackgroundChangeNotice;

- (UIBarButtonItem *)leftBarButtonWithStyle:(VSNavBarStyle)barStyle;
- (UIBarButtonItem *)rightBarButtonWithStyle:(VSNavBarStyle)barStyle;

- (void)leftNavButtonClicked:(UIButton *)button;
- (void)rightNavButtonClicked:(UIButton *)button;

@end




@interface UIViewController (ProgressHUD)

@property (nonatomic, strong) MBProgressHUD *hud;

- (void)showLoadHUD;
- (void)dismissLoadHUD;
- (void)dismissLoadHUDWithSuccessText:(NSString *)text;
- (void)dismissLoadHUDWithFailureText:(NSString *)text;
- (void)dismissLoadHUDWithSuccessText:(NSString *)text completion:(void(^)())completion;
- (void)dismissLoadHUDWithFailureText:(NSString *)text completion:(void(^)())completion;
- (void)dismissHudWithText:(NSString *)text textFont:(UIFont *)textFont interval:(CGFloat)interval yOffset:(CGFloat)yOffset completion:(void (^)())completion;
- (void) showAlertViewWithTitle:(NSString*) titleText andContent:(NSString*)contentText completion:(void (^)())completion;


@end
