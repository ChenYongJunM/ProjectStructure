//
//  GOGOActivityIndicatorView.h
//  test1
//
//  Created by nia_wei on 13-8-5.
//  Copyright (c) 2013年 nia_wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GOGOActivityIndicatorView : UIView
{
    IBOutlet UIImageView *imageLogo_;
    
    IBOutlet UIImageView *imageYinying_;
    
    IBOutlet UIImageView *imageAnimationView_;
    
    float _yinyingAlpha;
    
    BOOL _isrunning;
    
    float _offy;
}

- (void)startDoAnimation;
- (void)stopDoAnimation;
- (void)reset;



@end
