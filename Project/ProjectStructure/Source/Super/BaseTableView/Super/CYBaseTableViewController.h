//
//  CYVSModelTableViewController.h
//  StructureProject
//
//  Created by ChenYJ on 15/7/20.
//  Copyright (c) 2015年 ChenYJ. All rights reserved.
//

#import "CYModelTableViewController.h"
#import "MJRefresh.h"

//typedef NS_ENUM (NSUInteger, COUpPushToRefreshType) {
//    COUpPushToRefreshTypeNormal = 0,
//    COUpPushToRefreshTypeTapped = 1,
//};

typedef NS_ENUM (NSUInteger, CORefreshType) {
    CORefreshTypeNormal = 0,
    CORefreshTypeDownPush = 1,
    CORefreshTypeUpPush = 2,
};

@interface CYBaseTableViewController : CYModelTableViewController
{
    NSString *_enablePullUpToRefreshLoadingText;
    NSString *_enablePullUpToRefreshBeforeLoadText;
    NSString *_enablePullUpToRefreshNilDataText;
    
    NSString *_enableNilModelsAlertTest;
    
    // extension
    UIView *_headPanel;
    UIView *_footPanel;
}
// default is COUpPushToRefreshTypeNormal.
//@property (nonatomic, assign) COUpPushToRefreshType upPushType;
@property (nonatomic, strong) NSString *currentOffSet;
@property (nonatomic, strong, readonly) NSString *offset;

//@property (nonatomic, strong) SRRefreshView *refreashView;
@property (nonatomic, assign) BOOL enablePullDownToRefresh;
@property (nonatomic, assign) BOOL enablePullUpToRefresh;

@property (nonatomic, strong) NSString *enablePullUpToRefreshLoadingText;     // <设置启用上拉刷新后
@property (nonatomic, strong) NSString *enablePullUpToRefreshBeforeLoadText;  //  在刷新前、刷新时和刷新后刷新控
@property (nonatomic, strong) NSString *enablePullUpToRefreshNilDataText;     //  件分别显示的文字。

@property (nonatomic, strong) NSString *enableNilModelsAlertTest;  // 当数据为0时提示用语
@property (nonatomic, strong) UIButton *upRefreshButton;
@property (nonatomic, assign) BOOL hasMore;

@property (nonatomic, assign) NSInteger fetchingNumber; // 正在执行获取的进程数
- (void)fetchDataWithOffset:(NSString *)offset __attribute__((objc_requires_super));
- (void)finishDataFetchWithModels:(NSArray *)models hasMore:(BOOL)hasMore currentOffset:(NSString *)currentOffset isSection:(BOOL) isSection __attribute__((objc_requires_super));

- (void)beginRefresh;
- (void)beginDownPushRefreshing __attribute__((objc_requires_super));
//- (void)stopRefresh;
//- (void)beginUpPushToRefreshing __attribute__((objc_requires_super));

@property (nonatomic, assign) CORefreshType currentRefreshType;

// extension

@property (nonatomic, strong) UIView *headPanel;
@property (nonatomic, strong) UIView *footPanel;

#pragma mark - extension archive list
@property (nonatomic, assign) BOOL isUseArchive; // default is No.
- (void)archiveListWithPath:(NSString *)path models:(NSArray *)models;
- (NSArray *)unArchiveListWithPath:(NSString *)path;
- (void)loadArchiveList;

- (void)showCOLoadHUD;


@end
