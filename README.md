# pldate
simple date-manipulation in Perl (to be used in shell scripts)

Might be useful on platforms (like AIX) that don't have GNU-dateutils.

It only handles dates, not times or timestamps.

It's only supported date-format is YYYYMMDD

Usage:
    pldate                       # just print the current date (localtime)
    pldate [command-list]        # execute the commands and print the result

Command:
    today                        # set the internal variable to the current day
                                 # automatically performed at start
    tomorrow                     # set the internal variable to the next day
    yesterday                    # set the internal variable to the previous day
    add-days N                   # add N days (it can be negative too)
    next-dow N                   # N=0..7: go to the next Nth day of week
    prew-dow N                   # N=0..7: go to the prev Nth day of week

Complete example:
    Next Saturday:
        ./pldate today next-dow 6

    Today if it is Saturday, otherways the first Saturday after today:
        ./pldate yesterday next-dow 6

    Previous Saturday:
        ./pldate today prev-dow 6

    Today if it is Saturday, otherways the previous Saturday before today:
        ./pldate tomorrow prev-dow 6
