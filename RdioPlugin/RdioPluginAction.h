//
//  RdioPluginAction.h
//  RdioPlugin
//
//  Created by James W Mann on 2013-05-10.
//

@class RdioApplication;

@interface QSRdioPluginControlsProvider : QSActionProvider
{
  RdioApplication *rdio;
}

-(id)init;

-(void)playPause;
-(void)increaseVolume;
-(void)decreaseVolume;
-(void)previousTrack;
-(void)nextTrack;

@property (nonatomic, strong) RdioApplication *rdio;

@end

@interface QSRdioPluginActionProvider : QSActionProvider
{
}

@end
