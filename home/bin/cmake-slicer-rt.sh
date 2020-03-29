cmake \
    -DSLICERRT_ENABLE_EXPERIMENTAL_MODULES:BOOL=TRUE \
    -DSlicer_DIR:STRING=$HOME/build/slicer-4/Slicer-build/Slicer-build \
    -DPlastimatch_DIR:STRING=$HOME/build/slicer-4/plastimatch-build \
    $HOME/build/slicer-4/SlicerRT
