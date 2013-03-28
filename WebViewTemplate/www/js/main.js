function openCustomURLinIFrame(src)
{
    var rootElm = document.documentElement;
    var newFrameElm = document.createElement("IFRAME");
    newFrameElm.setAttribute("src",src);
    rootElm.appendChild(newFrameElm);
    //remove the frame now
    newFrameElm.parentNode.removeChild(newFrameElm);
}


function calliOSFunction(functionName, args, successCallback, errorCallback)
{
    var url = "js2ios://";

    var callInfo = {};
    callInfo.functionname = functionName;
    if (successCallback)
    {
        callInfo.success = successCallback;
    }
    if (errorCallback)
    {
        callInfo.error = errorCallback;
    }
    if (args)
    {
        callInfo.args = args;
    }

    url += JSON.stringify(callInfo)

    openCustomURLinIFrame(url);
}


$(document).ready(function() {
   // do stuff when DOM is ready
   
   $(".native-link").click(function(e){
	   var txt = $(e.currentTarget).attr('id');
	   calliOSFunction("changeLabel", [txt], "onSuccess", "onError");

	   function onSuccess (ret)
	   {
	       if (ret)
	       {
	           var obj = JSON.parse(ret);
	           document.write(obj.result);
	       }
	   }

	   function onError (ret)
	   {
	       if (ret)
	       {
	           var obj = JSON.parse(ret);
	           document.write(obj.error);
	       }
	   }
   });
 });