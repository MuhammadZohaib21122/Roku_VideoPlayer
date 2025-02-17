function init()
    m.rateUsFlag = "true"
    m.BBGroup = m.top.findNode("BBGroup")
    m.ExitGroup = m.top.FindNode("ExitGroup")
    m.exitAppButton = m.top.findNode("exitButton")
    m.cancelExitDialogeButton = m.top.findNode("cancelExitButton")
    m.exitAppButton.observeField("buttonSelected", "exitButtonSelect")
    m.cancelExitDialogeButton.observeField("buttonSelected", "cancelExitDialoge")
    m.video = m.top.findNode("videoPlayer")
    m.B1 = m.top.findNode("B1")
    m.B1.observeField("buttonSelected", "videoplay1")
    m.B2 = m.top.findNode("B2")
    m.B2.observeField("buttonSelected", "videoplay2")
    m.B3 = m.top.findNode("B3")
    m.B3.observeField("buttonSelected", "videoplay3")
    m.B4 = m.top.findNode("B4")
    m.B4.observeField("buttonSelected", "videoplay4")
    m.B5 = m.top.findNode("B5")
    m.B5.observeField("buttonSelected", "videoplay5")
    m.B6 = m.top.findNode("B6")
    m.B6.observeField("buttonSelected", "videoplay6")
    m.B7 = m.top.findNode("B7")
    m.B7.observeField("buttonSelected", "videoplay7")

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

    m.BBGroup.visible = true
    m.B1.setFocus(true)


    m.lastLoggedSecond = 0

    m.rateUsRegistry = CreateObject("roRegistrySection", "showRateUsPopup")

    if m.rateUsRegistry.Exists("RateusFlag") = false
        m.rateUsRegistry.Write("RateusFlag", "true")

    end if
    ?"flag"m.rateUsFlag


end function

function videoplay1()

    m.video.translation = "[0,0]"
    m.BBGroup.visible = false
    m.video.visible = true
    m.video = m.top.findNode("videoPlayer")
    m.video.content = createObject("roSGNode", "ContentNode")
    m.video.content.url = "https://vz-1a8ceb4a-84a.b-cdn.net/0423eda1-4989-4f4b-9110-dd0b3c843d53/playlist.m3u8"


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

        ?"Video Running seconds: " position
    end if

    if m.lastLoggedSecond = 5 and m.rateUsRegistry.Exists("RateusFlag") then
        m.rateUsFlag = m.rateUsRegistry.Read("RateusFlag")
        ?"Log Rigestry------------->>>>>>>>>>"

        if m.rateUsFlag = "true" then

            ?"Log Rigestry----True--------->>>>>>>>>>"
            m.video.control = "pause"
            m.video.visible = false
            m.B1.setFocus(false)
            m.BBGroup.visible = false
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
    m.B1.setFocus(true)
    m.BBGroup.visible = false
    m.video.visible = true
    m.video.control = "resume"
    m.rateUsFlag = "false"
end function

function videoplay2()

    m.video.translation = "[0,0]"
    m.BBGroup.visible = false
    m.video.visible = true
    m.video = m.top.findNode("videoPlayer")
    m.video.content = createObject("roSGNode", "ContentNode")
    m.video.content.url = "https://vz-1a8ceb4a-84a.b-cdn.net/ddda6950-961a-4e49-9e1d-f514ef0aca39/playlist.m3u8"
    m.video.content.streamFormat = "HLS"
    m.video.control = "play"

    m.video.observeField("duration", "onVideoDuration")
    m.video.observeField("state", "onVideoStateChange")
    m.video.observeField("position", "onVideoPositionChange")
    errorMessage()
    m.video.setFocus(true)

    ?"LL-------------" m.video.control

end function


function videoplay3()

    m.video.translation = "[0,0]"
    m.BBGroup.visible = false
    m.video.visible = true
    m.video = m.top.findNode("videoPlayer")
    m.video.content = createObject("roSGNode", "ContentNode")
    m.video.content.url = "https://vz-1a8ceb4a-84a.b-cdn.net/c54fa081-3299-43d2-8ca5-6cafc4568cb3/playlist.m3u8"
    m.video.content.streamFormat = "HLS"
    m.video.control = "play"

    m.video.observeField("duration", "onVideoDuration")
    m.video.observeField("state", "onVideoStateChange")
    m.video.observeField("position", "onVideoPositionChange")
    errorMessage()
    m.video.setFocus(true)

    ?"LL-------------" m.video.control

end function

function videoplay4()

    m.video.translation = "[0,0]"
    m.BBGroup.visible = false
    m.video.visible = true

    m.video = m.top.findNode("videoPlayer")
    m.video.content = createObject("roSGNode", "ContentNode")
    m.video.content.url = "https://vz-1a8ceb4a-84a.b-cdn.net/83b7b34c-0315-40f1-9fee-6fad26c12a2e/playlist.m3u8"
    m.video.content.streamFormat = "HLS"
    m.video.control = "play"

    m.video.observeField("duration", "onVideoDuration")
    m.video.observeField("state", "onVideoStateChange")
    m.video.observeField("position", "onVideoPositionChange")
    errorMessage()
    m.video.setFocus(true)

    ?"LL-------------" m.video.control
end function

function videoplay5()

    m.video.translation = "[0,0]"
    m.BBGroup.visible = false
    m.video.visible = true

    m.video = m.top.findNode("videoPlayer")
    m.video.content = createObject("roSGNode", "ContentNode")
    m.video.content.url = "https://vz-81c807ed-aaa.b-cdn.net/5cf1aba3-9443-4dad-acdc-9439a26ac166/playlist.m3u8"
    m.video.content.streamFormat = "HLS"
    m.video.control = "play"

    m.video.observeField("duration", "onVideoDuration")
    m.video.observeField("state", "onVideoStateChange")
    m.video.observeField("position", "onVideoPositionChange")
    errorMessage()
    m.video.setFocus(true)

    ?"LL-------------" m.video.control
end function

function videoplay6()

    m.video.translation = "[0,0]"
    m.BBGroup.visible = false
    m.video.visible = true

    m.video = m.top.findNode("videoPlayer")
    m.video.content = createObject("roSGNode", "ContentNode")
    m.video.content.url = "https://vz-5182823f-c24.b-cdn.net/fa9157a7-c955-44b3-a179-8d1c7b93d452/playlist.m3u8"
    m.video.content.streamFormat = "HLS"
    m.video.control = "play"

    m.video.observeField("duration", "onVideoDuration")
    m.video.observeField("state", "onVideoStateChange")
    m.video.observeField("position", "onVideoPositionChange")
    errorMessage()
    m.video.setFocus(true)

    ?"LL-------------" m.video.control
end function

function videoplay7()

    m.video.translation = "[0,0]"
    m.BBGroup.visible = false
    m.video.visible = true

    m.video = m.top.findNode("videoPlayer")
    m.video.content = createObject("roSGNode", "ContentNode")
    m.video.content.url = "https://vz-5182823f-c24.b-cdn.net/3e5d0ad6-6a46-43cb-b541-6a671e1ada6b/playlist.m3u8"
    m.video.content.streamFormat = "HLS"
    m.video.control = "play"

    m.video.observeField("duration", "onVideoDuration")
    m.video.observeField("state", "onVideoStateChange")
    m.video.observeField("position", "onVideoPositionChange")
    errorMessage()
    m.video.setFocus(true)

    ?"LL-------------" m.video.control
end function


function cancelExitDialoge()
    m.ExitGroup.visible = false
    m.B1.setFocus(true)

end function

sub exitButtonSelect()
    m.top.getScene().exitApp = true
end sub


function onKeyEvent(key as string, press as boolean) as boolean

    handled = false

    if press

        if key = "back"

            if m.video.visible = false and m.BBGroup.visible = true

                m.ExitGroup.visible = true
                m.cancelExitDialogeButton.setFocus(true)
                handled = true

            else if m.ExitGroup.visible = true
                m.ExitGroup.visible = false
                m.B1.setFocus(true)
                handled = true

            else if m.video.visible = true and m.BBGroup.visible = true

                m.video.control = "stop"

                m.video.visible = false
                m.BBGroup.visible = true
                m.B1.setFocus(true)
                handled = true

            else if m.video.visible = true


                m.BBGroup.visible = true
                m.B1.setFocus(true)
                handled = true

                ' else if  m.SubscriptionGroup.visible = true

                '     m.SubscriptionGroup.visible = false
                '     m.video.visible = false
                '     m.BBGroup.visible = true
                '     m.B1.setFocus(true)
                '     handled = true

            end if
        end if

        if key = "right" and m.BBGroup.visible = true then

            if m.B1.hasFocus()

                m.B1.setFocus(false)
                m.B2.setFocus(true)


            else if m.B2.hasFocus()

                m.B2.setFocus(false)
                m.B3.setFocus(true)

            else if m.B3.hasFocus()

                m.B3.setFocus(false)
                m.B4.setFocus(true)

            else if m.B4.hasFocus()

                m.B4.setFocus(false)
                m.B5.setFocus(true)

            else if m.B5.hasFocus()

                m.B5.setFocus(false)
                m.B6.setFocus(true)

            else if m.B6.hasFocus()

                m.B6.setFocus(false)
                m.B7.setFocus(true)

            else if m.B7.hasFocus()

                m.B7.setFocus(false)
                m.B1.setFocus(true)

            end if
            handled = true
        end if


        if key = "left" and m.BBGroup.visible = true then

            if m.B1.hasFocus()

                m.B1.setFocus(false)
                m.B7.setFocus(true)


            else if m.B7.hasFocus()

                m.B7.setFocus(false)
                m.B6.setFocus(true)

            else if m.B6.hasFocus()

                m.B6.setFocus(false)
                m.B5.setFocus(true)

            else if m.B5.hasFocus()

                m.B5.setFocus(false)
                m.B4.setFocus(true)

            else if m.B4.hasFocus()

                m.B4.setFocus(false)
                m.B3.setFocus(true)

            else if m.B3.hasFocus()

                m.B3.setFocus(false)
                m.B2.setFocus(true)

            else if m.B2.hasFocus()

                m.B2.setFocus(false)
                m.B1.setFocus(true)

            end if
            handled = true
        end if

        if key = "right" and m.cancelExitDialogeButton.hasFocus()
            m.cancelExitDialogeButton.setFocus(false)
            m.exitAppButton.setFocus(true)

        else if key = "right" and m.closeSubscriptionButton.hasFocus()

            m.closeSubscriptionButton.setFocus(false)
            m.subscribeButton.setFocus(true)


        else if key = "left" and m.exitAppButton.hasFocus()
            m.exitAppButton.setFocus(false)
            m.cancelExitDialogeButton.setFocus(true)

        else if key = "left" and m.subscribeButton.hasFocus()

            m.subscribeButton.setFocus(false)
            m.closeSubscriptionButton.setFocus(true)

        else if key = "down" and m.video.visible = true
            ' m.video.translation = "[0, -100]"
            m.video.setFocus(false)
            m.B1.setFocus(true)
            m.BBGroup.visible = true

        else if key = "down" and m.video.visible = false
            m.BBGroup.visible = true
            m.B1.setFocus(true)

        else if key = "replay" and m.video.visible = true
            m.video.control = "stop"
            m.video.control = "play"

        else if key = "up"  and m.video.visible = true and m.BBGroup.visible = true
            ' m.video.translation = "[0, 0]"
            m.BBGroup.visible = false
            m.video.setFocus(true)
            handled = true
        end if
        handled = true
    end if

    return handled
end function