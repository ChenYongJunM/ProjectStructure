//
//  COHUDView.m
//  Cooking
//
//  Created by iOS_Doctor on 14-10-18.
//  Copyright (c) 2014年 ___GoGo___. All rights reserved.
//

#import "COHUDView.h"

@interface COHUDView ()

@property (nonatomic, assign) NSInteger currentHUDCount;
@property (nonatomic, assign) NSInteger currentVisiteHud;

@end

@implementation COHUDView

@synthesize
imageNames = _imageNames,
aniamtionSpeed  = _aniamtionSpeed,
currentHUDCount = _currentHUDCount,
isLoading = _isLoading,
huds      = _huds;

+ (instancetype)shareHud
{
    static COHUDView *__simgle__;
    static dispatch_once_t __once__;
    dispatch_once(&__once__, ^{
        __simgle__ = [[COHUDView alloc]init];
        [__simgle__ _availableProperties];
    });
    return __simgle__;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _availableProperties];
    }
    return self;
}

- (void)showInView:(UIView *)view
{
    if (self.superview == nil) {
        [view addSubview:self];
        self.centerX = view.width / 2;
    }
    [self _start];
}

- (void)_start
{
    [self _loadHud];
    if (_currentVisiteHud + 1 < _huds.count) {
        [self _replaceHudWithIdx:_currentVisiteHud + 1];
        _currentVisiteHud ++;
    }
    else{
        _currentVisiteHud = 0;
        [self _replaceHudWithIdx:_currentVisiteHud];
    }
    [self performSelector:@selector(_start) withObject:self afterDelay:_aniamtionSpeed];
}

- (void)stop
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self removeFromSuperview];
}

#pragma mark - help

- (void)_replaceHudWithIdx:(NSInteger)idx
{
    NSInteger index = idx;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImageView *hud = (UIImageView *)_huds[index];
        hud.hidden = NO;
        if (index - 1 >= 0) {
            UIImageView * currentHud = (UIImageView *)_huds[index - 1];
            currentHud.hidden = YES;
        }
        else{
            UIImageView * currentHud = (UIImageView *)_huds[_huds.count - 1];
            currentHud.hidden = YES;
        }
    });
}

- (void)_availableProperties
{
    [self bringToFront];
    self.backgroundColor = [UIColor clearColor];
    if (!_imageNames) {
        _imageNames = @[@"loading_1", @"loading_2"];
    }
    if (_currentHUDCount <= 0) {
        _currentHUDCount = 0;
    }
    if (!_huds) {
        _huds = [NSMutableArray new];
    }
}

- (void)_loadHud
{
    [self _availableProperties];
    if (_currentHUDCount != _imageNames.count) {
        for (NSString *name in _imageNames) {
            UIImageView *hudView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:name]];
            hudView.origin = CGPointMake(0, 0);
            hudView.size = CGSizeMake(self.width, self.height);
            hudView.centerX = self.width / 2;
            hudView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            hudView.backgroundColor = [UIColor clearColor];
            hudView.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:hudView];
            if (_currentHUDCount > 0) {
                hudView.hidden = YES;
            }
            else{
                _currentVisiteHud = _currentHUDCount;
            }
            _currentHUDCount ++;
            [_huds addObject:hudView];
        }
    }
}

@end
