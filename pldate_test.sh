#!/bin/sh

TestComplete () {
    From="$1"
    Expect="$2"
    To="$(./pldate $From)"
    if [ "$To" = "$Expect" ]; then
        printf "%s => %s OK\n" "$From" "$To"
    else
        printf "%s => %s *** expected %s \n" "$From" "$To" "$Expect"
        exit 9
    fi
}

TestSet () {
    From="$1"
    Expect="$2"
    To="$(./pldate set "$From")"
    if [ "$To" = "$Expect" ]; then
        printf "set %s => %s OK\n" "$From" "$To"
    else
        printf "set %s => %s *** expected %s \n" "$From" "$To" "$Expect"
        exit 9
    fi
}

TestAddDays () {
    From="$1"
    Add="$2"
    Expect="$3"
    To="$(./pldate set "$From" add-days "$Add")"
    if [ "$To" = "$Expect" ]; then
        printf "set %s add-days %s => %s OK\n" "$From" "$Add" "$To"
    else
        printf "set %s add-days %s => %s *** expected %s \n" "$From" "$Add" "$To" "$Expect"
        exit 9
    fi
}

TestNextDow () {
    From="$1"
    Dow="$2"
    Expect="$3"
    To="$(./pldate set "$From" next-dow "$Dow")"
    if [ "$To" = "$Expect" ]; then
        printf "set %s next-dow %s => %s OK\n" "$From" "$Dow" "$To"
    else
        printf "set %s next-dow %s => %s *** expected %s \n" "$From" "$Dow" "$To" "$Expect"
        exit 9
    fi
}

TestPrevDow () {
    From="$1"
    Dow="$2"
    Expect="$3"
    To="$(./pldate set "$From" prev-dow "$Dow")"
    if [ "$To" = "$Expect" ]; then
        printf "set %s prev-dow %s => %s OK\n" "$From" "$Dow" "$To"
    else
        printf "set %s prev-dow %s => %s *** expected %s \n" "$From" "$Dow" "$To" "$Expect"
        exit 9
    fi
}

TestSet 16010101 16010101
TestSet 18480315 18480315
TestSet 19680309 19680309
TestSet 21000228 21000228

TestAddDays 23001231   0 23001231
TestAddDays 16010301  -1 16010228
TestAddDays 16040301  -1 16040229
TestAddDays 17000301  -1 17000228
TestAddDays 20000301  -1 20000229
TestAddDays 23000301  -1 23000228
TestAddDays 19991231  +1 20000101
TestAddDays 19991231 +61 20000301
TestAddDays 20000301 -61 19991231
TestAddDays 20001231 +60 20010301
TestAddDays 20010301 -60 20001231

TestNextDow 20190420 0 20190421
TestNextDow 20190420 1 20190422
TestNextDow 20190420 2 20190423
TestNextDow 20190420 3 20190424
TestNextDow 20190420 4 20190425
TestNextDow 20190420 5 20190426
TestNextDow 20190420 6 20190427
TestNextDow 20190420 7 20190421

TestPrevDow 20190420 0 20190414
TestPrevDow 20190420 1 20190415
TestPrevDow 20190420 2 20190416
TestPrevDow 20190420 3 20190417
TestPrevDow 20190420 4 20190418
TestPrevDow 20190420 5 20190419
TestPrevDow 20190420 6 20190413
TestPrevDow 20190420 7 20190414

TestComplete 'set 19010101'                             19010101
TestComplete 'set 19010101   add-days 365'              19020101
TestComplete 'set 19010101   add-days 365   next-dow 0' 19020105
TestComplete 'set 19010101   add-days 365   prev-dow 0' 19010129
