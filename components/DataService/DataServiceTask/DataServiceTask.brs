function init()
	m.port = createObject("roMessagePort")
	m.top.functionName="getDataFromServer"
end function

function getDataFromServer()
	requestObject = createUrlObject(m.top.uri)
    requestObject.RetainBodyOnError(true)
	requestObject.setMessagePort(m.port)

	if (UCase(m.top.requestType)="GET") then
		urlResponse = requestObject.AsyncGetToString()
	else
        requestObject.RetainBodyOnError(true)
        urlResponse = requestObject.AsyncPostFromString(m.top.param)
	end if
	processReqest(urlResponse)
end function

function processReqest(urlResponse)
    if(urlResponse = true)
        while true
            msg = wait(0, m.port)
            messageType = type(msg)
            if messageType <> "roUrlEvent" or (messageType = "roUrlEvent" and msg.GetResponseCode() < 0)
                print "Some Error in network call"
                exit while
            else if messageType = "roUrlEvent"
                content = msg.GetString()
                if content <> invalid
                    m.top.content = content
                end if
                exit while
            end if
        end while
    end if
end function


function createUrlObject(urlString as string) as dynamic
    urlObject = invalid
    urlObject = CreateObject("roUrlTransfer")
    urlObject.SetUrl(urlString)

    useSecureConnection = secureConnectionUsed(urlString)

    if useSecureConnection = true
        urlObject.SetCertificatesFile("common:/certs/ca-bundle.crt")
        urlObject.AddHeader("X-Roku-Reserved-Dev-Id", "")
        urlObject.InitClientCertificates()
    end if

    return urlObject
end function

function secureConnectionUsed(urlString as string) as boolean
    secureConnection = false
    urlStringTokens = []

    urlStringObj = CreateObject("roString")
    urlStringObj.SetString(urlString)

    urlStringTokens = urlStringObj.Tokenize("://")

    if urlStringTokens.Count() > 0
        if urlStringTokens[0] = "https"
            secureConnection = true
        end if
    end if

    return secureConnection
end function
