set -e
set -x

os=`uname`
TRAVIS_ROOT="$1"

case "$os" in
    Darwin)
        echo "Mac"
        set +e
        brew update
        for p in julia Caskroom/cask/julia ; do
            if [ "x`brew ls --versions $p`" = "x" ] ; then
                echo "$p is not installed - installing it"
                brew install $p
            else
                echo "$p is installed - upgrading it"
                brew upgrade $p
            fi
        done
        set -e
    ;;

    Linux)
        echo "Linux"
        if [ ! -d "$TRAVIS_ROOT/julia" ]; then
            cd $TRAVIS_ROOT
            wget --no-check-certificate -q https://julialang.s3.amazonaws.com/bin/linux/x64/0.4/julia-0.4.5-linux-x86_64.tar.gz
            tar -tzvf julia-0.4.5-linux-x86_64.tar.gz
        fi
        ;;
esac