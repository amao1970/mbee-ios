//
//  VDJWPlayerVC.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/21.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "VDJWPlayerVC.h"
#import <JWPlayer_iOS_SDK/JWPlayerController.h>

@interface VDJWPlayerVC ()

@property (nonatomic) JWPlayerController *player;

@end

@implementation VDJWPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    JWConfig *config = [[JWConfig alloc] init];
//    config.file = @"";
    self.player = [[JWPlayerController alloc] initWithConfig:config];
    self.player.view.frame = CGRectMake(0, 0, SCR_WIDTH, SCR_WIDTH/16.0f*9);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view addSubview:self.player.view];
}


@end
