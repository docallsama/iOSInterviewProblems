//
//  TestKVCViewController.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/10/18.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "TestKVViewController.h"
#import "AuthorInfo.h"
#import "NSObject+OVKVO.h"

static void * PopularBookContext = &PopularBookContext;
static void * LatestBookContext = &LatestBookContext;

@interface TestKVViewController () {
    Book *popularBook;
    Book *latestBook;
    Book *commentBook;
}

@end

@implementation TestKVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self testKVC];
    [self testKVO];
    [self testCustomKVO];
}

/*书籍样例数据格式
 
    Name                Price       Publish Time
 
    Devil and Angel     29.50       2013-12-01
    
    Digital Castle      23.70       2000-05-05
 
    Lost Symbols        60.80       2010-07-22
 
*/

//使用KVC
- (void)testKVC {
    AuthorInfo *DanBrownInfo = [[AuthorInfo alloc] init];
    DanBrownInfo.bestSeller = [Book new];
    [DanBrownInfo setValue:@"DanBrown"forKey:@"authName"];
    [DanBrownInfo setValue:@"Thriller writer"forKey:@"summary"];
    //使用keypath插入值
    [DanBrownInfo setValue:@"Lost Symbols" forKeyPath:@"bestSeller.name"];
    [DanBrownInfo setValue:nil forKeyPath:@"bestSeller.pageCount"];
    
    NSMutableArray *books = [NSMutableArray new];
    Book *devilAndAngel = [[Book alloc] init];
    [devilAndAngel setValue:@"Devil and Angel" forKey:@"name"];
    [devilAndAngel setValue:@(29.50) forKey:@"price"];
    [devilAndAngel setValue:[self convertStringToDate:@"2013-12-01"] forKey:@"publishTime"];
    [books addObject:devilAndAngel];
    
    Book *digitalCastle = [[Book alloc] init];
    [digitalCastle setValue:@"Digital Castle" forKey:@"name"];
    [digitalCastle setValue:@(23.70) forKey:@"price"];
    [digitalCastle setValue:[self convertStringToDate:@"2000-05-05"] forKey:@"publishTime"];
    [books addObject:digitalCastle];
    
    Book *lostSymbols = [[Book alloc] init];
    [lostSymbols setValue:@"Lost Symbols" forKey:@"name"];
    [lostSymbols setValue:@(60.70) forKey:@"price"];
    [lostSymbols setValue:[self convertStringToDate:@"2010-07-22"] forKey:@"publishTime"];
    [books addObject:lostSymbols];
    
    DanBrownInfo.books = books;
    
    //使用collection operators获取数组中对象平均值等操作
    NSLog(@"dan brown's book count -> %@",[DanBrownInfo.books valueForKeyPath:@"@count"]);
    NSLog(@"dan brown's book all price -> %@",[DanBrownInfo.books valueForKeyPath:@"@sum.price"]);
    NSLog(@"dan brown's book average price -> %@",[DanBrownInfo.books valueForKeyPath:@"@avg.price"]);
    NSLog(@"dan brown's book latest publish -> %@",[DanBrownInfo.books valueForKeyPath:@"@min.publishTime"]);
    
    //对数组中对象属性进行排重获取集合
    NSArray *recentStocks = @[devilAndAngel, digitalCastle, digitalCastle, digitalCastle, lostSymbols, lostSymbols];
    NSLog(@"dan brown's book recent stocks name -> %@",[recentStocks valueForKeyPath:@"@unionOfObjects.name"]);
    NSLog(@"dan brown's book recent stocks name -> %@",[recentStocks valueForKeyPath:@"@distinctUnionOfObjects.name"]);
}

- (NSDate *)convertStringToDate:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

//使用KVO
- (void)testKVO {
    popularBook = [[Book alloc] init];
    [popularBook setValue:@"Devil and Angel" forKey:@"name"];
    [popularBook setValue:@(29.50) forKey:@"price"];
    [popularBook setValue:[self convertStringToDate:@"2013-12-01"] forKey:@"publishTime"];
    
    [popularBook addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:PopularBookContext];
    
    [popularBook setValue:@"Lost Symbols" forKey:@"name"];
    
    latestBook = [[Book alloc] initWithBookName:@"Inferno" andPrice:30.8 andPulishTime:[self convertStringToDate:@"2013-12-01"]];
    [latestBook addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:LatestBookContext];
    [latestBook setValue:@"waitting for review" forKey:@"name"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"observeValueForKeyPath");
    if (context == PopularBookContext) {
        if ([keyPath isEqualToString:@"name"]) {
            NSLog(@"popular book change => %@",change);
        }
    } else if (context == LatestBookContext) {
        if ([keyPath isEqualToString:@"name"]) {
            NSLog(@"latest book change -> %@",change);
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [popularBook removeObserver:self forKeyPath:@"name"];
    [latestBook removeObserver:self forKeyPath:@"name"];
}

//使用自己创建的KVO
- (void)testCustomKVO {
    commentBook = [[Book alloc] init];
    [commentBook ov_addObserver:self forKeyPath:@"comment"];
    [commentBook setValue:@"very good" forKey:@"comment"];
}

- (void)ov_observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object {
    NSLog(@"did get change of -> %@",keyPath);
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
