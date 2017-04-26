//
//  TagViewController.swift
//  Swift--TableView
//
//  Created by maweilong-PC on 2017/3/31.
//  Copyright © 2017年 maweilong. All rights reserved.
//

import UIKit
let itemW: CGFloat = (SCREEN_WIDTH - 100) * 0.25

private let ChannelViewCellId = "ChannelViewCellId"
private let ChannelViewHeaderIdentifier = "ChannelViewHeaderIdentifier"

class TagViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    var switchoverCallblock: ((_ selectedArr: [String], _ recommendArr: [String], _ index:Int) -> ())?
    
     var headerArr = [["切换频道","点击添加更多频道"],["长按拖动排序","点击添加更多频道"]]
    var selectedArr = ["推荐","河北","财经","娱乐","体育","社会","NBA","视频","汽车","图片","科技","军事","国际","数码","星座","电影","时尚","文化","游戏","教育","动漫","政务","纪录片","房产","佛学","股票","理财"]
    
    var recommendArr = ["有声","家居","电竞","美容","电视剧","搏击","健康","摄影","生活","旅游","韩流","探索","综艺","美食","育儿"]
//    var selectedArr = [String]()
//    var recommendArr = [String]()
    //判断是否是编辑状态
    var isEdit: Bool = false
    var indexPath : IndexPath?
    var targetIndexPath : IndexPath?
    
    /*
     接受上界面的数据传过来
    init(a:[String],b:[String]) {
        selectedArr = a
        recommendArr = b
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    **/
    
//    var collectionView: UICollectionView?
    private lazy var collectionView:UICollectionView = {
        var frame = self.view.frame
        let clv = UICollectionView(frame:frame, collectionViewLayout: ChannelViewLayout())
        clv.backgroundColor = UIColor.white
        clv.delegate = self
        clv.dataSource = self
        clv.register(ChannelViewCell.self, forCellWithReuseIdentifier: ChannelViewCellId)
        clv.register(ChannelHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ChannelViewHeaderIdentifier)
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressGesture(_:)))
        clv.addGestureRecognizer(longPress)
        return clv
    }()
    
    private lazy var dragingItem: ChannelViewCell = {
        let cell = ChannelViewCell.init(frame: CGRect.init(x: 0, y: 0, width: itemW, height: itemW * 0.5))
        cell.isHidden = true
        
        return cell
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        //
        self.title = "标签"
        view.addSubview(collectionView)
        collectionView.addSubview(dragingItem)
        
    }
    

    //collection代理
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? selectedArr.count : recommendArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:ChannelViewCellId, for: indexPath) as! ChannelViewCell
        
        cell.text = indexPath.section == 0 ? selectedArr[indexPath.row] : recommendArr[indexPath.row]
        cell.edit = (indexPath.section == 0 && indexPath.item == 0) ? false : isEdit
        return cell
        
    }
    
    //点击cell事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section > 0 {
            //更新数据
            let obj = recommendArr[indexPath.item]
            recommendArr.remove(at: indexPath.item)
            selectedArr.append(obj)//增加元素到数组最后一个
            collectionView.moveItem(at: indexPath, to: NSIndexPath.init(item: selectedArr.count - 1, section: 0) as IndexPath)
            
        }else{
            if isEdit {
                if indexPath.item == 0 {
                    return
                }
                let obj = selectedArr[indexPath.item]
                selectedArr.remove(at: indexPath.item)
                recommendArr.insert(obj, at: 0)
                collectionView.moveItem(at: indexPath, to: NSIndexPath.init(item: 0, section: 1) as IndexPath)
                
            }else{
                if switchoverCallblock != nil {
                    switchoverCallblock!(selectedArr,recommendArr,indexPath.item)
                    _ = navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    //创建头视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ChannelViewHeaderIdentifier, for: indexPath) as! ChannelHeaderView
        
        header.text = isEdit ? headerArr[1][indexPath.section] : headerArr[0][indexPath.section]
        
        header.button.isSelected = isEdit
        if indexPath.section > 0  {
            header.button.isHidden = true
        }else{
            header.button.isHidden = false
        }
        
        header.clickCallback = {
            [weak self] in
            self?.isEdit = !(self?.isEdit)!
            collectionView.reloadData()
        }
        
        return header
    }
    
    // 长按手势点击事件
    func longPressGesture(_ tap:UILongPressGestureRecognizer){
        if !isEdit{
            isEdit = !isEdit
            collectionView.reloadData()
            return
        }
        let point = tap.location(in: collectionView)
        switch tap.state {
        case UIGestureRecognizerState.began:
            dragBegan(point: point)
        case UIGestureRecognizerState.changed:
            dragChanged(point: point)
        case UIGestureRecognizerState.ended:
            dragEnded(point: point)
        case UIGestureRecognizerState.cancelled:
            dragEnded(point: point)
        default:
            break
        }
        
    }
    //mark - 长按开始
    private func dragBegan(point:CGPoint){
        indexPath = collectionView.indexPathForItem(at: point)
        //判断不能响应长按手势的
        if indexPath == nil || (indexPath?.section)! > 0 || indexPath?.item == 0 {
            return
        }
        
        let item = collectionView.cellForItem(at: indexPath!) as? ChannelViewCell
        item?.isHidden = true
        dragingItem.frame = (item?.frame)!
        dragingItem.text = item!.text
        dragingItem.isHidden = false
        dragingItem.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
        
        
    }
    //mark - 长按过程
    private func dragChanged(point:CGPoint){
        //判断不能响应长按手势的
        if indexPath == nil || (indexPath?.section)! > 0 || indexPath?.item == 0 {
            return
        }
        
        dragingItem.center = point
        targetIndexPath = collectionView.indexPathForItem(at: point)
        if targetIndexPath == nil || (targetIndexPath?.section)! > 0 || indexPath == targetIndexPath || targetIndexPath?.item == 0 {
            return
        }
        //更新数据
        let obj = selectedArr[indexPath!.item]
        selectedArr.remove(at: indexPath!.row)
        selectedArr.insert(obj, at: targetIndexPath!.item)
        //交换位置
        collectionView.moveItem(at: indexPath!, to: targetIndexPath!)
        indexPath = targetIndexPath
        
        
    }
    //mark - 长按束
    private func dragEnded(point:CGPoint){
        if indexPath == nil || (indexPath?.section)! > 0 || indexPath?.item == 0 {
            return
        }
        let endCell = collectionView.cellForItem(at: indexPath!)
        
        UIView.animate(withDuration: 0.25, animations: { 
            self.dragingItem.transform = CGAffineTransform.identity
            self.dragingItem.center = (endCell?.center)!
        }, completion: {
            
            (finish) -> () in
            endCell?.isHidden = false
            self.dragingItem.isHidden = true
            self.indexPath = nil
            
        })
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}




//mark - 自定义cell
class ChannelViewCell:UICollectionViewCell{
    
    private lazy var label: UILabel = {
        let label = UILabel.init(frame: self.bounds)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
       
        let imageView = UIImageView.init(frame:CGRect.init(x: 2, y: 2, width: 10, height: 10))
        imageView.image = UIImage.init(named: "close")
        imageView.isHidden = true
        return imageView
        
    }()
    
    
    
    var  edit = true {
        didSet{
            imageView.isHidden = !edit
        }
    }
    
    
    var text:String? {
        didSet{
            label.text = text
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //创建Cell
        self.setupUI()
        
    }
    //创建Cell
    func setupUI ()  {
        contentView.addSubview(label)
        label.addSubview(imageView)
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
    }

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//自定义头视图
class ChannelHeaderView:  UICollectionReusableView {
    
    var clickCallback: (() -> ())?
    
    var text:String? {
        didSet{
            HeaderLabel.text = text
        }
    }
    
    
    private lazy var HeaderLabel :UILabel = {
        let label = UILabel.init(frame: self.bounds)
        label.frame.origin.x = 20
        return label
    }()
     lazy var button: UIButton = {
        let  button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect.init(x: SCREEN_WIDTH - 80, y: 0, width: 80, height: self.frame.height)
        button.setTitle("编辑", for: .normal)
        button.setTitle("完成", for: .selected)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(ButtonClick(_ :)), for: .touchUpInside)
        return button
        
    }()
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setupHeader()
    }
    
    
    
    func setupHeader (){
        addSubview(HeaderLabel)
        addSubview(button)
        backgroundColor = UIColor.groupTableViewBackground
    }
    
    //button  点击事件
    func ButtonClick(_ button:UIButton) {
        
        if (clickCallback != nil) {
            clickCallback!()
        }

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//自定义布局
class ChannelViewLayout: UICollectionViewFlowLayout {
    override func prepare() {
    super.prepare()
    
        headerReferenceSize = CGSize.init(width: SCREEN_WIDTH, height: 40)
        itemSize = CGSize.init(width: itemW, height: itemW * 0.5)
        minimumLineSpacing = 15
        minimumInteritemSpacing = 20
        sectionInset = UIEdgeInsets.init(top: 10, left: 20, bottom: 10, right: 20)
        
    }
}
