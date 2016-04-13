//
//  GOGOActivityIndicatorView.m
//  test1
//
//  Created by nia_wei on 13-8-5.
//  Copyright (c) 2013年 nia_wei. All rights reserved.
//

#import "GOGOActivityIndicatorView.h"

@implementation GOGOActivityIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self=[[[NSBundle mainBundle] loadNibNamed:@"GOGOActivityIndicatorView" owner:self options:nil] objectAtIndex:1];
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, self.frame.size.width, self.frame.size.height);
        
        _offy = imageYinying_.frame.origin.y - imageLogo_.frame.origin.y - imageLogo_.frame.size.height + 3;
    }
    
    return self;
}

- (void)doAnimations
{
    
    if (_isrunning) {
        
        
        [UIView animateWithDuration:.3 animations:^(){
            
            imageLogo_.center = CGPointMake(imageLogo_.center.x, imageLogo_.center.y + _offy );
            
            _yinyingAlpha = imageLogo_.frame.origin.y / _offy;
            
            imageYinying_.alpha = _yinyingAlpha;
            
        } completion:^(BOOL finished){
            
            if (_isrunning) {
                
                [UIView animateWithDuration:.5 animations:^(){
                    
                    imageLogo_.center = CGPointMake(imageLogo_.center.x, imageLogo_.center.y - _offy );
                    
                    _yinyingAlpha = imageLogo_.frame.origin.y / _offy;
                    
                    imageYinying_.alpha = _yinyingAlpha;
                    
                } completion:^(BOOL finished){
                    
                    if (_isrunning) {
                        //                    [self performSelectorOnMainThread:@selector(doAnimations) withObject:nil waitUntilDone:YES];
                        [self doAnimations];
                    }
                }];
                
                
            }
            
        }];
        
    }
}

- (void)startDoAnimation
{
    [self reset];
    if (!_isrunning) {
        _isrunning = YES;
//        [self performSelectorOnMainThread:@selector(doAnimations) withObject:nil waitUntilDone:YES];
//        [self doAnimations];
    }
   
    
    //V3
    NSArray *ary = @[[UIImage imageNamed:@"01.png"] , [UIImage imageNamed:@"02.png"] , [UIImage imageNamed:@"03.png"] , [UIImage imageNamed:@"04.png"] , [UIImage imageNamed:@"05.png"] , [UIImage imageNamed:@"06.png"] , [UIImage imageNamed:@"07.png"] , [UIImage imageNamed:@"08.png"] ];

    
    [imageAnimationView_ setAnimationImages:ary];
    float animationDuration = [imageAnimationView_.animationImages count] * 0.050; // 50ms per frame
    [imageAnimationView_ setAnimationRepeatCount:0];
    [imageAnimationView_ setAnimationDuration:animationDuration];
    [imageAnimationView_ startAnimating];
}

- (void)stopDoAnimation
{
    _isrunning = NO;
    
    //V3
    [imageAnimationView_ stopAnimating];
}

- (void)reset
{
    _yinyingAlpha = 0;
    imageLogo_.frame = CGRectMake(148.0, 0.0, 25.0, 25.0);
    imageYinying_.frame = CGRectMake(135.0, 40.0, 50.0, 10.0);
    imageYinying_.alpha = _yinyingAlpha;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
