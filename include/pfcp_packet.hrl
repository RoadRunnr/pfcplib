%% This Source Code Form is subject to the terms of the Mozilla Public
%% License, v. 2.0. If a copy of the MPL was not distributed with this
%% file, You can obtain one at http://mozilla.org/MPL/2.0/.

%% Copyright 2017, Travelping GmbH <info@travelping.com>

-record(pfcp, {
	  version	:: 'undefined' | 'v1',
	  type		:: atom(),
	  seid		:: 'undefined' | 0..16#ffffffffffffffff,
	  seq_no	:: 0..16#ffffff,
	  ie		:: [term()] | map()
	 }).

-record(f_teid, {
	  teid       :: 'choose' | 0..16#ffffffff,
	  ipv6       :: 'undefined' | 'choose' | inet:ip6_address(),
	  ipv4       :: 'undefined' | 'choose' | inet:ip4_address(),
	  choose_id  :: 'undefined' | 0..16#ff
	 }).

-record(sdf_filter, {
	  flow_description         :: binary(),
	  tos_traffic_class        :: 0..16#ffff,
	  security_parameter_index :: 0..16#ffffffff,
	  flow_label               :: 0..16#ffffff
	 }).

-record(volume_threshold, {
	  total		:: 0..16#ffffffffffffffff,
	  uplink	:: 0..16#ffffffffffffffff,
	  downlink	:: 0..16#ffffffffffffffff
	 }).

-record(subsequent_volume_threshold, {
	  total		:: 0..16#ffffffffffffffff,
	  uplink	:: 0..16#ffffffffffffffff,
	  downlink	:: 0..16#ffffffffffffffff
	 }).

-record(downlink_data_service_information, {
	  value :: 0..16#3f,
	  qfi :: 0..16#3f
	 }).

-record(f_seid, {
	  seid	:: 0..16#ffffffffffffffff,
	  ipv4	:: inet:ip4_address(),
	  ipv6	:: inet:ip6_address()
	 }).

-record(node_id, {
	  id	:: {ipv4 | ipv6 | fqdn, binary()}
	 }).

-record(pfd_contents, {
	  flow			:: binary(),
	  url			:: binary(),
	  domain		:: binary(),
	  custom		:: binary(),
	  dnp			:: binary(),
	  additional_flow	:: [binary()],
	  additional_url	:: [binary()],
	  additional_domain	:: [binary()]
	 }).

-record(fq_csid, {
	  address = {1,1,0}	:: binary() | {MCC :: integer, MNC :: integer, Id :: integer},
	  csid = []		:: [0..16#ffff]
	 }).

-record(volume_measurement, {
	  total		:: 0..16#ffffffffffffffff,
	  uplink	:: 0..16#ffffffffffffffff,
	  downlink	:: 0..16#ffffffffffffffff
	 }).

-record(dropped_dl_traffic_threshold, {
	  packets       :: 0..16#ffffffffffffffff,
	  bytes         :: 0..16#ffffffffffffffff
	 }).

-record(volume_quota, {
	  total		:: 0..16#ffffffffffffffff,
	  uplink	:: 0..16#ffffffffffffffff,
	  downlink	:: 0..16#ffffffffffffffff
	 }).

-record(outer_header_creation, {
	  type		:: 'GTP-U' | 'UDP' | 'IP' | 'Ethernet',
	  teid,
	  ipv4		:: 'undefined' | inet:ip4_address(),
	  ipv6		:: 'undefined' | inet:ip6_address(),
	  port		:: 0..16#ffff,
	  ctag		:: binary(),
	  stag		:: binary()
	 }).

-record(ue_ip_address, {
	  type		:: 'undefined' | 'src' | 'dst',
	  ipv4		:: 'undefined' | inet:ip4_address(),
	  ipv6		:: 'undefined' | inet:ip6_address(),
	  ipv6_pd_bits	:: 'undefined' | 0..128
	 }).

-record(packet_rate, {
	  ul_time_unit,
	  ul_max_packet_rate,
	  dl_time_unit,
	  dl_max_packet_rate
	 }).

-record(dl_flow_level_marking, {
	  traffic_class,
	  service_class_indicator
	 }).

-record(remote_gtp_u_peer, {
	  ipv4			:: inet:ip4_address(),
	  ipv6			:: inet:ip6_address(),
	  destination_interface :: atom(),
	  network_instance	:: binary()
	 }).

-record(failed_rule_id, {
	  type	:: 'pdr' | 'far' | 'qer' | 'urr' | 'bar',
	  id	:: integer()
	 }).

-record(user_plane_ip_resource_information, {
	  teid_range,
	  ipv4			:: inet:ip4_address(),
	  ipv6			:: inet:ip6_address(),
	  network_instance	:: binary()
	 }).

-record(subsequent_volume_quota, {
	  total		:: 0..16#ffffffffffffffff,
	  uplink	:: 0..16#ffffffffffffffff,
	  downlink	:: 0..16#ffffffffffffffff
	 }).

-record(mac_address, {
	  source_mac,
	  destination_mac,
	  upper_source_mac,
	  upper_destination_mac
	 }).

-record(c_tag, {
	  pcp		:: 'undefined' | 0..7,
	  dei		:: 'undefined' | 0..1,
	  vid		:: 'undefined' | 0..16#fff
	 }).

-record(s_tag, {
	  pcp		:: 0..16#fff,
	  dei		:: 0..1,
	  vid		:: 0..16#fff
	 }).

-record(user_id, {
	  imsi		:: 'undefined' | binary(),
	  imei		:: 'undefined' | binary(),
	  msisdn	:: 'undefined' | binary(),
	  nai		:: 'undefined' | binary()
	 }).

-record(tp_packet_measurement, {
	  total		:: 0..16#ffffffffffffffff,
	  uplink	:: 0..16#ffffffffffffffff,
	  downlink	:: 0..16#ffffffffffffffff
	 }).

-record(alternative_smf_ip_address, {
	  ipv4	:: inet:ip4_address(),
	  ipv6	:: inet:ip6_address()
	 }).

%% The following code is auto-generated. DO NOT EDIT

%% -include("pfcp_packet_v1_gen.hrl").

-record(create_pdr, {
	  group
}).

-record(pdi, {
	  group
}).

-record(create_far, {
	  group
}).

-record(forwarding_parameters, {
	  group
}).

-record(duplicating_parameters, {
	  group
}).

-record(create_urr, {
	  group
}).

-record(create_qer, {
	  group
}).

-record(created_pdr, {
	  group
}).

-record(update_pdr, {
	  group
}).

-record(update_far, {
	  group
}).

-record(update_forwarding_parameters, {
	  group
}).

-record(update_bar_response, {
	  group
}).

-record(update_urr, {
	  group
}).

-record(update_qer, {
	  group
}).

-record(remove_pdr, {
	  group
}).

-record(remove_far, {
	  group
}).

-record(remove_urr, {
	  group
}).

-record(remove_qer, {
	  group
}).

-record(pfcp_cause, {
	  cause = 'Reserved'
}).

-record(source_interface, {
	  interface = 'Access'
}).

-record(network_instance, {
	  instance = <<>>
}).

-record(application_id, {
	  id = <<>>
}).

-record(gate_status, {
	  ul = 'OPEN',
	  dl = 'OPEN'
}).

-record(mbr, {
	  ul = 0,
	  dl = 0
}).

-record(gbr, {
	  ul = 0,
	  dl = 0
}).

-record(qer_correlation_id, {
	  id = 0
}).

-record(precedence, {
	  precedence = 0
}).

-record(transport_level_marking, {
	  tos = 0
}).

-record(time_threshold, {
	  threshold = 0
}).

-record(monitoring_time, {
	  time = 0
}).

-record(subsequent_time_threshold, {
	  threshold = 0
}).

-record(inactivity_detection_time, {
	  time = 0
}).

-record(reporting_triggers, {
	  linked_usage_reporting = 0,
	  dropped_dl_traffic_threshold = 0,
	  stop_of_traffic = 0,
	  start_of_traffic = 0,
	  quota_holding_time = 0,
	  time_threshold = 0,
	  volume_threshold = 0,
	  periodic_reporting = 0,
	  event_quota = 0,
	  event_threshold = 0,
	  mac_addresses_reporting = 0,
	  envelope_closure = 0,
	  time_quota = 0,
	  volume_quota = 0
}).

-record(redirect_information, {
	  type = 'IPv4',
	  address = <<>>,
	  other_address = <<>>
}).

-record(report_type, {
	  upir = 0,
	  erir = 0,
	  usar = 0,
	  dldr = 0
}).

-record(offending_ie, {
	  type = 0
}).

-record(forwarding_policy, {
	  policy_identifier = <<>>
}).

-record(destination_interface, {
	  interface = 'Access'
}).

-record(up_function_features, {
	  treu = 0,
	  heeu = 0,
	  pfdm = 0,
	  ftup = 0,
	  trst = 0,
	  dlbd = 0,
	  ddnd = 0,
	  bucp = 0,
	  epfar = 0,
	  pfde = 0,
	  frrt = 0,
	  trace = 0,
	  quoac = 0,
	  udbc = 0,
	  pdiu = 0,
	  empu = 0,
	  sset = 0,
	  ueip = 0,
	  adpdp = 0,
	  dpdra = 0
}).

-record(apply_action, {
	  dupl = 0,
	  nocp = 0,
	  buff = 0,
	  forw = 0,
	  drop = 0
}).

-record(downlink_data_notification_delay, {
	  delay = 0
}).

-record(dl_buffering_duration, {
	  dl_buffer_unit = '2 seconds',
	  dl_buffer_value = 0
}).

-record(dl_buffering_suggested_packet_count, {
	  count = 0
}).

-record(sxsmreq_flags, {
	  qaurr = 0,
	  sndem = 0,
	  drobu = 0
}).

-record(sxsrrsp_flags, {
	  drobu = 0
}).

-record(load_control_information, {
	  group
}).

-record(sequence_number, {
	  number = 0
}).

-record(metric, {
	  metric = 0
}).

-record(overload_control_information, {
	  group
}).

-record(timer, {
	  timer_unit = '2 seconds',
	  timer_value = 0
}).

-record(pdr_id, {
	  id = 0
}).

-record(application_id_pfds, {
	  group
}).

-record(pfd_context, {
	  group
}).

-record(measurement_method, {
	  event = 0,
	  volum = 0,
	  durat = 0
}).

-record(usage_report_trigger, {
	  immer = 0,
	  droth = 0,
	  stopt = 0,
	  start = 0,
	  quhti = 0,
	  timth = 0,
	  volth = 0,
	  perio = 0,
	  eveth = 0,
	  macar = 0,
	  envcl = 0,
	  monit = 0,
	  termr = 0,
	  liusa = 0,
	  timqu = 0,
	  volqu = 0,
	  tebur = 0,
	  evequ = 0
}).

-record(measurement_period, {
	  period = 0
}).

-record(duration_measurement, {
	  duration = 0
}).

-record(application_detection_information, {
	  group
}).

-record(time_of_first_packet, {
	  time = 0
}).

-record(time_of_last_packet, {
	  time = 0
}).

-record(quota_holding_time, {
	  time = 0
}).

-record(time_quota, {
	  quota = 0
}).

-record(start_time, {
	  time = 0
}).

-record(end_time, {
	  time = 0
}).

-record(query_urr, {
	  group
}).

-record(usage_report_smr, {
	  group
}).

-record(usage_report_sdr, {
	  group
}).

-record(usage_report_srr, {
	  group
}).

-record(urr_id, {
	  id = 0
}).

-record(linked_urr_id, {
	  id = 0
}).

-record(downlink_data_report, {
	  group
}).

-record(create_bar, {
	  group
}).

-record(update_bar_request, {
	  group
}).

-record(remove_bar, {
	  group
}).

-record(bar_id, {
	  id = 0
}).

-record(cp_function_features, {
	  sset = 0,
	  epfar = 0,
	  ovrl = 0,
	  load = 0
}).

-record(usage_information, {
	  ube = 0,
	  uae = 0,
	  aft = 0,
	  bef = 0
}).

-record(application_instance_id, {
	  id = <<>>
}).

-record(flow_information, {
	  direction = 'Unspecified',
	  flow = <<>>
}).

-record(outer_header_removal, {
	  header = 'GTP-U/UDP/IPv4',
	  pdu_session_container = 0
}).

-record(recovery_time_stamp, {
	  time = 0
}).

-record(header_enrichment, {
	  header_type = 'HTTP',
	  name = <<>>,
	  value = <<>>
}).

-record(error_indication_report, {
	  group
}).

-record(measurement_information, {
	  istm = 0,
	  radi = 0,
	  inam = 0,
	  mbqe = 0
}).

-record(node_report_type, {
	  upfr = 0
}).

-record(user_plane_path_failure_report, {
	  group
}).

-record(ur_seqn, {
	  number = 0
}).

-record(update_duplicating_parameters, {
	  group
}).

-record(activate_predefined_rules, {
	  name = <<>>
}).

-record(deactivate_predefined_rules, {
	  name = <<>>
}).

-record(far_id, {
	  id = 0
}).

-record(qer_id, {
	  id = 0
}).

-record(oci_flags, {
	  aoci = 0
}).

-record(sx_association_release_request, {
	  urss = 0,
	  sarr = 0
}).

-record(graceful_release_period, {
	  release_timer_unit = '2 seconds',
	  release_timer_value = 0
}).

-record(pdn_type, {
	  pdn_type = 'IPv4'
}).

-record(time_quota_mechanism, {
	  base_time_interval_type = 'CTP',
	  interval = 0
}).

-record(user_plane_inactivity_timer, {
	  timer = 0
}).

-record(aggregated_urrs, {
	  group
}).

-record(multiplier, {
	  digits = 0,
	  exponent = 0
}).

-record(aggregated_urr_id, {
	  id = 0
}).

-record(subsequent_time_quota, {
	  quota = 0
}).

-record(rqi, {
	  rqi = 0
}).

-record(qfi, {
	  qfi = 0
}).

-record(query_urr_reference, {
	  reference = 0
}).

-record(additional_usage_reports_information, {
	  auri = 0,
	  reports = 0
}).

-record(create_traffic_endpoint, {
	  group
}).

-record(created_traffic_endpoint, {
	  group
}).

-record(update_traffic_endpoint, {
	  group
}).

-record(remove_traffic_endpoint, {
	  group
}).

-record(traffic_endpoint_id, {
	  id = 0
}).

-record(ethernet_packet_filter, {
	  group
}).

-record(ethertype, {
	  type = 0
}).

-record(proxying, {
	  ins = 0,
	  arp = 0
}).

-record(ethernet_filter_id, {
	  id = 0
}).

-record(ethernet_filter_properties, {
	  bide = 0
}).

-record(suggested_buffering_packets_count, {
	  count = 0
}).

-record(ethernet_pdu_session_information, {
	  ethi = 0
}).

-record(ethernet_traffic_information, {
	  group
}).

-record(mac_addresses_detected, {
	  macs = []
}).

-record(mac_addresses_removed, {
	  macs = []
}).

-record(ethernet_inactivity_timer, {
	  timer = 0
}).

-record(additional_monitoring_time, {
	  group
}).

-record(event_quota, {
	  quota = 0
}).

-record(event_threshold, {
	  threshold = 0
}).

-record(subsequent_event_quota, {
	  quota = 0
}).

-record(subsequent_event_threshold, {
	  threshold = 0
}).

-record(trace_information, {
	  mccmnc,
	  trace_id = 0,
	  triggering_events = <<>>,
	  session_trace_depth = 0,
	  list_of_interfaces = <<>>,
	  ip_address_of_trace_collection_entity = <<>>
}).

-record(framed_route, {
	  framed_route = <<>>
}).

-record(framed_routing, {
	  framed_routing = 0
}).

-record(framed_ipv6_route, {
	  framed_ipv6_route = <<>>
}).

-record(event_time_stamp, {
	  time = 0
}).

-record(averaging_window, {
	  averaging_window = 0
}).

-record(paging_policy_indicator, {
	  ppi = 0
}).

-record(apn_dnn, {
	  apn_dnn
}).

-record(tgpp_interface_type, {
	  tgpp_interface_type = 'S1-U'
}).

-record(pfcpsrreq_flags, {
	  psdbu = 0
}).

-record(pfcpaureq_flags, {
	  parps = 0
}).

-record(activation_time, {
	  time = 0
}).

-record(deactivation_time, {
	  time = 0
}).

-record(create_mar, {
	  group
}).

-record(access_forwarding_action_information_1, {
	  group
}).

-record(access_forwarding_action_information_2, {
	  group
}).

-record(remove_mar, {
	  group
}).

-record(update_mar, {
	  group
}).

-record(mar_id, {
	  id = 0
}).

-record(steering_functionality, {
	  steering_functionality = 'ATSSS-LL'
}).

-record(steering_mode, {
	  steering_mode = 'Active-Standby'
}).

-record(weight, {
	  weight = 0
}).

-record(priority, {
	  priority_value = 'Active'
}).

-record(update_access_forwarding_action_information_1, {
	  group
}).

-record(update_access_forwarding_action_information_2, {
	  group
}).

-record(ue_ip_address_pool_identity, {
	  identity = <<>>
}).

-record(tp_build_id, {
	  id = <<>>
}).

-record(tp_now, {
	  now
}).

-record(tp_start, {
	  start
}).

-record(tp_stop, {
	  stop
}).
