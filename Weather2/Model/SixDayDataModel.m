//
//  SixDayDataModel.m
//  Weather2
//
//  Created by PO-JUNG on 16/11/6.
//  Copyright © 2016年 PO-JUNG. All rights reserved.
//

#import "SixDayDataModel.h"
#import "FMDB.h"

@implementation SixDayDataModel

//- (id)initWithData {
//    self = [super init];
//    if (self != nil) {
//        NSString *partJSON = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingString:@"sixDayTempData.json"];
//        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:partJSON];
//        NSArray *arr = dic[@"list"];
//    }
//    return self;
//}

- (void)LoadSixDayData:(NSInteger)row {
    NSString *partJSON = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingString:@"sixDayTempData.json"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:partJSON];
    NSArray *arr = dic[@"list"];
    NSDictionary *listDic = arr[row];
    
    NSString *partSQL = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingString:@"CityList.sqlite"];
    FMDatabase *DB = [FMDatabase databaseWithPath:partSQL];
    [DB open];
    
    //当前时间
    NSTimeInterval timeInterval = [listDic[@"dt"] doubleValue];
    NSDate *now = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calender components:NSWeekdayCalendarUnit fromDate:now];
    NSInteger n = [comp weekday];
    NSArray *week = [NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    _timeNow = week[n-1];
    //当前温度
    _temp = [listDic[@"temp"][@"day"] floatValue];
    //当前温度说明与Icon
    NSString *tempInfoID = listDic[@"weather"][0][@"id"];
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM WeatherCodes WHERE id = '%@';",tempInfoID];
    FMResultSet *result = [DB executeQuery:SQL];
    while ([result next]) {
        _tempInfo = [result stringForColumn:@"meaning"];
        _weatherIcon = [result stringForColumn:@"icon"];
    }
    //当前温度Icon
    if ([_weatherIcon isEqualToString:@""]) {
        if ([_tempInfo isEqualToString:@"晴"]) {
            _weatherIcon = @"SunnyDay";
        }else if([_tempInfo isEqualToString:@"阴"] || [_tempInfo isEqualToString:@"阴"]){
            _weatherIcon = @"ScatteredCloudsDay";
        }
    }
    //当前湿度
    _humidity = [listDic[@"humidity"] floatValue];
    //当前气压
    _pressure = [listDic[@"pressure"] floatValue];
    //当前风速
    _wind = [listDic[@"speed"] floatValue];
}

@end
