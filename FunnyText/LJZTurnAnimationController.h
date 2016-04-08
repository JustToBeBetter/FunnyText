//
//  LJZTurnAnimationController.h
//  FunnyText
//
//  Created by 李金柱 on 16/3/31.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import "LJZReversibleAnimationController.h"

typedef NS_ENUM(NSInteger, LJZDirection) {
    LJZDirectionHorizontal,
    LJZDirectionVertical
};


@interface LJZTurnAnimationController : LJZReversibleAnimationController

@property (nonatomic, assign) LJZDirection flipDirection;

@end
