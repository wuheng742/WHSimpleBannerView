//
//  WHAutoMoveAdView.swift
//  swiftDW
//
//  Created by wuheng on 2017/3/1.
//  Copyright © 2017年 wuheng. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

class WHAutoMoveAdView: UIView {

    fileprivate let scrView = UIScrollView()
    
    open var autoTime : Timer!
    
    fileprivate var pageNum: NSInteger = 0
    
    fileprivate var parentVc: UIViewController!
    
    fileprivate let pageColtrol: UIPageControl = UIPageControl()
    
    
    //传进来的图片数组
    open var imageArr: [String]? {
        didSet {
            setUpImage()
        }
    }
    
    fileprivate var placeHolder: UIImage? {
        didSet {
            setUpImage()
        }
    }
    
    
    
    //图片View数组
    var imageViewArr: [UIImageView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setUpScrView()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 设置scrollView
    func setUpScrView() {
        
        scrView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        self .addSubview(scrView)
        
        
//        scrView.contentOffset.x = frame.size.width;
        
        scrView.isPagingEnabled = true
        
        scrView.delegate = self;
        
    }
    
    
    convenience init(imageUrlArr: [String]?, frame: CGRect, placeHolder: UIImage) {
        self.init(frame: frame)
        
        self.imageArr = imageUrlArr
        
        self.placeHolder = placeHolder
        
        setUpImage()
        
        if autoTime != nil {
            autoTime.invalidate()
            autoTime = nil
        }
        
    }
    
    //MARK: - 设置滑动的图片
    func setUpImage() {
        
        guard let imageArr = imageArr else {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
            scrView.contentSize = scrView.frame.size
            
            scrView.addSubview(imageView)
            
            scrView.isScrollEnabled = false
            imageView.image = placeHolder
            return

        }

        for view: UIView in scrView.subviews {
            view.removeFromSuperview()
        }
        
        pageNum = 0
        scrView.contentSize = CGSize(width: frame.size.width * 3.0, height: frame.size.height)
        scrView.isScrollEnabled = true
        for i in 0 ..< 3 {
            
            let pointX = CGFloat(i) * frame.size.width
            
            let imageView = UIImageView(frame: CGRect(x: pointX, y: 0, width: frame.size.width, height: frame.size.height))
            
            
            imageViewArr.append(imageView)
            
            scrView.addSubview(imageView)
        }
        
        let pageControlW = CGFloat(imageArr.count) * 30.0
        
        pageColtrol.frame = CGRect(x: (scrView.frame.size.width - pageControlW)/2, y: scrView.frame.size.height - 40, width: pageControlW, height: 20)
        
        pageColtrol.currentPageIndicatorTintColor = Color.red
        pageColtrol.pageIndicatorTintColor = Color.black
        
        pageColtrol.numberOfPages = imageArr.count
        
        scrView.superview!.addSubview(pageColtrol)
        
        
        //添加定时器
        if autoTime == nil {
            autoTime = Timer(timeInterval: 3, target: self, selector: #selector(timeChange), userInfo: nil, repeats: true)
            RunLoop.current.add(autoTime, forMode: .commonModes)
            
        }else {
            
        }
       changeImageLocation(pageNum: pageNum)

    }
    
    //MARK: - 定时器触发方法
    func timeChange() {
        let changePoint = CGPoint(x: scrView.contentOffset.x + frame.size.width, y: 0)
        UIView.animate(withDuration: 0.5, animations: { 
             self.scrView.contentOffset = changePoint
        }) { (complie) in
            self.scrollViewDidEndDecelerating(self.scrView)
            
            
        }
      
        
        
        
    }
    
}

extension WHAutoMoveAdView: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let isForward: Bool = scrollView.contentOffset.x > frame.size.width
        if isForward {
            pageNum = (pageNum + 1)%(imageArr?.count)!
        }else {
            pageNum = ((imageArr?.count)! + pageNum - 1)%(imageArr?.count)!
        }
        
        changeImageLocation(pageNum: pageNum)
        
        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       /*
         // 启动定时器
         timer.fireDate = NSDate.distantFuture()
         
         // 暂停定时器
         timer.fireDate = NSDate.distantPast()
         
         // 关闭定时器，永久关闭定时器
         timer.invalidate()
         */
        
        autoTime.invalidate()
        autoTime = nil
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        autoTime = Timer(timeInterval: 4, target: self, selector: #selector(timeChange), userInfo: nil, repeats: true)
        
        RunLoop.current.add(autoTime, forMode: .commonModes)
        
        
    }
    
    func changeImageLocation(pageNum: NSInteger) {
        
        
        
        for (index, imageView) in imageViewArr.enumerated() {
            
            guard let imageArr = imageArr else {
                return
            }
            let num = (imageArr.count + (pageNum+index)-1)%imageArr.count
            
           let imageStr = imageArr[num]
            
            imageView.kf.setImage(with: URL.init(string: imageStr))
            
           
            
        }
        
        scrView.contentOffset.x = frame.size.width
        pageColtrol.currentPage = pageNum
    }
    
    
    
}





















