(*---------------------------------------------------------------------------
   Copyright (c) 2014 Daniel C. Bünzli. All rights reserved.
   Distributed under the ISC license, see terms at the end of the file.
   %%NAME%% %%VERSION%%
  ---------------------------------------------------------------------------*)

(** DICOM data

    {b Warning.} This is a private module do not use directly. *)

type vr =
  [ `AE | `AS | `AT | `CS | `DA | `DS | `DT | `FD | `FL | `IS | `LO | `LT
  | `OB | `OF | `OW | `PN | `SH | `SL | `SQ | `SS | `ST | `TM | `UI | `UL
  | `UN | `US | `UT | `OB_or_OW | `US_or_SS | `US_or_OW | `US_or_SS_or_OW ]

type vm =
  [ `One | `One_2 | `One_3 | `One_8 | `One_32 | `One_99 | `One_n
  | `Two | `Two_n | `Two_2n | `Three | `Three_n | `Three_3n | `Four
  | `Six | `Six_n | `Nine | `Sixteen ]

val elements : (int32 * (string * string * vr * vm * bool)) list
(** [elements] pair data element tags with their specification
    [(name, keyword, vr, vm, retired)] as found in PS 3.6 2011 §6,7,8 and
    PS 3.7 2011 Annex E. *)

val element_ranges : (int32 * int32) list
(** [element_ranges] pairs a tag [t] with a mask [m]. Given a tag [t'] if
    [t' land m = t] then lookup for [t] in {!elements} for its definition. *)

val uid_names : (string * string) list
(** [uid_names] pairs UIDs and their names as found in PS 3.6 2011
    Annex A). *)


module Tag_constants : sig
  val command_group_length : int32
  (** (0000,0000) *)
  val affected_sop_class_uid : int32
  (** (0000,0002) *)
  val requested_sopclass_uid : int32
  (** (0000,0003) *)
  val command_field : int32
  (** (0000,0100) *)
  val message_id : int32
  (** (0000,0110) *)
  val message_id_being_responded_to : int32
  (** (0000,0120) *)
  val move_destination : int32
  (** (0000,0600) *)
  val priority : int32
  (** (0000,0700) *)
  val command_data_set_type : int32
  (** (0000,0800) *)
  val status : int32
  (** (0000,0900) *)
  val offending_element : int32
  (** (0000,0901) *)
  val error_comment : int32
  (** (0000,0902) *)
  val error_id : int32
  (** (0000,0903) *)
  val affected_sop_instance_uid : int32
  (** (0000,1000) *)
  val requested_sop_instance_uid : int32
  (** (0000,1001) *)
  val event_type_id : int32
  (** (0000,1002) *)
  val attribute_identifier_list : int32
  (** (0000,1005) *)
  val action_type_id : int32
  (** (0000,1008) *)
  val number_of_remaining_suboperations : int32
  (** (0000,1020) *)
  val number_of_completed_suboperations : int32
  (** (0000,1021) *)
  val number_of_failed_suboperations : int32
  (** (0000,1022) *)
  val number_of_warning_suboperations : int32
  (** (0000,1023) *)
  val move_originator_application_entity_title : int32
  (** (0000,1030) *)
  val move_originator_message_id : int32
  (** (0000,1031) *)
  val command_length_to_end : int32
  (** (0000,0001) *)
  val command_recognition_code : int32
  (** (0000,0010) *)
  val initiator : int32
  (** (0000,0200) *)
  val receiver : int32
  (** (0000,0300) *)
  val find_location : int32
  (** (0000,0400) *)
  val number_of_matches : int32
  (** (0000,0850) *)
  val response_sequence_number : int32
  (** (0000,0860) *)
  val dialog_receiver : int32
  (** (0000,4000) *)
  val terminal_type : int32
  (** (0000,4010) *)
  val message_set_id : int32
  (** (0000,5010) *)
  val end_message_id : int32
  (** (0000,5020) *)
  val display_format : int32
  (** (0000,5110) *)
  val page_position_id : int32
  (** (0000,5120) *)
  val text_format_id : int32
  (** (0000,5130) *)
  val normal_reverse : int32
  (** (0000,5140) *)
  val add_gray_scale : int32
  (** (0000,5150) *)
  val borders : int32
  (** (0000,5160) *)
  val copies : int32
  (** (0000,5170) *)
  val command_magnification_type : int32
  (** (0000,5180) *)
  val erase : int32
  (** (0000,5190) *)
  val print : int32
  (** (0000,51a0) *)
  val overlays : int32
  (** (0000,51b0) *)
  val file_meta_information_group_length : int32
  (** (0002,0000) *)
  val file_meta_information_version : int32
  (** (0002,0001) *)
  val media_storage_sop_class_uid : int32
  (** (0002,0002) *)
  val media_storage_sop_instance_uid : int32
  (** (0002,0003) *)
  val transfer_syntax_uid : int32
  (** (0002,0010) *)
  val implementation_class_uid : int32
  (** (0002,0012) *)
  val implementation_version_name : int32
  (** (0002,0013) *)
  val source_application_entity_title : int32
  (** (0002,0016) *)
  val private_information_creator_uid : int32
  (** (0002,0100) *)
  val private_information : int32
  (** (0002,0102) *)
  val file_set_id : int32
  (** (0004,1130) *)
  val file_set_descriptor_file_id : int32
  (** (0004,1141) *)
  val specific_character_set_of_file_set_descriptor_file : int32
  (** (0004,1142) *)
  val offset_of_the_first_directory_record_of_the_root_directory_entity : int32
  (** (0004,1200) *)
  val offset_of_the_last_directory_record_of_the_root_directory_entity : int32
  (** (0004,1202) *)
  val file_set_consistency_flag : int32
  (** (0004,1212) *)
  val directory_record_sequence : int32
  (** (0004,1220) *)
  val offset_of_the_next_directory_record : int32
  (** (0004,1400) *)
  val record_in_use_flag : int32
  (** (0004,1410) *)
  val offset_of_referenced_lower_level_directory_entity : int32
  (** (0004,1420) *)
  val directory_record_type : int32
  (** (0004,1430) *)
  val private_record_uid : int32
  (** (0004,1432) *)
  val referenced_file_id : int32
  (** (0004,1500) *)
  val mrdr_directory_record_offset : int32
  (** (0004,1504) *)
  val referenced_sop_class_uid_in_file : int32
  (** (0004,1510) *)
  val referenced_sop_instance_uid_in_file : int32
  (** (0004,1511) *)
  val referenced_transfer_syntax_uid_in_file : int32
  (** (0004,1512) *)
  val referenced_related_general_sop_class_uid_in_file : int32
  (** (0004,151a) *)
  val number_of_references : int32
  (** (0004,1600) *)
  val length_to_end : int32
  (** (0008,0001) *)
  val specific_character_set : int32
  (** (0008,0005) *)
  val language_code_sequence : int32
  (** (0008,0006) *)
  val image_type : int32
  (** (0008,0008) *)
  val recognition_code : int32
  (** (0008,0010) *)
  val instance_creation_date : int32
  (** (0008,0012) *)
  val instance_creation_time : int32
  (** (0008,0013) *)
  val instance_creator_uid : int32
  (** (0008,0014) *)
  val sop_class_uid : int32
  (** (0008,0016) *)
  val sop_instance_uid : int32
  (** (0008,0018) *)
  val related_general_sop_class_uid : int32
  (** (0008,001a) *)
  val original_specialized_sop_class_uid : int32
  (** (0008,001b) *)
  val study_date : int32
  (** (0008,0020) *)
  val series_date : int32
  (** (0008,0021) *)
  val acquisition_date : int32
  (** (0008,0022) *)
  val content_date : int32
  (** (0008,0023) *)
  val overlay_date : int32
  (** (0008,0024) *)
  val curve_date : int32
  (** (0008,0025) *)
  val acquisition_date_time : int32
  (** (0008,002a) *)
  val study_time : int32
  (** (0008,0030) *)
  val series_time : int32
  (** (0008,0031) *)
  val acquisition_time : int32
  (** (0008,0032) *)
  val content_time : int32
  (** (0008,0033) *)
  val overlay_time : int32
  (** (0008,0034) *)
  val curve_time : int32
  (** (0008,0035) *)
  val data_set_type : int32
  (** (0008,0040) *)
  val data_set_subtype : int32
  (** (0008,0041) *)
  val nuclear_medicine_series_type : int32
  (** (0008,0042) *)
  val accession_number : int32
  (** (0008,0050) *)
  val issuer_of_accession_number_sequence : int32
  (** (0008,0051) *)
  val query_retrieve_level : int32
  (** (0008,0052) *)
  val retrieve_ae_title : int32
  (** (0008,0054) *)
  val instance_availability : int32
  (** (0008,0056) *)
  val failed_sop_instance_uid_list : int32
  (** (0008,0058) *)
  val modality : int32
  (** (0008,0060) *)
  val modalities_in_study : int32
  (** (0008,0061) *)
  val sop_classes_in_study : int32
  (** (0008,0062) *)
  val conversion_type : int32
  (** (0008,0064) *)
  val presentation_intent_type : int32
  (** (0008,0068) *)
  val manufacturer : int32
  (** (0008,0070) *)
  val institution_name : int32
  (** (0008,0080) *)
  val institution_address : int32
  (** (0008,0081) *)
  val institution_code_sequence : int32
  (** (0008,0082) *)
  val referring_physician_name : int32
  (** (0008,0090) *)
  val referring_physician_address : int32
  (** (0008,0092) *)
  val referring_physician_telephone_numbers : int32
  (** (0008,0094) *)
  val referring_physician_identification_sequence : int32
  (** (0008,0096) *)
  val code_value : int32
  (** (0008,0100) *)
  val coding_scheme_designator : int32
  (** (0008,0102) *)
  val coding_scheme_version : int32
  (** (0008,0103) *)
  val code_meaning : int32
  (** (0008,0104) *)
  val mapping_resource : int32
  (** (0008,0105) *)
  val context_group_version : int32
  (** (0008,0106) *)
  val context_group_local_version : int32
  (** (0008,0107) *)
  val context_group_extension_flag : int32
  (** (0008,010b) *)
  val coding_scheme_uid : int32
  (** (0008,010c) *)
  val context_group_extension_creator_uid : int32
  (** (0008,010d) *)
  val context_identifier : int32
  (** (0008,010f) *)
  val coding_scheme_identification_sequence : int32
  (** (0008,0110) *)
  val coding_scheme_registry : int32
  (** (0008,0112) *)
  val coding_scheme_external_id : int32
  (** (0008,0114) *)
  val coding_scheme_name : int32
  (** (0008,0115) *)
  val coding_scheme_responsible_organization : int32
  (** (0008,0116) *)
  val context_uid : int32
  (** (0008,0117) *)
  val timezone_offset_from_utc : int32
  (** (0008,0201) *)
  val network_id : int32
  (** (0008,1000) *)
  val station_name : int32
  (** (0008,1010) *)
  val study_description : int32
  (** (0008,1030) *)
  val procedure_code_sequence : int32
  (** (0008,1032) *)
  val series_description : int32
  (** (0008,103e) *)
  val series_description_code_sequence : int32
  (** (0008,103f) *)
  val institutional_department_name : int32
  (** (0008,1040) *)
  val physicians_of_record : int32
  (** (0008,1048) *)
  val physicians_of_record_identification_sequence : int32
  (** (0008,1049) *)
  val performing_physician_name : int32
  (** (0008,1050) *)
  val performing_physician_identification_sequence : int32
  (** (0008,1052) *)
  val name_of_physicians_reading_study : int32
  (** (0008,1060) *)
  val physicians_reading_study_identification_sequence : int32
  (** (0008,1062) *)
  val operators_name : int32
  (** (0008,1070) *)
  val operator_identification_sequence : int32
  (** (0008,1072) *)
  val admitting_diagnoses_description : int32
  (** (0008,1080) *)
  val admitting_diagnoses_code_sequence : int32
  (** (0008,1084) *)
  val manufacturer_model_name : int32
  (** (0008,1090) *)
  val referenced_results_sequence : int32
  (** (0008,1100) *)
  val referenced_study_sequence : int32
  (** (0008,1110) *)
  val referenced_performed_procedure_step_sequence : int32
  (** (0008,1111) *)
  val referenced_series_sequence : int32
  (** (0008,1115) *)
  val referenced_patient_sequence : int32
  (** (0008,1120) *)
  val referenced_visit_sequence : int32
  (** (0008,1125) *)
  val referenced_overlay_sequence : int32
  (** (0008,1130) *)
  val referenced_stereometric_instance_sequence : int32
  (** (0008,1134) *)
  val referenced_waveform_sequence : int32
  (** (0008,113a) *)
  val referenced_image_sequence : int32
  (** (0008,1140) *)
  val referenced_curve_sequence : int32
  (** (0008,1145) *)
  val referenced_instance_sequence : int32
  (** (0008,114a) *)
  val referenced_real_world_value_mapping_instance_sequence : int32
  (** (0008,114b) *)
  val referenced_sop_class_uid : int32
  (** (0008,1150) *)
  val referenced_sop_instance_uid : int32
  (** (0008,1155) *)
  val sop_classes_supported : int32
  (** (0008,115a) *)
  val referenced_frame_number : int32
  (** (0008,1160) *)
  val simple_frame_list : int32
  (** (0008,1161) *)
  val calculated_frame_list : int32
  (** (0008,1162) *)
  val time_range : int32
  (** (0008,1163) *)
  val frame_extraction_sequence : int32
  (** (0008,1164) *)
  val multi_frame_source_sop_instance_uid : int32
  (** (0008,1167) *)
  val transaction_uid : int32
  (** (0008,1195) *)
  val failure_reason : int32
  (** (0008,1197) *)
  val failed_sop_sequence : int32
  (** (0008,1198) *)
  val referenced_sop_sequence : int32
  (** (0008,1199) *)
  val studies_containing_other_referenced_instances_sequence : int32
  (** (0008,1200) *)
  val related_series_sequence : int32
  (** (0008,1250) *)
  val lossy_image_compression_retired : int32
  (** (0008,2110) *)
  val derivation_description : int32
  (** (0008,2111) *)
  val source_image_sequence : int32
  (** (0008,2112) *)
  val stage_name : int32
  (** (0008,2120) *)
  val stage_number : int32
  (** (0008,2122) *)
  val number_of_stages : int32
  (** (0008,2124) *)
  val view_name : int32
  (** (0008,2127) *)
  val view_number : int32
  (** (0008,2128) *)
  val number_of_event_timers : int32
  (** (0008,2129) *)
  val number_of_views_in_stage : int32
  (** (0008,212a) *)
  val event_elapsed_times : int32
  (** (0008,2130) *)
  val event_timer_names : int32
  (** (0008,2132) *)
  val event_timer_sequence : int32
  (** (0008,2133) *)
  val event_time_offset : int32
  (** (0008,2134) *)
  val event_code_sequence : int32
  (** (0008,2135) *)
  val start_trim : int32
  (** (0008,2142) *)
  val stop_trim : int32
  (** (0008,2143) *)
  val recommended_display_frame_rate : int32
  (** (0008,2144) *)
  val transducer_position : int32
  (** (0008,2200) *)
  val transducer_orientation : int32
  (** (0008,2204) *)
  val anatomic_structure : int32
  (** (0008,2208) *)
  val anatomic_region_sequence : int32
  (** (0008,2218) *)
  val anatomic_region_modifier_sequence : int32
  (** (0008,2220) *)
  val primary_anatomic_structure_sequence : int32
  (** (0008,2228) *)
  val anatomic_structure_space_or_region_sequence : int32
  (** (0008,2229) *)
  val primary_anatomic_structure_modifier_sequence : int32
  (** (0008,2230) *)
  val transducer_position_sequence : int32
  (** (0008,2240) *)
  val transducer_position_modifier_sequence : int32
  (** (0008,2242) *)
  val transducer_orientation_sequence : int32
  (** (0008,2244) *)
  val transducer_orientation_modifier_sequence : int32
  (** (0008,2246) *)
  val anatomic_structure_space_or_region_code_sequence_trial : int32
  (** (0008,2251) *)
  val anatomic_portal_of_entrance_code_sequence_trial : int32
  (** (0008,2253) *)
  val anatomic_approach_direction_code_sequence_trial : int32
  (** (0008,2255) *)
  val anatomic_perspective_description_trial : int32
  (** (0008,2256) *)
  val anatomic_perspective_code_sequence_trial : int32
  (** (0008,2257) *)
  val anatomic_location_of_examining_instrument_description_trial : int32
  (** (0008,2258) *)
  val anatomic_location_of_examining_instrument_code_sequence_trial : int32
  (** (0008,2259) *)
  val anatomic_structure_space_or_region_modifier_code_sequence_trial : int32
  (** (0008,225A) *)
  val on_axis_background_anatomic_structure_code_sequence_trial : int32
  (** (0008,225C) *)
  val alternate_representation_sequence : int32
  (** (0008,3001) *)
  val irradiation_event_uid : int32
  (** (0008,3010) *)
  val identifying_comments : int32
  (** (0008,4000) *)
  val frame_type : int32
  (** (0008,9007) *)
  val referenced_image_evidence_sequence : int32
  (** (0008,9092) *)
  val referenced_raw_data_sequence : int32
  (** (0008,9121) *)
  val creator_version_uid : int32
  (** (0008,9123) *)
  val derivation_image_sequence : int32
  (** (0008,9124) *)
  val source_image_evidence_sequence : int32
  (** (0008,9154) *)
  val pixel_presentation : int32
  (** (0008,9205) *)
  val volumetric_properties : int32
  (** (0008,9206) *)
  val volume_based_calculation_technique : int32
  (** (0008,9207) *)
  val complex_image_component : int32
  (** (0008,9208) *)
  val acquisition_contrast : int32
  (** (0008,9209) *)
  val derivation_code_sequence : int32
  (** (0008,9215) *)
  val referenced_presentation_state_sequence : int32
  (** (0008,9237) *)
  val referenced_other_plane_sequence : int32
  (** (0008,9410) *)
  val frame_display_sequence : int32
  (** (0008,9458) *)
  val recommended_display_frame_rate_in_float : int32
  (** (0008,9459) *)
  val skip_frame_range_flag : int32
  (** (0008,9460) *)
  val patient_name : int32
  (** (0010,0010) *)
  val patient_id : int32
  (** (0010,0020) *)
  val issuer_of_patient_id : int32
  (** (0010,0021) *)
  val type_of_patient_id : int32
  (** (0010,0022) *)
  val issuer_of_patient_id_qualifiers_sequence : int32
  (** (0010,0024) *)
  val patient_birth_date : int32
  (** (0010,0030) *)
  val patient_birth_time : int32
  (** (0010,0032) *)
  val patient_sex : int32
  (** (0010,0040) *)
  val patient_insurance_plan_code_sequence : int32
  (** (0010,0050) *)
  val patient_primary_language_code_sequence : int32
  (** (0010,0101) *)
  val patient_primary_language_modifier_code_sequence : int32
  (** (0010,0102) *)
  val other_patient_ids : int32
  (** (0010,1000) *)
  val other_patient_names : int32
  (** (0010,1001) *)
  val other_patient_ids_sequence : int32
  (** (0010,1002) *)
  val patient_birth_name : int32
  (** (0010,1005) *)
  val patient_age : int32
  (** (0010,1010) *)
  val patient_size : int32
  (** (0010,1020) *)
  val patient_size_code_sequence : int32
  (** (0010,1021) *)
  val patient_weight : int32
  (** (0010,1030) *)
  val patient_address : int32
  (** (0010,1040) *)
  val insurance_plan_identification : int32
  (** (0010,1050) *)
  val patient_mother_birth_name : int32
  (** (0010,1060) *)
  val military_rank : int32
  (** (0010,1080) *)
  val branch_of_service : int32
  (** (0010,1081) *)
  val medical_record_locator : int32
  (** (0010,1090) *)
  val medical_alerts : int32
  (** (0010,2000) *)
  val allergies : int32
  (** (0010,2110) *)
  val country_of_residence : int32
  (** (0010,2150) *)
  val region_of_residence : int32
  (** (0010,2152) *)
  val patient_telephone_numbers : int32
  (** (0010,2154) *)
  val ethnic_group : int32
  (** (0010,2160) *)
  val occupation : int32
  (** (0010,2180) *)
  val smoking_status : int32
  (** (0010,21A0) *)
  val additional_patient_history : int32
  (** (0010,21B0) *)
  val pregnancy_status : int32
  (** (0010,21C0) *)
  val last_menstrual_date : int32
  (** (0010,21D0) *)
  val patient_religious_preference : int32
  (** (0010,21F0) *)
  val patient_species_description : int32
  (** (0010,2201) *)
  val patient_species_code_sequence : int32
  (** (0010,2202) *)
  val patient_sex_neutered : int32
  (** (0010,2203) *)
  val anatomical_orientation_type : int32
  (** (0010,2210) *)
  val patient_breed_description : int32
  (** (0010,2292) *)
  val patient_breed_code_sequence : int32
  (** (0010,2293) *)
  val breed_registration_sequence : int32
  (** (0010,2294) *)
  val breed_registration_number : int32
  (** (0010,2295) *)
  val breed_registry_code_sequence : int32
  (** (0010,2296) *)
  val responsible_person : int32
  (** (0010,2297) *)
  val responsible_person_role : int32
  (** (0010,2298) *)
  val responsible_organization : int32
  (** (0010,2299) *)
  val patient_comments : int32
  (** (0010,4000) *)
  val examined_body_thickness : int32
  (** (0010,9431) *)
  val clinical_trial_sponsor_name : int32
  (** (0012,0010) *)
  val clinical_trial_protocol_id : int32
  (** (0012,0020) *)
  val clinical_trial_protocol_name : int32
  (** (0012,0021) *)
  val clinical_trial_site_id : int32
  (** (0012,0030) *)
  val clinical_trial_site_name : int32
  (** (0012,0031) *)
  val clinical_trial_subject_id : int32
  (** (0012,0040) *)
  val clinical_trial_subject_reading_id : int32
  (** (0012,0042) *)
  val clinical_trial_time_point_id : int32
  (** (0012,0050) *)
  val clinical_trial_time_point_description : int32
  (** (0012,0051) *)
  val clinical_trial_coordinating_center_name : int32
  (** (0012,0060) *)
  val patient_identity_removed : int32
  (** (0012,0062) *)
  val deidentification_method : int32
  (** (0012,0063) *)
  val deidentification_method_code_sequence : int32
  (** (0012,0064) *)
  val clinical_trial_series_id : int32
  (** (0012,0071) *)
  val clinical_trial_series_description : int32
  (** (0012,0072) *)
  val clinical_trial_protocol_ethics_committee_name : int32
  (** (0012,0081) *)
  val clinical_trial_protocol_ethics_committee_approval_number : int32
  (** (0012,0082) *)
  val consent_for_clinical_trial_use_sequence : int32
  (** (0012,0083) *)
  val distribution_type : int32
  (** (0012,0084) *)
  val consent_for_distribution_flag : int32
  (** (0012,0085) *)
  val cad_file_format : int32
  (** (0014,0023) *)
  val component_reference_system : int32
  (** (0014,0024) *)
  val component_manufacturing_procedure : int32
  (** (0014,0025) *)
  val component_manufacturer : int32
  (** (0014,0028) *)
  val material_thickness : int32
  (** (0014,0030) *)
  val material_pipe_diameter : int32
  (** (0014,0032) *)
  val material_isolation_diameter : int32
  (** (0014,0034) *)
  val material_grade : int32
  (** (0014,0042) *)
  val material_properties_file_id : int32
  (** (0014,0044) *)
  val material_properties_file_format : int32
  (** (0014,0045) *)
  val material_notes : int32
  (** (0014,0046) *)
  val component_shape : int32
  (** (0014,0050) *)
  val curvature_type : int32
  (** (0014,0052) *)
  val outer_diameter : int32
  (** (0014,0054) *)
  val inner_diameter : int32
  (** (0014,0056) *)
  val actual_environmental_conditions : int32
  (** (0014,1010) *)
  val expiry_date : int32
  (** (0014,1020) *)
  val environmental_conditions : int32
  (** (0014,1040) *)
  val evaluator_sequence : int32
  (** (0014,2002) *)
  val evaluator_number : int32
  (** (0014,2004) *)
  val evaluator_name : int32
  (** (0014,2006) *)
  val evaluation_attempt : int32
  (** (0014,2008) *)
  val indication_sequence : int32
  (** (0014,2012) *)
  val indication_number : int32
  (** (0014,2014) *)
  val indication_label : int32
  (** (0014,2016) *)
  val indication_description : int32
  (** (0014,2018) *)
  val indication_type : int32
  (** (0014,201A) *)
  val indication_disposition : int32
  (** (0014,201C) *)
  val indication_roisequence : int32
  (** (0014,201E) *)
  val indication_physical_property_sequence : int32
  (** (0014,2030) *)
  val property_label : int32
  (** (0014,2032) *)
  val coordinate_system_number_of_axes : int32
  (** (0014,2202) *)
  val coordinate_system_axes_sequence : int32
  (** (0014,2204) *)
  val coordinate_system_axis_description : int32
  (** (0014,2206) *)
  val coordinate_system_data_set_mapping : int32
  (** (0014,2208) *)
  val coordinate_system_axis_number : int32
  (** (0014,220A) *)
  val coordinate_system_axis_type : int32
  (** (0014,220C) *)
  val coordinate_system_axis_units : int32
  (** (0014,220E) *)
  val coordinate_system_axis_values : int32
  (** (0014,2210) *)
  val coordinate_system_transform_sequence : int32
  (** (0014,2220) *)
  val transform_description : int32
  (** (0014,2222) *)
  val transform_number_of_axes : int32
  (** (0014,2224) *)
  val transform_order_of_axes : int32
  (** (0014,2226) *)
  val transformed_axis_units : int32
  (** (0014,2228) *)
  val coordinate_system_transform_rotation_and_scale_matrix : int32
  (** (0014,222A) *)
  val coordinate_system_transform_translation_matrix : int32
  (** (0014,222C) *)
  val internal_detector_frame_time : int32
  (** (0014,3011) *)
  val number_of_frames_integrated : int32
  (** (0014,3012) *)
  val detector_temperature_sequence : int32
  (** (0014,3020) *)
  val sensor_name : int32
  (** (0014,3022) *)
  val horizontal_offset_of_sensor : int32
  (** (0014,3024) *)
  val vertical_offset_of_sensor : int32
  (** (0014,3026) *)
  val sensor_temperature : int32
  (** (0014,3028) *)
  val dark_current_sequence : int32
  (** (0014,3040) *)
  val dark_current_counts : int32
  (** (0014,3050) *)
  val gain_correction_reference_sequence : int32
  (** (0014,3060) *)
  val air_counts : int32
  (** (0014,3070) *)
  val kv_used_in_gain_calibration : int32
  (** (0014,3071) *)
  val ma_used_in_gain_calibration : int32
  (** (0014,3072) *)
  val number_of_frames_used_for_integration : int32
  (** (0014,3073) *)
  val filter_material_used_in_gain_calibration : int32
  (** (0014,3074) *)
  val filter_thickness_used_in_gain_calibration : int32
  (** (0014,3075) *)
  val date_of_gain_calibration : int32
  (** (0014,3076) *)
  val time_of_gain_calibration : int32
  (** (0014,3077) *)
  val bad_pixel_image : int32
  (** (0014,3080) *)
  val calibration_notes : int32
  (** (0014,3099) *)
  val pulser_equipment_sequence : int32
  (** (0014,4002) *)
  val pulser_type : int32
  (** (0014,4004) *)
  val pulser_notes : int32
  (** (0014,4006) *)
  val receiver_equipment_sequence : int32
  (** (0014,4008) *)
  val amplifier_type : int32
  (** (0014,400A) *)
  val receiver_notes : int32
  (** (0014,400C) *)
  val pre_amplifier_equipment_sequence : int32
  (** (0014,400E) *)
  val pre_amplifier_notes : int32
  (** (0014,400F) *)
  val transmit_transducer_sequence : int32
  (** (0014,4010) *)
  val receive_transducer_sequence : int32
  (** (0014,4011) *)
  val number_of_elements : int32
  (** (0014,4012) *)
  val element_shape : int32
  (** (0014,4013) *)
  val element_dimension_a : int32
  (** (0014,4014) *)
  val element_dimension_b : int32
  (** (0014,4015) *)
  val element_pitch : int32
  (** (0014,4016) *)
  val measured_beam_dimension_a : int32
  (** (0014,4017) *)
  val measured_beam_dimension_b : int32
  (** (0014,4018) *)
  val location_of_measured_beam_diameter : int32
  (** (0014,4019) *)
  val nominal_frequency : int32
  (** (0014,401A) *)
  val measured_center_frequency : int32
  (** (0014,401B) *)
  val measured_bandwidth : int32
  (** (0014,401C) *)
  val pulser_settings_sequence : int32
  (** (0014,4020) *)
  val pulse_width : int32
  (** (0014,4022) *)
  val excitation_frequency : int32
  (** (0014,4024) *)
  val modulation_type : int32
  (** (0014,4026) *)
  val damping : int32
  (** (0014,4028) *)
  val receiver_settings_sequence : int32
  (** (0014,4030) *)
  val acquired_soundpath_length : int32
  (** (0014,4031) *)
  val acquisition_compression_type : int32
  (** (0014,4032) *)
  val acquisition_sample_size : int32
  (** (0014,4033) *)
  val rectifier_smoothing : int32
  (** (0014,4034) *)
  val dacsequence : int32
  (** (0014,4035) *)
  val dactype : int32
  (** (0014,4036) *)
  val dacgainpoints : int32
  (** (0014,4038) *)
  val dactimepoints : int32
  (** (0014,403A) *)
  val dacamplitude : int32
  (** (0014,403C) *)
  val pre_amplifier_settings_sequence : int32
  (** (0014,4040) *)
  val transmit_transducer_settings_sequence : int32
  (** (0014,4050) *)
  val receive_transducer_settings_sequence : int32
  (** (0014,4051) *)
  val incident_angle : int32
  (** (0014,4052) *)
  val coupling_technique : int32
  (** (0014,4054) *)
  val coupling_medium : int32
  (** (0014,4056) *)
  val coupling_velocity : int32
  (** (0014,4057) *)
  val crystal_center_location_x : int32
  (** (0014,4058) *)
  val crystal_center_location_z : int32
  (** (0014,4059) *)
  val sound_path_length : int32
  (** (0014,405A) *)
  val delay_law_identifier : int32
  (** (0014,405C) *)
  val gate_settings_sequence : int32
  (** (0014,4060) *)
  val gate_threshold : int32
  (** (0014,4062) *)
  val velocity_of_sound : int32
  (** (0014,4064) *)
  val calibration_settings_sequence : int32
  (** (0014,4070) *)
  val calibration_procedure : int32
  (** (0014,4072) *)
  val procedure_version : int32
  (** (0014,4074) *)
  val procedure_creation_date : int32
  (** (0014,4076) *)
  val procedure_expiration_date : int32
  (** (0014,4078) *)
  val procedure_last_modified_date : int32
  (** (0014,407A) *)
  val calibration_time : int32
  (** (0014,407C) *)
  val calibration_date : int32
  (** (0014,407E) *)
  val linacenergy : int32
  (** (0014,5002) *)
  val linacoutput : int32
  (** (0014,5004) *)
  val contrast_bolus_agent : int32
  (** (0018,0010) *)
  val contrast_bolus_agent_sequence : int32
  (** (0018,0012) *)
  val contrast_bolus_administration_route_sequence : int32
  (** (0018,0014) *)
  val body_part_examined : int32
  (** (0018,0015) *)
  val scanning_sequence : int32
  (** (0018,0020) *)
  val sequence_variant : int32
  (** (0018,0021) *)
  val scan_options : int32
  (** (0018,0022) *)
  val mr_acquisition_type : int32
  (** (0018,0023) *)
  val sequence_name : int32
  (** (0018,0024) *)
  val angio_flag : int32
  (** (0018,0025) *)
  val intervention_drug_information_sequence : int32
  (** (0018,0026) *)
  val intervention_drug_stop_time : int32
  (** (0018,0027) *)
  val intervention_drug_dose : int32
  (** (0018,0028) *)
  val intervention_drug_code_sequence : int32
  (** (0018,0029) *)
  val additional_drug_sequence : int32
  (** (0018,002A) *)
  val radionuclide : int32
  (** (0018,0030) *)
  val radiopharmaceutical : int32
  (** (0018,0031) *)
  val energy_window_centerline : int32
  (** (0018,0032) *)
  val energy_window_total_width : int32
  (** (0018,0033) *)
  val intervention_drug_name : int32
  (** (0018,0034) *)
  val intervention_drug_start_time : int32
  (** (0018,0035) *)
  val intervention_sequence : int32
  (** (0018,0036) *)
  val therapy_type : int32
  (** (0018,0037) *)
  val intervention_status : int32
  (** (0018,0038) *)
  val therapy_description : int32
  (** (0018,0039) *)
  val intervention_description : int32
  (** (0018,003A) *)
  val cine_rate : int32
  (** (0018,0040) *)
  val initial_cine_run_state : int32
  (** (0018,0042) *)
  val slice_thickness : int32
  (** (0018,0050) *)
  val kvp : int32
  (** (0018,0060) *)
  val counts_accumulated : int32
  (** (0018,0070) *)
  val acquisition_termination_condition : int32
  (** (0018,0071) *)
  val effective_duration : int32
  (** (0018,0072) *)
  val acquisition_start_condition : int32
  (** (0018,0073) *)
  val acquisition_start_condition_data : int32
  (** (0018,0074) *)
  val acquisition_termination_condition_data : int32
  (** (0018,0075) *)
  val repetition_time : int32
  (** (0018,0080) *)
  val echo_time : int32
  (** (0018,0081) *)
  val inversion_time : int32
  (** (0018,0082) *)
  val number_of_averages : int32
  (** (0018,0083) *)
  val imaging_frequency : int32
  (** (0018,0084) *)
  val imaged_nucleus : int32
  (** (0018,0085) *)
  val echo_numbers : int32
  (** (0018,0086) *)
  val magnetic_field_strength : int32
  (** (0018,0087) *)
  val spacing_between_slices : int32
  (** (0018,0088) *)
  val number_of_phase_encoding_steps : int32
  (** (0018,0089) *)
  val data_collection_diameter : int32
  (** (0018,0090) *)
  val echo_train_length : int32
  (** (0018,0091) *)
  val percent_sampling : int32
  (** (0018,0093) *)
  val percent_phase_field_of_view : int32
  (** (0018,0094) *)
  val pixel_bandwidth : int32
  (** (0018,0095) *)
  val device_serial_number : int32
  (** (0018,1000) *)
  val device_uid : int32
  (** (0018,1002) *)
  val device_id : int32
  (** (0018,1003) *)
  val plate_id : int32
  (** (0018,1004) *)
  val generator_id : int32
  (** (0018,1005) *)
  val grid_id : int32
  (** (0018,1006) *)
  val cassette_id : int32
  (** (0018,1007) *)
  val gantry_id : int32
  (** (0018,1008) *)
  val secondary_capture_device_id : int32
  (** (0018,1010) *)
  val hardcopy_creation_device_id : int32
  (** (0018,1011) *)
  val date_of_secondary_capture : int32
  (** (0018,1012) *)
  val time_of_secondary_capture : int32
  (** (0018,1014) *)
  val secondary_capture_device_manufacturer : int32
  (** (0018,1016) *)
  val hardcopy_device_manufacturer : int32
  (** (0018,1017) *)
  val secondary_capture_device_manufacturer_model_name : int32
  (** (0018,1018) *)
  val secondary_capture_device_software_versions : int32
  (** (0018,1019) *)
  val hardcopy_device_software_version : int32
  (** (0018,101A) *)
  val hardcopy_device_manufacturer_model_name : int32
  (** (0018,101B) *)
  val software_versions : int32
  (** (0018,1020) *)
  val video_image_format_acquired : int32
  (** (0018,1022) *)
  val digital_image_format_acquired : int32
  (** (0018,1023) *)
  val protocol_name : int32
  (** (0018,1030) *)
  val contrast_bolus_route : int32
  (** (0018,1040) *)
  val contrast_bolus_volume : int32
  (** (0018,1041) *)
  val contrast_bolus_start_time : int32
  (** (0018,1042) *)
  val contrast_bolus_stop_time : int32
  (** (0018,1043) *)
  val contrast_bolus_total_dose : int32
  (** (0018,1044) *)
  val syringe_counts : int32
  (** (0018,1045) *)
  val contrast_flow_rate : int32
  (** (0018,1046) *)
  val contrast_flow_duration : int32
  (** (0018,1047) *)
  val contrast_bolus_ingredient : int32
  (** (0018,1048) *)
  val contrast_bolus_ingredient_concentration : int32
  (** (0018,1049) *)
  val spatial_resolution : int32
  (** (0018,1050) *)
  val trigger_time : int32
  (** (0018,1060) *)
  val trigger_source_or_type : int32
  (** (0018,1061) *)
  val nominal_interval : int32
  (** (0018,1062) *)
  val frame_time : int32
  (** (0018,1063) *)
  val cardiac_framing_type : int32
  (** (0018,1064) *)
  val frame_time_vector : int32
  (** (0018,1065) *)
  val frame_delay : int32
  (** (0018,1066) *)
  val image_trigger_delay : int32
  (** (0018,1067) *)
  val multiplex_group_time_offset : int32
  (** (0018,1068) *)
  val trigger_time_offset : int32
  (** (0018,1069) *)
  val synchronization_trigger : int32
  (** (0018,106A) *)
  val synchronization_channel : int32
  (** (0018,106C) *)
  val trigger_sample_position : int32
  (** (0018,106E) *)
  val radiopharmaceutical_route : int32
  (** (0018,1070) *)
  val radiopharmaceutical_volume : int32
  (** (0018,1071) *)
  val radiopharmaceutical_start_time : int32
  (** (0018,1072) *)
  val radiopharmaceutical_stop_time : int32
  (** (0018,1073) *)
  val radionuclide_total_dose : int32
  (** (0018,1074) *)
  val radionuclide_half_life : int32
  (** (0018,1075) *)
  val radionuclide_positron_fraction : int32
  (** (0018,1076) *)
  val radiopharmaceutical_specific_activity : int32
  (** (0018,1077) *)
  val radiopharmaceutical_start_date_time : int32
  (** (0018,1078) *)
  val radiopharmaceutical_stop_date_time : int32
  (** (0018,1079) *)
  val beat_rejection_flag : int32
  (** (0018,1080) *)
  val low_rr_value : int32
  (** (0018,1081) *)
  val high_rr_value : int32
  (** (0018,1082) *)
  val intervals_acquired : int32
  (** (0018,1083) *)
  val intervals_rejected : int32
  (** (0018,1084) *)
  val p_vcrejection : int32
  (** (0018,1085) *)
  val skip_beats : int32
  (** (0018,1086) *)
  val heart_rate : int32
  (** (0018,1088) *)
  val cardiac_number_of_images : int32
  (** (0018,1090) *)
  val trigger_window : int32
  (** (0018,1094) *)
  val reconstruction_diameter : int32
  (** (0018,1100) *)
  val distance_source_to_detector : int32
  (** (0018,1110) *)
  val distance_source_to_patient : int32
  (** (0018,1111) *)
  val estimated_radiographic_magnification_factor : int32
  (** (0018,1114) *)
  val gantry_detector_tilt : int32
  (** (0018,1120) *)
  val gantry_detector_slew : int32
  (** (0018,1121) *)
  val table_height : int32
  (** (0018,1130) *)
  val table_traverse : int32
  (** (0018,1131) *)
  val table_motion : int32
  (** (0018,1134) *)
  val table_vertical_increment : int32
  (** (0018,1135) *)
  val table_lateral_increment : int32
  (** (0018,1136) *)
  val table_longitudinal_increment : int32
  (** (0018,1137) *)
  val table_angle : int32
  (** (0018,1138) *)
  val table_type : int32
  (** (0018,113A) *)
  val rotation_direction : int32
  (** (0018,1140) *)
  val angular_position : int32
  (** (0018,1141) *)
  val radial_position : int32
  (** (0018,1142) *)
  val scan_arc : int32
  (** (0018,1143) *)
  val angular_step : int32
  (** (0018,1144) *)
  val center_of_rotation_offset : int32
  (** (0018,1145) *)
  val rotation_offset : int32
  (** (0018,1146) *)
  val field_of_view_shape : int32
  (** (0018,1147) *)
  val field_of_view_dimensions : int32
  (** (0018,1149) *)
  val exposure_time : int32
  (** (0018,1150) *)
  val x_ray_tube_current : int32
  (** (0018,1151) *)
  val exposure : int32
  (** (0018,1152) *)
  val exposure_inu_as : int32
  (** (0018,1153) *)
  val average_pulse_width : int32
  (** (0018,1154) *)
  val radiation_setting : int32
  (** (0018,1155) *)
  val rectification_type : int32
  (** (0018,1156) *)
  val radiation_mode : int32
  (** (0018,115A) *)
  val image_and_fluoroscopy_area_dose_product : int32
  (** (0018,115E) *)
  val filter_type : int32
  (** (0018,1160) *)
  val type_of_filters : int32
  (** (0018,1161) *)
  val intensifier_size : int32
  (** (0018,1162) *)
  val imager_pixel_spacing : int32
  (** (0018,1164) *)
  val grid : int32
  (** (0018,1166) *)
  val generator_power : int32
  (** (0018,1170) *)
  val collimator_grid_name : int32
  (** (0018,1180) *)
  val collimator_type : int32
  (** (0018,1181) *)
  val focal_distance : int32
  (** (0018,1182) *)
  val x_focus_center : int32
  (** (0018,1183) *)
  val y_focus_center : int32
  (** (0018,1184) *)
  val focal_spots : int32
  (** (0018,1190) *)
  val anode_target_material : int32
  (** (0018,1191) *)
  val body_part_thickness : int32
  (** (0018,11A0) *)
  val compression_force : int32
  (** (0018,11A2) *)
  val date_of_last_calibration : int32
  (** (0018,1200) *)
  val time_of_last_calibration : int32
  (** (0018,1201) *)
  val convolution_kernel : int32
  (** (0018,1210) *)
  val upper_lower_pixel_values : int32
  (** (0018,1240) *)
  val actual_frame_duration : int32
  (** (0018,1242) *)
  val count_rate : int32
  (** (0018,1243) *)
  val preferred_playback_sequencing : int32
  (** (0018,1244) *)
  val receive_coil_name : int32
  (** (0018,1250) *)
  val transmit_coil_name : int32
  (** (0018,1251) *)
  val plate_type : int32
  (** (0018,1260) *)
  val phosphor_type : int32
  (** (0018,1261) *)
  val scan_velocity : int32
  (** (0018,1300) *)
  val whole_body_technique : int32
  (** (0018,1301) *)
  val scan_length : int32
  (** (0018,1302) *)
  val acquisition_matrix : int32
  (** (0018,1310) *)
  val in_plane_phase_encoding_direction : int32
  (** (0018,1312) *)
  val flip_angle : int32
  (** (0018,1314) *)
  val variable_flip_angle_flag : int32
  (** (0018,1315) *)
  val sat : int32
  (** (0018,1316) *)
  val dbdt : int32
  (** (0018,1318) *)
  val acquisition_device_processing_description : int32
  (** (0018,1400) *)
  val acquisition_device_processing_code : int32
  (** (0018,1401) *)
  val cassette_orientation : int32
  (** (0018,1402) *)
  val cassette_size : int32
  (** (0018,1403) *)
  val exposures_on_plate : int32
  (** (0018,1404) *)
  val relative_x_ray_exposure : int32
  (** (0018,1405) *)
  val exposure_index : int32
  (** (0018,1411) *)
  val target_exposure_index : int32
  (** (0018,1412) *)
  val deviation_index : int32
  (** (0018,1413) *)
  val column_angulation : int32
  (** (0018,1450) *)
  val tomo_layer_height : int32
  (** (0018,1460) *)
  val tomo_angle : int32
  (** (0018,1470) *)
  val tomo_time : int32
  (** (0018,1480) *)
  val tomo_type : int32
  (** (0018,1490) *)
  val tomo_class : int32
  (** (0018,1491) *)
  val number_of_tomosynthesis_source_images : int32
  (** (0018,1495) *)
  val positioner_motion : int32
  (** (0018,1500) *)
  val positioner_type : int32
  (** (0018,1508) *)
  val positioner_primary_angle : int32
  (** (0018,1510) *)
  val positioner_secondary_angle : int32
  (** (0018,1511) *)
  val positioner_primary_angle_increment : int32
  (** (0018,1520) *)
  val positioner_secondary_angle_increment : int32
  (** (0018,1521) *)
  val detector_primary_angle : int32
  (** (0018,1530) *)
  val detector_secondary_angle : int32
  (** (0018,1531) *)
  val shutter_shape : int32
  (** (0018,1600) *)
  val shutter_left_vertical_edge : int32
  (** (0018,1602) *)
  val shutter_right_vertical_edge : int32
  (** (0018,1604) *)
  val shutter_upper_horizontal_edge : int32
  (** (0018,1606) *)
  val shutter_lower_horizontal_edge : int32
  (** (0018,1608) *)
  val center_of_circular_shutter : int32
  (** (0018,1610) *)
  val radius_of_circular_shutter : int32
  (** (0018,1612) *)
  val vertices_of_the_polygonal_shutter : int32
  (** (0018,1620) *)
  val shutter_presentation_value : int32
  (** (0018,1622) *)
  val shutter_overlay_group : int32
  (** (0018,1623) *)
  val shutter_presentation_color_cielab_value : int32
  (** (0018,1624) *)
  val collimator_shape : int32
  (** (0018,1700) *)
  val collimator_left_vertical_edge : int32
  (** (0018,1702) *)
  val collimator_right_vertical_edge : int32
  (** (0018,1704) *)
  val collimator_upper_horizontal_edge : int32
  (** (0018,1706) *)
  val collimator_lower_horizontal_edge : int32
  (** (0018,1708) *)
  val center_of_circular_collimator : int32
  (** (0018,1710) *)
  val radius_of_circular_collimator : int32
  (** (0018,1712) *)
  val vertices_of_the_polygonal_collimator : int32
  (** (0018,1720) *)
  val acquisition_time_synchronized : int32
  (** (0018,1800) *)
  val time_source : int32
  (** (0018,1801) *)
  val time_distribution_protocol : int32
  (** (0018,1802) *)
  val ntp_source_address : int32
  (** (0018,1803) *)
  val page_number_vector : int32
  (** (0018,2001) *)
  val frame_label_vector : int32
  (** (0018,2002) *)
  val frame_primary_angle_vector : int32
  (** (0018,2003) *)
  val frame_secondary_angle_vector : int32
  (** (0018,2004) *)
  val slice_location_vector : int32
  (** (0018,2005) *)
  val display_window_label_vector : int32
  (** (0018,2006) *)
  val nominal_scanned_pixel_spacing : int32
  (** (0018,2010) *)
  val digitizing_device_transport_direction : int32
  (** (0018,2020) *)
  val rotation_of_scanned_film : int32
  (** (0018,2030) *)
  val ivus_acquisition : int32
  (** (0018,3100) *)
  val ivus_pullback_rate : int32
  (** (0018,3101) *)
  val ivus_gated_rate : int32
  (** (0018,3102) *)
  val ivus_pullback_start_frame_number : int32
  (** (0018,3103) *)
  val ivus_pullback_stop_frame_number : int32
  (** (0018,3104) *)
  val lesion_number : int32
  (** (0018,3105) *)
  val acquisition_comments : int32
  (** (0018,4000) *)
  val output_power : int32
  (** (0018,5000) *)
  val transducer_data : int32
  (** (0018,5010) *)
  val focus_depth : int32
  (** (0018,5012) *)
  val processing_function : int32
  (** (0018,5020) *)
  val postprocessing_function : int32
  (** (0018,5021) *)
  val mechanical_index : int32
  (** (0018,5022) *)
  val bone_thermal_index : int32
  (** (0018,5024) *)
  val cranial_thermal_index : int32
  (** (0018,5026) *)
  val soft_tissue_thermal_index : int32
  (** (0018,5027) *)
  val soft_tissue_focus_thermal_index : int32
  (** (0018,5028) *)
  val soft_tissue_surface_thermal_index : int32
  (** (0018,5029) *)
  val dynamic_range : int32
  (** (0018,5030) *)
  val total_gain : int32
  (** (0018,5040) *)
  val depth_of_scan_field : int32
  (** (0018,5050) *)
  val patient_position : int32
  (** (0018,5100) *)
  val view_position : int32
  (** (0018,5101) *)
  val projection_eponymous_name_code_sequence : int32
  (** (0018,5104) *)
  val image_transformation_matrix : int32
  (** (0018,5210) *)
  val image_translation_vector : int32
  (** (0018,5212) *)
  val sensitivity : int32
  (** (0018,6000) *)
  val sequence_of_ultrasound_regions : int32
  (** (0018,6011) *)
  val region_spatial_format : int32
  (** (0018,6012) *)
  val region_data_type : int32
  (** (0018,6014) *)
  val region_flags : int32
  (** (0018,6016) *)
  val region_location_min_x0 : int32
  (** (0018,6018) *)
  val region_location_min_y0 : int32
  (** (0018,601A) *)
  val region_location_max_x1 : int32
  (** (0018,601C) *)
  val region_location_max_y1 : int32
  (** (0018,601E) *)
  val reference_pixel_x0 : int32
  (** (0018,6020) *)
  val reference_pixel_y0 : int32
  (** (0018,6022) *)
  val physical_units_xdirection : int32
  (** (0018,6024) *)
  val physical_units_ydirection : int32
  (** (0018,6026) *)
  val reference_pixel_physical_value_x : int32
  (** (0018,6028) *)
  val reference_pixel_physical_value_y : int32
  (** (0018,602A) *)
  val physical_delta_x : int32
  (** (0018,602C) *)
  val physical_delta_y : int32
  (** (0018,602E) *)
  val transducer_frequency : int32
  (** (0018,6030) *)
  val transducer_type : int32
  (** (0018,6031) *)
  val pulse_repetition_frequency : int32
  (** (0018,6032) *)
  val doppler_correction_angle : int32
  (** (0018,6034) *)
  val steering_angle : int32
  (** (0018,6036) *)
  val doppler_sample_volume_xposition_retired : int32
  (** (0018,6038) *)
  val doppler_sample_volume_xposition : int32
  (** (0018,6039) *)
  val doppler_sample_volume_yposition_retired : int32
  (** (0018,603A) *)
  val doppler_sample_volume_yposition : int32
  (** (0018,603B) *)
  val tm_line_position_x0_retired : int32
  (** (0018,603C) *)
  val tm_line_position_x0 : int32
  (** (0018,603D) *)
  val tm_line_position_y0_retired : int32
  (** (0018,603E) *)
  val tm_line_position_y0 : int32
  (** (0018,603F) *)
  val tm_line_position_x1_retired : int32
  (** (0018,6040) *)
  val tm_line_position_x1 : int32
  (** (0018,6041) *)
  val tm_line_position_y1_retired : int32
  (** (0018,6042) *)
  val tm_line_position_y1 : int32
  (** (0018,6043) *)
  val pixel_component_organization : int32
  (** (0018,6044) *)
  val pixel_component_mask : int32
  (** (0018,6046) *)
  val pixel_component_range_start : int32
  (** (0018,6048) *)
  val pixel_component_range_stop : int32
  (** (0018,604A) *)
  val pixel_component_physical_units : int32
  (** (0018,604C) *)
  val pixel_component_data_type : int32
  (** (0018,604E) *)
  val number_of_table_break_points : int32
  (** (0018,6050) *)
  val table_of_xbreak_points : int32
  (** (0018,6052) *)
  val table_of_ybreak_points : int32
  (** (0018,6054) *)
  val number_of_table_entries : int32
  (** (0018,6056) *)
  val table_of_pixel_values : int32
  (** (0018,6058) *)
  val table_of_parameter_values : int32
  (** (0018,605A) *)
  val r_wave_time_vector : int32
  (** (0018,6060) *)
  val detector_conditions_nominal_flag : int32
  (** (0018,7000) *)
  val detector_temperature : int32
  (** (0018,7001) *)
  val detector_type : int32
  (** (0018,7004) *)
  val detector_configuration : int32
  (** (0018,7005) *)
  val detector_description : int32
  (** (0018,7006) *)
  val detector_mode : int32
  (** (0018,7008) *)
  val detector_id : int32
  (** (0018,700A) *)
  val date_of_last_detector_calibration : int32
  (** (0018,700C) *)
  val time_of_last_detector_calibration : int32
  (** (0018,700E) *)
  val exposures_on_detector_since_last_calibration : int32
  (** (0018,7010) *)
  val exposures_on_detector_since_manufactured : int32
  (** (0018,7011) *)
  val detector_time_since_last_exposure : int32
  (** (0018,7012) *)
  val detector_active_time : int32
  (** (0018,7014) *)
  val detector_activation_offset_from_exposure : int32
  (** (0018,7016) *)
  val detector_binning : int32
  (** (0018,701A) *)
  val detector_element_physical_size : int32
  (** (0018,7020) *)
  val detector_element_spacing : int32
  (** (0018,7022) *)
  val detector_active_shape : int32
  (** (0018,7024) *)
  val detector_active_dimensions : int32
  (** (0018,7026) *)
  val detector_active_origin : int32
  (** (0018,7028) *)
  val detector_manufacturer_name : int32
  (** (0018,702A) *)
  val detector_manufacturer_model_name : int32
  (** (0018,702B) *)
  val field_of_view_origin : int32
  (** (0018,7030) *)
  val field_of_view_rotation : int32
  (** (0018,7032) *)
  val field_of_view_horizontal_flip : int32
  (** (0018,7034) *)
  val pixel_data_area_origin_relative_to_fov : int32
  (** (0018,7036) *)
  val pixel_data_area_rotation_angle_relative_to_fov : int32
  (** (0018,7038) *)
  val grid_absorbing_material : int32
  (** (0018,7040) *)
  val grid_spacing_material : int32
  (** (0018,7041) *)
  val grid_thickness : int32
  (** (0018,7042) *)
  val grid_pitch : int32
  (** (0018,7044) *)
  val grid_aspect_ratio : int32
  (** (0018,7046) *)
  val grid_period : int32
  (** (0018,7048) *)
  val grid_focal_distance : int32
  (** (0018,704C) *)
  val filter_material : int32
  (** (0018,7050) *)
  val filter_thickness_minimum : int32
  (** (0018,7052) *)
  val filter_thickness_maximum : int32
  (** (0018,7054) *)
  val filter_beam_path_length_minimum : int32
  (** (0018,7056) *)
  val filter_beam_path_length_maximum : int32
  (** (0018,7058) *)
  val exposure_control_mode : int32
  (** (0018,7060) *)
  val exposure_control_mode_description : int32
  (** (0018,7062) *)
  val exposure_status : int32
  (** (0018,7064) *)
  val phototimer_setting : int32
  (** (0018,7065) *)
  val exposure_time_inu_s : int32
  (** (0018,8150) *)
  val x_ray_tube_current_inu_a : int32
  (** (0018,8151) *)
  val content_qualification : int32
  (** (0018,9004) *)
  val pulse_sequence_name : int32
  (** (0018,9005) *)
  val m_rimaging_modifier_sequence : int32
  (** (0018,9006) *)
  val echo_pulse_sequence : int32
  (** (0018,9008) *)
  val inversion_recovery : int32
  (** (0018,9009) *)
  val flow_compensation : int32
  (** (0018,9010) *)
  val multiple_spin_echo : int32
  (** (0018,9011) *)
  val multi_planar_excitation : int32
  (** (0018,9012) *)
  val phase_contrast : int32
  (** (0018,9014) *)
  val time_of_flight_contrast : int32
  (** (0018,9015) *)
  val spoiling : int32
  (** (0018,9016) *)
  val steady_state_pulse_sequence : int32
  (** (0018,9017) *)
  val echo_planar_pulse_sequence : int32
  (** (0018,9018) *)
  val tag_angle_first_axis : int32
  (** (0018,9019) *)
  val magnetization_transfer : int32
  (** (0018,9020) *)
  val t2_preparation : int32
  (** (0018,9021) *)
  val blood_signal_nulling : int32
  (** (0018,9022) *)
  val saturation_recovery : int32
  (** (0018,9024) *)
  val spectrally_selected_suppression : int32
  (** (0018,9025) *)
  val spectrally_selected_excitation : int32
  (** (0018,9026) *)
  val spatial_presaturation : int32
  (** (0018,9027) *)
  val tagging : int32
  (** (0018,9028) *)
  val oversampling_phase : int32
  (** (0018,9029) *)
  val tag_spacing_first_dimension : int32
  (** (0018,9030) *)
  val geometry_of_kspace_traversal : int32
  (** (0018,9032) *)
  val segmented_kspace_traversal : int32
  (** (0018,9033) *)
  val rectilinear_phase_encode_reordering : int32
  (** (0018,9034) *)
  val tag_thickness : int32
  (** (0018,9035) *)
  val partial_fourier_direction : int32
  (** (0018,9036) *)
  val cardiac_synchronization_technique : int32
  (** (0018,9037) *)
  val receive_coil_manufacturer_name : int32
  (** (0018,9041) *)
  val m_rreceive_coil_sequence : int32
  (** (0018,9042) *)
  val receive_coil_type : int32
  (** (0018,9043) *)
  val quadrature_receive_coil : int32
  (** (0018,9044) *)
  val multi_coil_definition_sequence : int32
  (** (0018,9045) *)
  val multi_coil_configuration : int32
  (** (0018,9046) *)
  val multi_coil_element_name : int32
  (** (0018,9047) *)
  val multi_coil_element_used : int32
  (** (0018,9048) *)
  val mr_transmit_coil_sequence : int32
  (** (0018,9049) *)
  val transmit_coil_manufacturer_name : int32
  (** (0018,9050) *)
  val transmit_coil_type : int32
  (** (0018,9051) *)
  val spectral_width : int32
  (** (0018,9052) *)
  val chemical_shift_reference : int32
  (** (0018,9053) *)
  val volume_localization_technique : int32
  (** (0018,9054) *)
  val mr_acquisition_frequency_encoding_steps : int32
  (** (0018,9058) *)
  val decoupling : int32
  (** (0018,9059) *)
  val decoupled_nucleus : int32
  (** (0018,9060) *)
  val decoupling_frequency : int32
  (** (0018,9061) *)
  val decoupling_method : int32
  (** (0018,9062) *)
  val decoupling_chemical_shift_reference : int32
  (** (0018,9063) *)
  val kspace_filtering : int32
  (** (0018,9064) *)
  val time_domain_filtering : int32
  (** (0018,9065) *)
  val number_of_zero_fills : int32
  (** (0018,9066) *)
  val baseline_correction : int32
  (** (0018,9067) *)
  val parallel_reduction_factor_in_plane : int32
  (** (0018,9069) *)
  val cardiac_rr_interval_specified : int32
  (** (0018,9070) *)
  val acquisition_duration : int32
  (** (0018,9073) *)
  val frame_acquisition_date_time : int32
  (** (0018,9074) *)
  val diffusion_directionality : int32
  (** (0018,9075) *)
  val diffusion_gradient_direction_sequence : int32
  (** (0018,9076) *)
  val parallel_acquisition : int32
  (** (0018,9077) *)
  val parallel_acquisition_technique : int32
  (** (0018,9078) *)
  val inversion_times : int32
  (** (0018,9079) *)
  val metabolite_map_description : int32
  (** (0018,9080) *)
  val partial_fourier : int32
  (** (0018,9081) *)
  val effective_echo_time : int32
  (** (0018,9082) *)
  val metabolite_map_code_sequence : int32
  (** (0018,9083) *)
  val chemical_shift_sequence : int32
  (** (0018,9084) *)
  val cardiac_signal_source : int32
  (** (0018,9085) *)
  val diffusion_bvalue : int32
  (** (0018,9087) *)
  val diffusion_gradient_orientation : int32
  (** (0018,9089) *)
  val velocity_encoding_direction : int32
  (** (0018,9090) *)
  val velocity_encoding_minimum_value : int32
  (** (0018,9091) *)
  val velocity_encoding_acquisition_sequence : int32
  (** (0018,9092) *)
  val number_of_kspace_trajectories : int32
  (** (0018,9093) *)
  val coverage_of_kspace : int32
  (** (0018,9094) *)
  val spectroscopy_acquisition_phase_rows : int32
  (** (0018,9095) *)
  val parallel_reduction_factor_in_plane_retired : int32
  (** (0018,9096) *)
  val transmitter_frequency : int32
  (** (0018,9098) *)
  val resonant_nucleus : int32
  (** (0018,9100) *)
  val frequency_correction : int32
  (** (0018,9101) *)
  val mr_spectroscopy_fovgeometry_sequence : int32
  (** (0018,9103) *)
  val slab_thickness : int32
  (** (0018,9104) *)
  val slab_orientation : int32
  (** (0018,9105) *)
  val mid_slab_position : int32
  (** (0018,9106) *)
  val mrspatialsaturationsequence : int32
  (** (0018,9107) *)
  val mrtimingandrelatedparameterssequence : int32
  (** (0018,9112) *)
  val mrechosequence : int32
  (** (0018,9114) *)
  val mrmodifiersequence : int32
  (** (0018,9115) *)
  val mrdiffusionsequence : int32
  (** (0018,9117) *)
  val cardiac_synchronization_sequence : int32
  (** (0018,9118) *)
  val mr_averages_sequence : int32
  (** (0018,9119) *)
  val mr_fovgeometry_sequence : int32
  (** (0018,9125) *)
  val volume_localization_sequence : int32
  (** (0018,9126) *)
  val spectroscopy_acquisition_data_columns : int32
  (** (0018,9127) *)
  val diffusion_anisotropy_type : int32
  (** (0018,9147) *)
  val frame_reference_date_time : int32
  (** (0018,9151) *)
  val mr_metabolite_map_sequence : int32
  (** (0018,9152) *)
  val parallel_reduction_factor_out_of_plane : int32
  (** (0018,9155) *)
  val spectroscopy_acquisition_out_of_plane_phase_steps : int32
  (** (0018,9159) *)
  val bulk_motion_status : int32
  (** (0018,9166) *)
  val parallel_reduction_factor_second_in_plane : int32
  (** (0018,9168) *)
  val cardiac_beat_rejection_technique : int32
  (** (0018,9169) *)
  val respiratory_motion_compensation_technique : int32
  (** (0018,9170) *)
  val respiratory_signal_source : int32
  (** (0018,9171) *)
  val bulk_motion_compensation_technique : int32
  (** (0018,9172) *)
  val bulk_motion_signal_source : int32
  (** (0018,9173) *)
  val applicable_safety_standard_agency : int32
  (** (0018,9174) *)
  val applicable_safety_standard_description : int32
  (** (0018,9175) *)
  val operating_mode_sequence : int32
  (** (0018,9176) *)
  val operating_mode_type : int32
  (** (0018,9177) *)
  val operating_mode : int32
  (** (0018,9178) *)
  val specific_absorption_rate_definition : int32
  (** (0018,9179) *)
  val gradient_output_type : int32
  (** (0018,9180) *)
  val specific_absorption_rate_value : int32
  (** (0018,9181) *)
  val gradient_output : int32
  (** (0018,9182) *)
  val flow_compensation_direction : int32
  (** (0018,9183) *)
  val tagging_delay : int32
  (** (0018,9184) *)
  val respiratory_motion_compensation_technique_description : int32
  (** (0018,9185) *)
  val respiratory_signal_source_id : int32
  (** (0018,9186) *)
  val chemical_shift_minimum_integration_limit_in_hz : int32
  (** (0018,9195) *)
  val chemical_shift_maximum_integration_limit_in_hz : int32
  (** (0018,9196) *)
  val mrvelocityencodingsequence : int32
  (** (0018,9197) *)
  val first_order_phase_correction : int32
  (** (0018,9198) *)
  val water_referenced_phase_correction : int32
  (** (0018,9199) *)
  val mr_spectroscopy_acquisition_type : int32
  (** (0018,9200) *)
  val respiratory_cycle_position : int32
  (** (0018,9214) *)
  val velocity_encoding_maximum_value : int32
  (** (0018,9217) *)
  val tag_spacing_second_dimension : int32
  (** (0018,9218) *)
  val tag_angle_second_axis : int32
  (** (0018,9219) *)
  val frame_acquisition_duration : int32
  (** (0018,9220) *)
  val mr_image_frame_type_sequence : int32
  (** (0018,9226) *)
  val mr_spectroscopy_frame_type_sequence : int32
  (** (0018,9227) *)
  val mr_acquisition_phase_encoding_steps_in_plane : int32
  (** (0018,9231) *)
  val mr_acquisition_phase_encoding_steps_out_of_plane : int32
  (** (0018,9232) *)
  val spectroscopy_acquisition_phase_columns : int32
  (** (0018,9234) *)
  val cardiac_cycle_position : int32
  (** (0018,9236) *)
  val specific_absorption_rate_sequence : int32
  (** (0018,9239) *)
  val rf_echo_train_length : int32
  (** (0018,9240) *)
  val gradient_echo_train_length : int32
  (** (0018,9241) *)
  val arterial_spin_labeling_contrast : int32
  (** (0018,9250) *)
  val mr_arterial_spin_labeling_sequence : int32
  (** (0018,9251) *)
  val asl_technique_description : int32
  (** (0018,9252) *)
  val asl_slab_number : int32
  (** (0018,9253) *)
  val asl_slab_thickness : int32
  (** (0018,9254) *)
  val asl_slab_orientation : int32
  (** (0018,9255) *)
  val asl_mid_slab_position : int32
  (** (0018,9256) *)
  val asl_context : int32
  (** (0018,9257) *)
  val asl_pulse_train_duration : int32
  (** (0018,9258) *)
  val asl_crusher_flag : int32
  (** (0018,9259) *)
  val asl_crusher_flow : int32
  (** (0018,925A) *)
  val asl_crusher_description : int32
  (** (0018,925B) *)
  val asl_bolus_cutoff_flag : int32
  (** (0018,925C) *)
  val asl_bolus_cutoff_timing_sequence : int32
  (** (0018,925D) *)
  val asl_bolus_cutoff_technique : int32
  (** (0018,925E) *)
  val asl_bolus_cutoff_delay_time : int32
  (** (0018,925F) *)
  val asl_slab_sequence : int32
  (** (0018,9260) *)
  val chemical_shift_minimum_integration_limit_inppm : int32
  (** (0018,9295) *)
  val chemical_shift_maximum_integration_limit_inppm : int32
  (** (0018,9296) *)
  val ct_acquisition_type_sequence : int32
  (** (0018,9301) *)
  val acquisition_type : int32
  (** (0018,9302) *)
  val tube_angle : int32
  (** (0018,9303) *)
  val ct_acquisition_details_sequence : int32
  (** (0018,9304) *)
  val revolution_time : int32
  (** (0018,9305) *)
  val single_collimation_width : int32
  (** (0018,9306) *)
  val total_collimation_width : int32
  (** (0018,9307) *)
  val ct_table_dynamics_sequence : int32
  (** (0018,9308) *)
  val table_speed : int32
  (** (0018,9309) *)
  val table_feed_per_rotation : int32
  (** (0018,9310) *)
  val spiral_pitch_factor : int32
  (** (0018,9311) *)
  val ct_geometry_sequence : int32
  (** (0018,9312) *)
  val data_collection_center_patient : int32
  (** (0018,9313) *)
  val ct_reconstruction_sequence : int32
  (** (0018,9314) *)
  val reconstruction_algorithm : int32
  (** (0018,9315) *)
  val convolution_kernel_group : int32
  (** (0018,9316) *)
  val reconstruction_field_of_view : int32
  (** (0018,9317) *)
  val reconstruction_target_center_patient : int32
  (** (0018,9318) *)
  val reconstruction_angle : int32
  (** (0018,9319) *)
  val image_filter : int32
  (** (0018,9320) *)
  val ct_exposure_sequence : int32
  (** (0018,9321) *)
  val reconstruction_pixel_spacing : int32
  (** (0018,9322) *)
  val exposure_modulation_type : int32
  (** (0018,9323) *)
  val estimated_dose_saving : int32
  (** (0018,9324) *)
  val ct_x_ray_details_sequence : int32
  (** (0018,9325) *)
  val ct_position_sequence : int32
  (** (0018,9326) *)
  val table_position : int32
  (** (0018,9327) *)
  val exposure_time_inms : int32
  (** (0018,9328) *)
  val ct_image_frame_type_sequence : int32
  (** (0018,9329) *)
  val x_ray_tube_current_inm_a : int32
  (** (0018,9330) *)
  val exposure_inm_as : int32
  (** (0018,9332) *)
  val constant_volume_flag : int32
  (** (0018,9333) *)
  val fluoroscopy_flag : int32
  (** (0018,9334) *)
  val distance_source_to_data_collection_center : int32
  (** (0018,9335) *)
  val contrast_bolus_agent_number : int32
  (** (0018,9337) *)
  val contrast_bolus_ingredient_code_sequence : int32
  (** (0018,9338) *)
  val contrast_administration_profile_sequence : int32
  (** (0018,9340) *)
  val contrast_bolus_usage_sequence : int32
  (** (0018,9341) *)
  val contrast_bolus_agent_administered : int32
  (** (0018,9342) *)
  val contrast_bolus_agent_detected : int32
  (** (0018,9343) *)
  val contrast_bolus_agent_phase : int32
  (** (0018,9344) *)
  val ctdi_vol : int32
  (** (0018,9345) *)
  val ctdi_phantom_type_code_sequence : int32
  (** (0018,9346) *)
  val calcium_scoring_mass_factor_patient : int32
  (** (0018,9351) *)
  val calcium_scoring_mass_factor_device : int32
  (** (0018,9352) *)
  val energy_weighting_factor : int32
  (** (0018,9353) *)
  val ct_additional_xray_source_sequence : int32
  (** (0018,9360) *)
  val projection_pixel_calibration_sequence : int32
  (** (0018,9401) *)
  val distance_source_to_isocenter : int32
  (** (0018,9402) *)
  val distance_object_to_table_top : int32
  (** (0018,9403) *)
  val object_pixel_spacing_in_center_of_beam : int32
  (** (0018,9404) *)
  val positioner_position_sequence : int32
  (** (0018,9405) *)
  val table_position_sequence : int32
  (** (0018,9406) *)
  val collimator_shape_sequence : int32
  (** (0018,9407) *)
  val planes_in_acquisition : int32
  (** (0018,9410) *)
  val xaxrf_frame_characteristics_sequence : int32
  (** (0018,9412) *)
  val frame_acquisition_sequence : int32
  (** (0018,9417) *)
  val x_ray_receptor_type : int32
  (** (0018,9420) *)
  val acquisition_protocol_name : int32
  (** (0018,9423) *)
  val acquisition_protocol_description : int32
  (** (0018,9424) *)
  val contrast_bolus_ingredient_opaque : int32
  (** (0018,9425) *)
  val distance_receptor_plane_to_detector_housing : int32
  (** (0018,9426) *)
  val intensifier_active_shape : int32
  (** (0018,9427) *)
  val intensifier_active_dimensions : int32
  (** (0018,9428) *)
  val physical_detector_size : int32
  (** (0018,9429) *)
  val position_of_isocenter_projection : int32
  (** (0018,9430) *)
  val field_of_view_sequence : int32
  (** (0018,9432) *)
  val field_of_view_description : int32
  (** (0018,9433) *)
  val exposure_control_sensing_regions_sequence : int32
  (** (0018,9434) *)
  val exposure_control_sensing_region_shape : int32
  (** (0018,9435) *)
  val exposure_control_sensing_region_left_vertical_edge : int32
  (** (0018,9436) *)
  val exposure_control_sensing_region_right_vertical_edge : int32
  (** (0018,9437) *)
  val exposure_control_sensing_region_upper_horizontal_edge : int32
  (** (0018,9438) *)
  val exposure_control_sensing_region_lower_horizontal_edge : int32
  (** (0018,9439) *)
  val center_of_circular_exposure_control_sensing_region : int32
  (** (0018,9440) *)
  val radius_of_circular_exposure_control_sensing_region : int32
  (** (0018,9441) *)
  val vertices_of_the_polygonal_exposure_control_sensing_region : int32
  (** (0018,9442) *)
  val column_angulation_patient : int32
  (** (0018,9447) *)
  val beam_angle : int32
  (** (0018,9449) *)
  val frame_detector_parameters_sequence : int32
  (** (0018,9451) *)
  val calculated_anatomy_thickness : int32
  (** (0018,9452) *)
  val calibration_sequence : int32
  (** (0018,9455) *)
  val object_thickness_sequence : int32
  (** (0018,9456) *)
  val plane_identification : int32
  (** (0018,9457) *)
  val field_of_view_dimensions_in_float : int32
  (** (0018,9461) *)
  val isocenter_reference_system_sequence : int32
  (** (0018,9462) *)
  val positioner_isocenter_primary_angle : int32
  (** (0018,9463) *)
  val positioner_isocenter_secondary_angle : int32
  (** (0018,9464) *)
  val positioner_isocenter_detector_rotation_angle : int32
  (** (0018,9465) *)
  val table_xposition_to_isocenter : int32
  (** (0018,9466) *)
  val table_yposition_to_isocenter : int32
  (** (0018,9467) *)
  val table_zposition_to_isocenter : int32
  (** (0018,9468) *)
  val table_horizontal_rotation_angle : int32
  (** (0018,9469) *)
  val table_head_tilt_angle : int32
  (** (0018,9470) *)
  val table_cradle_tilt_angle : int32
  (** (0018,9471) *)
  val frame_display_shutter_sequence : int32
  (** (0018,9472) *)
  val acquired_image_area_dose_product : int32
  (** (0018,9473) *)
  val c_arm_positioner_tabletop_relationship : int32
  (** (0018,9474) *)
  val x_ray_geometry_sequence : int32
  (** (0018,9476) *)
  val irradiation_event_identification_sequence : int32
  (** (0018,9477) *)
  val x_ray_3d_frame_type_sequence : int32
  (** (0018,9504) *)
  val contributing_sources_sequence : int32
  (** (0018,9506) *)
  val x_ray_3d_acquisition_sequence : int32
  (** (0018,9507) *)
  val primary_positioner_scan_arc : int32
  (** (0018,9508) *)
  val secondary_positioner_scan_arc : int32
  (** (0018,9509) *)
  val primary_positioner_scan_start_angle : int32
  (** (0018,9510) *)
  val secondary_positioner_scan_start_angle : int32
  (** (0018,9511) *)
  val primary_positioner_increment : int32
  (** (0018,9514) *)
  val secondary_positioner_increment : int32
  (** (0018,9515) *)
  val start_acquisition_date_time : int32
  (** (0018,9516) *)
  val end_acquisition_date_time : int32
  (** (0018,9517) *)
  val application_name : int32
  (** (0018,9524) *)
  val application_version : int32
  (** (0018,9525) *)
  val application_manufacturer : int32
  (** (0018,9526) *)
  val algorithm_type : int32
  (** (0018,9527) *)
  val algorithm_description : int32
  (** (0018,9528) *)
  val x_ray_3dreconstruction_sequence : int32
  (** (0018,9530) *)
  val reconstruction_description : int32
  (** (0018,9531) *)
  val per_projection_acquisition_sequence : int32
  (** (0018,9538) *)
  val diffusion_bmatrix_sequence : int32
  (** (0018,9601) *)
  val diffusion_b_value_xx : int32
  (** (0018,9602) *)
  val diffusion_b_value_xy : int32
  (** (0018,9603) *)
  val diffusion_b_value_xz : int32
  (** (0018,9604) *)
  val diffusion_b_value_yy : int32
  (** (0018,9605) *)
  val diffusion_b_value_yz : int32
  (** (0018,9606) *)
  val diffusion_b_value_zz : int32
  (** (0018,9607) *)
  val decay_correction_date_time : int32
  (** (0018,9701) *)
  val start_density_threshold : int32
  (** (0018,9715) *)
  val start_relative_density_difference_threshold : int32
  (** (0018,9716) *)
  val start_cardiac_trigger_count_threshold : int32
  (** (0018,9717) *)
  val start_respiratory_trigger_count_threshold : int32
  (** (0018,9718) *)
  val termination_counts_threshold : int32
  (** (0018,9719) *)
  val termination_density_threshold : int32
  (** (0018,9720) *)
  val termination_relative_density_threshold : int32
  (** (0018,9721) *)
  val termination_time_threshold : int32
  (** (0018,9722) *)
  val termination_cardiac_trigger_count_threshold : int32
  (** (0018,9723) *)
  val termination_respiratory_trigger_count_threshold : int32
  (** (0018,9724) *)
  val detector_geometry : int32
  (** (0018,9725) *)
  val transverse_detector_separation : int32
  (** (0018,9726) *)
  val axial_detector_dimension : int32
  (** (0018,9727) *)
  val radiopharmaceutical_agent_number : int32
  (** (0018,9729) *)
  val pet_frame_acquisition_sequence : int32
  (** (0018,9732) *)
  val pet_detector_motion_details_sequence : int32
  (** (0018,9733) *)
  val pettabledynamicssequence : int32
  (** (0018,9734) *)
  val petpositionsequence : int32
  (** (0018,9735) *)
  val petframecorrectionfactorssequence : int32
  (** (0018,9736) *)
  val radiopharmaceutical_usage_sequence : int32
  (** (0018,9737) *)
  val attenuation_correction_source : int32
  (** (0018,9738) *)
  val number_of_iterations : int32
  (** (0018,9739) *)
  val number_of_subsets : int32
  (** (0018,9740) *)
  val pet_reconstruction_sequence : int32
  (** (0018,9749) *)
  val pet_frame_type_sequence : int32
  (** (0018,9751) *)
  val time_of_flight_information_used : int32
  (** (0018,9755) *)
  val reconstruction_type : int32
  (** (0018,9756) *)
  val decay_corrected : int32
  (** (0018,9758) *)
  val attenuation_corrected : int32
  (** (0018,9759) *)
  val scatter_corrected : int32
  (** (0018,9760) *)
  val dead_time_corrected : int32
  (** (0018,9761) *)
  val gantry_motion_corrected : int32
  (** (0018,9762) *)
  val patient_motion_corrected : int32
  (** (0018,9763) *)
  val count_loss_normalization_corrected : int32
  (** (0018,9764) *)
  val randoms_corrected : int32
  (** (0018,9765) *)
  val non_uniform_radial_sampling_corrected : int32
  (** (0018,9766) *)
  val sensitivity_calibrated : int32
  (** (0018,9767) *)
  val detector_normalization_correction : int32
  (** (0018,9768) *)
  val iterative_reconstruction_method : int32
  (** (0018,9769) *)
  val attenuation_correction_temporal_relationship : int32
  (** (0018,9770) *)
  val patient_physiological_state_sequence : int32
  (** (0018,9771) *)
  val patient_physiological_state_code_sequence : int32
  (** (0018,9772) *)
  val depths_of_focus : int32
  (** (0018,9801) *)
  val excluded_intervals_sequence : int32
  (** (0018,9803) *)
  val exclusion_start_datetime : int32
  (** (0018,9804) *)
  val exclusion_duration : int32
  (** (0018,9805) *)
  val u_simage_description_sequence : int32
  (** (0018,9806) *)
  val image_data_type_sequence : int32
  (** (0018,9807) *)
  val data_type : int32
  (** (0018,9808) *)
  val transducer_scan_pattern_code_sequence : int32
  (** (0018,9809) *)
  val aliased_data_type : int32
  (** (0018,980B) *)
  val position_measuring_device_used : int32
  (** (0018,980C) *)
  val transducer_geometry_code_sequence : int32
  (** (0018,980D) *)
  val transducer_beam_steering_code_sequence : int32
  (** (0018,980E) *)
  val transducer_application_code_sequence : int32
  (** (0018,980F) *)
  val contributing_equipment_sequence : int32
  (** (0018,A001) *)
  val contribution_date_time : int32
  (** (0018,A002) *)
  val contribution_description : int32
  (** (0018,A003) *)
  val study_instance_uid : int32
  (** (0020,000D) *)
  val series_instance_uid : int32
  (** (0020,000E) *)
  val study_id : int32
  (** (0020,0010) *)
  val series_number : int32
  (** (0020,0011) *)
  val acquisition_number : int32
  (** (0020,0012) *)
  val instance_number : int32
  (** (0020,0013) *)
  val isotope_number : int32
  (** (0020,0014) *)
  val phase_number : int32
  (** (0020,0015) *)
  val interval_number : int32
  (** (0020,0016) *)
  val time_slot_number : int32
  (** (0020,0017) *)
  val angle_number : int32
  (** (0020,0018) *)
  val item_number : int32
  (** (0020,0019) *)
  val patient_orientation : int32
  (** (0020,0020) *)
  val overlay_number : int32
  (** (0020,0022) *)
  val curve_number : int32
  (** (0020,0024) *)
  val lut_number : int32
  (** (0020,0026) *)
  val image_position : int32
  (** (0020,0030) *)
  val image_position_patient : int32
  (** (0020,0032) *)
  val image_orientation : int32
  (** (0020,0035) *)
  val image_orientation_patient : int32
  (** (0020,0037) *)
  val location : int32
  (** (0020,0050) *)
  val frame_of_reference_uid : int32
  (** (0020,0052) *)
  val laterality : int32
  (** (0020,0060) *)
  val image_laterality : int32
  (** (0020,0062) *)
  val image_geometry_type : int32
  (** (0020,0070) *)
  val masking_image : int32
  (** (0020,0080) *)
  val report_number : int32
  (** (0020,00AA) *)
  val temporal_position_identifier : int32
  (** (0020,0100) *)
  val number_of_temporal_positions : int32
  (** (0020,0105) *)
  val temporal_resolution : int32
  (** (0020,0110) *)
  val synchronization_frame_of_reference_uid : int32
  (** (0020,0200) *)
  val sop_instance_uidofconcatenationsource : int32
  (** (0020,0242) *)
  val series_in_study : int32
  (** (0020,1000) *)
  val acquisitions_in_series : int32
  (** (0020,1001) *)
  val images_in_acquisition : int32
  (** (0020,1002) *)
  val images_in_series : int32
  (** (0020,1003) *)
  val acquisitions_in_study : int32
  (** (0020,1004) *)
  val images_in_study : int32
  (** (0020,1005) *)
  val reference : int32
  (** (0020,1020) *)
  val position_reference_indicator : int32
  (** (0020,1040) *)
  val slice_location : int32
  (** (0020,1041) *)
  val other_study_numbers : int32
  (** (0020,1070) *)
  val number_of_patient_related_studies : int32
  (** (0020,1200) *)
  val number_of_patient_related_series : int32
  (** (0020,1202) *)
  val number_of_patient_related_instances : int32
  (** (0020,1204) *)
  val number_of_study_related_series : int32
  (** (0020,1206) *)
  val number_of_study_related_instances : int32
  (** (0020,1208) *)
  val number_of_series_related_instances : int32
  (** (0020,1209) *)
  val source_image_ids : int32
  (** (0020,3100) *)
  val modifying_device_id : int32
  (** (0020,3401) *)
  val modified_image_id : int32
  (** (0020,3402) *)
  val modified_image_date : int32
  (** (0020,3403) *)
  val modifying_device_manufacturer : int32
  (** (0020,3404) *)
  val modified_image_time : int32
  (** (0020,3405) *)
  val modified_image_description : int32
  (** (0020,3406) *)
  val image_comments : int32
  (** (0020,4000) *)
  val original_image_identification : int32
  (** (0020,5000) *)
  val original_image_identification_nomenclature : int32
  (** (0020,5002) *)
  val stack_id : int32
  (** (0020,9056) *)
  val in_stack_position_number : int32
  (** (0020,9057) *)
  val frame_anatomy_sequence : int32
  (** (0020,9071) *)
  val frame_laterality : int32
  (** (0020,9072) *)
  val frame_content_sequence : int32
  (** (0020,9111) *)
  val plane_position_sequence : int32
  (** (0020,9113) *)
  val plane_orientation_sequence : int32
  (** (0020,9116) *)
  val temporal_position_index : int32
  (** (0020,9128) *)
  val nominal_cardiac_trigger_delay_time : int32
  (** (0020,9153) *)
  val nominal_cardiac_trigger_time_prior_to_rpeak : int32
  (** (0020,9154) *)
  val actual_cardiac_trigger_time_prior_to_rpeak : int32
  (** (0020,9155) *)
  val frame_acquisition_number : int32
  (** (0020,9156) *)
  val dimension_index_values : int32
  (** (0020,9157) *)
  val frame_comments : int32
  (** (0020,9158) *)
  val concatenation_uid : int32
  (** (0020,9161) *)
  val in_concatenation_number : int32
  (** (0020,9162) *)
  val in_concatenation_total_number : int32
  (** (0020,9163) *)
  val dimension_organization_uid : int32
  (** (0020,9164) *)
  val dimension_index_pointer : int32
  (** (0020,9165) *)
  val functional_group_pointer : int32
  (** (0020,9167) *)
  val dimension_index_private_creator : int32
  (** (0020,9213) *)
  val dimension_organization_sequence : int32
  (** (0020,9221) *)
  val dimension_index_sequence : int32
  (** (0020,9222) *)
  val concatenation_frame_offset_number : int32
  (** (0020,9228) *)
  val functional_group_private_creator : int32
  (** (0020,9238) *)
  val nominal_percentage_of_cardiac_phase : int32
  (** (0020,9241) *)
  val nominal_percentage_of_respiratory_phase : int32
  (** (0020,9245) *)
  val starting_respiratory_amplitude : int32
  (** (0020,9246) *)
  val starting_respiratory_phase : int32
  (** (0020,9247) *)
  val ending_respiratory_amplitude : int32
  (** (0020,9248) *)
  val ending_respiratory_phase : int32
  (** (0020,9249) *)
  val respiratory_trigger_type : int32
  (** (0020,9250) *)
  val rr_interval_time_nominal : int32
  (** (0020,9251) *)
  val actual_cardiac_trigger_delay_time : int32
  (** (0020,9252) *)
  val respiratory_synchronization_sequence : int32
  (** (0020,9253) *)
  val respiratory_interval_time : int32
  (** (0020,9254) *)
  val nominal_respiratory_trigger_delay_time : int32
  (** (0020,9255) *)
  val respiratory_trigger_delay_threshold : int32
  (** (0020,9256) *)
  val actual_respiratory_trigger_delay_time : int32
  (** (0020,9257) *)
  val image_position_volume : int32
  (** (0020,9301) *)
  val image_orientation_volume : int32
  (** (0020,9302) *)
  val ultrasound_acquisition_geometry : int32
  (** (0020,9307) *)
  val apex_position : int32
  (** (0020,9308) *)
  val volume_to_transducer_mapping_matrix : int32
  (** (0020,9309) *)
  val volume_to_table_mapping_matrix : int32
  (** (0020,930A) *)
  val patient_frame_of_reference_source : int32
  (** (0020,930C) *)
  val temporal_position_time_offset : int32
  (** (0020,930D) *)
  val plane_position_volume_sequence : int32
  (** (0020,930E) *)
  val plane_orientation_volume_sequence : int32
  (** (0020,930F) *)
  val temporal_position_sequence : int32
  (** (0020,9310) *)
  val dimension_organization_type : int32
  (** (0020,9311) *)
  val volume_frame_of_reference_uid : int32
  (** (0020,9312) *)
  val table_frame_of_reference_uid : int32
  (** (0020,9313) *)
  val dimension_description_label : int32
  (** (0020,9421) *)
  val patient_orientation_in_frame_sequence : int32
  (** (0020,9450) *)
  val frame_label : int32
  (** (0020,9453) *)
  val acquisition_index : int32
  (** (0020,9518) *)
  val contributing_sop_instances_reference_sequence : int32
  (** (0020,9529) *)
  val reconstruction_index : int32
  (** (0020,9536) *)
  val light_path_filter_pass_through_wavelength : int32
  (** (0022,0001) *)
  val light_path_filter_pass_band : int32
  (** (0022,0002) *)
  val image_path_filter_pass_through_wavelength : int32
  (** (0022,0003) *)
  val image_path_filter_pass_band : int32
  (** (0022,0004) *)
  val patient_eye_movement_commanded : int32
  (** (0022,0005) *)
  val patient_eye_movement_command_code_sequence : int32
  (** (0022,0006) *)
  val spherical_lens_power : int32
  (** (0022,0007) *)
  val cylinder_lens_power : int32
  (** (0022,0008) *)
  val cylinder_axis : int32
  (** (0022,0009) *)
  val emmetropic_magnification : int32
  (** (0022,000A) *)
  val intra_ocular_pressure : int32
  (** (0022,000B) *)
  val horizontal_field_of_view : int32
  (** (0022,000C) *)
  val pupil_dilated : int32
  (** (0022,000D) *)
  val degree_of_dilation : int32
  (** (0022,000E) *)
  val stereo_baseline_angle : int32
  (** (0022,0010) *)
  val stereo_baseline_displacement : int32
  (** (0022,0011) *)
  val stereo_horizontal_pixel_offset : int32
  (** (0022,0012) *)
  val stereo_vertical_pixel_offset : int32
  (** (0022,0013) *)
  val stereo_rotation : int32
  (** (0022,0014) *)
  val acquisition_device_type_code_sequence : int32
  (** (0022,0015) *)
  val illumination_type_code_sequence : int32
  (** (0022,0016) *)
  val light_path_filter_type_stack_code_sequence : int32
  (** (0022,0017) *)
  val image_path_filter_type_stack_code_sequence : int32
  (** (0022,0018) *)
  val lenses_code_sequence : int32
  (** (0022,0019) *)
  val channel_description_code_sequence : int32
  (** (0022,001A) *)
  val refractive_state_sequence : int32
  (** (0022,001B) *)
  val mydriatic_agent_code_sequence : int32
  (** (0022,001C) *)
  val relative_image_position_code_sequence : int32
  (** (0022,001D) *)
  val camera_angle_of_view : int32
  (** (0022,001E) *)
  val stereo_pairs_sequence : int32
  (** (0022,0020) *)
  val left_image_sequence : int32
  (** (0022,0021) *)
  val right_image_sequence : int32
  (** (0022,0022) *)
  val axial_length_of_the_eye : int32
  (** (0022,0030) *)
  val ophthalmic_frame_location_sequence : int32
  (** (0022,0031) *)
  val reference_coordinates : int32
  (** (0022,0032) *)
  val depth_spatial_resolution : int32
  (** (0022,0035) *)
  val maximum_depth_distortion : int32
  (** (0022,0036) *)
  val along_scan_spatial_resolution : int32
  (** (0022,0037) *)
  val maximum_along_scan_distortion : int32
  (** (0022,0038) *)
  val ophthalmic_image_orientation : int32
  (** (0022,0039) *)
  val depth_of_transverse_image : int32
  (** (0022,0041) *)
  val mydriatic_agent_concentration_units_sequence : int32
  (** (0022,0042) *)
  val across_scan_spatial_resolution : int32
  (** (0022,0048) *)
  val maximum_across_scan_distortion : int32
  (** (0022,0049) *)
  val mydriatic_agent_concentration : int32
  (** (0022,004E) *)
  val illumination_wave_length : int32
  (** (0022,0055) *)
  val illumination_power : int32
  (** (0022,0056) *)
  val illumination_bandwidth : int32
  (** (0022,0057) *)
  val mydriatic_agent_sequence : int32
  (** (0022,0058) *)
  val ophthalmic_axial_measurements_right_eye_sequence : int32
  (** (0022,1007) *)
  val ophthalmic_axial_measurements_left_eye_sequence : int32
  (** (0022,1008) *)
  val ophthalmic_axial_length_measurements_type : int32
  (** (0022,1010) *)
  val ophthalmic_axial_length : int32
  (** (0022,1019) *)
  val lens_status_code_sequence : int32
  (** (0022,1024) *)
  val vitreous_status_code_sequence : int32
  (** (0022,1025) *)
  val iol_formula_code_sequence : int32
  (** (0022,1028) *)
  val iol_formula_detail : int32
  (** (0022,1029) *)
  val keratometer_index : int32
  (** (0022,1033) *)
  val source_of_ophthalmic_axial_length_code_sequence : int32
  (** (0022,1035) *)
  val target_refraction : int32
  (** (0022,1037) *)
  val refractive_procedure_occurred : int32
  (** (0022,1039) *)
  val refractive_surgery_type_code_sequence : int32
  (** (0022,1040) *)
  val ophthalmic_ultrasound_axial_measurements_type_code_sequence : int32
  (** (0022,1044) *)
  val ophthalmic_axial_length_measurements_sequence : int32
  (** (0022,1050) *)
  val iol_power : int32
  (** (0022,1053) *)
  val predicted_refractive_error : int32
  (** (0022,1054) *)
  val ophthalmic_axial_length_velocity : int32
  (** (0022,1059) *)
  val lens_status_description : int32
  (** (0022,1065) *)
  val vitreous_status_description : int32
  (** (0022,1066) *)
  val iol_power_sequence : int32
  (** (0022,1090) *)
  val lens_constant_sequence : int32
  (** (0022,1092) *)
  val iol_manufacturer : int32
  (** (0022,1093) *)
  val lens_constant_description : int32
  (** (0022,1094) *)
  val keratometry_measurement_type_code_sequence : int32
  (** (0022,1096) *)
  val referenced_ophthalmic_axial_measurements_sequence : int32
  (** (0022,1100) *)
  val ophthalmic_axial_length_measurements_segment_name_code_sequence : int32
  (** (0022,1101) *)
  val refractive_error_before_refractive_surgery_code_sequence : int32
  (** (0022,1103) *)
  val iol_power_for_exact_emmetropia : int32
  (** (0022,1121) *)
  val iol_power_for_exact_target_refraction : int32
  (** (0022,1122) *)
  val anterior_chamber_depth_definition_code_sequence : int32
  (** (0022,1125) *)
  val lens_thickness : int32
  (** (0022,1130) *)
  val anterior_chamber_depth : int32
  (** (0022,1131) *)
  val source_of_lens_thickness_data_code_sequence : int32
  (** (0022,1132) *)
  val source_of_anterior_chamber_depth_data_code_sequence : int32
  (** (0022,1133) *)
  val source_of_refractive_error_data_code_sequence : int32
  (** (0022,1135) *)
  val ophthalmic_axial_length_measurement_modified : int32
  (** (0022,1140) *)
  val ophthalmic_axial_length_data_source_code_sequence : int32
  (** (0022,1150) *)
  val ophthalmic_axial_length_acquisition_method_code_sequence : int32
  (** (0022,1153) *)
  val signal_to_noise_ratio : int32
  (** (0022,1155) *)
  val ophthalmic_axial_length_data_source_description : int32
  (** (0022,1159) *)
  val ophthalmic_axial_length_measurements_total_length_sequence : int32
  (** (0022,1210) *)
  val ophthalmic_axial_length_measurements_segmental_length_sequence : int32
  (** (0022,1211) *)
  val ophthalmic_axial_length_measurements_length_summation_sequence : int32
  (** (0022,1212) *)
  val ultrasound_ophthalmic_axial_length_measurements_sequence : int32
  (** (0022,1220) *)
  val optical_ophthalmic_axial_length_measurements_sequence : int32
  (** (0022,1225) *)
  val ultrasound_selected_ophthalmic_axial_length_sequence : int32
  (** (0022,1230) *)
  val ophthalmic_axial_length_selection_method_code_sequence : int32
  (** (0022,1250) *)
  val optical_selected_ophthalmic_axial_length_sequence : int32
  (** (0022,1255) *)
  val selected_segmental_ophthalmic_axial_length_sequence : int32
  (** (0022,1257) *)
  val selected_total_ophthalmic_axial_length_sequence : int32
  (** (0022,1260) *)
  val ophthalmic_axial_length_quality_metric_sequence : int32
  (** (0022,1262) *)
  val ophthalmic_axial_length_quality_metric_type_description : int32
  (** (0022,1273) *)
  val intraocular_lens_calculations_right_eye_sequence : int32
  (** (0022,1300) *)
  val intraocular_lens_calculations_left_eye_sequence : int32
  (** (0022,1310) *)
  val referenced_ophthalmic_axial_length_measurement_qcimage_sequence : int32
  (** (0022,1330) *)
  val visual_field_horizontal_extent : int32
  (** (0024,0010) *)
  val visual_field_vertical_extent : int32
  (** (0024,0011) *)
  val visual_field_shape : int32
  (** (0024,0012) *)
  val screening_test_mode_code_sequence : int32
  (** (0024,0016) *)
  val maximum_stimulus_luminance : int32
  (** (0024,0018) *)
  val background_luminance : int32
  (** (0024,0020) *)
  val stimulus_color_code_sequence : int32
  (** (0024,0021) *)
  val background_illumination_color_code_sequence : int32
  (** (0024,0024) *)
  val stimulus_area : int32
  (** (0024,0025) *)
  val stimulus_presentation_time : int32
  (** (0024,0028) *)
  val fixation_sequence : int32
  (** (0024,0032) *)
  val fixation_monitoring_code_sequence : int32
  (** (0024,0033) *)
  val visual_field_catch_trial_sequence : int32
  (** (0024,0034) *)
  val fixation_checked_quantity : int32
  (** (0024,0035) *)
  val patient_not_properly_fixated_quantity : int32
  (** (0024,0036) *)
  val presented_visual_stimuli_data_flag : int32
  (** (0024,0037) *)
  val number_of_visual_stimuli : int32
  (** (0024,0038) *)
  val excessive_fixation_losses_data_flag : int32
  (** (0024,0039) *)
  val excessive_fixation_losses : int32
  (** (0024,0040) *)
  val stimuli_retesting_quantity : int32
  (** (0024,0042) *)
  val comments_on_patient_performance_of_visual_field : int32
  (** (0024,0044) *)
  val false_negatives_estimate_flag : int32
  (** (0024,0045) *)
  val false_negatives_estimate : int32
  (** (0024,0046) *)
  val negative_catch_trials_quantity : int32
  (** (0024,0048) *)
  val false_negatives_quantity : int32
  (** (0024,0050) *)
  val excessive_false_negatives_data_flag : int32
  (** (0024,0051) *)
  val excessive_false_negatives : int32
  (** (0024,0052) *)
  val false_positives_estimate_flag : int32
  (** (0024,0053) *)
  val false_positives_estimate : int32
  (** (0024,0054) *)
  val catch_trials_data_flag : int32
  (** (0024,0055) *)
  val positive_catch_trials_quantity : int32
  (** (0024,0056) *)
  val test_point_normals_data_flag : int32
  (** (0024,0057) *)
  val test_point_normals_sequence : int32
  (** (0024,0058) *)
  val global_deviation_probability_normals_flag : int32
  (** (0024,0059) *)
  val false_positives_quantity : int32
  (** (0024,0060) *)
  val excessive_false_positives_data_flag : int32
  (** (0024,0061) *)
  val excessive_false_positives : int32
  (** (0024,0062) *)
  val visual_field_test_normals_flag : int32
  (** (0024,0063) *)
  val results_normals_sequence : int32
  (** (0024,0064) *)
  val age_corrected_sensitivity_deviation_algorithm_sequence : int32
  (** (0024,0065) *)
  val global_deviation_from_normal : int32
  (** (0024,0066) *)
  val generalized_defect_sensitivity_deviation_algorithm_sequence : int32
  (** (0024,0067) *)
  val localized_deviationfrom_normal : int32
  (** (0024,0068) *)
  val patient_reliability_indicator : int32
  (** (0024,0069) *)
  val visual_field_mean_sensitivity : int32
  (** (0024,0070) *)
  val global_deviation_probability : int32
  (** (0024,0071) *)
  val local_deviation_probability_normals_flag : int32
  (** (0024,0072) *)
  val localized_deviation_probability : int32
  (** (0024,0073) *)
  val short_term_fluctuation_calculated : int32
  (** (0024,0074) *)
  val short_term_fluctuation : int32
  (** (0024,0075) *)
  val short_term_fluctuation_probability_calculated : int32
  (** (0024,0076) *)
  val short_term_fluctuation_probability : int32
  (** (0024,0077) *)
  val corrected_localized_deviation_from_normal_calculated : int32
  (** (0024,0078) *)
  val corrected_localized_deviation_from_normal : int32
  (** (0024,0079) *)
  val corrected_localized_deviation_from_normal_probability_calculated : int32
  (** (0024,0080) *)
  val corrected_localized_deviation_from_normal_probability : int32
  (** (0024,0081) *)
  val global_deviation_probability_sequence : int32
  (** (0024,0083) *)
  val localized_deviation_probability_sequence : int32
  (** (0024,0085) *)
  val foveal_sensitivity_measured : int32
  (** (0024,0086) *)
  val foveal_sensitivity : int32
  (** (0024,0087) *)
  val visual_field_test_duration : int32
  (** (0024,0088) *)
  val visual_field_test_point_sequence : int32
  (** (0024,0089) *)
  val visual_field_test_point_xcoordinate : int32
  (** (0024,0090) *)
  val visual_field_test_point_ycoordinate : int32
  (** (0024,0091) *)
  val age_corrected_sensitivity_deviation_value : int32
  (** (0024,0092) *)
  val stimulus_results : int32
  (** (0024,0093) *)
  val sensitivity_value : int32
  (** (0024,0094) *)
  val retest_stimulus_seen : int32
  (** (0024,0095) *)
  val retest_sensitivity_value : int32
  (** (0024,0096) *)
  val visual_field_test_point_normals_sequence : int32
  (** (0024,0097) *)
  val quantified_defect : int32
  (** (0024,0098) *)
  val age_corrected_sensitivity_deviation_probability_value : int32
  (** (0024,0100) *)
  val generalized_defect_corrected_sensitivity_deviation_flag : int32
  (** (0024,0102) *)
  val generalized_defect_corrected_sensitivity_deviation_value : int32
  (** (0024,0103) *)
  val generalized_defect_corrected_sensitivity_deviation_probability_value : int32
  (** (0024,0104) *)
  val minimum_sensitivity_value : int32
  (** (0024,0105) *)
  val blind_spot_localized : int32
  (** (0024,0106) *)
  val blind_spot_xcoordinate : int32
  (** (0024,0107) *)
  val blind_spot_ycoordinate : int32
  (** (0024,0108) *)
  val visual_acuity_measurement_sequence : int32
  (** (0024,0110) *)
  val refractive_parameters_used_on_patient_sequence : int32
  (** (0024,0112) *)
  val measurement_laterality : int32
  (** (0024,0113) *)
  val ophthalmic_patient_clinical_information_left_eye_sequence : int32
  (** (0024,0114) *)
  val ophthalmic_patient_clinical_information_right_eye_sequence : int32
  (** (0024,0115) *)
  val foveal_point_normative_data_flag : int32
  (** (0024,0117) *)
  val foveal_point_probability_value : int32
  (** (0024,0118) *)
  val screening_baseline_measured : int32
  (** (0024,0120) *)
  val screening_baseline_measured_sequence : int32
  (** (0024,0122) *)
  val screening_baseline_type : int32
  (** (0024,0124) *)
  val screening_baseline_value : int32
  (** (0024,0126) *)
  val algorithm_source : int32
  (** (0024,0202) *)
  val data_set_name : int32
  (** (0024,0306) *)
  val data_set_version : int32
  (** (0024,0307) *)
  val data_set_source : int32
  (** (0024,0308) *)
  val data_set_description : int32
  (** (0024,0309) *)
  val visual_field_test_reliability_global_index_sequence : int32
  (** (0024,0317) *)
  val visual_field_global_results_index_sequence : int32
  (** (0024,0320) *)
  val data_observation_sequence : int32
  (** (0024,0325) *)
  val index_normals_flag : int32
  (** (0024,0338) *)
  val index_probability : int32
  (** (0024,0341) *)
  val index_probability_sequence : int32
  (** (0024,0344) *)
  val samples_per_pixel : int32
  (** (0028,0002) *)
  val samples_per_pixel_used : int32
  (** (0028,0003) *)
  val photometric_interpretation : int32
  (** (0028,0004) *)
  val image_dimensions : int32
  (** (0028,0005) *)
  val planar_configuration : int32
  (** (0028,0006) *)
  val number_of_frames : int32
  (** (0028,0008) *)
  val frame_increment_pointer : int32
  (** (0028,0009) *)
  val frame_dimension_pointer : int32
  (** (0028,000A) *)
  val rows : int32
  (** (0028,0010) *)
  val columns : int32
  (** (0028,0011) *)
  val planes : int32
  (** (0028,0012) *)
  val ultrasound_color_data_present : int32
  (** (0028,0014) *)
  val pixel_spacing : int32
  (** (0028,0030) *)
  val zoom_factor : int32
  (** (0028,0031) *)
  val zoom_center : int32
  (** (0028,0032) *)
  val pixel_aspect_ratio : int32
  (** (0028,0034) *)
  val image_format : int32
  (** (0028,0040) *)
  val manipulated_image : int32
  (** (0028,0050) *)
  val corrected_image : int32
  (** (0028,0051) *)
  val compression_recognition_code : int32
  (** (0028,005F) *)
  val compression_code : int32
  (** (0028,0060) *)
  val compression_originator : int32
  (** (0028,0061) *)
  val compression_label : int32
  (** (0028,0062) *)
  val compression_description : int32
  (** (0028,0063) *)
  val compression_sequence : int32
  (** (0028,0065) *)
  val compression_step_pointers : int32
  (** (0028,0066) *)
  val repeat_interval : int32
  (** (0028,0068) *)
  val bits_grouped : int32
  (** (0028,0069) *)
  val perimeter_table : int32
  (** (0028,0070) *)
  val perimeter_value : int32
  (** (0028,0071) *)
  val predictor_rows : int32
  (** (0028,0080) *)
  val predictor_columns : int32
  (** (0028,0081) *)
  val predictor_constants : int32
  (** (0028,0082) *)
  val blocked_pixels : int32
  (** (0028,0090) *)
  val block_rows : int32
  (** (0028,0091) *)
  val block_columns : int32
  (** (0028,0092) *)
  val row_overlap : int32
  (** (0028,0093) *)
  val column_overlap : int32
  (** (0028,0094) *)
  val bits_allocated : int32
  (** (0028,0100) *)
  val bits_stored : int32
  (** (0028,0101) *)
  val high_bit : int32
  (** (0028,0102) *)
  val pixel_representation : int32
  (** (0028,0103) *)
  val smallest_valid_pixel_value : int32
  (** (0028,0104) *)
  val largest_valid_pixel_value : int32
  (** (0028,0105) *)
  val smallest_image_pixel_value : int32
  (** (0028,0106) *)
  val largest_image_pixel_value : int32
  (** (0028,0107) *)
  val smallest_pixel_value_in_series : int32
  (** (0028,0108) *)
  val largest_pixel_value_in_series : int32
  (** (0028,0109) *)
  val smallest_image_pixel_value_in_plane : int32
  (** (0028,0110) *)
  val largest_image_pixel_value_in_plane : int32
  (** (0028,0111) *)
  val pixel_padding_value : int32
  (** (0028,0120) *)
  val pixel_padding_range_limit : int32
  (** (0028,0121) *)
  val image_location : int32
  (** (0028,0200) *)
  val quality_control_image : int32
  (** (0028,0300) *)
  val burned_in_annotation : int32
  (** (0028,0301) *)
  val recognizable_visual_features : int32
  (** (0028,0302) *)
  val longitudinal_temporal_information_modified : int32
  (** (0028,0303) *)
  val transform_label : int32
  (** (0028,0400) *)
  val transform_version_number : int32
  (** (0028,0401) *)
  val number_of_transform_steps : int32
  (** (0028,0402) *)
  val sequence_of_compressed_data : int32
  (** (0028,0403) *)
  val details_of_coefficients : int32
  (** (0028,0404) *)
  val rows_for_nth_order_coefficients : int32
  (** (0028,0400) *)
  val columns_for_nth_order_coefficients : int32
  (** (0028,0401) *)
  val coefficient_coding : int32
  (** (0028,0402) *)
  val coefficient_coding_pointers : int32
  (** (0028,0403) *)
  val dct_label : int32
  (** (0028,0700) *)
  val data_block_description : int32
  (** (0028,0701) *)
  val data_block : int32
  (** (0028,0702) *)
  val normalization_factor_format : int32
  (** (0028,0710) *)
  val zonal_map_number_format : int32
  (** (0028,0720) *)
  val zonal_map_location : int32
  (** (0028,0721) *)
  val zonal_map_format : int32
  (** (0028,0722) *)
  val adaptive_map_format : int32
  (** (0028,0730) *)
  val code_number_format : int32
  (** (0028,0740) *)
  val code_label : int32
  (** (0028,0800) *)
  val number_of_tables : int32
  (** (0028,0802) *)
  val code_table_location : int32
  (** (0028,0803) *)
  val bits_for_code_word : int32
  (** (0028,0804) *)
  val image_data_location : int32
  (** (0028,0808) *)
  val pixel_spacing_calibration_type : int32
  (** (0028,0A02) *)
  val pixel_spacing_calibration_description : int32
  (** (0028,0A04) *)
  val pixel_intensity_relationship : int32
  (** (0028,1040) *)
  val pixel_intensity_relationship_sign : int32
  (** (0028,1041) *)
  val window_center : int32
  (** (0028,1050) *)
  val window_width : int32
  (** (0028,1051) *)
  val rescale_intercept : int32
  (** (0028,1052) *)
  val rescale_slope : int32
  (** (0028,1053) *)
  val rescale_type : int32
  (** (0028,1054) *)
  val window_center_width_explanation : int32
  (** (0028,1055) *)
  val voi_lut_function : int32
  (** (0028,1056) *)
  val gray_scale : int32
  (** (0028,1080) *)
  val recommended_viewing_mode : int32
  (** (0028,1090) *)
  val gray_lookup_table_descriptor : int32
  (** (0028,1100) *)
  val red_palette_color_lookup_table_descriptor : int32
  (** (0028,1101) *)
  val green_palette_color_lookup_table_descriptor : int32
  (** (0028,1102) *)
  val blue_palette_color_lookup_table_descriptor : int32
  (** (0028,1103) *)
  val alpha_palette_color_lookup_table_descriptor : int32
  (** (0028,1104) *)
  val large_red_palette_color_lookup_table_descriptor : int32
  (** (0028,1111) *)
  val large_green_palette_color_lookup_table_descriptor : int32
  (** (0028,1112) *)
  val large_blue_palette_color_lookup_table_descriptor : int32
  (** (0028,1113) *)
  val palette_color_lookup_table_uid : int32
  (** (0028,1199) *)
  val gray_lookup_table_data : int32
  (** (0028,1200) *)
  val red_palette_color_lookup_table_data : int32
  (** (0028,1201) *)
  val green_palette_color_lookup_table_data : int32
  (** (0028,1202) *)
  val blue_palette_color_lookup_table_data : int32
  (** (0028,1203) *)
  val alpha_palette_color_lookup_table_data : int32
  (** (0028,1204) *)
  val large_red_palette_color_lookup_table_data : int32
  (** (0028,1211) *)
  val large_green_palette_color_lookup_table_data : int32
  (** (0028,1212) *)
  val large_blue_palette_color_lookup_table_data : int32
  (** (0028,1213) *)
  val large_palette_color_lookup_table_uid : int32
  (** (0028,1214) *)
  val segmented_red_palette_color_lookup_table_data : int32
  (** (0028,1221) *)
  val segmented_green_palette_color_lookup_table_data : int32
  (** (0028,1222) *)
  val segmented_blue_palette_color_lookup_table_data : int32
  (** (0028,1223) *)
  val breast_implant_present : int32
  (** (0028,1300) *)
  val partial_view : int32
  (** (0028,1350) *)
  val partial_view_description : int32
  (** (0028,1351) *)
  val partial_view_code_sequence : int32
  (** (0028,1352) *)
  val spatial_locations_preserved : int32
  (** (0028,135A) *)
  val data_frame_assignment_sequence : int32
  (** (0028,1401) *)
  val data_path_assignment : int32
  (** (0028,1402) *)
  val bits_mapped_to_color_lookup_table : int32
  (** (0028,1403) *)
  val blending_lut1_sequence : int32
  (** (0028,1404) *)
  val blending_lut1_transfer_function : int32
  (** (0028,1405) *)
  val blending_weight_constant : int32
  (** (0028,1406) *)
  val blending_lookup_table_descriptor : int32
  (** (0028,1407) *)
  val blending_lookup_table_data : int32
  (** (0028,1408) *)
  val enhanced_palette_color_lookup_table_sequence : int32
  (** (0028,140B) *)
  val blending_lut2_sequence : int32
  (** (0028,140C) *)
  val blending_lut2_transfer_function : int32
  (** (0028,140D) *)
  val data_path_id : int32
  (** (0028,140E) *)
  val rgb_lut_transfer_function : int32
  (** (0028,140F) *)
  val alpha_lut_transfer_function : int32
  (** (0028,1410) *)
  val icc_profile : int32
  (** (0028,2000) *)
  val lossy_image_compression : int32
  (** (0028,2110) *)
  val lossy_image_compression_ratio : int32
  (** (0028,2112) *)
  val lossy_image_compression_method : int32
  (** (0028,2114) *)
  val modality_lut_sequence : int32
  (** (0028,3000) *)
  val lut_descriptor : int32
  (** (0028,3002) *)
  val lut_explanation : int32
  (** (0028,3003) *)
  val modality_lut_type : int32
  (** (0028,3004) *)
  val lut_data : int32
  (** (0028,3006) *)
  val voi_lut_sequence : int32
  (** (0028,3010) *)
  val soft_copy_void_lut_sequence : int32
  (** (0028,3110) *)
  val image_presentation_comments : int32
  (** (0028,4000) *)
  val bi_plane_acquisition_sequence : int32
  (** (0028,5000) *)
  val representative_frame_number : int32
  (** (0028,6010) *)
  val frame_numbers_of_interest : int32
  (** (0028,6020) *)
  val frame_of_interest_description : int32
  (** (0028,6022) *)
  val frame_of_interest_type : int32
  (** (0028,6023) *)
  val mask_pointers : int32
  (** (0028,6030) *)
  val r_wave_pointer : int32
  (** (0028,6040) *)
  val mask_subtraction_sequence : int32
  (** (0028,6100) *)
  val mask_operation : int32
  (** (0028,6101) *)
  val applicable_frame_range : int32
  (** (0028,6102) *)
  val mask_frame_numbers : int32
  (** (0028,6110) *)
  val contrast_frame_averaging : int32
  (** (0028,6112) *)
  val mask_sub_pixel_shift : int32
  (** (0028,6114) *)
  val tid_offset : int32
  (** (0028,6120) *)
  val mask_operation_explanation : int32
  (** (0028,6190) *)
  val pixel_data_provider_url : int32
  (** (0028,7FE0) *)
  val data_point_rows : int32
  (** (0028,9001) *)
  val data_point_columns : int32
  (** (0028,9002) *)
  val signal_domain_columns : int32
  (** (0028,9003) *)
  val largest_monochrome_pixel_value : int32
  (** (0028,9099) *)
  val data_representation : int32
  (** (0028,9108) *)
  val pixel_measures_sequence : int32
  (** (0028,9110) *)
  val frame_voi_lut_sequence : int32
  (** (0028,9132) *)
  val pixel_value_transformation_sequence : int32
  (** (0028,9145) *)
  val signal_domain_rows : int32
  (** (0028,9235) *)
  val display_filter_percentage : int32
  (** (0028,9411) *)
  val frame_pixel_shift_sequence : int32
  (** (0028,9415) *)
  val subtraction_item_id : int32
  (** (0028,9416) *)
  val pixel_intensity_relationship_lutsequence : int32
  (** (0028,9422) *)
  val frame_pixel_data_properties_sequence : int32
  (** (0028,9443) *)
  val geometrical_properties : int32
  (** (0028,9444) *)
  val geometric_maximum_distortion : int32
  (** (0028,9445) *)
  val image_processing_applied : int32
  (** (0028,9446) *)
  val mask_selection_mode : int32
  (** (0028,9454) *)
  val lut_function : int32
  (** (0028,9474) *)
  val mask_visibility_percentage : int32
  (** (0028,9478) *)
  val pixel_shift_sequence : int32
  (** (0028,9501) *)
  val region_pixel_shift_sequence : int32
  (** (0028,9502) *)
  val vertices_of_the_region : int32
  (** (0028,9503) *)
  val multi_frame_presentation_sequence : int32
  (** (0028,9505) *)
  val pixel_shift_frame_range : int32
  (** (0028,9506) *)
  val lut_frame_range : int32
  (** (0028,9507) *)
  val image_to_equipment_mapping_matrix : int32
  (** (0028,9520) *)
  val equipment_coordinate_system_identification : int32
  (** (0028,9537) *)
  val study_status_id : int32
  (** (0032,000A) *)
  val study_priority_id : int32
  (** (0032,000C) *)
  val study_id_issuer : int32
  (** (0032,0012) *)
  val study_verified_date : int32
  (** (0032,0032) *)
  val study_verified_time : int32
  (** (0032,0033) *)
  val study_read_date : int32
  (** (0032,0034) *)
  val study_read_time : int32
  (** (0032,0035) *)
  val scheduled_study_start_date : int32
  (** (0032,1000) *)
  val scheduled_study_start_time : int32
  (** (0032,1001) *)
  val scheduled_study_stop_date : int32
  (** (0032,1010) *)
  val scheduled_study_stop_time : int32
  (** (0032,1011) *)
  val scheduled_study_location : int32
  (** (0032,1020) *)
  val scheduled_study_location_aetitle : int32
  (** (0032,1021) *)
  val reason_for_study : int32
  (** (0032,1030) *)
  val requesting_physician_identification_sequence : int32
  (** (0032,1031) *)
  val requesting_physician : int32
  (** (0032,1032) *)
  val requesting_service : int32
  (** (0032,1033) *)
  val requesting_service_code_sequence : int32
  (** (0032,1034) *)
  val study_arrival_date : int32
  (** (0032,1040) *)
  val study_arrival_time : int32
  (** (0032,1041) *)
  val study_completion_date : int32
  (** (0032,1050) *)
  val study_completion_time : int32
  (** (0032,1051) *)
  val study_component_status_id : int32
  (** (0032,1055) *)
  val requested_procedure_description : int32
  (** (0032,1060) *)
  val requested_procedure_code_sequence : int32
  (** (0032,1064) *)
  val requested_contrast_agent : int32
  (** (0032,1070) *)
  val study_comments : int32
  (** (0032,4000) *)
  val referenced_patient_alias_sequence : int32
  (** (0038,0004) *)
  val visit_status_id : int32
  (** (0038,0008) *)
  val admission_id : int32
  (** (0038,0010) *)
  val issuer_of_admission_id : int32
  (** (0038,0011) *)
  val issuer_of_admission_id_sequence : int32
  (** (0038,0014) *)
  val route_of_admissions : int32
  (** (0038,0016) *)
  val scheduled_admission_date : int32
  (** (0038,001A) *)
  val scheduled_admission_time : int32
  (** (0038,001B) *)
  val scheduled_discharge_date : int32
  (** (0038,001C) *)
  val scheduled_discharge_time : int32
  (** (0038,001D) *)
  val scheduled_patient_institution_residence : int32
  (** (0038,001E) *)
  val admitting_date : int32
  (** (0038,0020) *)
  val admitting_time : int32
  (** (0038,0021) *)
  val discharge_date : int32
  (** (0038,0030) *)
  val discharge_time : int32
  (** (0038,0032) *)
  val discharge_diagnosis_description : int32
  (** (0038,0040) *)
  val discharge_diagnosis_code_sequence : int32
  (** (0038,0044) *)
  val special_needs : int32
  (** (0038,0050) *)
  val service_episode_id : int32
  (** (0038,0060) *)
  val issuer_of_service_episode_id : int32
  (** (0038,0061) *)
  val service_episode_description : int32
  (** (0038,0062) *)
  val issuer_of_service_episode_id_sequence : int32
  (** (0038,0064) *)
  val pertinent_documents_sequence : int32
  (** (0038,0100) *)
  val current_patient_location : int32
  (** (0038,0300) *)
  val patient_institution_residence : int32
  (** (0038,0400) *)
  val patient_state : int32
  (** (0038,0500) *)
  val patient_clinical_trial_participation_sequence : int32
  (** (0038,0502) *)
  val visit_comments : int32
  (** (0038,4000) *)
  val waveform_originality : int32
  (** (003A,0004) *)
  val number_of_waveform_channels : int32
  (** (003A,0005) *)
  val number_of_waveform_samples : int32
  (** (003A,0010) *)
  val sampling_frequency : int32
  (** (003A,001A) *)
  val multiplex_group_label : int32
  (** (003A,0020) *)
  val channel_definition_sequence : int32
  (** (003A,0200) *)
  val waveform_channel_number : int32
  (** (003A,0202) *)
  val channel_label : int32
  (** (003A,0203) *)
  val channel_status : int32
  (** (003A,0205) *)
  val channel_source_sequence : int32
  (** (003A,0208) *)
  val channel_source_modifiers_sequence : int32
  (** (003A,0209) *)
  val source_waveform_sequence : int32
  (** (003A,020A) *)
  val channel_derivation_description : int32
  (** (003A,020C) *)
  val channel_sensitivity : int32
  (** (003A,0210) *)
  val channel_sensitivity_units_sequence : int32
  (** (003A,0211) *)
  val channel_sensitivity_correction_factor : int32
  (** (003A,0212) *)
  val channel_baseline : int32
  (** (003A,0213) *)
  val channel_time_skew : int32
  (** (003A,0214) *)
  val channel_sample_skew : int32
  (** (003A,0215) *)
  val channel_offset : int32
  (** (003A,0218) *)
  val waveform_bits_stored : int32
  (** (003A,021A) *)
  val filter_low_frequency : int32
  (** (003A,0220) *)
  val filter_high_frequency : int32
  (** (003A,0221) *)
  val notch_filter_frequency : int32
  (** (003A,0222) *)
  val notch_filter_bandwidth : int32
  (** (003A,0223) *)
  val waveform_data_display_scale : int32
  (** (003A,0230) *)
  val waveform_display_background_cielab_value : int32
  (** (003A,0231) *)
  val waveform_presentation_group_sequence : int32
  (** (003A,0240) *)
  val presentation_group_number : int32
  (** (003A,0241) *)
  val channel_display_sequence : int32
  (** (003A,0242) *)
  val channel_recommended_display_cielab_value : int32
  (** (003A,0244) *)
  val channel_position : int32
  (** (003A,0245) *)
  val display_shading_flag : int32
  (** (003A,0246) *)
  val fractional_channel_display_scale : int32
  (** (003A,0247) *)
  val absolute_channel_display_scale : int32
  (** (003A,0248) *)
  val multiplexed_audio_channels_description_code_sequence : int32
  (** (003A,0300) *)
  val channel_identification_code : int32
  (** (003A,0301) *)
  val channel_mode : int32
  (** (003A,0302) *)
  val scheduled_station_aetitle : int32
  (** (0040,0001) *)
  val scheduled_procedure_step_start_date : int32
  (** (0040,0002) *)
  val scheduled_procedure_step_start_time : int32
  (** (0040,0003) *)
  val scheduled_procedure_step_end_date : int32
  (** (0040,0004) *)
  val scheduled_procedure_step_end_time : int32
  (** (0040,0005) *)
  val scheduled_performing_physician_name : int32
  (** (0040,0006) *)
  val scheduled_procedure_step_description : int32
  (** (0040,0007) *)
  val scheduled_protocol_code_sequence : int32
  (** (0040,0008) *)
  val scheduled_procedure_step_id : int32
  (** (0040,0009) *)
  val stage_code_sequence : int32
  (** (0040,000A) *)
  val scheduled_performing_physician_identification_sequence : int32
  (** (0040,000B) *)
  val scheduled_station_name : int32
  (** (0040,0010) *)
  val scheduled_procedure_step_location : int32
  (** (0040,0011) *)
  val pre_medication : int32
  (** (0040,0012) *)
  val scheduled_procedure_step_status : int32
  (** (0040,0020) *)
  val order_placer_identifier_sequence : int32
  (** (0040,0026) *)
  val order_filler_identifier_sequence : int32
  (** (0040,0027) *)
  val local_namespace_entity_id : int32
  (** (0040,0031) *)
  val universal_entity_id : int32
  (** (0040,0032) *)
  val universal_entity_id_type : int32
  (** (0040,0033) *)
  val identifier_type_code : int32
  (** (0040,0035) *)
  val assigning_facility_sequence : int32
  (** (0040,0036) *)
  val assigning_jurisdiction_code_sequence : int32
  (** (0040,0039) *)
  val assigning_agency_or_department_code_sequence : int32
  (** (0040,003A) *)
  val scheduled_procedure_step_sequence : int32
  (** (0040,0100) *)
  val referenced_non_image_composite_sop_instance_sequence : int32
  (** (0040,0220) *)
  val performed_station_aetitle : int32
  (** (0040,0241) *)
  val performed_station_name : int32
  (** (0040,0242) *)
  val performed_location : int32
  (** (0040,0243) *)
  val performed_procedure_step_start_date : int32
  (** (0040,0244) *)
  val performed_procedure_step_start_time : int32
  (** (0040,0245) *)
  val performed_procedure_step_end_date : int32
  (** (0040,0250) *)
  val performed_procedure_step_end_time : int32
  (** (0040,0251) *)
  val performed_procedure_step_status : int32
  (** (0040,0252) *)
  val performed_procedure_step_id : int32
  (** (0040,0253) *)
  val performed_procedure_step_description : int32
  (** (0040,0254) *)
  val performed_procedure_type_description : int32
  (** (0040,0255) *)
  val performed_protocol_code_sequence : int32
  (** (0040,0260) *)
  val performed_protocol_type : int32
  (** (0040,0261) *)
  val scheduled_step_attributes_sequence : int32
  (** (0040,0270) *)
  val request_attributes_sequence : int32
  (** (0040,0275) *)
  val comments_on_the_performed_procedure_step : int32
  (** (0040,0280) *)
  val performed_procedure_step_discontinuation_reason_code_sequence : int32
  (** (0040,0281) *)
  val quantity_sequence : int32
  (** (0040,0293) *)
  val quantity : int32
  (** (0040,0294) *)
  val measuring_units_sequence : int32
  (** (0040,0295) *)
  val billing_item_sequence : int32
  (** (0040,0296) *)
  val total_time_of_fluoroscopy : int32
  (** (0040,0300) *)
  val total_number_of_exposures : int32
  (** (0040,0301) *)
  val entrance_dose : int32
  (** (0040,0302) *)
  val exposed_area : int32
  (** (0040,0303) *)
  val distance_source_to_entrance : int32
  (** (0040,0306) *)
  val distance_source_to_support : int32
  (** (0040,0307) *)
  val exposure_dose_sequence : int32
  (** (0040,030E) *)
  val comments_on_radiation_dose : int32
  (** (0040,0310) *)
  val x_ray_output : int32
  (** (0040,0312) *)
  val half_value_layer : int32
  (** (0040,0314) *)
  val organ_dose : int32
  (** (0040,0316) *)
  val organ_exposed : int32
  (** (0040,0318) *)
  val billing_procedure_step_sequence : int32
  (** (0040,0320) *)
  val film_consumption_sequence : int32
  (** (0040,0321) *)
  val billing_supplies_and_devices_sequence : int32
  (** (0040,0324) *)
  val referenced_procedure_step_sequence : int32
  (** (0040,0330) *)
  val performed_series_sequence : int32
  (** (0040,0340) *)
  val comments_on_the_scheduled_procedure_step : int32
  (** (0040,0400) *)
  val protocol_context_sequence : int32
  (** (0040,0440) *)
  val content_item_modifier_sequence : int32
  (** (0040,0441) *)
  val scheduled_specimen_sequence : int32
  (** (0040,0500) *)
  val specimen_accession_number : int32
  (** (0040,050A) *)
  val container_identifier : int32
  (** (0040,0512) *)
  val issuer_of_the_container_identifier_sequence : int32
  (** (0040,0513) *)
  val alternate_container_identifier_sequence : int32
  (** (0040,0515) *)
  val container_type_code_sequence : int32
  (** (0040,0518) *)
  val container_description : int32
  (** (0040,051A) *)
  val container_component_sequence : int32
  (** (0040,0520) *)
  val specimen_sequence : int32
  (** (0040,0550) *)
  val specimen_identifier : int32
  (** (0040,0551) *)
  val specimen_description_sequence_trial : int32
  (** (0040,0552) *)
  val specimen_description_trial : int32
  (** (0040,0553) *)
  val specimen_uid : int32
  (** (0040,0554) *)
  val acquisition_context_sequence : int32
  (** (0040,0555) *)
  val acquisition_context_description : int32
  (** (0040,0556) *)
  val specimen_type_code_sequence : int32
  (** (0040,059A) *)
  val specimen_description_sequence : int32
  (** (0040,0560) *)
  val issuer_of_the_specimen_identifier_sequence : int32
  (** (0040,0562) *)
  val specimen_short_description : int32
  (** (0040,0600) *)
  val specimen_detailed_description : int32
  (** (0040,0602) *)
  val specimen_preparation_sequence : int32
  (** (0040,0610) *)
  val specimen_preparation_step_content_item_sequence : int32
  (** (0040,0612) *)
  val specimen_localization_content_item_sequence : int32
  (** (0040,0620) *)
  val slide_identifier : int32
  (** (0040,06FA) *)
  val image_center_point_coordinates_sequence : int32
  (** (0040,071A) *)
  val x_offset_in_slide_coordinate_system : int32
  (** (0040,072A) *)
  val y_offset_in_slide_coordinate_system : int32
  (** (0040,073A) *)
  val z_offset_in_slide_coordinate_system : int32
  (** (0040,074A) *)
  val pixel_spacing_sequence : int32
  (** (0040,08D8) *)
  val coordinate_system_axis_code_sequence : int32
  (** (0040,08DA) *)
  val measurement_units_code_sequence : int32
  (** (0040,08EA) *)
  val vital_stain_code_sequence_trial : int32
  (** (0040,09F8) *)
  val requested_procedure_id : int32
  (** (0040,1001) *)
  val reason_for_the_requested_procedure : int32
  (** (0040,1002) *)
  val requested_procedure_priority : int32
  (** (0040,1003) *)
  val patient_transport_arrangements : int32
  (** (0040,1004) *)
  val requested_procedure_location : int32
  (** (0040,1005) *)
  val placer_order_number_procedure : int32
  (** (0040,1006) *)
  val filler_order_number_procedure : int32
  (** (0040,1007) *)
  val confidentiality_code : int32
  (** (0040,1008) *)
  val reporting_priority : int32
  (** (0040,1009) *)
  val reason_for_requested_procedure_code_sequence : int32
  (** (0040,100A) *)
  val names_of_intended_recipients_of_results : int32
  (** (0040,1010) *)
  val intended_recipients_of_results_identification_sequence : int32
  (** (0040,1011) *)
  val reason_for_performed_procedure_code_sequence : int32
  (** (0040,1012) *)
  val requested_procedure_description_trial : int32
  (** (0040,1060) *)
  val person_identification_code_sequence : int32
  (** (0040,1101) *)
  val person_address : int32
  (** (0040,1102) *)
  val person_telephone_numbers : int32
  (** (0040,1103) *)
  val requested_procedure_comments : int32
  (** (0040,1400) *)
  val reason_for_the_imaging_service_request : int32
  (** (0040,2001) *)
  val issue_date_of_imaging_service_request : int32
  (** (0040,2004) *)
  val issue_time_of_imaging_service_request : int32
  (** (0040,2005) *)
  val placer_order_number_imaging_service_request_retired : int32
  (** (0040,2006) *)
  val filler_order_number_imaging_service_request_retired : int32
  (** (0040,2007) *)
  val order_entered_by : int32
  (** (0040,2008) *)
  val order_enterer_location : int32
  (** (0040,2009) *)
  val order_callback_phone_number : int32
  (** (0040,2010) *)
  val placer_order_number_imaging_service_request : int32
  (** (0040,2016) *)
  val filler_order_number_imaging_service_request : int32
  (** (0040,2017) *)
  val imaging_service_request_comments : int32
  (** (0040,2400) *)
  val confidentiality_constraint_on_patient_data_description : int32
  (** (0040,3001) *)
  val general_purpose_scheduled_procedure_step_status : int32
  (** (0040,4001) *)
  val general_purpose_performed_procedure_step_status : int32
  (** (0040,4002) *)
  val general_purpose_scheduled_procedure_step_priority : int32
  (** (0040,4003) *)
  val scheduled_processing_applications_code_sequence : int32
  (** (0040,4004) *)
  val scheduled_procedure_step_start_date_time : int32
  (** (0040,4005) *)
  val multiple_copies_flag : int32
  (** (0040,4006) *)
  val performed_processing_applications_code_sequence : int32
  (** (0040,4007) *)
  val human_performer_code_sequence : int32
  (** (0040,4009) *)
  val scheduled_procedure_step_modification_date_time : int32
  (** (0040,4010) *)
  val expected_completion_date_time : int32
  (** (0040,4011) *)
  val resulting_general_purpose_performed_procedure_steps_sequence : int32
  (** (0040,4015) *)
  val referenced_general_purpose_scheduled_procedure_step_sequence : int32
  (** (0040,4016) *)
  val scheduled_workitem_code_sequence : int32
  (** (0040,4018) *)
  val performed_workitem_code_sequence : int32
  (** (0040,4019) *)
  val input_availability_flag : int32
  (** (0040,4020) *)
  val input_information_sequence : int32
  (** (0040,4021) *)
  val relevant_information_sequence : int32
  (** (0040,4022) *)
  val referenced_general_purpose_scheduled_procedure_step_transaction_uid : int32
  (** (0040,4023) *)
  val scheduled_station_name_code_sequence : int32
  (** (0040,4025) *)
  val scheduled_station_class_code_sequence : int32
  (** (0040,4026) *)
  val scheduled_station_geographic_location_code_sequence : int32
  (** (0040,4027) *)
  val performed_station_name_code_sequence : int32
  (** (0040,4028) *)
  val performed_station_class_code_sequence : int32
  (** (0040,4029) *)
  val performed_station_geographic_location_code_sequence : int32
  (** (0040,4030) *)
  val requested_subsequent_workitem_code_sequence : int32
  (** (0040,4031) *)
  val non_dicomoutput_code_sequence : int32
  (** (0040,4032) *)
  val output_information_sequence : int32
  (** (0040,4033) *)
  val scheduled_human_performers_sequence : int32
  (** (0040,4034) *)
  val actual_human_performers_sequence : int32
  (** (0040,4035) *)
  val human_performer_organization : int32
  (** (0040,4036) *)
  val human_performer_name : int32
  (** (0040,4037) *)
  val raw_data_handling : int32
  (** (0040,4040) *)
  val input_readiness_state : int32
  (** (0040,4041) *)
  val performed_procedure_step_start_date_time : int32
  (** (0040,4050) *)
  val performed_procedure_step_end_date_time : int32
  (** (0040,4051) *)
  val procedure_step_cancellation_date_time : int32
  (** (0040,4052) *)
  val entrance_dose_inm_gy : int32
  (** (0040,8302) *)
  val referenced_image_real_world_value_mapping_sequence : int32
  (** (0040,9094) *)
  val real_world_value_mapping_sequence : int32
  (** (0040,9096) *)
  val pixel_value_mapping_code_sequence : int32
  (** (0040,9098) *)
  val lut_label : int32
  (** (0040,9210) *)
  val real_world_value_last_value_mapped : int32
  (** (0040,9211) *)
  val real_world_value_lut_data : int32
  (** (0040,9212) *)
  val real_world_value_first_value_mapped : int32
  (** (0040,9216) *)
  val real_world_value_intercept : int32
  (** (0040,9224) *)
  val real_world_value_slope : int32
  (** (0040,9225) *)
  val findings_flag_trial : int32
  (** (0040,A007) *)
  val relationship_type : int32
  (** (0040,A010) *)
  val findings_sequence_trial : int32
  (** (0040,A020) *)
  val findings_group_uid_trial : int32
  (** (0040,A021) *)
  val referenced_findings_group_uid_trial : int32
  (** (0040,A022) *)
  val findings_group_recording_date_trial : int32
  (** (0040,A023) *)
  val findings_group_recording_time_trial : int32
  (** (0040,A024) *)
  val findings_source_category_code_sequence_trial : int32
  (** (0040,A026) *)
  val verifying_organization : int32
  (** (0040,A027) *)
  val documenting_organization_identifier_code_sequence_trial : int32
  (** (0040,A028) *)
  val verification_date_time : int32
  (** (0040,A030) *)
  val observation_date_time : int32
  (** (0040,A032) *)
  val value_type : int32
  (** (0040,A040) *)
  val concept_name_code_sequence : int32
  (** (0040,A043) *)
  val measurement_precision_description_trial : int32
  (** (0040,A047) *)
  val continuity_of_content : int32
  (** (0040,A050) *)
  val urgency_or_priority_alerts_trial : int32
  (** (0040,A057) *)
  val sequencing_indicator_trial : int32
  (** (0040,A060) *)
  val document_identifier_code_sequence_trial : int32
  (** (0040,A066) *)
  val document_author_trial : int32
  (** (0040,A067) *)
  val document_author_identifier_code_sequence_trial : int32
  (** (0040,A068) *)
  val identifier_code_sequence_trial : int32
  (** (0040,A070) *)
  val verifying_observer_sequence : int32
  (** (0040,A073) *)
  val object_binary_identifier_trial : int32
  (** (0040,A074) *)
  val verifying_observer_name : int32
  (** (0040,A075) *)
  val documenting_observer_identifier_code_sequence_trial : int32
  (** (0040,A076) *)
  val author_observer_sequence : int32
  (** (0040,A078) *)
  val participant_sequence : int32
  (** (0040,A07A) *)
  val custodial_organization_sequence : int32
  (** (0040,A07C) *)
  val participation_type : int32
  (** (0040,A080) *)
  val participation_date_time : int32
  (** (0040,A082) *)
  val observer_type : int32
  (** (0040,A084) *)
  val procedure_identifier_code_sequence_trial : int32
  (** (0040,A085) *)
  val verifying_observer_identification_code_sequence : int32
  (** (0040,A088) *)
  val object_directory_binary_identifier_trial : int32
  (** (0040,A089) *)
  val equivalent_cda_document_sequence : int32
  (** (0040,A090) *)
  val referenced_waveform_channels : int32
  (** (0040,A0B0) *)
  val date_of_document_or_verbal_transaction_trial : int32
  (** (0040,A110) *)
  val time_of_document_creation_or_verbal_transaction_trial : int32
  (** (0040,A112) *)
  val date_time : int32
  (** (0040,A120) *)
  val date : int32
  (** (0040,A121) *)
  val time : int32
  (** (0040,A122) *)
  val person_name : int32
  (** (0040,A123) *)
  val uid : int32
  (** (0040,A124) *)
  val report_status_id_trial : int32
  (** (0040,A125) *)
  val temporal_range_type : int32
  (** (0040,A130) *)
  val referenced_sample_positions : int32
  (** (0040,A132) *)
  val referenced_frame_numbers : int32
  (** (0040,A136) *)
  val referenced_time_offsets : int32
  (** (0040,A138) *)
  val referenced_date_time : int32
  (** (0040,A13A) *)
  val text_value : int32
  (** (0040,A160) *)
  val observation_category_code_sequence_trial : int32
  (** (0040,A167) *)
  val concept_code_sequence : int32
  (** (0040,A168) *)
  val bibliographic_citation_trial : int32
  (** (0040,A16A) *)
  val purpose_of_reference_code_sequence : int32
  (** (0040,A170) *)
  val observation_uid_trial : int32
  (** (0040,A171) *)
  val referenced_observation_uid_trial : int32
  (** (0040,A172) *)
  val referenced_observation_class_trial : int32
  (** (0040,A173) *)
  val referenced_object_observation_class_trial : int32
  (** (0040,A174) *)
  val annotation_group_number : int32
  (** (0040,A180) *)
  val observation_date_trial : int32
  (** (0040,A192) *)
  val observation_time_trial : int32
  (** (0040,A193) *)
  val measurement_automation_trial : int32
  (** (0040,A194) *)
  val modifier_code_sequence : int32
  (** (0040,A195) *)
  val identification_description_trial : int32
  (** (0040,A224) *)
  val coordinates_set_geometric_type_trial : int32
  (** (0040,A290) *)
  val algorithm_code_sequence_trial : int32
  (** (0040,A296) *)
  val algorithm_description_trial : int32
  (** (0040,A297) *)
  val pixel_coordinates_set_trial : int32
  (** (0040,A29A) *)
  val measured_value_sequence : int32
  (** (0040,A300) *)
  val numeric_value_qualifier_code_sequence : int32
  (** (0040,A301) *)
  val current_observer_trial : int32
  (** (0040,A307) *)
  val numeric_value : int32
  (** (0040,A30A) *)
  val referenced_accession_sequence_trial : int32
  (** (0040,A313) *)
  val report_status_comment_trial : int32
  (** (0040,A33A) *)
  val procedure_context_sequence_trial : int32
  (** (0040,A340) *)
  val verbal_source_trial : int32
  (** (0040,A352) *)
  val address_trial : int32
  (** (0040,A353) *)
  val telephone_number_trial : int32
  (** (0040,A354) *)
  val verbal_source_identifier_code_sequence_trial : int32
  (** (0040,A358) *)
  val predecessor_documents_sequence : int32
  (** (0040,A360) *)
  val referenced_request_sequence : int32
  (** (0040,A370) *)
  val performed_procedure_code_sequence : int32
  (** (0040,A372) *)
  val current_requested_procedure_evidence_sequence : int32
  (** (0040,A375) *)
  val report_detail_sequence_trial : int32
  (** (0040,A380) *)
  val pertinent_other_evidence_sequence : int32
  (** (0040,A385) *)
  val hl7_structured_document_reference_sequence : int32
  (** (0040,A390) *)
  val observation_subject_uid_trial : int32
  (** (0040,A402) *)
  val observation_subject_class_trial : int32
  (** (0040,A403) *)
  val observation_subject_type_code_sequence_trial : int32
  (** (0040,A404) *)
  val completion_flag : int32
  (** (0040,A491) *)
  val completion_flag_description : int32
  (** (0040,A492) *)
  val verification_flag : int32
  (** (0040,A493) *)
  val archive_requested : int32
  (** (0040,A494) *)
  val preliminary_flag : int32
  (** (0040,A496) *)
  val content_template_sequence : int32
  (** (0040,A504) *)
  val identical_documents_sequence : int32
  (** (0040,A525) *)
  val observation_subject_context_flag_trial : int32
  (** (0040,A600) *)
  val observer_context_flag_trial : int32
  (** (0040,A601) *)
  val procedure_context_flag_trial : int32
  (** (0040,A603) *)
  val content_sequence : int32
  (** (0040,A730) *)
  val relationship_sequence_trial : int32
  (** (0040,A731) *)
  val relationship_type_code_sequence_trial : int32
  (** (0040,A732) *)
  val language_code_sequence_trial : int32
  (** (0040,A744) *)
  val uniform_resource_locator_trial : int32
  (** (0040,A992) *)
  val waveform_annotation_sequence : int32
  (** (0040,B020) *)
  val template_identifier : int32
  (** (0040,DB00) *)
  val template_version : int32
  (** (0040,DB06) *)
  val template_local_version : int32
  (** (0040,DB07) *)
  val template_extension_flag : int32
  (** (0040,DB0B) *)
  val template_extension_organization_uid : int32
  (** (0040,DB0C) *)
  val template_extension_creator_uid : int32
  (** (0040,DB0D) *)
  val referenced_content_item_identifier : int32
  (** (0040,DB73) *)
  val hl7_instance_identifier : int32
  (** (0040,E001) *)
  val hl7_document_effective_time : int32
  (** (0040,E004) *)
  val hl7_document_type_code_sequence : int32
  (** (0040,E006) *)
  val document_class_code_sequence : int32
  (** (0040,E008) *)
  val retrieve_uri : int32
  (** (0040,E010) *)
  val retrieve_location_uid : int32
  (** (0040,E011) *)
  val type_of_instances : int32
  (** (0040,E020) *)
  val dicomretrievalsequence : int32
  (** (0040,E021) *)
  val dicommediaretrievalsequence : int32
  (** (0040,E022) *)
  val wado_retrieval_sequence : int32
  (** (0040,E023) *)
  val xds_retrieval_sequence : int32
  (** (0040,E024) *)
  val repository_unique_id : int32
  (** (0040,E030) *)
  val home_community_id : int32
  (** (0040,E031) *)
  val document_title : int32
  (** (0042,0010) *)
  val encapsulated_document : int32
  (** (0042,0011) *)
  val mime_type_of_encapsulated_document : int32
  (** (0042,0012) *)
  val source_instance_sequence : int32
  (** (0042,0013) *)
  val list_of_mime_types : int32
  (** (0042,0014) *)
  val product_package_identifier : int32
  (** (0044,0001) *)
  val substance_administration_approval : int32
  (** (0044,0002) *)
  val approval_status_further_description : int32
  (** (0044,0003) *)
  val approval_status_date_time : int32
  (** (0044,0004) *)
  val product_type_code_sequence : int32
  (** (0044,0007) *)
  val product_name : int32
  (** (0044,0008) *)
  val product_description : int32
  (** (0044,0009) *)
  val product_lot_identifier : int32
  (** (0044,000A) *)
  val product_expiration_date_time : int32
  (** (0044,000B) *)
  val substance_administration_date_time : int32
  (** (0044,0010) *)
  val substance_administration_notes : int32
  (** (0044,0011) *)
  val substance_administration_device_id : int32
  (** (0044,0012) *)
  val product_parameter_sequence : int32
  (** (0044,0013) *)
  val substance_administration_parameter_sequence : int32
  (** (0044,0019) *)
  val lens_description : int32
  (** (0046,0012) *)
  val right_lens_sequence : int32
  (** (0046,0014) *)
  val left_lens_sequence : int32
  (** (0046,0015) *)
  val unspecified_laterality_lens_sequence : int32
  (** (0046,0016) *)
  val cylinder_sequence : int32
  (** (0046,0018) *)
  val prism_sequence : int32
  (** (0046,0028) *)
  val horizontal_prism_power : int32
  (** (0046,0030) *)
  val horizontal_prism_base : int32
  (** (0046,0032) *)
  val vertical_prism_power : int32
  (** (0046,0034) *)
  val vertical_prism_base : int32
  (** (0046,0036) *)
  val lens_segment_type : int32
  (** (0046,0038) *)
  val optical_transmittance : int32
  (** (0046,0040) *)
  val channel_width : int32
  (** (0046,0042) *)
  val pupil_size : int32
  (** (0046,0044) *)
  val corneal_size : int32
  (** (0046,0046) *)
  val autorefraction_right_eye_sequence : int32
  (** (0046,0050) *)
  val autorefraction_left_eye_sequence : int32
  (** (0046,0052) *)
  val distance_pupillary_distance : int32
  (** (0046,0060) *)
  val near_pupillary_distance : int32
  (** (0046,0062) *)
  val intermediate_pupillary_distance : int32
  (** (0046,0063) *)
  val other_pupillary_distance : int32
  (** (0046,0064) *)
  val keratometry_right_eye_sequence : int32
  (** (0046,0070) *)
  val keratometry_left_eye_sequence : int32
  (** (0046,0071) *)
  val steep_keratometric_axis_sequence : int32
  (** (0046,0074) *)
  val radius_of_curvature : int32
  (** (0046,0075) *)
  val keratometric_power : int32
  (** (0046,0076) *)
  val keratometric_axis : int32
  (** (0046,0077) *)
  val flat_keratometric_axis_sequence : int32
  (** (0046,0080) *)
  val background_color : int32
  (** (0046,0092) *)
  val optotype : int32
  (** (0046,0094) *)
  val optotype_presentation : int32
  (** (0046,0095) *)
  val subjective_refraction_right_eye_sequence : int32
  (** (0046,0097) *)
  val subjective_refraction_left_eye_sequence : int32
  (** (0046,0098) *)
  val add_near_sequence : int32
  (** (0046,0100) *)
  val add_intermediate_sequence : int32
  (** (0046,0101) *)
  val add_other_sequence : int32
  (** (0046,0102) *)
  val add_power : int32
  (** (0046,0104) *)
  val viewing_distance : int32
  (** (0046,0106) *)
  val visual_acuity_type_code_sequence : int32
  (** (0046,0121) *)
  val visual_acuity_right_eye_sequence : int32
  (** (0046,0122) *)
  val visual_acuity_left_eye_sequence : int32
  (** (0046,0123) *)
  val visual_acuity_both_eyes_open_sequence : int32
  (** (0046,0124) *)
  val viewing_distance_type : int32
  (** (0046,0125) *)
  val visual_acuity_modifiers : int32
  (** (0046,0135) *)
  val decimal_visual_acuity : int32
  (** (0046,0137) *)
  val optotype_detailed_definition : int32
  (** (0046,0139) *)
  val referenced_refractive_measurements_sequence : int32
  (** (0046,0145) *)
  val sphere_power : int32
  (** (0046,0146) *)
  val cylinder_power : int32
  (** (0046,0147) *)
  val imaged_volume_width : int32
  (** (0048,0001) *)
  val imaged_volume_height : int32
  (** (0048,0002) *)
  val imaged_volume_depth : int32
  (** (0048,0003) *)
  val total_pixel_matrix_columns : int32
  (** (0048,0006) *)
  val total_pixel_matrix_rows : int32
  (** (0048,0007) *)
  val total_pixel_matrix_origin_sequence : int32
  (** (0048,0008) *)
  val specimen_label_in_image : int32
  (** (0048,0010) *)
  val focus_method : int32
  (** (0048,0011) *)
  val extended_depth_of_field : int32
  (** (0048,0012) *)
  val number_of_focal_planes : int32
  (** (0048,0013) *)
  val distance_between_focal_planes : int32
  (** (0048,0014) *)
  val recommended_absent_pixel_cielab_value : int32
  (** (0048,0015) *)
  val illuminator_type_code_sequence : int32
  (** (0048,0100) *)
  val image_orientation_slide : int32
  (** (0048,0102) *)
  val optical_path_sequence : int32
  (** (0048,0105) *)
  val optical_path_identifier : int32
  (** (0048,0106) *)
  val optical_path_description : int32
  (** (0048,0107) *)
  val illumination_color_code_sequence : int32
  (** (0048,0108) *)
  val specimen_reference_sequence : int32
  (** (0048,0110) *)
  val condenser_lens_power : int32
  (** (0048,0111) *)
  val objective_lens_power : int32
  (** (0048,0112) *)
  val objective_lens_numerical_aperture : int32
  (** (0048,0113) *)
  val palette_color_lookup_table_sequence : int32
  (** (0048,0120) *)
  val referenced_image_navigation_sequence : int32
  (** (0048,0200) *)
  val top_left_hand_corner_of_localizer_area : int32
  (** (0048,0201) *)
  val bottom_right_hand_corner_of_localizer_area : int32
  (** (0048,0202) *)
  val optical_path_identification_sequence : int32
  (** (0048,0207) *)
  val plane_position_slide_sequence : int32
  (** (0048,021A) *)
  val row_position_in_total_image_pixel_matrix : int32
  (** (0048,021E) *)
  val column_position_in_total_image_pixel_matrix : int32
  (** (0048,021F) *)
  val pixel_origin_interpretation : int32
  (** (0048,0301) *)
  val calibration_image : int32
  (** (0050,0004) *)
  val device_sequence : int32
  (** (0050,0010) *)
  val container_component_type_code_sequence : int32
  (** (0050,0012) *)
  val container_component_thickness : int32
  (** (0050,0013) *)
  val device_length : int32
  (** (0050,0014) *)
  val container_component_width : int32
  (** (0050,0015) *)
  val device_diameter : int32
  (** (0050,0016) *)
  val device_diameter_units : int32
  (** (0050,0017) *)
  val device_volume : int32
  (** (0050,0018) *)
  val inter_marker_distance : int32
  (** (0050,0019) *)
  val container_component_material : int32
  (** (0050,001A) *)
  val container_component_id : int32
  (** (0050,001B) *)
  val container_component_length : int32
  (** (0050,001C) *)
  val container_component_diameter : int32
  (** (0050,001D) *)
  val container_component_description : int32
  (** (0050,001E) *)
  val device_description : int32
  (** (0050,0020) *)
  val contrast_bolus_ingredient_percent_by_volume : int32
  (** (0052,0001) *)
  val oct_focal_distance : int32
  (** (0052,0002) *)
  val beam_spot_size : int32
  (** (0052,0003) *)
  val effective_refractive_index : int32
  (** (0052,0004) *)
  val oct_acquisition_domain : int32
  (** (0052,0006) *)
  val oct_optical_center_wavelength : int32
  (** (0052,0007) *)
  val axial_resolution : int32
  (** (0052,0008) *)
  val ranging_depth : int32
  (** (0052,0009) *)
  val a_line_rate : int32
  (** (0052,0011) *)
  val a_lines_per_frame : int32
  (** (0052,0012) *)
  val catheter_rotational_rate : int32
  (** (0052,0013) *)
  val a_line_pixel_spacing : int32
  (** (0052,0014) *)
  val mode_of_percutaneous_access_sequence : int32
  (** (0052,0016) *)
  val intravascular_oct_frame_type_sequence : int32
  (** (0052,0025) *)
  val oct_zoffset_applied : int32
  (** (0052,0026) *)
  val intravascular_frame_content_sequence : int32
  (** (0052,0027) *)
  val intravascular_longitudinal_distance : int32
  (** (0052,0028) *)
  val intravascular_oct_frame_content_sequence : int32
  (** (0052,0029) *)
  val oct_zoffset_correction : int32
  (** (0052,0030) *)
  val catheter_direction_of_rotation : int32
  (** (0052,0031) *)
  val seam_line_location : int32
  (** (0052,0033) *)
  val first_aline_location : int32
  (** (0052,0034) *)
  val seam_line_index : int32
  (** (0052,0036) *)
  val number_of_padded_alines : int32
  (** (0052,0038) *)
  val interpolation_type : int32
  (** (0052,0039) *)
  val refractive_index_applied : int32
  (** (0052,003A) *)
  val energy_window_vector : int32
  (** (0054,0010) *)
  val number_of_energy_windows : int32
  (** (0054,0011) *)
  val energy_window_information_sequence : int32
  (** (0054,0012) *)
  val energy_window_range_sequence : int32
  (** (0054,0013) *)
  val energy_window_lower_limit : int32
  (** (0054,0014) *)
  val energy_window_upper_limit : int32
  (** (0054,0015) *)
  val radiopharmaceutical_information_sequence : int32
  (** (0054,0016) *)
  val residual_syringe_counts : int32
  (** (0054,0017) *)
  val energy_window_name : int32
  (** (0054,0018) *)
  val detector_vector : int32
  (** (0054,0020) *)
  val number_of_detectors : int32
  (** (0054,0021) *)
  val detector_information_sequence : int32
  (** (0054,0022) *)
  val phase_vector : int32
  (** (0054,0030) *)
  val number_of_phases : int32
  (** (0054,0031) *)
  val phase_information_sequence : int32
  (** (0054,0032) *)
  val number_of_frames_in_phase : int32
  (** (0054,0033) *)
  val phase_delay : int32
  (** (0054,0036) *)
  val pause_between_frames : int32
  (** (0054,0038) *)
  val phase_description : int32
  (** (0054,0039) *)
  val rotation_vector : int32
  (** (0054,0050) *)
  val number_of_rotations : int32
  (** (0054,0051) *)
  val rotation_information_sequence : int32
  (** (0054,0052) *)
  val number_of_frames_in_rotation : int32
  (** (0054,0053) *)
  val r_rinterval_vector : int32
  (** (0054,0060) *)
  val number_of_rrintervals : int32
  (** (0054,0061) *)
  val gated_information_sequence : int32
  (** (0054,0062) *)
  val data_information_sequence : int32
  (** (0054,0063) *)
  val time_slot_vector : int32
  (** (0054,0070) *)
  val number_of_time_slots : int32
  (** (0054,0071) *)
  val time_slot_information_sequence : int32
  (** (0054,0072) *)
  val time_slot_time : int32
  (** (0054,0073) *)
  val slice_vector : int32
  (** (0054,0080) *)
  val number_of_slices : int32
  (** (0054,0081) *)
  val angular_view_vector : int32
  (** (0054,0090) *)
  val time_slice_vector : int32
  (** (0054,0100) *)
  val number_of_time_slices : int32
  (** (0054,0101) *)
  val start_angle : int32
  (** (0054,0200) *)
  val type_of_detector_motion : int32
  (** (0054,0202) *)
  val trigger_vector : int32
  (** (0054,0210) *)
  val number_of_triggers_in_phase : int32
  (** (0054,0211) *)
  val view_code_sequence : int32
  (** (0054,0220) *)
  val view_modifier_code_sequence : int32
  (** (0054,0222) *)
  val radionuclide_code_sequence : int32
  (** (0054,0300) *)
  val administration_route_code_sequence : int32
  (** (0054,0302) *)
  val radiopharmaceutical_code_sequence : int32
  (** (0054,0304) *)
  val calibration_data_sequence : int32
  (** (0054,0306) *)
  val energy_window_number : int32
  (** (0054,0308) *)
  val image_id : int32
  (** (0054,0400) *)
  val patient_orientation_code_sequence : int32
  (** (0054,0410) *)
  val patient_orientation_modifier_code_sequence : int32
  (** (0054,0412) *)
  val patient_gantry_relationship_code_sequence : int32
  (** (0054,0414) *)
  val slice_progression_direction : int32
  (** (0054,0500) *)
  val series_type : int32
  (** (0054,1000) *)
  val units : int32
  (** (0054,1001) *)
  val counts_source : int32
  (** (0054,1002) *)
  val reprojection_method : int32
  (** (0054,1004) *)
  val suv_type : int32
  (** (0054,1006) *)
  val randoms_correction_method : int32
  (** (0054,1100) *)
  val attenuation_correction_method : int32
  (** (0054,1101) *)
  val decay_correction : int32
  (** (0054,1102) *)
  val reconstruction_method : int32
  (** (0054,1103) *)
  val detector_lines_of_response_used : int32
  (** (0054,1104) *)
  val scatter_correction_method : int32
  (** (0054,1105) *)
  val axial_acceptance : int32
  (** (0054,1200) *)
  val axial_mash : int32
  (** (0054,1201) *)
  val transverse_mash : int32
  (** (0054,1202) *)
  val detector_element_size : int32
  (** (0054,1203) *)
  val coincidence_window_width : int32
  (** (0054,1210) *)
  val secondary_counts_type : int32
  (** (0054,1220) *)
  val frame_reference_time : int32
  (** (0054,1300) *)
  val primary_prompts_counts_accumulated : int32
  (** (0054,1310) *)
  val secondary_counts_accumulated : int32
  (** (0054,1311) *)
  val slice_sensitivity_factor : int32
  (** (0054,1320) *)
  val decay_factor : int32
  (** (0054,1321) *)
  val dose_calibration_factor : int32
  (** (0054,1322) *)
  val scatter_fraction_factor : int32
  (** (0054,1323) *)
  val dead_time_factor : int32
  (** (0054,1324) *)
  val image_index : int32
  (** (0054,1330) *)
  val counts_included : int32
  (** (0054,1400) *)
  val dead_time_correction_flag : int32
  (** (0054,1401) *)
  val histogram_sequence : int32
  (** (0060,3000) *)
  val histogram_number_of_bins : int32
  (** (0060,3002) *)
  val histogram_first_bin_value : int32
  (** (0060,3004) *)
  val histogram_last_bin_value : int32
  (** (0060,3006) *)
  val histogram_bin_width : int32
  (** (0060,3008) *)
  val histogram_explanation : int32
  (** (0060,3010) *)
  val histogram_data : int32
  (** (0060,3020) *)
  val segmentation_type : int32
  (** (0062,0001) *)
  val segment_sequence : int32
  (** (0062,0002) *)
  val segmented_property_category_code_sequence : int32
  (** (0062,0003) *)
  val segment_number : int32
  (** (0062,0004) *)
  val segment_label : int32
  (** (0062,0005) *)
  val segment_description : int32
  (** (0062,0006) *)
  val segment_algorithm_type : int32
  (** (0062,0008) *)
  val segment_algorithm_name : int32
  (** (0062,0009) *)
  val segment_identification_sequence : int32
  (** (0062,000A) *)
  val referenced_segment_number : int32
  (** (0062,000B) *)
  val recommended_display_grayscale_value : int32
  (** (0062,000C) *)
  val recommended_display_cie_lab_value : int32
  (** (0062,000D) *)
  val maximum_fractional_value : int32
  (** (0062,000E) *)
  val segmented_property_type_code_sequence : int32
  (** (0062,000F) *)
  val segmentation_fractional_type : int32
  (** (0062,0010) *)
  val deformable_registration_sequence : int32
  (** (0064,0002) *)
  val source_frame_of_reference_uid : int32
  (** (0064,0003) *)
  val deformable_registration_grid_sequence : int32
  (** (0064,0005) *)
  val grid_dimensions : int32
  (** (0064,0007) *)
  val grid_resolution : int32
  (** (0064,0008) *)
  val vector_grid_data : int32
  (** (0064,0009) *)
  val pre_deformation_matrix_registration_sequence : int32
  (** (0064,000F) *)
  val post_deformation_matrix_registration_sequence : int32
  (** (0064,0010) *)
  val number_of_surfaces : int32
  (** (0066,0001) *)
  val surface_sequence : int32
  (** (0066,0002) *)
  val surface_number : int32
  (** (0066,0003) *)
  val surface_comments : int32
  (** (0066,0004) *)
  val surface_processing : int32
  (** (0066,0009) *)
  val surface_processing_ratio : int32
  (** (0066,000A) *)
  val surface_processing_description : int32
  (** (0066,000B) *)
  val recommended_presentation_opacity : int32
  (** (0066,000C) *)
  val recommended_presentation_type : int32
  (** (0066,000D) *)
  val finite_volume : int32
  (** (0066,000E) *)
  val manifold : int32
  (** (0066,0010) *)
  val surface_points_sequence : int32
  (** (0066,0011) *)
  val surface_points_normals_sequence : int32
  (** (0066,0012) *)
  val surface_mesh_primitives_sequence : int32
  (** (0066,0013) *)
  val number_of_surface_points : int32
  (** (0066,0015) *)
  val point_coordinates_data : int32
  (** (0066,0016) *)
  val point_position_accuracy : int32
  (** (0066,0017) *)
  val mean_point_distance : int32
  (** (0066,0018) *)
  val maximum_point_distance : int32
  (** (0066,0019) *)
  val points_bounding_box_coordinates : int32
  (** (0066,001A) *)
  val axis_of_rotation : int32
  (** (0066,001B) *)
  val center_of_rotation : int32
  (** (0066,001C) *)
  val number_of_vectors : int32
  (** (0066,001E) *)
  val vector_dimensionality : int32
  (** (0066,001F) *)
  val vector_accuracy : int32
  (** (0066,0020) *)
  val vector_coordinate_data : int32
  (** (0066,0021) *)
  val triangle_point_index_list : int32
  (** (0066,0023) *)
  val edge_point_index_list : int32
  (** (0066,0024) *)
  val vertex_point_index_list : int32
  (** (0066,0025) *)
  val triangle_strip_sequence : int32
  (** (0066,0026) *)
  val triangle_fan_sequence : int32
  (** (0066,0027) *)
  val line_sequence : int32
  (** (0066,0028) *)
  val primitive_point_index_list : int32
  (** (0066,0029) *)
  val surface_count : int32
  (** (0066,002A) *)
  val referenced_surface_sequence : int32
  (** (0066,002B) *)
  val referenced_surface_number : int32
  (** (0066,002C) *)
  val segment_surface_generation_algorithm_identification_sequence : int32
  (** (0066,002D) *)
  val segment_surface_source_instance_sequence : int32
  (** (0066,002E) *)
  val algorithm_family_code_sequence : int32
  (** (0066,002F) *)
  val algorithm_name_code_sequence : int32
  (** (0066,0030) *)
  val algorithm_version : int32
  (** (0066,0031) *)
  val algorithm_parameters : int32
  (** (0066,0032) *)
  val facet_sequence : int32
  (** (0066,0034) *)
  val surface_processing_algorithm_identification_sequence : int32
  (** (0066,0035) *)
  val algorithm_name : int32
  (** (0066,0036) *)
  val implant_size : int32
  (** (0068,6210) *)
  val implant_template_version : int32
  (** (0068,6221) *)
  val replaced_implant_template_sequence : int32
  (** (0068,6222) *)
  val implant_type : int32
  (** (0068,6223) *)
  val derivation_implant_template_sequence : int32
  (** (0068,6224) *)
  val original_implant_template_sequence : int32
  (** (0068,6225) *)
  val effective_date_time : int32
  (** (0068,6226) *)
  val implant_target_anatomy_sequence : int32
  (** (0068,6230) *)
  val information_from_manufacturer_sequence : int32
  (** (0068,6260) *)
  val notification_from_manufacturer_sequence : int32
  (** (0068,6265) *)
  val information_issue_date_time : int32
  (** (0068,6270) *)
  val information_summary : int32
  (** (0068,6280) *)
  val implant_regulatory_disapproval_code_sequence : int32
  (** (0068,62A0) *)
  val overall_template_spatial_tolerance : int32
  (** (0068,62A5) *)
  val hpgldocumentsequence : int32
  (** (0068,62C0) *)
  val hpgldocument_id : int32
  (** (0068,62D0) *)
  val hpgldocumentlabel : int32
  (** (0068,62D5) *)
  val view_orientation_code_sequence : int32
  (** (0068,62E0) *)
  val view_orientation_modifier : int32
  (** (0068,62F0) *)
  val hpgl_document_scaling : int32
  (** (0068,62F2) *)
  val hpgl_document : int32
  (** (0068,6300) *)
  val hpgl_contour_pen_number : int32
  (** (0068,6310) *)
  val hpgl_pen_sequence : int32
  (** (0068,6320) *)
  val hpgl_pen_number : int32
  (** (0068,6330) *)
  val hpgl_pen_label : int32
  (** (0068,6340) *)
  val hpgl_pen_description : int32
  (** (0068,6345) *)
  val recommended_rotation_point : int32
  (** (0068,6346) *)
  val bounding_rectangle : int32
  (** (0068,6347) *)
  val implant_template3_dmodel_surface_number : int32
  (** (0068,6350) *)
  val surface_model_description_sequence : int32
  (** (0068,6360) *)
  val surface_model_label : int32
  (** (0068,6380) *)
  val surface_model_scaling_factor : int32
  (** (0068,6390) *)
  val materials_code_sequence : int32
  (** (0068,63A0) *)
  val coating_materials_code_sequence : int32
  (** (0068,63A4) *)
  val implant_type_code_sequence : int32
  (** (0068,63A8) *)
  val fixation_method_code_sequence : int32
  (** (0068,63AC) *)
  val mating_feature_sets_sequence : int32
  (** (0068,63B0) *)
  val mating_feature_set_id : int32
  (** (0068,63C0) *)
  val mating_feature_set_label : int32
  (** (0068,63D0) *)
  val mating_feature_sequence : int32
  (** (0068,63E0) *)
  val mating_feature_id : int32
  (** (0068,63F0) *)
  val mating_feature_degree_of_freedom_sequence : int32
  (** (0068,6400) *)
  val degree_of_freedom_id : int32
  (** (0068,6410) *)
  val degree_of_freedom_type : int32
  (** (0068,6420) *)
  val two_dmating_feature_coordinates_sequence : int32
  (** (0068,6430) *)
  val referenced_hpgl_document_id : int32
  (** (0068,6440) *)
  val two_d_mating_point : int32
  (** (0068,6450) *)
  val two_d_mating_axes : int32
  (** (0068,6460) *)
  val two_d_degree_of_freedom_sequence : int32
  (** (0068,6470) *)
  val three_d_degree_of_freedom_axis : int32
  (** (0068,6490) *)
  val range_of_freedom : int32
  (** (0068,64A0) *)
  val three_d_mating_point : int32
  (** (0068,64C0) *)
  val three_d_mating_axes : int32
  (** (0068,64D0) *)
  val two_d_degree_of_freedom_axis : int32
  (** (0068,64F0) *)
  val planning_landmark_point_sequence : int32
  (** (0068,6500) *)
  val planning_landmark_line_sequence : int32
  (** (0068,6510) *)
  val planning_landmark_plane_sequence : int32
  (** (0068,6520) *)
  val planning_landmark_id : int32
  (** (0068,6530) *)
  val planning_landmark_description : int32
  (** (0068,6540) *)
  val planning_landmark_identification_code_sequence : int32
  (** (0068,6545) *)
  val two_d_point_coordinates_sequence : int32
  (** (0068,6550) *)
  val two_d_point_coordinates : int32
  (** (0068,6560) *)
  val three_d_point_coordinates : int32
  (** (0068,6590) *)
  val two_d_line_coordinates_sequence : int32
  (** (0068,65A0) *)
  val two_d_line_coordinates : int32
  (** (0068,65B0) *)
  val three_d_line_coordinates : int32
  (** (0068,65D0) *)
  val two_d_plane_coordinates_sequence : int32
  (** (0068,65E0) *)
  val two_d_plane_intersection : int32
  (** (0068,65F0) *)
  val three_d_plane_origin : int32
  (** (0068,6610) *)
  val three_d_plane_normal : int32
  (** (0068,6620) *)
  val graphic_annotation_sequence : int32
  (** (0070,0001) *)
  val graphic_layer : int32
  (** (0070,0002) *)
  val bounding_box_annotation_units : int32
  (** (0070,0003) *)
  val anchor_point_annotation_units : int32
  (** (0070,0004) *)
  val graphic_annotation_units : int32
  (** (0070,0005) *)
  val unformatted_text_value : int32
  (** (0070,0006) *)
  val text_object_sequence : int32
  (** (0070,0008) *)
  val graphic_object_sequence : int32
  (** (0070,0009) *)
  val bounding_box_top_left_hand_corner : int32
  (** (0070,0010) *)
  val bounding_box_bottom_right_hand_corner : int32
  (** (0070,0011) *)
  val bounding_box_text_horizontal_justification : int32
  (** (0070,0012) *)
  val anchor_point : int32
  (** (0070,0014) *)
  val anchor_point_visibility : int32
  (** (0070,0015) *)
  val graphic_dimensions : int32
  (** (0070,0020) *)
  val number_of_graphic_points : int32
  (** (0070,0021) *)
  val graphic_data : int32
  (** (0070,0022) *)
  val graphic_type : int32
  (** (0070,0023) *)
  val graphic_filled : int32
  (** (0070,0024) *)
  val image_rotation_retired : int32
  (** (0070,0040) *)
  val image_horizontal_flip : int32
  (** (0070,0041) *)
  val image_rotation : int32
  (** (0070,0042) *)
  val displayed_area_top_left_hand_corner_trial : int32
  (** (0070,0050) *)
  val displayed_area_bottom_right_hand_corner_trial : int32
  (** (0070,0051) *)
  val displayed_area_top_left_hand_corner : int32
  (** (0070,0052) *)
  val displayed_area_bottom_right_hand_corner : int32
  (** (0070,0053) *)
  val displayed_area_selection_sequence : int32
  (** (0070,005A) *)
  val graphic_layer_sequence : int32
  (** (0070,0060) *)
  val graphic_layer_order : int32
  (** (0070,0062) *)
  val graphic_layer_recommended_display_grayscale_value : int32
  (** (0070,0066) *)
  val graphic_layer_recommended_display_rgbvalue : int32
  (** (0070,0067) *)
  val graphic_layer_description : int32
  (** (0070,0068) *)
  val content_label : int32
  (** (0070,0080) *)
  val content_description : int32
  (** (0070,0081) *)
  val presentation_creation_date : int32
  (** (0070,0082) *)
  val presentation_creation_time : int32
  (** (0070,0083) *)
  val content_creator_name : int32
  (** (0070,0084) *)
  val content_creator_identification_code_sequence : int32
  (** (0070,0086) *)
  val alternate_content_description_sequence : int32
  (** (0070,0087) *)
  val presentation_size_mode : int32
  (** (0070,0100) *)
  val presentation_pixel_spacing : int32
  (** (0070,0101) *)
  val presentation_pixel_aspect_ratio : int32
  (** (0070,0102) *)
  val presentation_pixel_magnification_ratio : int32
  (** (0070,0103) *)
  val graphic_group_label : int32
  (** (0070,0207) *)
  val graphic_group_description : int32
  (** (0070,0208) *)
  val compound_graphic_sequence : int32
  (** (0070,0209) *)
  val compound_graphic_instance_id : int32
  (** (0070,0226) *)
  val font_name : int32
  (** (0070,0227) *)
  val font_name_type : int32
  (** (0070,0228) *)
  val css_font_name : int32
  (** (0070,0229) *)
  val rotation_angle : int32
  (** (0070,0230) *)
  val text_style_sequence : int32
  (** (0070,0231) *)
  val line_style_sequence : int32
  (** (0070,0232) *)
  val fill_style_sequence : int32
  (** (0070,0233) *)
  val graphic_group_sequence : int32
  (** (0070,0234) *)
  val text_color_cie_lab_value : int32
  (** (0070,0241) *)
  val horizontal_alignment : int32
  (** (0070,0242) *)
  val vertical_alignment : int32
  (** (0070,0243) *)
  val shadow_style : int32
  (** (0070,0244) *)
  val shadow_offset_x : int32
  (** (0070,0245) *)
  val shadow_offset_y : int32
  (** (0070,0246) *)
  val shadow_color_cie_lab_value : int32
  (** (0070,0247) *)
  val underlined : int32
  (** (0070,0248) *)
  val bold : int32
  (** (0070,0249) *)
  val italic : int32
  (** (0070,0250) *)
  val pattern_on_color_cie_lab_value : int32
  (** (0070,0251) *)
  val pattern_off_color_cie_lab_value : int32
  (** (0070,0252) *)
  val line_thickness : int32
  (** (0070,0253) *)
  val line_dashing_style : int32
  (** (0070,0254) *)
  val line_pattern : int32
  (** (0070,0255) *)
  val fill_pattern : int32
  (** (0070,0256) *)
  val fill_mode : int32
  (** (0070,0257) *)
  val shadow_opacity : int32
  (** (0070,0258) *)
  val gap_length : int32
  (** (0070,0261) *)
  val diameter_of_visibility : int32
  (** (0070,0262) *)
  val rotation_point : int32
  (** (0070,0273) *)
  val tick_alignment : int32
  (** (0070,0274) *)
  val show_tick_label : int32
  (** (0070,0278) *)
  val tick_label_alignment : int32
  (** (0070,0279) *)
  val compound_graphic_units : int32
  (** (0070,0282) *)
  val pattern_on_opacity : int32
  (** (0070,0284) *)
  val pattern_off_opacity : int32
  (** (0070,0285) *)
  val major_ticks_sequence : int32
  (** (0070,0287) *)
  val tick_position : int32
  (** (0070,0288) *)
  val tick_label : int32
  (** (0070,0289) *)
  val compound_graphic_type : int32
  (** (0070,0294) *)
  val graphic_group_id : int32
  (** (0070,0295) *)
  val shape_type : int32
  (** (0070,0306) *)
  val registration_sequence : int32
  (** (0070,0308) *)
  val matrix_registration_sequence : int32
  (** (0070,0309) *)
  val matrix_sequence : int32
  (** (0070,030A) *)
  val frame_of_reference_transformation_matrix_type : int32
  (** (0070,030C) *)
  val registration_type_code_sequence : int32
  (** (0070,030D) *)
  val fiducial_description : int32
  (** (0070,030F) *)
  val fiducial_identifier : int32
  (** (0070,0310) *)
  val fiducial_identifier_code_sequence : int32
  (** (0070,0311) *)
  val contour_uncertainty_radius : int32
  (** (0070,0312) *)
  val used_fiducials_sequence : int32
  (** (0070,0314) *)
  val graphic_coordinates_data_sequence : int32
  (** (0070,0318) *)
  val fiducial_uid : int32
  (** (0070,031A) *)
  val fiducial_set_sequence : int32
  (** (0070,031C) *)
  val fiducial_sequence : int32
  (** (0070,031E) *)
  val graphic_layer_recommended_display_cielab_value : int32
  (** (0070,0401) *)
  val blending_sequence : int32
  (** (0070,0402) *)
  val relative_opacity : int32
  (** (0070,0403) *)
  val referenced_spatial_registration_sequence : int32
  (** (0070,0404) *)
  val blending_position : int32
  (** (0070,0405) *)
  val hanging_protocol_name : int32
  (** (0072,0002) *)
  val hanging_protocol_description : int32
  (** (0072,0004) *)
  val hanging_protocol_level : int32
  (** (0072,0006) *)
  val hanging_protocol_creator : int32
  (** (0072,0008) *)
  val hanging_protocol_creation_date_time : int32
  (** (0072,000A) *)
  val hanging_protocol_definition_sequence : int32
  (** (0072,000C) *)
  val hanging_protocol_user_identification_code_sequence : int32
  (** (0072,000E) *)
  val hanging_protocol_user_group_name : int32
  (** (0072,0010) *)
  val source_hanging_protocol_sequence : int32
  (** (0072,0012) *)
  val number_of_priors_referenced : int32
  (** (0072,0014) *)
  val image_sets_sequence : int32
  (** (0072,0020) *)
  val image_set_selector_sequence : int32
  (** (0072,0022) *)
  val image_set_selector_usage_flag : int32
  (** (0072,0024) *)
  val selector_attribute : int32
  (** (0072,0026) *)
  val selector_value_number : int32
  (** (0072,0028) *)
  val time_based_image_sets_sequence : int32
  (** (0072,0030) *)
  val image_set_number : int32
  (** (0072,0032) *)
  val image_set_selector_category : int32
  (** (0072,0034) *)
  val relative_time : int32
  (** (0072,0038) *)
  val relative_time_units : int32
  (** (0072,003A) *)
  val abstract_prior_value : int32
  (** (0072,003C) *)
  val abstract_prior_code_sequence : int32
  (** (0072,003E) *)
  val image_set_label : int32
  (** (0072,0040) *)
  val selector_attribute_vr : int32
  (** (0072,0050) *)
  val selector_sequence_pointer : int32
  (** (0072,0052) *)
  val selector_sequence_pointer_private_creator : int32
  (** (0072,0054) *)
  val selector_attribute_private_creator : int32
  (** (0072,0056) *)
  val selector_at_value : int32
  (** (0072,0060) *)
  val selector_cs_value : int32
  (** (0072,0062) *)
  val selector_is_value : int32
  (** (0072,0064) *)
  val selector_lo_value : int32
  (** (0072,0066) *)
  val selector_lt_value : int32
  (** (0072,0068) *)
  val selector_pn_value : int32
  (** (0072,006A) *)
  val selector_sh_value : int32
  (** (0072,006C) *)
  val selector_st_value : int32
  (** (0072,006E) *)
  val selector_ut_value : int32
  (** (0072,0070) *)
  val selector_ds_value : int32
  (** (0072,0072) *)
  val selector_fd_value : int32
  (** (0072,0074) *)
  val selector_fl_value : int32
  (** (0072,0076) *)
  val selector_ul_value : int32
  (** (0072,0078) *)
  val selector_us_value : int32
  (** (0072,007A) *)
  val selector_sl_value : int32
  (** (0072,007C) *)
  val selector_ss_value : int32
  (** (0072,007E) *)
  val selector_code_sequence_value : int32
  (** (0072,0080) *)
  val number_of_screens : int32
  (** (0072,0100) *)
  val nominal_screen_definition_sequence : int32
  (** (0072,0102) *)
  val number_of_vertical_pixels : int32
  (** (0072,0104) *)
  val number_of_horizontal_pixels : int32
  (** (0072,0106) *)
  val display_environment_spatial_position : int32
  (** (0072,0108) *)
  val screen_minimum_grayscale_bit_depth : int32
  (** (0072,010A) *)
  val screen_minimum_color_bit_depth : int32
  (** (0072,010C) *)
  val application_maximum_repaint_time : int32
  (** (0072,010E) *)
  val display_sets_sequence : int32
  (** (0072,0200) *)
  val display_set_number : int32
  (** (0072,0202) *)
  val display_set_label : int32
  (** (0072,0203) *)
  val display_set_presentation_group : int32
  (** (0072,0204) *)
  val display_set_presentation_group_description : int32
  (** (0072,0206) *)
  val partial_data_display_handling : int32
  (** (0072,0208) *)
  val synchronized_scrolling_sequence : int32
  (** (0072,0210) *)
  val display_set_scrolling_group : int32
  (** (0072,0212) *)
  val navigation_indicator_sequence : int32
  (** (0072,0214) *)
  val navigation_display_set : int32
  (** (0072,0216) *)
  val reference_display_sets : int32
  (** (0072,0218) *)
  val image_boxes_sequence : int32
  (** (0072,0300) *)
  val image_box_number : int32
  (** (0072,0302) *)
  val image_box_layout_type : int32
  (** (0072,0304) *)
  val image_box_tile_horizontal_dimension : int32
  (** (0072,0306) *)
  val image_box_tile_vertical_dimension : int32
  (** (0072,0308) *)
  val image_box_scroll_direction : int32
  (** (0072,0310) *)
  val image_box_small_scroll_type : int32
  (** (0072,0312) *)
  val image_box_small_scroll_amount : int32
  (** (0072,0314) *)
  val image_box_large_scroll_type : int32
  (** (0072,0316) *)
  val image_box_large_scroll_amount : int32
  (** (0072,0318) *)
  val image_box_overlap_priority : int32
  (** (0072,0320) *)
  val cine_relative_to_real_time : int32
  (** (0072,0330) *)
  val filter_operations_sequence : int32
  (** (0072,0400) *)
  val filter_by_category : int32
  (** (0072,0402) *)
  val filter_by_attribute_presence : int32
  (** (0072,0404) *)
  val filter_by_operator : int32
  (** (0072,0406) *)
  val structured_display_background_cielab_value : int32
  (** (0072,0420) *)
  val empty_image_box_cie_lab_value : int32
  (** (0072,0421) *)
  val structured_display_image_box_sequence : int32
  (** (0072,0422) *)
  val structured_display_text_box_sequence : int32
  (** (0072,0424) *)
  val referenced_first_frame_sequence : int32
  (** (0072,0427) *)
  val image_box_synchronization_sequence : int32
  (** (0072,0430) *)
  val synchronized_image_box_list : int32
  (** (0072,0432) *)
  val type_of_synchronization : int32
  (** (0072,0434) *)
  val blending_operation_type : int32
  (** (0072,0500) *)
  val reformatting_operation_type : int32
  (** (0072,0510) *)
  val reformatting_thickness : int32
  (** (0072,0512) *)
  val reformatting_interval : int32
  (** (0072,0514) *)
  val reformatting_operation_initial_view_direction : int32
  (** (0072,0516) *)
  val three_drendering_type : int32
  (** (0072,0520) *)
  val sorting_operations_sequence : int32
  (** (0072,0600) *)
  val sort_by_category : int32
  (** (0072,0602) *)
  val sorting_direction : int32
  (** (0072,0604) *)
  val display_set_patient_orientation : int32
  (** (0072,0700) *)
  val voi_type : int32
  (** (0072,0702) *)
  val pseudo_color_type : int32
  (** (0072,0704) *)
  val pseudo_color_palette_instance_reference_sequence : int32
  (** (0072,0705) *)
  val show_grayscale_inverted : int32
  (** (0072,0706) *)
  val show_image_true_size_flag : int32
  (** (0072,0710) *)
  val show_graphic_annotation_flag : int32
  (** (0072,0712) *)
  val show_patient_demographics_flag : int32
  (** (0072,0714) *)
  val show_acquisition_techniques_flag : int32
  (** (0072,0716) *)
  val display_set_horizontal_justification : int32
  (** (0072,0717) *)
  val display_set_vertical_justification : int32
  (** (0072,0718) *)
  val continuation_start_meterset : int32
  (** (0074,0120) *)
  val continuation_end_meterset : int32
  (** (0074,0121) *)
  val procedure_step_state : int32
  (** (0074,1000) *)
  val procedure_step_progress_information_sequence : int32
  (** (0074,1002) *)
  val procedure_step_progress : int32
  (** (0074,1004) *)
  val procedure_step_progress_description : int32
  (** (0074,1006) *)
  val procedure_step_communications_urisequence : int32
  (** (0074,1008) *)
  val contact_uri : int32
  (** (0074,100a) *)
  val contact_display_name : int32
  (** (0074,100c) *)
  val procedure_step_discontinuation_reason_code_sequence : int32
  (** (0074,100e) *)
  val beam_task_sequence : int32
  (** (0074,1020) *)
  val beam_task_type : int32
  (** (0074,1022) *)
  val beam_order_index_trial : int32
  (** (0074,1024) *)
  val table_top_vertical_adjusted_position : int32
  (** (0074,1026) *)
  val table_top_longitudinal_adjusted_position : int32
  (** (0074,1027) *)
  val table_top_lateral_adjusted_position : int32
  (** (0074,1028) *)
  val patient_support_adjusted_angle : int32
  (** (0074,102A) *)
  val table_top_eccentric_adjusted_angle : int32
  (** (0074,102B) *)
  val table_top_pitch_adjusted_angle : int32
  (** (0074,102C) *)
  val table_top_roll_adjusted_angle : int32
  (** (0074,102D) *)
  val delivery_verification_image_sequence : int32
  (** (0074,1030) *)
  val verification_image_timing : int32
  (** (0074,1032) *)
  val double_exposure_flag : int32
  (** (0074,1034) *)
  val double_exposure_ordering : int32
  (** (0074,1036) *)
  val double_exposure_meterset_trial : int32
  (** (0074,1038) *)
  val double_exposure_field_delta_trial : int32
  (** (0074,103A) *)
  val related_reference_rtimage_sequence : int32
  (** (0074,1040) *)
  val general_machine_verification_sequence : int32
  (** (0074,1042) *)
  val conventional_machine_verification_sequence : int32
  (** (0074,1044) *)
  val ion_machine_verification_sequence : int32
  (** (0074,1046) *)
  val failed_attributes_sequence : int32
  (** (0074,1048) *)
  val overridden_attributes_sequence : int32
  (** (0074,104A) *)
  val conventional_control_point_verification_sequence : int32
  (** (0074,104C) *)
  val ion_control_point_verification_sequence : int32
  (** (0074,104E) *)
  val attribute_occurrence_sequence : int32
  (** (0074,1050) *)
  val attribute_occurrence_pointer : int32
  (** (0074,1052) *)
  val attribute_item_selector : int32
  (** (0074,1054) *)
  val attribute_occurrence_private_creator : int32
  (** (0074,1056) *)
  val selector_sequence_pointer_items : int32
  (** (0074,1057) *)
  val scheduled_procedure_step_priority : int32
  (** (0074,1200) *)
  val worklist_label : int32
  (** (0074,1202) *)
  val procedure_step_label : int32
  (** (0074,1204) *)
  val scheduled_processing_parameters_sequence : int32
  (** (0074,1210) *)
  val performed_processing_parameters_sequence : int32
  (** (0074,1212) *)
  val unified_procedure_step_performed_procedure_sequence : int32
  (** (0074,1216) *)
  val related_procedure_step_sequence : int32
  (** (0074,1220) *)
  val procedure_step_relationship_type : int32
  (** (0074,1222) *)
  val replaced_procedure_step_sequence : int32
  (** (0074,1224) *)
  val deletion_lock : int32
  (** (0074,1230) *)
  val receiving_ae : int32
  (** (0074,1234) *)
  val requesting_ae : int32
  (** (0074,1236) *)
  val reason_for_cancellation : int32
  (** (0074,1238) *)
  val scp_status : int32
  (** (0074,1242) *)
  val subscription_list_status : int32
  (** (0074,1244) *)
  val unified_procedure_step_list_status : int32
  (** (0074,1246) *)
  val beam_order_index : int32
  (** (0074,1324) *)
  val double_exposure_meterset : int32
  (** (0074,1338) *)
  val double_exposure_field_delta : int32
  (** (0074,133A) *)
  val implant_assembly_template_name : int32
  (** (0076,0001) *)
  val implant_assembly_template_issuer : int32
  (** (0076,0003) *)
  val implant_assembly_template_version : int32
  (** (0076,0006) *)
  val replaced_implant_assembly_template_sequence : int32
  (** (0076,0008) *)
  val implant_assembly_template_type : int32
  (** (0076,000A) *)
  val original_implant_assembly_template_sequence : int32
  (** (0076,000C) *)
  val derivation_implant_assembly_template_sequence : int32
  (** (0076,000E) *)
  val implant_assembly_template_target_anatomy_sequence : int32
  (** (0076,0010) *)
  val procedure_type_code_sequence : int32
  (** (0076,0020) *)
  val surgical_technique : int32
  (** (0076,0030) *)
  val component_types_sequence : int32
  (** (0076,0032) *)
  val component_type_code_sequence : int32
  (** (0076,0034) *)
  val exclusive_component_type : int32
  (** (0076,0036) *)
  val mandatory_component_type : int32
  (** (0076,0038) *)
  val component_sequence : int32
  (** (0076,0040) *)
  val component_id : int32
  (** (0076,0055) *)
  val component_assembly_sequence : int32
  (** (0076,0060) *)
  val component1_referenced_id : int32
  (** (0076,0070) *)
  val component1_referenced_mating_feature_set_id : int32
  (** (0076,0080) *)
  val component1_referenced_mating_feature_id : int32
  (** (0076,0090) *)
  val component2_referenced_id : int32
  (** (0076,00A0) *)
  val component2_referenced_mating_feature_set_id : int32
  (** (0076,00B0) *)
  val component2_referenced_mating_feature_id : int32
  (** (0076,00C0) *)
  val implant_template_group_name : int32
  (** (0078,0001) *)
  val implant_template_group_description : int32
  (** (0078,0010) *)
  val implant_template_group_issuer : int32
  (** (0078,0020) *)
  val implant_template_group_version : int32
  (** (0078,0024) *)
  val replaced_implant_template_group_sequence : int32
  (** (0078,0026) *)
  val implant_template_group_target_anatomy_sequence : int32
  (** (0078,0028) *)
  val implant_template_group_members_sequence : int32
  (** (0078,002A) *)
  val implant_template_group_member_id : int32
  (** (0078,002E) *)
  val three_d_implant_template_group_member_matching_point : int32
  (** (0078,0050) *)
  val three_d_implant_template_group_member_matching_axes : int32
  (** (0078,0060) *)
  val implant_template_group_member_matching2_dcoordinates_sequence : int32
  (** (0078,0070) *)
  val two_d_implant_template_group_member_matching_point : int32
  (** (0078,0090) *)
  val two_d_implant_template_group_member_matching_axes : int32
  (** (0078,00A0) *)
  val implant_template_group_variation_dimension_sequence : int32
  (** (0078,00B0) *)
  val implant_template_group_variation_dimension_name : int32
  (** (0078,00B2) *)
  val implant_template_group_variation_dimension_rank_sequence : int32
  (** (0078,00B4) *)
  val referenced_implant_template_group_member_id : int32
  (** (0078,00B6) *)
  val implant_template_group_variation_dimension_rank : int32
  (** (0078,00B8) *)
  val storage_media_file_set_id : int32
  (** (0088,0130) *)
  val storage_media_file_set_uid : int32
  (** (0088,0140) *)
  val icon_image_sequence : int32
  (** (0088,0200) *)
  val topic_title : int32
  (** (0088,0904) *)
  val topic_subject : int32
  (** (0088,0906) *)
  val topic_author : int32
  (** (0088,0910) *)
  val topic_keywords : int32
  (** (0088,0912) *)
  val sop_instance_status : int32
  (** (0100,0410) *)
  val sop_authorization_date_time : int32
  (** (0100,0420) *)
  val sop_authorization_comment : int32
  (** (0100,0424) *)
  val authorization_equipment_certification_number : int32
  (** (0100,0426) *)
  val mac_id_number : int32
  (** (0400,0005) *)
  val mac_calculation_transfer_syntax_uid : int32
  (** (0400,0010) *)
  val mac_algorithm : int32
  (** (0400,0015) *)
  val data_elements_signed : int32
  (** (0400,0020) *)
  val digital_signature_uid : int32
  (** (0400,0100) *)
  val digital_signature_date_time : int32
  (** (0400,0105) *)
  val certificate_type : int32
  (** (0400,0110) *)
  val certificate_of_signer : int32
  (** (0400,0115) *)
  val signature : int32
  (** (0400,0120) *)
  val certified_timestamp_type : int32
  (** (0400,0305) *)
  val certified_timestamp : int32
  (** (0400,0310) *)
  val digital_signature_purpose_code_sequence : int32
  (** (0400,0401) *)
  val referenced_digital_signature_sequence : int32
  (** (0400,0402) *)
  val referenced_sop_instance_mac_sequence : int32
  (** (0400,0403) *)
  val mac : int32
  (** (0400,0404) *)
  val encrypted_attributes_sequence : int32
  (** (0400,0500) *)
  val encrypted_content_transfer_syntax_uid : int32
  (** (0400,0510) *)
  val encrypted_content : int32
  (** (0400,0520) *)
  val modified_attributes_sequence : int32
  (** (0400,0550) *)
  val original_attributes_sequence : int32
  (** (0400,0561) *)
  val attribute_modification_date_time : int32
  (** (0400,0562) *)
  val modifying_system : int32
  (** (0400,0563) *)
  val source_of_previous_values : int32
  (** (0400,0564) *)
  val reason_for_the_attribute_modification : int32
  (** (0400,0565) *)
  val escape_triplet : int32
  (** (1000,0000) *)
  val run_length_triplet : int32
  (** (1000,0001) *)
  val huffman_table_size : int32
  (** (1000,0002) *)
  val huffman_table_triplet : int32
  (** (1000,0003) *)
  val shift_table_size : int32
  (** (1000,0004) *)
  val shift_table_triplet : int32
  (** (1000,0005) *)
  val zonal_map : int32
  (** (1010,0000) *)
  val number_of_copies : int32
  (** (2000,0010) *)
  val printer_configuration_sequence : int32
  (** (2000,001E) *)
  val print_priority : int32
  (** (2000,0020) *)
  val medium_type : int32
  (** (2000,0030) *)
  val film_destination : int32
  (** (2000,0040) *)
  val film_session_label : int32
  (** (2000,0050) *)
  val memory_allocation : int32
  (** (2000,0060) *)
  val maximum_memory_allocation : int32
  (** (2000,0061) *)
  val color_image_printing_flag : int32
  (** (2000,0062) *)
  val collation_flag : int32
  (** (2000,0063) *)
  val annotation_flag : int32
  (** (2000,0065) *)
  val image_overlay_flag : int32
  (** (2000,0067) *)
  val presentation_lut_flag : int32
  (** (2000,0069) *)
  val image_box_presentation_lutflag : int32
  (** (2000,006A) *)
  val memory_bit_depth : int32
  (** (2000,00A0) *)
  val printing_bit_depth : int32
  (** (2000,00A1) *)
  val media_installed_sequence : int32
  (** (2000,00A2) *)
  val other_media_available_sequence : int32
  (** (2000,00A4) *)
  val supported_image_display_formats_sequence : int32
  (** (2000,00A8) *)
  val referenced_film_box_sequence : int32
  (** (2000,0500) *)
  val referenced_stored_print_sequence : int32
  (** (2000,0510) *)
  val image_display_format : int32
  (** (2010,0010) *)
  val annotation_display_format_id : int32
  (** (2010,0030) *)
  val film_orientation : int32
  (** (2010,0040) *)
  val film_size_id : int32
  (** (2010,0050) *)
  val printer_resolution_id : int32
  (** (2010,0052) *)
  val default_printer_resolution_id : int32
  (** (2010,0054) *)
  val magnification_type : int32
  (** (2010,0060) *)
  val smoothing_type : int32
  (** (2010,0080) *)
  val default_magnification_type : int32
  (** (2010,00A6) *)
  val other_magnification_types_available : int32
  (** (2010,00A7) *)
  val default_smoothing_type : int32
  (** (2010,00A8) *)
  val other_smoothing_types_available : int32
  (** (2010,00A9) *)
  val border_density : int32
  (** (2010,0100) *)
  val empty_image_density : int32
  (** (2010,0110) *)
  val min_density : int32
  (** (2010,0120) *)
  val max_density : int32
  (** (2010,0130) *)
  val trim : int32
  (** (2010,0140) *)
  val configuration_information : int32
  (** (2010,0150) *)
  val configuration_information_description : int32
  (** (2010,0152) *)
  val maximum_collated_films : int32
  (** (2010,0154) *)
  val illumination : int32
  (** (2010,015E) *)
  val reflected_ambient_light : int32
  (** (2010,0160) *)
  val printer_pixel_spacing : int32
  (** (2010,0376) *)
  val referenced_film_session_sequence : int32
  (** (2010,0500) *)
  val referenced_image_box_sequence : int32
  (** (2010,0510) *)
  val referenced_basic_annotation_box_sequence : int32
  (** (2010,0520) *)
  val image_box_position : int32
  (** (2020,0010) *)
  val polarity : int32
  (** (2020,0020) *)
  val requested_image_size : int32
  (** (2020,0030) *)
  val requested_decimate_crop_behavior : int32
  (** (2020,0040) *)
  val requested_resolution_id : int32
  (** (2020,0050) *)
  val requested_image_size_flag : int32
  (** (2020,00A0) *)
  val decimate_crop_result : int32
  (** (2020,00A2) *)
  val basic_grayscale_image_sequence : int32
  (** (2020,0110) *)
  val basic_color_image_sequence : int32
  (** (2020,0111) *)
  val referenced_image_overlay_box_sequence : int32
  (** (2020,0130) *)
  val referenced_voilutbox_sequence : int32
  (** (2020,0140) *)
  val annotation_position : int32
  (** (2030,0010) *)
  val text_string : int32
  (** (2030,0020) *)
  val referenced_overlay_plane_sequence : int32
  (** (2040,0010) *)
  val referenced_overlay_plane_groups : int32
  (** (2040,0011) *)
  val overlay_pixel_data_sequence : int32
  (** (2040,0020) *)
  val overlay_magnification_type : int32
  (** (2040,0060) *)
  val overlay_smoothing_type : int32
  (** (2040,0070) *)
  val overlay_or_image_magnification : int32
  (** (2040,0072) *)
  val magnify_to_number_of_columns : int32
  (** (2040,0074) *)
  val overlay_foreground_density : int32
  (** (2040,0080) *)
  val overlay_background_density : int32
  (** (2040,0082) *)
  val overlay_mode : int32
  (** (2040,0090) *)
  val threshold_density : int32
  (** (2040,0100) *)
  val referenced_image_box_sequence_retired : int32
  (** (2040,0500) *)
  val presentation_lutsequence : int32
  (** (2050,0010) *)
  val presentation_lutshape : int32
  (** (2050,0020) *)
  val referenced_presentation_lutsequence : int32
  (** (2050,0500) *)
  val print_job_id : int32
  (** (2100,0010) *)
  val execution_status : int32
  (** (2100,0020) *)
  val execution_status_info : int32
  (** (2100,0030) *)
  val creation_date : int32
  (** (2100,0040) *)
  val creation_time : int32
  (** (2100,0050) *)
  val originator : int32
  (** (2100,0070) *)
  val destination_ae : int32
  (** (2100,0140) *)
  val owner_id : int32
  (** (2100,0160) *)
  val number_of_films : int32
  (** (2100,0170) *)
  val referenced_print_job_sequence_pull_stored_print : int32
  (** (2100,0500) *)
  val printer_status : int32
  (** (2110,0010) *)
  val printer_status_info : int32
  (** (2110,0020) *)
  val printer_name : int32
  (** (2110,0030) *)
  val print_queue_id : int32
  (** (2110,0099) *)
  val queue_status : int32
  (** (2120,0010) *)
  val print_job_description_sequence : int32
  (** (2120,0050) *)
  val referenced_print_job_sequence : int32
  (** (2120,0070) *)
  val print_management_capabilities_sequence : int32
  (** (2130,0010) *)
  val printer_characteristics_sequence : int32
  (** (2130,0015) *)
  val film_box_content_sequence : int32
  (** (2130,0030) *)
  val image_box_content_sequence : int32
  (** (2130,0040) *)
  val annotation_content_sequence : int32
  (** (2130,0050) *)
  val image_overlay_box_content_sequence : int32
  (** (2130,0060) *)
  val presentation_lut_content_sequence : int32
  (** (2130,0080) *)
  val proposed_study_sequence : int32
  (** (2130,00A0) *)
  val original_image_sequence : int32
  (** (2130,00C0) *)
  val label_using_information_extracted_from_instances : int32
  (** (2200,0001) *)
  val label_text : int32
  (** (2200,0002) *)
  val label_style_selection : int32
  (** (2200,0003) *)
  val media_disposition : int32
  (** (2200,0004) *)
  val barcode_value : int32
  (** (2200,0005) *)
  val barcode_symbology : int32
  (** (2200,0006) *)
  val allow_media_splitting : int32
  (** (2200,0007) *)
  val include_non_dicomobjects : int32
  (** (2200,0008) *)
  val include_display_application : int32
  (** (2200,0009) *)
  val preserve_composite_instances_after_media_creation : int32
  (** (2200,000A) *)
  val total_number_of_pieces_of_media_created : int32
  (** (2200,000B) *)
  val requested_media_application_profile : int32
  (** (2200,000C) *)
  val referenced_storage_media_sequence : int32
  (** (2200,000D) *)
  val failure_attributes : int32
  (** (2200,000E) *)
  val allow_lossy_compression : int32
  (** (2200,000F) *)
  val request_priority : int32
  (** (2200,0020) *)
  val rt_image_label : int32
  (** (3002,0002) *)
  val rt_image_name : int32
  (** (3002,0003) *)
  val rt_image_description : int32
  (** (3002,0004) *)
  val reported_values_origin : int32
  (** (3002,000A) *)
  val rt_image_plane : int32
  (** (3002,000C) *)
  val x_ray_image_receptor_translation : int32
  (** (3002,000D) *)
  val x_ray_image_receptor_angle : int32
  (** (3002,000E) *)
  val rt_image_orientation : int32
  (** (3002,0010) *)
  val image_plane_pixel_spacing : int32
  (** (3002,0011) *)
  val rt_image_position : int32
  (** (3002,0012) *)
  val radiation_machine_name : int32
  (** (3002,0020) *)
  val radiation_machine_sad : int32
  (** (3002,0022) *)
  val radiation_machine_ssd : int32
  (** (3002,0024) *)
  val rt_image_sid : int32
  (** (3002,0026) *)
  val source_to_reference_object_distance : int32
  (** (3002,0028) *)
  val fraction_number : int32
  (** (3002,0029) *)
  val exposure_sequence : int32
  (** (3002,0030) *)
  val meterset_exposure : int32
  (** (3002,0032) *)
  val diaphragm_position : int32
  (** (3002,0034) *)
  val fluence_map_sequence : int32
  (** (3002,0040) *)
  val fluence_data_source : int32
  (** (3002,0041) *)
  val fluence_data_scale : int32
  (** (3002,0042) *)
  val primary_fluence_mode_sequence : int32
  (** (3002,0050) *)
  val fluence_mode : int32
  (** (3002,0051) *)
  val fluence_mode_id : int32
  (** (3002,0052) *)
  val dvh_type : int32
  (** (3004,0001) *)
  val dose_units : int32
  (** (3004,0002) *)
  val dose_type : int32
  (** (3004,0004) *)
  val dose_comment : int32
  (** (3004,0006) *)
  val normalization_point : int32
  (** (3004,0008) *)
  val dose_summation_type : int32
  (** (3004,000A) *)
  val grid_frame_offset_vector : int32
  (** (3004,000C) *)
  val dose_grid_scaling : int32
  (** (3004,000E) *)
  val rt_dose_roi_sequence : int32
  (** (3004,0010) *)
  val dose_value : int32
  (** (3004,0012) *)
  val tissue_heterogeneity_correction : int32
  (** (3004,0014) *)
  val dvh_normalization_point : int32
  (** (3004,0040) *)
  val dvh_normalization_dose_value : int32
  (** (3004,0042) *)
  val dvh_sequence : int32
  (** (3004,0050) *)
  val dvh_dose_scaling : int32
  (** (3004,0052) *)
  val dvh_volume_units : int32
  (** (3004,0054) *)
  val dvh_number_of_bins : int32
  (** (3004,0056) *)
  val dvh_data : int32
  (** (3004,0058) *)
  val dvh_referenced_roisequence : int32
  (** (3004,0060) *)
  val dvh_roicontribution_type : int32
  (** (3004,0062) *)
  val dvh_minimum_dose : int32
  (** (3004,0070) *)
  val dvh_maximum_dose : int32
  (** (3004,0072) *)
  val dvh_mean_dose : int32
  (** (3004,0074) *)
  val structure_set_label : int32
  (** (3006,0002) *)
  val structure_set_name : int32
  (** (3006,0004) *)
  val structure_set_description : int32
  (** (3006,0006) *)
  val structure_set_date : int32
  (** (3006,0008) *)
  val structure_set_time : int32
  (** (3006,0009) *)
  val referenced_frame_of_reference_sequence : int32
  (** (3006,0010) *)
  val rt_referenced_study_sequence : int32
  (** (3006,0012) *)
  val rt_referenced_series_sequence : int32
  (** (3006,0014) *)
  val contour_image_sequence : int32
  (** (3006,0016) *)
  val structure_set_roisequence : int32
  (** (3006,0020) *)
  val roi_number : int32
  (** (3006,0022) *)
  val referenced_frame_of_reference_uid : int32
  (** (3006,0024) *)
  val roiname : int32
  (** (3006,0026) *)
  val roidescription : int32
  (** (3006,0028) *)
  val roidisplaycolor : int32
  (** (3006,002A) *)
  val roivolume : int32
  (** (3006,002C) *)
  val rtrelatedroisequence : int32
  (** (3006,0030) *)
  val rtroirelationship : int32
  (** (3006,0033) *)
  val roigenerationalgorithm : int32
  (** (3006,0036) *)
  val roigenerationdescription : int32
  (** (3006,0038) *)
  val roicontoursequence : int32
  (** (3006,0039) *)
  val contour_sequence : int32
  (** (3006,0040) *)
  val contour_geometric_type : int32
  (** (3006,0042) *)
  val contour_slab_thickness : int32
  (** (3006,0044) *)
  val contour_offset_vector : int32
  (** (3006,0045) *)
  val number_of_contour_points : int32
  (** (3006,0046) *)
  val contour_number : int32
  (** (3006,0048) *)
  val attached_contours : int32
  (** (3006,0049) *)
  val contour_data : int32
  (** (3006,0050) *)
  val rt_roi_observations_sequence : int32
  (** (3006,0080) *)
  val observation_number : int32
  (** (3006,0082) *)
  val referenced_roinumber : int32
  (** (3006,0084) *)
  val roi_observation_label : int32
  (** (3006,0085) *)
  val rt_roi_identification_code_sequence : int32
  (** (3006,0086) *)
  val roi_observation_description : int32
  (** (3006,0088) *)
  val related_rt_roi_observations_sequence : int32
  (** (3006,00A0) *)
  val rt_roi_interpreted_type : int32
  (** (3006,00A4) *)
  val roi_interpreter : int32
  (** (3006,00A6) *)
  val roi_physical_properties_sequence : int32
  (** (3006,00B0) *)
  val roi_physical_property : int32
  (** (3006,00B2) *)
  val roi_physical_property_value : int32
  (** (3006,00B4) *)
  val roi_elemental_composition_sequence : int32
  (** (3006,00B6) *)
  val roi_elemental_composition_atomic_number : int32
  (** (3006,00B7) *)
  val roi_elemental_composition_atomic_mass_fraction : int32
  (** (3006,00B8) *)
  val frame_of_reference_relationship_sequence : int32
  (** (3006,00C0) *)
  val related_frame_of_reference_uid : int32
  (** (3006,00C2) *)
  val frame_of_reference_transformation_type : int32
  (** (3006,00C4) *)
  val frame_of_reference_transformation_matrix : int32
  (** (3006,00C6) *)
  val frame_of_reference_transformation_comment : int32
  (** (3006,00C8) *)
  val measured_dose_reference_sequence : int32
  (** (3008,0010) *)
  val measured_dose_description : int32
  (** (3008,0012) *)
  val measured_dose_type : int32
  (** (3008,0014) *)
  val measured_dose_value : int32
  (** (3008,0016) *)
  val treatment_session_beam_sequence : int32
  (** (3008,0020) *)
  val treatment_session_ion_beam_sequence : int32
  (** (3008,0021) *)
  val current_fraction_number : int32
  (** (3008,0022) *)
  val treatment_control_point_date : int32
  (** (3008,0024) *)
  val treatment_control_point_time : int32
  (** (3008,0025) *)
  val treatment_termination_status : int32
  (** (3008,002A) *)
  val treatment_termination_code : int32
  (** (3008,002B) *)
  val treatment_verification_status : int32
  (** (3008,002C) *)
  val referenced_treatment_record_sequence : int32
  (** (3008,0030) *)
  val specified_primary_meterset : int32
  (** (3008,0032) *)
  val specified_secondary_meterset : int32
  (** (3008,0033) *)
  val delivered_primary_meterset : int32
  (** (3008,0036) *)
  val delivered_secondary_meterset : int32
  (** (3008,0037) *)
  val specified_treatment_time : int32
  (** (3008,003A) *)
  val delivered_treatment_time : int32
  (** (3008,003B) *)
  val control_point_delivery_sequence : int32
  (** (3008,0040) *)
  val ion_control_point_delivery_sequence : int32
  (** (3008,0041) *)
  val specified_meterset : int32
  (** (3008,0042) *)
  val delivered_meterset : int32
  (** (3008,0044) *)
  val meterset_rate_set : int32
  (** (3008,0045) *)
  val meterset_rate_delivered : int32
  (** (3008,0046) *)
  val scan_spot_metersets_delivered : int32
  (** (3008,0047) *)
  val dose_rate_delivered : int32
  (** (3008,0048) *)
  val treatment_summary_calculated_dose_reference_sequence : int32
  (** (3008,0050) *)
  val cumulative_dose_to_dose_reference : int32
  (** (3008,0052) *)
  val first_treatment_date : int32
  (** (3008,0054) *)
  val most_recent_treatment_date : int32
  (** (3008,0056) *)
  val number_of_fractions_delivered : int32
  (** (3008,005A) *)
  val override_sequence : int32
  (** (3008,0060) *)
  val parameter_sequence_pointer : int32
  (** (3008,0061) *)
  val override_parameter_pointer : int32
  (** (3008,0062) *)
  val parameter_item_index : int32
  (** (3008,0063) *)
  val measured_dose_reference_number : int32
  (** (3008,0064) *)
  val parameter_pointer : int32
  (** (3008,0065) *)
  val override_reason : int32
  (** (3008,0066) *)
  val corrected_parameter_sequence : int32
  (** (3008,0068) *)
  val correction_value : int32
  (** (3008,006A) *)
  val calculated_dose_reference_sequence : int32
  (** (3008,0070) *)
  val calculated_dose_reference_number : int32
  (** (3008,0072) *)
  val calculated_dose_reference_description : int32
  (** (3008,0074) *)
  val calculated_dose_reference_dose_value : int32
  (** (3008,0076) *)
  val start_meterset : int32
  (** (3008,0078) *)
  val end_meterset : int32
  (** (3008,007A) *)
  val referenced_measured_dose_reference_sequence : int32
  (** (3008,0080) *)
  val referenced_measured_dose_reference_number : int32
  (** (3008,0082) *)
  val referenced_calculated_dose_reference_sequence : int32
  (** (3008,0090) *)
  val referenced_calculated_dose_reference_number : int32
  (** (3008,0092) *)
  val beam_limiting_device_leaf_pairs_sequence : int32
  (** (3008,00A0) *)
  val recorded_wedge_sequence : int32
  (** (3008,00B0) *)
  val recorded_compensator_sequence : int32
  (** (3008,00C0) *)
  val recorded_block_sequence : int32
  (** (3008,00D0) *)
  val treatment_summary_measured_dose_reference_sequence : int32
  (** (3008,00E0) *)
  val recorded_snout_sequence : int32
  (** (3008,00F0) *)
  val recorded_range_shifter_sequence : int32
  (** (3008,00F2) *)
  val recorded_lateral_spreading_device_sequence : int32
  (** (3008,00F4) *)
  val recorded_range_modulator_sequence : int32
  (** (3008,00F6) *)
  val recorded_source_sequence : int32
  (** (3008,0100) *)
  val source_serial_number : int32
  (** (3008,0105) *)
  val treatment_session_application_setup_sequence : int32
  (** (3008,0110) *)
  val application_setup_check : int32
  (** (3008,0116) *)
  val recorded_brachy_accessory_device_sequence : int32
  (** (3008,0120) *)
  val referenced_brachy_accessory_device_number : int32
  (** (3008,0122) *)
  val recorded_channel_sequence : int32
  (** (3008,0130) *)
  val specified_channel_total_time : int32
  (** (3008,0132) *)
  val delivered_channel_total_time : int32
  (** (3008,0134) *)
  val specified_number_of_pulses : int32
  (** (3008,0136) *)
  val delivered_number_of_pulses : int32
  (** (3008,0138) *)
  val specified_pulse_repetition_interval : int32
  (** (3008,013A) *)
  val delivered_pulse_repetition_interval : int32
  (** (3008,013C) *)
  val recorded_source_applicator_sequence : int32
  (** (3008,0140) *)
  val referenced_source_applicator_number : int32
  (** (3008,0142) *)
  val recorded_channel_shield_sequence : int32
  (** (3008,0150) *)
  val referenced_channel_shield_number : int32
  (** (3008,0152) *)
  val brachy_control_point_delivered_sequence : int32
  (** (3008,0160) *)
  val safe_position_exit_date : int32
  (** (3008,0162) *)
  val safe_position_exit_time : int32
  (** (3008,0164) *)
  val safe_position_return_date : int32
  (** (3008,0166) *)
  val safe_position_return_time : int32
  (** (3008,0168) *)
  val current_treatment_status : int32
  (** (3008,0200) *)
  val treatment_status_comment : int32
  (** (3008,0202) *)
  val fraction_group_summary_sequence : int32
  (** (3008,0220) *)
  val referenced_fraction_number : int32
  (** (3008,0223) *)
  val fraction_group_type : int32
  (** (3008,0224) *)
  val beam_stopper_position : int32
  (** (3008,0230) *)
  val fraction_status_summary_sequence : int32
  (** (3008,0240) *)
  val treatment_date : int32
  (** (3008,0250) *)
  val treatment_time : int32
  (** (3008,0251) *)
  val rt_plan_label : int32
  (** (300A,0002) *)
  val rt_plan_name : int32
  (** (300A,0003) *)
  val rt_plan_description : int32
  (** (300A,0004) *)
  val rt_plan_date : int32
  (** (300A,0006) *)
  val rt_plan_time : int32
  (** (300A,0007) *)
  val treatment_protocols : int32
  (** (300A,0009) *)
  val plan_intent : int32
  (** (300A,000A) *)
  val treatment_sites : int32
  (** (300A,000B) *)
  val r_tplan_geometry : int32
  (** (300A,000C) *)
  val prescription_description : int32
  (** (300A,000E) *)
  val dose_reference_sequence : int32
  (** (300A,0010) *)
  val dose_reference_number : int32
  (** (300A,0012) *)
  val dose_reference_uid : int32
  (** (300A,0013) *)
  val dose_reference_structure_type : int32
  (** (300A,0014) *)
  val nominal_beam_energy_unit : int32
  (** (300A,0015) *)
  val dose_reference_description : int32
  (** (300A,0016) *)
  val dose_reference_point_coordinates : int32
  (** (300A,0018) *)
  val nominal_prior_dose : int32
  (** (300A,001A) *)
  val dose_reference_type : int32
  (** (300A,0020) *)
  val constraint_weight : int32
  (** (300A,0021) *)
  val delivery_warning_dose : int32
  (** (300A,0022) *)
  val delivery_maximum_dose : int32
  (** (300A,0023) *)
  val target_minimum_dose : int32
  (** (300A,0025) *)
  val target_prescription_dose : int32
  (** (300A,0026) *)
  val target_maximum_dose : int32
  (** (300A,0027) *)
  val target_underdose_volume_fraction : int32
  (** (300A,0028) *)
  val organ_at_risk_full_volume_dose : int32
  (** (300A,002A) *)
  val organ_at_risk_limit_dose : int32
  (** (300A,002B) *)
  val organ_at_risk_maximum_dose : int32
  (** (300A,002C) *)
  val organ_at_risk_overdose_volume_fraction : int32
  (** (300A,002D) *)
  val tolerance_table_sequence : int32
  (** (300A,0040) *)
  val tolerance_table_number : int32
  (** (300A,0042) *)
  val tolerance_table_label : int32
  (** (300A,0043) *)
  val gantry_angle_tolerance : int32
  (** (300A,0044) *)
  val beam_limiting_device_angle_tolerance : int32
  (** (300A,0046) *)
  val beam_limiting_device_tolerance_sequence : int32
  (** (300A,0048) *)
  val beam_limiting_device_position_tolerance : int32
  (** (300A,004A) *)
  val snout_position_tolerance : int32
  (** (300A,004B) *)
  val patient_support_angle_tolerance : int32
  (** (300A,004C) *)
  val table_top_eccentric_angle_tolerance : int32
  (** (300A,004E) *)
  val table_top_pitch_angle_tolerance : int32
  (** (300A,004F) *)
  val table_top_roll_angle_tolerance : int32
  (** (300A,0050) *)
  val table_top_vertical_position_tolerance : int32
  (** (300A,0051) *)
  val table_top_longitudinal_position_tolerance : int32
  (** (300A,0052) *)
  val table_top_lateral_position_tolerance : int32
  (** (300A,0053) *)
  val rt_plan_relationship : int32
  (** (300A,0055) *)
  val fraction_group_sequence : int32
  (** (300A,0070) *)
  val fraction_group_number : int32
  (** (300A,0071) *)
  val fraction_group_description : int32
  (** (300A,0072) *)
  val number_of_fractions_planned : int32
  (** (300A,0078) *)
  val number_of_fraction_pattern_digits_per_day : int32
  (** (300A,0079) *)
  val repeat_fraction_cycle_length : int32
  (** (300A,007A) *)
  val fraction_pattern : int32
  (** (300A,007B) *)
  val number_of_beams : int32
  (** (300A,0080) *)
  val beam_dose_specification_point : int32
  (** (300A,0082) *)
  val beam_dose : int32
  (** (300A,0084) *)
  val beam_meterset : int32
  (** (300A,0086) *)
  val beam_dose_point_depth : int32
  (** (300A,0088) *)
  val beam_dose_point_equivalent_depth : int32
  (** (300A,0089) *)
  val beam_dose_point_ssd : int32
  (** (300A,008A) *)
  val number_of_brachy_application_setups : int32
  (** (300A,00A0) *)
  val brachy_application_setup_dose_specification_point : int32
  (** (300A,00A2) *)
  val brachy_application_setup_dose : int32
  (** (300A,00A4) *)
  val beam_sequence : int32
  (** (300A,00B0) *)
  val treatment_machine_name : int32
  (** (300A,00B2) *)
  val primary_dosimeter_unit : int32
  (** (300A,00B3) *)
  val source_axis_distance : int32
  (** (300A,00B4) *)
  val beam_limiting_device_sequence : int32
  (** (300A,00B6) *)
  val r_tbeam_limiting_device_type : int32
  (** (300A,00B8) *)
  val source_to_beam_limiting_device_distance : int32
  (** (300A,00BA) *)
  val isocenter_to_beam_limiting_device_distance : int32
  (** (300A,00BB) *)
  val number_of_leaf_jaw_pairs : int32
  (** (300A,00BC) *)
  val leaf_position_boundaries : int32
  (** (300A,00BE) *)
  val beam_number : int32
  (** (300A,00C0) *)
  val beam_name : int32
  (** (300A,00C2) *)
  val beam_description : int32
  (** (300A,00C3) *)
  val beam_type : int32
  (** (300A,00C4) *)
  val radiation_type : int32
  (** (300A,00C6) *)
  val high_dose_technique_type : int32
  (** (300A,00C7) *)
  val reference_image_number : int32
  (** (300A,00C8) *)
  val planned_verification_image_sequence : int32
  (** (300A,00CA) *)
  val imaging_device_specific_acquisition_parameters : int32
  (** (300A,00CC) *)
  val treatment_delivery_type : int32
  (** (300A,00CE) *)
  val number_of_wedges : int32
  (** (300A,00D0) *)
  val wedge_sequence : int32
  (** (300A,00D1) *)
  val wedge_number : int32
  (** (300A,00D2) *)
  val wedge_type : int32
  (** (300A,00D3) *)
  val wedge_id : int32
  (** (300A,00D4) *)
  val wedge_angle : int32
  (** (300A,00D5) *)
  val wedge_factor : int32
  (** (300A,00D6) *)
  val total_wedge_tray_water_equivalent_thickness : int32
  (** (300A,00D7) *)
  val wedge_orientation : int32
  (** (300A,00D8) *)
  val isocenter_to_wedge_tray_distance : int32
  (** (300A,00D9) *)
  val source_to_wedge_tray_distance : int32
  (** (300A,00DA) *)
  val wedge_thin_edge_position : int32
  (** (300A,00DB) *)
  val bolus_id : int32
  (** (300A,00DC) *)
  val bolus_description : int32
  (** (300A,00DD) *)
  val number_of_compensators : int32
  (** (300A,00E0) *)
  val material_id : int32
  (** (300A,00E1) *)
  val total_compensator_tray_factor : int32
  (** (300A,00E2) *)
  val compensator_sequence : int32
  (** (300A,00E3) *)
  val compensator_number : int32
  (** (300A,00E4) *)
  val compensator_id : int32
  (** (300A,00E5) *)
  val source_to_compensator_tray_distance : int32
  (** (300A,00E6) *)
  val compensator_rows : int32
  (** (300A,00E7) *)
  val compensator_columns : int32
  (** (300A,00E8) *)
  val compensator_pixel_spacing : int32
  (** (300A,00E9) *)
  val compensator_position : int32
  (** (300A,00EA) *)
  val compensator_transmission_data : int32
  (** (300A,00EB) *)
  val compensator_thickness_data : int32
  (** (300A,00EC) *)
  val number_of_boli : int32
  (** (300A,00ED) *)
  val compensator_type : int32
  (** (300A,00EE) *)
  val number_of_blocks : int32
  (** (300A,00F0) *)
  val total_block_tray_factor : int32
  (** (300A,00F2) *)
  val total_block_tray_water_equivalent_thickness : int32
  (** (300A,00F3) *)
  val block_sequence : int32
  (** (300A,00F4) *)
  val block_tray_id : int32
  (** (300A,00F5) *)
  val source_to_block_tray_distance : int32
  (** (300A,00F6) *)
  val isocenter_to_block_tray_distance : int32
  (** (300A,00F7) *)
  val block_type : int32
  (** (300A,00F8) *)
  val accessory_code : int32
  (** (300A,00F9) *)
  val block_divergence : int32
  (** (300A,00FA) *)
  val block_mounting_position : int32
  (** (300A,00FB) *)
  val block_number : int32
  (** (300A,00FC) *)
  val block_name : int32
  (** (300A,00FE) *)
  val block_thickness : int32
  (** (300A,0100) *)
  val block_transmission : int32
  (** (300A,0102) *)
  val block_number_of_points : int32
  (** (300A,0104) *)
  val block_data : int32
  (** (300A,0106) *)
  val applicator_sequence : int32
  (** (300A,0107) *)
  val applicator_id : int32
  (** (300A,0108) *)
  val applicator_type : int32
  (** (300A,0109) *)
  val applicator_description : int32
  (** (300A,010A) *)
  val cumulative_dose_reference_coefficient : int32
  (** (300A,010C) *)
  val final_cumulative_meterset_weight : int32
  (** (300A,010E) *)
  val number_of_control_points : int32
  (** (300A,0110) *)
  val control_point_sequence : int32
  (** (300A,0111) *)
  val control_point_index : int32
  (** (300A,0112) *)
  val nominal_beam_energy : int32
  (** (300A,0114) *)
  val dose_rate_set : int32
  (** (300A,0115) *)
  val wedge_position_sequence : int32
  (** (300A,0116) *)
  val wedge_position : int32
  (** (300A,0118) *)
  val beam_limiting_device_position_sequence : int32
  (** (300A,011A) *)
  val leaf_jaw_positions : int32
  (** (300A,011C) *)
  val gantry_angle : int32
  (** (300A,011E) *)
  val gantry_rotation_direction : int32
  (** (300A,011F) *)
  val beam_limiting_device_angle : int32
  (** (300A,0120) *)
  val beam_limiting_device_rotation_direction : int32
  (** (300A,0121) *)
  val patient_support_angle : int32
  (** (300A,0122) *)
  val patient_support_rotation_direction : int32
  (** (300A,0123) *)
  val table_top_eccentric_axis_distance : int32
  (** (300A,0124) *)
  val table_top_eccentric_angle : int32
  (** (300A,0125) *)
  val table_top_eccentric_rotation_direction : int32
  (** (300A,0126) *)
  val table_top_vertical_position : int32
  (** (300A,0128) *)
  val table_top_longitudinal_position : int32
  (** (300A,0129) *)
  val table_top_lateral_position : int32
  (** (300A,012A) *)
  val isocenter_position : int32
  (** (300A,012C) *)
  val surface_entry_point : int32
  (** (300A,012E) *)
  val source_to_surface_distance : int32
  (** (300A,0130) *)
  val cumulative_meterset_weight : int32
  (** (300A,0134) *)
  val table_top_pitch_angle : int32
  (** (300A,0140) *)
  val table_top_pitch_rotation_direction : int32
  (** (300A,0142) *)
  val table_top_roll_angle : int32
  (** (300A,0144) *)
  val table_top_roll_rotation_direction : int32
  (** (300A,0146) *)
  val head_fixation_angle : int32
  (** (300A,0148) *)
  val gantry_pitch_angle : int32
  (** (300A,014A) *)
  val gantry_pitch_rotation_direction : int32
  (** (300A,014C) *)
  val gantry_pitch_angle_tolerance : int32
  (** (300A,014E) *)
  val patient_setup_sequence : int32
  (** (300A,0180) *)
  val patient_setup_number : int32
  (** (300A,0182) *)
  val patient_setup_label : int32
  (** (300A,0183) *)
  val patient_additional_position : int32
  (** (300A,0184) *)
  val fixation_device_sequence : int32
  (** (300A,0190) *)
  val fixation_device_type : int32
  (** (300A,0192) *)
  val fixation_device_label : int32
  (** (300A,0194) *)
  val fixation_device_description : int32
  (** (300A,0196) *)
  val fixation_device_position : int32
  (** (300A,0198) *)
  val fixation_device_pitch_angle : int32
  (** (300A,0199) *)
  val fixation_device_roll_angle : int32
  (** (300A,019A) *)
  val shielding_device_sequence : int32
  (** (300A,01A0) *)
  val shielding_device_type : int32
  (** (300A,01A2) *)
  val shielding_device_label : int32
  (** (300A,01A4) *)
  val shielding_device_description : int32
  (** (300A,01A6) *)
  val shielding_device_position : int32
  (** (300A,01A8) *)
  val setup_technique : int32
  (** (300A,01B0) *)
  val setup_technique_description : int32
  (** (300A,01B2) *)
  val setup_device_sequence : int32
  (** (300A,01B4) *)
  val setup_device_type : int32
  (** (300A,01B6) *)
  val setup_device_label : int32
  (** (300A,01B8) *)
  val setup_device_description : int32
  (** (300A,01BA) *)
  val setup_device_parameter : int32
  (** (300A,01BC) *)
  val setup_reference_description : int32
  (** (300A,01D0) *)
  val table_top_vertical_setup_displacement : int32
  (** (300A,01D2) *)
  val table_top_longitudinal_setup_displacement : int32
  (** (300A,01D4) *)
  val table_top_lateral_setup_displacement : int32
  (** (300A,01D6) *)
  val brachy_treatment_technique : int32
  (** (300A,0200) *)
  val brachy_treatment_type : int32
  (** (300A,0202) *)
  val treatment_machine_sequence : int32
  (** (300A,0206) *)
  val source_sequence : int32
  (** (300A,0210) *)
  val source_number : int32
  (** (300A,0212) *)
  val source_type : int32
  (** (300A,0214) *)
  val source_manufacturer : int32
  (** (300A,0216) *)
  val active_source_diameter : int32
  (** (300A,0218) *)
  val active_source_length : int32
  (** (300A,021A) *)
  val source_encapsulation_nominal_thickness : int32
  (** (300A,0222) *)
  val source_encapsulation_nominal_transmission : int32
  (** (300A,0224) *)
  val source_isotope_name : int32
  (** (300A,0226) *)
  val source_isotope_half_life : int32
  (** (300A,0228) *)
  val source_strength_units : int32
  (** (300A,0229) *)
  val reference_air_kerma_rate : int32
  (** (300A,022A) *)
  val source_strength : int32
  (** (300A,022B) *)
  val source_strength_reference_date : int32
  (** (300A,022C) *)
  val source_strength_reference_time : int32
  (** (300A,022E) *)
  val application_setup_sequence : int32
  (** (300A,0230) *)
  val application_setup_type : int32
  (** (300A,0232) *)
  val application_setup_number : int32
  (** (300A,0234) *)
  val application_setup_name : int32
  (** (300A,0236) *)
  val application_setup_manufacturer : int32
  (** (300A,0238) *)
  val template_number : int32
  (** (300A,0240) *)
  val template_type : int32
  (** (300A,0242) *)
  val template_name : int32
  (** (300A,0244) *)
  val total_reference_air_kerma : int32
  (** (300A,0250) *)
  val brachy_accessory_device_sequence : int32
  (** (300A,0260) *)
  val brachy_accessory_device_number : int32
  (** (300A,0262) *)
  val brachy_accessory_device_id : int32
  (** (300A,0263) *)
  val brachy_accessory_device_type : int32
  (** (300A,0264) *)
  val brachy_accessory_device_name : int32
  (** (300A,0266) *)
  val brachy_accessory_device_nominal_thickness : int32
  (** (300A,026A) *)
  val brachy_accessory_device_nominal_transmission : int32
  (** (300A,026C) *)
  val channel_sequence : int32
  (** (300A,0280) *)
  val channel_number : int32
  (** (300A,0282) *)
  val channel_length : int32
  (** (300A,0284) *)
  val channel_total_time : int32
  (** (300A,0286) *)
  val source_movement_type : int32
  (** (300A,0288) *)
  val number_of_pulses : int32
  (** (300A,028A) *)
  val pulse_repetition_interval : int32
  (** (300A,028C) *)
  val source_applicator_number : int32
  (** (300A,0290) *)
  val source_applicator_id : int32
  (** (300A,0291) *)
  val source_applicator_type : int32
  (** (300A,0292) *)
  val source_applicator_name : int32
  (** (300A,0294) *)
  val source_applicator_length : int32
  (** (300A,0296) *)
  val source_applicator_manufacturer : int32
  (** (300A,0298) *)
  val source_applicator_wall_nominal_thickness : int32
  (** (300A,029C) *)
  val source_applicator_wall_nominal_transmission : int32
  (** (300A,029E) *)
  val source_applicator_step_size : int32
  (** (300A,02A0) *)
  val transfer_tube_number : int32
  (** (300A,02A2) *)
  val transfer_tube_length : int32
  (** (300A,02A4) *)
  val channel_shield_sequence : int32
  (** (300A,02B0) *)
  val channel_shield_number : int32
  (** (300A,02B2) *)
  val channel_shield_id : int32
  (** (300A,02B3) *)
  val channel_shield_name : int32
  (** (300A,02B4) *)
  val channel_shield_nominal_thickness : int32
  (** (300A,02B8) *)
  val channel_shield_nominal_transmission : int32
  (** (300A,02BA) *)
  val final_cumulative_time_weight : int32
  (** (300A,02C8) *)
  val brachy_control_point_sequence : int32
  (** (300A,02D0) *)
  val control_point_relative_position : int32
  (** (300A,02D2) *)
  val control_point_3d_position : int32
  (** (300A,02D4) *)
  val cumulative_time_weight : int32
  (** (300A,02D6) *)
  val compensator_divergence : int32
  (** (300A,02E0) *)
  val compensator_mounting_position : int32
  (** (300A,02E1) *)
  val source_to_compensator_distance : int32
  (** (300A,02E2) *)
  val total_compensator_tray_water_equivalent_thickness : int32
  (** (300A,02E3) *)
  val isocenter_to_compensator_tray_distance : int32
  (** (300A,02E4) *)
  val compensator_column_offset : int32
  (** (300A,02E5) *)
  val isocenter_to_compensator_distances : int32
  (** (300A,02E6) *)
  val compensator_relative_stopping_power_ratio : int32
  (** (300A,02E7) *)
  val compensator_milling_tool_diameter : int32
  (** (300A,02E8) *)
  val ion_range_compensator_sequence : int32
  (** (300A,02EA) *)
  val compensator_description : int32
  (** (300A,02EB) *)
  val radiation_mass_number : int32
  (** (300A,0302) *)
  val radiation_atomic_number : int32
  (** (300A,0304) *)
  val radiation_charge_state : int32
  (** (300A,0306) *)
  val scan_mode : int32
  (** (300A,0308) *)
  val virtual_source_axis_distances : int32
  (** (300A,030A) *)
  val snout_sequence : int32
  (** (300A,030C) *)
  val snout_position : int32
  (** (300A,030D) *)
  val snout_id : int32
  (** (300A,030F) *)
  val number_of_range_shifters : int32
  (** (300A,0312) *)
  val range_shifter_sequence : int32
  (** (300A,0314) *)
  val range_shifter_number : int32
  (** (300A,0316) *)
  val range_shifter_id : int32
  (** (300A,0318) *)
  val range_shifter_type : int32
  (** (300A,0320) *)
  val range_shifter_description : int32
  (** (300A,0322) *)
  val number_of_lateral_spreading_devices : int32
  (** (300A,0330) *)
  val lateral_spreading_device_sequence : int32
  (** (300A,0332) *)
  val lateral_spreading_device_number : int32
  (** (300A,0334) *)
  val lateral_spreading_device_id : int32
  (** (300A,0336) *)
  val lateral_spreading_device_type : int32
  (** (300A,0338) *)
  val lateral_spreading_device_description : int32
  (** (300A,033A) *)
  val lateral_spreading_device_water_equivalent_thickness : int32
  (** (300A,033C) *)
  val number_of_range_modulators : int32
  (** (300A,0340) *)
  val range_modulator_sequence : int32
  (** (300A,0342) *)
  val range_modulator_number : int32
  (** (300A,0344) *)
  val range_modulator_id : int32
  (** (300A,0346) *)
  val range_modulator_type : int32
  (** (300A,0348) *)
  val range_modulator_description : int32
  (** (300A,034A) *)
  val beam_current_modulation_id : int32
  (** (300A,034C) *)
  val patient_support_type : int32
  (** (300A,0350) *)
  val patient_support_id : int32
  (** (300A,0352) *)
  val patient_support_accessory_code : int32
  (** (300A,0354) *)
  val fixation_light_azimuthal_angle : int32
  (** (300A,0356) *)
  val fixation_light_polar_angle : int32
  (** (300A,0358) *)
  val meterset_rate : int32
  (** (300A,035A) *)
  val range_shifter_settings_sequence : int32
  (** (300A,0360) *)
  val range_shifter_setting : int32
  (** (300A,0362) *)
  val isocenter_to_range_shifter_distance : int32
  (** (300A,0364) *)
  val range_shifter_water_equivalent_thickness : int32
  (** (300A,0366) *)
  val lateral_spreading_device_settings_sequence : int32
  (** (300A,0370) *)
  val lateral_spreading_device_setting : int32
  (** (300A,0372) *)
  val isocenter_to_lateral_spreading_device_distance : int32
  (** (300A,0374) *)
  val range_modulator_settings_sequence : int32
  (** (300A,0380) *)
  val range_modulator_gating_start_value : int32
  (** (300A,0382) *)
  val range_modulator_gating_stop_value : int32
  (** (300A,0384) *)
  val range_modulator_gating_start_water_equivalent_thickness : int32
  (** (300A,0386) *)
  val range_modulator_gating_stop_water_equivalent_thickness : int32
  (** (300A,0388) *)
  val isocenter_to_range_modulator_distance : int32
  (** (300A,038A) *)
  val scan_spot_tune_id : int32
  (** (300A,0390) *)
  val number_of_scan_spot_positions : int32
  (** (300A,0392) *)
  val scan_spot_position_map : int32
  (** (300A,0394) *)
  val scan_spot_meterset_weights : int32
  (** (300A,0396) *)
  val scanning_spot_size : int32
  (** (300A,0398) *)
  val number_of_paintings : int32
  (** (300A,039A) *)
  val ion_tolerance_table_sequence : int32
  (** (300A,03A0) *)
  val ion_beam_sequence : int32
  (** (300A,03A2) *)
  val ion_beam_limiting_device_sequence : int32
  (** (300A,03A4) *)
  val ion_block_sequence : int32
  (** (300A,03A6) *)
  val ion_control_point_sequence : int32
  (** (300A,03A8) *)
  val ion_wedge_sequence : int32
  (** (300A,03AA) *)
  val ion_wedge_position_sequence : int32
  (** (300A,03AC) *)
  val referenced_setup_image_sequence : int32
  (** (300A,0401) *)
  val setup_image_comment : int32
  (** (300A,0402) *)
  val motion_synchronization_sequence : int32
  (** (300A,0410) *)
  val control_point_orientation : int32
  (** (300A,0412) *)
  val general_accessory_sequence : int32
  (** (300A,0420) *)
  val general_accessory_id : int32
  (** (300A,0421) *)
  val general_accessory_description : int32
  (** (300A,0422) *)
  val general_accessory_type : int32
  (** (300A,0423) *)
  val general_accessory_number : int32
  (** (300A,0424) *)
  val applicator_geometry_sequence : int32
  (** (300A,0431) *)
  val applicator_aperture_shape : int32
  (** (300A,0432) *)
  val applicator_opening : int32
  (** (300A,0433) *)
  val applicator_opening_x : int32
  (** (300A,0434) *)
  val applicator_opening_y : int32
  (** (300A,0435) *)
  val source_to_applicator_mounting_position_distance : int32
  (** (300A,0436) *)
  val referenced_rt_plan_sequence : int32
  (** (300C,0002) *)
  val referenced_beam_sequence : int32
  (** (300C,0004) *)
  val referenced_beam_number : int32
  (** (300C,0006) *)
  val referenced_reference_image_number : int32
  (** (300C,0007) *)
  val start_cumulative_meterset_weight : int32
  (** (300C,0008) *)
  val end_cumulative_meterset_weight : int32
  (** (300C,0009) *)
  val referenced_brachy_application_setup_sequence : int32
  (** (300C,000A) *)
  val referenced_brachy_application_setup_number : int32
  (** (300C,000C) *)
  val referenced_source_number : int32
  (** (300C,000E) *)
  val referenced_fraction_group_sequence : int32
  (** (300C,0020) *)
  val referenced_fraction_group_number : int32
  (** (300C,0022) *)
  val referenced_verification_image_sequence : int32
  (** (300C,0040) *)
  val referenced_reference_image_sequence : int32
  (** (300C,0042) *)
  val referenced_dose_reference_sequence : int32
  (** (300C,0050) *)
  val referenced_dose_reference_number : int32
  (** (300C,0051) *)
  val brachy_referenced_dose_reference_sequence : int32
  (** (300C,0055) *)
  val referenced_structure_set_sequence : int32
  (** (300C,0060) *)
  val referenced_patient_setup_number : int32
  (** (300C,006A) *)
  val referenced_dose_sequence : int32
  (** (300C,0080) *)
  val referenced_tolerance_table_number : int32
  (** (300C,00A0) *)
  val referenced_bolus_sequence : int32
  (** (300C,00B0) *)
  val referenced_wedge_number : int32
  (** (300C,00C0) *)
  val referenced_compensator_number : int32
  (** (300C,00D0) *)
  val referenced_block_number : int32
  (** (300C,00E0) *)
  val referenced_control_point_index : int32
  (** (300C,00F0) *)
  val referenced_control_point_sequence : int32
  (** (300C,00F2) *)
  val referenced_start_control_point_index : int32
  (** (300C,00F4) *)
  val referenced_stop_control_point_index : int32
  (** (300C,00F6) *)
  val referenced_range_shifter_number : int32
  (** (300C,0100) *)
  val referenced_lateral_spreading_device_number : int32
  (** (300C,0102) *)
  val referenced_range_modulator_number : int32
  (** (300C,0104) *)
  val approval_status : int32
  (** (300E,0002) *)
  val review_date : int32
  (** (300E,0004) *)
  val review_time : int32
  (** (300E,0005) *)
  val reviewer_name : int32
  (** (300E,0008) *)
  val arbitrary : int32
  (** (4000,0010) *)
  val text_comments : int32
  (** (4000,4000) *)
  val results_id : int32
  (** (4008,0040) *)
  val results_id_issuer : int32
  (** (4008,0042) *)
  val referenced_interpretation_sequence : int32
  (** (4008,0050) *)
  val report_production_status_trial : int32
  (** (4008,00FF) *)
  val interpretation_recorded_date : int32
  (** (4008,0100) *)
  val interpretation_recorded_time : int32
  (** (4008,0101) *)
  val interpretation_recorder : int32
  (** (4008,0102) *)
  val reference_to_recorded_sound : int32
  (** (4008,0103) *)
  val interpretation_transcription_date : int32
  (** (4008,0108) *)
  val interpretation_transcription_time : int32
  (** (4008,0109) *)
  val interpretation_transcriber : int32
  (** (4008,010A) *)
  val interpretation_text : int32
  (** (4008,010B) *)
  val interpretation_author : int32
  (** (4008,010C) *)
  val interpretation_approver_sequence : int32
  (** (4008,0111) *)
  val interpretation_approval_date : int32
  (** (4008,0112) *)
  val interpretation_approval_time : int32
  (** (4008,0113) *)
  val physician_approving_interpretation : int32
  (** (4008,0114) *)
  val interpretation_diagnosis_description : int32
  (** (4008,0115) *)
  val interpretation_diagnosis_code_sequence : int32
  (** (4008,0117) *)
  val results_distribution_list_sequence : int32
  (** (4008,0118) *)
  val distribution_name : int32
  (** (4008,0119) *)
  val distribution_address : int32
  (** (4008,011A) *)
  val interpretation_id : int32
  (** (4008,0200) *)
  val interpretation_id_issuer : int32
  (** (4008,0202) *)
  val interpretation_type_id : int32
  (** (4008,0210) *)
  val interpretation_status_id : int32
  (** (4008,0212) *)
  val impressions : int32
  (** (4008,0300) *)
  val results_comments : int32
  (** (4008,4000) *)
  val low_energy_detectors : int32
  (** (4010,0001) *)
  val high_energy_detectors : int32
  (** (4010,0002) *)
  val detector_geometry_sequence : int32
  (** (4010,0004) *)
  val threat_roi_voxel_sequence : int32
  (** (4010,1001) *)
  val threat_roi_base : int32
  (** (4010,1004) *)
  val threat_roi_extents : int32
  (** (4010,1005) *)
  val threat_roi_bitmap : int32
  (** (4010,1006) *)
  val route_segment_id : int32
  (** (4010,1007) *)
  val gantry_type : int32
  (** (4010,1008) *)
  val ooi_owner_type : int32
  (** (4010,1009) *)
  val route_segment_sequence : int32
  (** (4010,100A) *)
  val potential_threat_object_id : int32
  (** (4010,1010) *)
  val threat_sequence : int32
  (** (4010,1011) *)
  val threat_category : int32
  (** (4010,1012) *)
  val threat_category_description : int32
  (** (4010,1013) *)
  val atd_ability_assessment : int32
  (** (4010,1014) *)
  val atd_assessment_flag : int32
  (** (4010,1015) *)
  val atd_assessment_probability : int32
  (** (4010,1016) *)
  val mass : int32
  (** (4010,1017) *)
  val density : int32
  (** (4010,1018) *)
  val z_effective : int32
  (** (4010,1019) *)
  val boarding_pass_id : int32
  (** (4010,101A) *)
  val center_of_mass : int32
  (** (4010,101B) *)
  val center_of_pto : int32
  (** (4010,101C) *)
  val bounding_polygon : int32
  (** (4010,101D) *)
  val route_segment_start_location_id : int32
  (** (4010,101E) *)
  val route_segment_end_location_id : int32
  (** (4010,101F) *)
  val route_segment_location_id_type : int32
  (** (4010,1020) *)
  val abort_reason : int32
  (** (4010,1021) *)
  val volume_of_pto : int32
  (** (4010,1023) *)
  val abort_flag : int32
  (** (4010,1024) *)
  val route_segment_start_time : int32
  (** (4010,1025) *)
  val route_segment_end_time : int32
  (** (4010,1026) *)
  val tdr_type : int32
  (** (4010,1027) *)
  val international_route_segment : int32
  (** (4010,1028) *)
  val threat_detection_algorithmand_version : int32
  (** (4010,1029) *)
  val assigned_location : int32
  (** (4010,102A) *)
  val alarm_decision_time : int32
  (** (4010,102B) *)
  val alarm_decision : int32
  (** (4010,1031) *)
  val number_of_total_objects : int32
  (** (4010,1033) *)
  val number_of_alarm_objects : int32
  (** (4010,1034) *)
  val pto_representation_sequence : int32
  (** (4010,1037) *)
  val atd_assessment_sequence : int32
  (** (4010,1038) *)
  val tip_type : int32
  (** (4010,1039) *)
  val dicos_version : int32
  (** (4010,103A) *)
  val ooi_owner_creation_time : int32
  (** (4010,1041) *)
  val ooi_type : int32
  (** (4010,1042) *)
  val ooi_size : int32
  (** (4010,1043) *)
  val acquisition_status : int32
  (** (4010,1044) *)
  val basis_materials_code_sequence : int32
  (** (4010,1045) *)
  val phantom_type : int32
  (** (4010,1046) *)
  val ooi_owner_sequence : int32
  (** (4010,1047) *)
  val scan_type : int32
  (** (4010,1048) *)
  val itinerary_id : int32
  (** (4010,1051) *)
  val itinerary_id_type : int32
  (** (4010,1052) *)
  val itinerary_id_assigning_authority : int32
  (** (4010,1053) *)
  val route_id : int32
  (** (4010,1054) *)
  val route_id_assigning_authority : int32
  (** (4010,1055) *)
  val inbound_arrival_type : int32
  (** (4010,1056) *)
  val carrier_id : int32
  (** (4010,1058) *)
  val carrier_id_assigning_authority : int32
  (** (4010,1059) *)
  val source_orientation : int32
  (** (4010,1060) *)
  val source_position : int32
  (** (4010,1061) *)
  val belt_height : int32
  (** (4010,1062) *)
  val algorithm_routing_code_sequence : int32
  (** (4010,1064) *)
  val transport_classification : int32
  (** (4010,1067) *)
  val ooi_type_descriptor : int32
  (** (4010,1068) *)
  val total_processing_time : int32
  (** (4010,1069) *)
  val detector_calibration_data : int32
  (** (4010,106C) *)
  val macparameterssequence : int32
  (** (4FFE,0001) *)
  val curve_dimensions : int32
  (** (5000,0005) *)
  val number_of_points : int32
  (** (5000,0010) *)
  val type_of_data : int32
  (** (5000,0020) *)
  val curve_description : int32
  (** (5000,0022) *)
  val axis_units : int32
  (** (5000,0030) *)
  val axis_labels : int32
  (** (5000,0040) *)
  val data_value_representation : int32
  (** (5000,0103) *)
  val minimum_coordinate_value : int32
  (** (5000,0104) *)
  val maximum_coordinate_value : int32
  (** (5000,0105) *)
  val curve_range : int32
  (** (5000,0106) *)
  val curve_data_descriptor : int32
  (** (5000,0110) *)
  val coordinate_start_value : int32
  (** (5000,0112) *)
  val coordinate_step_value : int32
  (** (5000,0114) *)
  val curve_activation_layer : int32
  (** (5000,1001) *)
  val audio_type : int32
  (** (5000,2000) *)
  val audio_sample_format : int32
  (** (5000,2002) *)
  val number_of_channels : int32
  (** (5000,2004) *)
  val number_of_samples : int32
  (** (5000,2006) *)
  val sample_rate : int32
  (** (5000,2008) *)
  val total_time : int32
  (** (5000,200A) *)
  val audio_sample_data : int32
  (** (5000,200C) *)
  val audio_comments : int32
  (** (5000,200E) *)
  val curve_label : int32
  (** (5000,2500) *)
  val curve_referenced_overlay_sequence : int32
  (** (5000,2600) *)
  val curve_referenced_overlay_group : int32
  (** (5000,2610) *)
  val curve_data : int32
  (** (5000,3000) *)
  val shared_functional_groups_sequence : int32
  (** (5200,9229) *)
  val per_frame_functional_groups_sequence : int32
  (** (5200,9230) *)
  val waveform_sequence : int32
  (** (5400,0100) *)
  val channel_minimum_value : int32
  (** (5400,0110) *)
  val channel_maximum_value : int32
  (** (5400,0112) *)
  val waveform_bits_allocated : int32
  (** (5400,1004) *)
  val waveform_sample_interpretation : int32
  (** (5400,1006) *)
  val waveform_padding_value : int32
  (** (5400,100A) *)
  val waveform_data : int32
  (** (5400,1010) *)
  val first_order_phase_correction_angle : int32
  (** (5600,0010) *)
  val spectroscopy_data : int32
  (** (5600,0020) *)
  val overlay_rows : int32
  (** (6000,0010) *)
  val overlay_columns : int32
  (** (6000,0011) *)
  val overlay_planes : int32
  (** (6000,0012) *)
  val number_of_frames_in_overlay : int32
  (** (6000,0015) *)
  val overlay_description : int32
  (** (6000,0022) *)
  val overlay_type : int32
  (** (6000,0040) *)
  val overlay_subtype : int32
  (** (6000,0045) *)
  val overlay_origin : int32
  (** (6000,0050) *)
  val image_frame_origin : int32
  (** (6000,0051) *)
  val overlay_plane_origin : int32
  (** (6000,0052) *)
  val overlay_compression_code : int32
  (** (6000,0060) *)
  val overlay_compression_originator : int32
  (** (6000,0061) *)
  val overlay_compression_label : int32
  (** (6000,0062) *)
  val overlay_compression_description : int32
  (** (6000,0063) *)
  val overlay_compression_step_pointers : int32
  (** (6000,0066) *)
  val overlay_repeat_interval : int32
  (** (6000,0068) *)
  val overlay_bits_grouped : int32
  (** (6000,0069) *)
  val overlay_bits_allocated : int32
  (** (6000,0100) *)
  val overlay_bit_position : int32
  (** (6000,0102) *)
  val overlay_format : int32
  (** (6000,0110) *)
  val overlay_location : int32
  (** (6000,0200) *)
  val overlay_code_label : int32
  (** (6000,0800) *)
  val overlay_number_of_tables : int32
  (** (6000,0802) *)
  val overlay_code_table_location : int32
  (** (6000,0803) *)
  val overlay_bits_for_code_word : int32
  (** (6000,0804) *)
  val overlay_activation_layer : int32
  (** (6000,1001) *)
  val overlay_descriptor_gray : int32
  (** (6000,1100) *)
  val overlay_descriptor_red : int32
  (** (6000,1101) *)
  val overlay_descriptor_green : int32
  (** (6000,1102) *)
  val overlay_descriptor_blue : int32
  (** (6000,1103) *)
  val overlays_gray : int32
  (** (6000,1200) *)
  val overlays_red : int32
  (** (6000,1201) *)
  val overlays_green : int32
  (** (6000,1202) *)
  val overlays_blue : int32
  (** (6000,1203) *)
  val roi_area : int32
  (** (6000,1301) *)
  val roi_mean : int32
  (** (6000,1302) *)
  val roi_standard_deviation : int32
  (** (6000,1303) *)
  val overlay_label : int32
  (** (6000,1500) *)
  val overlay_data : int32
  (** (6000,3000) *)
  val overlay_comments : int32
  (** (6000,4000) *)
  val pixel_data : int32
  (** (7FE0,0010) *)
  val coefficients_sdvn : int32
  (** (7FE0,0020) *)
  val coefficients_sdhn : int32
  (** (7FE0,0030) *)
  val coefficients_sddn : int32
  (** (7FE0,0040) *)
  val variable_pixel_data : int32
  (** (7F00,0010) *)
  val variable_next_data_group : int32
  (** (7F00,0011) *)
  val variable_coefficients_sdvn : int32
  (** (7F00,0020) *)
  val variable_coefficients_sdhn : int32
  (** (7F00,0030) *)
  val variable_coefficients_sddn : int32
  (** (7F00,0040) *)
  val digital_signatures_sequence : int32
  (** (FFFA,FFFA) *)
  val data_set_trailing_padding : int32
  (** (FFFC,FFFC) *)
end

(*---------------------------------------------------------------------------
   Copyright (c) 2014 Daniel C. Bünzli

   Permission to use, copy, modify, and/or distribute this software for any
   purpose with or without fee is hereby granted, provided that the above
   copyright notice and this permission notice appear in all copies.

   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
   WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
   MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
   ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  ---------------------------------------------------------------------------*)
