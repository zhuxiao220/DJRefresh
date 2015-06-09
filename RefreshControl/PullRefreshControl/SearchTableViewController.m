//
//  SearchTableViewController.m
//  PullRefreshControl
//
//  Created by YuDejian on 15/6/8.
//  Copyright (c) 2015年 YDJ. All rights reserved.
//

#import "SearchTableViewController.h"
#import "RefreshControl.h"


@interface SearchTableViewController ()<UITableViewDataSource,UITableViewDelegate,RefreshControlDelegate>

@property (nonatomic,strong)NSMutableArray *dataList;
@property (nonatomic,weak)IBOutlet UITableView *tableView;
@property (nonatomic,strong)RefreshControl *refreshController;

@property (nonatomic,weak)IBOutlet UISearchBar *searchBar;


@end

@implementation SearchTableViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.tableView.tableHeaderView=self.searchBar;
    
    _refreshController=[[RefreshControl alloc] initWithScrollView:self.tableView delegate:self];
    _refreshController.topEnabled=YES;
    _refreshController.bottomEnabled=YES;
 
    
}

- (void)refreshControl:(RefreshControl *)refreshControl didEngageRefreshDirection:(RefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadData];
    });
    
}


- (NSMutableArray *)dataList{
    
    if (!_dataList) {
        _dataList=[[NSMutableArray alloc] init];
    }
    return _dataList;
    
}


- (void)loadData{

    if (_refreshController.refreshingDirection==RefreshingDirectionTop) {
        [self.dataList removeAllObjects];
    }
    
    for (NSInteger i=0; i<20; i++) {
        [self.dataList addObject:@""];
    }
    
    if (_refreshController.refreshingDirection==RefreshingDirectionTop) {
        [_refreshController finishRefreshingDirection:RefreshDirectionTop];

    }else{
        [_refreshController finishRefreshingDirection:RefreshDirectionBottom];

    }
    
    [self.tableView reloadData];
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    return cell;
  
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}




@end
