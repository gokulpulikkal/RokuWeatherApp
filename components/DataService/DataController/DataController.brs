

function sendRequest(requestObject as object, handler="defaultResponseHandler") as void
    dataTask = CreateObject("roSGNode", "DataServiceTask")
    dataTask.update(requestObject, true)
    dataTask.observeField("content", handler)
    dataTask.control = "RUN"

end function

function defaultResponseHandler(event as object) as void
    data = event.getData()
    if data <> invalid
        print "Response is in default reponse handler"
    end if
end function

function sendSearchRequest(requestObject as object, handler="defaultResponseHandler")
    if m.global.SearchTask <> invalid
        ' Stopping running thread, if any
        m.global.SearchTask.control = "STOP"
    end if

    searchTask = CreateObject("roSGNode", "DataServiceTask")
    m.global.update({"searchTask": searchTask}, true)

    searchTask.update(requestObject, true)
    searchTask.observeField("content", handler)
    searchTask.control = "RUN"

end function