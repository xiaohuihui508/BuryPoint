//
//  MethodSwizzingTool.h
//  无痕埋点
//
//  Created by isoft on 2019/1/3.
//  Copyright © 2019 isoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MethodSwizzingTool : NSObject


+ (void)swizzingForClass:(Class)cls originalSel:(SEL)originalSelector swizzingSel:(SEL)swizzingSelector;


@end
