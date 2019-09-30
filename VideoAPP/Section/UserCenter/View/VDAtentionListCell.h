//
//  VDAtentionListCell.h
//  VideoAPP
//
//  Created by admxjx on 2019/5/19.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface VDAtentionListCell : JXTableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *descLab;
@property (strong, nonatomic) IBOutlet UILabel *fansLab;
@property (strong, nonatomic) IBOutlet UIButton *cancelbut;
@property (assign, nonatomic) BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
