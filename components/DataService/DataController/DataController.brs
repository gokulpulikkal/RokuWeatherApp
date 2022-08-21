

function sendRequest(requestObject as object, handler="defaultResponseHandler") as void
    dataTask = CreateObject("roSGNode", "DataServiceTask")
    dataTask.update(requestObject)
    dataTask.observeField("content", handler)
    dataTask.control = "RUN"

end function

function defaultResponseHandler(event as object) as void
    data = event.getData()
    if data <> invalid
        print "Response is in default reponse handler"
    end if
end function