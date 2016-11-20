//
//  CityNameListView.h
//  Weather2
//
//  Created by PO-JUNG on 16/11/8.
//  Copyright © 2016年 PO-JUNG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityNameListView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *cityNameListArr;
@property(nonatomic,strong)NSString *selectCityName;
@property(nonatomic,strong)UITableView *tableView;

- (id)initWithFrame:(CGRect)frame;// WithCityNameList:(NSMutableArray *)cityNameListArr;
- (void)LoadCityNameData:(NSMutableArray *)array;

@end
