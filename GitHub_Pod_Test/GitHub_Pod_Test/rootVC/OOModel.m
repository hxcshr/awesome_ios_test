//
//  OOModel.m
//  GitHub_Pod_Test
//
//  Created by mengkezheng on 2019/3/25.
//  Copyright © 2019 com.qudao. All rights reserved.
//

#import "OOModel.h"

@implementation OOModel

+ (OOModel *)T:(NSString *)t C:(Class)c {
    OOModel *m = [OOModel new];
    m.title = t;
    m.showVCclass = c;
    return m;
}

@end
