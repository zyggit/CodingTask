//
//  OrderService.h
//  CodingTask
//
//  Created by zyg on 2022/11/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderService : NSObject

- (NSString *)payBillWithGroup:(NSInteger)group paid:(NSNumber *)paid;

@end

NS_ASSUME_NONNULL_END
