//
//  TestLocksViewController.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2022/3/22.
//  Copyright © 2022 谢艺欣. All rights reserved.
//

#import "TestLocksViewController.h"
#include <pthread.h>

pthread_rwlock_t lock;

@interface TestLocksViewController ()

@end

@implementation TestLocksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    pthread_rwlock_init(&lock, nil);
    
    for (int i = 0; i < 10; i++) {
        [self testRead];
        [self testRead];
        [self testWrite];
    }
}

- (void)testRead
{
    pthread_rwlock_rdlock(&lock);
    sleep(1);
    NSLog(@"read");
    pthread_rwlock_unlock(&lock);
}

- (void)testWrite
{
    pthread_rwlock_wrlock(&lock);
    sleep(1);
    NSLog(@"write");
    pthread_rwlock_unlock(&lock);
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
