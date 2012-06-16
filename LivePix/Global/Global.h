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


#define KsSAVEDID @"SAVEDID"
#define KsALLEVENT @"http://74.53.228.211/~vodavo/webservices/allevents.php"
#define KsAlLEVENTIMAgES @"http://74.53.228.211/~vodavo/webservices/geteventimage.php?event_id="
#define KsSAVEDLOGGEDIN @"loginuser"

#define KsSELEVENT @"EVENTSELECTED"

#define KsURLINVITATION @"http://74.53.228.211/~vodavo/webservices/addinvite.php?event_id=%@&sender_email=%@&invited_list_email=%@"

#define KsDeleteImage @"http://74.53.228.211/~vodavo/webservices/deleteimage.php?image_id=%@&image_creator=%@"

#define KsDeleteEvent @"http://74.53.228.211/~vodavo/webservices/deleteevent.php?event_id=%@&event_creator=%@"