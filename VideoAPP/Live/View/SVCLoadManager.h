//
//  SVCLoadManager.h
//  SmartValleyCloudSeeding
//
//  Created by xumin on 2018/6/21.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVCLoadManager : NSObject

+(instancetype)shareManagare;

-(void)showLoadIng;
-(void)HideLoadIng;
@end
