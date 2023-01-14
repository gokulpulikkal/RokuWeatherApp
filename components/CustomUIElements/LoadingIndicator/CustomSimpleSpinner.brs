function init()
    m.top.poster.uri = m.top.posterURI
end function

function onPosterPropertyChange()
    m.top.poster.uri = m.top.posterURI
    if IsString(m.top.posterBlendColor)
        m.top.poster.blendColor = m.top.posterBlendColor
    end if
end function