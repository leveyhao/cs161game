/*
	Tracks mouse movement, click, keyboard, and scroll events. 
	Sends event data to php server to be stored in a database.
	
	To include script on an HTML webpage, insert the following two lines:
		<script type="text/javascript" src="json2.js"></script>
		<script type="text/javascript" src="Track.js"></script>
*/
//parameters to be set
var id = document.userid,		//id of current user
    serverurl = "record_event",	//server url page
    group0time1 = 1,			//send data after certain # of events or time interval
    sendTogether = 40,			//send data to server every n events if group0time1 == 0
    interval = 5000,			//send data to server every n milliseconds if group0time1 == 1
    mouseSampleRate = 5; 		//every nth mousemove event recorded
	
//misc. variables
var x, y, time, request, jsonObject;
var moves = 0,
    eventsRecorded = 0,
    xOffset = 0,
    yOffset = 0,
    jsonArray = [];

//IE may have different event handles
var isIE = document.all ? true : false;
if (!isIE) document.captureEvents(Event.MOUSEMOVE);

//sends data every <interval> milliseconds if parameter is set
if (group0time1 == 1) {
    setInterval(function () {
        send();
    }, interval);
}

//event handles that trigger functions to record event data
document.onmousemove = getMousePosition;
document.onmousedown = leftClickDown;
document.onmouseup = leftClickUp;
document.onkeydown = getKeyDown;
document.onkeypress = getKeyPress;
document.onkeyup = getKeyUp;
document.onscroll = getScroll;

/** escape special % chars **/
function customEscape(c) {
    return ((c == "%" || c == "&") ? escape(c) : c)
}

/** records current cursor position **/
function getMousePosition(e) {
    if (moves++ % mouseSampleRate != 0) return;
    updatePosition(e);
    recordEvent("mousemove", x, y, '');
}

/** records cursor position at beginning of click **/
function leftClickDown(e) {
    updatePosition(e);
    recordEvent("leftclickdown", x, y, '');
}

/** records cursor position at release of click **/
function leftClickUp(e) {
    updatePosition(e);
    recordEvent("leftclickup", x, y, '');
}

/** records a key being pressed**/
//records letter of key, does not have capital/lower case info
function getKeyDown(e) {
    var e = window.event || e;
    var unicode = e.charCode || e.keyCode;
    recordEvent("keydown", unicode, 0, customEscape(String.fromCharCode(unicode)))
}

/** records a key being pressed **/
//records the character that has been typed, including case info
function getKeyPress(e) {
    var e = window.event || e;
    var unicode = e.charCode || e.keyCode;
    recordEvent("keypress", unicode, 0, customEscape(String.fromCharCode(unicode)))
}

/** records a key being released **/
//records letter of key, does not have capital/lower case info
function getKeyUp(e) {
    var e = window.event || e;
    var unicode = e.charCode || e.keyCode;
    recordEvent("keyup", unicode, 0, customEscape(String.fromCharCode(unicode)));
}

/** records scrolling action including distance of scroll **/
function getScroll(e) {
    recordEvent("scroll", (window.pageXOffset - xOffset), (window.pageYOffset - yOffset), '');
    //update values of offsets
    xOffset = window.pageXOffset;
    yOffset = window.pageYOffset;
}

/** sets global vars x and y to the position of the cursor **/
function updatePosition(e) {
    if (!isIE) {
        x = e.pageX;
        y = e.pageY;
    }
    if (isIE) {
        x = event.clientX + xOffset;
        y = event.clientY + yOffset;
    }
}

/** creates event JSON, saves to array, sends if max length is reached **/
function recordEvent(eventname, i, j, str) {
    jsonObject = {
        user_id: id,
        time: new Date().getTime(),
        event: eventname,
        info1: i,
        info2: j,
        info3: str
    }
    jsonArray.push(jsonObject);
    //tries to send data if length-based sending is set
    if (group0time1 == 0) {
        //sends if there are <sendTogether> objects in the array
        if (++eventsRecorded % sendTogether == 0) {
            send();
        }
    }
}

/** sends recorded event data to server **/
function send() {
    if (jsonArray.length < 1) return;
    if (window.XMLHttpRequest) {
        //for IE7+, Firefox, Chrome, Opera, Safari
        request = new XMLHttpRequest();
    } else {
        //for IE6, IE5
        request = new ActiveXObject("Microsoft.XMLHTTP");
    }
    request.onreadystatechange = function () {
        //if request finished and response is ready
        if (request.readyState == 4) {
            //if status is not "OK" write the error to the page
            if (request.status != 200) {
                document.write(request.responseText);
            }
        }
    }
    //open a POST connection and send the string
    request.open("POST", serverurl, true);
    request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    var token = $("meta[name='csrf-token']").attr("content");
    request.setRequestHeader("X-CSRF-Token", token);
    request.send("eventdata=" + JSON.stringify(jsonArray));
    jsonArray = [];
}
