dir="$HOME/projects/git-merge/repo"

@test "" {
  run mkdir -p $dir
  [ "$status" -eq 0 ]
}