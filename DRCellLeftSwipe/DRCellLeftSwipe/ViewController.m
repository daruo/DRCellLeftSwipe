//
//  ViewController.m
//  DRCellLeftSwipe
//
//  Created by Daruo on 2018/7/3.
//  Copyright © 2018年 BeeSmart. All rights reserved.
//

#import "ViewController.h"
#import "DRSystermCellSwipe.h"
#import "MGSwipeButton.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,MGSwipeTableCellDelegate>
/** <#param#>     */
@property (nonatomic, strong) UITableView                    *tableView;
/** <#param#>     */
@property (nonatomic, strong) NSMutableArray                 *dateSourceArray;
@end
static NSString *const musicStepCellIdtntifer = @"musicStepCellIdtntifer";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义左滑";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"原生" style:UIBarButtonItemStylePlain target:self action:@selector(go)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}


-(void)go {
    DRSystermCellSwipe *systermSwipe = [[DRSystermCellSwipe alloc] init];
    [self.navigationController pushViewController:systermSwipe animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dateSourceArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MGSwipeTableCell * cell = [tableView dequeueReusableCellWithIdentifier:musicStepCellIdtntifer];
    if (!cell) {
        cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:musicStepCellIdtntifer];
    }
    cell.delegate = self;
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld行",indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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


#pragma mark Swipe Delegate
-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell canSwipe:(MGSwipeDirection) direction{
    if (direction == MGSwipeDirectionLeftToRight ) {
        return NO;
    }
    return YES;
}


-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings {
    swipeSettings.transition = MGSwipeTransitionBorder;
    expansionSettings.buttonIndex = 0;
    __weak ViewController * me = self;
    if (direction == MGSwipeDirectionRightToLeft) {
        expansionSettings.fillOnTrigger = YES;
        expansionSettings.threshold = 1.1;
        CGFloat padding = 15;
        MGSwipeButton * delete = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor colorWithRed:1.0 green:59/255.0 blue:50/255.0 alpha:1.0] padding:padding callback:^BOOL(MGSwipeTableCell *sender) {

            NSIndexPath * indexPath = [me.tableView indexPathForCell:sender];
            [me deleteMail:indexPath];
            return NO;
        }];
        MGSwipeButton * edit = [MGSwipeButton buttonWithTitle:@"编辑" backgroundColor:[UIColor colorWithRed:1.0 green:149/255.0 blue:0.05 alpha:1.0] padding:padding callback:^BOOL(MGSwipeTableCell *sender) {
            
            
            
            return YES;
        }];
        return @[delete, edit];
    }
    return nil;
}

-(void) swipeTableCell:(MGSwipeTableCell*) cell didChangeSwipeState:(MGSwipeState)state gestureIsActive:(BOOL)gestureIsActive {
    NSString * str;
    switch (state) {
        case MGSwipeStateNone: str = @"None"; break;
        case MGSwipeStateSwippingLeftToRight: str = @"SwippingLeftToRight"; break;
        case MGSwipeStateSwippingRightToLeft: str = @"SwippingRightToLeft"; break;
        case MGSwipeStateExpandingLeftToRight: str = @"ExpandingLeftToRight"; break;
        case MGSwipeStateExpandingRightToLeft: str = @"ExpandingRightToLeft"; break;
    }
    NSLog(@"Swipe state: %@ ::: Gesture: %@", str, gestureIsActive ? @"Active" : @"Ended");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)dateSourceArray {
    if (!_dateSourceArray) {
        _dateSourceArray = [@[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"] mutableCopy];
    }
    return _dateSourceArray;
}
-(void) deleteMail:(NSIndexPath *) indexPath {

    [self.dateSourceArray removeObjectAtIndex:indexPath.row];
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}



@end
