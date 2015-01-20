#Copyright (c) 2013, Intel Corporation
#
#Redistribution and use in source and binary forms, with or without 
#modification, are permitted provided that the following conditions 
#are met:
#
#    * Redistributions of source code must retain the above copyright 
#      notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above 
#      copyright notice, this list of conditions and the following 
#      disclaimer in the documentation and/or other materials provided 
#      with the distribution.
#    * Neither the name of Intel Corporation nor the names of its 
#      contributors may be used to endorse or promote products 
#      derived from this software without specific prior written 
#      permission.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
#"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
#LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
#FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
#COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
#INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
#BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
#LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
#CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
#LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN 
#ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
#POSSIBILITY OF SUCH DAMAGE.
#
# ******************************************************************

ifndef number_of_functions
  number_of_functions=40
endif

ifndef matrix_rank
  matrix_rank=5
endif

ifndef default_opt_flags
  default_opt_flags=-O3 -restrict
endif

default:
	@echo "Usage: \"make all\"          (re-)builds all targets"
	@echo "       \"make allserial\"    (re-)builds all serial targets"
	@echo "       \"make allopenmp\"    (re-)builds all OpenMP targets"
	@echo "       \"make allmpi\"       (re-)builds all MPI targets"
	@echo "       \"make allmpiopenmp\" (re-)builds all OpenMP targets"
	@echo "       \"make allmpirma\"    (re-)builds all MPI-3 RMA targets"
	@echo "       \"make allmpishm\"    (re-)builds all MPI-3 shared memory segments targets"
	@echo "       \"make allcharm++\"   (re-)builds all Charm++ targets"
	@echo "       optionally, specify   \"matrix_rank=<n> number_of_functions=<m>\""
	@echo "       optionally, specify   \"default_opt_flags=<list of optimization flags>\""
	@echo "       \"make clean\"        removes all objects and executables"
	@echo "       \"make veryclean\"    removes some generated source files as well"

all: allserial allopenmp allmpi allmpiopenmp allmpirma allmpishm allcharm++ 

allmpi: 
	cd MPI/Synch_global;        $(MAKE) global    "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd MPI/Synch_p2p;           $(MAKE) p2p       "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd MPI/Sparse;              $(MAKE) sparse    "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd MPI/Transpose;           $(MAKE) transpose "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd MPI/Stencil;             $(MAKE) stencil   "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd MPI/DGEMM;               $(MAKE) dgemm     "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd MPI/Nstream;             $(MAKE) nstream   "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd MPI/Reduce;              $(MAKE) reduce    "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd MPI/Random;              $(MAKE) random    "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd MPI/Branch;              $(MAKE) branch    "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"  \
                                                      "MATRIX_RANK         = $(matrix_rank)"        \
                                                      "NUMBER_OF_FUNCTIONS = $(number_of_functions)"

allmpiopenmp: 
	cd MPIOPENMP/Nstream;       $(MAKE) nstream   "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd MPIOPENMP/Transpose;     $(MAKE) transpose "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd MPIOPENMP/Stencil;       $(MAKE) stencil   "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd MPIOPENMP/Synch_p2p;     $(MAKE) p2p       "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"

allmpirma: 
	cd MPIRMA/Synch_p2p;        $(MAKE) p2p       "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd MPIRMA/Stencil;          $(MAKE) stencil   "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"

allmpishm: 
	cd MPISHM/Synch_p2p;        $(MAKE) p2p       "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd MPISHM/Stencil;          $(MAKE) stencil   "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"

allopenmp: 
	cd OPENMP/DGEMM;            $(MAKE) dgemm     "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd OPENMP/Nstream;          $(MAKE) nstream   "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd OPENMP/Reduce;           $(MAKE) reduce    "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd OPENMP/RefCount_shared;  $(MAKE) shared    "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd OPENMP/RefCount_private; $(MAKE) private   "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd OPENMP/Stencil;          $(MAKE) stencil   "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd OPENMP/Transpose;        $(MAKE) transpose "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd OPENMP/Random;           $(MAKE) random    "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd OPENMP/Sparse;           $(MAKE) sparse    "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd OPENMP/Synch_global;     $(MAKE) global    "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd OPENMP/Synch_p2p;        $(MAKE) p2p       "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd OPENMP/Branch;           $(MAKE) branch    "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"  \
                                                      "MATRIX_RANK         = $(matrix_rank)"        \
                                                      "NUMBER_OF_FUNCTIONS = $(number_of_functions)"

allcharm++: 
	cd CHARM++/Synch_p2p;       $(MAKE) p2p       "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd CHARM++/Stencil;         $(MAKE) stencil   "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd CHARM++/Transpose;       $(MAKE) transpose "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"


allserial: 
	cd SERIAL/DGEMM;            $(MAKE) dgemm     "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd SERIAL/Nstream;          $(MAKE) nstream   "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd SERIAL/Reduce;           $(MAKE) reduce    "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd SERIAL/Stencil;          $(MAKE) stencil   "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd SERIAL/Transpose;        $(MAKE) transpose "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd SERIAL/Random;           $(MAKE) random    "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd SERIAL/Sparse;           $(MAKE) sparse    "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd SERIAL/Synch_p2p;        $(MAKE) p2p       "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"
	cd SERIAL/Branch;           $(MAKE) branch    "DEFAULT_OPT_FLAGS   = $(default_opt_flags)"  \
                                                      "MATRIX_RANK         = $(matrix_rank)"        \
                                                      "NUMBER_OF_FUNCTIONS = $(number_of_functions)"

clean:
	cd MPI/DGEMM;               $(MAKE) clean
	cd MPI/Nstream;             $(MAKE) clean
	cd MPI/Reduce;              $(MAKE) clean
	cd MPI/Stencil;             $(MAKE) clean
	cd MPI/Transpose;           $(MAKE) clean
	cd MPI/Random;              $(MAKE) clean
	cd MPI/Sparse;              $(MAKE) clean
	cd MPI/Synch_global;        $(MAKE) clean
	cd MPI/Synch_p2p;           $(MAKE) clean
	cd MPI/Branch;              $(MAKE) clean
	cd MPIRMA/Stencil;          $(MAKE) clean
	cd MPIRMA/Synch_p2p;        $(MAKE) clean
	cd MPISHM/Stencil;          $(MAKE) clean
	cd MPISHM/Synch_p2p;        $(MAKE) clean
	cd CHARM++/Stencil;         $(MAKE) clean
	cd CHARM++/Synch_p2p;       $(MAKE) clean
	cd CHARM++/Transpose;       $(MAKE) clean
	cd MPIOPENMP/Nstream;       $(MAKE) clean
	cd MPIOPENMP/Stencil;       $(MAKE) clean
	cd MPIOPENMP/Transpose;     $(MAKE) clean
	cd MPIOPENMP/Synch_p2p;     $(MAKE) clean
	cd OPENMP/DGEMM;            $(MAKE) clean
	cd OPENMP/Nstream;          $(MAKE) clean
	cd OPENMP/Reduce;           $(MAKE) clean
	cd OPENMP/RefCount_shared;  $(MAKE) clean
	cd OPENMP/RefCount_private; $(MAKE) clean
	cd OPENMP/Stencil;          $(MAKE) clean
	cd OPENMP/Transpose;        $(MAKE) clean
	cd OPENMP/Random;           $(MAKE) clean
	cd OPENMP/Sparse;           $(MAKE) clean
	cd OPENMP/Synch_global;     $(MAKE) clean
	cd OPENMP/Synch_p2p;        $(MAKE) clean
	cd OPENMP/Branch;           $(MAKE) clean
	cd SERIAL/DGEMM;            $(MAKE) clean
	cd SERIAL/Nstream;          $(MAKE) clean
	cd SERIAL/Reduce;           $(MAKE) clean
	cd SERIAL/Stencil;          $(MAKE) clean
	cd SERIAL/Transpose;        $(MAKE) clean
	cd SERIAL/Random;           $(MAKE) clean
	cd SERIAL/Sparse;           $(MAKE) clean
	cd SERIAL/Synch_p2p;        $(MAKE) clean
	cd SERIAL/Branch;           $(MAKE) clean

veryclean: clean
	cd MPI/Branch;       $(MAKE) veryclean
	cd OPENMP/Branch;    $(MAKE) veryclean
	cd SERIAL/Branch;    $(MAKE) veryclean
