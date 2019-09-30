//
//  SVCMovieTableViewController.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/24.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlainTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVCMovieTableViewController : PlainTableViewController

- (instancetype)initWithCategoryID:(NSString *)ID;
@end

NS_ASSUME_NONNULL_END
