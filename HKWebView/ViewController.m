//
//  ViewController.m
//  HKWebView
//
//  Created by zhushaobo on 2016/9/22.
//  Copyright © 2016年 Shaobo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *mWKWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"html"];
    NSURL *baseUrl = [NSURL fileURLWithPath:path];
    NSString *stringHtml = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [_mWKWebView loadHTMLString:stringHtml baseURL:baseUrl];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
