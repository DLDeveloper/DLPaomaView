//
//  DLPaomaView.m
//  DLPaomaView
//
//  Created by ssxt on 15/7/13.
//  Copyright (c) 2015年 developerzhang. All rights reserved.
//

#import "DLPaomaView.h"

#define START_TAG  100

@interface DLPaomaView ()
{
    UIScrollView *_abstractScrollview;
    
    CGPoint _currentOffset;
    
    NSInteger _startIndex;
    
    NSArray *_itemsArray;
    
    UIFont *_textFont;
    
    UIColor *_textColor;
    
    CGFloat _intervalTime;
    
    UIImage *_backgroundImage;
    
    DLPaomaViewOrientationStyle _style;
    
    CGFloat _height;
    
    CGFloat _width;
    
    NSTimer *_timer;
}

-(void)makeUI;

- (void)startTimer;

-(void)releaseTimer;

@end

@implementation DLPaomaView

- (instancetype)initWithFrame:(CGRect)frame backgroundImage:(UIImage *)image textFont:(UIFont *)font intervalTime:(NSInteger)intervalTime textColor:(UIColor *)color itemsArray:(NSArray *)itemsArray DLPaomaViewOrientationStyle:(DLPaomaViewOrientationStyle)style
{
    if (self = [super initWithFrame:frame]) {
        
        _itemsArray = itemsArray;
        
        _backgroundImage = image;
        
        _textFont = font;
        
        _textColor = color;
        
        _intervalTime = intervalTime;
        
        _style = style;
        
        _currentOffset = CGPointMake(0,0);
        
        _width = self.frame.size.width;
        
        _height = self.frame.size.height;
        
        assert([itemsArray count]!=0);
        
        [self makeUI];
        
        [self startTimer];
        
    }
    return self;
}

-(void)makeUI
{
    _startIndex = 0;
    
    _abstractScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,_width,_height)];
    _abstractScrollview.backgroundColor = [UIColor colorWithPatternImage:_backgroundImage];
    
    [self addSubview:_abstractScrollview];
    if (_style == DLPaomaViewHorizontalStyle) {
        _abstractScrollview.contentSize = CGSizeMake((_itemsArray.count + 1) * _width, _height);
        
        for (int i = 0; i < [_itemsArray count]; i++) {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(_width * i, 0, _width, _height)];
            label.text = _itemsArray[i];
            label.textColor = _textColor;
            label.font = _textFont;
            label.tag = START_TAG + i;
            [_abstractScrollview addSubview:label];
            
            if (i == [_itemsArray count]-1) {
                UILabel *labelLast=[[UILabel alloc]initWithFrame:CGRectMake(_width * (i + 1), 0, _width, _height)];
                labelLast.text = _itemsArray[0];
                labelLast.textColor = _textColor;
                labelLast.font = _textFont;
                labelLast.tag = START_TAG + i + 1;
                [_abstractScrollview addSubview:labelLast];
            }
        }
    }else{
        [_abstractScrollview setContentSize:CGSizeMake(_width, ([_itemsArray count]+1)*_height)];
        
        for (int i=0; i<[_itemsArray count]; i++)
        {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, _height*i, _width, _height)];
            label.text = _itemsArray[i];
            label.textColor = _textColor;
            label.font = _textFont;
            label.tag = START_TAG + i;
            [_abstractScrollview addSubview:label];
            
            if (i == [_itemsArray count]-1) {
                UILabel *labelLast=[[UILabel alloc]initWithFrame:CGRectMake(0, _height*(i+1), _width, _height)];
                labelLast.text = _itemsArray[0];
                labelLast.textColor = _textColor;
                labelLast.font = _textFont;
                labelLast.tag = START_TAG + i + 1;
                [_abstractScrollview addSubview:labelLast];
            }
        }
    }
    _abstractScrollview.contentOffset=CGPointMake(0, 0);
}

- (void)startTimer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_intervalTime target:self selector:@selector(updateTitle) userInfo:nil repeats:YES];
    }
}

- (void)releaseTimer
{
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)updateTitle
{
    CGPoint point = _abstractScrollview.contentOffset;
    CGPoint point1 = CGPointMake(0, 0);
    UIView *lastLabel = (UIView *)[_abstractScrollview viewWithTag:(START_TAG + _itemsArray.count)];
    
    if (_style == DLPaomaViewHorizontalStyle) {
        if (point.x >= lastLabel.frame.origin.x) {
            _startIndex = 0;
            _abstractScrollview.contentOffset = point1;
        }
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDuration:_intervalTime];
        [UIView setAnimationDelegate:self];
        
        UIView *currentView = (UIView *)[_abstractScrollview viewWithTag:(START_TAG  + _startIndex + 1)];
        CGPoint pointmiddle = CGPointMake(currentView.frame.origin.x, 0);
        
        _startIndex ++;
        _abstractScrollview.contentOffset = pointmiddle;
        
        [UIView commitAnimations];
    }else{
        if (point.y >= lastLabel.frame.origin.y) {
            _startIndex = 0;
            _abstractScrollview.contentOffset = _currentOffset;
        }
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDuration:_intervalTime];
        [UIView setAnimationDelegate:self];
        
        UIView *currentView = (UIView *)[_abstractScrollview viewWithTag:(START_TAG  + _startIndex + 1)];
        CGPoint pointmiddle = CGPointMake(0, currentView.frame.origin.y);
        
        _startIndex ++;
        _abstractScrollview.contentOffset = pointmiddle;
        
        [UIView commitAnimations];
    }
}

- (void)dealloc
{
    [self releaseTimer];
}

@end
