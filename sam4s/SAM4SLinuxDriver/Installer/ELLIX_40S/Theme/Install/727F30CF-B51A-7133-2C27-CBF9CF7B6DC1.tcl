proc CreateWindow.727F30CF-B51A-7133-2C27-CBF9CF7B6DC1 {wizard id} {
    set base  [$wizard widget get $id]
    set frame $base.titleframe

    grid rowconfigure    $base 3 -weight 1
    grid columnconfigure $base 0 -weight 1

    frame $frame -bd 0 -relief flat -background #FFFFFF
    grid  $frame -row 0 -column 0 -sticky nsew

    grid rowconfigure    $frame 1 -weight 1
    grid columnconfigure $frame 0 -weight 1

    Label $frame.title -background #FFFFFF -anchor nw -justify left  -autowrap 1 -font TkCaptionFont  -textvariable [$wizard variable $id -text1]
    grid $frame.title -row 0 -column 0 -sticky new -padx 5 -pady 5
    $id widget set Title -widget $frame.title

    Label $frame.subtitle -background #FFFFFF -anchor nw -autowrap 1  -justify left -textvariable [$wizard variable $id -text2]
    grid $frame.subtitle -row 1 -column 0 -sticky new -padx [list 20 5]
    $id widget set Subtitle -widget $frame.subtitle

    label $frame.icon -borderwidth 0 -background #FFFFFF -anchor c
    grid  $frame.icon -row 0 -column 1 -rowspan 2
    $id widget set Icon -widget $frame.icon -type image

    Separator $base.separator -relief groove -orient horizontal
    grid $base.separator -row 1 -column 0 -sticky ew 

    Label $base.caption -anchor nw -justify left -autowrap 1  -textvariable [$wizard variable $id -text3]
    grid $base.caption -row 2 -sticky nsew -padx 8 -pady [list 8 4]
    $id widget set Caption -widget $base.caption


  $wizard itemconfigure next -state disabled



proc isIP {str type} {
   # modify these if you want to check specifi ranges for
   # each portion - now it look for 0 - 255 in each
   set ipnum1 {\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]}
   set ipnum2 {\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]}
   set ipnum3 {\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]}
   set ipnum4 {\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]}
   set fullExp {^($ipnum1)\.($ipnum2)\.($ipnum3)\.($ipnum4)$}
   set partialExp {^(($ipnum1)(\.(($ipnum2)(\.(($ipnum3)(\.(($ipnum4)?)?)?)?)?)?)?)?$}
   set fullExp [subst -nocommands -nobackslashes $fullExp]
   set partialExp [subst -nocommands -nobackslashes $partialExp]
   if [string equal $type focusout] {
      if [regexp -- $fullExp $str] {
	 return 1
      } else {
	 #tk_messageBox -message "Please enter valid ip address!"
	 return 0
      }
   } else {
      return [regexp -- $partialExp $str]
   }
}

#tk_messageBox -message "I know you like this application!" -type ok
# Added By Ganesh for getting Printer List

 
pack [entry $base.entry -textvar IP -validate all -vcmd "isIP %P %V" ] 
grid $base.entry -row 2 -column 0 -sticky nsew -padx 100 -pady [list 8 4] 
$id widget set Text -widget $base.text


bind $base.entry <Return> {
::InstallAPI::SetVirtualText -virtualtext PrinterChoice -value $IP
#::InstallJammer::Wizard reload
set conf(skipPane) 0

::InstallJammer::Wizard next
#$wizard itemconfigure next -state disabled

}
bind $base.entry <<TraverseOut>> {
	#$wizard itemconfigure next -state disabled
::InstallAPI::SetVirtualText -virtualtext PrinterChoice -value $IP
}

bind $base.entry <Leave> {
	#$wizard itemconfigure next -state disabled
::InstallAPI::SetVirtualText -virtualtext PrinterChoice -value $IP
}
}

