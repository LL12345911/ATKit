发送消息

```objective-c
#import "QSShowContentView.h"

@interface QSContentViewController()

@property (nonatomic,strong)UITextField *textField1;
@property (nonatomic,strong)UITextField *textField2;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)UIButton *resetBtn;
@property (nonatomic,strong)QSShowContentView *contentView;

@end

@implementation QSContentViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"QSUseMessageCenterDemo";
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    [self.view addSubview:({
        _contentView = [[QSShowContentView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,150)];
        _contentView;
    })];
    

    [self.view addSubview:({
        _textField1 = [[UITextField alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_contentView.frame) + 15, SCREEN_WIDTH - 30, 40)];
        _textField1.textColor = [UIColor blackColor];
        _textField1.placeholder = @"请对应label的位置index(从0开始)";
        _textField1.text = @"0";
        _textField1.keyboardType = UIKeyboardTypeNumberPad;
        _textField1;
    })];
    
    [self.view addSubview:({
        _textField2 = [[UITextField alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_textField1.frame) + 15, SCREEN_WIDTH - 30, 40)];
        _textField2.textColor = [UIColor blackColor];
        _textField2.placeholder = @"请输入消息内容";
        _textField2.text = @"哈哈哈哈哈";
        _textField2;
    })];
    
    [self.view addSubview:({
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_btn setTitle:@"更新数据" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _btn.frame = CGRectMake(0, CGRectGetMaxY(_textField2.frame) + 15, SCREEN_WIDTH/2, 30);
        _btn;
    })];
    
    [self.view addSubview:({
        _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_resetBtn setTitle:@"重置数据" forState:UIControlStateNormal];
        [_resetBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _resetBtn.frame = CGRectMake( SCREEN_WIDTH/2, CGRectGetMaxY(_textField2.frame) + 15,  SCREEN_WIDTH/2, 30);
        _resetBtn;
    })];

}

- (void)clickBtnAction:(UIButton *)btn{
    
    if (btn == self.btn) {
        
        NSString *indexStr = _textField1.text;
        NSString *content = _textField2.text;
        NSInteger index = [indexStr integerValue];
        
        if (CHECK_VALID_STRING(indexStr) && CHECK_VALID_STRING(content) && (index >=0 && index <4)) {
            
            QSContentModel *messageModel = [[QSContentModel alloc]initWithIndex:index content:content];
            [self sendMessage:messageModel messageId:QSSetContentValueID receiverKey:@"QSShowContentView"];
        
        }else{
        
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提醒" message:@"index应大于等于0,小于4，内容不可以为空" preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertVC animated:YES completion:nil];
        
        }
        
    }else if (btn == self.resetBtn){
        
        _textField1.text = @"";
        _textField2.text = @"";
        [self sendMessage:nil messageId:QSReSetContentValueID receiverKey:@"QSShowContentView"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

```



接收消息

<QSShowContentView.h>

```objective-c

#define QSSetContentValueID @"SET"
#define QSReSetContentValueID @"RESET"

@interface QSContentModel : NSObject

@property (nonatomic,copy)NSString *content;
@property (nonatomic,assign)NSInteger index;

- (instancetype)initWithIndex:(NSInteger)index content:(NSString *)content;

@end

@interface QSShowContentView : UIView

@end
```

<QSShowContentView.m>

```objective-c
@implementation QSContentModel

- (instancetype)initWithIndex:(NSInteger)index content:(NSString *)content{

    self = [super init];
    if (self) {
        self.index = index;
        self.content = content;
    }
    return self;
}


- (NSString *)description{
    
    return [NSString stringWithFormat:@"%d-%@",(int)self.index,self.content];
}

@end



@interface QSShowContentView()

@property (nonatomic,strong)NSMutableArray *labels;

@end

@implementation QSShowContentView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self setupLabels];
        //注册
        [self registerMessageReceiverWithKey:@"QSShowContentView"];
    }
    return self;
}

- (void)setupLabels{

    self.labels = [NSMutableArray array];
    
    CGFloat width = (self.frame.size.width - 30 - 8)/2;
    CGFloat height = self.frame.size.height/2;
    for (int i= 0; i < 4; i++) {
        
        UILabel *label = [self p_label];
        label.tag = i + 1;
        label.text = [NSString stringWithFormat:@"index %d",(int)i];
        label.frame = CGRectMake((width + 8) * (i%2) + 15, height * (i/2), width, height);
        [self.labels addObject:label];
        [self addSubview:label];
    }
}

- (UILabel *)p_label{

    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor blueColor];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"";
    label.layer.borderColor = [UIColor redColor].CGColor;
    label.layer.borderWidth = 1;
    return label;
}

#pragma mark - 接收消息
- (void)qsReceiveMessage:(id)message messageId:(NSString *)msgId{

    if ([msgId isEqualToString:QSSetContentValueID]) {
        
        QSContentModel *messageModel = (QSContentModel *)message;
        if (messageModel.index >= [self.labels count]) {
            return;
        }
        
        UILabel *label = [self.labels objectAtIndex:messageModel.index];
        label.text = messageModel.content;
        
    }else if ([msgId isEqualToString:QSReSetContentValueID]){
    
    
        for (int i = 0; i < [self.labels count]; i++) {
            UILabel *label = [self.labels objectAtIndex:i];
            label.text = [NSString stringWithFormat:@"index %d",(int)i];
        }
    }
}

@end
```

