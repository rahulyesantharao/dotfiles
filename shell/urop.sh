export CXX_FLAGS="-Wall -pedantic -Werror -Wno-variadic-macros -Wno-long-long -Wno-shadow -fPIC"
export CC=gcc-7
export CXX=g++-7
export CLASSPATH=".:~/.local/lib/antlr-4.7.2-complete.jar:$CLASSPATH"
alias antlr='java -jar ~/.local/lib/antlr-4.7.2-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'

# start docker: docker exec -it <name> /bin/bash
