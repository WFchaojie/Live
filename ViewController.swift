//
//  ViewController.swift
//  Live
//
//  Created by 武超杰 on 16/6/4.
//  Copyright © 2016年 武超杰. All rights reserved.

import UIKit
import AFNetworking

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var liveTableView = UITableView()
    
    var dataArray = NSMutableArray(capacity: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        liveTableView = UITableView(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height), style:UITableViewStyle.Plain)
        liveTableView.delegate=self
        liveTableView.dataSource = self
        self.view .addSubview(liveTableView)
        
        liveTableView.registerClass(HomeCell.self, forCellReuseIdentifier: "UserCenter")
        //http://pull.a8.com/live/1465471281402266.flv?ikHost=ws&ikOp=1
        let manager = AFHTTPRequestOperationManager()
        let url = "http://service.ingkee.com/api/live/simpleall?imsi=&uid=2301215&proto=5&idfa=F5682D14-E851-414A-A5FD-487BF4F239F1&lc=0000000000000026&cc=TG0001&imei=&sid=20yggYnx0wqU4twYqLIcodcSEar0HVQP0X8V4CHzePouEJTwi3i3&cv=IK3.1.00_Iphone&devi=a0822dac1e3de1adb82e7e42055b8fb895b2440b&conn=Wifi&ua=iPhone%206%20Plus&idfv=3DBF3B57-6925-453C-9718-F2C920404EE8&osversion=ios_9.300000&"
        //http://service.ingkee.com/api/live/gettop?imsi=&uid=2301215&proto=5&idfa=F5682D14-E851-414A-A5FD-487BF4F239F1&lc=0000000000000026&cc=TG0001&imei=&sid=20yggYnx0wqU4twYqLIcodcSEar0HVQP0X8V4CHzePouEJTwi3i3&cv=IK3.1.00_Iphone&devi=a0822dac1e3de1adb82e7e42055b8fb895b2440b&conn=Wifi&ua=iPhone%206%20Plus&idfv=3DBF3B57-6925-453C-9718-F2C920404EE8&osversion=ios_9.300000&count=5&multiaddr=1
        
        
        let op = manager.GET(url, parameters: nil, success: { (operation : AFHTTPRequestOperation, responseObject : AnyObject) in
            
            let dict:NSDictionary?
            do {
                dict = try NSJSONSerialization.JSONObjectWithData(responseObject as! NSData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                self.dataArray = (dict?.objectForKey("lives"))! as! NSMutableArray;
                print("刷新")
                self.liveTableView.reloadData()
            }catch _ {
                dict = nil
            }
            
            
            //print(dict)
            
            }, failure: { (operation : AFHTTPRequestOperation?, error : NSError) in
            })
        
        op?.responseSerializer = AFHTTPResponseSerializer()
        op?.start()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let live = LiveViewController()
        self.navigationController?.pushViewController(live, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 640
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCenter") as! HomeCell
        
        let dict = dataArray.objectAtIndex(indexPath.row)
        
        let str = "http://image.scale.a8.com/imageproxy2/dimgm/scaleImage?url=http%3A%2F%2Fimg.meelive.cn%2F\(dict.objectForKey("creator")!.objectForKey("portrait")!)&w=640&s=80&h=640&c=0&o=0"
        
        
        //let url = NSURL(string: str)
        //print(str)
        //cell.pic?.sd_setImageWithURL(url)
        cell.picString = str
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

