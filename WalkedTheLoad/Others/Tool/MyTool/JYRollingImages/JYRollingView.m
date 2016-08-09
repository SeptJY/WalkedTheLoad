//
//  JYRollingView.m
//  SeptRollingImages
//
//  Created by Sept on 16/4/18.
//  Copyright © 2016年 九月. All rights reserved.
//

#import "JYRollingView.h"

#define  widthSelf self.frame.size.width
#define  heightSelf self.frame.size.height
#define strId @"JYRolling"
#define DEFAULTTIME 5
#define DescribeLabelAlpha 0.3

#define Margin 10

typedef enum{
    JYImagesRollingDirectionNone,
    JYImagesRollingDirectionLeft,
    JYImagesRollingDirectionRight
} JYImagesRollingDirection;

@interface JYRollingView() <UIScrollViewDelegate>

//定时器
@property (nonatomic, strong) NSTimer *timer;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIPageControl *pageControl;

@property (strong, nonatomic) UILabel *describeLabel;

//pageControl图片大小
@property (nonatomic, assign) CGSize pageImageSize;

@property (nonatomic, strong) UIImageView *currImageView;
//辅助滚动的imageView
@property (nonatomic, strong) UIImageView *otherImageView;

@property (assign, nonatomic) JYImagesRollingDirection direction;

//当前显示图片的索引
@property (nonatomic, assign) NSInteger currIndex;
//将要显示图片的索引
@property (nonatomic, assign) NSInteger nextIndex;

//下载的图片字典
@property (nonatomic, strong) NSMutableDictionary *imageDic;
//下载图片的操作
@property (nonatomic, strong) NSMutableDictionary *operationDic;

//轮播的图片数组
@property (nonatomic, strong) NSMutableArray *images;

//任务队列
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation JYRollingView

#pragma mark- 初始化方法
//创建用来缓存图片的文件夹
+ (void)initialize {
    NSString *cache = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:strId];
    BOOL isDir = NO;
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:cache isDirectory:&isDir];
    if (!isExists || !isDir) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cache withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (instancetype)initWithimageArray:(NSArray *)imageArray
{
    self = [super init];
    if (self) {
        self.imageArray = imageArray;
    }
    return self;
}

+ (instancetype)rollingViewWithimageArray:(NSArray *)imageArray
{
    return [[self alloc] initWithimageArray:imageArray];
}

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageArray = imageArray;
    }
    return self;
}

+ (instancetype)rollingViewWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray {
    return [[self alloc] initWithFrame:frame imageArray:imageArray];
}

#pragma mark- 懒加载
- (NSMutableDictionary *)imageDic{
    if (!_imageDic) {
        _imageDic = [NSMutableDictionary dictionary];
    }
    return _imageDic;
}

- (NSMutableDictionary *)operationDic{
    if (!_operationDic) {
        _operationDic = [NSMutableDictionary dictionary];
    }
    return  _operationDic;
}

- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] init];
        
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor cyanColor];
        
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] init];
        
        _pageControl.hidesForSinglePage = NO;
        _pageControl.userInteractionEnabled = NO;
        _pageControl.numberOfPages = 3;
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

- (UIImageView *)currImageView
{
    if (!_currImageView) {
        
        _currImageView = [[UIImageView alloc] init];
        
        _currImageView.userInteractionEnabled = YES;
        [_currImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rollingViewImagesOnClick)]];
        
        [self.scrollView addSubview:_currImageView];
    }
    return _currImageView;
}

- (void)rollingViewImagesOnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rollingViewImagesOnClick)]) {
        [self.delegate rollingViewImagesOnClick];
    }
}

- (UIImageView *)otherImageView
{
    if (!_otherImageView) {
        
        _otherImageView = [[UIImageView alloc] init];
        
        [self.scrollView addSubview:_otherImageView];
    }
    return _otherImageView;
}

- (UILabel *)describeLabel
{
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:DescribeLabelAlpha];
        _describeLabel.textColor = [UIColor whiteColor];
        _describeLabel.textAlignment = NSTextAlignmentCenter;
        _describeLabel.font = [UIFont systemFontOfSize:13];
        _describeLabel.hidden = YES;
        
        [self addSubview:_describeLabel];
    }
    return _describeLabel;
}

#pragma mark -------------------------> 自定义描述标签的背景颜色
- (void)setDescribeBgColor:(UIColor *)describeBgColor
{
    _describeBgColor = describeBgColor;
    
    self.describeLabel.backgroundColor = describeBgColor;
}

- (void)setDirection:(JYImagesRollingDirection)direction
{
    if (_direction == direction) return;
    
    _direction = direction;
    
    if (direction == JYImagesRollingDirectionNone) return;
    
    if (direction == JYImagesRollingDirectionRight) {
        
        self.otherImageView.frame = CGRectMake(0, 0, widthSelf, heightSelf);
        self.nextIndex = self.currIndex - 1;
        
        if (self.nextIndex < 0) {
            self.nextIndex = self.images.count - 1;
        }
    }
    else if (direction == JYImagesRollingDirectionLeft)
    {
        self.otherImageView.frame = CGRectMake(CGRectGetMaxX(self.currImageView.frame), 0, widthSelf, heightSelf);
        self.nextIndex = (self.currIndex + 1) % self.images.count;
    }
    
    self.otherImageView.image = self.images[self.nextIndex];
}

-(void)setImageArray:(NSArray *)imageArray
{
    if (!imageArray.count) return;
    
    _imageArray = imageArray;
    
    self.images = [NSMutableArray array];
    
    for (int i = 0; i < imageArray.count; i ++) {
        if ([imageArray[i] isKindOfClass:[UIImage class]]) {
            [self.images addObject:imageArray[i]];
        }
        else if ([imageArray[i] isKindOfClass:[NSString class]])
        {
            [self.images addObject:[UIImage imageNamed:@"placeholder"]];
            [self downloadImages:i];
        }
    }
    self.currImageView.image = self.images.firstObject;
    self.pageControl.numberOfPages = self.images.count;
}

- (void)setDescribeArray:(NSArray *)describeArray
{
    _describeArray = describeArray;
    
    // 如果描述的个数与图片个数不一致，则补空字符串
    if (describeArray && describeArray.count > 0) {
        if (describeArray.count < self.images.count) {
            NSMutableArray *describes = [NSMutableArray arrayWithArray:describeArray];
            for (NSInteger i = describeArray.count; i < self.images.count; i ++) {
                [describes addObject:@""];
            }
            describeArray = describes;
        }
        self.describeLabel.hidden = NO;
        self.describeLabel.text = describeArray.firstObject;
    }
}

- (void)downloadImages:(NSInteger)index
{
    NSString *key = self.imageArray[index];
    
    // 从内存缓存中取图片
    UIImage *image = [self.imageDic objectForKey:key];
    if (image) {
        self.images[index] = image;
        return;
    }
    
    // 从沙河缓存中取图片
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *path = [cache stringByAppendingPathComponent:[key lastPathComponent]];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    if (data)
    {
        image = [UIImage imageWithData:data];
        self.images[index] = image;
        [self.imageDic setObject:image forKey:key];
        return;
    }
    
    // 下载图片
    NSBlockOperation *downloadImgs = [self.operationDic objectForKey:key];
    
    if (downloadImgs) return;
    
    // 创建一个操作
    downloadImgs = [NSBlockOperation blockOperationWithBlock:^{
        
        NSURL *url = [NSURL URLWithString:key];
        NSData *data = [NSData dataWithContentsOfURL:url];
        if (!data) return ;
        
        UIImage *image = [UIImage imageWithData:data];
        
        // 取到的data有可能不是图片
        if (image) {
            [self.imageDic setObject:image forKey:key];
            self.images[index] = image;
            
            // 如果下载的图片为当前要显示的图片，直接到主线程给imageView赋值，否则要等下一轮才会显示
            if (self.currIndex == index) {
                [self.currImageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
            }
            [data writeToFile:path atomically:YES];
        }
        [self.operationDic removeObjectForKey:key];
    }];
    
    [self.queue addOperation:downloadImgs];
    [self.operationDic setObject:downloadImgs forKey:key];
}

#pragma mark 清除沙盒中的图片缓存
- (void)clearDiskCache
{
    NSString *cache = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:strId];
    
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cache error:NULL];
    
    for (NSString *fileName in contents) {
        [[NSFileManager defaultManager] removeItemAtPath:[cache stringByAppendingPathComponent:fileName] error:nil];
    }
}

#pragma mark- --------UIScrollViewDelegate--------
// 任何偏移的变化
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    
    self.direction = offsetX > widthSelf ? JYImagesRollingDirectionLeft : offsetX < widthSelf ? JYImagesRollingDirectionRight : JYImagesRollingDirectionNone;
    
    [self changeCurrentPageWithOffsets:offsetX];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self pauseRolling];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self pauseRolling];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

// 停止滚动
- (void)pauseRolling
{
    // 等于1表示没滚动
    if (self.scrollView.contentOffset.x / widthSelf == 1) return;
    
    self.currIndex = self.nextIndex;
    self.pageControl.currentPage = self.currIndex;
    self.currImageView.frame = CGRectMake(widthSelf, 0, widthSelf, heightSelf);
    self.describeLabel.text = self.describeArray[self.currIndex];
    self.currImageView.image = self.otherImageView.image;
    self.scrollView.contentOffset = CGPointMake(widthSelf, 0);
}

#pragma mark 当图片滚动过半时就修改当前页码
- (void)changeCurrentPageWithOffsets:(CGFloat)offsetX
{
    if (offsetX < widthSelf * 0.5) {
        NSInteger index = self.currIndex - 1;
        if (index < 0)
        {
            index = self.images.count - 1;
        }
        self.pageControl.currentPage = index;
    }
    else if (offsetX > widthSelf * 1.5){
        self.pageControl.currentPage = (self.currIndex + 1) % self.images.count;
    } else {
        self.pageControl.currentPage = self.currIndex;
    }
}

- (void)setFrameToPageCtrol
{
    if (self.pagePosition == JYPageControlPositionHide) {
        self.pageControl.hidden = YES;
        return;
    }
    
    CGSize size;
    if (self.pageImageSize.width == 0) {   // 没有设置图片
        // sizeForNumberOfPages 返回给定的页计数的显示点所需的最小大小。如果页面计数可以改变，可以使用大小控制
        size = [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
        size.height = 20;
    } else {    // 设置图片了
        size = CGSizeMake(self.pageImageSize.width * (self.pageControl.numberOfPages * 2 - 1), self.pageImageSize.height);
    }
    
    self.pageControl.frame = CGRectMake(0, 0, size.width, size.height);
    
    switch (self.pagePosition) {
        case JYPageControlPositionTopCenter:
            self.pageControl.center = CGPointMake(widthSelf * 0.5, size.height * 0.5);
            break;
        case JYPageControlPositionBottomLeft:
            self.pageControl.frame = CGRectMake(Margin, heightSelf - (self.describeLabel.hidden? size.height : size.height + 20), size.width, size.height);
            break;
        case JYPageControlPositionBottomRight:
            _pageControl.frame = CGRectMake(widthSelf - Margin - size.width, heightSelf - (self.describeLabel.hidden? size.height : size.height + 20), size.width, size.height);
            break;
        default:
            self.pageControl.center = CGPointMake(widthSelf * 0.5, heightSelf - (self.describeLabel.hidden ? 10 : 30));
            break;
    }
}

- (void)setScrollViewToContentSize
{
    if (self.images.count > 1) {
        self.scrollView.contentSize = CGSizeMake(widthSelf * 3, 0);
        self.scrollView.contentOffset = CGPointMake(widthSelf, 0);
        self.currImageView.frame = CGRectMake(widthSelf, 0, widthSelf, heightSelf);
        [self startTimer];
    } else {
        self.scrollView.contentSize = CGSizeZero;
        self.scrollView.contentOffset = CGPointZero;
        self.currImageView.frame = CGRectMake(0, 0, widthSelf, heightSelf);
    }
}

#pragma mark 设置定时器时间
- (void)setTime:(NSTimeInterval)time {
    _time = time;
    [self startTimer];
}

#pragma mark- --------定时器相关方法--------
- (void)startTimer {
    //如果只有一张图片，则直接返回，不开启定时器
    if (_images.count <= 1) return;
    //如果定时器已开启，先停止再重新开启
    if (self.timer) [self stopTimer];
    self.timer = [NSTimer timerWithTimeInterval:self.time < 1? DEFAULTTIME : _time target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage {
    [self.scrollView setContentOffset:CGPointMake(widthSelf * 2, 0) animated:YES];
}

- (void)layoutSubviews
{
    //有导航控制器时，会默认在scrollview上方添加64的内边距，这里强制设置为0
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.frame = self.bounds;
    
    self.describeLabel.frame = CGRectMake(0, heightSelf - 20, widthSelf, 20);
    
    // 设置分页按钮的frame
    [self setFrameToPageCtrol];
    
    // 设置scrollView的滚动范围
    [self setScrollViewToContentSize];
}

@end
