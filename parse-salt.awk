/Succeeded/ {
    succeeded += $2
    start = match($3, "=")
    end   = match($3, ")")
    changes += substr($3, start+1, end-start-1)
}

/Failed/ {
    failed += $2
}

/^[a-zA-Z0-9.-]+:$/ {
    hostname = gensub(":", "", "g", $1)
    hosts += 1
}

/^Total states run/ {
    hosts_connected += 1
}

/Minion did not return/ {
    hosts_noresponse += 1
}

END {
    print "hosts:                 | " hosts
    print "hosts connected        | " hosts_connected
    print "hosts without response | " hosts_noresponse
    print "-----------------------|-----"
    print "states succeeded:      | " succeeded
    print "states with changes:   | " changes
    print "states failed:         | " failed
}
