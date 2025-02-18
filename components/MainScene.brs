sub init()

    m.buttons_list = m.top.findNode("buttons_list")
    menuButtons = [
        { "text": "SnowFall" },
        { "text": "FirePlace" },
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
    InitScreenStack()

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

        if focusedNode.isSameNode(m.top)
            m.top.setFocus(false)

            if m.TrialExpiredPopup.visible
                m.buttons_list.setFocus(false)
                m.btnSubscribeinTrialPopup.setFocus(true)
            end if
        end if
    end if
end sub

function onMenuButtonSelected(event as object)
    m.index = event.getData()

    actions = [
        "onSnowFall",
        "onFirePlace",
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
    if funcName = "onSnowFall" then
        onSnowFall()
    else if funcName = "onFirePlace" then
        onFirePlace()
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

function onSnowFall()
    ?"SnowFall selected"
end function

function onFirePlace()
    ?"FirePlace selected"

    m.top.getScene().callFunc("ShowFirePlaceScreen")
    ' ShowFirePlaceScreen()

end function

function onWaterFall()
    ?"WaterFall selected"
end function

function onSnowPark()
    ?"SnowPark selected"
end function

function onSnowForest()
    ?"SnowForest selected"
end function

function onWaterTank()
    ?"WaterTank selected"
end function

function onUnderSea()
    ?"UnderSea selected"
end function


function onKeyEvent(key as string, press as boolean) as boolean

    handled = false

    if press

        if key = "back"

            if m.buttons_list.visible = true


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