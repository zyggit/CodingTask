//
//  OrderModel.m
//  CodingTask
//
//  Created by zyg on 2022/11/26.
//

#import "OrderModel.h"

@implementation OrderModel

- (instancetype)initWithCoder:(NSCoder *)coder {
    self=[super init];
    if(self) {
        self.orderGroup = [coder decodeIntegerForKey:@"orderGroup"];
    }
    
    return  self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeInteger:self.orderGroup forKey:@"orderGroup"];
}

- (NSString *)description {
    NSMutableString *orderGoods = [[NSMutableString alloc] init];
    NSInteger totalGoodsCount = 0;
    
    double totalPrice = 0;
    for (OrderItemsModel *model in self.orderItems) {
        [orderGoods appendFormat:@"     - %@ x %@ * %@\n",model.itemCount,model.itemPrice,model.itemName];
        totalGoodsCount += model.itemCount.integerValue;
        totalPrice += model.itemPrice.doubleValue;
    }
    
    
    
    
    return [NSString stringWithFormat:@"\n---------Bill---------- \n #OrderGroup   No.%ld\n #OrderPerson  %ld \n #OrderGoods   %ld\n%@\n\n#OrderPrice   $%@\n",
            (long)self.orderGroup,
            (long)self.orderPersons.count,
            totalGoodsCount,
            orderGoods,
            self.paymentModel.shouldPayAmount
            ];
}


@end
