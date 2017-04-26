//
//  MyViewController.swift
//  Swift--TableView
//
//  Created by maweilong-PC on 2017/3/14.
//  Copyright © 2017年 maweilong. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {
    var _Lalabel:UILabel? = nil
    var _Text: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.title = "你好"
        
        _Lalabel = UILabel(frame:CGRect(x: 70,y: 60,width: 100,height: 100))
        
        _Lalabel?.text = _Text
        _Lalabel?.textColor = UIColor.red
        
        self.view.addSubview(_Lalabel!)
    
        
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
