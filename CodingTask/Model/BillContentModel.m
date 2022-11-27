//
//  BillContentModel.m
//  CodingTask
//
//  Created by zyg on 2022/11/26.
//

#import "BillContentModel.h"

@implementation BillContentModel


- (instancetype)initWithCoder:(NSCoder *)coder {
    self=[super init];
    if(self) {
        self.orderId = [coder decodeIntegerForKey:@"orderId"];
    }
    
    return  self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeInteger:self.orderId forKey:@"orderId"];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"\n---------Invoice---------- \n #group identification   %@\n #taxes                $%@ \n #surcharges        $%@\n #discounts          $%@\n\n #need paid            $%@\n #paid                   $%@\n #returned             $%@\n #remaining            $%@",
            self.groupId,
            self.taxes,
            self.surcharges,
            self.discounts,
            self.shouldPayAmount,
            self.paidAmount,
            self.returnedAmount,
            self.remainingAmount
            ];
}


@end
