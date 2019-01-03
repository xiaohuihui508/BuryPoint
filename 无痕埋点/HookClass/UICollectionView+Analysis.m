//
//  UICollectionView+Analysis.m
//  无痕埋点
//
//  Created by isoft on 2019/1/3.
//  Copyright © 2019 isoft. All rights reserved.
//

#import "UICollectionView+Analysis.h"
#import "MethodSwizzingTool.h"
#import <objc/runtime.h>

@implementation UICollectionView (Analysis)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalAppearSelector = @selector(setDelegate:);
        SEL swizzingAppearSelector = @selector(user_setDelegate:);
        [MethodSwizzingTool swizzingForClass:[self class] originalSel:originalAppearSelector swizzingSel:swizzingAppearSelector];
    });
}


-(void)user_setDelegate:(id<UICollectionViewDelegate>)delegate
{
    [self user_setDelegate:delegate];
    
    SEL sel = @selector(collectionView:didSelectItemAtIndexPath:);
    
    SEL sel_ =  NSSelectorFromString(@"userDefined_collectionView_didselected");
    
    class_addMethod([delegate class],
                    sel_,
                    method_getImplementation(class_getInstanceMethod([self class], @selector(user_collectionView:didSelectItemAtIndexPath:))),
                    nil);
    
    
    //判断是否有实现，没有的话添加一个实现
    if (![self isContainSel:sel inClass:[delegate class]]) {
        IMP imp = method_getImplementation(class_getInstanceMethod([delegate class], sel));
        class_addMethod([delegate class], sel, imp, nil);
    }
    
    
    // 将swizzle delegate method 和 origin delegate method 交换
    [MethodSwizzingTool swizzingForClass:[delegate class] originalSel:sel swizzingSel:sel_];
}


//判断页面是否实现了某个sel
- (BOOL)isContainSel:(SEL)sel inClass:(Class)class {
    unsigned int count;
    
    Method *methodList = class_copyMethodList(class,&count);
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSString *tempMethodString = [NSString stringWithUTF8String:sel_getName(method_getName(method))];
        if ([tempMethodString isEqualToString:NSStringFromSelector(sel)]) {
            return YES;
        }
    }
    return NO;
}



- (void)user_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
//    SEL sel = NSSelectorFromString(@"userDefined_collectionView_didselected");
//    if ([self respondsToSelector:sel]) {
//        IMP imp = [self methodForSelector:sel];
//        void (*func)(id, SEL,id,id) = (void *)imp;
//        func(self, sel,collectionView,indexPath);
//    }
    
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@/%@/%ld", NSStringFromClass([self class]),  NSStringFromClass([collectionView class]), collectionView.tag]);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL,id,id) = (void *)imp;
        func(self, sel,collectionView,indexPath);
    }
    
    
    NSString * identifier = [NSString stringWithFormat:@"%@/%@/%ld", [self class],[collectionView class], collectionView.tag];
    NSDictionary * dic = [[[DataContainer dataInstance].data objectForKey:@"COLLECTIONVIEW"] objectForKey:identifier];
    if (dic) {
        
        NSString * eventid = dic[@"userDefined"][@"eventid"];
        NSString * targetname = dic[@"userDefined"][@"target"];
        NSString * pageid = dic[@"userDefined"][@"pageid"];
        NSString * pagename = dic[@"userDefined"][@"pagename"];
        NSDictionary * pagePara = dic[@"pagePara"];
        
        
        
        UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        __block NSMutableDictionary * uploadDic = [NSMutableDictionary dictionaryWithCapacity:0];
        [pagePara enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSInteger containIn = [obj[@"containIn"] integerValue];
            id instance = containIn == 0 ? self : cell;
            id value = [CaptureTool captureVarforInstance:instance withPara:obj];
            if (value && key) {
                [uploadDic setObject:value forKey:key];
            }
        }];
        
        NSLog(@"\n event id === %@,\n  target === %@, \n  pageid === %@,\n  pagename === %@,\n pagepara === %@ \n", eventid, targetname, pageid, pagename, uploadDic);
    }
    
}

@end
