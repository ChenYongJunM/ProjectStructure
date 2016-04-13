//
//  XBTextView.m
//  StructureProject
//
//  Created by ChenYJ on 14/5/20.
//  Copyright (c) 2014年 ChenYJ. All rights reserved.
//

#import "XBTextField.h"

@implementation XBTextField

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self];
    }
    return self;
}

- (void)textFiledEditChanged:(NSNotification*)note {
    if (self.limitWordsNum <= 0) {
        return;
    }
    UITextField *textField = (UITextField *)note.object;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            [self limitTextWords];
            if ([self.xbDelegate respondsToSelector:@selector(textFieldDidChangedWithOutPinyinInputing:)]) {
                [self.xbDelegate textFieldDidChangedWithOutPinyinInputing:self];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{

        [self limitTextWords];
        if ([self.xbDelegate respondsToSelector:@selector(textFieldDidChangedWithOutPinyinInputing:)]) {
            [self.xbDelegate textFieldDidChangedWithOutPinyinInputing:self];
        }
    }
    
}

- (void)limitTextWords {
    NSInteger length;
    if (self.limitByBytes) {
        length = [[self class] lengthOfStringBytes:self.text];
    } else {
        length = self.text.length;
    }
    if (length > self.limitWordsNum) {
        self.text = (self.limitByBytes ? [[self class] subStringToBytesLenght:self.limitWordsNum string:self.text] : [self.text substringToIndex:self.limitWordsNum]);
    }
}

+ (NSString*)subStringToBytesLenght:(int)lenght string:(NSString*)string{
    float number = 0.0;
    NSMutableString *resultString = [NSMutableString string];
    for (int index = 0; index < [string length]; index++) {
        
        NSString *character = [string substringWithRange:NSMakeRange(index, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3) {
            number++;
        } else {
            number = number+0.5;
        }
        if (number <= lenght) {
            [resultString appendString:character];
        } else {
            break;
        }
    }
    return resultString;
    
}

+ (NSInteger)lengthOfStringBytes:(NSString*)string
{
    float number = 0.0;
    for (int index = 0; index < [string length]; index++) {
        
        NSString *character = [string substringWithRange:NSMakeRange(index, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3) {
            number++;
        } else {
            number = number+0.5;
        }
    }
    return ceil(number);
}

@end
