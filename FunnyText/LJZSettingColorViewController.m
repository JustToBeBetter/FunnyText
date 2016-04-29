//
//  LJZSettingColorViewController.m
//  FunnyText
//
//  Created by 李金柱 on 16/4/8.
//  Copyright © 2016年 likeme. All rights reserved.
//
#import "ColorDetectView.h"
#import "LJZSettingColorViewController.h"

@interface LJZSettingColorViewController ()<ColorDetectViewDelegate>
{
    UIImageView  *_colorWheel;
    UILabel      *_resultLabel;
    UIScrollView *_scrollView;
    UIView       *_pickView;
    
    
}
@property (nonatomic,assign) CGPoint  touchPoint;
@property (strong, nonatomic) ColorDetectView *colorDetectView;
@property (nonatomic,  copy) NSString         *hexColor;
@end

@implementation LJZSettingColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self initUI];
}
- (void)initUI{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    _scrollView.backgroundColor = kBackgroundColor;
    [self.view addSubview:_scrollView];
    
    CGFloat labelX = 30;
    CGFloat labelY = 100;
    CGFloat labelW = 100;
    CGFloat labelH = 30;
    
    UILabel *colorLable = [[UILabel alloc]initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    colorLable.text = @"色调";
    [_scrollView addSubview:colorLable];
    
    _resultLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelX, CGRectGetMaxY(colorLable.frame) + 20, kScreenSize.width - 2*labelX, labelH)];
    
    if (self.isTextColor) {
        if ([LJZTools isBlankString:[userDefaults objectForKey:@"textColor"]]) {
            _resultLabel.backgroundColor     = [UIColor greenColor];
        }else{
            _resultLabel.backgroundColor = [LJZTools getColorWithHexColor:[userDefaults objectForKey:@"textColor"]];
        }

    }else{
        if ([LJZTools isBlankString:[userDefaults objectForKey:@"bgColor"]]) {
            _resultLabel.backgroundColor     = [UIColor greenColor];
        }else{
            _resultLabel.backgroundColor = [LJZTools getColorWithHexColor:[userDefaults objectForKey:@"bgColor"]];
        }

    }
    [_scrollView addSubview:_resultLabel];
    
//    _colorWheel = [[UIImageView alloc]initWithFrame:CGRectMake(labelX, CGRectGetMaxY(_resultLabel.frame) + 20, kScreenSize.width - 2*labelX, kScreenSize.width - 2*labelX)];
//    _colorWheel.image = [UIImage imageNamed:@"colorwheel"];
//    _colorWheel.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
//    [_colorWheel addGestureRecognizer:tap];
    
    self.colorDetectView = [[ColorDetectView alloc]initWithFrame:CGRectMake(labelX, CGRectGetMaxY(_resultLabel.frame) + 20, kScreenSize.width - 2*labelX, kScreenSize.width - 2*labelX) andUIImage:[UIImage imageNamed:@"colorwheel"]];
    self.colorDetectView.delegate = self;
    [_scrollView addSubview:self.colorDetectView];
    
    [_scrollView addSubview:_colorWheel];
    
  
//    [self.view addGestureRecognizer:tap];
    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pangesture:)];
//    _pickView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"picker"]];
//    [_pickView addGestureRecognizer:pan];
//    _pickView.userInteractionEnabled = YES;
//    _pickView.hidden = YES;
//    [_colorWheel addSubview:_pickView];
    
    
    CGFloat buttonX = (kScreenSize.width - 2*labelX)/2;
    CGFloat buttonW = 50;
    CGFloat buttonH = 30;
   
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.frame = CGRectMake(buttonX - 50, CGRectGetMaxY(self.colorDetectView.frame) + 20, buttonW, buttonH);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_scrollView addSubview:cancleBtn];
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(buttonX + 50, CGRectGetMaxY(self.colorDetectView.frame) + 20, buttonW, buttonH);
    [okBtn setTitle:@"好啦" forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(okClick:) forControlEvents:UIControlEventTouchUpInside];
    [okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_scrollView addSubview:okBtn];
    
}
- (void)tapGesture:(UITapGestureRecognizer *)tap{
    
    self.touchPoint = [tap locationInView:_colorWheel];
    _pickView.center = self.touchPoint;
    _pickView.hidden = NO;
    [self getColorOfPoint:self.touchPoint InView:_colorWheel];
    
    
}
- (void)getColorOfPoint:(CGPoint)touchPoint InView:(UIView *)view{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel,
                                                 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -touchPoint.x, -touchPoint.y);
    
    [view.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    NSString *hexColor = [NSString stringWithFormat:@"0x%02x%02x%02x",pixel[0],pixel[1],pixel[2]];
    self.hexColor      = hexColor;
    [self getColorWithHexColor:hexColor];
}
- (void)getColorWithHexColor:(NSString *)hexColor{
  
    self.hexColor      = hexColor;
    
    //转换hex值
    unsigned int red ,green,blue;
    
    NSScanner *scanner = [NSScanner scannerWithString:[hexColor substringWithRange:NSMakeRange(1, 2)]];
    [scanner scanHexInt:&red];
    
    scanner = [NSScanner scannerWithString:[hexColor substringWithRange:NSMakeRange(3, 2)]];
    [scanner scanHexInt:&green];
    
    scanner = [NSScanner scannerWithString:[hexColor substringWithRange:NSMakeRange(5, 2)]];
    [scanner scanHexInt:&blue];
    _resultLabel.backgroundColor = LJZRGBColor(red, green, blue);
}
- (void)pangesture:(UIPanGestureRecognizer *)pan{
    if (pan.state == UIGestureRecognizerStateChanged) {
        _pickView.center = [pan locationInView:_colorWheel];
        [self getColorOfPoint:[pan locationInView:_colorWheel] InView:_colorWheel];
    }
}
- (void)cancleClick:(UIButton *)sender{
    [self dismiss];
}
- (void)okClick:(UIButton *)sender{
     self.ReturnColorBlack(self.hexColor,self.isTextColor);
    [self dismiss];
}
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)handelColor:(NSString *)hexColor
{
    [self getColorWithHexColor:hexColor];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
