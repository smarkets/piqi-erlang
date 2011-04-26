%% Copyright 2009, 2010, 2011 Anton Lavrik
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

%%
%% @doc Piqi high-level interface
%%
-module(piqi).

-export([start/0, stop/0]).
% utilities
-export([get_command/1]).


% @doc start Piqi application
start() ->
    application:start(piqi).


% @doc stop Piqi application
stop() ->
    application:stop(piqi).


%
% Utilities
%


-ifndef(PIQI_CROSS_PLATFORM).
get_command(Name) -> Name.
-else.
get_command(Name) ->
    PiqiDir =
        case code:lib_dir(piqi) of
            {error, Error} ->
                erlang:error({"can't locate Piqi application: ", Error});
            X -> X
        end,
    KernelName = os:cmd("uname -s"),
    Machine = os:cmd("uname -m"),
    lists:concat([filename:join(PiqiDir, Name), "-", KernelName, "-", Machine]).
-endif.
