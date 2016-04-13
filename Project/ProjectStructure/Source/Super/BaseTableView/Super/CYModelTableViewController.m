//
//  CYModelTableViewController.m
//  StructureProject
//
//  Created by ChenYJ on 15/7/20.
//  Copyright (c) 2015年 ChenYJ. All rights reserved.
//

#import "CYModelTableViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface CYModelTableViewController ()
{
    UITableViewStyle _style;
}

@property (nonatomic, strong) NSMutableDictionary *modelCellClassMap;
@property (nonatomic, strong) NSMutableDictionary *modelReuseIdentifierMap;

@end

@implementation CYModelTableViewController

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
        }
#endif
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init]) {
        _style = style;
    }
    return self;
}

- (NSMutableDictionary *)modelCellClassMap
{
    if (_modelCellClassMap == nil) {
        _modelCellClassMap = [[NSMutableDictionary alloc] init];
    }
    return _modelCellClassMap;
}

- (NSMutableDictionary *)modelReuseIdentifierMap
{
    if (_modelReuseIdentifierMap == nil) {
        _modelReuseIdentifierMap = [[NSMutableDictionary alloc] init];
    }
    return _modelReuseIdentifierMap;
}

- (NSMutableArray *)models
{
    if (_models == nil) {
        _models = [[NSMutableArray alloc] init];
    }
    return _models;
}

- (NSArray *)registeredModelClasses
{
    return self.modelCellClassMap.allKeys;
}

#pragma mark - UIViewController Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:_style];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:self.tableView];
    
    [self loadCellModelMapping];
}

#pragma mark - APIs

- (void)configureCell:(UITableViewCell<CYModelBinding> *)cell forIndexPath:(NSIndexPath *)indexPath
{
    // should be implemented by subclass
}

- (void)loadCellModelMapping
{
    // should be implemented by subclass
}

- (void)registerModelClass:(Class)modelClass mappedCellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier
{
    if (![cellClass isSubclassOfClass:[UITableViewCell class]] || reuseIdentifier.length == 0) {
        NSLog(@"Failed to register model and cell classes to ModelTableViewController. %@ is not the subclass of XIMModel or %@ is illegal.", modelClass, reuseIdentifier);
        return;
    }
    if (![cellClass conformsToProtocol:@protocol(CYModelBinding)]) {
        NSLog(@"Failed to register model and cell classes. %@ doesn't conform to XIMModelBinding protocol", cellClass);
        return;
    }
    
    NSString *modelClassString = NSStringFromClass(modelClass);
    self.modelCellClassMap[modelClassString] = NSStringFromClass(cellClass);
    self.modelReuseIdentifierMap[modelClassString] = reuseIdentifier;
}

- (Class)mappedCellClassForModelClass:(Class)modelClass
{
    NSString *cellClassName = self.modelCellClassMap[NSStringFromClass(modelClass)];
    if (cellClassName == nil) NSLog(@"%@ not registered with a cellClass", modelClass);
    return NSClassFromString(cellClassName);
}

- (NSString *)mappedReuseIdentifierForModelClass:(Class)modelClass
{
    NSString *reuseIdentifier = self.modelReuseIdentifierMap[NSStringFromClass(modelClass)];
    if (reuseIdentifier == nil) NSLog(@"%@ not registered with a reuseIdentifier", modelClass);
    return reuseIdentifier;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_hasSection) {
        return self.models.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //We only support one section tableview currently.
    if (_hasSection) {
        return [self.models[section] count];
    }
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject *model;
    if (_hasSection) {
        model = self.models[indexPath.section][indexPath.row];
    }else{
        model = self.models[indexPath.row];
    }

    Class cellClass = [self mappedCellClassForModelClass:model.class];
    [cellClass heightWithModel:model];
    return [cellClass heightWithModel:model];
    
//    NSObject *model = self.models[indexPath.row];
//    Class cellClass = [self mappedCellClassForModelClass:model.class];
//    [cellClass heightWithModel:self.models[indexPath.row]];
//    return [cellClass heightWithModel:self.models[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject *model;
    if (_hasSection) {
        model = self.models[indexPath.section][indexPath.row];
    }else{
        model = self.models[indexPath.row];
    }
    
    NSString *cellIdentifier = [self mappedReuseIdentifierForModelClass:model.class];
    UITableViewCell<CYModelBinding> *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        Class cellClass = [self mappedCellClassForModelClass:model.class];
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.model = (BaseModel *)model;
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
    
    
//    NSObject *model = self.models[indexPath.row];
//    NSString *cellIdentifier = [self mappedReuseIdentifierForModelClass:model.class];
//    UITableViewCell<CYModelBinding> *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    if (cell == nil) {
//        Class cellClass = [self mappedCellClassForModelClass:model.class];
//        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
//    
//    cell.model = (BaseModel *)model;
//    [self configureCell:cell forIndexPath:indexPath];
//    
//    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // should be implemented by subclass
}

@end
