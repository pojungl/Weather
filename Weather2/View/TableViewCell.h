//
//  TableViewCell.h
//  Weather2
//
//  Created by PO-JUNG on 16/11/6.
//  Copyright © 2016年 PO-JUNG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SixDayDataModel;

@interface TableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *time;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *temp;
@property(nonatomic,strong)UILabel *tempInfo;
@property(nonatomic,strong)UIImageView *humidityIcon;
@property(nonatomic,strong)UILabel *humidity;
@property(nonatomic,strong)UIImageView *pressureIcon;
@property(nonatomic,strong)UILabel *pressure;
@property(nonatomic,strong)UIImageView *windIcon;
@property(nonatomic,strong)UILabel *wind;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)reloadMainViewData:(SixDayDataModel *)Data;

@end
