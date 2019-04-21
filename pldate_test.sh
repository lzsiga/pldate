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

TestSubDays () {
    From="$1"
    Sub="$2"
    Expect="$3"
    To="$(./pldate set "$From" sub-days "$Sub")"
    if [ "$To" = "$Expect" ]; then
        printf "set %s sub-days %s => %s OK\n" "$From" "$Sub" "$To"
    else
        printf "set %s sub-days %s => %s *** expected %s \n" "$From" "$Sub" "$To" "$Expect"
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

TestUpToDow () {
    From="$1"
    Dow="$2"
    Expect="$3"
    To="$(./pldate set "$From" upto-dow "$Dow")"
    if [ "$To" = "$Expect" ]; then
        printf "set %s upto-dow %s => %s OK\n" "$From" "$Dow" "$To"
    else
        printf "set %s upto-dow %s => %s *** expected %s \n" "$From" "$Dow" "$To" "$Expect"
        exit 9
    fi
}

TestDownToDow () {
    From="$1"
    Dow="$2"
    Expect="$3"
    To="$(./pldate set "$From" downto-dow "$Dow")"
    if [ "$To" = "$Expect" ]; then
        printf "set %s downto-dow %s => %s OK\n" "$From" "$Dow" "$To"
    else
        printf "set %s downto-dow %s => %s *** expected %s \n" "$From" "$Dow" "$To" "$Expect"
        exit 9
    fi
}

TestSetMday () {
    From="$1"
    Mday="$2"
    Expect="$3"
    To="$(./pldate set "$From" set-mday "$Mday")"
    if [ "$To" = "$Expect" ]; then
        printf "set %s set-mday %s => %s OK\n" "$From" "$Mday" "$To"
    else
        printf "set %s set-mday %s => %s *** expected %s \n" "$From" "$Mday" "$To" "$Expect"
        exit 9
    fi
}

TestSetYday () {
    From="$1"
    Yday="$2"
    Expect="$3"
    To="$(./pldate set "$From" set-yday "$Yday")"
    if [ "$To" = "$Expect" ]; then
        printf "set %s set-yday %s => %s OK\n" "$From" "$Yday" "$To"
    else
        printf "set %s set-yday %s => %s *** expected %s \n" "$From" "$Yday" "$To" "$Expect"
        exit 9
    fi
}

TestInternal () {
    Ext="$1"
    Int="$2"
    Tmp1="$(./pldate set "$Ext" printf %I)"
    Tmp2="$(./pldate set-int "$Int" print)"
    if [ "$Tmp2" = "$Ext" -a "$Tmp1" = "$Int" ]; then
        printf "ext=%s int=%s OK\n" "$Ext" "$Int"
    else
        printf "ext=%s int=%s tmp1=%s tmp2=%s **** Fail\n" "$Ext" "$Int" "$Tmp1" "$Tmp2"
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

TestSubDays 20011212    0 20011212
TestSubDays 20011212  200 20010526
TestSubDays 20011212 -200 20020630

TestNextDow 20190420 0 20190421
TestNextDow 20190420 1 20190422
TestNextDow 20190420 2 20190423
TestNextDow 20190420 3 20190424
TestNextDow 20190420 4 20190425
TestNextDow 20190420 5 20190426
TestNextDow 20190420 6 20190427 # here 'next-dow' and 'upto-dow' differ
TestNextDow 20190420 7 20190421

TestPrevDow 20190420 0 20190414
TestPrevDow 20190420 1 20190415
TestPrevDow 20190420 2 20190416
TestPrevDow 20190420 3 20190417
TestPrevDow 20190420 4 20190418
TestPrevDow 20190420 5 20190419
TestPrevDow 20190420 6 20190413 # here 'prev-dow' and 'downto-dow' differ
TestPrevDow 20190420 7 20190414

TestUpToDow 20190420 0 20190421
TestUpToDow 20190420 1 20190422
TestUpToDow 20190420 2 20190423
TestUpToDow 20190420 3 20190424
TestUpToDow 20190420 4 20190425
TestUpToDow 20190420 5 20190426
TestUpToDow 20190420 6 20190420 # here 'next-dow' and 'upto-dow' differ
TestUpToDow 20190420 7 20190421

TestDownToDow 20190420 0 20190414
TestDownToDow 20190420 1 20190415
TestDownToDow 20190420 2 20190416
TestDownToDow 20190420 3 20190417
TestDownToDow 20190420 4 20190418
TestDownToDow 20190420 5 20190419
TestDownToDow 20190420 6 20190420 # here 'prev-dow' and 'downto-dow' differ
TestDownToDow 20190420 7 20190414

TestSetMday 23000201 -31 23000201
TestSetMday 23000201 -30 23000201
TestSetMday 23000201 -27 23000202
TestSetMday 23000201 -10 23000219
TestSetMday 23000201  -1 23000228
TestSetMday 23000201   0 23000201
TestSetMday 23000201   1 23000201
TestSetMday 23000201  30 23000228
TestSetMday 23000201  31 23000228

TestSetYday 17890315  -1 17891231
TestSetYday 17890315   0 17890101
TestSetYday 17890315 365 17891231

TestInternal 16010101 000000
TestInternal 17001231 036523
TestInternal 17010101 036524
TestInternal 20001231 146096
TestInternal 20000229 145790
TestInternal 20000301 145791
TestInternal 24001231 292193

TestComplete 'set 19010101'                             19010101
TestComplete 'set 19010101   add-days 365'              19020101
TestComplete 'set 19010101   add-days 365   next-dow 0' 19020105
TestComplete 'set 19010101   add-days 365   prev-dow 0' 19011229
TestComplete 'set 19450404   set-mday   1   sub-days 1' 19450331
TestComplete 'set 19450404   set-mday  -1   add-days 1' 19450501

TestComplete 'set 19681226
              add-days 1
              prev-dow 1
              printf %Y%m%d-
              next-dow 7 printf %Y%m%d' 19681223-19681229
TestComplete 'set 19681230
              add-days 1
              prev-dow 1
              printf %Y%m%d.%w.%j-
              next-dow 7 printf %Y%m%d.%w.%j' 19681230.1.365-19690105.0.005
