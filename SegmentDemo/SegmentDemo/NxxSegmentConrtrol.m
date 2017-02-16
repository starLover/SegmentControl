//
//  NxxSegmentConrtrol.m
//  SegmentDemo
//
//  Created by starlover on 2017/2/14.
//  Copyright © 2017年 starlover. All rights reserved.
//

#import "NxxSegmentConrtrol.h"
#import <Masonry.h>

typedef void(^selectBlock)(NSUInteger);

@interface NxxSegmentConrtrol ()

{
    CGRect _frame;
    UIColor *defaultColor;
    UIColor *selectColor;
    NSUInteger _numberOfSegments;
}

@property (nonatomic, strong) CALayer *lineLayer;

@property (nonatomic, copy) selectBlock block;

@end

@implementation NxxSegmentConrtrol

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _frame = frame;
        defaultColor = [UIColor blackColor];
        selectColor = [UIColor redColor];
    }
    return self;
}

- (void)setNumberOfSegments:(NSUInteger)numberOfSegments{
    _numberOfSegments = numberOfSegments;
    NSAssert(numberOfSegments > 0, @"numberOfSegments must be greater than 0");
    CGFloat width = _frame.size.width / numberOfSegments;
    for (NSUInteger i = 0; i < numberOfSegments; i++) {
        UIView *view = [UIView new];
        view.tag = i + 100;
        view.frame = CGRectMake(width * i, 0, width, _frame.size.height);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAction:)];
        [view addGestureRecognizer:tap];
        [self addSubview:view];
        
        //set view's subviews
        UILabel *titleLabel = [UILabel new];
        titleLabel.textColor = defaultColor;
        titleLabel.tag = 1;
        [view addSubview:titleLabel];
        UILabel *numberLabel = [UILabel new];
        numberLabel.textColor = defaultColor;
        numberLabel.tag = 2;
        [view addSubview:numberLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.top.equalTo(@10);
        }];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.bottom.mas_equalTo(-10);
        }];
        
        [titleLabel sizeToFit];
        [numberLabel sizeToFit];
    }
    self.lineLayer.frame = CGRectMake(0, _frame.size.height-5, width, 5);
    self.lineLayer.backgroundColor = selectColor.CGColor;
    [self.layer addSublayer:self.lineLayer];
}

- (void)setSelectAtIndex:(NSUInteger)index animation:(BOOL)animation{
    UIView *view = [self viewWithTag:index + 100];
    if (animation) {
        [self setContentOffsetWithView:view atIndex:index animation:YES];
    } else {
        [self setContentOffsetWithView:view atIndex:index animation:NO];
    }
}


- (void)selectAction:(UITapGestureRecognizer *)tap{
    UIView *view = tap.view;
    NSUInteger index = view.tag - 100;
    
    [self setContentOffsetWithView:view atIndex:index animation:YES];
}

- (void)setContentOffsetWithView:(UIView *)view atIndex:(NSUInteger)index animation:(BOOL)animation{
    
    //change view's color and line's offset
    for (UIView *view in self.subviews) {
        if (view.tag - 100 == index) {
            for (UILabel *label in view.subviews) {
                label.textColor = selectColor;
            }
        } else {
            for (UILabel *label in view.subviews) {
                label.textColor = defaultColor;
            }
        }
    }
    
    CGFloat width = _frame.size.width / _numberOfSegments;
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.3];
    self.lineLayer.frame = CGRectMake(index * width, _frame.size.height-5, width, 5);
    [CATransaction commit];
    
    //sent which segment user's tap
    NSAssert(self.block != nil, @"block must not be nil");
    if (self.block) {
        self.block(index);
    }
}

// handle action
- (void)selectAtIndex:(void (^)(NSUInteger))selectBlock{
    self.block = selectBlock;
}


- (void)setNumber:(NSUInteger)number atIndex:(NSUInteger)index{
    UILabel *label = [self returnNumberAtIndex:index];
    label.text = [NSString stringWithFormat:@"%lu", number];
}
- (void)setTitle:(NSString *)title atIndex:(NSUInteger)index{
    UILabel *label = [self returnTitleAtIndex:index];
    label.text = [NSString stringWithFormat:@"%@", title];
}

// set color and font
- (void)setTitleFont:(UIFont *)titleFont{
    for (UIView *view in self.subviews) {
        UILabel *label = [view viewWithTag:1];
        label.font = titleFont;
    }
}
- (void)setNumberFont:(UIFont *)numberFont{
    for (UIView *view in self.subviews) {
        UILabel *label = [view viewWithTag:2];
        label.font = numberFont;
    }
}

- (void)setTitleColor:(UIColor *)titleColor{
    for (UIView *view in self.subviews) {
        UILabel *label = [view viewWithTag:1];
        label.textColor = titleColor;
    }
}

- (void)setNumberColor:(UIColor *)numberColor{
    for (UIView *view in self.subviews) {
        UILabel *label = [view viewWithTag:2];
        label.textColor = numberColor;
    }
}

- (void)setSelectColor:(UIColor *)color{
    selectColor = color;
}
- (void)setDefaultColor:(UIColor *)color{
    defaultColor = color;
}

- (void)setLineHeight:(NSUInteger)lineHeight{
    CGRect frame = self.lineLayer.frame;
    frame.origin.y = _frame.size.height - lineHeight;
    frame.size.height = lineHeight;
    self.lineLayer.frame = frame;
}

- (void)setTitleTop:(CGFloat)top numberBottom:(CGFloat)bottom{
    for (UIView *view in self.subviews) {
        UILabel *titleLabel = [view viewWithTag:1];
        UILabel *numberLabel = [view viewWithTag:2];
        
        CGRect frame1 = titleLabel.frame;
        CGRect frame2 = numberLabel.frame;
        
        frame1.origin.y = top;
        frame2.origin.y = _frame.size.height-bottom;
        
        titleLabel.frame = frame1;
        numberLabel.frame = frame2;
    }
}

//return title or number Label
- (UILabel *)returnTitleAtIndex:(NSUInteger)index{
    UIView *view = [self viewWithTag:index + 100];
    return [view viewWithTag:1];
}

- (UILabel *)returnNumberAtIndex:(NSUInteger)index{
    UIView *view = [self viewWithTag:index + 100];
    return [view viewWithTag:2];
}

- (CALayer *)lineLayer{
    if (!_lineLayer) {
        _lineLayer = [CALayer layer];
        _lineLayer.backgroundColor = selectColor.CGColor;
    }
    return _lineLayer;
}


@end
