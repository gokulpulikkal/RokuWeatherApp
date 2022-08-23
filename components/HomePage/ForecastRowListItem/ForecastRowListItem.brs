
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
end function

function showFocus() as void
    scale = 1 + (m.top.focusPercent * 0.08)
    m.backgroundRect.scale = [scale, scale]
end function

function showRowFocus() as void
end function