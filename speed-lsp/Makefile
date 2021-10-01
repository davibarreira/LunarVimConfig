JULIA=$(shell which julia)
JULIA_PROJECT="~/.julia/environments/v1.6/"
default: languageserver.so

languageserver.so: Manifest.toml packagecompiler/Manifest.toml packagecompiler/precompile_statements.jl
	JULIA_LOAD_PATH=${PWD}:${PWD}/packagecompiler:@stdlib ${JULIA} -e 'using PackageCompiler; PackageCompiler.create_sysimage([:LanguageServer], sysimage_path="languageserver.so", precompile_statements_file="packagecompiler/precompile_statements.jl")'

Manifest.toml: Project.toml
	JULIA_LOAD_PATH=${PWD}/Project.toml:@stdlib ${JULIA} -e 'using Pkg; Pkg.instantiate()'

Project.toml:
	JULIA_LOAD_PATH=${PWD}/Project.toml:@stdlib ${JULIA} -e 'using Pkg; Pkg.add("LanguageServer");'

packagecompiler/Manifest.toml: packagecompiler/Project.toml
	JULIA_LOAD_PATH=${PWD}/packagecompiler/Project.toml:@stdlib ${JULIA} -e 'using Pkg; Pkg.instantiate()'

packagecompiler/Project.toml:
	mkdir -p packagecompiler
	JULIA_LOAD_PATH=${PWD}/packagecompiler/Project.toml:@stdlib ${JULIA} -e 'using Pkg; Pkg.add("PackageCompiler")'

packagecompiler/precompile_statements.jl: Manifest.toml bin/julia
	TMPDIR=$(shell mktemp -d) && \
	cd $${TMPDIR} && \
	JULIA_LOAD_PATH=: ${JULIA} -e 'using Pkg; Pkg.generate("Example")' 2> /dev/null && \
	cd Example && \
	JULIA_LOAD_PATH=$${PWD}:@stdlib ${JULIA} -e 'using Pkg; Pkg.add(["JSON", "fzf_jll", "Random", "Zlib_jll"])' 2> /dev/null && \
	JULIA_LOAD_PATH=$${PWD}:@stdlib ${JULIA} -e 'using Pkg; Pkg.precompile()' 2> /dev/null && \
	echo "module Example" > src/Example.jl && \
	echo "" >> src/Example.jl && \
	echo "import JSON" >> src/Example.jl && \
	echo "import fzf_jll" >> src/Example.jl && \
	echo "using Random" >> src/Example.jl && \
	echo "using Zlib_jll" >> src/Example.jl && \
	echo "" >> src/Example.jl && \
	echo "function hello(who, notused)" >> src/Example.jl && \
	echo "    println(\"hello\", who)" >> src/Example.jl && \
	echo "    shuffle([1, 2, 3])" >> src/Example.jl && \
	echo "    shoffle([1, 2, 3])" >> src/Example.jl && \
	echo "    fzzf = fzf_jll.fzzf()" >> src/Example.jl && \
	echo "    fzf = fzf_jll.fzf(1)" >> src/Example.jl && \
	echo "    JSON.print(stdout, Dict(\"hello\" => [1, 2, 3]), 2, 123)" >> src/Example.jl && \
	echo "    JSON.print(stdout, Dict(\"hello\" => [1, 2, 3]))" >> src/Example.jl && \
	echo "    hi(who)" >> src/Example.jl && \
	echo "    return Zlib_jll.libz" >> src/Example.jl && \
	echo "end" >> src/Example.jl && \
	echo "" >> src/Example.jl && \
	echo "end # module" >> src/Example.jl && \
	JULIA_TRACE_COMPILE=1 lvim src/Example.jl && \
	rm -rf $${TMPDIR}

bin/julia:
	mkdir -p bin
	rm -f bin/julia
	echo "#!/bin/bash" > bin/julia
	echo "JULIA=${JULIA}" >> bin/julia
	echo "if [[ \$${JULIA_TRACE_COMPILE} = \"1\" ]]; then" >> bin/julia
	echo "    exec \$${JULIA} --trace-compile=${PWD}/packagecompiler/precompile_statements.jl \"\$$@\"" >> bin/julia
	echo "elif [[ -f ${PWD}/languageserver.so ]]; then" >> bin/julia
	echo "    exec \$${JULIA} --sysimage=${PWD}/languageserver.so \"\$$@\"" >> bin/julia
	echo "else" >> bin/julia
	echo "    exec \$${JULIA} \"\$$@\"" >> bin/julia
	echo "fi" >> bin/julia
	chmod +x bin/julia

clean:
	rm -rf languageserver.so packagecompiler bin

.PHONY: clean default
