//
//  WCDBViewController.m
//  GitHub_Pod_Test
//
//  Created by 何学成 on 2019/4/5.
//  Copyright © 2019 com.qudao. All rights reserved.
//

#import "WCDBViewController.h"
#import "DBModel.h"
#import <WCDB/WCDB.h>
#import "DBModel.h"
#import <Masonry/Masonry.h>


@interface WCDBViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) WCTDatabase *database;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *ageField;
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation WCDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    _dataArray = [[self.database getAllObjectsOfClass:DBModel.class fromTable:@"user"] mutableCopy];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] init];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.5);
    }];
    
    _nameField = [[UITextField alloc] init];
    _nameField.placeholder = @"姓名";
    _nameField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_nameField];
    [_nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(self.tableView.mas_left).mas_offset(-8);
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(self.view.mas_centerY).mas_offset(-50);
    }];
    _ageField = [[UITextField alloc] init];
    _ageField.placeholder = @"年龄";
    _ageField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_ageField];
    [_ageField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(self.tableView.mas_left).mas_offset(-8);
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(self.view);
    }];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(self.tableView.mas_left).mas_offset(-8);
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(self.view.mas_centerY).mas_offset(50);
    }];
    _saveBtn = btn;
}

- (void)btnClick:(UIButton *)sender {
    NSString *name = _nameField.text;
    NSString *ageStr = _ageField.text;
    if (name.length <= 0 || ageStr.length <= 0) {
        return;
    }
    NSInteger age = [ageStr integerValue];
    DBModel *model = [[DBModel alloc] init];
    model.isAutoIncrement = YES;
    model.age = age;
    model.name = name;
    if ([self.database insertObject:model into:@"user"]) {
        [_dataArray addObject:model];
        [_tableView reloadData];
        _nameField.text = @"";
        _ageField.text = @"";
    }
    
}

- (WCTDatabase *)database {
    static WCTDatabase *db = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        db = [[WCTDatabase alloc] initWithPath:[docDir stringByAppendingPathComponent:@"my_db"]];
        if ([db canOpen]) {
            [db createTableAndIndexesOfName:@"user" withClass:[DBModel class]];
            //如果表不存在就创建表，如果字段有更新，就更新表，所以不用判断是否已经存在该表
        }
    });
    _database = db;
    return _database;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    DBModel *model = _dataArray[indexPath.row];
    cell.textLabel.text = model.description;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DBModel *model = _dataArray[indexPath.row];
        if ([self.database deleteObjectsFromTable:@"user" where:DBModel.user_id.is(model.user_id)]) {
            [_dataArray removeObject:model];
            [tableView reloadData];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.isEditing) {
        return;
    }
    DBModel *model = _dataArray[indexPath.row];
    __weak typeof(self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"姓名";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.text = model.name;
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"年龄";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.text = [NSString stringWithFormat:@"%@",@(model.age)];
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"修改" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *name = alert.textFields[0].text;
        NSString *ageStr = alert.textFields[1].text;
        if (name.length <= 0 || ageStr.length <= 0) {
            return;
        }
        NSInteger age = [ageStr integerValue];
        model.age = age;
        model.name = name;
        
        if ([self.database updateAllRowsInTable:@"user" onProperties:{DBModel.age ,DBModel.name} withObject:model]) {
            [weakSelf.tableView reloadData];
            NSLog(@"修改成功");
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];

}



@end
