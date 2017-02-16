//
//  ViewController.m
//  SegmentDemo
//
//  Created by starlover on 2017/2/14.
//  Copyright © 2017年 starlover. All rights reserved.
//

#import "ViewController.h"
#import "NxxSegmentConrtrol.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NxxSegmentConrtrol *segmentControl = [[NxxSegmentConrtrol alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 80)];
    segmentControl.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //设置个数
    segmentControl.numberOfSegments = 4;
    segmentControl.titleFont = [UIFont systemFontOfSize:16];
    segmentControl.numberFont = [UIFont systemFontOfSize:13];
    for (int i = 0; i < 4; i++) {
        //设置相对应的文字等
        [segmentControl setTitle:@"我的" atIndex:i];
        [segmentControl setNumber:1 atIndex:i];
    }
    [self.view addSubview:segmentControl];
    [segmentControl selectAtIndex:^(NSUInteger index) {
        NSLog(@"%lu", index);
    }];
    [segmentControl setSelectAtIndex:2 animation:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
