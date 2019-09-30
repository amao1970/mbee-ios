//
//  UIView+JXMethods.m
//  webSnifferLW
//
//  Created admso on 2017/6/27.
//
//

#import "UIView+JXMethods.h"

@implementation UIView (JXMethods)

// 添加水平线
-(void)addHorizontalLine
{
    [self addHorizontalLineWithTop:NO bottom:NO];
}

-(void)addHorizontalLineWithTop:(BOOL)topHidde bottom:(BOOL)bottomHidde
{
    UIView *lineTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
    lineTop.backgroundColor = Color(199, 199, 199);
    lineTop.hidden = topHidde;
    [self addSubview:lineTop];
    
    UIView *lineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
    lineBottom.backgroundColor = Color(199, 199, 199);
    lineBottom.hidden = bottomHidde;
    [self addSubview:lineBottom];
}


+(instancetype)getViewFormNSBunld
{
    Class controllerClass = [self class];
    
    return [[NSBundle mainBundle] loadNibNamed:
            NSStringFromClass(controllerClass) owner:nil options:nil ].lastObject;
}

-(void)updateUI
{
    for (UIView *temp in self.subviews) {
        temp.frame = JXRectMake(temp.x, temp.y, temp.width, temp.height);
        for (UIView *temp1 in temp.subviews) {
            temp1.frame = JXRectMake(temp1.x, temp1.y, temp1.width, temp1.height);
        }
    }
}

-(void)jx_setCornerRadius:(float)cornerRadius
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

-(void)jx_setUpCornerRadius
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.height/2.f;
}



@end
