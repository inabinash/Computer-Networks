set a 8
 

proc factorial  abi {
 
    if {$facti <= 1} {
 
        return 1
    }
expr $facti * [factorial [expr $facti-1]]
 
}

puts $b

