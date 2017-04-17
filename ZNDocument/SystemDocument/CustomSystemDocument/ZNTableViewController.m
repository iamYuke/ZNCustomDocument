//
//  ZNTableViewController.m
//  ZNDocument
//
//  Created by ZhangNanBoy on 16/8/8.
//  Copyright © 2016年 zhangnanboy. All rights reserved.
//

#import "ZNTableViewController.h"
#import "ZNWebTestController.h"
#import "ExpressTestController.h"
#import "ZNBesselTestController.h"
#import "CALayerTestController.h"
#import "ZNSlideMenu.h"
#import "ZNTestCell.h"
#import "ZNLocalStoreTestController.h"
#import "ZNStartTestController.h"
#import "ZNNetworkRequestTestController.h"
#import "ZNUItableViewTestController.h"
#import "ZNCoreTextTestController.h"
#import "AppleInPurchasingTestController.h"
#import "ZNLiveTestController.h"
#import "ZNSysPhotoAlbumTestController.h"
#import "ZNGoodDemoCollectionTestController.h"
@interface ZNTableViewController ()<UIScrollViewDelegate,ZNSlideMenuDelegate>

@property(nonatomic, strong)NSMutableArray *dataArray;// 数据源

@property(nonatomic,strong)UIButton *trigger;

@property(nonatomic, strong)ZNSlideMenu *slideMenu;

@property(nonatomic, strong)NSMutableArray *controllerNames;


@end

@implementation ZNTableViewController


- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObjectsFromArray:@[@"Web交互测试",@"Express表情处理",@"Bessel测试",@"Layer测试",@"本地存储",@"启动图",@"网络请求",@"UITableview",@"富文本和加载Html语言",@"苹果内购",@"直播",@"系统相册",@"好的Demo"]];
    }
    return _dataArray;
}

-(NSMutableArray *)controllerNames
{
    if (!_controllerNames) {
        _controllerNames = [NSMutableArray array];
        [_controllerNames addObjectsFromArray:@[@"ZNWebTestController",@"ExpressTestController",@"ZNBesselTestController",@"CALayerTestController",@"ZNLocalStoreTestController",@"ZNStartTestController",@"ZNNetworkRequestTestController",@"ZNUItableViewTestController",@"ZNCoreTextTestController",@"AppleInPurchasingTestController",@"ZNLiveTestController",@"ZNSysPhotoAlbumTestController",@"ZNGoodDemoCollectionTestController"]];
        
    }
    return _controllerNames;
}

- (UIButton *)trigger{
    if (!_trigger) {
        _trigger = [UIButton buttonWithType:UIButtonTypeCustom];
        _trigger.frame = CGRectMake(SCREENT_WIDTH - 100 - 20, SCREENT_HEIGHT - 20 - 36 - 64 - 100, 100, 36);
        [_trigger setTitle:@"Trigger" forState:UIControlStateNormal];
        [_trigger setTitleColor:MyColor(0, 188, 255) forState:UIControlStateNormal];
        _trigger.titleLabel.font = MyFont(20);
        [_trigger addTarget:self action:@selector(triggerAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _trigger;
}

- (ZNSlideMenu *)slideMenu
{
    if (!_slideMenu) {
        _slideMenu = [[ZNSlideMenu alloc] initWithTitile:@[@"首页",@"消息",@"发布",@"发现",@"个人"]];
        _slideMenu.menuClickBlock = ^(NSInteger index,NSString *title) {
            MyLog(@"第%ld个的标题是%@",index,title);
        };
        _slideMenu.delegate = self;
    }
    return _slideMenu;
}

- (void)triggerAction:(UIButton *)sender
{
    MyLog(@"SlideMenu"); // 只有加载到window上的第一个View才会往上移动
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [self.slideMenu trigger];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试数据";
    [self configureUI];
    
}


- (void)configureUI
{
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    self.tableView.backgroundColor = MyColor(247, 247, 247);
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
//    [self.view addSubview:self.trigger];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZNTestCell *cell = [ZNTestCell getZNTestCellWith:tableView];
    cell.testTitle = self.dataArray[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];//反选让cell取消选中状态
    
    NSString *title = self.dataArray[indexPath.row];
    NSString *controllerName = self.controllerNames[indexPath.row];
    UIViewController *testController = [[NSClassFromString(controllerName) alloc] init];
    testController.title = title;
    [self.navigationController pushViewController:testController animated:YES];
}


#pragma mark - 复制操作 系统自带
/*
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if (action == @selector(copy:)) {
        return YES;
    }
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if (action == @selector(copy:)) {
        [MBProgressHUD showSuccess:@"复制成功"];
    }
}
*/


#pragma mark - 滑动的ScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView // 使用UITableViewController会使加在上面的子控件随着tableView滑动而滑动
{
    self.trigger.y = scrollView.contentOffset.y + self.tableView.height - self.trigger.height - 20;
    [self.view bringSubviewToFront:self.trigger];
}

// View controller-based status bar appearance 需要设置为YES
#pragma mark - 状态栏的改变重载
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}
//
//- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
//{
//    return UIStatusBarAnimationSlide;
//}

#pragma mark - 侧滑消失
- (void)finishHidden
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

@end
