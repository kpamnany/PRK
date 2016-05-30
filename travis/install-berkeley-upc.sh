set -e
set -x

TRAVIS_ROOT="$1"

MPI_IMPL=mpich

# we can't handle this yet in build-run-prk.sh
#if [ "x$GASNET_CONDUIT" -eq "x" ] ; then
#    BUPC_PREFIX=bupc-$CC
#else
#    BUPC_PREFIX=bupc-$CC-$GASNET_CONDUIT
#fi
BUPC_PREFIX=$TRAVIS_ROOT/bupc-$CC

export BUPC_RELEASE=berkeley_upc-2.22.3

# On Mac (not Linux), we see this error:
#   upcrun: When network=smp compile with '-pthreads' or PSHM support to run with > 1 thread
os=`uname`
case $os in
    Darwin)
        BUPC_NO_PTHREADS="--disable-par"
        MPI_ROOT=/usr/local
        ;;
    Linux)
        BUPC_NO_PTHREADS=""
        MPI_ROOT=$TRAVIS_ROOT/$MPI_IMPL
        ;;
esac

BUPC_NO_HPC_NETWORKS="--disable-auto-conduit-detect --disable-ibv --disable-gemini --disable-aries --disable-shmem --disable-pami  --disable-fca --disable-portals4 --disable-mxm --disable-hugetlbfs"
BUPC_ONLY_X86_CPU="--disable-ppc64-probe --disable-ultrasparc-probe --disable-arch-sgi-ip27 --disable-tune-ppc970"
BUPC_VM_FRIENDLY="--enable-force-yield-membars --disable-aligned-segments"

if [ ! -d "$BUPC_PREFIX" ]; then
    wget --no-check-certificate -q http://upc.lbl.gov/download/release/$BUPC_RELEASE.tar.gz
    tar -xzf $BUPC_RELEASE.tar.gz
    cd $BUPC_RELEASE
    mkdir build && cd build
    case "$GASNET_CONDUIT" in
        pthreads)
            ../configure --prefix=$BUPC_PREFIX --enable-smp --enable-pthreads --disable-pshm \
                         $BUPC_NO_HPC_NETWORKS $BUPC_ONLY_X86_CPU $BUPC_VM_FRIENDLY
            ;;
        pshm)
            ../configure --prefix=$BUPC_PREFIX --enable-smp --enable-pshm --disable-pthreads \
                         $BUPC_NO_HPC_NETWORKS $BUPC_ONLY_X86_CPU $BUPC_VM_FRIENDLY
            ;;
        udp)
            ../configure --prefix=$BUPC_PREFIX $BUPC_NO_PTHREADS --enable-$GASNET_CONDUIT \
                         $BUPC_NO_HPC_NETWORKS $BUPC_ONLY_X86_CPU $BUPC_VM_FRIENDLY
            ;;
        ofi)
            # TODO factor Hydra out of Sandia OpenSHMEM install so it can be used as spawner here
            ../configure --prefix=$BUPC_PREFIX $BUPC_NO_PTHREADS --enable-$GASNET_CONDUIT \
                         --with-ofihome=$TRAVIS_ROOT/libfabric --with-ofi-spawner=pmi --with-pmi=$TRAVIS_ROOT/hydra \
                         $BUPC_NO_HPC_NETWORKS $BUPC_ONLY_X86_CPU $BUPC_VM_FRIENDLY
            ;;
        mpi)
            ../configure --prefix=$BUPC_PREFIX $BUPC_NO_PTHREADS --enable-$GASNET_CONDUIT \
                         --with-mpi-cc=$MPI_ROOT/bin/mpicc \
                         $BUPC_NO_HPC_NETWORKS $BUPC_ONLY_X86_CPU $BUPC_VM_FRIENDLY
            ;;
        *)
            echo "GASNet conduit not specified - configure will guess."
            ../configure --prefix=$BUPC_PREFIX $BUPC_ONLY_X86_CPU $BUPC_VM_FRIENDLY
            ;;
    esac
    make -j2
    make install
else
    echo "Berkeley UPC (w/ $CC) installed..."
    find $BUPC_PREFIX -name upcc -type f
fi

