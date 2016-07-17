Group {
    id: box
    label: "General"
    //extern: "/part0/kit0/adpars/GlobalPar/GlobalFilter/"
    property Function whenModified: nil
    property Bool     type: :analog

    onType: {
        #Changes filter type
    }

    function cb()
    {
        whenModified.call if whenModified
    }

    function change_cat()
    {
        dest = self.extern + "Ptype"    if cat.selected == 0
        return                          if cat.selected == 1
        dest = self.extern + "type-svf" if cat.selected == 2
        if(typ.extern != dest)
            typ.extern = dest
            typ.extern()
        end
    }

    ParModuleRow {
        Knob { whenValue: lambda { box.cb};  extern: box.extern     + "Pfreq" }
        Knob { whenValue: lambda { box.cb};  extern: box.extern     + "Pq" }
        Knob { whenValue: lambda { box.cb};  extern: box.extern     + "Pfreqtrack" }
        Knob { extern: box.extern + "../PFilterVelocityScale" }
        Knob { extern: box.extern + "../PFilterVelocityScaleFunction" }
    }
    ParModuleRow {
        NumEntry {
            whenValue: lambda { box.cb}
            extern: box.extern + "Pstages"
            offset: 1
            minimum: 1
            maximum: 5
        }
        Selector {
            id: cat
            whenValue: lambda { box.change_cat};
            extern: box.extern + "Pcategory"
        }
        Selector {
            id: typ
            whenValue: lambda { box.cb};
            extern: box.extern + "Ptype"
        }
        Knob { whenValue: lambda { box.cb};  extern: box.extern     + "Pgain" }
    }
}
