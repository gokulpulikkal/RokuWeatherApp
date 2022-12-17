
function getCurrentTimeInSec() as longInteger
    dateObject = CreateObject("roDateTime")
    dateObject.toLocalTime()
    return dateObject.AsSeconds()
end function

function getValueFromKey(key)
    value = invalid
    if NOT IsAssociativeArray(m.appConfig)
        m.appConfig = getAppConfig()
    end if
    if IsString(key)
        value = m.appConfig.lookup(key)
    end if
    return value
end function

function getAppConfig() as object
    if m.appConfig = invalid
        m.appConfig = ParseJson(safeString(ReadAsciiFile("pkg:/components/AppConfigFiles/appConfig.json")))
        m.global.update({
            "appConfig": m.appConfig
        }, true)
        return m.appConfig
    end if
    return m.appConfig
end function

' *********************************
' Safe checks Utils
' *********************************
function safeString(input as object, default="") as string
    if IsString(input)
        return input
    else
        return default
    end if
end function