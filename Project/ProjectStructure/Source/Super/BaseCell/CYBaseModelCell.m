//
//  COModelCell.m
//  StructureProject
//
//  Created by ChenYJ on 14/5/20.
//  Copyright (c) 2014年 ChenYJ. All rights reserved.
//

#import "CYBaseModelCell.h"

@implementation CYBaseModelCell
@synthesize model = _model,
idx = _idx,
separatorViewLeft = _separatorViewLeft,
sectionIdx = _sectionIdx,
separatorView = _separatorView,
isApearSeparatorView = _isApearSeparatorView;

- (void)setIsApearSeparatorView:(BOOL)isApearSeparatorView
{
    self.separatorView.hidden = !isApearSeparatorView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[NSBundle mainBundle] loadNibNamed:reuseIdentifier owner:self options:nil][0];
        self.contentView.clipsToBounds = YES;
        self.clipsToBounds = YES;
        
        self.isApearSeparatorView = YES; // < default set.
        
        self.separatorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gen_list_line"]];
        self.separatorView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.separatorView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
     self.separatorView.frame = CGRectMake(self.separatorView.left, self.contentView.height - 1.0, self.width, self.separatorView.height);
}

- (void)setModel:(BaseModel *)model
{
    // could subController implement ...
    
}

+ (CGFloat)heightWithModel:(BaseModel *)model
{
    // could subController implement ...
    return 60; // < default return 60.
}

@end
