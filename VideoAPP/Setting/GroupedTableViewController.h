//
//  GroupedTableViewController.h
//  DancePublic
//
//  Created by tsingning on 16/1/28.
//  Copyright © 2016年  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupedTableViewController : SVCBaseViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@end
