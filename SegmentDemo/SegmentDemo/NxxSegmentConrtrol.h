//
//  NxxSegmentConrtrol.h
//  SegmentDemo
//
//  Created by starlover on 2017/2/14.
//  Copyright © 2017年 starlover. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NxxSegmentConrtrol : UIView

@property (nonatomic, assign) NSUInteger numberOfSegments; 
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *numberFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *numberColor;
@property (nonatomic, assign) NSUInteger lineHeight;

/*
 set 0.1.2... for segment which index you need. 
 set title ...
 */
- (void)setNumber:(NSUInteger)number atIndex:(NSUInteger)index;
- (void)setTitle:(NSString *)title atIndex:(NSUInteger)index;

- (void)setDefaultColor:(UIColor *)color; //normal color
- (void)setSelectColor:(UIColor *)color;  //select color

- (void)setTitleTop:(CGFloat)top numberBottom:(CGFloat)bottom;

- (void)selectAtIndex:(void(^)(NSUInteger index))selectBlock;

- (void)setSelectAtIndex:(NSUInteger)index animation:(BOOL)animation;

@end
