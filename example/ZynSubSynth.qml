Widget {
    id: subsynth


    TabGroup {
        id: subtabs
        TabButton {label: "harmonic" }
        TabButton {label: "amplitude" }
        TabButton {label: "bandwidth" }
        TabButton {label: "frequency" }
        TabButton {label: "filter" }
        TabButton {label: "oscilloscope"}
        CopyButton  { id: cpy; extern: subsynth.extern}
        PasteButton { extern: subsynth.extern}

        function layout(l, selfBox) {
            selfBox = Draw::Layout::tabpack(l, selfBox, self, cpy)
        }

        function set_tab(wid)
        {
            selected = get_tab wid

            #Define a mapping from tabs to values
            mapping = {0 => :harmonic,
                       1 => :amplitude,
                       2 => :bandwidth,
                       3 => :frequency,
                       4 => :filter,
                       5 => :oscilloscope
                       }
            return if !mapping.include?(selected)
            root.set_view_pos(:subview, mapping[selected])
            root.change_view
        }
    }
    
    Swappable { id: swap }

    function layout(l, selfBox) {
        Draw::Layout::vfill(l, selfBox, children, [0.05, 0.95])
    }

    function set_view()
    {
        vw = root.get_view_pos(:subview)
        mapping = {:harmonic  => Qml::ZynSubHarmonic,
                   :amplitude => Qml::ZynSubAmp,
                   :bandwidth => Qml::ZynSubBandwidth,
                   :frequency => Qml::ZynSubFreq,
                   :filter    => Qml::ZynSubFilter,
                   :oscilloscope => Qml::ZynSubOscilloscope}
        tabid   = {:harmonic  => 0,
                   :amplitude => 1,
                   :bandwidth => 2,
                   :frequency => 3,
                   :filter    => 4,
                   :oscilloscope => 5}
        if(!mapping.include?(vw))
            root.set_view_pos(:subview, :harmonic)
            vw = :harmonic
        end

        swap.extern  = subsynth.extern
        swap.content = mapping[vw]
        subtabs.children[tabid[vw]].value = true
    }

    function onSetup(old=nil)
    {
        set_view
    }
}
