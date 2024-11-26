# Installation
To install moris using apptainer run the following command:

```
apptainer build -F --sandbox moris.sif share/moris_cuda.def
```

To recompile code run
```
apptainer exec --writable moris_cuda_steps bash -c $PWD/moris_compile.sh
```

When using SLURM make sure to call the correct pmi version by using e.g.

```
srun --mpi=pmix apptainer exec --writable moris_cuda_steps bash -c $PWD/moris_compile.sh
```