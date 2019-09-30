//
//  WsHUD.h
//  TestHUD
//
//  Created by huaan on 12-2-27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



#define HUD_TAG 861126

#define HUD_MIN_WIDTH   138
#define HUD_HEIGHT  102


#define HUD_STYLE_INDICATOR 0   //转圈
#define HUD_STYLE_ICON_INFO  1  //感叹号图标
#define HUD_STYLE_ICON_DONE  2  //完成图标
#define HUD_STYLE_ICON_ERROR  3 //错误图标


//可在工程中对下列用到的默认字符国际化
#define DEFAULT_WAITING_STRING  @"请稍候..."
#define DEFAULT_TIMEOUT_STRING  @"请求超时！"
#define OK_STRING  @"确定"
//

@interface WsHUD : UIView {
    BOOL modalMode;
    NSInteger width;
}

/**********************外部方法******************/
/*第一个参数可传nil，会显示默认的“请稍候...”*/
+(void)showHUDWithLabel:(NSString*)text modal:(BOOL)isModalMode timeoutDuration:(NSInteger)duration;
+(void)showHUDWithIconStyle:(NSInteger)iconStyle label:(NSString*)text;
+(void)showHUDWithLabel:(NSString*)text operation:(NSInvocationOperation*)operation;
+(void)findAndHideHUD:(BOOL)animated;
+(void)hideHUD;
/**********************************************/


/**********************内部方法，外部不要调用******************/
-(id)initWithLabel:(NSString*)text style:(NSInteger)aStyle modal:(BOOL)isModalMode;
-(void)showUsingAnimated:(BOOL)animated;
-(void)hideUsingAnimated:(BOOL)animated;
/**********************************************/

@end
