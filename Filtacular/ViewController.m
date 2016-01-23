//
//  ViewController.m
//  Filtacular
//
//  Created by Todd Sampson on 1/7/16.
//  Copyright © 2016 Todd Sampson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButtonItem;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarBottonConstratint;

@end

@implementation ViewController {
    NSURL *mainURL_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mainURL_ = [NSURL URLWithString:@"http://filtacular.com"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:mainURL_]];
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
    if ([URLString rangeOfString:mainURL_.absoluteString].location == NSNotFound) {
        [self showToolar];
    } else {
        [self hideToolbar];
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self updateToolBarButtons];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self updateToolBarButtons];
}

#pragma mark - User Actions

- (IBAction)backButtonAction:(id)sender {
    [self.webView goBack];
}

- (IBAction)forwardButtonAction:(id)sender {
    [self.webView goForward];
}

- (IBAction)shareButtonAction:(id)sender {
    NSURL *currentURL = self.webView.request.URL;
    
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[currentURL]
                                      applicationActivities:nil];
    [self presentViewController:activityViewController
                       animated:YES
                     completion:nil];
}

- (void)updateToolBarButtons {
    self.backButtonItem.enabled = [self.webView canGoBack];
    self.forwardButtonItem.enabled = [self.webView canGoForward];
}

#pragma mark - Help Methods

- (void)showToolar {
    if (self.toolBarBottonConstratint.constant != 0) {
        self.toolBarBottonConstratint.constant = 0;
        [self.view setNeedsUpdateConstraints];
        
        [UIView animateWithDuration:0.15f animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)hideToolbar {
    if (self.toolBarBottonConstratint.constant != -44) {
        self.toolBarBottonConstratint.constant = -44;
        [self.view setNeedsUpdateConstraints];
        
        [UIView animateWithDuration:0.15f animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

@end
