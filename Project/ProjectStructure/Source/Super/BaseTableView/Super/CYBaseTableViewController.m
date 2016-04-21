//
//  CYVSModelTableViewController.m
//  StructureProject
//
//  Created by ChenYJ on 15/7/20.
//  Copyright (c) 2015年 ChenYJ. All rights reserved.
//

#import "CYBaseTableViewController.h"

@interface CYBaseTableViewController ()

@property (nonatomic, strong, readwrite) NSString *offset;

@end

@implementation CYBaseTableViewController
@synthesize
isUseArchive = _isUseArchive,
headPanel = _headPanel,
footPanel = _footPanel,
upRefreshButton = _upRefreshButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (id)init
{
    if (self = [super init]) {
        self.enablePullUpToRefreshNilDataText    = @"暂无数据";
        self.isUseArchive = NO;
        self.fetchingNumber = 0;
        
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.separatorColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (self.enablePullDownToRefresh) {
        // 下拉刷新
        self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                self.offset = @"1";
                self.currentOffSet = @"1";
                [self fetchDataWithOffset:self.offset];
                
            });
        }];
    }
    if (self.enablePullUpToRefresh) {
        // 上拉刷新
        self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                self.currentRefreshType = CORefreshTypeUpPush;
                self.currentOffSet = [NSString stringWithFormat:@"%ld",([self.currentOffSet integerValue] + 1)];
                if (![self.currentOffSet isEqualToString:@"1"]) {
                    [self fetchDataWithOffset:self.currentOffSet];
                }
            });
        }];
    }
}

- (void)fetchDataWithOffset:(NSString *)offset
{
    self.offset = offset;
    self.fetchingNumber ++;
}

- (void)finishDataFetchWithModels:(NSArray *)models hasMore:(BOOL)hasMore currentOffset:(NSString *)currentOffset isSection:(BOOL) isSection
{
//    if (hasMore == NO) {
//        self.hasMore = hasMore;
//    }
//    else{
//        self.hasMore = (models.count) > 0;
//    }   暂时不用，用以自动加载下一页
    self.hasSection = isSection;
    //上拉
    if (self.currentRefreshType == CORefreshTypeUpPush) {
        // 结束刷新
        [self.tableView.footer endRefreshing];
    }
    //下拉
    if (self.currentRefreshType == CORefreshTypeDownPush) {
        // 结束刷新
        [self.tableView.header endRefreshing];
    }
    
    if ([self.currentOffSet isEqualToString:@"1"]) {
        self.models = [NSMutableArray arrayWithArray:models];
    }
    else if ([self.currentOffSet integerValue] > 0){
        [self.models addObjectsFromArray:models];
    }
    
    if (!models || models.count == 0) {
        if (self.models.count == 0) {
            self.view.alert = _enablePullUpToRefreshNilDataText;
        }
        [self.tableView reloadData];
        return;
    }
    else{
        if (self.isUseArchive == YES) {
            [self archiveListWithPath:[sandBoxPath stringByAppendingPathComponent:NSStringFromClass([self class])] models:models];
        }
    }
    self.view.alert = nil;
    [self.tableView reloadData];
}

- (void)beginRefresh
{
    self.currentRefreshType = CORefreshTypeDownPush;
    [self.tableView.header beginRefreshing];
}

#pragma mark - Override Super.

- (void)configureCell:(UITableViewCell<CYModelBinding> *)cell forIndexPath:(NSIndexPath *)indexPath
{
    [super configureCell:cell forIndexPath:indexPath];
    CYBaseModelCell *modelCell = (CYBaseModelCell *)cell;
    modelCell.idx = indexPath.row;
    modelCell.sectionIdx = indexPath.section;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == [self.models count] - 1 && self.enablePullUpToRefresh) {
//        if (self.hasMore && self.upPushType == COUpPushToRefreshTypeNormal && self.currentRefreshType == CORefreshTypeDone) {
//            [self beginUpPushToRefreshing];
//        }
//    }
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - help

- (void)archiveListWithPath:(NSString *)path models:(NSArray *)models
{
    [[NSFileManager defaultManager] createFileAtPath:path contents:[NSKeyedArchiver archivedDataWithRootObject:models] attributes:nil];
}

- (NSArray *)unArchiveListWithPath:(NSString *)path
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSFileManager defaultManager] contentsAtPath:path]];
}

- (void)loadArchiveList
{
    if (self.models.count == 0) {
        NSArray *models = [self unArchiveListWithPath:[sandBoxPath stringByAppendingPathComponent:NSStringFromClass([self class])]];
        self.currentOffSet = @"1";
        [self finishDataFetchWithModels:models hasMore:YES currentOffset:@"1" isSection:self.hasSection];
    }
}

- (void)showCOLoadHUD
{
    if (self.currentRefreshType == CORefreshTypeNormal) {
        [self showLoadHUD];
    }
}

@end
