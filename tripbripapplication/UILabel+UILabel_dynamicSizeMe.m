//
//  UILabel+UILabel_dynamicSizeMe.m
//  tripbripapplication
//
//  Created by mac on 1/6/17.
//  Copyright © 2017 mac. All rights reserved.
//

#import "UILabel+UILabel_dynamicSizeMe.h"

@implementation UILabel (UILabel_dynamicSizeMe)
-(float)resizeToFit{
    float height = [self expectedHeight];
    CGRect newFrame = [self frame];
    newFrame.size.height = height;
    [self setFrame:newFrame];
    return newFrame.origin.y + newFrame.size.height;
}

-(float)expectedHeight{
    [self setNumberOfLines:0];
    [self setLineBreakMode:UILineBreakModeWordWrap];
    
    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width,9999);
    
    CGSize expectedLabelSize = [[self text] sizeWithFont:[self font]
                                       constrainedToSize:maximumLabelSize
                                           lineBreakMode:[self lineBreakMode]];
    return expectedLabelSize.height;
}

@end
