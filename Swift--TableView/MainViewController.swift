//
//  MainViewController.swift
//  Swift--TableView
//
//  Created by maweilong-PC on 2017/3/2.
//  Copyright © 2017年 maweilong. All rights reserved.
//

import UIKit
class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MWLSwiftBannerViewDelegate {
    var mytabelView: UITableView? = nil
    var itemArray: NSMutableArray = []
    var editButton:UIButton? = nil
    var HeaderView:UIView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        self.itemArray = NSMutableArray.init(array: ["北京", "上海", "天津", "海南", "南京", "三亚", "青岛", "济南", "香港", "澳门", "安徽"])
    initView()
    setUpEditButton()
        
    }
    //创建tableVIew
    func initView() {
        self.mytabelView = UITableView(frame:CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height - 10), style:UITableViewStyle.plain)
        self.mytabelView?.delegate = self
        self.mytabelView?.dataSource = self
//        self.mytabelView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let cellNib = UINib(nibName: "MainViewCell", bundle: nil)
        self.mytabelView?.register(cellNib, forCellReuseIdentifier: "MainViewCell")
        
        self.view.addSubview(self.mytabelView!)
    }
    
    //添加左侧按钮
    func setUpEditButton() {
        self.editButton = UIButton.init(type: .custom)
        self.editButton?.frame = CGRect(x:0,y:0,width:40,height:20)
        //self.editButton?.backgroundColor = UIColor.blue
        self.editButton?.addTarget(self, action: #selector(editButtonTapped), for:.touchUpInside)
//        self.editButton?.titleLabel?.text = "编辑"
        self.editButton?.setTitleColor(UIColor.red, for: .normal)
        self.editButton?.setTitle("编辑", for: .normal)
        self.editButton?.tag = 10
        let leftBarButtonItem = UIBarButtonItem.init(customView: self.editButton!)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
    }
    //button 点击事件
    func editButtonTapped()  {
        if editButton?.tag == 10 {
            self.editButton?.setTitle("完成", for: .normal)
            self.mytabelView?.setEditing(true, animated: true)
            self.editButton?.tag = 200
        }else{
            self.editButton?.setTitle("编辑", for: .normal)
            self.mytabelView?.setEditing(false, animated: false)
            self.editButton?.tag = 10
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.itemArray.remove(at:indexPath.row)
//        tableView.deleteRows(at: [indexPath], with: .top)
    }
    
//    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        
//    }
    
    // MARK：-tableview代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.itemArray.count
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let Cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        
//        Cell.textLabel?.text = String(describing:self.itemArray[indexPath.row])
//        Cell.selectionStyle = .none
        let Cell:MainViewCell = tableView.dequeueReusableCell(withIdentifier: "MainViewCell", for: indexPath) as! MainViewCell
        return Cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //头尾视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        HeaderView = UIView()
        HeaderView?.backgroundColor = UIColor.blue
        
//        let bannerLocal:MWLSwiftBannerView = MWLSwiftBannerView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 150))
//        let arrayLocal:[String] = ["banner1","banner2","banner3"]
//        bannerLocal.addImageArray(arrayLocal)
//        bannerLocal.delegate = self as? MWLSwiftBannerViewDelegate
//        HeaderView?.addSubview(bannerLocal)
        
        let banner:MWLSwiftBannerView = MWLSwiftBannerView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 150))
        let array:[String] = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487153665015&di=1e552189349eaae4b7129e84a30dea0c&imgtype=0&src=http%3A%2F%2Fupload.fdc.com.cn%2F2016%2F0219%2F1455843261516.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487153793149&di=6ebbb8f29a9c1fd091a7fda022c6fe3a&imgtype=0&src=http%3A%2F%2Fp.sootoo.com%2Fson_media%2Fmsg%2F2017%2F01%2F13%2F746705.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487748435&di=1fbb5fc0c349b14dbd8bef73d863e8d2&imgtype=jpg&er=1&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0506%2F4%2F1.jpg","https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3416824839,3922583864&fm=23&gp=0.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487154052673&di=d2233d99bc4d777e6dda2ec9ff335db5&imgtype=0&src=http%3A%2F%2Fn1.itc.cn%2Fimg8%2Fwb%2Frecom%2F2016%2F05%2F04%2F146235549368743432.JPEG"];
        print(array[0])
        banner .addImageArray(array)
        banner.delegate = self
        HeaderView?.addSubview(banner)
        return HeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    //tableView点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let MyVC = MyViewController()
        MyVC._Text = "哈喽"
        //self.present(MyVC, animated: true, completion: nil)
        MyVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(MyVC, animated: true);
    }
    
    
    func imageViewClick(_ index: NSInteger, imageStr: String) {
        
        print(index,imageStr)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
}
