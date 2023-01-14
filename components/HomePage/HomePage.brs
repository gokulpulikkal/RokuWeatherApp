function init()
    ' ### node identifiers ###
    ' identify the title label
    m.cityNameLabel = m.top.findNode("cityNameLabel")
    m.dateLabel = m.top.findNode("dateLabel")
    m.temperatureLabel = m.top.findNode("temperatureLabel")
    m.climateLabel = m.top.findNode("climateLabel")
    m.weatherInfoPoster = m.top.findNode("weatherInfoPoster")
    m.locationChangeButton = m.top.findNode("locationChangeButton")
    m.splashImagePoster = m.top.findNode("SplashImagePoster")
    m.loadingIndicator = m.top.findNode("loadingIndicator")

    m.timeUpdater = m.top.findNode("timeUpdater")
    m.weatherUpdateTimer = m.top.findNode("weatherUpdateTimer")

    m.feelsLikeLabel = m.top.findNode("feelsLikeLabel")
    m.feelsLikeValueLabel = m.top.findNode("feelsLikeValueLabel")
    m.highestLabel = m.top.findNode("highestLabel")
    m.highestValueLabel = m.top.findNode("highestValueLabel")
    m.lowestLabel = m.top.findNode("lowestLabel")
    m.lowestValueLabel = m.top.findNode("lowestValueLabel")
    m.forecastRowList = m.top.findNode("forecastRowList")

    m.locationSelector = m.top.findNode("locationSelector")

    ' App ID that needed for every API call
    m.APPID = safeString(getValueFromKey("OpenWeatherKey"))

    adjustViews()
    m.dateLabel.text = getCurrentTimeString()

    ' ### node observers ###
    ' observe screen visibility
    m.top.observeField("visible", "onVisible")
    m.timeUpdater.ObserveField("fire", "changeTimerLabel")
    m.weatherUpdateTimer.ObserveField("fire", "onWeatherUpdateTimerFired")
    m.locationChangeButton.ObserveField("buttonSelected", "onLocationChangeButtonSelect")
    m.locationSelector.ObserveField("exitPopup", "closeLocationSelector")
    m.locationSelector.ObserveField("selectedCity", "onCitySelect")
end function

function onVisible(obj)
    visible = obj.getData()
    if (visible)
        getLocationData()
    end if
end function

function adjustViews()
    ' set the text string for the title label - tr() is optional for translating the string to another language
    m.cityNameLabel.text = tr("Bangalore")
    ' set the font size for the title label
    m.cityNameLabel.font.size = 102
    m.dateLabel.font.size = 35
    m.temperatureLabel.font.size = 200
    m.climateLabel.font.size = 50

    m.feelsLikeValueLabel.font.size = 100
    m.highestValueLabel.font.size = 100
    m.lowestValueLabel.font.size = 100

    ' Set the colors
    m.temperatureLabel.color = "#f5054f"
    m.feelsLikeValueLabel.color = "#f5054f"
    m.highestValueLabel.color = "#f5054f"
    m.lowestValueLabel.color = "#f5054f"

    ' Adjust RowList properties
    m.forecastRowList.showRowLabel = [false]
    m.forecastRowList.focusXOffset = [60]
    m.forecastRowList.rowItemSpacing = [[50, 0]]
    m.forecastRowList.itemSize = [1920, 280]
    m.forecastRowList.rowItemSize = [[480, 250]]
    m.forecastRowList.itemSpacing = [0, 40]

    ' LoadingIndicator handling
    centerX = (1920 - m.loadingIndicator.poster.bitmapWidth) / 2
    centerY = (1080 - m.loadingIndicator.poster.bitmapHeight) / 2
    m.loadingIndicator.translation = [ centerX + 450 , centerY + 20 ]

end function

function onLocationChangeButtonSelect()
    m.locationSelector.visible = true
    m.locationSelector.setFocus(true)
end function

function changeTimerLabel() as void
    m.dateLabel.text = getCurrentTimeString()
end function

function setWeatherData(event as object) as void
    weather = event.getData()
    if weather <> invalid
        if IsAssociativeArray(weather.main)
            if weather.main.temp <> invalid
                m.temperatureLabel.text = Fix(weather.main.temp).toStr() + "°C"
            end if

            if weather.main.feels_like <> invalid
                m.feelsLikeValueLabel.text = Fix(weather.main.feels_like).toStr() + "°C"
            end if

            if weather.main.temp_max <> invalid
                m.highestValueLabel.text = Fix(weather.main.temp_max).toStr() + "°C"
            end if

            if weather.main.temp_min <> invalid
                m.lowestValueLabel.text = Fix(weather.main.temp_min).toStr() + "°C"
            end if
        end if

        if IsArray(weather.weather) and weather.weather.count() > 0
            if IsString(weather.weather[0].description)
                m.climateLabel.text = weather.weather[0].description
            end if

            if IsString(weather.weather[0].main)
                m.weatherInfoPoster.uri = Substitute("pkg:/images/PosterAssets/{0}.png", weather.weather[0].main)
            end if
        end if

    end if
end function

function setLocationDetails(locationNode as object) as void
    if locationNode <> invalid
        if IsString(locationNode.name)
            m.cityNameLabel.text = locationNode.name
        end if
    end if
end function

function handleSplashScreen(show = false) as void
    m.splashImagePoster.visible = show
end function

function setForeCastData(event as object) as void
    ' Hiding Splash Image
    handleSplashScreen(false)
    m.loadingIndicator.visible = false

    forecastContentNode = event.getData()
    if forecastContentNode <> invalid
        m.forecastRowList.content = forecastContentNode
        m.forecastRowList.setFocus(true)

        ' Set the timer to for refreshing the forecast rowList
        startTimerForRefreshingWeatherData(forecastContentNode)
    end if
end function

function startTimerForRefreshingWeatherData(forecastDataNode as object) as void
    if isSGNode(forecastDataNode) AND forecastDataNode.getChildCount() >= 1
        rowData = forecastDataNode.getChild(0)
        if rowData.getChildCount() > 0
            firstItem = rowData.getChild(0)
            currentTime = getCurrentTimeInSec()
            nextNearestForeCastData = firstItem.timeInSec
            m.weatherUpdateTimer.duration = Int(nextNearestForeCastData - currentTime)
            m.weatherUpdateTimer.control = "start"
        end if
    end if
end function

function onWeatherUpdateTimerFired() as void
    getLocationData()
end function

function closeLocationSelector()
    m.locationSelector.visible = false
    m.locationChangeButton.setFocus(true)
end function

' capture key events from remote control
function onKeyEvent(key as string, press as boolean) as boolean
    if (press)
        returnVal = false
        if (key = "back")
            if m.locationSelector.visible = true
                closeLocationSelector()
                returnVal = true
            end if
        end if

        if (key = "up")
            if m.forecastRowList.hasFocus()
                m.forecastRowList.setFocus(false)
                m.locationChangeButton.setFocus(true)
                returnVal = true
            end if
        end if

        if (key = "down")
            if m.locationChangeButton.hasFocus()
                m.forecastRowList.setFocus(true)
                returnVal = true
            end if
        end if
        return returnVal
    end if
    return false
end function