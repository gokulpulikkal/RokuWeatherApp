function getLocationData()
    locationData = readFromRegistry("locationDetails")
    if IsString(locationData) AND locationData <> ""
        locationNode = ParseJson(locationData)
        getDataForLocationNode(locationNode)
    else
        handleSplashScreen(false)
        onLocationChangeButtonSelect()
    end if

end function

function onCitySelect(event as object) as void
    if event <> invalid AND event.getData() <> invalid
        locationNode = event.getData()
        getDataForLocationNode(locationNode)
    end if
end function

function getDataForLocationNode(locationNode)
    ' Clear all the current data
    ' Get new location data
    if locationNode <> invalid AND locationNode.latitude <> invalid AND locationNode.longitude <> invalid
        getCurrentWeatherData(locationNode.longitude, locationNode.latitude)
        getForeCastData(locationNode.longitude, locationNode.latitude)
        setLocationDetails(locationNode)

        ' Storing the location details to registry
        if isSGNode(locationNode)
            locationNodeAA = locationNode.getFields()
        else
            locationNodeAA = locationNode
        end if
        
        if IsAssociativeArray(locationNodeAA)
            writeToRegistry("locationDetails", FormatJson(locationNodeAA))
        end if
    end if
end function

function getCurrentWeatherData(lon = 77.590082, lat = 12.9767936) as void
    requestObject = {}
    requestObject.uri = "https://api.openweathermap.org/data/2.5/weather?lat="+ lat.toStr() +"&lon="+ lon.toStr() +"&units=metric&appid=" + m.APPID
    sendRequest(requestObject, "onCurrentWeatherDataResponse")
end function

function onCurrentWeatherDataResponse(event as object) as void
    response = event.getData()
    if response <> invalid
        responseAssocArray = ParseJson(response)
        if responseAssocArray <> invalid
            m.top.currentWeatherData = responseAssocArray
        end if
    end if
end function

function getForeCastData(lon = 77.590082, lat = 12.9767936) as void
    requestObject = {}
    requestObject.uri = "https://api.openweathermap.org/data/2.5/forecast?lat="+ lat.toStr() +"&lon="+ lon.toStr() +"&units=metric&appid=" + m.APPID
    sendRequest(requestObject, "onForecastDataResponse")
end function

function onForecastDataResponse(event as object)
    response = event.getData()
    if response <> invalid
        responseAssocArray = ParseJson(response)
        if responseAssocArray <> invalid
            createForecastRowListContent(responseAssocArray)
        end if
    end if
end function

function createForecastRowListContent(apiResponse as object) as void
    if NOT IsAssociativeArray(apiResponse) AND IsArray(apiResponse.list) AND apiResponse.list.count() > 0 return

    currentTimeInSec = getCurrentTimeInSec()

    rowListContentNode = CreateObject("roSGNode", "ContentNode")

    ' Since only one Row is there
    forecastRow = rowListContentNode.createChild("ContentNode")

    for each item in apiResponse.list
        if item.dt <> invalid AND item.dt > currentTimeInSec

            forecastRowItem = forecastRow.createChild("ContentNode")
            dateObject = CreateObject("roDateTime")
            dateObject.FromSeconds(item.dt)

            forecastDetails = {
                "time": Left(dateObject.GetWeekday(), 3) + ", " + getTimeStringFromSeconds(item.dt),
                "timeInSec": item.dt
            }

            if IsArray(item.weather) AND item.weather.count() > 0
                forecastDetails.weatherDescription = item.weather[0].description
                forecastDetails.main = item.weather[0].main
            end if

            if IsAssociativeArray(item.main)
                forecastDetails.tempMax = item.main.temp_max
                forecastDetails.tempMin = item.main.temp_min
            end if

            forecastRowItem.update(forecastDetails, true)
        end if
    end for
    
    m.top.weatherForecastData = rowListContentNode
end function

'''''''''
' getCurrentTimeString: Function will return current time string on the format "Mon 29 September 12:00AM"
'
' @return {dynamic} time string
'''''''''
function getCurrentTimeString() as string
    dateObject = CreateObject("roDateTime")
    dateObject.toLocalTime()
    timeString = ""
    day = Left(dateObject.GetWeekday(), 3)
    timeString += (day + ", ")
    timeString += (getMonthString(dateObject) + " ")
    timeString += (dateObject.GetDayOfMonth().toStr() + " ")
    timeString += (getTimeStringFromSeconds(dateObject.AsSeconds()) + " ")
    return timeString
end function

function getMonthString(dateObject) as string
    if dateObject <> invalid
        months = ["January", "Febraury", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        month = dateObject.GetMonth()
        return months[month - 1]
    end if
end function

function getTimeStringFromSeconds(seconds) as string
    if seconds <> invalid and seconds > 0
        date = CreateObject("roDateTime")
        date.FromSeconds(seconds)
        hours = date.GetHours()
        endString = " AM"
        if hours >= 12
            endString = " PM"
            reminder = hours MOD 12
            if reminder = 0
                hours = 12
            else
                hours = reminder
            end if
        else if hours = 0 ' 24 hours case
            hours = 12
        end if
        minutes = date.GetMinutes().toStr()
        if minutes.len() < 2
            minutes = "0" + minutes
        end if
        return hours.toStr() + ":" + minutes + endString
    end if
end function