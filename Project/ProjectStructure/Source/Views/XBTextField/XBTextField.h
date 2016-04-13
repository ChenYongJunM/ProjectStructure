//
//  XBTextView.h
//  StructureProject
//
//  Created by ChenYJ on 14/5/20.
//  Copyright (c) 2014年 ChenYJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XBTextFieldDelegate;

@interface XBTextField : UITextField

@property (nonatomic, assign) NSInteger limitWordsNum;

@property (nonatomic, assign) BOOL limitByBytes;

@property (nonatomic, weak) id<XBTextFieldDelegate> xbDelegate;

@end

@protocol XBTextFieldDelegate <NSObject>

@optional
- (void)textFieldDidChangedWithOutPinyinInputing:(XBTextField*)textView;

@end
