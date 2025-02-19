sub init()

   
    InitScreenStack()
    m.top.getScene().callFunc("ShowFirstScreen")
end sub


function onKeyEvent(key as string, press as boolean) as boolean

    handled = false

    if press

        if key = "back"

            if m.buttons_list.visible = true

                m.ExitGroup.visible = true
                m.cancelExitDialogeButton.setFocus(true)

                handled = true

            else if m.buttons_list.visible = false

                m.buttons_list.visible = true
                m.buttons_list.setFocus(true)

                handled = true

            end if
        end if
    end if
    return handled

end function