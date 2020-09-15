## 描述
这是一个灵活的事件总线。

事件总线是对发布-订阅模式的一种实现。它是一种集中式事件处理机制，允许不同的组件之间进行彼此通信而又不需要相互依赖，达到一种解耦的目的。

借助DWEventBus，你可以轻松的实现这种模式。他是线程安全，随意指定消息发布或者订阅回调的执行队列、订阅方执行完毕的反馈、对联合事件的支持、强弱类型的支持以及链式语法都让你使用起来可以更加轻松愉快。
## 功能
- 发布-订阅模式
- 联合事件
- 指定发布和订阅回调所在队列
- 订阅方执行完毕的反馈



```
 MarsEventBus
 
 支持强弱类型、指定队列、组合事件的事件总线。
 
 MarsEventBus提供强弱类型支持，可以指定事件发送的队列和接收事件后回调的队列。
 同时当接收到事件后，你也可以通知发送方接收方已处理完毕。
 你也可以指定多个事件联合作为一个回调触发的条件，也可指定订阅多个不同的事件而触发同一个回调。
 此外，当订阅者销毁时，可以自动移除订阅关系。
 可以存在多个总线，多个总线中相互独立，互不影响
 
 sample:
 
 [[MarsEventBus defaultEventBus] subscribe:^(MarsEventMaker *maker) {
    maker.EventName(@"Login").dw_Build();
 } On:^(__kindof MarsEvent *event, id subscribeTarget) {
    NSLog(@"收到事件了");
 }];
 
 [[MarsEventBus defaultEventBus] publish:^(MarsEventMaker *maker) {
    maker.EventName(@"Login").dw_Build();
 }];
 
 version 1.0.0
 提供强弱类型支持、提供队列支持、提供联合事件和批量事件支持、提供销毁时自动移除订阅支持
 多总线独立分发消息
 
```

##sample

```objective-c
@interface ViewController ()

@property (nonatomic ,strong) A * a;
@property (nonatomic ,strong) MarsEventBus * bus;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self testNormalEvent];
    //    [self testEventQueue];
    //    [self testUniteEvent];
    //    [self testMultiEvent];
    //    [self testRemove];
    //    [self testUniteRemove];
    [self testTargetDealloc];
}

-(void)testTargetDealloc {
    
    ///当target释放后，将自动移除事件订阅，不能再次响应事件
    self.a = [A new];
    [[MarsEventBus defaultEventBus] subscribe:^(MarsEventMaker *maker) {
        maker.EventName(@"Login").Target(self.a).Build();
    } On:^(__kindof MarsEvent *event ,id target) {
        NSLog(@"%@收到信号",target);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MarsEvent * e = [MarsEvent new];
        e.eventName = @"Login";
        
        NSLog(@"可以收到事件");
        [[MarsEventBus defaultEventBus] publishEvent:e];
        self.a = nil;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MarsEvent * e = [MarsEvent new];
        e.eventName = @"Login";
        
        NSLog(@"不可以收到事件");
        [[MarsEventBus defaultEventBus] publishEvent:e];
    });
}

-(void)testUniteRemove {
    
    ///联合移除概念有所不同，联合移除意为分别移除每一个事件，故相同事件均会被移除，而不是移除对应的联合事件
    
    MarsEvent * e1 = [MarsEvent new];
    e1.eventName = @"Regist";
    MarsEvent * e2 = [MarsEvent new];
    e2.eventName = @"Login";
    
    [[MarsEventBus defaultEventBus] subscribe:^(MarsEventMaker *maker) {
        maker.UniteEvent(e1).dw_Build();
        maker.UniteEvent(e2).dw_Build();
        maker.UniteEvent(e1).UniteEvent(e2).dw_Build();
    } On:^(__kindof MarsEvent *event ,id target) {
        NSLog(@"收到事件");
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"均可以收到事件");
        [[MarsEventBus defaultEventBus] publishEvent:e1];
        [[MarsEventBus defaultEventBus] publishEvent:e2];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[MarsEventBus defaultEventBus] remove:^(MarsEventMaker *maker) {
            maker.UniteEvent(e1).UniteEvent(e2).dw_Build();
        }];
        
        NSLog(@"均不能收到事件");
        [[MarsEventBus defaultEventBus] publishEvent:e1];
        [[MarsEventBus defaultEventBus] publishEvent:e2];
    });
    
    
}

-(void)testRemove {
    
    ///移除事件只会影响相同事件的订阅，即eventName与subType均相同的事件订阅才会被移除。
    
    ///移除后普通事件因为已经取消了事件的订阅所以无法再出发。
    ///联合事件中一个事件订阅被移除后，因为取消了联合事件中的一个订阅，该订阅即被移除，则该联合事件无法再出发
    
    MarsEvent * e1 = [MarsEvent new];
    e1.eventName = @"Regist";
    
    MarsEvent * e2 = [MarsEvent new];
    e2.eventName = @"Login";
    
    [[MarsEventBus defaultEventBus] subscribe:^(MarsEventMaker *maker) {
        maker.EventName(@"Regist").dw_Build();
        maker.UniteEvent(e1).UniteEvent(e2).dw_Build();
    } On:^(__kindof MarsEvent *event ,id target) {
        NSLog(@"收到事件");
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[MarsEventBus defaultEventBus] publish:^(MarsEventMaker *maker) {
            maker.UniteEvent(e1).UniteEvent(e2).Build();
        }];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[MarsEventBus defaultEventBus] remove:^(MarsEventMaker *maker) {
            maker.EventName(@"Regist").SubType(1).dw_Build();
        }];
        
        NSLog(@"不会影响事件收发，因为移除的事件与订阅事件不同。");
        [[MarsEventBus defaultEventBus] publishEvent:e1];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        MarsEvent * e = [MarsEvent new];
        e.eventName = @"Regist";
        [[MarsEventBus defaultEventBus] removeEvent:e target:self];
        
        NSLog(@"均不会收到事件");
        [[MarsEventBus defaultEventBus] publishEvent:e1];
        [[MarsEventBus defaultEventBus] publishEvent:e2];
    });
}

-(void)testMultiEvent {
    
    ///多个不同事件可以在同一个工厂中注册并同享同一个事件回调。单条语句视为一个事件，语句以Build()视为单条语句结束，工厂中可以由多条语句。
    ///同一事件可在不同处订阅事件，事件将分别回调。
    ///联合语句作用于仅在单条语句之中。若单条语句中只有一个联合事件，事件将降级为普通事件。
    MarsEvent * e1 = [MarsEvent new];
    e1.eventName = @"Regist";
    
    [[MarsEventBus defaultEventBus] subscribe:^(MarsEventMaker *maker) {
        maker.EventName(@"Login").dw_Build();
        maker.UniteEvent(e1).dw_Build();
    } On:^(__kindof MarsEvent *event ,id target) {
        NSLog(@"收到事件信号：%@",event.eventName);
    }];
    
    [[MarsEventBus defaultEventBus] subscribe:^(MarsEventMaker *maker) {
        maker.EventName(@"Login").dw_Build();
    } On:^(__kindof MarsEvent *event ,id target) {
        NSLog(@"第二次订阅收到的信号：%@",event.eventName);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MarsEvent * e1 = [MarsEvent new];
        e1.eventName = @"Login";
        [[MarsEventBus defaultEventBus] publishEvent:e1];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MarsEvent * e2 = [MarsEvent new];
        e2.eventName = @"Regist";
        [[MarsEventBus defaultEventBus] publishEvent:e2];
    });
}

-(void)testUniteEvent {
    
    ///发送联合事件概念有所不同，联合发送意为分别发送每一个事件，故相同事件均会被触发，而不是触发对应的联合事件
    ///联合事件只有在订阅的事件收到至少一次以后才会触发回调，并重置状态为均为收到状态，从而等待下一次所有事件至少收到一次。
    ///只有收到一致的事件才被视为有效事件。事件的一致性判断为:eventName和subType均相同的两个事件即为相同事件。
    MarsEvent * e1 = [MarsEvent new];
    e1.eventName = @"Regist";
    
    MarsEvent * e2 = [MarsEvent new];
    e2.eventName = @"Login";
    
    [[MarsEventBus defaultEventBus] subscribe:^(MarsEventMaker *maker) {
        maker.UniteEvent(e1).UniteEvent(e2).EventName(@"Test").dw_Build();
        maker.EventName(@"Login").dw_Build();
    } On:^(__kindof MarsEvent *event ,id target) {
        NSLog(@"事件接收完成，最后收到的是：%@",event.eventName);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"事件都将接收完成");
        [[MarsEventBus defaultEventBus] publish:^(MarsEventMaker *maker) {
            maker.UniteEvent(e1).UniteEvent(e2).Build();
        }];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        MarsEvent * e1 = [MarsEvent new];
        e1.eventName = @"Regist";
        
        NSLog(@"联合事件不会完成，因为还差Login事件的发送");
        [[MarsEventBus defaultEventBus] publishEvent:e1];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        MarsEvent * e2 = [MarsEvent new];
        e2.eventName = @"Login";
        e2.subType = 0;
        
        NSLog(@"联合事件不会完成，因为Login事件的subType指定为0，而订阅时为缺醒subType（-1）。");
        [[MarsEventBus defaultEventBus] publishEvent:e2];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MarsEvent * e3 = [MarsEvent new];
        e3.eventName = @"Login";
        
        NSLog(@"联合事件将会完成。");
        [[MarsEventBus defaultEventBus] publishEvent:e3];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MarsEvent * e4 = [MarsEvent new];
        e4.eventName = @"Test";
        
        NSLog(@"事件不会触发，因为若单挑语句中含有联合事件，则该条语句中的EventName及SubType将被忽略");
        [[MarsEventBus defaultEventBus] publishEvent:e4];
    });
}

-(void)testEventQueue {
    
    ///结尾的.dw_Build()为快捷宏，相当于.Target(self).Build().
    ///事件队列测试，一个在订阅时不指定接受回调队列，一个指定接收回调队列。
    ///事件发送时，一次不指定发送队列，一次指定发送队列。
    ///可以看到当不指定接收队列时，接收队列等于发送队列。
    ///当指定接收队列时，接受队列等于指定队列。
    ///当不指定发送队列时，当前队列即为发送队列。
    ///当指定发送队列时，指定队列即为发送队列。
    [[MarsEventBus defaultEventBus] subscribe:^(MarsEventMaker *maker) {
        maker.EventName(@"Login").Queue(dispatch_queue_create("com.MarsEventBus.receiveQueue", NULL)).dw_Build();
        maker.EventName(@"Login").dw_Build();
    } On:^(__kindof MarsEvent *event ,id target) {
        NSLog(@"Receive Login Event On Thread:%@",[NSThread currentThread]);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MarsEvent * event = [MarsEvent new];
        event.eventName = @"Login";
        event.queue = dispatch_queue_create("com.MarsEventBus.dispatchQueue", NULL);
        [[MarsEventBus defaultEventBus] publishEvent:event];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MarsEvent * event = [MarsEvent new];
        event.eventName = @"Login";
        [[MarsEventBus defaultEventBus] publishEvent:event];
    });
}

-(void)testNormalEvent {
    
    ///普通写法，仅指定主类型事件，事件接收是默认在事件发送的线程
    ///无法收到消息，因为发送消息的总线不是订阅的总线
    ///多个总线分开工作，互不影响
    
    MarsEvent * event = [MarsEvent new];
    event.eventName = @"Login";
    self.bus = [MarsEventBus new];
    [self.bus subscribeEvent:event target:self On:^(__kindof MarsEvent *event, id target) {
        NSLog(@"Receive Login Event On Thread:%@",[NSThread currentThread]);
        [event setEventHandledBy:self];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MarsEvent * event = [MarsEvent new];
        event.eventName = @"Login";
        event.eventHandledCallback = ^(id flag) {
            NSLog(@"Login event has been handled by %@",flag);
        };
        
        NSLog(@"无法收到消息，因为发送消息的总线不是订阅的总线");
        [[MarsEventBus defaultEventBus] publishEvent:event];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MarsEvent * event = [MarsEvent new];
        event.eventName = @"Login";
        event.eventHandledCallback = ^(id flag) {
            NSLog(@"Login event has been handled by %@",flag);
        };
        NSLog(@"可以接受消息，因为发送与订阅是同一个总线");
        [self.bus publishEvent:event];
        self.bus = nil;
    });
}
@end
```
