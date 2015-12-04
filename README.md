# ClearCache-Swift
iOS-Swift-清理缓存
#前言
####swift现在网上资源比较乱,需要找的要找很久,于是自己开始整理自己遇到的功能开始swift化,如果效果不错的话以后就会一直发表swift的博客,所以请各位读者多给我的GitHub点几个Star吧!
---
#效果图
![这里写图片描述](http://img.blog.csdn.net/20151204133231461)
#上代码
####在storyBoard创建一个button关联点击事件,然后在ViewController里写上以下代码
```
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
                try! NSFileManager.defaultManager().removeItemAtPath(path)
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

```

#效果展示
![这里写图片描述](http://img.blog.csdn.net/20151204133445628)

##GitHub:https://github.com/Lafree317/ClearCache-Swift
---
本人还是一只小菜鸡,不过是一只热心肠的菜鸡,如果有需要帮助或者代码中有更好的建议的话可以发邮件到lafree317@163.com中,我们一起进步XD
