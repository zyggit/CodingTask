//
//  OrderItemsModel.h
//  CodingTask
//
//  Created by zyg on 2022/11/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderItemsModel : NSObject

@property (nonatomic,   copy) NSString *itemName;
@property (nonatomic, strong) NSNumber *itemCount;
@property (nonatomic, strong) NSNumber *itemPrice;
@property (nonatomic, assign) NSInteger orderId;

@end

NS_ASSUME_NONNULL_END
