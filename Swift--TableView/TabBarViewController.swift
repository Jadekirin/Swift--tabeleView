//
//  TabBarViewController.swift
//  Swift--TableView
//
//  Created by maweilong-PC on 2017/3/15.
//  Copyright © 2017年 maweilong. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    var _backView:UIView? = nil
    var  items:NSArray = []
    let NameArr = ["首页","分类","购物车","我的"]
    let PicArr = ["main","grid","cart","me"]
    let PicSelectArr = ["main_blue","grid_blue","cart_blue","me_blue"]
    let VCArr = [MainViewController(),ClassViewController(),CartViewController(),MyViewController()]
    //初始化数组
    var NavVCArr:[NSObject] = [NSObject]()
    
    var nav:UINavigationController = UINavigationController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.CreatTabBar()
    }

    //创建tabBar
    func CreatTabBar()  {
        
        _backView = UIView(frame:CGRect(x:0,y:0,width:SCREEN_WIDTH,height:49))

       
//        let  MainVC  = MainViewController()
//        MainVC.title = "首页"
//        let MainNav = UINavigationController(rootViewController:MainVC)
//        MainNav.tabBarItem.title = "首页"
//        MainNav.tabBarItem.image = UIImage(named:"main")
//        MainNav.tabBarItem.selectedImage = UIImage(named:"main_blue")
//        
//        let  ClassVC  = ClassViewController()
//        ClassVC.title = "分类"
//        let ClassNav = UINavigationController(rootViewController:ClassVC)
//        ClassNav.tabBarItem.title = "分类"
//        ClassNav.tabBarItem.image = UIImage(named:"grid")
//        ClassNav.tabBarItem.selectedImage = UIImage(named:"grid_blue")
//        
//        let  CartVC  = CartViewController()
//        CartVC.title = "购物车"
//        let CartNav = UINavigationController(rootViewController:CartVC)
//        CartNav.tabBarItem.title = "购物车"
//        CartNav.tabBarItem.image = UIImage(named:"cart")
//        CartNav.tabBarItem.selectedImage = UIImage(named:"cart_blue")
//        let  MyVC  = MyViewController()
//        MyVC.title = "我的"
//        let MyNav = UINavigationController(rootViewController:MyVC)
//        MyNav.tabBarItem.title = "我的"
//        MyNav.tabBarItem.image = UIImage(named:"me")
//        MyNav.tabBarItem.selectedImage = UIImage(named:"me_blue")
//        
//        // 添加工具栏
//        items = [MainNav,ClassNav,CartNav,MyNav]
//        self.viewControllers = items as? [UIViewController]
//        for  i in 0 ..< items.count {
//            /*
//             (items[i] as AnyObject) 相当于 self.navigationController?
//             **/
//            //设置导航栏的背景图片 （优先级高）
//            (items[i] as AnyObject).navigationBar.setBackgroundImage(UIImage(named:"NavigationBar"), for:.default)
//            //设置导航栏的背景颜色 （优先级低）
//            (items[i] as AnyObject).navigationBar.barTintColor = UIColor.orange
//            //设置导航栏的字体颜色
//            (items[i] as AnyObject).navigationBar.titleTextAttributes =
//                [NSForegroundColorAttributeName: UIColor.red]
//        }
        
        
        /**
         for循环控制器数组 写法
        */
        for  M in 0 ..< VCArr.count {
            nav = UINavigationController(rootViewController:(VCArr[M] as AnyObject as! UIViewController))
            
            nav.tabBarItem.title = NameArr[M]
            nav.tabBarItem.image = UIImage(named:PicArr[M])
            nav.tabBarItem.selectedImage = UIImage(named:PicSelectArr[M])
            VCArr[M].title = NameArr[M]
            NavVCArr.append(nav)
        }
        // 添加工具栏
       // items = [MainNav,ClassNav,CartNav,MyNav]
        self.viewControllers = NavVCArr as? [UIViewController]
        for  i in 0 ..< NavVCArr.count {
            /*
             (items[i] as AnyObject) 相当于 self.navigationController?
             **/
            //设置导航栏的背景图片 （优先级高）
            (NavVCArr[i] as AnyObject).navigationBar.setBackgroundImage(UIImage(named:"NavigationBar"), for:.default)
            //设置导航栏的背景颜色 （优先级低）
            (NavVCArr[i] as AnyObject).navigationBar.barTintColor = UIColor.orange
            //设置导航栏的字体颜色
            (NavVCArr[i] as AnyObject).navigationBar.titleTextAttributes =
                [NSForegroundColorAttributeName: UIColor.white]
         
        }
 
        //tabBar 底部工具栏背景颜色 (以下两个都行)
        self.tabBar.barTintColor = UIColor.orange
        self.tabBar.backgroundColor = UIColor.brown
        //设置 tabBar 工具栏字体颜色 (未选中  和  选中)
        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(object:UIColor.white, forKey:NSForegroundColorAttributeName as NSCopying) as? [String : AnyObject], for:UIControlState.normal);
        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(object:UIColor.red, forKey:NSForegroundColorAttributeName as NSCopying) as? [String : AnyObject], for:UIControlState.selected);
       
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
