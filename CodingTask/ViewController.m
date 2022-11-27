//
//  ViewController.m
//  CodingTask
//
//  Created by zyg on 2022/11/26.
//

#import "ViewController.h"
#import "OrderService.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define BTNWIDTH  150
#define TOP  90
#define BTNHEIGHT  50

@interface ViewController ()

@property (nonatomic,   copy) NSArray *buttonTitleList;
@property (nonatomic, strong) UITextView *billView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _buttonTitleList = @[@"Group1",@"Group2",@"Group3"];
    [self createButtons];
    [self createBillView];
}

- (void)createButtons {
    for (int i = 0; i < _buttonTitleList.count; i++)
    {
        UIButton *btn = [[UIButton alloc ]init];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [btn setTitle:[_buttonTitleList objectAtIndex:i] forState:UIControlStateNormal];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setBackgroundColor:RGBA(46,184,193,1).CGColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:i];
        if (i==0) {
            btn.frame = CGRectMake((self.view.frame.size.width-BTNWIDTH)/2, TOP, BTNWIDTH, BTNHEIGHT);
        }else {
            btn.frame = CGRectMake((self.view.frame.size.width-BTNWIDTH)/2, TOP+i*(BTNHEIGHT+15), BTNWIDTH, BTNHEIGHT);
        }
        
        [self.view addSubview:btn];
    }
}

- (void)createBillView {
    UITextView *textView = [UITextView new];
    [textView setTextColor:RGBA(46,184,193,1)];
    [textView setTextAlignment:NSTextAlignmentLeft];
    [textView setScrollEnabled:YES];
    [textView setEditable:NO];
    textView.frame = CGRectMake(10, TOP+3*(BTNHEIGHT+15)+15, self.view.frame.size.width-20, 450);
    [self.view addSubview:textView];
    
    self.billView = textView;
    
}

-(void)buttonAction:(UIButton *)sender {
    OrderService *service = [OrderService new];
    NSInteger selIndex = sender.tag;
    switch (selIndex) {
        case 0:
        {
            self.billView.text = [service payBillWithGroup:1 paid:@(100)];
        }
            break;
        case 1:
        {
            self.billView.text = [service payBillWithGroup:2 paid:@(100)];
        }
            break;
        case 2:
        {
            self.billView.text = [service payBillWithGroup:3 paid:@(100)];
        }
            break;
            
        default:
            break;
    }
}


@end
