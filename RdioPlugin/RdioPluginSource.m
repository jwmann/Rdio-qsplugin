//
//  RdioPluginSource.m
//  RdioPlugin
//
//  Created by James W Mann on 2013-05-10.
//

#import "RdioPluginSource.h"

@implementation QSRdioPluginSource



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
	NSArray *controls = [NSArray arrayWithObjects:@"RdioPluginPlayPause", @"RdioPluginNextTrack", @"RdioPluginPreviousTrack", nil];
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
