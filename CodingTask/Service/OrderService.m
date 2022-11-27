//
//  OrderService.m
//  CodingTask
//
//  Created by zyg on 2022/11/26.
//

#import "OrderService.h"
#import "OrderHandler.h"
#import "CodeTaskUtil.h"

@interface OrderService()

@property (nonatomic, copy) NSArray<NSNumber *> *groupPersonCount;
@property (nonatomic, copy) NSString *group1ItemsString;
@property (nonatomic, copy) NSString *group1ItemsCountString;

@property (nonatomic, copy) NSString *group2Items;
@property (nonatomic, copy) NSString *group3Items;

@property (nonatomic, copy) NSArray<NSString *> *itemsNames;

@end

@implementation OrderService

- (NSString *)payBillWithGroup:(NSInteger)group paid:(NSNumber *)paid {
    [self configData];
    
    NSString *bill = nil;
    if (group == 1) {
        bill = [self payGroup1:paid];
    }else if(group == 2) {
        bill = [self payGroup2:paid];
    }else if(group == 3) {
        bill = [self payGroup3:paid];
    }
    
    return bill;
}

- (void)configData {
    self.groupPersonCount = @[@(3),@(5),@(7)];
    self.itemsNames = @[@"Big Brekkie",@"Bruschetta",@"Coffee",@"Garden Salad",@"Poached Eggs",@"Soda",@"Tea"];
    
    self.group1ItemsString = @"Big Brekkie $16 Big Brekkie $16 Bruschetta $8 Poached Eggs $12 Coffee $5 Tea $3 Soda $4";
    self.group1ItemsCountString = @"#1 #2 #3 #3 #2 #1 #3";
    
    self.group2Items = @"Tea $3x1 Coffee $3x3 Soda $4x1 Big Brekkie $16x3 Poached Eggs $12x1 Garden Salad $10x1";
    
    self.group3Items = @"Tea $3x2 Coffee $3x3 Soda $4x2 Bruschetta Big Brekkie Poached Eggs Garden Salad $8x5 $16x5 $12x2 $10x3";
    
}

- (NSString *)payGroup1:(NSNumber *)paid {
    // group 1
    NSInteger group = 1;
    // person
    NSInteger personCount = [[_groupPersonCount objectAtIndex:group-1] integerValue];
    NSArray<OrderPersonModel *> *groupPerson1 = [OrderHandler handleGroupPersons:personCount
                                                                      orderGroup:group];
    
    // order goods
    NSArray<OrderItemsModel *> *groupItems1 = [OrderHandler handleItemsWithOriginString:_group1ItemsString
                                                                            itemsNumber:_group1ItemsCountString
                                                                                orderId:group];
    // paytype
    PaymentModel *groupPayment1 = [OrderHandler handlePaymentWithOrder:groupItems1
                                                            paidAmount:paid
                                                               payType:billPayTypeSplit
                                                           paymentType:paymentTypeCash
                                                          discountType:discountTypeNone
                                                          discountData:@(0)
                                                        separateAmount:@(0)];
    
    // ordermodel
    OrderModel *orderModel1 = [OrderHandler buildOrderWithPerson:groupPerson1
                                                      orderGroup:group
                                                      orderItems:groupItems1
                                                    paymentModel:groupPayment1];
    
    // group bill
    NSString *groupString = [NSString stringWithFormat:@"Group %ld identification",(long)group];
    BillContentModel *billModel1 = [OrderHandler buildBillContentWithOrder:orderModel1
                                                                   groupId:groupString
                                                                orderGroup:group];
    
    NSString *billString = [NSString stringWithFormat:@"%@\n%@",[orderModel1 description],[billModel1 description]];
    NSLog(@"%@",billString);
    return billString;
}

- (NSString *)payGroup2:(NSNumber *)paid {
    // group 2
    NSInteger group = 2;
    // person
    NSInteger personCount = [[_groupPersonCount objectAtIndex:group-1] integerValue];
    NSArray<OrderPersonModel *> *groupPerson = [OrderHandler handleGroupPersons:personCount
                                                                      orderGroup:group];
    
    // order goods
    NSArray<OrderItemsModel *> *groupItems = [OrderHandler handleItemsWithOriginString:_group2Items
                                                                                orderId:group];
    
    // paytype
    PaymentModel *groupPayment = [OrderHandler handlePaymentWithOrder:groupItems
                                                            paidAmount:paid
                                                               payType:billPayTypeTotal
                                                           paymentType:paymentTypeCreditCard
                                                          discountType:discountTypePercent
                                                          discountData:@(0.1)
                                                        separateAmount:@(0)];
    
    // ordermodel
    OrderModel *orderModel = [OrderHandler buildOrderWithPerson:groupPerson
                                                     orderGroup:group
                                                      orderItems:groupItems
                                                    paymentModel:groupPayment];
    
    // group bill
    NSString *groupString = [NSString stringWithFormat:@"Group %ld identification",(long)group];
    BillContentModel *billModel = [OrderHandler buildBillContentWithOrder:orderModel
                                                                   groupId:groupString
                                                                orderGroup:group];
    
    NSString *billString = [NSString stringWithFormat:@"%@\n%@",[orderModel description],[billModel description]];
    NSLog(@"%@",billString);
    return billString;
}

- (NSString *)payGroup3:(NSNumber *)paid {
    NSInteger group = 3;
    // person
    NSInteger personCount = [[_groupPersonCount objectAtIndex:group-2] integerValue];
    NSArray<OrderPersonModel *> *groupPerson = [OrderHandler handleGroupPersons:personCount
                                                                      orderGroup:group];
    
    // order goods
    NSArray<OrderItemsModel *> *groupItems = [OrderHandler handleItemsWithOriginString:_group3Items
                                                                            itemsNames:_itemsNames
                                                                               orderId:group];
    
    // paytype
    PaymentModel *groupPayment = [OrderHandler handlePaymentWithOrder:groupItems
                                                            paidAmount:paid
                                                               payType:billPayTypeSplit
                                                           paymentType:paymentTypeCash
                                                          discountType:discountTypePrice
                                                          discountData:@(25)
                                                        separateAmount:@(50)];
    
    // ordermodel
    OrderModel *orderModel = [OrderHandler buildOrderWithPerson:groupPerson
                                                     orderGroup:group
                                                      orderItems:groupItems
                                                    paymentModel:groupPayment];
    
    // group bill
    NSString *groupString = [NSString stringWithFormat:@"Group %ld identification",(long)group];
    BillContentModel *billModel = [OrderHandler buildBillContentWithOrder:orderModel
                                                                   groupId:groupString
                                                                orderGroup:group];
    
    NSString *billString = [NSString stringWithFormat:@"%@\n%@",[orderModel description],[billModel description]];
    NSLog(@"%@",billString);
    return billString;
}

#pragma mark - private
- (void)buildOrder {
    
    
}


@end
