#import <Foundation/Foundation.h>
#import "Book.h"

@interface AuthorInfo : NSObject

@property (nonatomic, copy) NSString *authId;
@property (nonatomic, copy) NSString *shareContent;
@property (nonatomic, copy) NSString *shareImgUrl;
@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *authImage;
@property (nonatomic, copy) NSString *authDescribe;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *authName;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, strong) NSArray *books;
@property (nonatomic, strong) Book *bestSeller;
@property (nonatomic, assign) NSInteger contentType;
@property (nonatomic, assign) BOOL isFollowing;

@end

