//
//  ViewController.m
//  UISearchControllerDemo
//
//  Created by 栾士伟 on 17/3/10.
//  Copyright © 2017年 Luanshiwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"UISearchControllerDemo";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = self.searchViewController.searchBar;
    
    [self initData];
}

#pragma 懒加载

- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

- (UISearchController *)searchViewController {
    
    if (_searchViewController == nil) {
        _searchViewController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchViewController.delegate = self;
        _searchViewController.searchResultsUpdater = self;
        _searchViewController.dimsBackgroundDuringPresentation = NO;
        _searchViewController.hidesNavigationBarDuringPresentation = NO;
        self.definesPresentationContext = YES;
        
        _searchViewController.searchBar.placeholder=@"请输入关键词搜索";
        // 设置搜索框内部textField的背景图
//        [_searchViewController.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"search_bg"] forState:UIControlStateNormal];
        // 设置搜索框内放大镜图片
        [_searchViewController.searchBar setImage:[UIImage imageNamed:@"search_1"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        // 设置搜索框内按钮文字颜色，以及搜索光标颜色。
        _searchViewController.searchBar.tintColor = [UIColor blackColor];
        // 设置搜索框背景颜色
//        _searchViewController.searchBar.barTintColor = [UIColor colorWithHexString:@"#F6F7F8"];
        // 设置搜索框那个取消按钮文字
        [_searchViewController.searchBar setValue:@"完成"forKey:@"_cancelButtonText"];
    }
    return _searchViewController;
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.searchViewController.active) {
        return self.searchList.count;
    }else{
        return self.dataList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TableViewCell"];
    }
    if (self.searchViewController.active) {
        cell.textLabel.text = [self.searchList objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text = [self.dataList objectAtIndex:indexPath.row];
    }
    return cell;
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = [self.searchViewController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
    [self.tableView reloadData];
}

- (void)initData {
    
    for (NSInteger i = 0; i < 50; i++) {
        [self.dataList addObject:[NSString stringWithFormat:@"数据%ld",i]];
    }
    [self.tableView reloadData];
}

@end
