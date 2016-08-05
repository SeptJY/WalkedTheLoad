//
//  JYScanErWeiCode.m
//  JYTest
//
//  Created by Sept on 16/7/26.
//  Copyright © 2016年 九月. All rights reserved.
//

#import "JYScanErWeiCode.h"
#import "JYPreviewView.h"

@interface JYScanErWeiCode() <AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) AVCaptureDevice *captureDevice;

@property (strong, nonatomic) AVCaptureDeviceInput *deviceInput;

@property (strong, nonatomic) AVCaptureMetadataOutput * metadataOutput;

@property (strong, nonatomic) AVCaptureSession * captureSession;

@property (strong, nonatomic) AVCaptureVideoPreviewLayer * previewLayer;

@property (nonatomic) dispatch_queue_t sessionQueue;

@property (strong, nonatomic) JYPreviewView *previewView;

@end

@implementation JYScanErWeiCode

- (instancetype)initWithPreviewView:(JYPreviewView *)previewView
{
    self = [super init];
    if (self) {
        self.previewView = previewView;
        [self initSession];
    }
    return self;
}

- (void)initSession
{
    self.captureSession = [[AVCaptureSession alloc] init];
    
    // Setup the preview view.
    self.previewView.session = self.captureSession;
    
    // 与此队列中的会话和其他会话对象进行通信
    self.sessionQueue = dispatch_queue_create( "session queue", DISPATCH_QUEUE_SERIAL );
    
    // 设置捕追会话
    // 一般来说是不安全的 AVCaptureSession 突变 或 其任何输入，输出，或连接多个线程，在同一时间
    dispatch_async( self.sessionQueue, ^{
        
        NSError *error = nil;
        AVCaptureDevice *videoDevice = [JYScanErWeiCode deviceWithMediaType:AVMediaTypeVideo preferringPosition:AVCaptureDevicePositionBack];
        AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
        
        if ( ! videoDeviceInput ) {
            NSLog( @"Could not create video device input: %@", error );
        }
        
        [self.captureSession beginConfiguration];
        
        if ( [self.captureSession canAddInput:videoDeviceInput] ) {
            [self.captureSession addInput:videoDeviceInput];
            self.deviceInput = videoDeviceInput;
            
            AVCaptureDevice *currentVideoDevice = self.deviceInput.device;
            self.captureDevice = currentVideoDevice;
        } else
        {
            // 无法将视频设备输入到会话中
            NSLog( @"Could not add video device input to the session" );
        }
        
        dispatch_async( dispatch_get_main_queue(), ^{
            
            AVCaptureVideoPreviewLayer *previewLayer = (AVCaptureVideoPreviewLayer *)self.previewView.layer;
            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        });
        
        
        self.metadataOutput = [[AVCaptureMetadataOutput alloc]init];
        [self.metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        if ([self.captureSession canAddOutput:self.metadataOutput]) {
            [self.captureSession addOutput:self.metadataOutput];
        }
        
        // 条码类型 AVMetadataObjectTypeQRCode
        self.metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
        
        [self.captureSession commitConfiguration];
    });
}

#pragma mark ---> 设置手动对焦和自动对焦
- (void)focusMode:(AVCaptureFocusMode)focusMode
{
    NSError *error = nil;
    
    if ([self.captureDevice lockForConfiguration:&error]) {
        
        if ([self.captureDevice isFocusModeSupported:focusMode] ) {
            self.captureDevice.focusMode = focusMode;
        }
        
        [self.captureDevice unlockForConfiguration];
        
    } else
    {
        NSLog(@"设置自动对焦失败");
    }
}

- (void)startSession
{
    dispatch_async( self.sessionQueue, ^{
        [self.captureSession startRunning];
        [self focusMode:AVCaptureFocusModeContinuousAutoFocus];
    });
}

- (void)stopSession
{
    dispatch_async( self.sessionQueue, ^{
        [self.captureSession stopRunning];
    });
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0){
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(erWeiCodeScanStringValue:)]) {
            [self.delegate erWeiCodeScanStringValue:stringValue];
        }
        [self stopSession];
    }
}

+ (AVCaptureDevice *)deviceWithMediaType:(NSString *)mediaType preferringPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
    AVCaptureDevice *captureDevice = devices.firstObject;
    
    for ( AVCaptureDevice *device in devices ) {
        if ( device.position == position ) {
            captureDevice = device;
            break;
        }
    }
    
    return captureDevice;
}

@end
