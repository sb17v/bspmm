# -*- Mode: Makefile; -*-
USE_CBLAS=yes
USE_DEBUG=no
CC=mpicc
CFLAGS=-g -O0 -Wall
ifeq ($(USE_DEBUG), yes)
	CFLAGS+= -DDEBUG
endif

BLAS_FLAGS=
ifeq ($(USE_CBLAS), yes)
	BLAS_FLAGS= -lopenblas
	BLAS_FLAGS+= -DUSE_CBLAS
endif

OPENMPFLAGS=-fopenmp
BSPMM_COMMON_SRC=bspmm_common.c
BINS+=bspmm_single
BINS+=bspmm_single_modified
BINS+=bspmm_multiple
BINS+=bspmm_multiple_nwins

all: $(BINS)

bspmm_single: bspmm_single.c $(BSPMM_COMMON_SRC)
	$(CC) $(CFLAGS) $^ -o $@

bspmm_single_modified: bspmm_single_modified.c $(BSPMM_COMMON_SRC)
	$(CC) $(CFLAGS) $(BLAS_FLAGS) $^ -o $@

bspmm_multiple: bspmm_multiple.c $(BSPMM_COMMON_SRC)
	$(CC) $(CFLAGS) $(OPENMPFLAGS) $^ -o $@

bspmm_multiple_nwins: bspmm_multiple_nwins.c $(BSPMM_COMMON_SRC)
	$(CC) $(CFLAGS) $(OPENMPFLAGS) $^ -o $@

clean:
	rm -f $(BINS)
