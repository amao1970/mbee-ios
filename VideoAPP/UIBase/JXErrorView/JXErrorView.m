//
//  JXErrorView.m
//  Hemefin_iOS
//
//  Created by admxjx on 2017/10/20.
//  Copyright © 2017年 Hemefin. All rights reserved.
//

#import "JXErrorView.h"

@interface JXErrorView ()

@property (strong, nonatomic) AFNetworkReachabilityManager *manager;

@end

@implementation JXErrorView

-(id)initWithMDErrorShowView:(CGRect)MDErrorShowViewFarm contentShowString:(NSString *)contentShowString MDErrorShowViewType:(JXErrorViewType)ErrorType theDelegate:(id<JXErrorViewDelegate>) theDelegate{
    self = [JXErrorView getViewFormNSBunld];
    if (self) {
        [self updateUI];
        self.frame = MDErrorShowViewFarm;
        
        self.imgView.centerY = MDErrorShowViewFarm.size.height/2.f - self.imgView.height;
        self.titleLab.y = self.imgView.bottom + 10;
        delegate = theDelegate;
        self.titleLab.text = contentShowString;
        
        
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap_reload)];
        [self addGestureRecognizer:gestureRecognizer];
    }
    return self;
}

-(void)jx_setUpTitle:(NSString*)title
{
    self.titleLab.text = title;
}

-(void)ReachabilityStatus
{
    
    
}

-(void)dealloc{
    NSLog(@"____dealloc____");
}

-(void)removeFromSuperview
{
    NSLog(@"____removeFromSuperview____");
}

-(void)tap_reload{
//    [delegate againLoadingDataWithTag:self.tag];
    NSLog(@"______刷新页面______");
}


@end
