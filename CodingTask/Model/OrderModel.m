//
//  OrderModel.m
//  CodingTask
//
//  Created by zyg on 2022/11/26.
//

#import "OrderModel.h"
#import "CodeTaskUtil.h"

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
        NSString *price = [CodeTaskUtil formateNumber:[NSNumber numberWithDouble:model.itemPrice.doubleValue] formateType:NumberTypePrice];
        [orderGoods appendFormat:@"     - No.%@ %@     %@\n",model.itemCount,price,model.itemName];
        totalGoodsCount += model.itemCount.integerValue;
        totalPrice += model.itemPrice.doubleValue;
    }
    
    
    
    
    return [NSString stringWithFormat:@"\n---------Bill---------- \n #OrderGroup   No.%ld\n #OrderPerson  %ld \n #OrderGoods   NO.%ld\n%@\n\n#OrderPrice  %@\n",
            (long)self.orderGroup,
            (long)self.orderPersons.count,
            totalGoodsCount,
            orderGoods,
            [CodeTaskUtil formateNumber:[NSNumber numberWithDouble:self.paymentModel.shouldPayAmount.doubleValue] formateType:NumberTypePrice]
            ];
}


@end
