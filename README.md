# WHSimpleBannerView
a simple auto banner view , use Kingfisher to load image//一个简单的轮播图, 用Kingfisher加载轮播图
you just need drag one file to your project,then you can user this simple banner view;
你只需要将一个文件拖到你的文件夹里就可以使用这个轮播图了
first step//第一步
drag WHAutoMoveAdView to your project
```Swift
var autoScrView: WHAutoMoveAdView?

 autoScrView = WHAutoMoveAdView(imageUrlArr: nil, frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200), placeHolder: UIImage.init(named: "store_00")!)

 autoScrView?.delegate = self

mainScrView.addSubview(autoScrView)
```

second step， observe WHAutoMoveAdViewDelegate
第二步  遵守WHAutoMoveAdViewDelegate，然后使用代理来监听点击的情况
```Swift
 func selectPic(page: NSInteger) {
        
    }

```
