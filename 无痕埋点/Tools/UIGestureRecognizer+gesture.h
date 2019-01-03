//
//  UIGestureRecognizer+gesture.h
//  无痕埋点
//
//  Created by isoft on 2019/1/3.
//  Copyright © 2019 isoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIGestureRecognizer (gesture)

@property(nonatomic,copy)NSString * methodName;

@end

NS_ASSUME_NONNULL_END
