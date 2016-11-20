//
//  MainViewController.h
//  Weather2
//
//  Created by PO-JUNG on 16/11/3.
//  Copyright © 2016年 PO-JUNG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainView;
@class SearchView;
@class CityNameListView;

@interface MainViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)MainView *mainView;
@property(nonatomic,strong)SearchView *searchView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)CityNameListView *cityNameListView;
@property(nonatomic,strong)NSMutableArray *cityNameArr;
@property(nonatomic,strong)NSMutableArray *fiveDayArr;
@property(nonatomic,strong)NSString *cityName;

@end
