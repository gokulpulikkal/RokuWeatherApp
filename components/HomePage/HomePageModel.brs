
function getCurrentWeatherData() as void
    requestObject = {}
    requestObject.uri = "https://api.openweathermap.org/data/2.5/weather?lat=12.9767936&lon=77.590082&appid=93fc112871e2f24aba37f420bf035e68&units=metric"
    sendRequest(requestObject, "onCurrentWeatherDataResponse")
end function

function onCurrentWeatherDataResponse(event as object) as void
    response = event.getData()
    if response <> invalid
        responseAssocArray = ParseJson(response)
        if responseAssocArray <> invalid
            setWeatherData(responseAssocArray)
        end if
    end if
end function

'''''''''
' getCurrentTimeString: Function will return current time string on the format "Mon 29 September 12:00AM"
'
' @return {dynamic} time string
'''''''''
function getCurrentTimeString()
    dateObject = CreateObject("roDateTime")
    timeString = ""
    day = Left(dateObject.GetWeekday(), 3)
    timeString += (day + ", ")
    timeString += (getMonthString(dateObject) + " ")
    timeString += (dateObject.GetDayOfMonth().toStr() + " ")
    timeString += (getTimeStringFromSeconds(dateObject.AsSeconds()) + " ")
    return timeString
end function

function getMonthString(dateObject)
    if dateObject <> invalid
        months = ["January", "Febraury", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        month = dateObject.GetMonth()
        return months[month - 1]
    end if
end function

function getTimeStringFromSeconds(seconds)
    if seconds <> invalid and seconds > 0
        date = CreateObject("roDateTime")
        date.FromSeconds(seconds)
        date.ToLocalTime()
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