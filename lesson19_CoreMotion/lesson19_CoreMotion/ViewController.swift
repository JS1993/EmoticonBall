//
//  ViewController.swift
//  lesson19_CoreMotion
//
//  Created by  江苏 on 15/11/1.
//  Copyright © 2015年  江苏. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController,UIAccelerometerDelegate {
//  var ball:UIImageView!
    var balls:UIImageView!
    var speedX:UIAccelerationValue=0
    var speedY:UIAccelerationValue=0
    var motionManager = CMMotionManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView=UIImageView(image: UIImage(named: "icon"))
        imageView.frame=CGRectMake(0, 20, 320, 565)
        self.view.addSubview(imageView)

    balls = UIImageView(image: UIImage(named: "balls"))
    //放一个小球在中央
    balls.frame=CGRectMake(0, 0, 50, 50)
    balls.center=self.view.center
    self.view.addSubview(balls)
    /// 定义拖动手势
    let pan=UIPanGestureRecognizer(target: self, action: Selector("panDid:"))
    pan.maximumNumberOfTouches=1
    balls.addGestureRecognizer(pan)
        func panDid(recognizer:UISwipeGestureRecognizer)
        {
            let point=recognizer.locationInView(self.view)
            balls.center=point
        }
    
    motionManager.accelerometerUpdateInterval = 1/60
    if (motionManager.accelerometerAvailable)
    {
    let queues = NSOperationQueue.currentQueue()
    motionManager.startAccelerometerUpdatesToQueue(queues!,withHandler:
    {(accelerometerData,error) in
    //动态小球位置设置
    
    self.speedX += accelerometerData!.acceleration.x
    self.speedY += accelerometerData!.acceleration.y
    var possX=self.balls.center.x + CGFloat(self.speedX)
    var possY=self.balls.center.y - CGFloat(self.speedY)
    //碰到边框后的反弹效果
    if possX<53 {
    possX=53
    self.speedX *= -0.4
    }else if possX > 267 {
    possX=267
    //碰到右边边框时以0.4倍速度反弹
    self.speedX *= -0.4
    }
    if possY<80 {
    possY=80
    //碰到上面的边框不反弹
    self.speedY=0
    }else if possY>510 {
    possY=510
    //碰到下面以1.5倍速度反弹
    self.speedY *= -1.1
    }
    self.balls.center = CGPointMake(possX, possY)
    })
    }
}

}

