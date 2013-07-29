//
//  RdioPluginAction.m
//  RdioPlugin
//
//  Created by James W Mann on 2013-05-10.
//

#import "RdioPluginAction.h"
#import "Rdio.h"

@implementation QSRdioPluginControlsProvider

@synthesize rdio;

- (id)init
{
  if (self = [super init]) {
    self.rdio = [SBApplication applicationWithBundleIdentifier:@"com.rdio.desktop"];
  }
  return self;
}

-(void)playPause
{
  [self.rdio playpause];
}

- (void)decreaseVolume
{
  NSInteger newVolume = self.rdio.soundVolume - 10;
  if (newVolume < 0) {
    newVolume = 0;
  }
  self.rdio.soundVolume = newVolume;
}

-(void)increaseVolume
{
  NSInteger newVolume = rdio.soundVolume + 10;
  if (newVolume > 100) {
    newVolume = 100;
  }
  rdio.soundVolume = newVolume;
}

-(void)previousTrack
{
  // Previous track just goes to the begining if the current track is pase ~2 seconds, hence why
  // it is called twice sometimes.
  if (self.rdio.playerPosition >= 3) {
    [self.rdio previousTrack];
  }
  
  [self.rdio previousTrack];
}

-(void)nextTrack
{
  [self.rdio nextTrack];
}

- (void) addToCollection {
  [self.rdio addToCollection];
}

- (void) removeFromCollection {
  [self.rdio removeFromCollection];
}


- (BOOL)indexIsValidFromDate:(NSDate *)indexDate forEntry:(NSDictionary *)theEntry
{
	return NO;
}

- (NSImage *)iconForEntry:(NSDictionary *)dict
{
	return nil;
}
@end
