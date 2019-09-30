//
//  PlainTableViewController.h
//  DeJiaAssistant
//
//  Created by yoky on 15/11/25.
//  Copyright © 2015年  rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlainTableViewController : SVCBaseViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@end
