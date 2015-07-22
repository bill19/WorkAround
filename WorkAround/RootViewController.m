//
//  RootViewController.m
//  WorkAround
//
//  Created by sunhao on 15-7-21.
//  Copyright (c) 2015年 SH. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
{
    UIImageView * _monkeyView;
    CGPoint _startPoint;
    CGPoint _endPoint;
    UIImageView * _firstMonkeyView;
    UIImageView * _secondMonkeyView;
}


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _monkeyView = [[UIImageView alloc]init];
    _monkeyView.frame = CGRectMake(100, 100, 100, 100);
    _monkeyView.backgroundColor = [UIColor grayColor];
    UIImage * image = [UIImage imageNamed:@"monkey"];
    _monkeyView.image = image;
    _monkeyView.center = self.view.center;
    [self.view addSubview:_monkeyView];
    
    
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    
    [self touchesBegan:touches withEvent:event];
    UITouch * touch = touches.anyObject;

    _startPoint = [touch previousLocationInView:touch.view];
    _endPoint = [touch locationInView:touch.view];
    
//    CGPoint center = _monkeyView.center;
    
    CGFloat angle = [self calculateAngle:_startPoint endPoint:_endPoint];
    [self rotate:angle];
    
    //atan2f(_endPoint.y - center.y, _endPoint.x - center.x) - atan2f(_startPoint.y - center.y, _startPoint.x - center.x);
    
//    _monkeyView.transform = CGAffineTransformRotate(_monkeyView.transform, angle);
}

- (CGFloat)calculateAngle:(CGPoint)begin endPoint:(CGPoint)end
{
    CGFloat k1,k2 ;
    CGPoint vCenter= [_monkeyView center];
    
    if(begin.x-vCenter.x==0 ||end.x-vCenter.x == 0)
    {
        return 0.0;
    }
    
    k1= (begin.y-vCenter.y)/(begin.x-vCenter.x) ;
    k2= (end.y-vCenter.y)/(end.x-vCenter.x);
    
    CGFloat tan0= (k2-k1)/(1.0+k1*k2);
    
  //返回都是正数的tan
//    if(tan0<0)
//    {
//        tan0=-tan0;
//    }
    
    
    return atan(tan0) ;
}


- (void)rotate:(CGFloat)angle
{
    CGAffineTransform originTransform = _monkeyView.transform ;
    _monkeyView.transform = CGAffineTransformRotate(originTransform, angle);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
