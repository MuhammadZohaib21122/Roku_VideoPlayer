sub Main(args as object)
    showChannelSGScreen(args)
end sub

sub showChannelSGScreen(args as object)


    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    m.scene = CreateObject("roInput")
    screen.setMessagePort(m.port)

    m.scene = screen.CreateScene("MainScene")
    screen.show()

    m.scene.launchArgs = args
    ?"m.scene.launchArgs  " m.scene.launchArgs 
    ?"========================> " args
    inputObject = createobject("roInput")
    inputObject.setmessageport(m.port)

    m.scene.observeField("exitApp", m.port)

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)

        if msgType = "roSGScreenEvent"
            if msg.IsScreenClosed() then return

        else if msgType = "roSGNodeEvent"
            return
        end if

        if Type(msg) = "roInputEvent"
            if msg.IsInput()
                inputData = msg.getInfo()
                ? "input"
                ' pass the deeplink to UI
                if inputData.DoesExist("mediaType") and inputData.DoesExist("contentId")
                    deeplink = {
                        contentId: inputData.contentID
                        mediaType: inputData.mediaType
                    }
                    scene.inputArgs = deeplink
                end if
            end if
        end if

    end while

end sub