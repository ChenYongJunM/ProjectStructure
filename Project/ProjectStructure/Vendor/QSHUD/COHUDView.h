//
//  COHUDView.h
//  Cooking
//
//  Created by iOS_Doctor on 14-10-18.
//  Copyright (c) 2014年 ___GoGo___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COHUDView : UIView

@property (nonatomic, copy) NSArray *imageNames; // progress animation image's name.
@property (nonatomic, assign) CGFloat aniamtionSpeed; // progress speed. default is 0.1.
@property (nonatomic, assign) BOOL isLoading; // wether loading.

@property (nonatomic, strong) NSMutableArray *huds;

+ (instancetype)shareHud;

- (void)showInView:(UIView *)view;
- (void)stop;

@end
