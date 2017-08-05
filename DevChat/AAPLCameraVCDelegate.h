//
//  Header.h
//  DevChat
//
//  Created by Mark Price on 7/12/16.
//  Copyright © 2016 Devslopes. All rights reserved.
//

#ifndef Header_h
#define Header_h

@protocol AAPLCameraVCDelegate <NSObject>

//azért kell recordUI és CameraUI mert csak akkor lehet megnyomni a Camera gombot ha a készüléknek két kamerája van.
-(void)shouldEnableRecordUI:(BOOL)enable;
-(void)shouldEnableCameraUI:(BOOL)enable;
-(void)canStartRecording;
-(void)recordingHasStarted;
//-(void)videoRecordingComplete:(NSURL*)videoURL;
//-(void)videoRecordingFailed;
//-(void)snapshotTaken:(NSData*)snapshotData;
//-(void)snapshotFailed;

@end

#endif /* Header_h */
