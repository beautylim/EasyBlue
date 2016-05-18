//
//  StepDataViewController.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/17.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "StepDataViewController.h"
#import "UserInfo.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "NSData+HexDump.h"

@interface StepDataViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>
@property (strong, nonatomic) CBCentralManager *myCentralManager;
@property (strong, nonatomic) CBPeripheral *myPeripheral;
@property (strong, nonatomic) IBOutlet UIButton *shakeButton;
@property (strong, nonatomic) CBService *myCBService;
@property (strong, nonatomic) CBCharacteristic *myShakeCharacteristic;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property (strong, nonatomic) IBOutlet UILabel *stepValue;

@end

@implementation StepDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCBCentralMAnager];
    _shakeButton.layer.masksToBounds = YES;
    _shakeButton.layer.cornerRadius = 15;
    _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:_indicatorView];
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.height.mas_equalTo(200);
    }];
    [_indicatorView startAnimating];
}

- (void)initCBCentralMAnager{
    _myCentralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil options:nil];
    //static NSString *const kServiceUUID = @"44DEF826-C654-DF07-C9EC-CF2DF0141794"; @[[CBUUID UUIDWithString:kServiceUUID]]

}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
 //   static NSString *const kServiceUUID = @"44DEF826-C654-DF07-C9EC-CF2DF0141794"; @[[CBUUID UUIDWithString:kServiceUUID]]
    if (self.myCentralManager.state == CBCentralManagerStatePoweredOn) {
         [_myCentralManager scanForPeripheralsWithServices:nil  options:nil];
    }
}
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    NSLog(@"Discovered %@", peripheral.name);
    if ([peripheral.name isEqualToString:@"MI"]) {
        [_myCentralManager stopScan];
        self.myPeripheral = peripheral;
        [_myCentralManager connectPeripheral:peripheral options:nil];
    }
 
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"Peripherl connected");
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    for (CBService *service in peripheral.services) {
        NSLog(@"Discovered service %@", service);
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@"Discovered characteristic %@", characteristic);
        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        NSLog(@"Reading vlue for characteristic %@", characteristic);
//        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A06"]]) {
//            _myShakeCharacteristic = characteristic;
            [_indicatorView stopAnimating];
//            Byte bytes[] = {1};
//            [peripheral writeValue:[NSData dataWithBytes:bytes length:1] forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
//        }
        [peripheral readValueForCharacteristic:characteristic];
    }

}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if ([characteristic.UUID isEqual:UUID_CHARACTERISTIC_REALTIME_STEPS]) {
        NSData *stepData = characteristic.value;
        NSString *stepStr = [stepData hexval];
        NSString *realStrpStr = [NSString stringWithFormat:@"%@%@%@",[stepStr substringWithRange:NSMakeRange(3, 1)],[stepStr substringWithRange:NSMakeRange(0, 1)],[stepStr substringWithRange:NSMakeRange(1, 1)]];
        UInt64 stepInt =  strtoul([realStrpStr UTF8String], 0, 16);
        _stepValue.text = [NSString stringWithFormat:@"步数为 %llu",stepInt];
    }
    
    NSLog(@"characteristic is %@      value is %@",characteristic,characteristic.value);
}

- (IBAction)clickShaking:(id)sender {
    if (_myShakeCharacteristic) {
        Byte bytes[] = {1};
        NSLog(@"cnuuid:%@",_myShakeCharacteristic.UUID);
        [_myPeripheral writeValue:[NSData dataWithBytes:bytes length:1] forCharacteristic:_myShakeCharacteristic type:CBCharacteristicWriteWithoutResponse];
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
