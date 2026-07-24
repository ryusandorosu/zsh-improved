unaliases=(
  lah
  ga
  gc
  gr
  gst
  glog
  gsh
  gg
)

for alias in "${unaliases[@]}"; do
[[ $(alias $alias) ]] && unalias $alias
done
