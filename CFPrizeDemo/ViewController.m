//
//  ViewController.m
//  CFPrizeDemo
//
//  Created by wjc on 16/11/7.
//  Copyright © 2016年 CityFire. All rights reserved.
//

#import "ViewController.h"
#import "TutuRollPrizeViewController.h"
#import "WheelPrizeViewController.h"
#import "RandomCreateViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // dispatch_semaphore是GCD用来同步的一种方式，与他相关的共有三个函数，分别是dispatch_semaphore_create，dispatch_semaphore_signal，dispatch_semaphore_wait。 信号量机制 P、V操作
    // （1）dispatch_semaphore_create的声明为：
//    dispatch_semaphore_t dispatch_semaphore_create(long value);
//    传入的参数为long，输出一个dispatch_semaphore_t类型且值为value的信号量。
//    
//    值得注意的是，这里的传入的参数value必须大于或等于0，否则dispatch_semaphore_create会返回NULL。
//    
//    （2）dispatch_semaphore_signal的声明为：
//    long dispatch_semaphore_signal(dispatch_semaphore_t dsema);
//    这个函数会使传入的信号量dsema的值加1；
//    
//    (3) dispatch_semaphore_wait的声明为：
//    long dispatch_semaphore_wait(dispatch_semaphore_t dsema, dispatch_time_t timeout);
//    这个函数会使传入的信号量dsema的值减1；这个函数的作用是这样的，如果dsema信号量的值大于0，该函数所处线程就继续执行下面的语句，并且将信号量的值减1；如果desema的值为0，那么这个函数就阻塞当前线程等待timeout（注意timeout的类型为dispatch_time_t，不能直接传入整形或float型数），如果等待的期间desema的值被dispatch_semaphore_signal函数加1了，且该函数（即dispatch_semaphore_wait）所处线程获得了信号量，那么就继续向下执行并将信号量减1。如果等待期间没有获取到信号量或者信号量的值一直为0，那么等到timeout时，其所处线程自动执行其后语句。
//    
//    dispatch_semaphore 是信号量，但当信号总量设为 1 时也可以当作锁来。在没有等待情况出现时，它的性能比 pthread_mutex 还要高，但一旦有等待情况出现时，性能就会下降许多。相对于 OSSpinLock 来说，它的优势在于等待时不会消耗 CPU 资源。
//    
//    如上的代码，如果超时时间overTime设置成>2，可完成同步操作。如果overTime<2的话，在线程1还没有执行完成的情况下，此时超时了，将自动执行下面的代码。
    /*
    dispatch_semaphore_t signal = dispatch_semaphore_create(1);
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"dispatch_semaphore需要线程同步的操作1 开始");
        sleep(2);
        NSLog(@"dispatch_semaphore需要线程同步的操作1 结束");
        dispatch_semaphore_signal(signal);
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"dispatch_semaphore需要线程同步的操作2");
        dispatch_semaphore_signal(signal);
    });

    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(50);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 100; i++) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            NSLog(@"%i", i);
            sleep(2);
            dispatch_semaphore_signal(semaphore);
        });
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    dispatch_release(group);
//    dispatch_release(semaphore);
    
    NSObject *obj = [[NSObject alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (obj) {
            NSLog(@"synchronized需要线程同步的操作1开始");
            sleep(3.0);
            NSLog(@"synchronized需要线程同步的操作1结束");
        }
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        @synchronized (self) {
            NSLog(@"synchronized需要线程同步的操作2");
        }
//        @synchronized (obj) {
//            NSLog(@"需要线程同步的操作2");
//        }
    });
     */
    // @synchronized指令实现锁的优点就是我们不需要在代码中显式的创建锁对象，便可以实现锁的机制，但作为一种预防措施，@synchronized块会隐式的添加一个异常处理例程来保护代码，该处理例程会在异常抛出的时候自动的释放互斥锁。所以如果不想让隐式的异常处理例程带来额外的开销，你可以考虑使用锁对象。
}

- (IBAction)randomCreateViewPressed:(id)sender {
    RandomCreateViewController *vc = [RandomCreateViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)rollPrizePressed:(id)sender {
    TutuRollPrizeViewController *vc = [TutuRollPrizeViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)wheelPressed:(id)sender {
    WheelPrizeViewController *vc = [WheelPrizeViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
