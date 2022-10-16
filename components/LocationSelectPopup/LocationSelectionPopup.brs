function init()
    m.miniKeyboard = m.top.findNode("miniKeyboard")
    m.dialogBackgroundPoster = m.top.findNode("dialogBackgroundPoster")
    m.popupTitleLabel = m.top.findNode("popupTitleLabel")

    setTranslations()
    
    m.top.observeField("visible", "onVisible")
    m.top.observeField("focusedChild", "onFocusChildChange")
    m.miniKeyboard.observeField("text", "onKeyboardTextChange")

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
end function

function onKeyboardTextChange(event) as void
    text = event.getData()
    if IsString(text)
        
    end if
end function