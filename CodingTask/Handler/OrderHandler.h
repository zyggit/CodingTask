//
//  OrderHandler.h
//  CodingTask
//
//  Created by zyg on 2022/11/26.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"
#import "BillContentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderHandler : NSObject

+ (NSArray<OrderPersonModel *> *)handleGroupPersons:(NSInteger)personCount orderGroup:(NSInteger)group;

// group 1
+ (NSArray<OrderItemsModel *> *)handleItemsWithOriginString:(NSString *)itemsString
                                                itemsNumber:(NSString *)numberString
                                                    orderId:(NSInteger)orderId;
// group 2
+ (NSArray<OrderItemsModel *> *)handleItemsWithOriginString:(NSString *)itemsString
                                                    orderId:(NSInteger)orderId;

// group 3
+ (NSArray<OrderItemsModel *> *)handleItemsWithOriginString:(NSString *)itemsString
                                                 itemsNames:(NSArray *)itemsNames
                                                    orderId:(NSInteger)orderId;

+ (PaymentModel *)handlePaymentWithOrder:(NSArray<OrderItemsModel *> *)orderItems
                              paidAmount:(NSNumber *)paid
                                 payType:(billPayType)payType
                             paymentType:(paymentType)payment
                            discountType:(discountType)discountType
                            discountData:(NSNumber *)discount
                          separateAmount:(NSNumber *)separate;

+ (OrderModel *)buildOrderWithPerson:(NSArray<OrderPersonModel *> *)persons
                          orderGroup:(NSInteger)group
                          orderItems:(NSArray<OrderItemsModel *> *)items
                        paymentModel:(PaymentModel *)payment;

+ (BillContentModel *)buildBillContentWithOrder:(OrderModel *)order
                                        groupId:(NSString *)groupId
                                     orderGroup:(NSInteger)orderGroup;

+ (void)calculateBill:(OrderModel *)order;


@end

NS_ASSUME_NONNULL_END
