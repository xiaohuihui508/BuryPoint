//
//  TestModel.h
//  无痕埋点
//
//  Created by isoft on 2019/1/3.
//  Copyright © 2019 isoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LikeModel.h"
@interface TestModel : NSObject

@property(nonatomic,assign)NSInteger age;


@property(nonatomic,strong)NSString * name;


@property(nonatomic,strong)NSString * sex;


@property(nonatomic,strong)NSString * genDer;


@property(nonatomic,strong)LikeModel * secondModel;


@end
