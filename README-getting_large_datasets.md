
## How to get the large datasets
### AKA "Why are the wikipedia data files missing?"

To pull in the large datasets, you must run

    git submodule init
    git submodule update

If you followed the instructions and cloned the repo with `git clone --recursive` this has already been done for you.

The large datasets are stored separately as their bulk requires special handling.


## How to save a ton of space by burning bridges behind you

It may be worth deleting the .git directories if you are short on space. This makes pulling in changes from git in the future difficult, but it's unlikely that really interesting changes happen.

    find . -iname .git -exec rm -rfi {} \;
