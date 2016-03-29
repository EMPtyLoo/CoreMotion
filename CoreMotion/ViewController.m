//
//  ViewController.m
//  CoreMotion
//
//  Created by EMPty on 3/29/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>//导入头文件

@interface ViewController ()
@property (nonatomic,strong)     CMMotionManager* motionManager;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建运动管理者对象
    _motionManager = [[CMMotionManager alloc]init];
    
    //2.判断加速计是否可用（最好判断）
    if (_motionManager.isAccelerometerAvailable)
    {
        NSLog(@"加速计可用");
        //开始采样
        [_motionManager startAccelerometerUpdates]; //pull,不需要设置采样时间
        
        
        
    }
    else
    {
        NSLog(@"加速计不可用");
    }
    



}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
#pragma mark 是个结构体  不用指针*
    CMAcceleration acc = _motionManager.accelerometerData.acceleration;
    NSLog(@"X:%f,Y:%f,Z:%f",acc.x,acc.y,acc.z);

}


- (void)push
{
    //1.创建运动管理者对象
    _motionManager = [[CMMotionManager alloc]init];

    //2.判断加速计是否可用（最好判断）
    if (_motionManager.isAccelerometerAvailable) {
        NSLog(@"加速计可用");
    
        //3.设置采样间隔
        //常用属性 方法
        //motionManager.isAccelerometerActive//是否正在采集
        //motionManager.accelerometerData//采集到的数据
        
        //startAccelerometerUpdates pull
        //startAccelerometerUpdatesToQueue push
        
        
        _motionManager.accelerometerUpdateInterval = 1/30.0;//采样间隔
        
        //4.开始采样（采样到的数据会调用handler，handler会在queue中执行）
        
        
        //实时采集
        //队列选择主队列
        [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData* data,NSError* error)
         {
             if (error) {
                 
                 return ;//有错误返回
             }
             //这个block是采集到数据时会调用
             
             NSLog(@"X:%f,Y:%f,Z:%f",data.acceleration.x,data.acceleration.y,data.acceleration.z);
             
             
         }];
        
        
    }
    else
    {
        NSLog(@"加速计不可用");
    }
    
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
