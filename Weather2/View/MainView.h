//
//  MainView.h
//  Weather2
//
//  Created by PO-JUNG on 16/11/3.
//  Copyright © 2016年 PO-JUNG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NowDataModel;

@interface MainView : UIView

@property(nonatomic,strong)UILabel *time;
@property(nonatomic,strong)UILabel *cityName;
@property(nonatomic,strong)UILabel *temp;
@property(nonatomic,strong)UILabel *tempInfo;
@property(nonatomic,strong)UILabel *humidity;
@property(nonatomic,strong)UIImageView *icon;

- (id)initWithFrame:(CGRect)frame;

- (void)reloadMainViewData:(NowDataModel *)Data;

@end
