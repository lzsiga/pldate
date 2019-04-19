#!/bin/sh

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

TestSet 16010101 16010101
TestSet 18480315 18480315
TestSet 19680309 19680309
TestSet 21000228 21000228

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
