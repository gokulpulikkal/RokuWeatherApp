function init()
    m.miniKeyboard = m.top.findNode("miniKeyboard")
    m.dialogBackgroundPoster = m.top.findNode("dialogBackgroundPoster")
    m.popupTitleLabel = m.top.findNode("popupTitleLabel")
    m.cityList = m.top.findNode("cityList")

    setTranslations()
    
    m.top.observeField("visible", "onVisible")
    m.top.observeField("focusedChild", "onFocusChildChange")
    m.miniKeyboard.observeField("text", "onKeyboardTextChange")
    m.cityList.observeField("itemSelected", "onCitySelect")

end function

function onFocusChildChange() as void
    if m.top.hasFocus()
        m.miniKeyboard.setFocus(true)
    end if
end function

function onVisible(obj)
    visible = obj.getData()
    if (visible)
        
    end if
end function

function setTranslations() as void
    ' Mini Keyboard
    miniKeyboardBoundingRect = m.miniKeyboard.boundingRect()
    miniKeyboardTextBoxBRect = m.miniKeyboard.textEditBox.boundingRect()
    dialogBackgroundPosterBRect = m.dialogBackgroundPoster.boundingRect()

    m.popupTitleLabel.translation = [120, 80]

    m.miniKeyboard.translation = [120, 80 + (dialogBackgroundPosterBRect.height/2)-(miniKeyboardBoundingRect.height/2)-miniKeyboardTextBoxBRect.height]
    m.miniKeyboard.textEditBox.translation = [ m.miniKeyboard.translation[0] + miniKeyboardBoundingRect.width + 20, m.miniKeyboard.translation[1] - 50]

    m.cityList.translation = [ m.miniKeyboard.translation[0] + miniKeyboardBoundingRect.width + 170, m.miniKeyboard.translation[1] + miniKeyboardTextBoxBRect.height + 100]
end function

function onKeyboardTextChange(event) as void
    text = event.getData()
    if IsString(text) AND Len(text) > 3
        getLocations(text)
    end if
end function

function setCityListData(event as object) as void
    cityListNode = event.getData()

    if cityListNode <> invalid
        m.cityList.content = cityListNode
    end if
end function

function onCitySelect(event as object) as object
    if event <> invalid
        itemSelectIndex = event.getData()
        if IsInteger(itemSelectIndex) AND m.cityList.content <> invalid
            if m.cityList.content.getChild(itemSelectIndex) <> invalid
                m.top.selectedCity = m.cityList.content.getChild(itemSelectIndex)
                m.top.exitPopup = true
            end if
        end if
    end if
end function

' capture key events from remote control
function onKeyEvent(key as string, press as boolean) as boolean
    if (press)
        returnVal = false
        if (key = "back")
        end if

        if (key = "up")
            if m.miniKeyboard.isInFocusChain() AND m.cityList.content <> invalid AND m.cityList.content.getChildCount() > 0
                m.cityList.setFocus(true)
            end if
        end if

        if (key = "down")
            if m.miniKeyboard.isInFocusChain() AND m.cityList.content <> invalid AND m.cityList.content.getChildCount() > 0
                m.cityList.setFocus(true)
            end if
        end if

        if (key = "right")
            if m.miniKeyboard.isInFocusChain() AND m.cityList.content <> invalid AND m.cityList.content.getChildCount() > 0
                m.cityList.setFocus(true)
            end if
        end if

        if (key = "left")
            if m.cityList.hasFocus()
                m.miniKeyboard.setFocus(true)
            end if
        end if
        return returnVal
    end if
    return false
end function