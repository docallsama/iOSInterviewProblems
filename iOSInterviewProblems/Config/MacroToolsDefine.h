//
//  MacroToolsDefine.h
//  China-net-app
//
//  Created by 谢艺欣 on 2017/11/6.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#ifndef MacroToolsDefine_h
#define MacroToolsDefine_h

#define weakify(o) __typeof__(o) __weak o##__weak_ = o;
#define strongify(o) __typeof__(o##__weak_) __strong o = o##__weak_;

#endif /* MacroToolsDefine_h */
