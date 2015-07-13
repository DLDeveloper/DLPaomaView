//
//  ViewController.m
//  DLPaomaView
//
//  Created by ssxt on 15/7/13.
//  Copyright (c) 2015年 developerzhang. All rights reserved.
//

#import "ViewController.h"
#import "DLPaomaView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *array = @[@"test1",@"test2",@"test3"];
    DLPaomaView *horizonView = [[DLPaomaView alloc] initWithFrame:CGRectMake(100, 100, 100, 40) backgroundImage:[UIImage imageNamed:@"work_handle.png"] textFont:[UIFont systemFontOfSize:15] intervalTime:2.0 textColor:[UIColor redColor] itemsArray:array DLPaomaViewOrientationStyle:DLPaomaViewHorizontalStyle];
    
    [self.view addSubview:horizonView];
    
    DLPaomaView *verticalView = [[DLPaomaView alloc] initWithFrame:CGRectMake(100, 300, 100, 40) backgroundImage:[UIImage imageNamed:@"work_handle.png"] textFont:[UIFont systemFontOfSize:15] intervalTime:2.0 textColor:[UIColor redColor] itemsArray:array DLPaomaViewOrientationStyle:DLPaomaViewVerticalStyle];
    [self.view addSubview:verticalView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
