sub init()

    m.buttons_list = m.top.findNode("buttons_list")

    m.ExitGroup = m.top.FindNode("ExitGroup")
    m.exitAppButton = m.top.findNode("exitButton")
    m.cancelExitDialogeButton = m.top.findNode("cancelExitButton")
    m.exitAppButton.observeField("buttonSelected", "exitButtonSelect")
    m.cancelExitDialogeButton.observeField("buttonSelected", "cancelExitDialoge")

    menuButtons = [
        { "text": "Fire place Meditation" },
        { "text": "ChristmasFirePlace" },
        { "text": "WaterFall" },
        { "text": "SnowPark" },
        { "text": "SnowForest" },
        { "text": "WaterTank" },
        { "text": "UnderSea" }
    ]

    parentNode = CreateObject("roSGNode", "ContentNode")

    for each data in menuButtons
        menuButtonsData = parentNode.createChild("ContentNode")
        menuButtonsData.title = data.text
    end for
    ?"parent node child count"parentNode.getChildCount()
    m.buttons_list.content = parentNode
    m.top.observeField("focusedChild", "focusChanged")
    m.index = 0
    m.buttons_list.ObserveField("ItemSelected", "onMenuButtonSelected")

    m.buttons_list.setFocus(true)

    m.top.ObserveField("visible", "OnVisibleChange")
  

end sub

sub focusChanged(evt)

    if m.top.isInFocusChain()
        child = evt.getData()
        focusedNode = invalid
        while true
            if(child.focusedChild = invalid or child.isSameNode(child.focusedChild)) then
                focusedNode = child.focusedChild
                exit while
            end if
            child = child.focusedChild
        end while
        end if

end sub

function onMenuButtonSelected(event as object)
    m.index = event.getData()

    actions = [
        "onFireplaceMeditation",
        "onChristmasFirePlace",
        "onWaterFall",
        "onSnowPark",
        "onSnowForest",
        "onWaterTank",
        "onUnderSea"
    ]

    if m.index >= 0 and m.index <= 6
        CallFunction(actions[m.index])
    end if
end function

function CallFunction(funcName as string)
    if funcName = "onFireplaceMeditation" then
        onFireplaceMeditation()
    else if funcName = "onChristmasFirePlace" then
        onChristmasFirePlace()
    else if funcName = "onWaterFall" then
        onWaterFall()
    else if funcName = "onSnowPark" then
        onSnowPark()
    else if funcName = "onSnowForest" then
        onSnowForest()
    else if funcName = "onWaterTank" then
        onWaterTank()
    else if funcName = "onUnderSea" then
        onUnderSea()
    end if
end function

function onFireplaceMeditation()
    ?"FireplaceMeditation selected"
    m.top.getScene().callFunc("ShowFirePlaceScreen")
end function

function onChristmasFirePlace()
    ?"FirePlace selected"

    m.top.getScene().callFunc("ShowChristmasFirePlaceScreen")


end function

function onWaterFall()
    ?"WaterFall selected"
      ' m.top.getScene().callFunc("ShowFirePlaceScreen")
end function

function onSnowPark()
    ?"SnowPark selected"
    '   m.top.getScene().callFunc("ShowFirePlaceScreen")
end function

function onSnowForest()
    ?"SnowForest selected"
    '   m.top.getScene().callFunc("ShowFirePlaceScreen")
end function

function onWaterTank()
    ?"WaterTank selected"
    '   m.top.getScene().callFunc("ShowFirePlaceScreen")
end function

function onUnderSea()
    ?"UnderSea selected"
    '   m.top.getScene().callFunc("ShowFirePlaceScreen")
end function

function cancelExitDialoge()
    m.ExitGroup.visible = false
    m.buttons_list.setFocus(true)

end function

sub exitButtonSelect()
    m.top.getScene().exitApp = true
end sub

sub OnVisibleChange()

    if m.top.visible = true
        ?"OnVisibleChange"
        m.buttons_list.setFocus(true)
    end if
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

        if key = "right"

            if   m.cancelExitDialogeButton.hasFocus()

                m.cancelExitDialogeButton.setFocus(false)
                m.exitAppButton.setFocus(true)

                handled = true

            ' else if m.buttons_list.visible = false

            '     m.buttons_list.visible = true
            '     m.buttons_list.setFocus(true)

            '     handled = true

            end if
        end if

        if key = "left"

            if  m.exitAppButton.hasFocus()

                m.exitAppButton.setFocus(false)
                m.cancelExitDialogeButton.setFocus(true)

                handled = true

            ' else if m.buttons_list.visible = false

            '     m.buttons_list.visible = true
            '     m.buttons_list.setFocus(true)

            '     handled = true

            end if
        end if


    end if
    return handled

end function