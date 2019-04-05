//
//  OOModel.h
//  GitHub_Pod_Test
//
//  Created by mengkezheng on 2019/3/25.
//  Copyright © 2019 com.qudao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OOModel : NSObject

+ (OOModel *)T:(NSString *)t C:(Class)c;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) Class showVCclass;

@end

NS_ASSUME_NONNULL_END
