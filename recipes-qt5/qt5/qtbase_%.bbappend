
# We cannot use system pcre as it lacks commit 0204af2 "libpcre2: add packages
# for 16-bit and 32-bit code unit support" on rocko branch.
PACKAGECONFIG_remove = "pcre"

# The -no-bundled-xcb-xinput does not work with libxcb from rocko release.
PACKAGECONFIG[xcb] = "-xcb -xcb-xlib,-no-xcb,libxcb xcb-util-wm xcb-util-image xcb-util-keysyms xcb-util-renderutil libxext"

# Avoid enabling openssl support for rocko as it is causing linking error.
PACKAGECONFIG_OPENSSL = ""
