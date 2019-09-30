//
//  VDUploadVideoView.h
//  VideoAPP
//
//  Created by admxjx on 2019/5/6.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VDUploadVideoView : JXView

@property (strong, nonatomic) IBOutlet UIButton *uploadVideo;
@property (strong, nonatomic) IBOutlet UIButton *uploadImg;
@property (strong, nonatomic) IBOutlet UITextField *tagLab;
@property (strong, nonatomic) IBOutlet UITextView *descLab;
@property (strong, nonatomic) IBOutlet UIButton *commit;
@property (strong, nonatomic) IBOutlet UITextField *titleTF;
@property (strong, nonatomic) IBOutlet UITextField *videoLab;
@property (strong, nonatomic) IBOutlet UITextField *imgLab;



@end

NS_ASSUME_NONNULL_END
