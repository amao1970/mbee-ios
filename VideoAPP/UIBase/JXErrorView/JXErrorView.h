//
//  JXErrorView.h
//  Hemefin_iOS
//
//  Created by admxjx on 2017/10/20.
//  Copyright © 2017年 Hemefin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JXErrorViewType){
    NoNetwork = 0,
    NoData = 1,
    againRequestData = 2,
    NoRedenveLope = 3 //后添加 没有红包
};

@protocol JXErrorViewDelegate <NSObject>
-(void)againLoadingDataWithTag:(NSInteger)tag;
@end


@interface JXErrorView : UIView{
    id<JXErrorViewDelegate> delegate;
}

//@property (strong, nonatomic) IBOutlet UILabel *noNetLab;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
-(id)initWithMDErrorShowView:(CGRect)MDErrorShowViewFarm contentShowString:(NSString *)contentShowString MDErrorShowViewType:(JXErrorViewType)ErrorType theDelegate:(id<JXErrorViewDelegate>) theDelegate;
-(void)jx_setUpTitle:(NSString*)title;
@end
