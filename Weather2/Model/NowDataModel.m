//
//  NowDataModel.m
//  Weather2
//
//  Created by PO-JUNG on 16/11/3.
//  Copyright © 2016年 PO-JUNG. All rights reserved.
//

#import "NowDataModel.h"
#import "FMDB.h"

@implementation NowDataModel

- (id)initWithData {
    self = [super init];
    if (self != nil) {
        NSString *partJSON = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingString:@"NowTempData.json"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:partJSON];
        NSString *partSQL = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingString:@"CityList.sqlite"];
        FMDatabase *DB = [FMDatabase databaseWithPath:partSQL];
        [DB open];
        
        //城市名称
        _cityName = dic[@"name"];
        //城市ID
        _cityID = dic[@"id"];
        //纬度
        _lat = [dic[@"coord"][@"lat"] floatValue];
        //经度
        _lon = [dic[@"coord"][@"lon"] floatValue];
        //当前时间
        NSTimeInterval timeInterval = [dic[@"dt"] doubleValue];
        NSDate *now = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        NSCalendar *calender = [NSCalendar currentCalendar];
        NSDateComponents *comp = [calender components:NSWeekdayCalendarUnit fromDate:now];
        NSInteger n = [comp weekday];
        NSArray *week = [NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
        _timeNow = week[n-1];
        //当前温度
        _temp = [dic[@"main"][@"temp"] floatValue]-272.15;
        //当前温度说明与Icon
        NSString *tempInfoID = dic[@"weather"][0][@"id"];
        NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM WeatherCodes WHERE id = '%@';",tempInfoID];
        FMResultSet *result = [DB executeQuery:SQL];
        while ([result next]) {
            _tempInfo = [result stringForColumn:@"meaning"];
            _weatherIcon = [result stringForColumn:@"icon"];
        }
        //当前温度Icon
        if ([_weatherIcon isEqualToString:@""]) {
            NSDate *date = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH"];
            NSInteger HH = [[dateFormatter stringFromDate:date] integerValue];
            if ([_tempInfo isEqualToString:@"晴"]) {
                if (6 <= HH && HH <= 18) {
                    _weatherIcon = @"SunnyDay";
                }else {
                    _weatherIcon = @"SunnyNight";
                }
            }else if([_tempInfo isEqualToString:@"阴"] || [_tempInfo isEqualToString:@"阴"]){
                if (6 <= HH && HH <= 18) {
                    _weatherIcon = @"ScatteredCloudsDay";
                }else {
                    _weatherIcon = @"ScatteredCloudsNight";
                }
            }
        }
        //当前湿度
        _humidity = [dic[@"main"][@"humidity"] floatValue];
        //当前气压
        _pressure = [dic[@"main"][@"pressure"] floatValue];
    }
    return self;
}

@end
