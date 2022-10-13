
function init()
    m.backgroundRect = m.top.findNode("backgroundRect")
    m.timeLabel = m.top.findNode("timeLabel")
    m.weatherConditionLabel = m.top.findNode("weatherConditionLabel")
    m.highestTempLabel = m.top.findNode("highestTempLabel")
    m.lowestTempLabel = m.top.findNode("lowestTempLabel")
    m.weatherInfoPoster = m.top.findNode("weatherInfoPoster")

    AdjustLabelFonts()
end function

function AdjustLabelFonts() as void
    m.timeLabel.font.size = 27
    m.weatherConditionLabel.font.size = 35
    m.highestTempLabel.font.size = 36
    m.lowestTempLabel.font.size = 36
end function

function showContent() as void
    itemContent = m.top.itemContent
    if itemContent <> invalid

        if IsString(itemContent.time)
            m.timeLabel.text = itemContent.time
        end if

        if IsString(itemContent.weatherDescription)
            m.weatherConditionLabel.text = itemContent.weatherDescription
        end if

        if IsString(itemContent.main)
            m.weatherInfoPoster.uri = Substitute("pkg:/images/PosterAssets/{0}.png", itemContent.main)
        end if

        if itemContent.tempMax <> invalid
            m.highestTempLabel.text = "H: " + Fix(itemContent.tempMax).toStr() + "°C"
        end if

        if itemContent.tempMax <> invalid
            m.lowestTempLabel.text = "L: " + Fix(itemContent.tempMin).toStr() + "°C"
        end if

    end if
end function

function showFocus() as void
    scale = 1 + (m.top.focusPercent * 0.08)
    m.backgroundRect.scale = [scale, scale]
end function

function showRowFocus() as void
    if NOT m.top.rowListHasFocus
        m.backgroundRect.scale = [1, 1]
    else
        showFocus()
    end if
end function