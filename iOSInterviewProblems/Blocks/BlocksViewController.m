//
//  BlocksViewController.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/11/6.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "BlocksViewController.h"
#import "MacroToolsDefine.h"

typedef BOOL (^AuthorNameCheck)(NSString *name);

@interface BlocksViewController ()

@property (nonatomic, copy) BOOL (^authorNameCheck)(NSString *name);

@property (nonatomic, copy) AuthorNameCheck semiCheck;

@property (nonatomic, copy) void (^descriptionCheck)();

@end

@implementation BlocksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initWithLocalVariable];
    [self initWithProperty];
    [self checkBookNameBlock:^BOOL(NSString *name) {
        if ([name isEqualToString:@"Lost Symbols"]) {
            return true;
        } else {
            return false;
        }
    }];
    [self checkAuthorNameBlock];
    
    [self cancelBlock];
    [self testChangeValueOnBlock];
    [self blockTest];
}

//
- (void)initWithLocalVariable {
    BOOL (^checkBookName)(NSString *name) = ^BOOL(NSString *name) {
        if ([name isEqualToString:@"Digital Castle"]) {
            return true;
        } else {
            return false;
        }
    };
    
    BOOL result = checkBookName(@"Lost Symbols");
    NSLog(@"check name result -> %d",result);
}

//
- (void)initWithProperty {
      //如果未声明block直接调用会导致空指针 EXC_BAD_ACCESS
//    BOOL fastResult = self.authorNameCheck(@"Dan Brown");
//    NSLog(@"check author result -> %d",fastResult);
    
    self.authorNameCheck = ^BOOL(NSString *name) {
        if ([name isEqualToString:@"Dan Brown"]) {
            return true;
        } else {
            return false;
        }
    };
    
    BOOL result = self.authorNameCheck(@"Dan Brown");
    NSLog(@"check author result -> %d",result);
}

//方法block
- (void)checkBookNameBlock:(BOOL (^)(NSString *name))checkBookName {
    
    BOOL result = checkBookName(@"test");
    NSLog(@"check book result -> %d",result);
}

//typdef方式
- (void)checkAuthorNameBlock {
    AuthorNameCheck check = ^BOOL(NSString *name) {
        if ([name isEqualToString:@"Dan Brown"]) {
            return true;
        } else {
            return false;
        }
    };
    BOOL result = check(@"jason");
    NSLog(@"check name result -> %d",result);
}

//解决 retain cycle
- (void)avoidRetainCycle {
    
    __weak __typeof(self)weakSelf = self;
    
//    weakify(self);
    
    @weakify(self);
    
    self.descriptionCheck = ^() {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf checkDescription];
        }
        
//         [self__weak_ checkDescription];
        
        @strongify(self);
        if (!self) return;
        [self checkDescription];
    };
}

- (void)checkDescription {
    NSLog(@"test description");
}

//取消一个block
- (void)cancelBlock {
    
    BOOL status = false;
    
    @weakify(self);
    self.descriptionCheck = ^() {
        if (status) {
            
            @strongify(self);
            if (!self) return;
            [self checkDescription];
        }
    };
}

- (void)testChangeValueOnBlock
{
    int i = 10;
    static int m = 100;
    NSMutableArray *mArray = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
    void (^blk)(void) = ^{
    NSLog(@"In block, i = %d", i);
    NSLog(@"In block, m = %d", m);
        for (NSString *str in mArray) {
            NSLog(@"In block, str = %@", str);
        }
    };
    i = 20;
    m = 200;
    [mArray addObject:@"3"];
    blk();
    
    
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
        
    void(^block)(void) = ^{
        
        NSLog(@"arr -> %@",arr);//局部变量
    };
    
    [arr addObject:@"3"];
    
    arr = nil;
    
    block();
    
    
}

static NSInteger num3 = 300;

NSInteger num4 = 3000;

- (void)blockTest
{
    NSInteger num = 30;
    
    static NSInteger num2 = 3;
    
    __block NSInteger num5 = 30000;
    
    void(^block)(void) = ^{
        
        NSLog(@"%zd",num);//局部变量 不可变，值截获
        
        NSLog(@"%zd",num2);//静态变量 可改变，指针截获
        
        NSLog(@"%zd",num3);//全局变量 可改变，不截获直接取值
        
        NSLog(@"%zd",num4);//全局静态变量 可改变，不截获直接取值
        
        NSLog(@"%zd",num5);//__block修饰变量
    };
    
    num5 = 5;
    
    block();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"released %@",[self class]);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
