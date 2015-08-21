(function($){
	$.cfVirtualWindow = function(title,url,options,handlers){
		var opts = $.extend({},$.cfVirtualWindow.defaults,options);
		var handlers = $.extend({},$.cfVirtualWindow.handlers,handlers);
		var cfwin,objWin;
		var cfwid = "cfvirtual" + Math.floor(new Date().getTime() + (Math.random()*333));
		var divElement = document.createElement("div");		
		var objiframe = $("<iframe  id=\"iframewin" + cfwid + "\" name=\"" + opts.iframeName + "\" frameborder=\"0\" style=\"background-color:##ffffff\"></iframe>");		

		divElement.id=cfwid;
		divElement.setAttribute("style","overflow:hidden");
		objiframe.parent().css("overflow","hidden");
		objiframe.css("width",(opts.width - 15)+ 'px');
		objiframe.css("height",(opts.height)+ 'px');
		$(divElement).append(objiframe);
		var curdig = $(divElement);
		curdig.dialog({
			autoOpen: false,
			height: opts.height,
			width: opts.width,
			modal: opts.modal,
			resizable: opts.resizable,
			minHeight: opts.minHeight,
			minWidth : opts.minWidth,
			open: function( event, ui ) {
				$(this).dialog("option", "title", title);
				objiframe.attr("src",url);
				objiframe.css("height",$(divElement).css("height"));
				eval(handlers.onShow());
			},
			close: function( event, ui ) {
				objiframe.attr("src","");
				eval(handlers.onHide());
			},
			resize:function(event,ui){
				objiframe.css("width",($(divElement).width() + 7)+ 'px');
				objiframe.css("height",($(divElement).height())+ 'px');
			}
		});
		this.show = function(){curdig.dialog( "open" );};
		this.hide = function(){curdig.dialog( "close" );};
		
		this.setURL = function(mUrl){
			url = mUrl;
		};
		this.setTitle = function(mTitle){
			title = mTitle;
		};
		this.setHeight = function(mHeight){
			opts.height = mHeight;
			objiframe.css("height",(opts.height)+ 'px');
			$(curdig).dialog("option", { height: opts.height });
		};
		this.setWidth = function(mWidth){
			opts.width = mWidth;
			objiframe.css("width",(opts.width - 15)+ 'px');
			$(curdig).dialog("option", { width: opts.width });
		};

		return this;
	};
	$.cfVirtualWindow.defaults = {
		title:'Haunt World',
		width:600,
		height:450,
		modal:true,
		center:true,
		draggable:true,
		minHeight:300,
		minWidth:300,
		resizable:true,
		initshow:false,
		iframeName:''
	};
	$.cfVirtualWindow.handlers = {
		onHide : function(){},
		onShow : function(){}
	};
	
})(jQuery);