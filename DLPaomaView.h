//
//  DLPaomaView.h
//  DLPaomaView
//
//  Created by ssxt on 15/7/13.
//  Copyright (c) 2015年 developerzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger,DLPaomaViewOrientationStyle){
    DLPaomaViewHorizontalStyle,
    DLPaomaViewVerticalStyle,
};

@interface DLPaomaView : UIView

- (instancetype)initWithFrame:(CGRect)frame backgroundImage:(UIImage *)image textFont:(UIFont *)font intervalTime:(NSInteger)intervalTime textColor:(UIColor *)color itemsArray:(NSArray *)itemsArray DLPaomaViewOrientationStyle:(DLPaomaViewOrientationStyle)style;

@end