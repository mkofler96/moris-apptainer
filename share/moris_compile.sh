echo "Starting moris compilation"
echo $WORKSPACE
source activate_moris.sh
cd $WORKSPACE
spack env activate .
bash $WORKSPACE/moris/share/spack/make_moris_resource.sh view
source ~/.bashrc_moris
spack --version
cd moris
mkdir build
cd build
cmake -DBUILD_ALL=ON -DMORIS_USE_EXAMPLES=ON -DMORIS_HAVE_PETSC=OFF -DMORIS_HAVE_SLEPC=OFF -DMORIS_USE_PARDISO=OFF -DMORIS_USE_MUMPS=OFF -DMORIS_HAVE_GCMMA=OFF -DMORIS_HAVE_LBFGS=OFF -DMORIS_HAVE_SNOPT=OFF ..
make -j 48
ctest