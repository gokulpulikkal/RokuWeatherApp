
function getLocations(str as string) as void
    requestObject = {}
    requestObject.uri = "https://wft-geo-db.p.rapidapi.com/v1/geo/cities?namePrefix=" + str
    apiKey = safeString(getValueFromKey("locationsAPIKey"))
    header = {
        "X-RapidAPI-Key": apiKey
    }
    requestObject.header = header
    sendSearchRequest(requestObject, "onLocationsResponse")
end function

function onLocationsResponse(event as object)
    response = event.getData()
    if response <> invalid
        responseAssocArray = ParseJson(response)
        if IsAssociativeArray(responseAssocArray)
            createListData(responseAssocArray)
        end if
    end if
end function

function createListData(listData as object) as void
    if IsAssociativeArray(listData) AND IsArray(listData.data)
        contentNode = createObject("roSGNode", "contentNode")
        for each item in listData.data
            childNode = contentNode.createChild("contentNode")
            childNode.update(item, true)
            if (IsString(item.city))
                childNode.title = item.city
            end if
        end for
        m.top.listData = contentNode
    end if
end function