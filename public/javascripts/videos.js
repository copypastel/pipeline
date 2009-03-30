/************************************
  videos.js
  Contains all of the javascript used by the Video controller specifically.
*************************************/
//Youtube Constants
const YOUTUBE_CMD_VIDEO_DONE = 0;
var current_video
//called when the page is finished loading.
function onLoad(video) {
	current_video = video;
	document.title = "Pipeline :: " + current_video.title;
}
//TODO: Verrify that this is true
//Called by third party sourcecode when the youtube player is ready
function onYouTubePlayerReady() {
    startVideo();
}
//Called to start the current_video
function startVideo() {
	var video = document.getElementById("video_player");
    video.loadVideoById(current_video.video_id, 0);
    video.playVideo();
    video.addEventListener("onStateChange", "onYoutubeStateHandle");
}

function loadNextVideo(video) {
	//TODO: does this create a memory leak in javascrip?  Do I have to destroy current_video first?
	$.get("<%= url(:controller => 'videos', :action => 'next')%>", { id: current_video.db_id }, function(response) {
        if(response != "false") {
			current_video = new JSVideo(response.title,response.video_id,response.id);
			startVideo();
		}
	});
}

// Set by youtube options to be the callback, contains the proper response
function onYoutubeStateHandle(state){
    if(state == YOUTUBE_CMD_VIDEO_DONE) {
      loadNextVideo(current_video);
	}
}

//Class used to hold the current video
function JSVideo(title,video_id,id) {
	this.title    = title;    //Title of video
	this.video_id = video_id; //Youtube ID of video
	this.db_id    = id;       //database ID of video
}


//Called bye video submission form.
function post_video(){
    // POST the url.
    $.post("/videos", { url: $('#yt_url').val() }, postVideoHandle,'text');
};

//Called after a post is made to create a new video
//Will display the error message or notify user upon a successful 
function postVideoHandle(response) {
	Success = "#BEEC4C"; //Color for success
	Failure = "#C03926"; //Color for failure
	
	console = new VideoConsole();
	console.hide();

    if(response == "true"){
      // Background to chartreuse, message to 'success'
	  console.message("Video Added",Success)
    }
    else {
	  console.message(response,Failure)
    }
      
    console.show();// Show console.
    setTimeout( function(){
      // Hide console.
      console.hide();
	  console.revert();
      console.show();
    }, 5000);
}

//TODO: Inside of queue functions we cannot access message_box and form... need to fix that to speed up this function since
// currently all modifications call document.getElementById
function VideoConsole() {
	this.form =    $('#video_form');
	this.message_box = $('#console_message');
	this.console = $('#console');
	this.hide = function() {
		// Hide console.
		this.console.animate({ top: -100, opacity: 0 }, 500 );
	}
	
	this.show = function() {
		// Show console.
	    this.console.animate({ top: 0, opacity: 0.85 }, 500 );
	}
	
	this.message = function(message,color) {
		this.console.queue( function() {
		  $("#console_message").html(message);
		  $(this).css('background-color', color);
		  $("#video_form").css( 'display', 'none');
		  $("#console_message").css('display', 'block');
		  $(this).dequeue();
		});
	}
	
	this.revert = function() {
		this.console.queue( function(){
	      $('#yt_url').attr( 'value', '');
	      $('#video_form').css('display', 'block');
		  $(this).css('background-color', 'black');
		  $("#console_message").css('display', 'none');
	      $(this).dequeue();
	    });
	}
}