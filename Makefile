
all: fast_derive

fast_derive: jl_fd.jl
	julia jl_fd.jl
