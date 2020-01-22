//
//  UIView+Border.m
//  Videre
//
//  Created by Luokey on 12/29/15.
//  Copyright © 2015 Luokey. All rights reserved.
//

#import "UIView+Border.h"

@implementation UIView (Border)

@dynamic borderColor, borderWidth, cornerRadius;

- (void)setBorderColor:(UIColor *)borderColor {
    
    [self.layer setBorderColor:borderColor.CGColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    
    [self.layer setBorderWidth:borderWidth];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:cornerRadius];
}

@end