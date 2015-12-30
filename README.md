## Purpose

Check how `git-revert` works on merge commits when reverting by the first or second parent of the merge commit

## Format
Tests have been used to validate the behavior of git-revert on merge commits

Steps:
* On the fly creating a new repo
* add commits on `master` and on `feature` branches.
* merge the feature branch into master
* Then call `git-revert` on the merge commits.


## Run
To run this:

`bin\bats tests`

[Bats](https://github.com/sstephenson/bats) testing framework required




