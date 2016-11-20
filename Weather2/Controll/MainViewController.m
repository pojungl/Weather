//
//  MainViewController.m
//  Weather2
//
//  Created by PO-JUNG on 16/11/3.
//  Copyright © 2016年 PO-JUNG. All rights reserved.
//

#import "MainViewController.h"
#import <AFNetworking.h>
#import "MainView.h"
#import "SearchView.h"
#import "TableViewCell.h"
#import "CityNameListView.h"
#import "FMDB.h"
#import "ChineseString.h"
#import "pinyin.h"
#import "NowDataModel.h"
#import "SixDayDataModel.h"

@interface MainViewController ()

@end

@implementation MainViewController
//---------------------------------- 下载数据--------------------------------------------
- (void)GetWeatherData:(NSString *)city {
    //检测网络
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable: {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无网络连接" message:@"请在设置中打开WiFi或蜂窝数据网络！" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    [[UIApplication sharedApplication] openURL:url];
                }];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:ok];
                [alert addAction:cancel];
                [self presentViewController:alert animated:YES completion:nil];
                break;
            }
            default:
                break;
        }
    }];
    
    //下载当天数据
    NSString *NowData = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&mode=json&appid=d05aede6ee0d60cdb1e2eaf59c4a6789",city];
    NowData = [NowData stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[AFHTTPSessionManager manager] GET:NowData parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //将下载到数据存入沙盒
        NSString *partJSON = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingString:@"NowTempData.json"];
        NSDictionary *temp = responseObject;
        [temp writeToFile:partJSON atomically:YES];
        //发送通知更新数据
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetNowDataSuccess" object:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    //下载6天数据
    NSString *sixDayData = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&mode=json&units=metric&cnt=6&appid=d05aede6ee0d60cdb1e2eaf59c4a6789",city];
    sixDayData = [sixDayData stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[AFHTTPSessionManager manager] GET:sixDayData parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //将下载到数据存入沙盒
        NSString *partJSON = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingString:@"sixDayTempData.json"];
        NSDictionary *temp = responseObject;
        [temp writeToFile:partJSON atomically:YES];
        //发送通知更新数据
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetsixDayDataSuccess" object:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
//---------------------------------- viewDidload--------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //获取缓存数据当中的城市，并更新当前天气数据
    NSString *part = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingString:@"NowTempData.json"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:part];
    _cityName = dic[@"name"];
    if ([_cityName isEqualToString:@""]) {
        _cityName = @"Beijing";
    }
    [self GetWeatherData:_cityName];
    
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoadMainViewData) name:@"GetNowDataSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoadTableViewData) name:@"GetsixDayDataSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelectCityName) name:@"selectCityName" object:nil];
    
    //初始化MainView与SearchView，将SearchView添加到MainView
    _mainView = [[MainView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/2-27)];
    _searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 30)];
    [_searchView.button addTarget:self action:@selector(SearchCityName) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_mainView];
    [_mainView addSubview:_searchView];
    
    //初始化TableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2-25, self.view.bounds.size.width, self.view.bounds.size.height/2+25) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:25/255.0 green:35/255.0 blue:48/255.0 alpha:1];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //
    _cityNameListView = [[CityNameListView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width-6, self.view.bounds.size.height/2-3)];
    _cityNameListView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.9];
    _cityNameListView.layer.cornerRadius = 20;
    [self.view addSubview:_cityNameListView];

    //刷新main数据
    [self LoadMainViewData];
    //刷新tableView数据
    [self LoadTableViewData];
    
}
//---------------------------------- 加载城市数据--------------------------------------------
//加载MainView数据
- (void)LoadMainViewData {
    //根据时间改变MainView背景颜色
    NSDate *HourDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH"];
    NSInteger HH = [[dateFormatter stringFromDate:HourDate] integerValue];
    if (6 <= HH && HH <= 18) {
        _mainView.backgroundColor = [UIColor colorWithRed:0/255.0 green:225/255.0 blue:255/255.0 alpha:0.8];
        _mainView.cityName.textColor = [UIColor blackColor];
    }else {
        _mainView.backgroundColor = [UIColor colorWithRed:23/255.0 green:35/255.0 blue:45/255.0 alpha:1];
        _mainView.cityName.textColor = [UIColor whiteColor];
    }
    //加载数据
    NowDataModel *nowData = [[NowDataModel alloc] initWithData];
    [_mainView reloadMainViewData:nowData];
}

//加载TableView数据
- (void)LoadTableViewData {
    _fiveDayArr = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 5; i++) {
        SixDayDataModel *sixDayData = [[SixDayDataModel alloc] init];
        [sixDayData LoadSixDayData:i];
        [_fiveDayArr addObject:sixDayData];
    }
    [_tableView reloadData];
}

//----------------------------------搜索／更换城市数据--------------------------------------------
- (void)SearchCityName {
    [_searchView.inputCityName endEditing:YES];

    _cityNameArr = [[NSMutableArray alloc] init];
    NSString *str = [NSString stringWithFormat:@"%@",_searchView.inputCityName.text];
    NSString *SQL = [NSString stringWithFormat:@"SELECT name,country FROM CityList WHERE name LIKE '%%%@%%';",str];
    
    NSString *partSQL = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingString:@"CityList.sqlite"];
    FMDatabase *DB = [FMDatabase databaseWithPath:partSQL];
    [DB open];
    FMResultSet * result = [DB executeQuery:SQL];
    while ([result next]) {
        NSString *name = [result stringForColumn:@"name"];
        NSString *country = [result stringForColumn:@"country"];
        NSString *cityInfo = [NSString stringWithFormat:@"%@,%@",name,country];
        [_cityNameArr addObject:cityInfo];
    }
    [_cityNameListView LoadCityNameData:_cityNameArr];
    //显示CityNameListView
    [UIView animateWithDuration:0.5 animations:^{
        _cityNameListView.frame = CGRectMake(3, self.view.bounds.size.height/2, self.view.bounds.size.width-6, self.view.bounds.size.height/2-3);
    }];
    _searchView.inputCityName.text = @"";
}

- (void)SelectCityName {
    [self GetWeatherData:_cityNameListView.selectCityName];
    [UIView animateWithDuration:0.5 animations:^{
        _cityNameListView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width-10, self.view.bounds.size.height/2-5);
    }];
}

//----------------------------------tableView--------------------------------------------
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
//tableViewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *strID = @"ID";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell reloadMainViewData:_fiveDayArr[indexPath.row]];
    return cell;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (self.view.bounds.size.height/2+25)/5;
}
//----------------------------------Other--------------------------------------------
//收起键盘、CityNameListView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_searchView.inputCityName endEditing:YES];
    [UIView animateWithDuration:0.5 animations:^{
        _cityNameListView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width-10, self.view.bounds.size.height/2-5);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
