//
//  CodingTaskTests.m
//  CodingTaskTests
//
//  Created by zyg on 2022/11/26.
//

#import <XCTest/XCTest.h>
#import "CodeTaskUtil.h"
#import "OrderHandler.h"

@interface CodingTaskTests : XCTestCase



@end

@implementation CodingTaskTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testFilterCharacterFromOriginStr_returnInlegal {
    // Given
    NSString *oriStr = @"Big Brekkie $16 Big Brekkie $16 Bruschetta $8 Poached Eggs $12 Coffee $5 Tea $3 Soda $4";
    NSString *scanString = [NSString stringWithFormat:@"%@%@",PRICENUMBER,PRICEFLAG];
    
    // When
    NSString *filter = [CodeTaskUtil filterCharacterFromOriginStr:oriStr scanString:scanString];
    
    // Then
    XCTAssertNotNil(filter,@"The input content does not conform to the product format");
    XCTAssert(filter.length > 0,@"The input content does not conform to the product format");
    
    
    
}

- (void)testformateNumber_returnInlegal {
    // Given
    NSNumber *number1 = [NSNumber numberWithDouble:1.22];
    NSNumber *number2 = [NSNumber numberWithDouble:0.22];
    NSNumber *number3 = [NSNumber numberWithDouble:-1];
    NSNumber *number4 = [NSNumber numberWithDouble:+1.22];
    
    NSNumber *number_1 = [NSNumber numberWithDouble:1.22];
    NSNumber *number_2 = [NSNumber numberWithDouble:0.22];
    NSNumber *number_3 = [NSNumber numberWithDouble:10];
    
    // When
    NSString *formate1 = [CodeTaskUtil formateNumber:number1 formateType:NumberTypePrice];
    NSString *formate2 = [CodeTaskUtil formateNumber:number2 formateType:NumberTypePrice];
    NSString *formate3 = [CodeTaskUtil formateNumber:number3 formateType:NumberTypePrice];
    NSString *formate4 = [CodeTaskUtil formateNumber:number4 formateType:NumberTypePrice];
    
    NSString *formate_1 = [CodeTaskUtil formateNumber:number_1 formateType:NumberTypeTaxes];
    NSString *formate_2 = [CodeTaskUtil formateNumber:number_2 formateType:NumberTypeTaxes];
    NSString *formate_3 = [CodeTaskUtil formateNumber:number_3 formateType:NumberTypeTaxes];
    
    
    // Then
    XCTAssertNotNil(formate1,@"price format error,reason:not support number");
    XCTAssertNotEqual(formate1, formate4,@"format error");
    XCTAssert([formate3 containsString:@"-"],@"price format error");
    XCTAssert([formate2 containsString:@"0.22"],@"price format error");
    
    
    XCTAssertNotNil(formate_1,@"taxes format error,reason:not support number");
    XCTAssert([formate_1 containsString:@"%"],@"taxes format error");
    XCTAssertNotEqual(formate_2, @"22%",@"taxes format error");
    XCTAssertNotEqual(formate_3, @"1,000.0%",@"taxes format error");
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
