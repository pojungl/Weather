//
//  NowDataModel.h
//  Weather2
//
//  Created by PO-JUNG on 16/11/3.
//  Copyright © 2016年 PO-JUNG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NowDataModel : NSObject

//城市名
@property(nonatomic,strong)NSString *cityName;
//城市ID
@property(nonatomic,strong)NSString *cityID;
//纬度
@property(nonatomic,assign)float lat;
//经度
@property(nonatomic,assign)float lon;
//当前时间
@property(nonatomic,strong)NSString *timeNow;
//当前温度
@property(nonatomic,assign)float temp;
//当前温度说明
@property(nonatomic,strong)NSString *tempInfo;
//当前温度Icon
@property(nonatomic,strong)NSString *weatherIcon;
//当前湿度
@property(nonatomic,assign)float humidity;
//当前气压
@property(nonatomic,assign)float pressure;

- (id)initWithData;

@end
