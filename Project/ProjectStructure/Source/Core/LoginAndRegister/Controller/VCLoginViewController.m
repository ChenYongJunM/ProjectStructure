//
//  LoginViewController.m
//  V_Cat
//
//  Created by my on 15/7/22.
//  Copyright (c) 2015年 ChenYJ. All rights reserved.
//

#import "VCLoginViewController.h"

@interface VCLoginViewController ()

@end

@implementation VCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//登陆
- (IBAction)loginAction:(UIButton *)sender
{

    [APPDELEGATE turnToTabBarRootController];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
