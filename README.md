[![Build Status](https://api.travis-ci.org/dbaltas/git-revert-merge.svg?branch=master)](https://travis-ci.org/dbaltas/git-revert-merge)

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


> This repo is tested with Bats on Travis-ci


