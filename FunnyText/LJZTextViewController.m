
//
//  LJZTextViewController.m
//  FunnyText
//
//  Created by 李金柱 on 16/4/8.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import "LJZTextViewController.h"

@interface LJZTextViewController ()
{
    CAGradientLayer *_gradientLayer;
    NSUserDefaults  *_userDefaults;
    CGFloat         _labelWidth;
    
}
@end

@implementation LJZTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([LJZTools isBlankString:[_userDefaults objectForKey:@"textColor"]]) {
         self.view.backgroundColor     = [UIColor whiteColor];
    }else{
         self.view.backgroundColor = [LJZTools getColorWithHexColor:[_userDefaults objectForKey:@"bgColor"]];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self.view addGestureRecognizer:tap];
    [self showText];
}
- (void)showText{
    
    UILabel *label = [[UILabel alloc]init];
    
    
    if (self.isV) {
        label.frame = CGRectMake(0, 10, self.view.bounds.size.height, kScreenSize.width - 20);
    }else{
        label.frame = CGRectMake(0, 100, self.view.bounds.size.width, 300);
    }
    label.text = self.text;
    label.textAlignment = NSTextAlignmentNatural;
    
    
    CGSize labelmaxSize = CGSizeMake(MAXFLOAT, kScreenSize.width);
    UIFont *font = [UIFont systemFontOfSize:400];
    NSDictionary *attributes = @{NSFontAttributeName:font};
    
    CGRect labelRect = [self.text boundingRectWithSize:labelmaxSize options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil];
    [label setFrame:CGRectMake(0, 10, labelRect.size.width, kScreenSize.width - 20)];
    label.text = self.text;
    _labelWidth = labelRect.size.width;
    label.font = font;
    
    
    if ([LJZTools isBlankString:[_userDefaults objectForKey:@"textColor"]]) {
        label.textColor     = [UIColor blackColor];
    }else{
        label.textColor = [LJZTools getColorWithHexColor:[_userDefaults objectForKey:@"textColor"]];
    }
    label.tag = 101;
    label.adjustsFontSizeToFitWidth = YES;
    
    [self.view addSubview:label];
    
    if (self.isMoving ) {
        [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(newTimer) userInfo:nil repeats:YES];
    }
}
- (void)newTimer{
    
    UILabel *label = (UILabel *)[self.view viewWithTag:101];
    static int x ;
    CGRect frame = label.frame;
    
    if (!self.speed) {
        x = 1;
    }else {
        x = self.speed;
    }
        if (frame.origin.x + _labelWidth< 0) {

            label.frame = CGRectMake(kScreenSize.width, 10, _labelWidth, kScreenSize.height - 20);
        }
        CGPoint center  = label.center;
//        [UIView beginAnimations:@"test" context:NULL];
//        //设置动画时间
//        [UIView setAnimationDuration:1];
//        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//        [UIView setAnimationDelegate:self];
//        [UIView setAnimationRepeatAutoreverses:NO];
//        [UIView setAnimationRepeatCount:9999];
        center.x -= x;
        label.center = center;
  //      [UIView commitAnimations];
        
}

//随机渐变
- (void)shadow{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 500)];
    
    label.adjustsFontSizeToFitWidth = YES;
    label.text = self.text;
    
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:400];
    label.tag = 101;
    [self.view addSubview:label];
    //创建渐变图层
    _gradientLayer = [CAGradientLayer layer];
    
    _gradientLayer.frame = label.frame;
    _gradientLayer.colors = @[(id)[self randomColor].CGColor,(id)[self randomColor].CGColor,(id)[self randomColor].CGColor,(id)[self randomColor].CGColor];
    [self.view.layer addSublayer:_gradientLayer];
    
    _gradientLayer.mask = label.layer;
    
    label.frame = _gradientLayer.bounds;
    //[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(newTimer) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(textColorChange) userInfo:nil repeats:YES];
    
    
}
- (UIColor *)randomColor{
    CGFloat  red = arc4random_uniform(256)/255.0;
    CGFloat  green = arc4random_uniform(256)/255.0;
    CGFloat  blue = arc4random_uniform(256)/255.0;
    
    return  [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    
}
- (void)textColorChange{
    _gradientLayer.colors = @[(id)[self randomColor].CGColor,(id)[self randomColor].CGColor,(id)[self randomColor].CGColor,(id)[self randomColor].CGColor,(id)[self randomColor].CGColor];
    
    
}
- (void)dismiss{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL) shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)toInterfaceOrientation {
    if (self.isV) {
        return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
    }else{
        return nil;
    }
    
    
}
- (NSUInteger)supportedInterfaceOrientations {
    if (self.isV) {
        return UIInterfaceOrientationMaskLandscapeRight;
    }else{
        return 0;
    }
}
//- (void)viewDidAppear:(BOOL)animated{
//    
//    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
//    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//富文本
- (void)attributeString{
    NSString *str = @"人生若只如初见，何事秋风悲画扇。\n等闲变却故人心，却道故人心易变。\n骊山语罢清宵半，泪雨霖铃终不怨。\n何如薄幸锦衣郎，比翼连枝当日愿。";
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:30.0f]
                    range:NSMakeRange(0, 3)];
    
    //attrStr添加字体和设置字体的范围
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30.0] range:NSMakeRange(0, 3)];
    
    //attrStr添加文字颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(17, 7)];
    
    //attrStr添加下划线
    [attrStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(8, 8)];
    
    //段落样式
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    //行间距
    paragraph.lineSpacing = 10;
    //段落间距
    paragraph.paragraphSpacing = 20;
    //对齐方式
    paragraph.alignment = NSTextAlignmentLeft;
    //指定段落开始的缩进像素
    paragraph.firstLineHeadIndent = 30;
    //调整全部文字的缩进像素
    paragraph.headIndent = 10;
   
    //attrStr添加段落设置
    
    [attrStr addAttribute:NSParagraphStyleAttributeName
                    value:paragraph
                    range:NSMakeRange(0, [str length])];
    
    //label添加链接
//    注意：label链接是可以显示出来，但是点不了，有兴趣的朋友可以试试。查资料发现textView是可以点击的，有shouldInteractWithURL代理方法回调。
    

    NSString *urlStr = @"www.baidu.com";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [attrStr addAttribute:NSLinkAttributeName
                    value:url
                    range:NSMakeRange(42, 7)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 100, 200, 0)];
    label.backgroundColor = [UIColor lightGrayColor];
    //自动换行
    label.numberOfLines = 0;
    //设置label的富文本
    label.attributedText = attrStr;
    //label高度自适应
    [label sizeToFit];
    [self.view addSubview:label];
    CGFloat height = label.frame.size.height;
    NSLog(@"height = %f",height);
}
@end
