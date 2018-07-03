//
//  DRSystermCellSwipe.m
//  DRCellLeftSwipe
//
//  Created by Daruo on 2018/7/3.
//  Copyright © 2018年 BeeSmart. All rights reserved.
//

#import "DRSystermCellSwipe.h"

@interface DRSystermCellSwipe ()<UITableViewDelegate,UITableViewDataSource>
/** <#param#>     */
@property (nonatomic, strong) UITableView                    *tableView;
/** <#param#>     */
@property (nonatomic, strong) NSMutableArray                 *dateSourceArray;
@end
static NSString *const musicStepCellIdtntifer02 = @"musicStepCellIdtntifer02";
@implementation DRSystermCellSwipe

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"原生左滑";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dateSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:musicStepCellIdtntifer02];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:musicStepCellIdtntifer02];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld行",indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}



#pragma iOS11 后左滑将进入此方法，设置 actions.performsFirstActionWithFullSwipe = NO 可以控制是否自动删除。

- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos){
    
    // delete action
    UIContextualAction *deleteAction = [UIContextualAction
                                        contextualActionWithStyle:UIContextualActionStyleDestructive
                                        title:@"删除"
                                        handler:^(UIContextualAction * _Nonnull action,
                                                  __kindof UIView * _Nonnull sourceView,
                                                  void (^ _Nonnull completionHandler)(BOOL))
                                        {
                                            
                                            
                                            completionHandler(true);
                                        }];
    
    UIContextualAction *editeAction = [UIContextualAction
                                       contextualActionWithStyle:UIContextualActionStyleNormal
                                       title:@"编辑"
                                       handler:^(UIContextualAction * _Nonnull action,
                                                 __kindof UIView * _Nonnull sourceView,
                                                 void (^ _Nonnull completionHandler)(BOOL))
                                       {
                                           
                                           
                                           completionHandler(true);
                                       }];
    
    
    UISwipeActionsConfiguration *actions = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction,editeAction]];
    actions.performsFirstActionWithFullSwipe = NO;
    
    return actions;
}



- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // 添加一个删除的按钮
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        // 做对应的操作
        
        [self.dateSourceArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    // 设置颜色
    deleteAction.backgroundColor = [UIColor redColor];
    
    // 添加一个标记未读按钮
    UITableViewRowAction *unreadAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [tableView setEditing:NO animated:YES];
        
    }];
    
    unreadAction.backgroundColor = [UIColor blueColor];
    return @[deleteAction,unreadAction];
    
    
}


-(NSMutableArray *)dateSourceArray {
    if (!_dateSourceArray) {
        _dateSourceArray = [@[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"] mutableCopy];
    }
    return _dateSourceArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
