//
//  ViewController.h
//  UISearchControllerDemo
//
//  Created by 栾士伟 on 17/3/10.
//  Copyright © 2017年 Luanshiwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchControllerDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)UISearchController *searchViewController;

@property(nonatomic, strong)NSMutableArray *dataList;

@property(nonatomic, strong)NSMutableArray *searchList;


@end

