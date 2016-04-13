//
//  CYModelTableViewController.h
//  StructureProject
//
//  Created by ChenYJ on 15/7/20.
//  Copyright (c) 2015年 ChenYJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYBaseViewController.h"

@interface CYModelTableViewController : CYBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
/** All the models should be put in this array. PS: We only support one section tableview currently.
 */
@property (nonatomic, strong) NSMutableArray *models;

@property (nonatomic, assign) BOOL hasSection;

- (instancetype)initWithStyle:(UITableViewStyle)style;

/** Use this method to inheritedly confgure cells.*/
- (void)configureCell:(UITableViewCell<CYModelBinding> *)cell forIndexPath:(NSIndexPath *)indexPath __attribute__((objc_requires_super));
- (void)loadCellModelMapping;

- (void)registerModelClass:(Class)modelClass mappedCellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier;

- (NSArray *)registeredModelClasses;

- (Class)mappedCellClassForModelClass:(Class)modelClass;
- (NSString *)mappedReuseIdentifierForModelClass:(Class)modelClass;

@end
