//
//  RdioPluginSource.m
//  RdioPlugin
//
//  Created by James W Mann on 2013-05-10.
//

#import "RdioPluginSource.h"
#import "Rdio.h"

@implementation QSRdioPluginSource

@synthesize rdio;

/*- (id)init
{
  if (self = [super init]) {
    self.rdio = [SBApplication applicationWithBundleIdentifier:@"com.rdio.desktop"];
  }
  return self;
}*/

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


- (BOOL)indexIsValidFromDate:(NSDate *)indexDate forEntry:(NSDictionary *)theEntry
{
	return NO;
}

- (NSImage *)iconForEntry:(NSDictionary *)dict
{
	return nil;
}

// Return a unique identifier for an object (if you haven't assigned one before)
//- (NSString *)identifierForObject:(id <QSObject>)object
//{
//	return nil;
//}

- (NSArray *) objectsForEntry:(NSDictionary *)theEntry
{
	NSMutableArray *objects=[NSMutableArray arrayWithCapacity:1];
	QSObject *newObject;
	
	newObject=[QSObject objectWithName:@"TestObject"];
	[newObject setObject:@"" forType:QSRdioPluginType];
	[newObject setPrimaryType:QSRdioPluginType];
	[objects addObject:newObject];
	
	return objects;
}

// Object Handler Methods

/*
- (void)setQuickIconForObject:(QSObject *)object
{
	[object setIcon:nil]; // An icon that is either already in memory or easy to load
}

- (BOOL)loadIconForObject:(QSObject *)object
{
	return NO;
	id data=[object objectForType:QSRdioPluginType];
	[object setIcon:nil];
	return YES;
}
*/
@end
