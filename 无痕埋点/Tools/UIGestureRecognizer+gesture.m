//
//  UIGestureRecognizer+gesture.m
//  无痕埋点
//
//  Created by isoft on 2019/1/3.
//  Copyright © 2019 isoft. All rights reserved.
//

#import "UIGestureRecognizer+gesture.h"
#import <objc/runtime.h>


@implementation UIGestureRecognizer (gesture)


-(void)setMethodName:(NSString *)methodName
{
    objc_setAssociatedObject(self, @"methodName", methodName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


-(NSString *)methodName
{
    return objc_getAssociatedObject(self, @"methodName");
}
@end
