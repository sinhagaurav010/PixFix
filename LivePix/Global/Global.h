//
//  Global.h
//  LivePix
//
//  Created by    on 10/06/12.
//  Copyright (c)  . All rights reserved.
//

#import <Foundation/Foundation.h>


#define KsURLSIGNUP @"http://74.53.228.211/~vodavo/webservices/appsignup.php?name="
#define KsURLLOIN @"http://74.53.228.211/~vodavo/webservices/applogin.php?email=%@"
#define KsURLADDEVENT @"http://74.53.228.211/~vodavo/webservices/addevent.php?event_name=%@&user_email=%@&description=%@&date=%@"
#define KsURLINVITEDATTEND @"http://74.53.228.211/~vodavo/webservices/allusersinvited.php?event_id=%@"

#define KsSAVEDID @"SAVEDID"
#define KsALLEVENT @"http://74.53.228.211/~vodavo/webservices/allevents.php"
#define KsAlLEVENTIMAgES @"http://74.53.228.211/~vodavo/webservices/geteventimage.php?event_id="
#define KsSAVEDLOGGEDIN @"loginuser"

#define KsSELEVENT @"EVENTSELECTED"

#define KsURLINVITATION @"http://74.53.228.211/~vodavo/webservices/addinvite.php?event_id=%@&sender_email=%@&invited_list_email=%@"

#define KsDeleteImage @"http://74.53.228.211/~vodavo/webservices/deleteimage.php?image_id=%@&image_creator=%@"

#define KsDeleteEvent @"http://74.53.228.211/~vodavo/webservices/deleteevent.php?event_id=%@&event_creator=%@"

#define KsUrlCreated @"http://74.53.228.211/~vodavo/webservices/alleventsuser.php?user_email=%@"
/*
 Delete image a user needs to swipe the image then a little X will appear that they click on then get confirmation. This will prevent some issues. 
 We use the address book on the phone/device. If they are already an app user then they will get push-notificataion that they have been invited to event. This is determined just by comparing the email from the address book to the members emails. If there is a match then they are app member and they get notification. If they are not a user then it will send them an email inviting them to access the event as well as give them permission to see the event. 
 Events page should not be pull down refresh. It should automatically refresh after adding an event as well as refresh every minute.
 All events need to show by last usage. I can edit that via the webservice with a lookup table.
 Fix upload this is very important.
 Picture resizing is all off. Images are stretched and goofy looking so we need to maintain aspect ratio somehow.
 Users can only access events they are invited to
 Allow image creator to put a name for a photo that will show on large view
 Users need to be able to see a list of all users invited to an event on the event page
 Users need to be able to tag images with people who attended event from list
 Create 2 buttons on bottom of my events page. One for My Events, One for invited events. My events view will be for events a user created, invited events are for list of events that user was invited to.
 Show date of event on Event View right near name
 */