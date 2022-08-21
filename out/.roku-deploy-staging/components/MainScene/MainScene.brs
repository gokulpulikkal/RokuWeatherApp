function init() as void
    m.homePage = m.top.findNode("homePage")
    m.homePage.visible = true

    createDummyAPICall()
end function

function createDummyAPICall() as void
    
end function

function dummyRequestHandler(event as object) as void
    data = event.getData()
    if data <> invalid
        print "the reponse is "
    end if
end function