# pldate
    Simple date-manipulation in Perl (to be used in shell scripts)
    
    Might be useful on platforms (like AIX) that don't have GNU-dateutils.
    
    It only handles dates, not times or timestamps.
    
    It's only supported date-format is YYYYMMDD (but it has a 'printf' command)
    Its internal date-representation is number of days since 1601-01-01,
    supported range: 0..292192 (1601-01-01..2400-12-31).

    Usage:
      pldate                     # just print the current date (localtime)
      pldate [command-list]      # execute the commands and print the result
    
    Commands:
      today                      # set the internal variable to the current day
                                 # (automatically performed at start)
      tomorrow                   # set the internal variable to the next day
      yesterday                  # set the internal variable to the previous day

      set YYYYMMDD               # go to the specifed day
      set-int N                  # the same with internal format (see above)

      add-day[s] N               # add N days (it can be negative too)
      sub-day[s] N               # subtract N days (it can be negative too)

      add-month[s] N             # add N months (it can be negative too)
      sub-month[s] N             # subtract N months (it can be negative too)
                                 # note: these two might change the day-of-month
                                 # eg 2001-03-31 -1 month = 2001-02-28

      add-year[s] N              # add N years (it can be negative too)
      sub-year[s] N              # subtract N years (it can be negative too)
                                 # note: these two might change the day-of-month
                                 # eg 2004-02-29 -1 year = 2003-02-28

      next-wday N                # N=0..7: go to the next Nth day of week
      next-dow  N                # synonym of the previous

      prev-wday N                # N=0..7: go to the previous Nth day of week
      prev-dow  N                # synonym of the previous

      upto-wday N                # N=0..7: go to the next Nth day of week
                                 # but stay, if it is today
                                 # _not_ equivalent with 'next-wday'
      upto-dow  N                # synonym of the previous

      downto-wday N              # N=0..7: go to the previous Nth day of week
                                 # but stay, if it is today
      downto-dow  N              # synonym of the previous

      set-mday N                 # N=1..31: go to Nth day of the month (or the last day)
                                 # N=0: same as N=1
                                 # N<0: go to the abs(N)th day of the month, counting backwards from the end

      set-yday N                 # N=1..366: go to Nth day of the year (or the last day)
                                 # N=0: same as N=1
                                 # N<0: go to the abs(N)th day of the year, counting backwards from the end

      print                      # print the current value as %Y%m%d
      printf FMT                 # formatted print (use %Y,%y,%m,%d,%w,%j and %I for internal number)
    
    Complete examples:
      Next Saturday:
        ./pldate today next-dow 6
    
      Today if it is Saturday, otherways the first Saturday after today:
        ./pldate yesterday next-dow 6
        ./pldate today upto-dow 6
    
      Previous Saturday:
        ./pldate today prev-dow 6
    
      Today if it is Saturday, otherways the previous Saturday before today:
        ./pldate tomorrow prev-dow 6
        ./pldate today downto-dow 6

      Last day of the previous month
        ./pldate today set-mday 1 sub-days 1
    
      First day of the next month
        ./pldate today set-mday -1 add-days 1
        ./pldate today add-month 1 set-mday 1

      Last day of the next month
        ./pldate today add-month 1 set-mday -1
    
      The week containing the current date (eg 19681230-19690105)
        ./pldate today \
              add-days 1 \
              prev-dow 1 \
              printf %Y%m%d- \
              next-dow 7 printf %Y%m%d

      Previous year as an interval (eg 20180101-20181231)
        ./pldate today sub-year 1 set-yday 1 printf %Y%m%d- set-yday -1 print

      Days since a fixed day:
         expr "$(./pldate today printf %I)" - "$(./pldate set 20010209 printf %I)"
