//
//  ClassViewController.swift
//  Swift--TableView
//
//  Created by maweilong-PC on 2017/3/23.
//  Copyright © 2017年 maweilong. All rights reserved.
//

import UIKit

class ClassViewController: UIViewController {

    var RightButton:UIButton?
    
    var selectedArr = ["推荐","河北","财经","娱乐","体育","社会","NBA","视频","汽车","图片","科技","军事","国际","数码","星座","电影","时尚","文化","游戏","教育","动漫","政务","纪录片","房产","佛学","股票","理财"]
    
    var recommendArr = ["有声","家居","电竞","美容","电视剧","搏击","健康","摄影","生活","旅游","韩流","探索","综艺","美食","育儿"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.setUpButton()
    }
    func setUpButton() {
        self.RightButton = UIButton.init(type: .custom)
        self.RightButton?.frame = CGRect(x:0,y:0,width:40,height:20)
        //self.editButton?.backgroundColor = UIColor.blue
        self.RightButton?.addTarget(self, action: #selector(RightButtonClick), for:.touchUpInside)
        //        self.editButton?.titleLabel?.text = "编辑"
        self.RightButton?.setTitleColor(UIColor.red, for: .normal)
        self.RightButton?.setTitle("添加", for: .normal)
        self.RightButton?.tag = 10
        let RightBarButtonItem = UIBarButtonItem.init(customView: self.RightButton!)
        self.navigationItem.rightBarButtonItem = RightBarButtonItem
        
    }
    //button 点击事件
    func RightButtonClick()  {
        /*
         把这界面的数据传到另一个界面
        let TagVC = TagViewController.init(a: selectedArr, b: recommendArr)
 **/
        let TagVC = TagViewController()
        TagVC.hidesBottomBarWhenPushed = true
        TagVC.title = "标签"
        
        TagVC.switchoverCallblock = {
            (selectedArr,recommendArr,index) -> () in
           self.selectedArr = selectedArr
           self.recommendArr = recommendArr
           self.title = selectedArr[index]
            
        }

        self.navigationController?.pushViewController(TagVC, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
