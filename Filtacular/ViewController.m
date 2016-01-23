//
//  ViewController.m
//  Filtacular
//
//  Created by Todd Sampson on 1/7/16.
//  Copyright © 2016 Todd Sampson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://filtacular.com"];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self addPullToRefreshToWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addPullToRefreshToWebView{
    UIColor *whiteColor = [UIColor whiteColor];
    UIRefreshControl *refreshController = [UIRefreshControl new];
    NSString *string = @"Pull down to refresh...";
    NSDictionary *attributes = @{ NSForegroundColorAttributeName : whiteColor };
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithString:string attributes:attributes];
    refreshController.bounds = CGRectMake(0, 0,
                                          refreshController.bounds.size.width,
                                          refreshController.bounds.size.height);
    refreshController.attributedTitle = attributedString;
    [refreshController addTarget:self action:@selector(refreshWebView:)
                forControlEvents:UIControlEventValueChanged];
    [refreshController setTintColor:whiteColor];
    [self.webView.scrollView addSubview:refreshController];
}

- (void)refreshWebView:(UIRefreshControl*)refreshController{
    [self.webView reload];
    [refreshController endRefreshing];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *URLString = [[request URL] absoluteString];
    NSString *referenceString = @"http://filtacular.com";
    
    BOOL URLStringContainsReferenceString = !([URLString rangeOfString:referenceString].location == NSNotFound);
    
    if (URLStringContainsReferenceString) {
        self.toolbar.alpha = 0;
    } else {
        self.toolbar.alpha = 1;
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
}

#pragma mark - Actions

- (IBAction)backButtonTapped:(id)sender {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }
}

- (IBAction)forwardButtonTapped:(id)sender {
    if (self.webView.canGoForward) {
        [self.webView goForward];
    }
}

- (IBAction)actionButtonTapped:(id)sender {
    
}

@end
