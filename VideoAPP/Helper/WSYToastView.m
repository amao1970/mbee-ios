//
//  Xuebei
//
//  Created by maceasy on 15/11/25.
//  Copyright © 2015年 macHY. All rights reserved.
//

#import "WSYToastView.h"
#import "NSString+Extension.h"
#import "UIView+Extension.h"
@interface WSYToastView()

@property (weak,nonatomic) UILabel *title;

@end

@implementation WSYToastView

+ (instancetype)toastWithString:(NSString *)string
{
    return [[self alloc] initToastWithString:string];
}

- (instancetype)initToastWithString:(NSString *)string
{
    self = [super init];
    if (self) {
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height/2;
        
//        CGSize textMaxSize = CGSizeMake(width - 60, MAXFLOAT);
        CGSize stringSize =[string sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}];

        
        CGFloat finalY = (height - 20 - stringSize.height) * 0.8;
        CGRect fra = CGRectMake((width - stringSize.width - 40) * 0.5, finalY, stringSize.width + 40, 20 + stringSize.height);
        
        [self setFrame:CGRectMake((width - stringSize.width - 40) * 0.5, finalY+30, stringSize.width + 40, 20 + stringSize.height)];
        
        //添加文字说明
        UILabel *title = [[UILabel alloc] init];
        [self addSubview:title];
        [title setText:string];
        title.numberOfLines = 0;
        title.textColor = [UIColor hexStringToColor:@"666666"];
//        [title setTextColor:Color(220, 220, 220)];
        [title setFont:[UIFont systemFontOfSize:14]];
        title.textAlignment = NSTextAlignmentCenter;
        self.title = title;
        self.backgroundColor = [UIColor cyanColor];
  
        CGRect titleFrame = self.bounds;
        titleFrame.origin.x += 10;
        titleFrame.origin.y += 5;
        titleFrame.size.width -= 20;
        titleFrame.size.height -= 10;
        [self.title setFrame:titleFrame];
        
        [self layerForViewWith:10 AndLineWidth:1.0];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
//        self.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        CGRect finalRect = fra;
        finalRect.origin.y += 5;
        [UIView animateWithDuration:0.2 animations:^{
            [self setFrame:fra];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                [self setFrame:finalRect];
            }];
        }];
    }
    return self;
}

- (void)finish
{
    [self removeFromSuperview];
}


@end
