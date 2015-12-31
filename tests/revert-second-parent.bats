current_dir=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`
git_repo_dir=$current_dir/repo

@test "" {
  run rm -rf $git_repo_dir
  run mkdir -p $git_repo_dir

  run git_init
  run git_commit "m1"
  run git_commit "m2"

  run git_checkout -b "featureA"
  run git_commit "a1"
  run git_commit "a2"

  run git_checkout "master"
  run git_commit "m3"
  run sleep 0.8

  run git_ merge "featureA" --no-ff -m "Ma"
  run git_log_in_one_line
  [[ "$output" =~ "Ma m3 a2 a1 m2 m1" ]]

  run ls_repo_files
  [[ "$output" =~ "m3 m2 m1 a2 a1" ]]

  run git_ revert -m 2 HEAD --no-edit
  run ls_repo_files
  [[ "$output" == "m2 m1 a2 a1" ]]
}

function git_()
{
	git --git-dir=$git_repo_dir/.git --work-tree=$git_repo_dir $*
}

function git_init()
{
  git init $git_repo_dir
  git config --file $git_repo_dir/.git/config user.email "git-revert-merge@gmail.com"
  git config --file $git_repo_dir/.git/config user.name "Bats Tested git-revert-merge"
}


function git_log_in_one_line()
{
	git_ log --pretty=format:\"%s\" | xargs
}

function git_commit()
{
  echo $1>>$git_repo_dir/$1
  git_ add $git_repo_dir/$1
  git_ commit -m $1 --allow-empty
}

function git_checkout()
{
  git_ checkout $*
  sleep 0.8
}

function ls_repo_files()
{
  # reverse sorting since default sorting has unexpected behavior in Mac OS
  ls $git_repo_dir | sort -r | xargs
}