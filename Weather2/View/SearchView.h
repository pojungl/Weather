//
//  SearchView.h
//  Weather2
//
//  Created by PO-JUNG on 16/11/3.
//  Copyright © 2016年 PO-JUNG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView

@property(nonatomic,strong)UITextField *inputCityName;
@property(nonatomic,strong)UIButton *button;

- (id)initWithFrame:(CGRect)frame;

@end
