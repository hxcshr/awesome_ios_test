//
//  DBModel.m
//  GitHub_Pod_Test
//
//  Created by 何学成 on 2019/4/5.
//  Copyright © 2019 com.qudao. All rights reserved.
//

#import "DBModel.h"

@implementation DBModel

WCDB_IMPLEMENTATION(DBModel)
WCDB_SYNTHESIZE(DBModel, name)
WCDB_SYNTHESIZE(DBModel, age)
WCDB_SYNTHESIZE(DBModel, user_id)
WCDB_PRIMARY_AUTO_INCREMENT(DBModel, user_id)

- (NSString *)description
{
    return [NSString stringWithFormat:@"姓名：%@ 年龄：%@", self.name,@(self.age)];
}

@end

