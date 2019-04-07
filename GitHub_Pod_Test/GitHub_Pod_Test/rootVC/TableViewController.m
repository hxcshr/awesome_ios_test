//
//  TableViewController.m
//  GitHub_Pod_Test
//
//  Created by mengkezheng on 2019/3/25.
//  Copyright © 2019 com.qudao. All rights reserved.
//

#import "TableViewController.h"
#import "OOModel.h"
#import "GitHub_Pod_Test-Swift.h"
#import "WCDBViewController.h"

@interface TableViewController ()

@property (nonatomic, strong) NSArray <OOModel *> *dataArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    OOModel *m1 = [OOModel T:@"PromiseKit" C:[PromiseKitViewController class]];
    OOModel *m2 = [OOModel T:@"Cartography" C:[CartographyViewController class]];
    OOModel *m3 = [OOModel T:@"RxSwift" C:[RxSwiftViewController class]];
    OOModel *m4 = [OOModel T:@"lottie-ios" C:[Lottie_iosViewController class]];
    OOModel *m5 = [OOModel T:@"pop" C:[POPViewController class]];
    OOModel *m6 = [OOModel T:@"WCDB" C:[WCDBViewController class]];
    OOModel *m7 = [OOModel T:@"MVVM" C:[MVVMViewController class]];
    _dataArray = @[m1,m2,m3,m4,m5,m6,m7];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = _dataArray[indexPath.row].title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Class c = _dataArray[indexPath.row].showVCclass;
    [self.navigationController pushViewController:[c new] animated:YES];
}

@end
