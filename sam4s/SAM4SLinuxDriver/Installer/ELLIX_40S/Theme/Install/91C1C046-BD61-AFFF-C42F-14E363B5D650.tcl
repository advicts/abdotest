proc CreateWindow.91C1C046-BD61-AFFF-C42F-14E363B5D650 {wizard id} {
    set base [$wizard widget get $id]

    grid rowconfigure    $base 4 -weight 1
    grid columnconfigure $base 1 -weight 1

    label $base.image -borderwidth 0 -background #FFFFFF
    grid  $base.image -row 0 -column 0 -rowspan 2 -sticky nw
    $id widget set Image -type image -widget $base.image

    Label $base.title -height 3 -bg #FFFFFF -font TkCaptionFont  -autowrap 1 -anchor nw -justify left
    grid $base.title -row 0 -column 1 -sticky ew -padx 20 -pady [list 20 10]
    $id widget set Caption -type text -widget $base.title

    Label $base.message -bg #FFFFFF -autowrap 1 -anchor nw -justify left
    grid  $base.message -row 1 -column 1 -sticky news -padx 20
    $id widget set Message -type text -widget $base.message

    Separator $base.sep -orient horizontal
    grid $base.sep -row 2 -column 0 -columnspan 2 -sticky ew


spinbox $base.list3
grid $base.list3 -row 0 -column 1 -sticky ew -padx 20 -pady 20
}

