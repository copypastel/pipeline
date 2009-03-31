/*
 * jHeartbeat 0.3.0
 * (C)Alex Richards - http://www.ajtrichards.co.uk/
 * Edited by Daicoden - http://www.copypastel.com/
 */
 
 $.jheartbeat = {

    options: {
		url: "heartbeat_default.asp",
		delay: 10000,
		format: 'html'
    },
	
	beatfunction:  function(response){
	
	},
	
	timeoutobj:  {
		id: -1
	},

    set: function(options, onbeatfunction) {
		if (this.timeoutobj.id > -1) {
			clearTimeout(this.timeoutobj);
		}
        if (options) {
            $.extend(this.options, options);
        }
        if (onbeatfunction) {
            this.beatfunction = onbeatfunction;
        }
		this.timeoutobj.id = setTimeout("$.jheartbeat.beat();", this.options.delay);
    },

    beat: function() {
		response = null;
		$.ajax({
				url: this.options.url,
				dataType: $.jheartbeat.options.format,
				type: "GET",
				error: function(e)   { 
					response = e;
				},
				success: function(data){ 
					response = e;
				}
			   });
		this.timeoutobj.id = setTimeout("$.jheartbeat.beat();", this.options.delay);
		$.jheartbeat.beatfunction(response);
    }
};