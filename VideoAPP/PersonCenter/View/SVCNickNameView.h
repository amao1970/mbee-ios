//
//  SVCNickNameView.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/2/23.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVCNickNameView : JXView

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *close;
@property (strong, nonatomic) IBOutlet UIButton *commit;

@end

NS_ASSUME_NONNULL_END
