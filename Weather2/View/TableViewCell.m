//
//  TableViewCell.m
//  Weather2
//
//  Created by PO-JUNG on 16/11/6.
//  Copyright © 2016年 PO-JUNG. All rights reserved.
//

#import "TableViewCell.h"
#import "SixDayDataModel.h"
#import "Masonry.h"

@implementation TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        //时间
        _time = [[UILabel alloc] init];
        _time.textColor = [UIColor whiteColor];
        _time.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_time];
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(55, 10));
            make.top.mas_equalTo(self.contentView.frame.size.height/2-5);
            make.left.mas_equalTo(10);
        }];
        //Icon
        _icon = [[UIImageView alloc] init];
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.top.mas_equalTo(self.contentView.frame.size.height/2-15);
            make.left.mas_equalTo(_time.mas_right).offset(5);
        }];
        //气候说明
        _tempInfo = [[UILabel alloc] init];
        _tempInfo.textColor = [UIColor whiteColor];
        _tempInfo.font = [UIFont systemFontOfSize:12];
        _tempInfo.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_tempInfo];
        [_tempInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(self.contentView.frame.size.width, 10));
            make.left.mas_equalTo(_icon.mas_right).offset(5);
            make.top.mas_equalTo(10);
        }];
        //温度
        _temp = [[UILabel alloc] init];
        _temp.textColor = [UIColor whiteColor];
        _temp.font = [UIFont systemFontOfSize:12];
        _temp.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_temp];
        [_temp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 10));
            make.top.mas_equalTo(_tempInfo.mas_bottom).offset(5);
            make.left.mas_equalTo(_icon.mas_right).offset(5);
        }];
        //湿度Icon
        _humidityIcon = [[UIImageView alloc] init];
        _humidityIcon.image = [UIImage imageNamed:@"Humidity"];
        [self.contentView addSubview:_humidityIcon];
        [_humidityIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.top.mas_equalTo(_temp.mas_bottom).offset(5);
            make.left.mas_equalTo(_icon.mas_right).offset(5);
        }];
        //湿度
        _humidity = [[UILabel alloc] init];
        _humidity.textColor = [UIColor whiteColor];
        _humidity.textAlignment = NSTextAlignmentLeft;
        _humidity.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_humidity];
        [_humidity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 10));
            make.top.mas_equalTo(_temp.mas_bottom).offset(5);
            make.left.mas_equalTo(_humidityIcon.mas_right).offset(3);
        }];
        //气压Icon
        _pressureIcon = [[UIImageView alloc] init];
        _pressureIcon.image = [UIImage imageNamed:@"Pressure"];
        [self.contentView addSubview:_pressureIcon];
        [_pressureIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.top.mas_equalTo(_temp.mas_bottom).offset(5);
            make.left.mas_equalTo(_humidity.mas_right).offset(3);
        }];
        //气压
        _pressure = [[UILabel alloc] init];
        _pressure.textColor = [UIColor whiteColor];
        _pressure.textAlignment = NSTextAlignmentLeft;
        _pressure.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_pressure];
        [_pressure mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 10));
            make.top.mas_equalTo(_temp.mas_bottom).offset(5);
            make.left.mas_equalTo(_pressureIcon.mas_right).offset(3);
        }];
        //风速Icon
        _windIcon = [[UIImageView alloc] init];
        _windIcon.image = [UIImage imageNamed:@"Wind"];
        [self.contentView addSubview:_windIcon];
        [_windIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.top.mas_equalTo(_temp.mas_bottom).offset(5);
            make.left.mas_equalTo(_pressure.mas_right).offset(3);
        }];
        //风速
        _wind = [[UILabel alloc] init];
        _wind.textColor = [UIColor whiteColor];
        _wind.textAlignment = NSTextAlignmentLeft;
        _wind.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_wind];
        [_wind mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 10));
            make.top.mas_equalTo(_temp.mas_bottom).offset(5);
            make.left.mas_equalTo(_windIcon.mas_right).offset(3);
        }];

    }
    return  self;
}

- (void)reloadMainViewData:(SixDayDataModel *)Data {
    _time.text = Data.timeNow;
    _icon.image = [UIImage imageNamed:Data.weatherIcon];
    _tempInfo.text = Data.tempInfo;
    _temp.text = [NSString stringWithFormat:@"%.1f ℃",Data.temp];
    _humidity.text = [NSString stringWithFormat:@"%.0f ％",Data.humidity];
    _pressure.text = [NSString stringWithFormat:@"%.0f hpa",Data.pressure];
    _wind.text = [NSString stringWithFormat:@"%.2f m/s",Data.wind];


}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
