//
//  RdioPluginSource.m
//  RdioPlugin
//
//  Created by James W Mann on 2013-05-10.
//

#import "RdioPluginSource.h"

@implementation QSRdioPluginControlSource

- (BOOL)indexIsValidFromDate:(NSDate *)indexDate forEntry:(NSDictionary *)theEntry {
	// rescan only if the indexDate is prior to the last launch
	NSDate *launched = [[NSRunningApplication currentApplication] launchDate];
	if (launched) {
		return ([launched compare:indexDate] == NSOrderedAscending);
	} else {
		// Quicksilver wasn't launched by LaunchServices - date unknown - rescan to be safe
		return NO;
	}
}

- (NSArray *)objectsForEntry:(NSDictionary *)theEntry
{
	NSMutableArray *controlObjects = [NSMutableArray arrayWithCapacity:1];
	QSCommand *command = nil;
	NSDictionary *commandDict = nil;
	QSAction *newObject = nil;
	NSString *actionID = nil;
	NSDictionary *actionDict = nil;
	// create catalog objects using info specified in the plist (under QSCommands)
	NSArray *controls = [NSArray arrayWithObjects:@"RdioPluginPlayPause", @"RdioPluginNextTrack", @"RdioPluginPreviousTrack", @"RdioPluginIncreaseVolume", @"RdioPluginDecreaseVolume", @"RdioPluginAddToCollection", @"RdioPluginRemoveFromCollection", nil];
	for (NSString *control in controls) {
		command = [QSCommand commandWithIdentifier:control];
		if (command) {
			commandDict = [command commandDict];
			actionID = [commandDict objectForKey:@"directID"];
			actionDict = [[[commandDict objectForKey:@"directArchive"] objectForKey:@"data"] objectForKey:QSActionType];
			if (actionDict) {
				newObject = [QSAction actionWithDictionary:actionDict identifier:actionID bundle:nil];
				[controlObjects addObject:newObject];
			}
		}
	}
	return controlObjects;
}

@end
