# This is a backport of new methods introduced in OE-Core which we'd like to
# avoid changing the code to allow maximum code reuse.

def parallel_make(d, makeinst=False):
    """
    Return the integer value for the number of parallel threads to use when
    building, scraped out of PARALLEL_MAKE. If no parallelization option is
    found, returns None

    e.g. if PARALLEL_MAKE = "-j 10", this will return 10 as an integer.
    """
    if makeinst:
        pm = (d.getVar('PARALLEL_MAKEINST') or '').split()
    else:
        pm = (d.getVar('PARALLEL_MAKE') or '').split()
    # look for '-j' and throw other options (e.g. '-l') away
    while pm:
        opt = pm.pop(0)
        if opt == '-j':
            v = pm.pop(0)
        elif opt.startswith('-j'):
            v = opt[2:].strip()
        else:
            continue

        return int(v)

    return None

def parallel_make_argument(d, fmt, limit=None, makeinst=False):
    """
    Helper utility to construct a parallel make argument from the number of
    parallel threads specified in PARALLEL_MAKE.

    Returns the input format string `fmt` where a single '%d' will be expanded
    with the number of parallel threads to use. If `limit` is specified, the
    number of parallel threads will be no larger than it. If no parallelization
    option is found in PARALLEL_MAKE, returns an empty string

    e.g. if PARALLEL_MAKE = "-j 10", parallel_make_argument(d, "-n %d") will return
    "-n 10"
    """
    v = parallel_make(d, makeinst)
    if v:
        if limit:
            v = min(limit, v)
        return fmt % v
    return ''
