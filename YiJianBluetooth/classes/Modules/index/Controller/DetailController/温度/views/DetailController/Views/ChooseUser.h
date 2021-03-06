//
//  ChooseUser.h
//  YiJianBluetooth
//
//  Created by tyl on 16/8/16.
//  Copyright © 2016年 LEI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@class ChooseUser;

@protocol chooseUserDelegate <NSObject>

-(void)callBackUser:(User *)user;
-(void)callBaceAddUser;

@end

@interface ChooseUser : UIView<UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout>{
    NSMutableArray *_array;
}

@property (nonatomic, assign) id<chooseUserDelegate> user_delegate;


- (instancetype)initWithFrame:(CGRect)frame;

- (void)setWithUserInfo:(NSArray *)users;

@end
