%% Copyright 2017,2019 Travelping GmbH <info@travelping.com>

%% This program is free software; you can redistribute it and/or
%% modify it under the terms of the GNU General Public License
%% as published by the Free Software Foundation; either version
%% 2 of the License, or (at your option) any later version.

-module(pfcp_msg_SUITE).

-compile([export_all, nowarn_export_all]).

-include_lib("common_test/include/ct.hrl").
-include_lib("pfcplib/include/pfcp_packet.hrl").

%%%===================================================================
%%% API
%%%===================================================================

init_per_suite(Config) ->
    ct_property_test:init_per_suite(Config).

end_per_suite(_Config) ->
    ok.


all() ->
    [msg_enc_dec, validation, compat].

%%%===================================================================
%%% Tests
%%%===================================================================

-define(match(Guard, Expr),
	((fun () ->
		  case (Expr) of
		      Guard -> ok;
		      V -> ct:pal("MISMATCH(~s:~b, ~s)~nExpected: ~p~nActual:   ~p~n",
				  [?FILE, ?LINE, ??Expr, ??Guard, V]),
			   error(badmatch)
		  end
	  end)())).

%%--------------------------------------------------------------------
msg_enc_dec() ->
    [{doc, "Check that Message encoding/decoding matches"}].
msg_enc_dec(Config) ->
    ct_property_test:quickcheck(pfcplib_prop:enc_dec_prop(Config), Config).

%%--------------------------------------------------------------------
validation() ->
    [{doc, "Check that Message validation works"}].

validation(_Config) ->
    Msg1 = #pfcp{type = heartbeat_request, ie = []},
    ?match({'EXIT', {badarg, _}}, (catch pfcp_packet:validate('Sxb', Msg1))),

    Msg2 = #pfcp{type = heartbeat_request, ie = #{}},
    ?match({'EXIT', {badarg, _}}, (catch pfcp_packet:validate('Sxb', Msg2))),

    Msg3 = #pfcp{type = heartbeat_request, ie = [#recovery_time_stamp{}, #recovery_time_stamp{}]},
    ?match(ok, (catch pfcp_packet:validate('Sxb', Msg3))),

    Msg4 = #pfcp{type = heartbeat_request,
		 ie = #{recovery_time_stamp => #recovery_time_stamp{}}},
    ?match(ok, (catch pfcp_packet:validate('Sxb', Msg4))),

    Msg5 = #pfcp{type = heartbeat_request,
		 ie = #{recovery_time_stamp => [#recovery_time_stamp{}]}},
    ?match(ok, (catch pfcp_packet:validate('Sxb', Msg5))),

    Msg6 = #pfcp{type = session_deletion_response,
		 ie = #{pfcp_cause                   => #pfcp_cause{},
			load_control_information     => #load_control_information{},
			offending_ie                 => #offending_ie{},
			overload_control_information => #overload_control_information{},
			recovery_time_stamp          => []
		       }},
    ?match(ok, (catch pfcp_packet:validate('Sxb', Msg6))),

    Msg7 = #pfcp{type = session_deletion_response,
		 ie = #{pfcp_cause                   => #pfcp_cause{},
			load_control_information     => [#load_control_information{}],
			offending_ie                 => [#offending_ie{}, #offending_ie{}],
			overload_control_information => []
		       }},
    ?match(ok, (catch pfcp_packet:validate('Sxb', Msg7))),

    Msg8 = #pfcp{type = session_deletion_response, ie = #{pfcp_cause => []}},
    ?match({'EXIT', {badarg, _}}, (catch pfcp_packet:validate('Sxb', Msg8))),

    Msg9 = #pfcp{type = session_modification_request, ie = #{}},
    ?match(ok, (catch pfcp_packet:validate('Sxb', Msg9))),

    Msg10 = #pfcp{type = session_modification_request,
		  ie = #{update_pdr =>
			     #update_pdr{
				group =
				    #{pdr_id => #pdr_id{}}
			       }
			}},
    ?match(ok, (catch pfcp_packet:validate('Sxb', Msg10))),

    Msg11 = #pfcp{type = session_modification_request,
		  ie = #{update_pdr =>
			     #update_pdr{
				group =
				    #{pdr_id => #pdr_id{}}
			       },
			 update_far =>
			     #update_far{
				group =
				    #{far_id => #far_id{},
				      update_forwarding_parameters =>
					  #update_forwarding_parameters{
					    group =
						 #{destination_interface =>
						       #destination_interface{}
						  }
					    }
				     }
			       }
			}},
    ?match(ok, (catch pfcp_packet:validate('Sxb', Msg11))),

    Msg12 = #pfcp{type = session_modification_request,
		  ie = #{update_pdr =>
			     #update_pdr{
				group =
				    #{urr_id => #urr_id{}}
			       }
			}},
    ?match({'EXIT', {badarg, _}}, (catch pfcp_packet:validate('Sxb', Msg12))),

    %% Usage Report is missing Mandatory IEs
    Msg13 = #pfcp{type = session_deletion_response,
		 ie = #{pfcp_cause                   => #pfcp_cause{},
			load_control_information     => #load_control_information{},
			offending_ie                 => #offending_ie{},
			overload_control_information => #overload_control_information{},
			usage_report_sdr             => #usage_report_sdr{},
			recovery_time_stamp          => []
		       }},
    ?match({'EXIT', {badarg, _}}, (catch pfcp_packet:validate('Sxb', Msg13))),

    Msg14 = #pfcp{type = session_modification_request, ie = []},
    ?match(ok, (catch pfcp_packet:validate('Sxb', Msg14))),

    Msg15 = #pfcp{type = session_modification_request,
		  ie = [#update_pdr{group = [#pdr_id{}]}]},
    ?match(ok, (catch pfcp_packet:validate('Sxb', Msg15))),

    Msg16 = #pfcp{type = session_modification_request,
		  ie = [#update_pdr{group = [#pdr_id{}]},
			#update_far{
			   group =
			       [#far_id{},
				#update_forwarding_parameters{
				   group = [#destination_interface{}]}]}]},
    ?match(ok, (catch pfcp_packet:validate('Sxb', Msg16))),

    Msg17 = #pfcp{type = session_modification_request,
		  ie = [#update_pdr{group = [#urr_id{}]}]},
    ?match({'EXIT', {badarg, _}}, (catch pfcp_packet:validate('Sxb', Msg17))),

    %% Usage Report is missing Mandatory IEs
    Msg18 = #pfcp{type = session_deletion_response,
		  ie = [#pfcp_cause{},
			#load_control_information{},
			#offending_ie{},
			#overload_control_information{},
			#usage_report_sdr{}]},
    ?match({'EXIT', {badarg, _}}, (catch pfcp_packet:validate('Sxb', Msg18))),
    ok.

compat() ->
    [{doc, "Check backwads compatibility for extended IEs"}].
compat(_Config) ->
    %% rel. 15.2:
    %% pfcp_packet:encode(#pfcp{version = v1, seq_no = 0,type = session_report_request, ie = [#up_function_features{}]}).

    R1 = pfcp_packet:decode(<<32,56,0,10,0,0,0,0,0,43,0,2,0,0>>),
    ?match(#pfcp{version = v1, seq_no = 0,
		 type = session_report_request,
		 ie = #{up_function_features := _}}, R1),

    %% rel. 15.2:
    %% pfcp_packet:encode(#pfcp{version = v1, seq_no = 0,type = session_report_request, ie = [#usage_report_trigger{}]}).
    R2 = pfcp_packet:decode(<<32,56,0,10,0,0,0,0,0,63,0,2,0,0>>),
    ?match(#pfcp{version = v1, seq_no = 0,
		 type = session_report_request,
		 ie = #{usage_report_trigger := _}}, R2),

    %% rel. 15.2:
    %% pfcp_packet:encode(#pfcp{version = v1, seq_no = 0,type = session_report_request, ie = [#outer_header_removal{}]}).
    R3 = pfcp_packet:decode(<<32,56,0,9,0,0,0,0,0,95,0,1,0>>),
    ?match(#pfcp{version = v1, seq_no = 0,
		 type = session_report_request,
		 ie = #{outer_header_removal := _}}, R3),
    ok.
