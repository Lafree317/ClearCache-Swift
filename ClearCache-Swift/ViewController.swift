//
//  ViewController.swift
//  ClearCache-Swift
//
//  Created by huchunyuan on 15/12/4.
//  Copyright © 2015年 huchunyuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
}

@IBAction func alertAction(sender: UIButton) {
    // 取出cache文件夹路径
    let cachePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
    // 打印路径,需要测试的可以往这个路径下放东西
    print(cachePath)
    // 取出文件夹下所有文件数组
    let files = NSFileManager.defaultManager().subpathsAtPath(cachePath!)
    // 用于统计文件夹内所有文件大小
    var big = Int();
    
    
    // 快速枚举取出所有文件名
    for p in files!{
        // 把文件名拼接到路径中
        let path = cachePath!.stringByAppendingFormat("/\(p)")
        // 取出文件属性
        let floder = try! NSFileManager.defaultManager().attributesOfItemAtPath(path)
        // 用元组取出文件大小属性
        for (abc,bcd) in floder {
            // 只去出文件大小进行拼接
            if abc == NSFileSize{
                big += bcd.integerValue
            }
        }
    }
    
    // 提示框
    let message = "\(big/(1024*1024))M缓存"
    let alert = UIAlertController(title: "清除缓存", message: message, preferredStyle: UIAlertControllerStyle.Alert)
    
    let alertConfirm = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (alertConfirm) -> Void in
        // 点击确定时开始删除
        for p in files!{
            // 拼接路径
            let path = cachePath!.stringByAppendingFormat("/\(p)")
            // 判断是否可以删除
            if(NSFileManager.defaultManager().fileExistsAtPath(path)){
                // 删除
                do {
                    try NSFileManager.defaultManager().removeItemAtPath(path)
                } catch let error as NSError {
                    print(error)
                }
                
            }
        }
    }
    alert.addAction(alertConfirm)
    let cancle = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (cancle) -> Void in
        
    }
    alert.addAction(cancle)
    // 提示框弹出
    presentViewController(alert, animated: true) { () -> Void in
        
    }
}
    
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

