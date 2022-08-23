
sub init()
    m.backgroundRect = m.top.findNode("backgroundRect")
end sub

sub showContent()
    itemContent = m.top.itemContent
end sub

sub showFocus()
    scale = 1 + (m.top.focusPercent * 0.08)
    m.backgroundRect.scale = [scale, scale]
end sub

sub showRowFocus()
end sub