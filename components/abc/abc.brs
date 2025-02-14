
function sss()
    

m.top.ObserveField("visible", "OnVisibleChange")

menuButtons = [
    {
        "focusUri": "pkg:/images/btn_files_f.png",
        "unfocusUri": "pkg:/images/btn_files_uf.png"
    },
    {
        "focusUri": "pkg:/images/btn_video_f.png",
        "unfocusUri": "pkg:/images/btn_video_uf.png"
    },
    {
        "focusUri": "pkg:/images/btn_images_f.png",
        "unfocusUri": "pkg:/images/btn_images_uf.png"
    },

    {
        "focusUri": "pkg:/images/btn_audio_f.png",
        "unfocusUri": "pkg:/images/btn_audio_uf.png"
    },
    {
        "focusUri": "pkg:/images/btn_text_f.png",
        "unfocusUri": "pkg:/images/btn_text_uf.png"
    }
]


parentNode = CreateObject("roSGNode", "ContentNode")

childNode = CreateObject("roSGNode", "ContentNode")


for each data in menuButtons
    '?"data values" data

    menuButtonsData = childNode.createChild("SimpleRowListItemData")

    menuButtonsData.unfocusUri = data.unfocusUri
    menuButtonsData.focusUri = data.focusUri

    '?"Ad Data"menuButtonsData



    parentNode.appendChild(childNode)


end for
end function

sub onMenuButtonSelected(event)
    ' sec = CreateObject("roRegistrySection", m.global.appName)
  

        data = event.getData()
        ?"Ad clicked data"data
        column = data[1]
        if m.global.isUSBplggedin
            if column = 0
                ' onbtnAllSelected()
                
            else if column = 1
                ' onbtnVideosSelected()
                
            else if column = 2
                ' onbtnImagesSelected()


            else if column = 3
                ' onbtnAudiosSelected()
            else if column = 4
                ' m.top.getScene().callFunc("ShowTextScreen")





            end if
        else
            ' m.USBdisconnectPopup.visible = true

        end if



end sub