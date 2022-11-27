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

/// Data model of dining staff
/// @param personCount person count
/// @param group Order of entering the restaurant
+ (NSArray<OrderPersonModel *> *)handleGroupPersons:(NSInteger)personCount
                                         orderGroup:(NSInteger)group;

//

/// handler group1
/// @param itemsString group1 datastring,including goods name/goods price
/// @param numberString  order goods count
/// @param orderId  Attributed Groups
+ (NSArray<OrderItemsModel *> *)handleItemsWithOriginString:(NSString *)itemsString
                                                itemsNumber:(NSString *)numberString
                                                    orderId:(NSInteger)orderId;
// group 2
/// @param itemsString group2 datastring,including goods name/goods price/goods count
/// @param orderId Attributed Groups
+ (NSArray<OrderItemsModel *> *)handleItemsWithOriginString:(NSString *)itemsString
                                                    orderId:(NSInteger)orderId;

// group 3 There is no correspondence between the amount of the product and the name of the goods
/// @param itemsString group3 datastring,including goods name/goods price/goods count
/// @param itemsNames restaurant all goods name
/// @param orderId Attributed Groups
+ (NSArray<OrderItemsModel *> *)handleItemsWithOriginString:(NSString *)itemsString
                                                 itemsNames:(NSArray *)itemsNames
                                                    orderId:(NSInteger)orderId;

/// PaymentModel
/// @param orderItems Information on ordered goods
/// @param paid Amount paid by the guest
/// @param payType Guest's choice of pay method: separate payment, or one person pays all
/// @param payment Guest's choice of payment method: cash or use credit card
/// @param discountType Discount amount or percentage of discount
/// @param discount data
/// @param separate The amount of payment to be made separately
+ (PaymentModel *)handlePaymentWithOrder:(NSArray<OrderItemsModel *> *)orderItems
                              paidAmount:(NSNumber *)paid
                                 payType:(billPayType)payType
                             paymentType:(paymentType)payment
                            discountType:(discountType)discountType
                            discountData:(NSNumber *)discount
                          separateAmount:(NSNumber *)separate;

/// OrderModel
/// @param persons All diners in the current group
/// @param group dining Group
/// @param items Information about the goods ordered by the guest
/// @param payment Guest choise payment Details
+ (OrderModel *)buildOrderWithPerson:(NSArray<OrderPersonModel *> *)persons
                          orderGroup:(NSInteger)group
                          orderItems:(NSArray<OrderItemsModel *> *)items
                        paymentModel:(PaymentModel *)payment;

/// BillModel
/// @param order  Guest order all goods Details
/// @param groupId  group identification
/// @param orderGroup Attributed Groups
+ (BillContentModel *)buildBillContentWithOrder:(OrderModel *)order
                                        groupId:(NSString *)groupId
                                     orderGroup:(NSInteger)orderGroup;
@end

NS_ASSUME_NONNULL_END
