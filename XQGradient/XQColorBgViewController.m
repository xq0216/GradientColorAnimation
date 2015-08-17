//
//  XQColorBgViewController.m
//  XQCalculator
//
//  Created by Candy Love on 15/8/10.
//  Copyright (c) 2015年 XQ. All rights reserved.
//

#import "XQColorBgViewController.h"

@interface XQColorBgViewController (){
    NSInteger currentIndex;
    BOOL bFirstLayerHide;
    NSMutableArray *p_allColors;
}
@property (strong, nonatomic) CAGradientLayer *gradientLayer0;
@property (strong, nonatomic) CAGradientLayer *gradientLayer1;
@end

@implementation XQColorBgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI{
    self.view.backgroundColor = [UIColor blackColor];
    currentIndex = 0;
    bFirstLayerHide = NO;

    _gradientLayer0 = [CAGradientLayer layer];
    _gradientLayer0.frame = self.view.bounds;
    _gradientLayer0.startPoint = CGPointMake(0, 0);
    _gradientLayer0.endPoint = CGPointMake(1, 0);
    [self.view.layer addSublayer:_gradientLayer0];

    _gradientLayer1 = [CAGradientLayer layer];
    _gradientLayer1.frame = self.view.bounds;
    _gradientLayer1.endPoint = CGPointMake(0, 0);
    _gradientLayer1.startPoint = CGPointMake(0, 1);
    [self.view.layer addSublayer:_gradientLayer1];



    p_allColors = [NSMutableArray array];
    NSArray *colors = @[@[@"e02d6f",@"fc963f"],
                        @[@"8217b7",@"edaa9c"],
                        @[@"194fb8",@"05c6d1"],
                        @[@"44cd9e",@"e7dd4b"],
                        @[@"0fa9a8",@"dfcee5"],
                        @[@"2cbedf",@"e5d8b9"]];
    [colors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableArray *item = [NSMutableArray array];
        NSArray *ary = obj;
        [ary enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIColor *color0 = [self colorWithHexString:obj];
            [item addObject:(id)[color0 CGColor]];
        }];
        [p_allColors addObject:item];
    }];

    _gradientLayer0.colors = p_allColors[currentIndex];
    currentIndex++;
    _gradientLayer1.colors = p_allColors[currentIndex];

    [self performAnimation];

}

- (void)performAnimation {

    [_gradientLayer0 removeAllAnimations];
    [_gradientLayer1 removeAllAnimations];

    CGFloat fromNum = (bFirstLayerHide)?0.:1.;
    CABasicAnimation *animation0;
    animation0 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animation0 setFromValue:[NSNumber numberWithFloat:fromNum]];
    [animation0 setToValue:[NSNumber numberWithFloat:1-fromNum]];
    [animation0 setDuration:5];
    [animation0 setRemovedOnCompletion:NO];
    [animation0 setFillMode:kCAFillModeForwards];
    [animation0 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation0 setDelegate:self];
    [_gradientLayer0 addAnimation:animation0 forKey:@"animateGradient0"];


    CABasicAnimation *animation1;
    animation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animation1 setFromValue:[NSNumber numberWithFloat:1-fromNum]];
    [animation1 setToValue:[NSNumber numberWithFloat:fromNum]];
    [animation1 setDuration:5];
    [animation1 setRemovedOnCompletion:NO];
    [animation1 setFillMode:kCAFillModeForwards];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation1 setDelegate:self];
    [_gradientLayer1 addAnimation:animation1 forKey:@"animateGradient1"];
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    if (!flag) {
        return;
    }
    CAAnimation *ani1 = [_gradientLayer1 animationForKey:@"animateGradient1"];
    if (ani1 == animation){
        bFirstLayerHide = !bFirstLayerHide;
        if (!bFirstLayerHide) {
            currentIndex ++ ;
            if (currentIndex >= p_allColors.count) {
                currentIndex = 0;
            }
            _gradientLayer1.colors = p_allColors[currentIndex];
        }
        else{
            currentIndex ++ ;
            if (currentIndex >= p_allColors.count) {
                currentIndex = 0;
            }
            _gradientLayer0.colors = p_allColors[currentIndex];
        }
        [self performAnimation];
    }
}

#pragma mark - color
- (UIColor *) colorWithHexString: (NSString *) stringToConvert alpha:(CGFloat)alphaNum
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString]; //去掉前后空格换行符

    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor redColor];

    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor redColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];

    range.location = 2;
    NSString *gString = [cString substringWithRange:range];

    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];  //扫描16进制到int
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alphaNum];
}

- (UIColor *) colorWithHexString: (NSString *)stringToConvert
{
    return [self colorWithHexString:stringToConvert alpha:1.];
}

@end
