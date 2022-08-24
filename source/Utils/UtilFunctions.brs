
function getCurrentTimeInSec() as longInteger
    dateObject = CreateObject("roDateTime")
    dateObject.toLocalTime()
    return dateObject.AsSeconds()
end function