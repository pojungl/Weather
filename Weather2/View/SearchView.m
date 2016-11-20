//
//  SearchView.m
//  Weather2
//
//  Created by PO-JUNG on 16/11/3.
//  Copyright © 2016年 PO-JUNG. All rights reserved.
//

#import "SearchView.h"
#import "Masonry.h"

@implementation SearchView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        _inputCityName = [[UITextField alloc] init];
        _inputCityName.placeholder = @"输入城市名称...";
        _inputCityName.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:_inputCityName];
        [_inputCityName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(frame.size.width-60, 30));
            make.left.mas_offset(10);
            make.top.mas_equalTo(0);
        }];
        
        _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        UIImage *searchImg = [UIImage imageNamed:@"Search"];
        searchImg = [searchImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_button setImage:searchImg forState:UIControlStateNormal];
        [self addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.mas_equalTo(_inputCityName.mas_right).offset(5);
            make.top.mas_offset(0);
            
        }];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
