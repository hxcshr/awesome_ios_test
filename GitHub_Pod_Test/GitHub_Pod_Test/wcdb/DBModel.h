//
//  DBModel.h
//  GitHub_Pod_Test
//
//  Created by 何学成 on 2019/4/5.
//  Copyright © 2019 com.qudao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBModel : NSObject <WCTTableCoding>

@property int user_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;

WCDB_PROPERTY(user_id)
WCDB_PROPERTY(name)
WCDB_PROPERTY(age)

@end

NS_ASSUME_NONNULL_END
