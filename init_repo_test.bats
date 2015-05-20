dir="$HOME/projects/git-merge/repo"

@test "" {
  run rm -rf $dir
  run mkdir -p $dir
  run git_ init
  run git_commit "m1"
  run git_commit "m2"
  # run git_ log --oneline
  run git_checkout -b "featureA"
  run git_commit "a1"
  run git_commit "a2"
  run git_ log --oneline
  run git_checkout "master"
  run git_ merge "featureA" --no-ff -m "Ma"
  run git_log_in_one_line
  [[ "$output" =~ "Ma a2 a1 m2 m1" ]]
  run messages
  [[ "$output" == "m1 m2 a1 a2" ]]
  run git_ revert -m 1 HEAD --no-edit
  run messages
  [[ "$output" == "m1 m2" ]]
}

function git_()
{
	git --git-dir=$dir/.git --work-tree=$dir $*
}

function git_log_in_one_line()
{
	git_ log --pretty=format:\"%s\" | xargs
}

function git_commit()
{
  echo $1>>$dir/messages
  git_ add $dir/messages
  git_ commit -m $1 --allow-empty
}

function git_checkout()
{
  git_ checkout $*
  sleep 0.8
}

function messages()
{
	cat $dir/messages | xargs
}