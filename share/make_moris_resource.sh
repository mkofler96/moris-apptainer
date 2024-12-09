#!/bin/bash

#-----------------------------------------------------------------
# script to generate resource files for bash and tcsh shells
#-----------------------------------------------------------------
echo "Running Version 0.2 of make moris resource"

if [ ! $WORKSPACE ];then
    echo ""
    echo "Environment variable WORKSPACE needs to be defined"
    echo ""
    exit
fi

if [ -f $WORKSPACE/.cshrc_moris ];then
    echo ""
    echo "saving $WORKSPACE/.cshrc_moris to $WORKSPACE/.cshrc_moris.org"
    mv $WORKSPACE/.cshrc_moris  $WORKSPACE/.cshrc_moris.org
fi
if [ -f $WORKSPACE/.bashrc_moris ];then
    echo ""
    echo "saving $WORKSPACE/.bashrc_moris to $WORKSPACE/.bashrc_moris.org"
    mv $WORKSPACE/.bashrc_moris $WORKSPACE/.bashrc_moris.org
fi

echo ""
echo "creating $WORKSPACE/.cshrc_moris"

cd $WORKSPACE
export SPACK_ROOT=$WORKSPACE/spack
export PATH=$PATH/:$SPACK_ROOT/bin
. $SPACK_ROOT/share/spack/setup-env.sh
spack env activate .

export SPACKCOMP=`spack compiler list | tail -1`

export  CC=`spack compiler info $SPACKCOMP | grep 'cc ='  | awk -F = '{print $2}' | xargs ls`
export CXX=`spack compiler info $SPACKCOMP | grep 'cxx =' | awk -F = '{print $2}' | xargs ls`
export  FC=`spack compiler info $SPACKCOMP | grep 'fc ='  | awk -F = '{print $2}' | xargs ls`
export F77=`spack compiler info $SPACKCOMP | grep 'f77 =' | awk -F = '{print $2}' | xargs ls`

# old command
#export GCCLIB=`spack compiler info $SPACKCOMP | grep 'cc ='  | awk -F = '{split($2,a,"/bin/");print a[1]}'`
# new one
# export GCCLIB=$(spack compiler info $SPACKCOMP | grep 'cc =' | awk -F '=' '{split($2,a,"/bin/"); print a[1]}' | xargs)


export GCMMA_INSTALLED=`spack find | awk -F '@' 'BEGIN{n=0}{ if ( $1 == "gcmma" )           {n=1}}END{print n}'`
export SNOPT_INSTALLED=`spack find | awk -F '@' 'BEGIN{n=0}{ if ( $1 == "snopt" )           {n=1}}END{print n}'`
export LBFGS_INSTALLED=`spack find | awk -F '@' 'BEGIN{n=0}{ if ( $1 == "lbfgs" )           {n=1}}END{print n}'`
export PETSC_INSTALLED=`spack find | awk -F '@' 'BEGIN{n=0}{ if ( $1 == "petsc" )           {n=1}}END{print n}'`
export ABLIS_INSTALLED=`spack find | awk -F '@' 'BEGIN{n=0}{ if ( $1 == "amdblis" )         {n=1}}END{print n}'`
export AFLAM_INSTALLED=`spack find | awk -F '@' 'BEGIN{n=0}{ if ( $1 == "amdlibflame" )     {n=1}}END{print n}'`
export OAMKL_INSTALLED=`spack find | awk -F '@' 'BEGIN{n=0}{ if ( $1 == "intel-oneapi-mkl" ){n=1}}END{print n}'`
export  IMKL_INSTALLED=`spack find | awk -F '@' 'BEGIN{n=0}{ if ( $1 == "intel-mkl" )       {n=1}}END{print n}'`
export OBLAS_INSTALLED=`spack find | awk -F '@' 'BEGIN{n=0}{ if ( $1 == "openblas" )        {n=1}}END{print n}'`
export SLEPC_INSTALLED=`spack find | awk -F '@' 'BEGIN{n=0}{ if ( $1 == "slepc" )           {n=1}}END{print n}'`
export  DOXY_INSTALLED=`spack find | awk -F '@' 'BEGIN{n=0}{ if ( $1 == "doxygen" )         {n=1}}END{print n}'`
export CLANG_INSTALLED=`spack find | awk -F '@' 'BEGIN{n=0}{ if ( $1 == "llvm" )            {n=1}}END{print n}'`
export NINJA_INSTALLED=`spack find | awk -F '@' 'BEGIN{n=0}{ if ( $1 == "ninja" )           {n=1}}END{print n}'`
export  ARBX_INSTALLED=`spack find | awk -F '@' 'BEGIN{n=0}{ if ( $1 == "arborx" )          {n=1}}END{print n}'`

export Trilinos_DIR=`spack location --install-dir trilinos`

if [ "$1" = "view" ];then
export MORISROOT=`spack location --install-dir moris`
echo 'setenv PATH $PATH/:'"$MORISROOT/bin/"                                    >> $WORKSPACE/.cshrc_moris
else
echo "setenv MORISROOT      $WORKSPACE/moris"                                  >> $WORKSPACE/.cshrc_moris
echo 'setenv MORISBUILDDBG  build_dbg'                                         >> $WORKSPACE/.cshrc_moris
echo 'setenv MORISBUILDOPT  build_opt'                                         >> $WORKSPACE/.cshrc_moris
echo 'setenv MORISOUTPUT    $MORISROOT/$MORISBUILDDBG/'                        >> $WORKSPACE/.cshrc_moris
echo ""                                                                        >> $WORKSPACE/.cshrc_moris
echo 'setenv MRD $MORISROOT/build_dbg/projects/mains/moris'                    >> $WORKSPACE/.cshrc_moris
echo 'setenv MRO $MORISROOT/build_opt/projects/mains/moris'                    >> $WORKSPACE/.cshrc_moris
echo 'setenv PATH $PATH/:$MORISROOT/share/scripts/'                            >> $WORKSPACE/.cshrc_moris
fi

echo ""                                                                        >> $WORKSPACE/.cshrc_moris
echo "setenv MPI_HOME"         `spack location --install-dir openmpi`          >> $WORKSPACE/.cshrc_moris
echo ""                                                                        >> $WORKSPACE/.cshrc_moris
echo "setenv Armadillo_DIR"    `spack location --install-dir armadillo`        >> $WORKSPACE/.cshrc_moris
echo "setenv Eigen3_DIR"       `spack location --install-dir eigen`            >> $WORKSPACE/.cshrc_moris
echo "setenv Boost_DIR"        `spack location --install-dir boost`            >> $WORKSPACE/.cshrc_moris
echo "setenv Boost_ROOT"       `spack location --install-dir boost`            >> $WORKSPACE/.cshrc_moris
echo "setenv ARPACK_DIR"       `spack location --install-dir arpack-ng`        >> $WORKSPACE/.cshrc_moris
echo "setenv SUPERLU_DIR"      `spack location --install-dir superlu`          >> $WORKSPACE/.cshrc_moris
echo "setenv SuperLU_DIST_DIR" `spack location --install-dir superlu-dist`     >> $WORKSPACE/.cshrc_moris
echo "setenv HDF5_DIR"         `spack location --install-dir hdf5`             >> $WORKSPACE/.cshrc_moris
echo "setenv NETCDF_DIR "      `spack location --install-dir netcdf-c`         >> $WORKSPACE/.cshrc_moris
echo "setenv ZLIB_DIR "        `spack location --install-dir zlib-ng`          >> $WORKSPACE/.cshrc_moris
echo "setenv SSL_DIR  "        `spack location --install-dir openssl`          >> $WORKSPACE/.cshrc_moris
echo "setenv CMAKE_DIR  "      `spack location --install-dir cmake`            >> $WORKSPACE/.cshrc_moris
echo "setenv Trilinos_DIR       $Trilinos_DIR"                                 >> $WORKSPACE/.cshrc_moris
echo ""                                                                        >> $WORKSPACE/.cshrc_moris

if [ $GCMMA_INSTALLED == "1" ];then
echo "setenv GCMMA_DIR"        `spack location --install-dir gcmma`            >> $WORKSPACE/.cshrc_moris
fi
if [ $SNOPT_INSTALLED == "1" ];then
echo "setenv SNOPT_DIR"        `spack location --install-dir snopt`            >> $WORKSPACE/.cshrc_moris
fi
if [ $LBFGS_INSTALLED == "1" ];then
echo "setenv LBFGSB_DIR"       `spack location --install-dir lbfgs`            >> $WORKSPACE/.cshrc_moris
fi
if [ $PETSC_INSTALLED == "1" ];then
export PETSC_DIR=`spack location --install-dir petsc`
echo "setenv PETSC_DIR"        $PETSC_DIR                                      >> $WORKSPACE/.cshrc_moris
fi
if [ $SLEPC_INSTALLED == "1" ];then
echo "setenv SLEPC_DIR"        `spack location --install-dir slepc`            >> $WORKSPACE/.cshrc_moris
fi
if [ $OAMKL_INSTALLED == "1" ];then
echo "setenv MKL_DIR" \
                 `spack location --install-dir intel-oneapi-mkl`"/mkl/latest"  >> $WORKSPACE/.cshrc_moris
fi
if [ $IMKL_INSTALLED == "1" ];then
echo "setenv MKL_DIR"          `spack location --install-dir intel-mkl`"/mkl"  >> $WORKSPACE/.cshrc_moris
fi
if [ $ABLIS_INSTALLED == "1" ];then
echo "setenv AMDBLIS_DIR"      `spack location --install-dir amdblis`          >> $WORKSPACE/.cshrc_moris
fi
if [ $AFLAM_INSTALLED == "1" ];then
echo "setenv AMDLIBFLAME_DIR"  `spack location --install-dir amdlibflame`      >> $WORKSPACE/.cshrc_moris
fi
if [ $OBLAS_INSTALLED == "1" ];then
echo "setenv OPENBLAS_DIR"     `spack location --install-dir openblas`         >> $WORKSPACE/.cshrc_moris
fi
if [ $DOXY_INSTALLED == "1" ];then
export DOXYGEN_DIR=`spack location --install-dir doxygen`
echo "setenv DOXYGEN_DIR"     $DOXYGEN_DIR                                     >> $WORKSPACE/.cshrc_moris
fi
if [ $CLANG_INSTALLED == "1" ];then
export CLANG_DIR=`spack location --install-dir llvm`
echo "setenv CLANG_DIR"       $CLANG_DIR                                       >> $WORKSPACE/.cshrc_moris
fi

if [ $NINJA_INSTALLED == "1" ];then
export NINJA_DIR=`spack location --install-dir ninja`
echo "setenv NINJA_DIR"       $NINJA_DIR                                       >> $WORKSPACE/.cshrc_moris
fi

if [ $ARBX_INSTALLED == "1" ];then
export ARBX_DIR=`spack location --install-dir arborx`
echo "setenv ARBX_DIR"       $ARBX_DIR                                         >> $WORKSPACE/.cshrc_moris
fi

echo ""                                                                        >> $WORKSPACE/.cshrc_moris
echo 'setenv PATH $MPI_HOME/bin/:$PATH'                                        >> $WORKSPACE/.cshrc_moris 
echo 'setenv PATH $NETCDF_DIR/bin/:$PATH'                                      >> $WORKSPACE/.cshrc_moris 
echo 'setenv PATH $Trilinos_DIR/bin/:$PATH'                                    >> $WORKSPACE/.cshrc_moris 
echo 'setenv PATH $CMAKE_DIR/bin/:$PATH'                                       >> $WORKSPACE/.cshrc_moris 

if [ $DOXY_INSTALLED == "1" ];then
echo 'setenv PATH $DOXYGEN_DIR/bin/:$PATH'                                     >> $WORKSPACE/.cshrc_moris 
fi

if [ $CLANG_INSTALLED == "1" ];then
echo 'setenv PATH $CLANG_DIR/bin/:$PATH'                                       >> $WORKSPACE/.cshrc_moris 
fi

if [ $NINJA_INSTALLED == "1" ];then
echo 'setenv PATH $NINJA_DIR/bin/:$PATH'                                       >> $WORKSPACE/.cshrc_moris 
fi

echo ""                                                                        >> $WORKSPACE/.cshrc_moris
# echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$GCCLIB/lib64'                  >> $WORKSPACE/.cshrc_moris 
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$ZLIB_DIR/lib'                  >> $WORKSPACE/.cshrc_moris 
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$SSL_DIR/lib64'                 >> $WORKSPACE/.cshrc_moris 
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$MPI_HOME/lib64'                >> $WORKSPACE/.cshrc_moris 
echo ""                                                                        >> $WORKSPACE/.cshrc_moris
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$Armadillo_DIR/lib64'           >> $WORKSPACE/.cshrc_moris 
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$Boost_DIR/lib'                 >> $WORKSPACE/.cshrc_moris 
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$ARPACK_DIR/lib64'              >> $WORKSPACE/.cshrc_moris 
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$SUPERLU_DIR/lib'               >> $WORKSPACE/.cshrc_moris 
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$SuperLU_DIST_DIR/lib'          >> $WORKSPACE/.cshrc_moris 
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$Trilinos_DIR/lib'              >> $WORKSPACE/.cshrc_moris 
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$HDF5_DIR/lib'                  >> $WORKSPACE/.cshrc_moris 
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$NETCDF_DIR/lib64'              >> $WORKSPACE/.cshrc_moris 
echo ""                                                                        >> $WORKSPACE/.cshrc_moris

if [ $GCMMA_INSTALLED == "1" ];then
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$GCMMA_DIR/lib'                 >> $WORKSPACE/.cshrc_moris 
fi
if [ $SNOPT_INSTALLED == "1" ];then
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$SNOPT_DIR/lib'                 >> $WORKSPACE/.cshrc_moris 
fi
if [ $LBFGS_INSTALLED == "1" ];then
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$LBFGSB_DIR/lib'                >> $WORKSPACE/.cshrc_moris 
fi
if [ $PETSC_INSTALLED == "1" ];then
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$PETSC_DIR/lib'                 >> $WORKSPACE/.cshrc_moris 
fi
if [ $SLEPC_INSTALLED == "1" ];then
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$SLEPC_DIR/lib'                 >> $WORKSPACE/.cshrc_moris 
fi
if [ $OBLAS_INSTALLED == "1" ];then
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$OPENBLAS_DIR/lib'              >> $WORKSPACE/.cshrc_moris 
fi
if [ $ABLIS_INSTALLED == "1" ];then
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$AMDBLIS_DIR/lib'               >> $WORKSPACE/.cshrc_moris
fi
if [ $AFLAM_INSTALLED == "1" ];then
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$AMDLIBFLAME_DIR/lib'           >> $WORKSPACE/.cshrc_moris
fi
if [ $IMKL_INSTALLED == "1" ];then
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$MKL_DIR/lib'                   >> $WORKSPACE/.cshrc_moris 
fi
if [ $OAMKL_INSTALLED == "1" ];then
echo 'setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH/:$MKL_DIR/lib'                   >> $WORKSPACE/.cshrc_moris 
fi

echo ""                                                                        >> $WORKSPACE/.cshrc_moris
echo "setenv OMPI_MCA_rmaps_base_oversubscribe 1"                              >> $WORKSPACE/.cshrc_moris
echo "setenv OMP_NUM_THREADS 1"                                                >> $WORKSPACE/.cshrc_moris
echo "setenv OMPI_MCA_btl ^tcp"                                                >> $WORKSPACE/.cshrc_moris

echo ""                                                                        >> $WORKSPACE/.cshrc_moris
echo "setenv CC  $CC"                                                          >> $WORKSPACE/.cshrc_moris
echo "setenv CXX $CXX"                                                         >> $WORKSPACE/.cshrc_moris
echo "setenv FC  $FC"                                                          >> $WORKSPACE/.cshrc_moris
echo "setenv F77 $F77"                                                         >> $WORKSPACE/.cshrc_moris
echo ""                                                                        >> $WORKSPACE/.cshrc_moris

if [ $PETSC_INSTALLED == "1" ];then
export      GFORTLIB=`ldd $PETSC_DIR/lib/libpetsc.so | grep gfortran | awk '{print $1}'`
export GFORTLIB_PATH=`ldd $PETSC_DIR/lib/libpetsc.so | grep gfortran | awk '{print $3}' | xargs dirname`
else
export      GFORTLIB=`ldd $Trilinos_DIR/lib/libexodus.so | grep gfortran | awk '{print $1}'`
export GFORTLIB_PATH=`ldd $Trilinos_DIR/lib/libexodus.so | grep gfortran | awk '{print $3}' | xargs dirname`
fi

echo "setenv GFORTLIB $GFORTLIB"                                               >> $WORKSPACE/.cshrc_moris
echo "setenv GFORTLIB_PATH $GFORTLIB_PATH"                                     >> $WORKSPACE/.cshrc_moris

echo ""
echo "creating $WORKSPACE/.bashrc_moris"

sed -rn 's/^\s*setenv\s+(\S+)\s+/export \1=/p' $WORKSPACE/.cshrc_moris > $WORKSPACE/.bashrc_moris

echo ""
echo "saving copy of .cshrc_moris and .bashrc_moris to $WORKSPACE: CSHRC_MORIS and BASHRC_MORIS"
cp $WORKSPACE/.bashrc_moris $WORKSPACE/BASHRC_MORIS
cp $WORKSPACE/.cshrc_moris  $WORKSPACE/CSHRC_MORIS

echo ""