#
# This file is always sourced. Do *not* put stuff in here that
# produces output and/or assume the shell is attached to a tty.
#
# The ArchWiki says this file is "generally used for setting some
# useful environment variables."
#

typeset -U path
path=(~/bin /opt/local/bin $path)
