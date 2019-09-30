//
//  UILabel+Others.m
//  isWater
//
//  Created by hxisWater on 15/8/21.
//  Copyright (c) 2015年 HX. All rights reserved.
//

#import "UILabel+Others.h"

@implementation UILabel (Others)
-(void)addparagraphStyleWithCGFloat:(CGFloat)lineSpace{
    
    if (self.text.length>0) {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
    }
}


-(void)addNSUnderlinePatternWithRnage:(NSRange )range{
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:range];
    [self setAttributedText:attri];

}
@end
