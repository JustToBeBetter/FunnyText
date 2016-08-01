//
//  ViewController.m
//  FunnyText
//
//  Created by 李金柱 on 16/3/31.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import "ViewController.h"
#import "AppDelegate.h"
#import "LJZBaseInteractionController.h"
#import "LJZReversibleAnimationController.h"
#import "LJZTurnAnimationController.h"
#import "LJZTextViewController.h"
#import "LJZCardsAnimatonController.h"
#import "LJZSettingColorViewController.h"
#import "LJZHistoryTableViewController.h"


//必须要由UUID来唯一标示对应的service和characteristic

#define kServiceUUID @"5C476471-1109-4EBE-A826-45B4F9D74FB9"

#define kCharacteristicHeartRateUUID @"82C7AC0F-6113-4EC9-92D1-5EEF44571398"

#define kCharacteristicBodyLocationUUID @"537B5FD6-1889-4041-9C35-F6949D1CA034"

@interface ViewController ()<UIViewControllerTransitioningDelegate,CBCentralManagerDelegate,CBPeripheralDelegate>
{
    UIScrollView   *_scrollView;
    UITextField    *_ljzTextField;
    UIButton       *_backgroundColorBtn;
    UIButton       *_textColorBtn;
    NSUserDefaults *_userDefaults;
    CGFloat        _speed;
    NSMutableArray *_historyArray;
}
@property (nonatomic,strong) CBCentralManager  *centralManager;
@property (nonatomic,strong) CBPeripheral  *preipheal;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _userDefaults = [NSUserDefaults standardUserDefaults];
  
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboards:)];
    [self.view addGestureRecognizer:tap];
    [self initUI];
    
    
}

- (void)hideKeyboards:(UITapGestureRecognizer *)tap{
    
    [_ljzTextField resignFirstResponder];
    
}
- (void)initUI{

    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    _scrollView.backgroundColor = kBackgroundColor;
    [self.view addSubview:_scrollView];
    
    CGFloat textFieldX = 50;
    CGFloat textFiledY = 40;
    CGFloat textFiledW = kScreenSize.width - 2*textFieldX;
    CGFloat textFiledH = 40;
    
    _ljzTextField = [[UITextField alloc]initWithFrame:CGRectMake(textFieldX, textFiledY, textFiledW, textFiledH)];
    _ljzTextField.borderStyle = UITextBorderStyleRoundedRect;
    [_scrollView addSubview:_ljzTextField];
    
    UIButton *historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    historyBtn.frame = CGRectMake(CGRectGetMaxX(_ljzTextField.frame) + 10, textFiledY, 30, 30);
    [historyBtn addTarget:self action:@selector(historyEvent:) forControlEvents:UIControlEventTouchUpInside];
    [historyBtn setBackgroundImage:[UIImage imageNamed:@"history"] forState:UIControlStateNormal];
    [_scrollView addSubview:historyBtn];
    
    
    UIButton *showBtn = [[UIButton alloc]initWithFrame:CGRectMake(textFieldX, CGRectGetMaxY(_ljzTextField.frame) + 30, textFiledW, 30)];
    [showBtn setTitle:@"显示文字" forState:UIControlStateNormal];
    [showBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showBtn setBackgroundColor:LJZRGBColor(230, 230, 230)];
    [showBtn addTarget:self action:@selector(showText:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:showBtn];
    
    UILabel *textColorLabel = [[UILabel alloc]initWithFrame:CGRectMake(textFieldX, CGRectGetMaxY(showBtn.frame) + 20, 120, 30)];
    textColorLabel.text = @"文字颜色";
    [_scrollView addSubview:textColorLabel];
    
    _textColorBtn = [[UIButton alloc]initWithFrame:CGRectMake(textFieldX, CGRectGetMaxY(textColorLabel.frame) + 10 , textFiledW, textFiledH)];
    [_textColorBtn addTarget:self action:@selector(selectTextColor:) forControlEvents:UIControlEventTouchUpInside];
    _textColorBtn.layer.cornerRadius  = 5;
    _textColorBtn.layer.masksToBounds = YES;
    if ([LJZTools isBlankString:[_userDefaults objectForKey:@"textColor"]]) {
        _textColorBtn.backgroundColor = [UIColor purpleColor];
    }else{
        _textColorBtn.backgroundColor = [LJZTools getColorWithHexColor:[_userDefaults objectForKey:@"textColor"]];
    }
    
    [_scrollView addSubview:_textColorBtn];
    
    
    UILabel *backgroundColorLabel = [[UILabel alloc]initWithFrame:CGRectMake(textFieldX, CGRectGetMaxY(_textColorBtn.frame) + 10, 120, 30)];
    backgroundColorLabel.text = @"背景颜色";
    [_scrollView addSubview:backgroundColorLabel];
    
    _backgroundColorBtn = [[UIButton alloc]initWithFrame:CGRectMake(textFieldX, CGRectGetMaxY(backgroundColorLabel.frame) + 20 , textFiledW, textFiledH)];
    [_backgroundColorBtn addTarget:self action:@selector(selectBackgroundColor:) forControlEvents:UIControlEventTouchUpInside];
    _backgroundColorBtn.layer.cornerRadius  = 5;
    _backgroundColorBtn.layer.masksToBounds = YES;
    
    if ([LJZTools isBlankString:[_userDefaults objectForKey:@"bgColor"]]) {
            _backgroundColorBtn.backgroundColor     = [UIColor greenColor];
    }else{
           _backgroundColorBtn.backgroundColor = [LJZTools getColorWithHexColor:[_userDefaults objectForKey:@"bgColor"]];
    }
   
    [_scrollView addSubview:_backgroundColorBtn];
    
    
    
    UILabel *speedLabel = [[UILabel alloc]initWithFrame:CGRectMake(textFieldX, CGRectGetMaxY(_backgroundColorBtn.frame) + 10, 120, 30)];
    speedLabel.text = @"速度";
    [_scrollView addSubview:speedLabel];
    
    ASValueTrackingSlider *speedSlider = [[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(textFieldX, CGRectGetMaxY(speedLabel.frame) + 20, textFiledW, textFiledH)];
    if ([_userDefaults floatForKey:@"speed"]) {
        speedSlider.value = [_userDefaults floatForKey:@"speed"];
    }
    [speedSlider addTarget:self action:@selector(sliderEvent:) forControlEvents:UIControlEventTouchUpInside];
    speedSlider.minimumValue = 0;
    speedSlider.maximumValue = 5;
    
    [speedSlider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
    speedSlider.minimumTrackTintColor = [UIColor orangeColor];
    
//    [speedSlider setMinimumTrackImage:[UIImage imageNamed:@"slider_backGround"] forState:UIControlStateNormal];
//    speedSlider.minimumValueImage = [UIImage imageNamed:@"slider_backGround"];
    [_scrollView addSubview:speedSlider];
    

}
- (void)historyEvent:(UIButton *)sender{
     AppDelegateAccessor.textAnimationController = [[LJZTurnAnimationController alloc]init];
    LJZHistoryTableViewController *historyVC = [[LJZHistoryTableViewController alloc]init];
    historyVC.PassHistoryString = ^(NSString *historyString){
        _ljzTextField.text = historyString;
    };
    historyVC.transitioningDelegate = self;
    [self presentViewController:historyVC animated:YES completion:nil];
}
- (void)sliderEvent:(UISlider *)sender{
    
    [_userDefaults setFloat:sender.value forKey:@"speed"];
    
    if (sender.value) {
        _speed = sender.value ;
    }
}
- (void)showText:(UIButton *)sender{
    
    if ([LJZTools isBlankString:_ljzTextField.text]) {
        
        return;
    }
    
   NSString *path = [[LJZHistoryManager sharedInstance]getPlistPath];
   _historyArray = [NSMutableArray arrayWithContentsOfFile:path];
    
    if (![_historyArray containsObject: _ljzTextField.text]) {
        [_historyArray addObject:_ljzTextField.text];
    }

    [[NSArray arrayWithArray:_historyArray]writeToFile:path atomically:YES];
   // AppDelegateAccessor.textAnimationController = [[LJZTurnAnimationController alloc]init];
    
    LJZTextViewController *showTextVC = [[LJZTextViewController alloc]init];
    showTextVC.transitioningDelegate = self;
    showTextVC.text     = _ljzTextField.text;
    showTextVC.isV      = YES;
    showTextVC.isMoving = YES;
    showTextVC.speed    = _speed;
    [self presentViewController:showTextVC animated:YES completion:nil];
}
- (void)selectTextColor:(UIButton *)sender{
    
    [_ljzTextField resignFirstResponder];
     AppDelegateAccessor.textAnimationController = [[LJZCardsAnimatonController alloc]init];
    
    LJZSettingColorViewController *settingVC = [[LJZSettingColorViewController alloc]init];
    settingVC.isTextColor = YES;
    settingVC.ReturnColorBlack = ^(NSString *hexColor,BOOL isTetColor){
        
        [_userDefaults setObject:hexColor forKey:@"textColor"];
        if (isTetColor) {
                _textColorBtn.backgroundColor = [LJZTools getColorWithHexColor:hexColor];
        }
    };
    settingVC.transitioningDelegate = self;
    [self presentViewController:settingVC animated:YES completion:nil];
}
- (void)selectBackgroundColor:(UIButton *)sender{
    
    [_ljzTextField resignFirstResponder];

    AppDelegateAccessor.textAnimationController = [[LJZCardsAnimatonController alloc]init];
    
    LJZSettingColorViewController *settingVC = [[LJZSettingColorViewController alloc]init];
    settingVC.transitioningDelegate = self;
    
    settingVC.isTextColor = NO;
    settingVC.ReturnColorBlack = ^(NSString *hexColor,BOOL isTetColor){
        [_userDefaults setObject:hexColor forKey:@"bgColor"];

        if (!isTetColor) {
                _backgroundColorBtn.backgroundColor = [LJZTools getColorWithHexColor:hexColor];
        }
        
    };
    [self presentViewController:settingVC animated:YES completion:nil];
    
}
#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if (AppDelegateAccessor.textInteractionController) {
        [AppDelegateAccessor.textInteractionController wireToViewController:presented forOperation:LJZInteractionOperationDismiss];
    }
    
    AppDelegateAccessor.textAnimationController.reverse = NO;
    return AppDelegateAccessor.textAnimationController;
    
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    AppDelegateAccessor.textAnimationController.reverse = YES;
    return AppDelegateAccessor.textAnimationController;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    AppDelegateAccessor.textAnimationController = nil;
    return AppDelegateAccessor.textInteractionController && AppDelegateAccessor.textInteractionController.interactionInProgress ? AppDelegateAccessor.textInteractionController : nil;
}
//- (BOOL) shouldAutorotateToInterfaceOrientation:
//(UIInterfaceOrientation)toInterfaceOrientation {
//  
//        return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
//}
//- (NSUInteger)supportedInterfaceOrientations {
//        return UIInterfaceOrientationMaskPortrait;
//}


@end
