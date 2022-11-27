//
//  OrderModel.h
//  CodingTask
//
//  Created by zyg on 2022/11/26.
//

#import <Foundation/Foundation.h>
#import "OrderPersonModel.h"
#import "OrderItemsModel.h"
#import "PaymentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger orderGroup;
@property (nonatomic, strong) NSArray <OrderPersonModel *> *orderPersons;
@property (nonatomic, strong) NSArray<OrderItemsModel *> *orderItems;
@property (nonatomic, strong) PaymentModel *paymentModel;

@end

NS_ASSUME_NONNULL_END
