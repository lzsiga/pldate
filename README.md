# pldate
    Simple date-manipulation in Perl (to be used in shell scripts)
    
    Might be useful on platforms (like AIX) that don't have GNU-dateutils.
    
    It only handles dates, not times or timestamps.
    
    It's only supported date-format is YYYYMMDD
    
    Usage:
      pldate                     # just print the current date (localtime)
      pldate [command-list]      # execute the commands and print the result
    
    Commands:
      today                      # set the internal variable to the current day
                                 # (automatically performed at start)
      tomorrow                   # set the internal variable to the next day
      yesterday                  # set the internal variable to the previous day

      add-days N                 # add N days (it can be negative too)
      sub-days N                 # subtract N days (it can be negative too)

      next-dow N                 # N=0..7: go to the next Nth day of week
      prew-dow N                 # N=0..7: go to the previous Nth day of week

      set-mday N                 # N=1..31: go to Nth day of the month (or the last day)
                                 # N=0: same as N=1
                                 # N<0: go to the abs(N)th day of the month, counting backwards from the end

      set-yday N                 # N=1..366: go to Nth day of the year (or the last day)
                                 # N=0: same as N=1
                                 # N<0: go to the abs(N)th day of the year, counting backwards from the end

      print                      # print the current value as %Y%m%d
      printf FMT                 # formatted print (use %Y,%y,%m,%d,%w,%j)
    
    Complete examples:
      Next Saturday:
        ./pldate today next-dow 6
    
      Today if it is Saturday, otherways the first Saturday after today:
        ./pldate yesterday next-dow 6
    
      Previous Saturday:
        ./pldate today prev-dow 6
    
      Today if it is Saturday, otherways the previous Saturday before today:
        ./pldate tomorrow prev-dow 6

      Last day of the previous month
        ./pldate today set-mday 1 sub-days 1

      First day of the next month
        ./pldate today set-mday -1 add-days 1
