# Center align text within some total width available
function center() {
  str=$1
  length=$2

  (( pad = length - ${#str} ))
  (( lpad = pad >> 1))
  (( rpad = lpad + pad & 1 ))

  printf '%-*s %s' $lpad
  printf '%s' $str
  printf '%-*s %s' $rpad
}

# Left align text right-padded with space
function left() {
  str=$1
  length=$2

  printf '%s%-*s %s' $str $length
}

# Fill up a line with |----------|
function grid() {
  length=$1
  pad=$(printf '%0.1s' "-"{1..$length})

  printf '|%*.*s|\n' 0 $length "$pad"
}
