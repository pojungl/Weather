//
//  MainView.m
//  Weather2
//
//  Created by PO-JUNG on 16/11/3.
//  Copyright © 2016年 PO-JUNG. All rights reserved.
//

#import "MainView.h"
#import "NowDataModel.h"
#import "Masonry.h"

@implementation MainView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        //时间
        _time = [[UILabel alloc] init];
        _time.textColor = [UIColor whiteColor];
        _time.font = [UIFont systemFontOfSize:16];
        _time.textAlignment = NSTextAlignmentRight;
        [self addSubview:_time];
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 20));
            make.top.mas_equalTo(110);
            make.right.mas_equalTo(-5);
        }];
        //城市名
        _cityName = [[UILabel alloc] init];
        _cityName.font = [UIFont systemFontOfSize:14];
        _cityName.textAlignment = NSTextAlignmentRight;
        _cityName.numberOfLines = 0;
        [self addSubview:_cityName];
        [_cityName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(150, 20));
            make.top.mas_equalTo(_time.mas_bottom).offset(5);
            make.right.mas_equalTo(-5);
        }];
        //温度
        _temp = [[UILabel alloc] init];
        _temp.textColor = [UIColor whiteColor];
        _temp.font = [UIFont systemFontOfSize:22];
        _temp.textAlignment = NSTextAlignmentRight;
        [self addSubview:_temp];
        [_temp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 20));
            make.top.mas_equalTo(_cityName.mas_bottom).offset(5);
            make.right.mas_equalTo(-5);
        }];
        //气候说明
        _tempInfo = [[UILabel alloc] init];
        _tempInfo.textColor = [UIColor whiteColor];
        _tempInfo.font = [UIFont systemFontOfSize:22];
        _tempInfo.textAlignment = NSTextAlignmentRight;
        [self addSubview:_tempInfo];
        [_tempInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(120, 20));
            make.right.mas_equalTo(_temp.mas_left).offset(-5);
            make.top.mas_equalTo(_cityName.mas_bottom).offset(5);
        }];
        //湿度
        _humidity = [[UILabel alloc] init];
        _humidity.textColor = [UIColor whiteColor];
        _humidity.textAlignment = NSTextAlignmentRight;
        _humidity.font = [UIFont systemFontOfSize:22];
        [self addSubview:_humidity];
        [_humidity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(120, 20));
            make.top.mas_equalTo(_temp.mas_bottom).offset(5);
            make.right.mas_equalTo(-5);
        }];
        //Icon
        _icon = [[UIImageView alloc] init];
        [self addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(frame.size.width/2, 150));
            make.top.mas_equalTo(80);
            make.left.mas_equalTo(5);
        }];

    }
    return self;
}

- (void)reloadMainViewData:(NowDataModel *)Data {
    //加载时间
    _time.text = Data.timeNow;
    //加载城市名
    _cityName.text = Data.cityName;
    //加载天气
    _temp.text = [NSString stringWithFormat:@"%.1f ℃",Data.temp];
    //加载天气说明
    _tempInfo.text = Data.tempInfo;
    //加载湿度
    _humidity.text = [NSString stringWithFormat:@"湿度:%.0f％",Data.humidity];
    //加载天气Icon
    _icon.image = [UIImage imageNamed:Data.weatherIcon];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
