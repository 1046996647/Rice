//
//  LeftViewController.h
//  CSLeftSlideDemo
//
//  Created by LCS on 16/2/11.
//  Copyright © 2016年 LCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "BaseViewController.h"
#import "PersonModel.h"

@protocol LeftViewControllerDelegate <NSObject>

- (void)LeftViewControllerdidSelectRow:(NSInteger)row;

@end

@interface LeftViewController : BaseViewController

@property (nonatomic, weak) id <LeftViewControllerDelegate> delegate;
@property (nonatomic, strong) PersonModel *personModel;

@end
