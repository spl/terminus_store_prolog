#!/usr/bin/env swipl

%%
%% Print the value of the SWIARCH environment variable.
%%

:- current_prolog_flag(arch, Arch),
   current_prolog_flag(executable, Executable),
   format('~s "~s"', [Arch, Executable]),
   halt.
