//
//  WsHUD.m
//  TestHUD
//
//  Created by huaan on 12-2-27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "WsHUD.h"
#import "AppDelegate.h"

@implementation WsHUD


+(void)showHUDWithLabel:(NSString*)text modal:(BOOL)isModalMode timeoutDuration:(NSInteger)duration {
    WsHUD *hud=[[WsHUD alloc] initWithLabel:text style:HUD_STYLE_INDICATOR modal:isModalMode];
    
    if (duration>0) {
        //N秒后自动隐藏。
        [hud performSelector:@selector(timeout) withObject:nil afterDelay:duration];
    }//如果不自动隐藏，用户需要在外部调用隐藏HUD。
    
    [hud showUsingAnimated:YES];
}

+(void)showHUDWithIconStyle:(NSInteger)iconStyle label:(NSString*)text {
    WsHUD *hud=[[WsHUD alloc] initWithLabel:text style:iconStyle modal:NO];
    [hud showUsingAnimated:YES];
    [hud performSelector:@selector(hideUsingAnimated:) withObject:[NSNumber numberWithBool:YES] afterDelay:3];
}


+(void)showHUDWithLabel:(NSString*)text operation:(NSInvocationOperation*)operation {
    WsHUD *hud=[[WsHUD alloc] initWithLabel:text style:HUD_STYLE_INDICATOR modal:YES];
    [hud showUsingAnimated:YES];
    
    NSOperationQueue *quene=[NSOperationQueue new];
    [quene setMaxConcurrentOperationCount:1];
    
    NSInvocationOperation *hideOperation=[[NSInvocationOperation alloc] initWithTarget:[WsHUD class] selector:@selector(findAndHideHUD:) object:[NSNumber numberWithBool:YES]];
    [quene addOperation:operation];
    [quene addOperation:hideOperation];
}

-(id)initWithLabel:(NSString*)text style:(NSInteger)aStyle modal:(BOOL)isModalMode {
    modalMode=isModalMode;
    
    if (text==nil) {
        text=DEFAULT_WAITING_STRING;
    }
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    UIWindow *win = appDelegate.window;
    UIFont *font=[UIFont boldSystemFontOfSize:15];
    CGSize fontSize=[text sizeWithFont:font constrainedToSize:CGSizeMake(180, 21)];
    
    width=(fontSize.width<(HUD_MIN_WIDTH-40) ? HUD_MIN_WIDTH : fontSize.width+40);
    
    if (modalMode) {
        self=[self initWithFrame:CGRectMake(0, 20, win.bounds.size.width, win.bounds.size.height-20)];
    } else {
        self=[self initWithFrame:CGRectMake(0, 64, win.bounds.size.width, win.bounds.size.height-64)];
    }
    
    UIView *iconView=nil;
    
    if (aStyle==HUD_STYLE_INDICATOR) {
        UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        indicator.frame=CGRectMake((self.bounds.size.width-indicator.bounds.size.width)/2, (self.bounds.size.height+(modalMode ? 44 : 0) - HUD_HEIGHT) / 2-20, indicator.bounds.size.width, indicator.bounds.size.height);
        [self addSubview:indicator];
        [indicator startAnimating];
        iconView=indicator;
    } else {
        UIImage *iconImage=nil;
        if (aStyle==HUD_STYLE_ICON_INFO) {
            iconImage=[UIImage imageNamed:@"hud_icon_info.png"];
        } else if (aStyle==HUD_STYLE_ICON_DONE) {
            iconImage=[UIImage imageNamed:@"hud_icon_done.png"];
        } else {
            iconImage=[UIImage imageNamed:@"hud_icon_error.png"];
        }
        
        
        UIImageView *iconImageView=[[UIImageView alloc] initWithImage:iconImage];
        iconImageView.frame=CGRectMake((self.bounds.size.width-iconImageView.bounds.size.width)/2, (self.bounds.size.height+(modalMode ? 44 : 0) - HUD_HEIGHT) / 2-20, iconImageView.bounds.size.width, iconImageView.bounds.size.height);
        [self addSubview:iconImageView];
        iconView=iconImageView;
    }
    
    UILabel *textLabel=[[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width - width) / 2+10, iconView.frame.origin.y+iconView.bounds.size.height+6, width-20, 21)];
    textLabel.font=font;
    textLabel.text=text;
    textLabel.textColor=[UIColor whiteColor];
    textLabel.backgroundColor=[UIColor clearColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:textLabel];
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    //self.backgroundColor=[UIColor greenColor];
    //显示之前，先查找之前的HUD，如果存在，隐藏掉
    [WsHUD findAndHideHUD:NO];
    self.opaque=NO;
    //alpha=0.6;
    self.tag=HUD_TAG;
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Center HUD
    // Draw rounded HUD bacgroud rect
    CGFloat alpha=0.8;
    CGRect boxRect = CGRectMake((self.bounds.size.width - width) / 2,
                                (self.bounds.size.height+(modalMode ? 44 : 0) - HUD_HEIGHT) / 2-40, width, HUD_HEIGHT);
    CGContextRef context = UIGraphicsGetCurrentContext();
    float radius = 8.0f;
    CGContextBeginPath(context);
    CGContextSetGrayFillColor(context, 0.0, alpha);
    CGContextMoveToPoint(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect));
    CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMinY(boxRect) + radius, radius, 3 * M_PI / 2, 0, 0);
    CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMaxY(boxRect) - radius, radius, 0, M_PI / 2, 0);
    CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMaxY(boxRect) - radius, radius, M_PI / 2, M_PI, 0);
    CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect) + radius, radius, M_PI, 3 * M_PI / 2, 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
}

+(void)findAndHideHUD:(BOOL)animated {
    //NSLog(@"findAndHideHUD");
    if ([NSThread isMainThread] == NO) {
        [[WsHUD class] performSelectorOnMainThread:@selector(findAndHideHUD:) withObject:[NSNumber numberWithBool:animated] waitUntilDone:NO];
        return;
    }

    UIWindow *topWindow = nil;
    //将提示放到键盘上面
    for (int i=0; i<[[[UIApplication sharedApplication] windows] count]; i++) {
        topWindow = [[[UIApplication sharedApplication] windows] objectAtSafeIndex:i];
        NSString *topViewClassName = [NSString stringWithFormat:@"%@", [topWindow class]];
        if  ([topViewClassName isEqualToString:@"UITextEffectsWindow"]){
            break;
        }else{
            topWindow = nil;
        }
    }
    if (topWindow == nil) {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        topWindow = appDelegate.window;
    }
    WsHUD *lastHUD = (WsHUD*)[topWindow viewWithTag:HUD_TAG];
    if (lastHUD) {
        //NSLog(@"find:%p",lastHUD);
        [lastHUD hideUsingAnimated:animated];
    }
}


-(void)showUsingAnimated:(BOOL)animated {
    //NSLog(@"showUsingAnimated");
    UIWindow *topWindow = nil;
    //将提示放到键盘上面
    for (int i=0; i<[[[UIApplication sharedApplication] windows] count]; i++) {
        topWindow = [[[UIApplication sharedApplication] windows] objectAtSafeIndex:i];
        NSString *topViewClassName = [NSString stringWithFormat:@"%@", [topWindow class]];
        if  ([topViewClassName isEqualToString:@"UITextEffectsWindow"]){
            break;
        }else{
            topWindow = nil;
        }
    }
    if (topWindow == nil) {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        topWindow = appDelegate.window;
    }
    for (UIView *subView in topWindow.subviews) {
        if ([subView isMemberOfClass:[self class]]) {
            [subView removeFromSuperview];
        }
    }
    [topWindow addSubview:self];
    if (animated) {
        self.alpha=0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.6];
        self.alpha = 1.0;
        [UIView commitAnimations];
    }
    else {
        self.alpha = 1.0;
    }
    //NSLog(@"show super view:%@",self.superview);
}

+(void)hideHUD {
    //NSLog(@"hideHUD");
    if ([NSThread isMainThread] == NO) {
        [[WsHUD class] performSelectorOnMainThread:@selector(hideHUD) withObject:nil waitUntilDone:NO];
        return;
    }
    
    UIWindow *topWindow = nil;
    //将提示放到键盘上面
    for (int i=0; i<[[[UIApplication sharedApplication] windows] count]; i++) {
        topWindow = [[[UIApplication sharedApplication] windows] objectAtSafeIndex:i];
        NSString *topViewClassName = [NSString stringWithFormat:@"%@", [topWindow class]];
        if  ([topViewClassName isEqualToString:@"UITextEffectsWindow"]){
            break;
        }else{
            topWindow = nil;
        }
    }
    if (topWindow == nil) {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        topWindow = appDelegate.window;
    }
    WsHUD *lastHUD = (WsHUD*)[topWindow viewWithTag:HUD_TAG];
    if (lastHUD) {
        //NSLog(@"find:%p",lastHUD);
        [lastHUD hideUsingAnimated:NO];
    }
}

-(void)hideUsingAnimated:(BOOL)animated {
    self.tag = -1;
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.6];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
        self.alpha = 0.02;
        [UIView commitAnimations];
    }
    else {
        [self removeFromSuperview];
    }
}

//-(void)timeout {
//    invalid=YES;
//    [self performSelector:@selector(showTimeoutAlert)];
//}

//-(void)showTimeoutAlert {
-(void)timeout {
    //NSLog(@"super view:%@",self.superview);
    if (self.superview) {
        //如果对话框没有被提前隐藏，隐藏掉
        [self hideUsingAnimated:YES];//如果在超时之前，HUD仍然是有效的，显示提示框
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:DEFAULT_TIMEOUT_STRING delegate:nil cancelButtonTitle:OK_STRING otherButtonTitles:nil, nil];
        
        [alert show];
    }
}

- (void)dealloc
{
}

@end
