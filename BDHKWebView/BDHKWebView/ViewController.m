//
//  ViewController.m
//  BDHKWebView
//
//  Created by zhushaobo on 2016/9/29.
//  Copyright © 2016年 Shaobo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
<UIWebViewDelegate,
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate>

@property (nonatomic, strong) UIWebView   *mWKWebView;
@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, assign) CGFloat     heightOfContent;

@end


#define kScreenWitdh  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation ViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mWKWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight)];
    _mWKWebView.backgroundColor = [UIColor clearColor];
    _mWKWebView.opaque = NO;
    _mWKWebView.delegate = self;
    _mWKWebView.scrollView.delegate = self;
    [self.view addSubview:_mWKWebView];
    
    self.mTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _mTableView.backgroundColor = [UIColor lightGrayColor];
    _mTableView.delegate = self;
    _mTableView.dataSource =self;
    [self.mWKWebView.scrollView addSubview:_mTableView];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"image1" ofType:@"html"];
    NSURL *baseUrl = [NSURL fileURLWithPath:path];
    NSString *stringHtml = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [_mWKWebView loadHTMLString:stringHtml baseURL:baseUrl];
}

#pragma  mark - UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *javaScriptString = @"document.body.offsetHeight";
    CGFloat heightContent = [[webView stringByEvaluatingJavaScriptFromString:javaScriptString] floatValue];
    _heightOfContent = heightContent;
    
    _mWKWebView.scrollView.contentSize = CGSizeMake(kScreenWitdh, _heightOfContent+kScreenHeight);
    _mTableView.frame = CGRectMake(0, _heightOfContent, kScreenWitdh, kScreenHeight);
}

#pragma  mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _mTableView.scrollEnabled = (_mWKWebView.scrollView.contentOffset.y<_heightOfContent)?NO:YES;
    
    if ([scrollView isEqual:_mWKWebView.scrollView]) {
        _mWKWebView.scrollView.bounces = (_mWKWebView.scrollView.contentOffset.y>0)?NO:YES;
    }
    if ([scrollView isEqual:_mTableView]) {
        _mTableView.bounces = (_mTableView.contentOffset.y>0)?YES:NO;
    }
}

#pragma  mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10.f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kCell = @"kCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCell];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d-%d",indexPath.section,indexPath.row];
    
    return cell;
}


@end
