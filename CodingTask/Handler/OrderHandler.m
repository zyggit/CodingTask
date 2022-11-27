//
//  OrderHandler.m
//  CodingTask
//
//  Created by zyg on 2022/11/26.
//

#import "OrderHandler.h"
#import "CodeTaskUtil.h"
#import "ItemLocationModel.h"

@implementation OrderHandler

+ (NSArray<OrderPersonModel *> *)handleGroupPersons:(NSInteger)personCount orderGroup:(NSInteger)group {
    NSMutableArray<OrderPersonModel *> *arr = [NSMutableArray new];
    
    for (int i=0; i<personCount; i++) {
        OrderPersonModel *model = [OrderPersonModel new];
        model.orderGroup = group;
        [arr addObject: model];
    }
    
    return arr;
}


+ (NSArray<OrderItemsModel *> *)handleItemsWithOriginString:(NSString *)itemsString
                                                itemsNumber:(NSString *)numberString
                                                    orderId:(NSInteger)orderId
{
    // 处理入参，删除开始结束空格
    NSString *priceString = PRICENUMBER;
    NSString *appendString = [NSString stringWithFormat:@"%@%@",priceString,PRICEFLAG];
    NSString *filterPriceString = [CodeTaskUtil filterCharacterFromOriginStr:itemsString scanString:appendString];
    NSString *filterNumberString = [CodeTaskUtil filterCharacterFromOriginStr:numberString scanString:priceString];
    NSString *legalPriceString = [filterPriceString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *legalNumberString = [filterNumberString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // 先获取单个商品的开始和结束位置
    // 默认第一个从0开始
    NSArray *priceArr = [legalPriceString componentsSeparatedByString:SEPARATEDFLAG];
    NSArray *numberArr = [legalNumberString componentsSeparatedByString:SEPARATEDFLAG];
    
    // 安全处理：判断商品的价格和个数是否匹配
    if (priceArr.count != numberArr.count) {
        NSAssert(false, @"inlegal data, reason:The price of the product is not equal to the number of the product");
        return nil;
    }
    
    NSMutableArray<OrderItemsModel *> *orderItems = [NSMutableArray new];
    
    for (int i = 0; i<priceArr.count; i++) {
        NSRange startRange = NSMakeRange(0, 0);
        NSRange endRange =  NSMakeRange(0, 0);

        itemsString = [itemsString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        // 获取商品结束位置
        if (i+1 <= priceArr.count) {
            NSString *nextItemPrice = [priceArr objectAtIndex:i];
            endRange = [itemsString rangeOfString:nextItemPrice];
        }
        
        NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
        NSString *name = [itemsString substringWithRange:range];
        
        NSInteger itemsCount = [[numberArr objectAtIndex:i] integerValue];
        NSString *priceString = [CodeTaskUtil originalString:[priceArr objectAtIndex:i] filterString:PRICEFLAG];
        double itemsPrice = [priceString doubleValue];
        
        // 为了避免数组重复引发取值问题，获取到首位的商品后，把商品从字符串里删除
        itemsString = [itemsString substringFromIndex:(endRange.location + endRange.length)];
        
        OrderItemsModel *itemsModel = [OrderItemsModel new];
        itemsModel.orderId = orderId;
        itemsModel.itemName = name;
        itemsModel.itemCount = [NSNumber numberWithInteger:itemsCount];
        itemsModel.itemPrice = [NSNumber numberWithDouble:itemsPrice];
        
        [orderItems addObject:itemsModel];
    }
    
    // 获取商品的个数
    
    return orderItems;
}


+ (NSArray<OrderItemsModel *> *)handleItemsWithOriginString:(NSString *)itemsString
                                                    orderId:(NSInteger)orderId
{
    // 处理入参，删除开始结束空格
    NSString *appendString = [NSString stringWithFormat:@"%@%@",PRICEFLAG,APPENDFLAG];
    NSString *scanString = [NSString stringWithFormat:@"%@%@",PRICENUMBER,appendString];
    NSString *filterPriceString = [CodeTaskUtil filterCharacterFromOriginStr:itemsString scanString:scanString];
    NSString *legalPriceString = [filterPriceString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // 先获取单个商品的开始和结束位置
    // 默认第一个从0开始
    NSArray *priceAndCountArr = [legalPriceString componentsSeparatedByString:SEPARATEDFLAG];
    
    NSMutableArray *numberArr = [NSMutableArray new];
    for (NSString *priceAndCount in priceAndCountArr) {
        NSArray *arr = [priceAndCount componentsSeparatedByString:APPENDFLAG];
        if (arr.count == 2) {
            [numberArr addObject:arr.lastObject];
        }else{
            NSAssert(false, @"error dataformat");
        }
    }
    
    
    NSMutableArray<OrderItemsModel *> *orderItems = [NSMutableArray new];
    
    for (int i = 0; i<priceAndCountArr.count; i++) {
        NSRange startRange = NSMakeRange(0, 0);
        NSRange endRange =  NSMakeRange(0, 0);

        itemsString = [itemsString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        // 获取商品结束位置
        if (i+1 <= priceAndCountArr.count) {
            NSString *nextItemPrice = [priceAndCountArr objectAtIndex:i];
            endRange = [itemsString rangeOfString:nextItemPrice];
        }
        
        NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
        NSString *name = [itemsString substringWithRange:range];
        
        NSInteger itemsCount = [[numberArr objectAtIndex:i] integerValue];
        NSString *priceString = [CodeTaskUtil originalString:[priceAndCountArr objectAtIndex:i] filterString:PRICEFLAG];
        double itemsPrice = [priceString doubleValue];
        
        // 为了避免数组重复引发取值问题，获取到首位的商品后，把商品从字符串里删除
        itemsString = [itemsString substringFromIndex:(endRange.location + endRange.length)];
        
        OrderItemsModel *itemsModel = [OrderItemsModel new];
        itemsModel.orderId = orderId;
        itemsModel.itemName = name;
        itemsModel.itemCount = [NSNumber numberWithInteger:itemsCount];
        itemsModel.itemPrice = [NSNumber numberWithDouble:itemsPrice];
        
        [orderItems addObject:itemsModel];
    }
    
    return orderItems;
}

+ (NSArray<OrderItemsModel *> *)handleItemsWithOriginString:(NSString *)itemsString
                                                 itemsNames:(NSArray *)itemsNames
                                                    orderId:(NSInteger)orderId
{
    NSMutableArray<ItemLocationModel *> *matchArr = [NSMutableArray new];
    for (NSString *name in itemsNames) {
        NSString *regex = name;
        NSError *error;
        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex
                                                                                 options:NSRegularExpressionCaseInsensitive
                                                                                   error:&error];
        NSArray *matches = [regular matchesInString:itemsString
                                            options:0
                                              range:NSMakeRange(0, itemsString.length)];
        for (NSTextCheckingResult *match in matches) {
            NSRange range = [match range];
            NSString *mStr = [itemsString substringWithRange:range];
            ItemLocationModel *matchItem = [ItemLocationModel itemWithLocation:range.location
                                                                      itemName:mStr];
            
            [matchArr addObject:matchItem];
        }
    }
    
    NSArray<ItemLocationModel *> *sortedItems = [matchArr sortedArrayUsingSelector: @selector(compareLocation:)];
    
    NSString *appendString = [NSString stringWithFormat:@"%@",APPENDFLAG];
    NSString *scanString = [NSString stringWithFormat:@"%@%@",PRICENUMBER,appendString];
    NSString *filterPriceString = [CodeTaskUtil filterCharacterFromOriginStr:itemsString scanString:scanString];
    NSString *legalPriceString = [filterPriceString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSArray *priceAndCountArr = [legalPriceString componentsSeparatedByString:SEPARATEDFLAG];
    NSMutableArray *priceArr = [NSMutableArray new];
    NSMutableArray *countArr = [NSMutableArray new];
    
    for (NSString *priceAndCount in priceAndCountArr) {
        NSArray *arr = [priceAndCount componentsSeparatedByString:APPENDFLAG];
        if (arr.count == 2) {
            [priceArr addObject:arr.firstObject];
            [countArr addObject:arr.lastObject];
        }else{
            NSAssert(false, @"error dataformat");
        }
    }
    
    NSMutableArray<OrderItemsModel *> *orderItems = [NSMutableArray new];
    
    for (ItemLocationModel *model in sortedItems) {
        OrderItemsModel *itemsModel = [OrderItemsModel new];
        itemsModel.orderId = orderId;
        itemsModel.itemName = model.itemName;
        NSInteger index = [sortedItems indexOfObject:model];
        NSInteger count = [[countArr objectAtIndex:index] integerValue];
        double price = [[priceArr objectAtIndex:index] doubleValue];
        itemsModel.itemCount = [NSNumber numberWithInteger:count];
        itemsModel.itemPrice = [NSNumber numberWithDouble:price];
        
        [orderItems addObject:itemsModel];
    }
    
    
    return orderItems;
}

+ (OrderItemsModel *)handleOrderId:(NSInteger)index
                        orderItems:(NSString *)orderItemsString
                         itemCount:(NSString *)countString
{
    return nil;
}

+ (PaymentModel *)handlePaymentWithOrder:(NSArray<OrderItemsModel *> *)orderItems
                              paidAmount:(NSNumber *)paid
                                 payType:(billPayType)payType
                             paymentType:(paymentType)payment
                            discountType:(discountType)discountType
                            discountData:(NSNumber *)discount
                          separateAmount:(NSNumber *)separate
{
    PaymentModel *model = [PaymentModel new];
    model.paidAmount = paid;

    model.shouldPayAmount = [NSDecimalNumber decimalNumberWithString:@"0"];
    for (OrderItemsModel *item in orderItems) {
        NSDecimalNumber *itemPrice = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",item.itemPrice]];
        NSDecimalNumber *itemCount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",item.itemCount]];
        NSDecimalNumber *itemTotal = [itemPrice decimalNumberByMultiplyingBy:itemCount];
        
        model.shouldPayAmount = [itemTotal decimalNumberByAdding:model.shouldPayAmount];
    }
    
    model.billPayStyle = payType;
    model.paymentType = payment;
    model.discountType = discountType;
    model.discountData = discount;
    model.separatePayAmount = separate;
    
    return model;
}

+ (OrderModel *)buildOrderWithPerson:(NSArray<OrderPersonModel *> *)persons
                          orderGroup:(NSInteger)group
                          orderItems:(NSArray<OrderItemsModel *> *)items
                        paymentModel:(PaymentModel *)payment
{
    OrderModel *model = [OrderModel new];
    model.orderGroup = group;
    model.orderItems = items;
    model.orderPersons = persons;
    model.paymentModel = payment;
    
    return model;
}

+ (BillContentModel *)buildBillContentWithOrder:(OrderModel *)order
                                        groupId:(NSString *)groupId
                                     orderGroup:(NSInteger)orderGroup
{
    NSDecimalNumber *paid = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",order.paymentModel.paidAmount]];
    
    // total
    NSDecimalNumber *shouldPay = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",order.paymentModel.shouldPayAmount]];
    
    // taxes
    NSDecimalNumber *taxes = [NSDecimalNumber decimalNumberWithString:@"0.012"];
    
    // surcharge
    NSDecimalNumber *surcharge = [NSDecimalNumber decimalNumberWithString:@"0.0"];
    if (order.paymentModel.paymentType == paymentTypeCreditCard) {
        surcharge = [shouldPay decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"0.012"]];
    }
    
    // discount
    NSDecimalNumber *discounts = [NSDecimalNumber decimalNumberWithString:@"0"];
    if (order.paymentModel.discountType == discountTypePrice) {
        discounts = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",order.paymentModel.discountData]];
    }else if(order.paymentModel.discountType == discountTypePercent) {
        NSDecimalNumber *percent = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",order.paymentModel.discountData]];
        discounts = [shouldPay decimalNumberByMultiplyingBy:percent];

    }
    
    
    // 结账
    NSDecimalNumber *needPay = [[shouldPay decimalNumberBySubtracting:discounts] decimalNumberByAdding:surcharge];
    NSDecimalNumber *returned = [paid decimalNumberBySubtracting:needPay];
    NSDecimalNumber *remaining = [paid decimalNumberBySubtracting:needPay];
    
    
    BillContentModel *model = [BillContentModel new];
    model.shouldPayAmount = needPay;
    model.paidAmount = order.paymentModel.paidAmount;
    model.returnedAmount = returned;
    model.remainingAmount = remaining;
    model.taxes = taxes;
    model.surcharges = surcharge;
    model.discounts = discounts;
    model.groupId = groupId;
    model.orderId = orderGroup;
    
    return model;
}


@end
