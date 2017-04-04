# WHSimpleBannerView
a simple auto banner view , use Kingfisher to load image//一个简单的轮播图, 用Kingfisher加载轮播图
first step//第一步
```Swift
var autoScrView: WHAutoMoveAdView?

 autoScrView = WHAutoMoveAdView(imageUrlArr: nil, frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200), placeHolder: UIImage.init(named: "store_00")!)

 autoScrView?.delegate = self

mainScrView.addSubview(autoScrView)
```
