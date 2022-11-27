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
#define BTNHEIGHT  50
#define TOP  70
#define BORDER  10
#define INPUTHEIGHT  35

@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic,   copy) NSArray *buttonTitleList;
@property (nonatomic, strong) UITextView *billView;
@property (nonatomic, strong) UITextField *paidField;
@property (nonatomic,   copy) NSString *paidAmount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _buttonTitleList = @[@"Group1",@"Group2",@"Group3"];
    _paidAmount = @"100";
    
    [self createInputs];
    [self createButtons];
    [self createBillView];
}

- (void)createInputs {
    UILabel *paidLab = [UILabel new];
    [paidLab setTextColor:RGBA(46,184,193,1)];
    paidLab.frame = CGRectMake(BORDER, TOP, 100, INPUTHEIGHT);
    paidLab.text = @"PaidAmount:";
    [self.view addSubview:paidLab];
    
    UITextField *paidField = [UITextField new];
    paidField.backgroundColor = RGBA(233,233,233,1);
    paidField.frame = CGRectMake(BORDER+paidLab.frame.size.width+BORDER, paidLab.frame.origin.y,70, INPUTHEIGHT);
    paidField.text = _paidAmount;
    paidField.delegate = self;
    _paidField = paidField;
    
    [self.view addSubview:paidField];
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
            btn.frame = CGRectMake((self.view.frame.size.width-BTNWIDTH)/2, TOP+BTNHEIGHT+BORDER, BTNWIDTH, BTNHEIGHT);
        }else {
            btn.frame = CGRectMake((self.view.frame.size.width-BTNWIDTH)/2, TOP+i*(BTNHEIGHT)+(i+1)*BORDER+BTNHEIGHT, BTNWIDTH, BTNHEIGHT);
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
    textView.frame = CGRectMake(BORDER, TOP+4*(BTNHEIGHT+BORDER), self.view.frame.size.width-2*BORDER, 450);
    [self.view addSubview:textView];
    
    self.billView = textView;
    
}

-(void)buttonAction:(UIButton *)sender {
    [_paidField resignFirstResponder];
    
    NSNumber *paid = [NSNumber numberWithDouble:_paidAmount.doubleValue];
    
    OrderService *service = [OrderService new];
    NSInteger selIndex = sender.tag;
    switch (selIndex) {
        case 0:
        {
            self.billView.text = [service payBillWithGroup:1 paid:paid];
        }
            break;
        case 1:
        {
            self.billView.text = [service payBillWithGroup:2 paid:paid];
        }
            break;
        case 2:
        {
            self.billView.text = [service payBillWithGroup:3 paid:paid];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    _paidAmount = textField.text;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_paidField resignFirstResponder];
    
}

@end
