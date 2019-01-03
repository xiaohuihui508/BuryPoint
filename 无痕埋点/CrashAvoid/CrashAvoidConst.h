//
//  CrashAvoidConst.h
//  无痕埋点
//
//  Created by isoft on 2019/1/3.
//  Copyright © 2019 isoft. All rights reserved.
//


#ifndef CrashAvoidConst_h
#define CrashAvoidConst_h

#import "CrashAvoidManager.h"
#import <objc/runtime.h>


static NSString * const AvoidCrashDefaultReturnNil     = @"AvoidCrash default is to return nil to avoid crash.";
static NSString * const AvoidCrashDefaultIgnore        = @"AvoidCrash default is to ignore this operation to avoid crash.";
static NSString * const AvoidCrashSeparator            = @"================================================================";
static NSString * const AvoidCrashSeparatorWithFlag    = @"========================CrashAvoid Log==========================";

static NSString * const key_errorName        = @"errorName";
static NSString * const key_errorReason      = @"errorReason";
static NSString * const key_errorPlace       = @"errorPlace";
static NSString * const key_defaultToDo      = @"defaultToDo";
static NSString * const key_callStackSymbols = @"callStackSymbols";
static NSString * const key_exception        = @"exception";

#endif /* CrashAvoidConst_h */
