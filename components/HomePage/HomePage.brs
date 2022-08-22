sub init()
    ' ### node identifiers ###
    ' identify the title label
    m.timeUpdater = m.top.findNode("timeUpdater")
    m.cityNameLabel = m.top.findNode("cityNameLabel")
    m.dateLabel = m.top.findNode("dateLabel")
    m.temperatureLabel = m.top.findNode("temperatureLabel")
    m.climateLabel = m.top.findNode("climateLabel")

    m.feelsLikeLabel = m.top.findNode("feelsLikeLabel")
    m.feelsLikeValueLabel = m.top.findNode("feelsLikeValueLabel")
    m.highestLabel = m.top.findNode("highestLabel")
    m.highestValueLabel = m.top.findNode("highestValueLabel")
    m.lowestLabel = m.top.findNode("lowestLabel")
    m.lowestValueLabel = m.top.findNode("lowestValueLabel")

    adjustViews()
    m.dateLabel.text = getCurrentTimeString()

    ' ### node observers ###
    ' observe screen visibility
    m.top.observeField("visible", "onVisible")
    m.timeUpdater.ObserveField("fire", "changeTimerLabel")
end sub

sub onVisible(obj)
    visible = obj.getData()
    if (visible)
        getCurrentWeatherData()
    end if
end sub

sub adjustViews()
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
end sub

function changeTimerLabel() as void
    m.dateLabel.text = getCurrentTimeString()
end function

function setWeatherData(weather as object) as void
    if weather <> invalid
        if IsAssociativeArray(weather.main) and weather.main.temp <> invalid
            m.temperatureLabel.text = Fix(weather.main.temp).toStr() + "°C"
        end if

        if IsArray(weather.weather) and weather.weather.count() > 0 and IsString(weather.weather[0].description)
            m.climateLabel.text = weather.weather[0].description
        end if

    end if
end function


' capture key events from remote control
function onKeyEvent(key as string, press as boolean) as boolean
    if (press)
        if (key = "back")
            ? "back key pressed"
            return false
        end if

        if (key = "up")
            ? "up key pressed"
            return true
        end if

        if (key = "down")
            ? "down key pressed"
            return true
        end if
    end if
    return false
end function