//
//  ViewController.m
//  20160701002-Thread-NSThread
//
//  Created by Rainer on 16/7/1.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 1.使用allock的方式创建NSThread线程
    [self createNSThreadFunction1];
    
    // 2.使用Detach的方式创建NSThread线程
//    [self createNSThreadFunction2];
    
    // 3.使用Perform的方式创建NSThread线程
//    [self createNSThreadFunction3];
}

/**
 *  1.使用Allock的方式创建NSThread线程
 */
- (void)createNSThreadFunction1 {
    // 创建一个NSThread线程对象
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadRunAction:) object:@"Alloc"];

    // 设置线程名称
    thread.name = @"Alloc NSThread";
    
    // 是否是主线程
    BOOL isFlag = [thread isMainThread];
    
    NSLog(@"createNSThreadFunction1方法中当前是否为主线程:[%@]", isFlag ? @"YES" : @"NO");
    
    // 开始线程
    [thread start];
}

/**
 *  2.使用Detach的方式创建NSThread线程
 */
- (void)createNSThreadFunction2 {
    // 从主线程中分离出一个线程的方式创建子线程
    [NSThread detachNewThreadSelector:@selector(threadRunAction:) toTarget:self withObject:@"Detach"];
}

/**
 *  3.使用Perform的方式创建NSThread线程
 */
- (void)createNSThreadFunction3 {
    // 从主线程中分离出一个线程的方式创建子线程
    [self performSelectorInBackground:@selector(threadRunAction:) withObject:@"Perform"];
}

- (void)threadRunAction:(NSString *)param {
    // 是否是主线程
    BOOL isFlag = [[NSThread currentThread] isMainThread];
    
    NSLog(@"threadRunAction方法中当前是否为主线程:[%@]", isFlag ? @"YES" : @"NO");
    
    for (NSInteger i = 0; i < 10000; i++) {
        NSLog(@"[%@]在线程[%@]中Run了[%ld]次", param, [NSThread currentThread], i);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
