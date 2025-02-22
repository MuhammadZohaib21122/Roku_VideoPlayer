function init()
    m.rateUsFlag = "true"
    m.lastLoggedSecond = 0
    m.video = m.top.findNode("videoPlayer")
    m.PreSubscriptionGroup = m.top.findNode("PreSubscriptionGroup")
    m.GoTOSubscriptionBTN = m.top.findNode("GoTOSubscriptionBTN")
    m.GoTOSubscriptionBTN.observeField("buttonSelected", "gotoSubscribe")

    m.SubscriptionGroup = m.top.findNode("SubscriptionGroup")
    m.closeSubscriptionButton = m.top.findNode("closeSubscriptionButton")
    m.subscribeButton = m.top.findNode("subscribeButton")
    m.subscribeButton.observeField("buttonSelected", "onClickSubscribeButton")
    m.closeSubscriptionButton.observeField("buttonSelected", "onClickSubscribeCancelButton")


    m.SubscriptionDoneGroup = m.top.findNode("SubscriptionDoneGroup")
    m.closeSubscriptionDoneButton = m.top.findNode("closeSubscriptionDoneButton")
    m.closeSubscriptionDoneButton.observeField("buttonSelected", "onSubscribeDoneButton")

   
    m.rateUsRegistry = CreateObject("roRegistrySection", "showRateUsPopup")
    if m.rateUsRegistry.Exists("RateusFlag") = false
        m.rateUsRegistry.Write("RateusFlag", "true")
    end if
    ?"flag"m.rateUsFlag


    m.buttons_list = m.top.findNode("buttons_list")
    menuButtons = [
        { "text": "WinterWarmth" },
        { "text": "FireLounge" },
        { "text": "MerryChristmas" },
        { "text": "MeditateInFire" },
        { "text": "HappyWinters" },
        { "text": "GlimmeringHolidays" },
        { "text": "SnowyChristmas" }
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

end function

function onMenuButtonSelected(event as object)
    m.index = event.getData()

    actions = [
        "onWinterWarmth",
        "onFireLounge",
        "onMerryChristmas",
        "onMeditateInFire",
        "onHappyWinters",
        "onGlimmeringHolidays",
        "SnowyChristmas"
    ]

    if m.index >= 0 and m.index <= 6
        CallFunction(actions[m.index])
    end if
end function

function CallFunction(funcName as string)
    if funcName = "onWinterWarmth" then
        FPV1()
    else if funcName = "onFireLounge" then
        FPV2()
    else if funcName = "onMerryChristmas" then
        FPV3()
    else if funcName = "onMeditateInFire" then
        FPV4()
    else if funcName = "onHappyWinters" then
        FPV5()
    else if funcName = "onGlimmeringHolidays" then
        FPV6()
    else if funcName = "SnowyChristmas" then
        FPV7()
    end if
end function

function FPV1()

    m.video.translation = "[0,0]"
    m.buttons_list.visible = false
    m.video.visible = true
    m.video = m.top.findNode("videoPlayer")
    m.video.content = createObject("roSGNode", "ContentNode")
    m.video.content.url = "https://vz-7e9bbf26-f4b.b-cdn.net/38087a24-8728-43de-afee-6a4969fb56f6/playlist.m3u8"


    m.video.content.streamFormat = "HLS"
    m.video.control = "play"
    ' m.video.setFocus(true)

    m.video.observeField("duration", "onVideoDuration")
    m.video.observeField("state", "onVideoStateChange")
    m.video.observeField("position", "onVideoPositionChange")
    errorMessage()
    m.video.setFocus(true)



    ?"LL-------------" m.video.control
end function

sub onVideoDuration(event as object)

    m.duration = event.getData()
    ?"Video Duration: "m.duration

end sub
sub onVideoPositionChange(event as object)

    position = event.getData()
    position = int(position)
    if position <= m.duration

        m.lastLoggedSecond = position
        ?"flag2"m.rateUsFlag

        ?"Video Running seconds: " position
    end if

    if m.lastLoggedSecond = 5 and m.rateUsRegistry.Exists("RateusFlag") then
        ' m.rateUsFlag = m.rateUsRegistry.Read("RateusFlag")
        ?"flag3"m.rateUsFlag
        ?"Log Rigestry------------->>>>>>>>>>"

        if m.rateUsFlag = "true" then

            ?"Log Rigestry----True--------->>>>>>>>>>"
            m.video.control = "pause"
            m.video.visible = false
            m.video.setFocus(false)
            m.buttons_list.visible = false
            m.PreSubscriptionGroup.visible = true
            m.GoTOSubscriptionBTN.setFocus(true)
            m.rateUsRegistry.Write("RateusFlag", "false")
        end if
    end if
end sub
sub errorMessage()

    ?"errorCode => " m.video.errorCode
    ?"errorMsg => " m.video.errorMsg
    ?"errorStr => " m.video.errorStr
    ?"errorInfo => " m.video.errorInfo

end sub

' sub videoForward()
'     newPosition = m.lastLoggedSecond + 200
'     if newPosition > m.duration then newPosition = m.duration
'     m.video.seek = newPosition
'     ?"Video Forwarded to: " newPosition
' end sub


' sub videoRewind()
'     newPosition = m.lastLoggedSecond - 10
'     if newPosition < 0 then newPosition = 0
'     m.video.seek = newPosition
'     ?"Video Rewinded to: " newPosition
' end sub

sub onVideoStateChange(event as object)
    state = event.getData()
    ?"Video State: " state


    if state = "finished"
        ?"Restarting video..."
        m.video.control = "stop"
        m.video.control = "play"
    end if
end sub

function gotoSubscribe()
    m.PreSubscriptionGroup.visible = false
    m.SubscriptionGroup.visible = true
    m.subscribeButton.setFocus(true)
end function

function onClickSubscribeButton()
    m.SubscriptionGroup.visible = false
    m.SubscriptionDoneGroup.visible = true
    m.closeSubscriptionDoneButton.setFocus(true)
end function

function onClickSubscribeCancelButton()
    m.SubscriptionGroup.visible = false
    m.PreSubscriptionGroup.visible = true
    m.GoTOSubscriptionBTN.setFocus(true)
end function

function onSubscribeDoneButton()

    m.SubscriptionDoneGroup.visible = false
    m.buttons_list.visible = false
    m.video.visible = true
    m.video.setFocus(true)
    m.video.control = "resume"
    m.rateUsFlag = "false"
end function

function FPV2()

    m.video.translation = "[0,0]"
    m.buttons_list.visible = false
    m.video.visible = true
    m.video = m.top.findNode("videoPlayer")
    m.video.content = createObject("roSGNode", "ContentNode")
    m.video.content.url = "https://vz-7e9bbf26-f4b.b-cdn.net/09801a23-0968-437b-a4cb-9b7e35bacc4e/playlist.m3u8"
    m.video.content.streamFormat = "HLS"
    m.video.control = "play"

    m.video.observeField("duration", "onVideoDuration")
    m.video.observeField("state", "onVideoStateChange")
    m.video.observeField("position", "onVideoPositionChange")
    errorMessage()
    m.video.setFocus(true)

    ?"LL-------------" m.video.control

end function


function FPV3()

    m.video.translation = "[0,0]"
    m.buttons_list.visible = false
    m.video.visible = true
    m.video = m.top.findNode("videoPlayer")
    m.video.content = createObject("roSGNode", "ContentNode")
    m.video.content.url = "https://vz-7e9bbf26-f4b.b-cdn.net/b2aa2ae1-6d99-4cdf-81f0-f4cb2c950ed4/playlist.m3u8"
    m.video.content.streamFormat = "HLS"
    m.video.control = "play"

    m.video.observeField("duration", "onVideoDuration")
    m.video.observeField("state", "onVideoStateChange")
    m.video.observeField("position", "onVideoPositionChange")
    errorMessage()
    m.video.setFocus(true)

    ?"LL-------------" m.video.control

end function

function FPV4()

    m.video.translation = "[0,0]"
    m.buttons_list.visible = false
    m.video.visible = true

    m.video = m.top.findNode("videoPlayer")
    m.video.content = createObject("roSGNode", "ContentNode")
    m.video.content.url = "https://vz-7e9bbf26-f4b.b-cdn.net/13e577e9-bac7-4e46-97ac-c2869c278b87/playlist.m3u8"
    m.video.content.streamFormat = "HLS"
    m.video.control = "play"

    m.video.observeField("duration", "onVideoDuration")
    m.video.observeField("state", "onVideoStateChange")
    m.video.observeField("position", "onVideoPositionChange")
    errorMessage()
    m.video.setFocus(true)

    ?"LL-------------" m.video.control
end function

function FPV5()

    m.video.translation = "[0,0]"
    m.buttons_list.visible = false
    m.video.visible = true
    m.video = m.top.findNode("videoPlayer")
    m.video.content = createObject("roSGNode", "ContentNode")
    m.video.content.url = "https://vz-7e9bbf26-f4b.b-cdn.net/9f97a45d-425f-4be0-be23-1bc9124181cf/playlist.m3u8"
    m.video.content.streamFormat = "HLS"
    m.video.control = "play"

    m.video.observeField("duration", "onVideoDuration")
    m.video.observeField("state", "onVideoStateChange")
    m.video.observeField("position", "onVideoPositionChange")
    errorMessage()
    m.video.setFocus(true)

    ?"LL-------------" m.video.control
end function

function FPV6()

    m.video.translation = "[0,0]"
    m.buttons_list.visible = false
    m.video.visible = true
    m.video = m.top.findNode("videoPlayer")
    m.video.content = createObject("roSGNode", "ContentNode")
    m.video.content.url = "https://vz-7e9bbf26-f4b.b-cdn.net/1cdc485e-dbdc-4406-a59a-acd42cdfc3f1/playlist.m3u8"
    m.video.content.streamFormat = "HLS"
    m.video.control = "play"
    m.video.observeField("duration", "onVideoDuration")
    m.video.observeField("state", "onVideoStateChange")
    m.video.observeField("position", "onVideoPositionChange")
    errorMessage()
    m.video.setFocus(true)

    ?"LL-------------" m.video.control
end function

function FPV7()

    m.video.translation = "[0,0]"
    m.buttons_list.visible = false
    m.video.visible = true
    m.video = m.top.findNode("videoPlayer")
    m.video.content = createObject("roSGNode", "ContentNode")
    m.video.content.url = "https://vz-7e9bbf26-f4b.b-cdn.net/e81444fd-08c4-492b-bd57-a81e8a958997/playlist.m3u8"
    m.video.content.streamFormat = "HLS"
    m.video.control = "play"
    m.video.observeField("duration", "onVideoDuration")
    m.video.observeField("state", "onVideoStateChange")
    m.video.observeField("position", "onVideoPositionChange")
    errorMessage()
    m.video.setFocus(true)

    ?"LL-------------" m.video.control
end function

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


function onKeyEvent(key as string, press as boolean) as boolean

    handled = false

    if press

        if key = "back"

            if m.video.visible = false and m.buttons_list.visible = true

                m.top.getScene().callFunc("CloseScreen", invalid)
               
                handled = true



            else if m.video.visible = true and m.buttons_list.visible = true

                m.video.control = "stop"

                m.video.visible = false
                m.buttons_list.visible = true
                m.buttons_list.setFocus(true)
                handled = true

            else if m.video.visible = true


                m.buttons_list.visible = true
                m.buttons_list.setFocus(true)
                handled = true

            end if
        end if

        if key = "right" and m.video.visible = true and m.buttons_list.visible = true then

            m.buttons_list.visible = false
            m.video.setFocus(true)

            ' if m.B1.hasFocus()

            '     m.B1.setFocus(false)
            '     m.B2.setFocus(true)

            ' end if
            handled = true
        end if

        if key = "right" and m.closeSubscriptionButton.hasFocus()

            m.closeSubscriptionButton.setFocus(false)
            m.subscribeButton.setFocus(true)

        else if key = "left" and m.subscribeButton.hasFocus()

            m.subscribeButton.setFocus(false)
            m.closeSubscriptionButton.setFocus(true)

        else if key = "replay" and m.video.visible = true
            m.video.control = "stop"
            m.video.control = "play"

            handled = true
        end if
        handled = true
    end if

    return handled
end function