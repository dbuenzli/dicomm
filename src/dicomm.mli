(*---------------------------------------------------------------------------
   Copyright (c) 2014 Daniel C. Bünzli. All rights reserved.
   Distributed under the BSD3 license, see license at the end of the file.
   %%NAME%% release %%VERSION%%
  ---------------------------------------------------------------------------*)

(** Non-blocking streaming DICOM data element decoder. 

    [Dicomm] is a non-blocking streaming decoder to
    {{!section:decode}decode} DICOM data elements.

    Consult the {{!model}data model}, {{!props}features and limitations} and 
    {{!examples}examples} of use. 
    
    {e Release %%VERSION%% — %%MAINTAINER%% }
    {3 References}
    {ul 
    {- NEMA.
    {e {{:http://medical.nema.org/standard.html}
        The DICOM Standard}}, 2011.}} *)

(** {1:model Data model} *) 

type syntax = [ `File | `LE_explicit | `BE_explicit | `LE_implicit ]
(** The type for transfer syntaxes. See {!decoder}. *)

type vr = 
  [ `AE | `AS | `AT | `CS | `DA | `DS | `DT | `FL | `FD | `IS | `LO | `LT 
  | `OB | `OF | `OW | `PN | `SH | `SL | `SQ | `SS | `ST | `TM | `UI | `UL 
  | `UN | `US | `UT ]
(** The type for value representations. *) 

val pp_vr : Format.formatter -> vr -> unit
(** [pp_vr ppf vr] prints an unspecified representation of [vr] on [ppf]. *)


type tag 
(** The type for data elements tags. *) 

(** Data elements tags and data dictionary. 

    The data dictionary information is as found in 
    {{:http://medical.nema.org/Dicom/2011/11_06pu.pdf}PS 3.6 2011} §6,7,8. *) 
module Tag : sig

  (** {1 Tags} *) 

  type t = tag
  (** The type for data elements tags. *) 

  val group : tag -> int 
  (** [group t] is [t]'s group number. *) 

  val element : tag -> int 
  (** [group t] is [t]'s element number. *) 

  val of_group_element : int -> int -> tag
  (** [of_group_element g e] is a tag from the group [g] and the element
      [e]. *) 

  val name : tag -> string option
  (** [name t] is the name of the data element with tag [t]. *) 

  val keyword : tag -> string option 
  (** [keyword t] is the keyword of the data element with tag [t]. *) 

  val vr : tag -> 
    [ vr | `OB_or_OW | `US_or_SS | `US_or_OW | `US_or_SS_or_OW ] option
  (** [vr t] is the value representation of the data element with tag [t]. *)

  val vm : tag ->
    [ `One | `One_2 | `One_3 | `One_8 | `One_32 | `One_99 | `One_n 
    | `Two | `Two_n | `Two_2n | `Three | `Three_n | `Three_3n 
    | `Four | `Six | `Six_n | `Nine | `Sixteen ] option
  (** [vm t] is the value multiplicity of the data element with tag [t]. *) 

  val retired : tag -> bool option
  (** [retired t] is [true] if the data element with tag [t] is retired
      by the standard. *) 

  val equal : tag -> tag -> bool 
  (** [equal t t'] is [true] if [t] and [t'] are equal. *)

  val compare : tag -> tag -> int 
  (** [compare t t'] orders [t] and [t'] first by group and then 
      by element both in integer order. *) 

  val pp : Format.formatter -> t -> unit
  (** [pp ppf t] prints an unspecified representation of [t] on [ppf]. *) 

  (** {1 Constants} *) 

  val command_group_length : tag
  (** (0000,0000) *)
  val affected_sop_class_uid : tag
  (** (0000,0002) *)
  val requested_sopclass_uid : tag
  (** (0000,0003) *)
  val command_field : tag
  (** (0000,0100) *)
  val message_id : tag
  (** (0000,0110) *)
  val message_id_being_responded_to : tag
  (** (0000,0120) *)
  val move_destination : tag
  (** (0000,0600) *)
  val priority : tag
  (** (0000,0700) *)
  val command_data_set_type : tag
  (** (0000,0800) *)
  val status : tag
  (** (0000,0900) *)
  val offending_element : tag
  (** (0000,0901) *)
  val error_comment : tag
  (** (0000,0902) *)
  val error_id : tag
  (** (0000,0903) *)
  val affected_sop_instance_uid : tag
  (** (0000,1000) *)
  val requested_sop_instance_uid : tag
  (** (0000,1001) *)
  val event_type_id : tag
  (** (0000,1002) *)
  val attribute_identifier_list : tag
  (** (0000,1005) *)
  val action_type_id : tag
  (** (0000,1008) *)
  val number_of_remaining_suboperations : tag
  (** (0000,1020) *)
  val number_of_completed_suboperations : tag
  (** (0000,1021) *)
  val number_of_failed_suboperations : tag
  (** (0000,1022) *)
  val number_of_warning_suboperations : tag
  (** (0000,1023) *)
  val move_originator_application_entity_title : tag
  (** (0000,1030) *)
  val move_originator_message_id : tag
  (** (0000,1031) *)
  val command_length_to_end : tag
  (** (0000,0001) *)
  val command_recognition_code : tag
  (** (0000,0010) *)
  val initiator : tag
  (** (0000,0200) *)
  val receiver : tag
  (** (0000,0300) *)
  val find_location : tag
  (** (0000,0400) *)
  val number_of_matches : tag
  (** (0000,0850) *)
  val response_sequence_number : tag
  (** (0000,0860) *)
  val dialog_receiver : tag
  (** (0000,4000) *)
  val terminal_type : tag
  (** (0000,4010) *)
  val message_set_id : tag
  (** (0000,5010) *)
  val end_message_id : tag
  (** (0000,5020) *)
  val display_format : tag
  (** (0000,5110) *)
  val page_position_id : tag
  (** (0000,5120) *)
  val text_format_id : tag
  (** (0000,5130) *)
  val normal_reverse : tag
  (** (0000,5140) *)
  val add_gray_scale : tag
  (** (0000,5150) *)
  val borders : tag
  (** (0000,5160) *)
  val copies : tag
  (** (0000,5170) *)
  val command_magnification_type : tag
  (** (0000,5180) *)
  val erase : tag
  (** (0000,5190) *)
  val print : tag
  (** (0000,51a0) *)
  val overlays : tag
  (** (0000,51b0) *)
  val file_meta_information_group_length : tag
  (** (0002,0000) *)
  val file_meta_information_version : tag
  (** (0002,0001) *)
  val media_storage_sop_class_uid : tag
  (** (0002,0002) *)
  val media_storage_sop_instance_uid : tag
  (** (0002,0003) *)
  val transfer_syntax_uid : tag
  (** (0002,0010) *)
  val implementation_class_uid : tag
  (** (0002,0012) *)
  val implementation_version_name : tag
  (** (0002,0013) *)
  val source_application_entity_title : tag
  (** (0002,0016) *)
  val private_information_creator_uid : tag
  (** (0002,0100) *)
  val private_information : tag
  (** (0002,0102) *)
  val file_set_id : tag
  (** (0004,1130) *)
  val file_set_descriptor_file_id : tag
  (** (0004,1141) *)
  val specific_character_set_of_file_set_descriptor_file : tag
  (** (0004,1142) *)
  val offset_of_the_first_directory_record_of_the_root_directory_entity : tag
  (** (0004,1200) *)
  val offset_of_the_last_directory_record_of_the_root_directory_entity : tag
  (** (0004,1202) *)
  val file_set_consistency_flag : tag
  (** (0004,1212) *)
  val directory_record_sequence : tag
  (** (0004,1220) *)
  val offset_of_the_next_directory_record : tag
  (** (0004,1400) *)
  val record_in_use_flag : tag
  (** (0004,1410) *)
  val offset_of_referenced_lower_level_directory_entity : tag
  (** (0004,1420) *)
  val directory_record_type : tag
  (** (0004,1430) *)
  val private_record_uid : tag
  (** (0004,1432) *)
  val referenced_file_id : tag
  (** (0004,1500) *)
  val mrdr_directory_record_offset : tag
  (** (0004,1504) *)
  val referenced_sop_class_uid_in_file : tag
  (** (0004,1510) *)
  val referenced_sop_instance_uid_in_file : tag
  (** (0004,1511) *)
  val referenced_transfer_syntax_uid_in_file : tag
  (** (0004,1512) *)
  val referenced_related_general_sop_class_uid_in_file : tag
  (** (0004,151a) *)
  val number_of_references : tag
  (** (0004,1600) *)
  val length_to_end : tag
  (** (0008,0001) *)
  val specific_character_set : tag
  (** (0008,0005) *)
  val language_code_sequence : tag
  (** (0008,0006) *)
  val image_type : tag
  (** (0008,0008) *)
  val recognition_code : tag
  (** (0008,0010) *)
  val instance_creation_date : tag
  (** (0008,0012) *)
  val instance_creation_time : tag
  (** (0008,0013) *)
  val instance_creator_uid : tag
  (** (0008,0014) *)
  val sop_class_uid : tag
  (** (0008,0016) *)
  val sop_instance_uid : tag
  (** (0008,0018) *)
  val related_general_sop_class_uid : tag
  (** (0008,001a) *)
  val original_specialized_sop_class_uid : tag
  (** (0008,001b) *)
  val study_date : tag
  (** (0008,0020) *)
  val series_date : tag
  (** (0008,0021) *)
  val acquisition_date : tag
  (** (0008,0022) *)
  val content_date : tag
  (** (0008,0023) *)
  val overlay_date : tag
  (** (0008,0024) *)
  val curve_date : tag
  (** (0008,0025) *)
  val acquisition_date_time : tag
  (** (0008,002a) *)
  val study_time : tag
  (** (0008,0030) *)
  val series_time : tag
  (** (0008,0031) *)
  val acquisition_time : tag
  (** (0008,0032) *)
  val content_time : tag
  (** (0008,0033) *)
  val overlay_time : tag
  (** (0008,0034) *)
  val curve_time : tag
  (** (0008,0035) *)
  val data_set_type : tag
  (** (0008,0040) *)
  val data_set_subtype : tag
  (** (0008,0041) *)
  val nuclear_medicine_series_type : tag
  (** (0008,0042) *)
  val accession_number : tag
  (** (0008,0050) *)
  val issuer_of_accession_number_sequence : tag
  (** (0008,0051) *)
  val query_retrieve_level : tag
  (** (0008,0052) *)
  val retrieve_ae_title : tag
  (** (0008,0054) *)
  val instance_availability : tag
  (** (0008,0056) *)
  val failed_sop_instance_uid_list : tag
  (** (0008,0058) *)
  val modality : tag
  (** (0008,0060) *)
  val modalities_in_study : tag
  (** (0008,0061) *)
  val sop_classes_in_study : tag
  (** (0008,0062) *)
  val conversion_type : tag
  (** (0008,0064) *)
  val presentation_intent_type : tag
  (** (0008,0068) *)
  val manufacturer : tag
  (** (0008,0070) *)
  val institution_name : tag
  (** (0008,0080) *)
  val institution_address : tag
  (** (0008,0081) *)
  val institution_code_sequence : tag
  (** (0008,0082) *)
  val referring_physician_name : tag
  (** (0008,0090) *)
  val referring_physician_address : tag
  (** (0008,0092) *)
  val referring_physician_telephone_numbers : tag
  (** (0008,0094) *)
  val referring_physician_identification_sequence : tag
  (** (0008,0096) *)
  val code_value : tag
  (** (0008,0100) *)
  val coding_scheme_designator : tag
  (** (0008,0102) *)
  val coding_scheme_version : tag
  (** (0008,0103) *)
  val code_meaning : tag
  (** (0008,0104) *)
  val mapping_resource : tag
  (** (0008,0105) *)
  val context_group_version : tag
  (** (0008,0106) *)
  val context_group_local_version : tag
  (** (0008,0107) *)
  val context_group_extension_flag : tag
  (** (0008,010b) *)
  val coding_scheme_uid : tag
  (** (0008,010c) *)
  val context_group_extension_creator_uid : tag
  (** (0008,010d) *)
  val context_identifier : tag
  (** (0008,010f) *)
  val coding_scheme_identification_sequence : tag
  (** (0008,0110) *)
  val coding_scheme_registry : tag
  (** (0008,0112) *)
  val coding_scheme_external_id : tag
  (** (0008,0114) *)
  val coding_scheme_name : tag
  (** (0008,0115) *)
  val coding_scheme_responsible_organization : tag
  (** (0008,0116) *)
  val context_uid : tag
  (** (0008,0117) *)
  val timezone_offset_from_utc : tag
  (** (0008,0201) *)
  val network_id : tag
  (** (0008,1000) *)
  val station_name : tag
  (** (0008,1010) *)
  val study_description : tag
  (** (0008,1030) *)
  val procedure_code_sequence : tag
  (** (0008,1032) *)
  val series_description : tag
  (** (0008,103e) *)
  val series_description_code_sequence : tag
  (** (0008,103f) *)
  val institutional_department_name : tag
  (** (0008,1040) *)
  val physicians_of_record : tag
  (** (0008,1048) *)
  val physicians_of_record_identification_sequence : tag
  (** (0008,1049) *)
  val performing_physician_name : tag
  (** (0008,1050) *)
  val performing_physician_identification_sequence : tag
  (** (0008,1052) *)
  val name_of_physicians_reading_study : tag
  (** (0008,1060) *)
  val physicians_reading_study_identification_sequence : tag
  (** (0008,1062) *)
  val operators_name : tag
  (** (0008,1070) *)
  val operator_identification_sequence : tag
  (** (0008,1072) *)
  val admitting_diagnoses_description : tag
  (** (0008,1080) *)
  val admitting_diagnoses_code_sequence : tag
  (** (0008,1084) *)
  val manufacturer_model_name : tag
  (** (0008,1090) *)
  val referenced_results_sequence : tag
  (** (0008,1100) *)
  val referenced_study_sequence : tag
  (** (0008,1110) *)
  val referenced_performed_procedure_step_sequence : tag
  (** (0008,1111) *)
  val referenced_series_sequence : tag
  (** (0008,1115) *)
  val referenced_patient_sequence : tag
  (** (0008,1120) *)
  val referenced_visit_sequence : tag
  (** (0008,1125) *)
  val referenced_overlay_sequence : tag
  (** (0008,1130) *)
  val referenced_stereometric_instance_sequence : tag
  (** (0008,1134) *)
  val referenced_waveform_sequence : tag
  (** (0008,113a) *)
  val referenced_image_sequence : tag
  (** (0008,1140) *)
  val referenced_curve_sequence : tag
  (** (0008,1145) *)
  val referenced_instance_sequence : tag
  (** (0008,114a) *)
  val referenced_real_world_value_mapping_instance_sequence : tag
  (** (0008,114b) *)
  val referenced_sop_class_uid : tag
  (** (0008,1150) *)
  val referenced_sop_instance_uid : tag
  (** (0008,1155) *)
  val sop_classes_supported : tag
  (** (0008,115a) *)
  val referenced_frame_number : tag
  (** (0008,1160) *)
  val simple_frame_list : tag
  (** (0008,1161) *)
  val calculated_frame_list : tag
  (** (0008,1162) *)
  val time_range : tag
  (** (0008,1163) *)
  val frame_extraction_sequence : tag
  (** (0008,1164) *)
  val multi_frame_source_sop_instance_uid : tag
  (** (0008,1167) *)
  val transaction_uid : tag
  (** (0008,1195) *)
  val failure_reason : tag
  (** (0008,1197) *)
  val failed_sop_sequence : tag
  (** (0008,1198) *)
  val referenced_sop_sequence : tag
  (** (0008,1199) *)
  val studies_containing_other_referenced_instances_sequence : tag
  (** (0008,1200) *)
  val related_series_sequence : tag
  (** (0008,1250) *)
  val lossy_image_compression_retired : tag
  (** (0008,2110) *)
  val derivation_description : tag
  (** (0008,2111) *)
  val source_image_sequence : tag
  (** (0008,2112) *)
  val stage_name : tag
  (** (0008,2120) *)
  val stage_number : tag
  (** (0008,2122) *)
  val number_of_stages : tag
  (** (0008,2124) *)
  val view_name : tag
  (** (0008,2127) *)
  val view_number : tag
  (** (0008,2128) *)
  val number_of_event_timers : tag
  (** (0008,2129) *)
  val number_of_views_in_stage : tag
  (** (0008,212a) *)
  val event_elapsed_times : tag
  (** (0008,2130) *)
  val event_timer_names : tag
  (** (0008,2132) *)
  val event_timer_sequence : tag
  (** (0008,2133) *)
  val event_time_offset : tag
  (** (0008,2134) *)
  val event_code_sequence : tag
  (** (0008,2135) *)
  val start_trim : tag
  (** (0008,2142) *)
  val stop_trim : tag
  (** (0008,2143) *)
  val recommended_display_frame_rate : tag
  (** (0008,2144) *)
  val transducer_position : tag
  (** (0008,2200) *)
  val transducer_orientation : tag
  (** (0008,2204) *)
  val anatomic_structure : tag
  (** (0008,2208) *)
  val anatomic_region_sequence : tag
  (** (0008,2218) *)
  val anatomic_region_modifier_sequence : tag
  (** (0008,2220) *)
  val primary_anatomic_structure_sequence : tag
  (** (0008,2228) *)
  val anatomic_structure_space_or_region_sequence : tag
  (** (0008,2229) *)
  val primary_anatomic_structure_modifier_sequence : tag
  (** (0008,2230) *)
  val transducer_position_sequence : tag
  (** (0008,2240) *)
  val transducer_position_modifier_sequence : tag
  (** (0008,2242) *)
  val transducer_orientation_sequence : tag
  (** (0008,2244) *)
  val transducer_orientation_modifier_sequence : tag
  (** (0008,2246) *)
  val anatomic_structure_space_or_region_code_sequence_trial : tag
  (** (0008,2251) *)
  val anatomic_portal_of_entrance_code_sequence_trial : tag
  (** (0008,2253) *)
  val anatomic_approach_direction_code_sequence_trial : tag
  (** (0008,2255) *)
  val anatomic_perspective_description_trial : tag
  (** (0008,2256) *)
  val anatomic_perspective_code_sequence_trial : tag
  (** (0008,2257) *)
  val anatomic_location_of_examining_instrument_description_trial : tag
  (** (0008,2258) *)
  val anatomic_location_of_examining_instrument_code_sequence_trial : tag
  (** (0008,2259) *)
  val anatomic_structure_space_or_region_modifier_code_sequence_trial : tag
  (** (0008,225A) *)
  val on_axis_background_anatomic_structure_code_sequence_trial : tag
  (** (0008,225C) *)
  val alternate_representation_sequence : tag
  (** (0008,3001) *)
  val irradiation_event_uid : tag
  (** (0008,3010) *)
  val identifying_comments : tag
  (** (0008,4000) *)
  val frame_type : tag
  (** (0008,9007) *)
  val referenced_image_evidence_sequence : tag
  (** (0008,9092) *)
  val referenced_raw_data_sequence : tag
  (** (0008,9121) *)
  val creator_version_uid : tag
  (** (0008,9123) *)
  val derivation_image_sequence : tag
  (** (0008,9124) *)
  val source_image_evidence_sequence : tag
  (** (0008,9154) *)
  val pixel_presentation : tag
  (** (0008,9205) *)
  val volumetric_properties : tag
  (** (0008,9206) *)
  val volume_based_calculation_technique : tag
  (** (0008,9207) *)
  val complex_image_component : tag
  (** (0008,9208) *)
  val acquisition_contrast : tag
  (** (0008,9209) *)
  val derivation_code_sequence : tag
  (** (0008,9215) *)
  val referenced_presentation_state_sequence : tag
  (** (0008,9237) *)
  val referenced_other_plane_sequence : tag
  (** (0008,9410) *)
  val frame_display_sequence : tag
  (** (0008,9458) *)
  val recommended_display_frame_rate_in_float : tag
  (** (0008,9459) *)
  val skip_frame_range_flag : tag
  (** (0008,9460) *)
  val patient_name : tag
  (** (0010,0010) *)
  val patient_id : tag
  (** (0010,0020) *)
  val issuer_of_patient_id : tag
  (** (0010,0021) *)
  val type_of_patient_id : tag
  (** (0010,0022) *)
  val issuer_of_patient_id_qualifiers_sequence : tag
  (** (0010,0024) *)
  val patient_birth_date : tag
  (** (0010,0030) *)
  val patient_birth_time : tag
  (** (0010,0032) *)
  val patient_sex : tag
  (** (0010,0040) *)
  val patient_insurance_plan_code_sequence : tag
  (** (0010,0050) *)
  val patient_primary_language_code_sequence : tag
  (** (0010,0101) *)
  val patient_primary_language_modifier_code_sequence : tag
  (** (0010,0102) *)
  val other_patient_ids : tag
  (** (0010,1000) *)
  val other_patient_names : tag
  (** (0010,1001) *)
  val other_patient_ids_sequence : tag
  (** (0010,1002) *)
  val patient_birth_name : tag
  (** (0010,1005) *)
  val patient_age : tag
  (** (0010,1010) *)
  val patient_size : tag
  (** (0010,1020) *)
  val patient_size_code_sequence : tag
  (** (0010,1021) *)
  val patient_weight : tag
  (** (0010,1030) *)
  val patient_address : tag
  (** (0010,1040) *)
  val insurance_plan_identification : tag
  (** (0010,1050) *)
  val patient_mother_birth_name : tag
  (** (0010,1060) *)
  val military_rank : tag
  (** (0010,1080) *)
  val branch_of_service : tag
  (** (0010,1081) *)
  val medical_record_locator : tag
  (** (0010,1090) *)
  val medical_alerts : tag
  (** (0010,2000) *)
  val allergies : tag
  (** (0010,2110) *)
  val country_of_residence : tag
  (** (0010,2150) *)
  val region_of_residence : tag
  (** (0010,2152) *)
  val patient_telephone_numbers : tag
  (** (0010,2154) *)
  val ethnic_group : tag
  (** (0010,2160) *)
  val occupation : tag
  (** (0010,2180) *)
  val smoking_status : tag
  (** (0010,21A0) *)
  val additional_patient_history : tag
  (** (0010,21B0) *)
  val pregnancy_status : tag
  (** (0010,21C0) *)
  val last_menstrual_date : tag
  (** (0010,21D0) *)
  val patient_religious_preference : tag
  (** (0010,21F0) *)
  val patient_species_description : tag
  (** (0010,2201) *)
  val patient_species_code_sequence : tag
  (** (0010,2202) *)
  val patient_sex_neutered : tag
  (** (0010,2203) *)
  val anatomical_orientation_type : tag
  (** (0010,2210) *)
  val patient_breed_description : tag
  (** (0010,2292) *)
  val patient_breed_code_sequence : tag
  (** (0010,2293) *)
  val breed_registration_sequence : tag
  (** (0010,2294) *)
  val breed_registration_number : tag
  (** (0010,2295) *)
  val breed_registry_code_sequence : tag
  (** (0010,2296) *)
  val responsible_person : tag
  (** (0010,2297) *)
  val responsible_person_role : tag
  (** (0010,2298) *)
  val responsible_organization : tag
  (** (0010,2299) *)
  val patient_comments : tag
  (** (0010,4000) *)
  val examined_body_thickness : tag
  (** (0010,9431) *)
  val clinical_trial_sponsor_name : tag
  (** (0012,0010) *)
  val clinical_trial_protocol_id : tag
  (** (0012,0020) *)
  val clinical_trial_protocol_name : tag
  (** (0012,0021) *)
  val clinical_trial_site_id : tag
  (** (0012,0030) *)
  val clinical_trial_site_name : tag
  (** (0012,0031) *)
  val clinical_trial_subject_id : tag
  (** (0012,0040) *)
  val clinical_trial_subject_reading_id : tag
  (** (0012,0042) *)
  val clinical_trial_time_point_id : tag
  (** (0012,0050) *)
  val clinical_trial_time_point_description : tag
  (** (0012,0051) *)
  val clinical_trial_coordinating_center_name : tag
  (** (0012,0060) *)
  val patient_identity_removed : tag
  (** (0012,0062) *)
  val deidentification_method : tag
  (** (0012,0063) *)
  val deidentification_method_code_sequence : tag
  (** (0012,0064) *)
  val clinical_trial_series_id : tag
  (** (0012,0071) *)
  val clinical_trial_series_description : tag
  (** (0012,0072) *)
  val clinical_trial_protocol_ethics_committee_name : tag
  (** (0012,0081) *)
  val clinical_trial_protocol_ethics_committee_approval_number : tag
  (** (0012,0082) *)
  val consent_for_clinical_trial_use_sequence : tag
  (** (0012,0083) *)
  val distribution_type : tag
  (** (0012,0084) *)
  val consent_for_distribution_flag : tag
  (** (0012,0085) *)
  val cad_file_format : tag
  (** (0014,0023) *)
  val component_reference_system : tag
  (** (0014,0024) *)
  val component_manufacturing_procedure : tag
  (** (0014,0025) *)
  val component_manufacturer : tag
  (** (0014,0028) *)
  val material_thickness : tag
  (** (0014,0030) *)
  val material_pipe_diameter : tag
  (** (0014,0032) *)
  val material_isolation_diameter : tag
  (** (0014,0034) *)
  val material_grade : tag
  (** (0014,0042) *)
  val material_properties_file_id : tag
  (** (0014,0044) *)
  val material_properties_file_format : tag
  (** (0014,0045) *)
  val material_notes : tag
  (** (0014,0046) *)
  val component_shape : tag
  (** (0014,0050) *)
  val curvature_type : tag
  (** (0014,0052) *)
  val outer_diameter : tag
  (** (0014,0054) *)
  val inner_diameter : tag
  (** (0014,0056) *)
  val actual_environmental_conditions : tag
  (** (0014,1010) *)
  val expiry_date : tag
  (** (0014,1020) *)
  val environmental_conditions : tag
  (** (0014,1040) *)
  val evaluator_sequence : tag
  (** (0014,2002) *)
  val evaluator_number : tag
  (** (0014,2004) *)
  val evaluator_name : tag
  (** (0014,2006) *)
  val evaluation_attempt : tag
  (** (0014,2008) *)
  val indication_sequence : tag
  (** (0014,2012) *)
  val indication_number : tag
  (** (0014,2014) *)
  val indication_label : tag
  (** (0014,2016) *)
  val indication_description : tag
  (** (0014,2018) *)
  val indication_type : tag
  (** (0014,201A) *)
  val indication_disposition : tag
  (** (0014,201C) *)
  val indication_roisequence : tag
  (** (0014,201E) *)
  val indication_physical_property_sequence : tag
  (** (0014,2030) *)
  val property_label : tag
  (** (0014,2032) *)
  val coordinate_system_number_of_axes : tag
  (** (0014,2202) *)
  val coordinate_system_axes_sequence : tag
  (** (0014,2204) *)
  val coordinate_system_axis_description : tag
  (** (0014,2206) *)
  val coordinate_system_data_set_mapping : tag
  (** (0014,2208) *)
  val coordinate_system_axis_number : tag
  (** (0014,220A) *)
  val coordinate_system_axis_type : tag
  (** (0014,220C) *)
  val coordinate_system_axis_units : tag
  (** (0014,220E) *)
  val coordinate_system_axis_values : tag
  (** (0014,2210) *)
  val coordinate_system_transform_sequence : tag
  (** (0014,2220) *)
  val transform_description : tag
  (** (0014,2222) *)
  val transform_number_of_axes : tag
  (** (0014,2224) *)
  val transform_order_of_axes : tag
  (** (0014,2226) *)
  val transformed_axis_units : tag
  (** (0014,2228) *)
  val coordinate_system_transform_rotation_and_scale_matrix : tag
  (** (0014,222A) *)
  val coordinate_system_transform_translation_matrix : tag
  (** (0014,222C) *)
  val internal_detector_frame_time : tag
  (** (0014,3011) *)
  val number_of_frames_integrated : tag
  (** (0014,3012) *)
  val detector_temperature_sequence : tag
  (** (0014,3020) *)
  val sensor_name : tag
  (** (0014,3022) *)
  val horizontal_offset_of_sensor : tag
  (** (0014,3024) *)
  val vertical_offset_of_sensor : tag
  (** (0014,3026) *)
  val sensor_temperature : tag
  (** (0014,3028) *)
  val dark_current_sequence : tag
  (** (0014,3040) *)
  val dark_current_counts : tag
  (** (0014,3050) *)
  val gain_correction_reference_sequence : tag
  (** (0014,3060) *)
  val air_counts : tag
  (** (0014,3070) *)
  val kv_used_in_gain_calibration : tag
  (** (0014,3071) *)
  val ma_used_in_gain_calibration : tag
  (** (0014,3072) *)
  val number_of_frames_used_for_integration : tag
  (** (0014,3073) *)
  val filter_material_used_in_gain_calibration : tag
  (** (0014,3074) *)
  val filter_thickness_used_in_gain_calibration : tag
  (** (0014,3075) *)
  val date_of_gain_calibration : tag
  (** (0014,3076) *)
  val time_of_gain_calibration : tag
  (** (0014,3077) *)
  val bad_pixel_image : tag
  (** (0014,3080) *)
  val calibration_notes : tag
  (** (0014,3099) *)
  val pulser_equipment_sequence : tag
  (** (0014,4002) *)
  val pulser_type : tag
  (** (0014,4004) *)
  val pulser_notes : tag
  (** (0014,4006) *)
  val receiver_equipment_sequence : tag
  (** (0014,4008) *)
  val amplifier_type : tag
  (** (0014,400A) *)
  val receiver_notes : tag
  (** (0014,400C) *)
  val pre_amplifier_equipment_sequence : tag
  (** (0014,400E) *)
  val pre_amplifier_notes : tag
  (** (0014,400F) *)
  val transmit_transducer_sequence : tag
  (** (0014,4010) *)
  val receive_transducer_sequence : tag
  (** (0014,4011) *)
  val number_of_elements : tag
  (** (0014,4012) *)
  val element_shape : tag
  (** (0014,4013) *)
  val element_dimension_a : tag
  (** (0014,4014) *)
  val element_dimension_b : tag
  (** (0014,4015) *)
  val element_pitch : tag
  (** (0014,4016) *)
  val measured_beam_dimension_a : tag
  (** (0014,4017) *)
  val measured_beam_dimension_b : tag
  (** (0014,4018) *)
  val location_of_measured_beam_diameter : tag
  (** (0014,4019) *)
  val nominal_frequency : tag
  (** (0014,401A) *)
  val measured_center_frequency : tag
  (** (0014,401B) *)
  val measured_bandwidth : tag
  (** (0014,401C) *)
  val pulser_settings_sequence : tag
  (** (0014,4020) *)
  val pulse_width : tag
  (** (0014,4022) *)
  val excitation_frequency : tag
  (** (0014,4024) *)
  val modulation_type : tag
  (** (0014,4026) *)
  val damping : tag
  (** (0014,4028) *)
  val receiver_settings_sequence : tag
  (** (0014,4030) *)
  val acquired_soundpath_length : tag
  (** (0014,4031) *)
  val acquisition_compression_type : tag
  (** (0014,4032) *)
  val acquisition_sample_size : tag
  (** (0014,4033) *)
  val rectifier_smoothing : tag
  (** (0014,4034) *)
  val dacsequence : tag
  (** (0014,4035) *)
  val dactype : tag
  (** (0014,4036) *)
  val dacgainpoints : tag
  (** (0014,4038) *)
  val dactimepoints : tag
  (** (0014,403A) *)
  val dacamplitude : tag
  (** (0014,403C) *)
  val pre_amplifier_settings_sequence : tag
  (** (0014,4040) *)
  val transmit_transducer_settings_sequence : tag
  (** (0014,4050) *)
  val receive_transducer_settings_sequence : tag
  (** (0014,4051) *)
  val incident_angle : tag
  (** (0014,4052) *)
  val coupling_technique : tag
  (** (0014,4054) *)
  val coupling_medium : tag
  (** (0014,4056) *)
  val coupling_velocity : tag
  (** (0014,4057) *)
  val crystal_center_location_x : tag
  (** (0014,4058) *)
  val crystal_center_location_z : tag
  (** (0014,4059) *)
  val sound_path_length : tag
  (** (0014,405A) *)
  val delay_law_identifier : tag
  (** (0014,405C) *)
  val gate_settings_sequence : tag
  (** (0014,4060) *)
  val gate_threshold : tag
  (** (0014,4062) *)
  val velocity_of_sound : tag
  (** (0014,4064) *)
  val calibration_settings_sequence : tag
  (** (0014,4070) *)
  val calibration_procedure : tag
  (** (0014,4072) *)
  val procedure_version : tag
  (** (0014,4074) *)
  val procedure_creation_date : tag
  (** (0014,4076) *)
  val procedure_expiration_date : tag
  (** (0014,4078) *)
  val procedure_last_modified_date : tag
  (** (0014,407A) *)
  val calibration_time : tag
  (** (0014,407C) *)
  val calibration_date : tag
  (** (0014,407E) *)
  val linacenergy : tag
  (** (0014,5002) *)
  val linacoutput : tag
  (** (0014,5004) *)
  val contrast_bolus_agent : tag
  (** (0018,0010) *)
  val contrast_bolus_agent_sequence : tag
  (** (0018,0012) *)
  val contrast_bolus_administration_route_sequence : tag
  (** (0018,0014) *)
  val body_part_examined : tag
  (** (0018,0015) *)
  val scanning_sequence : tag
  (** (0018,0020) *)
  val sequence_variant : tag
  (** (0018,0021) *)
  val scan_options : tag
  (** (0018,0022) *)
  val mr_acquisition_type : tag
  (** (0018,0023) *)
  val sequence_name : tag
  (** (0018,0024) *)
  val angio_flag : tag
  (** (0018,0025) *)
  val intervention_drug_information_sequence : tag
  (** (0018,0026) *)
  val intervention_drug_stop_time : tag
  (** (0018,0027) *)
  val intervention_drug_dose : tag
  (** (0018,0028) *)
  val intervention_drug_code_sequence : tag
  (** (0018,0029) *)
  val additional_drug_sequence : tag
  (** (0018,002A) *)
  val radionuclide : tag
  (** (0018,0030) *)
  val radiopharmaceutical : tag
  (** (0018,0031) *)
  val energy_window_centerline : tag
  (** (0018,0032) *)
  val energy_window_total_width : tag
  (** (0018,0033) *)
  val intervention_drug_name : tag
  (** (0018,0034) *)
  val intervention_drug_start_time : tag
  (** (0018,0035) *)
  val intervention_sequence : tag
  (** (0018,0036) *)
  val therapy_type : tag
  (** (0018,0037) *)
  val intervention_status : tag
  (** (0018,0038) *)
  val therapy_description : tag
  (** (0018,0039) *)
  val intervention_description : tag
  (** (0018,003A) *)
  val cine_rate : tag
  (** (0018,0040) *)
  val initial_cine_run_state : tag
  (** (0018,0042) *)
  val slice_thickness : tag
  (** (0018,0050) *)
  val kvp : tag
  (** (0018,0060) *)
  val counts_accumulated : tag
  (** (0018,0070) *)
  val acquisition_termination_condition : tag
  (** (0018,0071) *)
  val effective_duration : tag
  (** (0018,0072) *)
  val acquisition_start_condition : tag
  (** (0018,0073) *)
  val acquisition_start_condition_data : tag
  (** (0018,0074) *)
  val acquisition_termination_condition_data : tag
  (** (0018,0075) *)
  val repetition_time : tag
  (** (0018,0080) *)
  val echo_time : tag
  (** (0018,0081) *)
  val inversion_time : tag
  (** (0018,0082) *)
  val number_of_averages : tag
  (** (0018,0083) *)
  val imaging_frequency : tag
  (** (0018,0084) *)
  val imaged_nucleus : tag
  (** (0018,0085) *)
  val echo_numbers : tag
  (** (0018,0086) *)
  val magnetic_field_strength : tag
  (** (0018,0087) *)
  val spacing_between_slices : tag
  (** (0018,0088) *)
  val number_of_phase_encoding_steps : tag
  (** (0018,0089) *)
  val data_collection_diameter : tag
  (** (0018,0090) *)
  val echo_train_length : tag
  (** (0018,0091) *)
  val percent_sampling : tag
  (** (0018,0093) *)
  val percent_phase_field_of_view : tag
  (** (0018,0094) *)
  val pixel_bandwidth : tag
  (** (0018,0095) *)
  val device_serial_number : tag
  (** (0018,1000) *)
  val device_uid : tag
  (** (0018,1002) *)
  val device_id : tag
  (** (0018,1003) *)
  val plate_id : tag
  (** (0018,1004) *)
  val generator_id : tag
  (** (0018,1005) *)
  val grid_id : tag
  (** (0018,1006) *)
  val cassette_id : tag
  (** (0018,1007) *)
  val gantry_id : tag
  (** (0018,1008) *)
  val secondary_capture_device_id : tag
  (** (0018,1010) *)
  val hardcopy_creation_device_id : tag
  (** (0018,1011) *)
  val date_of_secondary_capture : tag
  (** (0018,1012) *)
  val time_of_secondary_capture : tag
  (** (0018,1014) *)
  val secondary_capture_device_manufacturer : tag
  (** (0018,1016) *)
  val hardcopy_device_manufacturer : tag
  (** (0018,1017) *)
  val secondary_capture_device_manufacturer_model_name : tag
  (** (0018,1018) *)
  val secondary_capture_device_software_versions : tag
  (** (0018,1019) *)
  val hardcopy_device_software_version : tag
  (** (0018,101A) *)
  val hardcopy_device_manufacturer_model_name : tag
  (** (0018,101B) *)
  val software_versions : tag
  (** (0018,1020) *)
  val video_image_format_acquired : tag
  (** (0018,1022) *)
  val digital_image_format_acquired : tag
  (** (0018,1023) *)
  val protocol_name : tag
  (** (0018,1030) *)
  val contrast_bolus_route : tag
  (** (0018,1040) *)
  val contrast_bolus_volume : tag
  (** (0018,1041) *)
  val contrast_bolus_start_time : tag
  (** (0018,1042) *)
  val contrast_bolus_stop_time : tag
  (** (0018,1043) *)
  val contrast_bolus_total_dose : tag
  (** (0018,1044) *)
  val syringe_counts : tag
  (** (0018,1045) *)
  val contrast_flow_rate : tag
  (** (0018,1046) *)
  val contrast_flow_duration : tag
  (** (0018,1047) *)
  val contrast_bolus_ingredient : tag
  (** (0018,1048) *)
  val contrast_bolus_ingredient_concentration : tag
  (** (0018,1049) *)
  val spatial_resolution : tag
  (** (0018,1050) *)
  val trigger_time : tag
  (** (0018,1060) *)
  val trigger_source_or_type : tag
  (** (0018,1061) *)
  val nominal_interval : tag
  (** (0018,1062) *)
  val frame_time : tag
  (** (0018,1063) *)
  val cardiac_framing_type : tag
  (** (0018,1064) *)
  val frame_time_vector : tag
  (** (0018,1065) *)
  val frame_delay : tag
  (** (0018,1066) *)
  val image_trigger_delay : tag
  (** (0018,1067) *)
  val multiplex_group_time_offset : tag
  (** (0018,1068) *)
  val trigger_time_offset : tag
  (** (0018,1069) *)
  val synchronization_trigger : tag
  (** (0018,106A) *)
  val synchronization_channel : tag
  (** (0018,106C) *)
  val trigger_sample_position : tag
  (** (0018,106E) *)
  val radiopharmaceutical_route : tag
  (** (0018,1070) *)
  val radiopharmaceutical_volume : tag
  (** (0018,1071) *)
  val radiopharmaceutical_start_time : tag
  (** (0018,1072) *)
  val radiopharmaceutical_stop_time : tag
  (** (0018,1073) *)
  val radionuclide_total_dose : tag
  (** (0018,1074) *)
  val radionuclide_half_life : tag
  (** (0018,1075) *)
  val radionuclide_positron_fraction : tag
  (** (0018,1076) *)
  val radiopharmaceutical_specific_activity : tag
  (** (0018,1077) *)
  val radiopharmaceutical_start_date_time : tag
  (** (0018,1078) *)
  val radiopharmaceutical_stop_date_time : tag
  (** (0018,1079) *)
  val beat_rejection_flag : tag
  (** (0018,1080) *)
  val low_rr_value : tag
  (** (0018,1081) *)
  val high_rr_value : tag
  (** (0018,1082) *)
  val intervals_acquired : tag
  (** (0018,1083) *)
  val intervals_rejected : tag
  (** (0018,1084) *)
  val p_vcrejection : tag
  (** (0018,1085) *)
  val skip_beats : tag
  (** (0018,1086) *)
  val heart_rate : tag
  (** (0018,1088) *)
  val cardiac_number_of_images : tag
  (** (0018,1090) *)
  val trigger_window : tag
  (** (0018,1094) *)
  val reconstruction_diameter : tag
  (** (0018,1100) *)
  val distance_source_to_detector : tag
  (** (0018,1110) *)
  val distance_source_to_patient : tag
  (** (0018,1111) *)
  val estimated_radiographic_magnification_factor : tag
  (** (0018,1114) *)
  val gantry_detector_tilt : tag
  (** (0018,1120) *)
  val gantry_detector_slew : tag
  (** (0018,1121) *)
  val table_height : tag
  (** (0018,1130) *)
  val table_traverse : tag
  (** (0018,1131) *)
  val table_motion : tag
  (** (0018,1134) *)
  val table_vertical_increment : tag
  (** (0018,1135) *)
  val table_lateral_increment : tag
  (** (0018,1136) *)
  val table_longitudinal_increment : tag
  (** (0018,1137) *)
  val table_angle : tag
  (** (0018,1138) *)
  val table_type : tag
  (** (0018,113A) *)
  val rotation_direction : tag
  (** (0018,1140) *)
  val angular_position : tag
  (** (0018,1141) *)
  val radial_position : tag
  (** (0018,1142) *)
  val scan_arc : tag
  (** (0018,1143) *)
  val angular_step : tag
  (** (0018,1144) *)
  val center_of_rotation_offset : tag
  (** (0018,1145) *)
  val rotation_offset : tag
  (** (0018,1146) *)
  val field_of_view_shape : tag
  (** (0018,1147) *)
  val field_of_view_dimensions : tag
  (** (0018,1149) *)
  val exposure_time : tag
  (** (0018,1150) *)
  val x_ray_tube_current : tag
  (** (0018,1151) *)
  val exposure : tag
  (** (0018,1152) *)
  val exposure_inu_as : tag
  (** (0018,1153) *)
  val average_pulse_width : tag
  (** (0018,1154) *)
  val radiation_setting : tag
  (** (0018,1155) *)
  val rectification_type : tag
  (** (0018,1156) *)
  val radiation_mode : tag
  (** (0018,115A) *)
  val image_and_fluoroscopy_area_dose_product : tag
  (** (0018,115E) *)
  val filter_type : tag
  (** (0018,1160) *)
  val type_of_filters : tag
  (** (0018,1161) *)
  val intensifier_size : tag
  (** (0018,1162) *)
  val imager_pixel_spacing : tag
  (** (0018,1164) *)
  val grid : tag
  (** (0018,1166) *)
  val generator_power : tag
  (** (0018,1170) *)
  val collimator_grid_name : tag
  (** (0018,1180) *)
  val collimator_type : tag
  (** (0018,1181) *)
  val focal_distance : tag
  (** (0018,1182) *)
  val x_focus_center : tag
  (** (0018,1183) *)
  val y_focus_center : tag
  (** (0018,1184) *)
  val focal_spots : tag
  (** (0018,1190) *)
  val anode_target_material : tag
  (** (0018,1191) *)
  val body_part_thickness : tag
  (** (0018,11A0) *)
  val compression_force : tag
  (** (0018,11A2) *)
  val date_of_last_calibration : tag
  (** (0018,1200) *)
  val time_of_last_calibration : tag
  (** (0018,1201) *)
  val convolution_kernel : tag
  (** (0018,1210) *)
  val upper_lower_pixel_values : tag
  (** (0018,1240) *)
  val actual_frame_duration : tag
  (** (0018,1242) *)
  val count_rate : tag
  (** (0018,1243) *)
  val preferred_playback_sequencing : tag
  (** (0018,1244) *)
  val receive_coil_name : tag
  (** (0018,1250) *)
  val transmit_coil_name : tag
  (** (0018,1251) *)
  val plate_type : tag
  (** (0018,1260) *)
  val phosphor_type : tag
  (** (0018,1261) *)
  val scan_velocity : tag
  (** (0018,1300) *)
  val whole_body_technique : tag
  (** (0018,1301) *)
  val scan_length : tag
  (** (0018,1302) *)
  val acquisition_matrix : tag
  (** (0018,1310) *)
  val in_plane_phase_encoding_direction : tag
  (** (0018,1312) *)
  val flip_angle : tag
  (** (0018,1314) *)
  val variable_flip_angle_flag : tag
  (** (0018,1315) *)
  val sat : tag
  (** (0018,1316) *)
  val dbdt : tag
  (** (0018,1318) *)
  val acquisition_device_processing_description : tag
  (** (0018,1400) *)
  val acquisition_device_processing_code : tag
  (** (0018,1401) *)
  val cassette_orientation : tag
  (** (0018,1402) *)
  val cassette_size : tag
  (** (0018,1403) *)
  val exposures_on_plate : tag
  (** (0018,1404) *)
  val relative_x_ray_exposure : tag
  (** (0018,1405) *)
  val exposure_index : tag
  (** (0018,1411) *)
  val target_exposure_index : tag
  (** (0018,1412) *)
  val deviation_index : tag
  (** (0018,1413) *)
  val column_angulation : tag
  (** (0018,1450) *)
  val tomo_layer_height : tag
  (** (0018,1460) *)
  val tomo_angle : tag
  (** (0018,1470) *)
  val tomo_time : tag
  (** (0018,1480) *)
  val tomo_type : tag
  (** (0018,1490) *)
  val tomo_class : tag
  (** (0018,1491) *)
  val number_of_tomosynthesis_source_images : tag
  (** (0018,1495) *)
  val positioner_motion : tag
  (** (0018,1500) *)
  val positioner_type : tag
  (** (0018,1508) *)
  val positioner_primary_angle : tag
  (** (0018,1510) *)
  val positioner_secondary_angle : tag
  (** (0018,1511) *)
  val positioner_primary_angle_increment : tag
  (** (0018,1520) *)
  val positioner_secondary_angle_increment : tag
  (** (0018,1521) *)
  val detector_primary_angle : tag
  (** (0018,1530) *)
  val detector_secondary_angle : tag
  (** (0018,1531) *)
  val shutter_shape : tag
  (** (0018,1600) *)
  val shutter_left_vertical_edge : tag
  (** (0018,1602) *)
  val shutter_right_vertical_edge : tag
  (** (0018,1604) *)
  val shutter_upper_horizontal_edge : tag
  (** (0018,1606) *)
  val shutter_lower_horizontal_edge : tag
  (** (0018,1608) *)
  val center_of_circular_shutter : tag
  (** (0018,1610) *)
  val radius_of_circular_shutter : tag
  (** (0018,1612) *)
  val vertices_of_the_polygonal_shutter : tag
  (** (0018,1620) *)
  val shutter_presentation_value : tag
  (** (0018,1622) *)
  val shutter_overlay_group : tag
  (** (0018,1623) *)
  val shutter_presentation_color_cielab_value : tag
  (** (0018,1624) *)
  val collimator_shape : tag
  (** (0018,1700) *)
  val collimator_left_vertical_edge : tag
  (** (0018,1702) *)
  val collimator_right_vertical_edge : tag
  (** (0018,1704) *)
  val collimator_upper_horizontal_edge : tag
  (** (0018,1706) *)
  val collimator_lower_horizontal_edge : tag
  (** (0018,1708) *)
  val center_of_circular_collimator : tag
  (** (0018,1710) *)
  val radius_of_circular_collimator : tag
  (** (0018,1712) *)
  val vertices_of_the_polygonal_collimator : tag
  (** (0018,1720) *)
  val acquisition_time_synchronized : tag
  (** (0018,1800) *)
  val time_source : tag
  (** (0018,1801) *)
  val time_distribution_protocol : tag
  (** (0018,1802) *)
  val ntp_source_address : tag
  (** (0018,1803) *)
  val page_number_vector : tag
  (** (0018,2001) *)
  val frame_label_vector : tag
  (** (0018,2002) *)
  val frame_primary_angle_vector : tag
  (** (0018,2003) *)
  val frame_secondary_angle_vector : tag
  (** (0018,2004) *)
  val slice_location_vector : tag
  (** (0018,2005) *)
  val display_window_label_vector : tag
  (** (0018,2006) *)
  val nominal_scanned_pixel_spacing : tag
  (** (0018,2010) *)
  val digitizing_device_transport_direction : tag
  (** (0018,2020) *)
  val rotation_of_scanned_film : tag
  (** (0018,2030) *)
  val ivus_acquisition : tag
  (** (0018,3100) *)
  val ivus_pullback_rate : tag
  (** (0018,3101) *)
  val ivus_gated_rate : tag
  (** (0018,3102) *)
  val ivus_pullback_start_frame_number : tag
  (** (0018,3103) *)
  val ivus_pullback_stop_frame_number : tag
  (** (0018,3104) *)
  val lesion_number : tag
  (** (0018,3105) *)
  val acquisition_comments : tag
  (** (0018,4000) *)
  val output_power : tag
  (** (0018,5000) *)
  val transducer_data : tag
  (** (0018,5010) *)
  val focus_depth : tag
  (** (0018,5012) *)
  val processing_function : tag
  (** (0018,5020) *)
  val postprocessing_function : tag
  (** (0018,5021) *)
  val mechanical_index : tag
  (** (0018,5022) *)
  val bone_thermal_index : tag
  (** (0018,5024) *)
  val cranial_thermal_index : tag
  (** (0018,5026) *)
  val soft_tissue_thermal_index : tag
  (** (0018,5027) *)
  val soft_tissue_focus_thermal_index : tag
  (** (0018,5028) *)
  val soft_tissue_surface_thermal_index : tag
  (** (0018,5029) *)
  val dynamic_range : tag
  (** (0018,5030) *)
  val total_gain : tag
  (** (0018,5040) *)
  val depth_of_scan_field : tag
  (** (0018,5050) *)
  val patient_position : tag
  (** (0018,5100) *)
  val view_position : tag
  (** (0018,5101) *)
  val projection_eponymous_name_code_sequence : tag
  (** (0018,5104) *)
  val image_transformation_matrix : tag
  (** (0018,5210) *)
  val image_translation_vector : tag
  (** (0018,5212) *)
  val sensitivity : tag
  (** (0018,6000) *)
  val sequence_of_ultrasound_regions : tag
  (** (0018,6011) *)
  val region_spatial_format : tag
  (** (0018,6012) *)
  val region_data_type : tag
  (** (0018,6014) *)
  val region_flags : tag
  (** (0018,6016) *)
  val region_location_min_x0 : tag
  (** (0018,6018) *)
  val region_location_min_y0 : tag
  (** (0018,601A) *)
  val region_location_max_x1 : tag
  (** (0018,601C) *)
  val region_location_max_y1 : tag
  (** (0018,601E) *)
  val reference_pixel_x0 : tag
  (** (0018,6020) *)
  val reference_pixel_y0 : tag
  (** (0018,6022) *)
  val physical_units_xdirection : tag
  (** (0018,6024) *)
  val physical_units_ydirection : tag
  (** (0018,6026) *)
  val reference_pixel_physical_value_x : tag
  (** (0018,6028) *)
  val reference_pixel_physical_value_y : tag
  (** (0018,602A) *)
  val physical_delta_x : tag
  (** (0018,602C) *)
  val physical_delta_y : tag
  (** (0018,602E) *)
  val transducer_frequency : tag
  (** (0018,6030) *)
  val transducer_type : tag
  (** (0018,6031) *)
  val pulse_repetition_frequency : tag
  (** (0018,6032) *)
  val doppler_correction_angle : tag
  (** (0018,6034) *)
  val steering_angle : tag
  (** (0018,6036) *)
  val doppler_sample_volume_xposition_retired : tag
  (** (0018,6038) *)
  val doppler_sample_volume_xposition : tag
  (** (0018,6039) *)
  val doppler_sample_volume_yposition_retired : tag
  (** (0018,603A) *)
  val doppler_sample_volume_yposition : tag
  (** (0018,603B) *)
  val tm_line_position_x0_retired : tag
  (** (0018,603C) *)
  val tm_line_position_x0 : tag
  (** (0018,603D) *)
  val tm_line_position_y0_retired : tag
  (** (0018,603E) *)
  val tm_line_position_y0 : tag
  (** (0018,603F) *)
  val tm_line_position_x1_retired : tag
  (** (0018,6040) *)
  val tm_line_position_x1 : tag
  (** (0018,6041) *)
  val tm_line_position_y1_retired : tag
  (** (0018,6042) *)
  val tm_line_position_y1 : tag
  (** (0018,6043) *)
  val pixel_component_organization : tag
  (** (0018,6044) *)
  val pixel_component_mask : tag
  (** (0018,6046) *)
  val pixel_component_range_start : tag
  (** (0018,6048) *)
  val pixel_component_range_stop : tag
  (** (0018,604A) *)
  val pixel_component_physical_units : tag
  (** (0018,604C) *)
  val pixel_component_data_type : tag
  (** (0018,604E) *)
  val number_of_table_break_points : tag
  (** (0018,6050) *)
  val table_of_xbreak_points : tag
  (** (0018,6052) *)
  val table_of_ybreak_points : tag
  (** (0018,6054) *)
  val number_of_table_entries : tag
  (** (0018,6056) *)
  val table_of_pixel_values : tag
  (** (0018,6058) *)
  val table_of_parameter_values : tag
  (** (0018,605A) *)
  val r_wave_time_vector : tag
  (** (0018,6060) *)
  val detector_conditions_nominal_flag : tag
  (** (0018,7000) *)
  val detector_temperature : tag
  (** (0018,7001) *)
  val detector_type : tag
  (** (0018,7004) *)
  val detector_configuration : tag
  (** (0018,7005) *)
  val detector_description : tag
  (** (0018,7006) *)
  val detector_mode : tag
  (** (0018,7008) *)
  val detector_id : tag
  (** (0018,700A) *)
  val date_of_last_detector_calibration : tag
  (** (0018,700C) *)
  val time_of_last_detector_calibration : tag
  (** (0018,700E) *)
  val exposures_on_detector_since_last_calibration : tag
  (** (0018,7010) *)
  val exposures_on_detector_since_manufactured : tag
  (** (0018,7011) *)
  val detector_time_since_last_exposure : tag
  (** (0018,7012) *)
  val detector_active_time : tag
  (** (0018,7014) *)
  val detector_activation_offset_from_exposure : tag
  (** (0018,7016) *)
  val detector_binning : tag
  (** (0018,701A) *)
  val detector_element_physical_size : tag
  (** (0018,7020) *)
  val detector_element_spacing : tag
  (** (0018,7022) *)
  val detector_active_shape : tag
  (** (0018,7024) *)
  val detector_active_dimensions : tag
  (** (0018,7026) *)
  val detector_active_origin : tag
  (** (0018,7028) *)
  val detector_manufacturer_name : tag
  (** (0018,702A) *)
  val detector_manufacturer_model_name : tag
  (** (0018,702B) *)
  val field_of_view_origin : tag
  (** (0018,7030) *)
  val field_of_view_rotation : tag
  (** (0018,7032) *)
  val field_of_view_horizontal_flip : tag
  (** (0018,7034) *)
  val pixel_data_area_origin_relative_to_fov : tag
  (** (0018,7036) *)
  val pixel_data_area_rotation_angle_relative_to_fov : tag
  (** (0018,7038) *)
  val grid_absorbing_material : tag
  (** (0018,7040) *)
  val grid_spacing_material : tag
  (** (0018,7041) *)
  val grid_thickness : tag
  (** (0018,7042) *)
  val grid_pitch : tag
  (** (0018,7044) *)
  val grid_aspect_ratio : tag
  (** (0018,7046) *)
  val grid_period : tag
  (** (0018,7048) *)
  val grid_focal_distance : tag
  (** (0018,704C) *)
  val filter_material : tag
  (** (0018,7050) *)
  val filter_thickness_minimum : tag
  (** (0018,7052) *)
  val filter_thickness_maximum : tag
  (** (0018,7054) *)
  val filter_beam_path_length_minimum : tag
  (** (0018,7056) *)
  val filter_beam_path_length_maximum : tag
  (** (0018,7058) *)
  val exposure_control_mode : tag
  (** (0018,7060) *)
  val exposure_control_mode_description : tag
  (** (0018,7062) *)
  val exposure_status : tag
  (** (0018,7064) *)
  val phototimer_setting : tag
  (** (0018,7065) *)
  val exposure_time_inu_s : tag
  (** (0018,8150) *)
  val x_ray_tube_current_inu_a : tag
  (** (0018,8151) *)
  val content_qualification : tag
  (** (0018,9004) *)
  val pulse_sequence_name : tag
  (** (0018,9005) *)
  val m_rimaging_modifier_sequence : tag
  (** (0018,9006) *)
  val echo_pulse_sequence : tag
  (** (0018,9008) *)
  val inversion_recovery : tag
  (** (0018,9009) *)
  val flow_compensation : tag
  (** (0018,9010) *)
  val multiple_spin_echo : tag
  (** (0018,9011) *)
  val multi_planar_excitation : tag
  (** (0018,9012) *)
  val phase_contrast : tag
  (** (0018,9014) *)
  val time_of_flight_contrast : tag
  (** (0018,9015) *)
  val spoiling : tag
  (** (0018,9016) *)
  val steady_state_pulse_sequence : tag
  (** (0018,9017) *)
  val echo_planar_pulse_sequence : tag
  (** (0018,9018) *)
  val tag_angle_first_axis : tag
  (** (0018,9019) *)
  val magnetization_transfer : tag
  (** (0018,9020) *)
  val t2_preparation : tag
  (** (0018,9021) *)
  val blood_signal_nulling : tag
  (** (0018,9022) *)
  val saturation_recovery : tag
  (** (0018,9024) *)
  val spectrally_selected_suppression : tag
  (** (0018,9025) *)
  val spectrally_selected_excitation : tag
  (** (0018,9026) *)
  val spatial_presaturation : tag
  (** (0018,9027) *)
  val tagging : tag
  (** (0018,9028) *)
  val oversampling_phase : tag
  (** (0018,9029) *)
  val tag_spacing_first_dimension : tag
  (** (0018,9030) *)
  val geometry_of_kspace_traversal : tag
  (** (0018,9032) *)
  val segmented_kspace_traversal : tag
  (** (0018,9033) *)
  val rectilinear_phase_encode_reordering : tag
  (** (0018,9034) *)
  val tag_thickness : tag
  (** (0018,9035) *)
  val partial_fourier_direction : tag
  (** (0018,9036) *)
  val cardiac_synchronization_technique : tag
  (** (0018,9037) *)
  val receive_coil_manufacturer_name : tag
  (** (0018,9041) *)
  val m_rreceive_coil_sequence : tag
  (** (0018,9042) *)
  val receive_coil_type : tag
  (** (0018,9043) *)
  val quadrature_receive_coil : tag
  (** (0018,9044) *)
  val multi_coil_definition_sequence : tag
  (** (0018,9045) *)
  val multi_coil_configuration : tag
  (** (0018,9046) *)
  val multi_coil_element_name : tag
  (** (0018,9047) *)
  val multi_coil_element_used : tag
  (** (0018,9048) *)
  val mr_transmit_coil_sequence : tag
  (** (0018,9049) *)
  val transmit_coil_manufacturer_name : tag
  (** (0018,9050) *)
  val transmit_coil_type : tag
  (** (0018,9051) *)
  val spectral_width : tag
  (** (0018,9052) *)
  val chemical_shift_reference : tag
  (** (0018,9053) *)
  val volume_localization_technique : tag
  (** (0018,9054) *)
  val mr_acquisition_frequency_encoding_steps : tag
  (** (0018,9058) *)
  val decoupling : tag
  (** (0018,9059) *)
  val decoupled_nucleus : tag
  (** (0018,9060) *)
  val decoupling_frequency : tag
  (** (0018,9061) *)
  val decoupling_method : tag
  (** (0018,9062) *)
  val decoupling_chemical_shift_reference : tag
  (** (0018,9063) *)
  val kspace_filtering : tag
  (** (0018,9064) *)
  val time_domain_filtering : tag
  (** (0018,9065) *)
  val number_of_zero_fills : tag
  (** (0018,9066) *)
  val baseline_correction : tag
  (** (0018,9067) *)
  val parallel_reduction_factor_in_plane : tag
  (** (0018,9069) *)
  val cardiac_rr_interval_specified : tag
  (** (0018,9070) *)
  val acquisition_duration : tag
  (** (0018,9073) *)
  val frame_acquisition_date_time : tag
  (** (0018,9074) *)
  val diffusion_directionality : tag
  (** (0018,9075) *)
  val diffusion_gradient_direction_sequence : tag
  (** (0018,9076) *)
  val parallel_acquisition : tag
  (** (0018,9077) *)
  val parallel_acquisition_technique : tag
  (** (0018,9078) *)
  val inversion_times : tag
  (** (0018,9079) *)
  val metabolite_map_description : tag
  (** (0018,9080) *)
  val partial_fourier : tag
  (** (0018,9081) *)
  val effective_echo_time : tag
  (** (0018,9082) *)
  val metabolite_map_code_sequence : tag
  (** (0018,9083) *)
  val chemical_shift_sequence : tag
  (** (0018,9084) *)
  val cardiac_signal_source : tag
  (** (0018,9085) *)
  val diffusion_bvalue : tag
  (** (0018,9087) *)
  val diffusion_gradient_orientation : tag
  (** (0018,9089) *)
  val velocity_encoding_direction : tag
  (** (0018,9090) *)
  val velocity_encoding_minimum_value : tag
  (** (0018,9091) *)
  val velocity_encoding_acquisition_sequence : tag
  (** (0018,9092) *)
  val number_of_kspace_trajectories : tag
  (** (0018,9093) *)
  val coverage_of_kspace : tag
  (** (0018,9094) *)
  val spectroscopy_acquisition_phase_rows : tag
  (** (0018,9095) *)
  val parallel_reduction_factor_in_plane_retired : tag
  (** (0018,9096) *)
  val transmitter_frequency : tag
  (** (0018,9098) *)
  val resonant_nucleus : tag
  (** (0018,9100) *)
  val frequency_correction : tag
  (** (0018,9101) *)
  val mr_spectroscopy_fovgeometry_sequence : tag
  (** (0018,9103) *)
  val slab_thickness : tag
  (** (0018,9104) *)
  val slab_orientation : tag
  (** (0018,9105) *)
  val mid_slab_position : tag
  (** (0018,9106) *)
  val mrspatialsaturationsequence : tag
  (** (0018,9107) *)
  val mrtimingandrelatedparameterssequence : tag
  (** (0018,9112) *)
  val mrechosequence : tag
  (** (0018,9114) *)
  val mrmodifiersequence : tag
  (** (0018,9115) *)
  val mrdiffusionsequence : tag
  (** (0018,9117) *)
  val cardiac_synchronization_sequence : tag
  (** (0018,9118) *)
  val mr_averages_sequence : tag
  (** (0018,9119) *)
  val mr_fovgeometry_sequence : tag
  (** (0018,9125) *)
  val volume_localization_sequence : tag
  (** (0018,9126) *)
  val spectroscopy_acquisition_data_columns : tag
  (** (0018,9127) *)
  val diffusion_anisotropy_type : tag
  (** (0018,9147) *)
  val frame_reference_date_time : tag
  (** (0018,9151) *)
  val mr_metabolite_map_sequence : tag
  (** (0018,9152) *)
  val parallel_reduction_factor_out_of_plane : tag
  (** (0018,9155) *)
  val spectroscopy_acquisition_out_of_plane_phase_steps : tag
  (** (0018,9159) *)
  val bulk_motion_status : tag
  (** (0018,9166) *)
  val parallel_reduction_factor_second_in_plane : tag
  (** (0018,9168) *)
  val cardiac_beat_rejection_technique : tag
  (** (0018,9169) *)
  val respiratory_motion_compensation_technique : tag
  (** (0018,9170) *)
  val respiratory_signal_source : tag
  (** (0018,9171) *)
  val bulk_motion_compensation_technique : tag
  (** (0018,9172) *)
  val bulk_motion_signal_source : tag
  (** (0018,9173) *)
  val applicable_safety_standard_agency : tag
  (** (0018,9174) *)
  val applicable_safety_standard_description : tag
  (** (0018,9175) *)
  val operating_mode_sequence : tag
  (** (0018,9176) *)
  val operating_mode_type : tag
  (** (0018,9177) *)
  val operating_mode : tag
  (** (0018,9178) *)
  val specific_absorption_rate_definition : tag
  (** (0018,9179) *)
  val gradient_output_type : tag
  (** (0018,9180) *)
  val specific_absorption_rate_value : tag
  (** (0018,9181) *)
  val gradient_output : tag
  (** (0018,9182) *)
  val flow_compensation_direction : tag
  (** (0018,9183) *)
  val tagging_delay : tag
  (** (0018,9184) *)
  val respiratory_motion_compensation_technique_description : tag
  (** (0018,9185) *)
  val respiratory_signal_source_id : tag
  (** (0018,9186) *)
  val chemical_shift_minimum_integration_limit_in_hz : tag
  (** (0018,9195) *)
  val chemical_shift_maximum_integration_limit_in_hz : tag
  (** (0018,9196) *)
  val mrvelocityencodingsequence : tag
  (** (0018,9197) *)
  val first_order_phase_correction : tag
  (** (0018,9198) *)
  val water_referenced_phase_correction : tag
  (** (0018,9199) *)
  val mr_spectroscopy_acquisition_type : tag
  (** (0018,9200) *)
  val respiratory_cycle_position : tag
  (** (0018,9214) *)
  val velocity_encoding_maximum_value : tag
  (** (0018,9217) *)
  val tag_spacing_second_dimension : tag
  (** (0018,9218) *)
  val tag_angle_second_axis : tag
  (** (0018,9219) *)
  val frame_acquisition_duration : tag
  (** (0018,9220) *)
  val mr_image_frame_type_sequence : tag
  (** (0018,9226) *)
  val mr_spectroscopy_frame_type_sequence : tag
  (** (0018,9227) *)
  val mr_acquisition_phase_encoding_steps_in_plane : tag
  (** (0018,9231) *)
  val mr_acquisition_phase_encoding_steps_out_of_plane : tag
  (** (0018,9232) *)
  val spectroscopy_acquisition_phase_columns : tag
  (** (0018,9234) *)
  val cardiac_cycle_position : tag
  (** (0018,9236) *)
  val specific_absorption_rate_sequence : tag
  (** (0018,9239) *)
  val rf_echo_train_length : tag
  (** (0018,9240) *)
  val gradient_echo_train_length : tag
  (** (0018,9241) *)
  val arterial_spin_labeling_contrast : tag
  (** (0018,9250) *)
  val mr_arterial_spin_labeling_sequence : tag
  (** (0018,9251) *)
  val asl_technique_description : tag
  (** (0018,9252) *)
  val asl_slab_number : tag
  (** (0018,9253) *)
  val asl_slab_thickness : tag
  (** (0018,9254) *)
  val asl_slab_orientation : tag
  (** (0018,9255) *)
  val asl_mid_slab_position : tag
  (** (0018,9256) *)
  val asl_context : tag
  (** (0018,9257) *)
  val asl_pulse_train_duration : tag
  (** (0018,9258) *)
  val asl_crusher_flag : tag
  (** (0018,9259) *)
  val asl_crusher_flow : tag
  (** (0018,925A) *)
  val asl_crusher_description : tag
  (** (0018,925B) *)
  val asl_bolus_cutoff_flag : tag
  (** (0018,925C) *)
  val asl_bolus_cutoff_timing_sequence : tag
  (** (0018,925D) *)
  val asl_bolus_cutoff_technique : tag
  (** (0018,925E) *)
  val asl_bolus_cutoff_delay_time : tag
  (** (0018,925F) *)
  val asl_slab_sequence : tag
  (** (0018,9260) *)
  val chemical_shift_minimum_integration_limit_inppm : tag
  (** (0018,9295) *)
  val chemical_shift_maximum_integration_limit_inppm : tag
  (** (0018,9296) *)
  val ct_acquisition_type_sequence : tag
  (** (0018,9301) *)
  val acquisition_type : tag
  (** (0018,9302) *)
  val tube_angle : tag
  (** (0018,9303) *)
  val ct_acquisition_details_sequence : tag
  (** (0018,9304) *)
  val revolution_time : tag
  (** (0018,9305) *)
  val single_collimation_width : tag
  (** (0018,9306) *)
  val total_collimation_width : tag
  (** (0018,9307) *)
  val ct_table_dynamics_sequence : tag
  (** (0018,9308) *)
  val table_speed : tag
  (** (0018,9309) *)
  val table_feed_per_rotation : tag
  (** (0018,9310) *)
  val spiral_pitch_factor : tag
  (** (0018,9311) *)
  val ct_geometry_sequence : tag
  (** (0018,9312) *)
  val data_collection_center_patient : tag
  (** (0018,9313) *)
  val ct_reconstruction_sequence : tag
  (** (0018,9314) *)
  val reconstruction_algorithm : tag
  (** (0018,9315) *)
  val convolution_kernel_group : tag
  (** (0018,9316) *)
  val reconstruction_field_of_view : tag
  (** (0018,9317) *)
  val reconstruction_target_center_patient : tag
  (** (0018,9318) *)
  val reconstruction_angle : tag
  (** (0018,9319) *)
  val image_filter : tag
  (** (0018,9320) *)
  val ct_exposure_sequence : tag
  (** (0018,9321) *)
  val reconstruction_pixel_spacing : tag
  (** (0018,9322) *)
  val exposure_modulation_type : tag
  (** (0018,9323) *)
  val estimated_dose_saving : tag
  (** (0018,9324) *)
  val ct_x_ray_details_sequence : tag
  (** (0018,9325) *)
  val ct_position_sequence : tag
  (** (0018,9326) *)
  val table_position : tag
  (** (0018,9327) *)
  val exposure_time_inms : tag
  (** (0018,9328) *)
  val ct_image_frame_type_sequence : tag
  (** (0018,9329) *)
  val x_ray_tube_current_inm_a : tag
  (** (0018,9330) *)
  val exposure_inm_as : tag
  (** (0018,9332) *)
  val constant_volume_flag : tag
  (** (0018,9333) *)
  val fluoroscopy_flag : tag
  (** (0018,9334) *)
  val distance_source_to_data_collection_center : tag
  (** (0018,9335) *)
  val contrast_bolus_agent_number : tag
  (** (0018,9337) *)
  val contrast_bolus_ingredient_code_sequence : tag
  (** (0018,9338) *)
  val contrast_administration_profile_sequence : tag
  (** (0018,9340) *)
  val contrast_bolus_usage_sequence : tag
  (** (0018,9341) *)
  val contrast_bolus_agent_administered : tag
  (** (0018,9342) *)
  val contrast_bolus_agent_detected : tag
  (** (0018,9343) *)
  val contrast_bolus_agent_phase : tag
  (** (0018,9344) *)
  val ctdi_vol : tag
  (** (0018,9345) *)
  val ctdi_phantom_type_code_sequence : tag
  (** (0018,9346) *)
  val calcium_scoring_mass_factor_patient : tag
  (** (0018,9351) *)
  val calcium_scoring_mass_factor_device : tag
  (** (0018,9352) *)
  val energy_weighting_factor : tag
  (** (0018,9353) *)
  val ct_additional_xray_source_sequence : tag
  (** (0018,9360) *)
  val projection_pixel_calibration_sequence : tag
  (** (0018,9401) *)
  val distance_source_to_isocenter : tag
  (** (0018,9402) *)
  val distance_object_to_table_top : tag
  (** (0018,9403) *)
  val object_pixel_spacing_in_center_of_beam : tag
  (** (0018,9404) *)
  val positioner_position_sequence : tag
  (** (0018,9405) *)
  val table_position_sequence : tag
  (** (0018,9406) *)
  val collimator_shape_sequence : tag
  (** (0018,9407) *)
  val planes_in_acquisition : tag
  (** (0018,9410) *)
  val xaxrf_frame_characteristics_sequence : tag
  (** (0018,9412) *)
  val frame_acquisition_sequence : tag
  (** (0018,9417) *)
  val x_ray_receptor_type : tag
  (** (0018,9420) *)
  val acquisition_protocol_name : tag
  (** (0018,9423) *)
  val acquisition_protocol_description : tag
  (** (0018,9424) *)
  val contrast_bolus_ingredient_opaque : tag
  (** (0018,9425) *)
  val distance_receptor_plane_to_detector_housing : tag
  (** (0018,9426) *)
  val intensifier_active_shape : tag
  (** (0018,9427) *)
  val intensifier_active_dimensions : tag
  (** (0018,9428) *)
  val physical_detector_size : tag
  (** (0018,9429) *)
  val position_of_isocenter_projection : tag
  (** (0018,9430) *)
  val field_of_view_sequence : tag
  (** (0018,9432) *)
  val field_of_view_description : tag
  (** (0018,9433) *)
  val exposure_control_sensing_regions_sequence : tag
  (** (0018,9434) *)
  val exposure_control_sensing_region_shape : tag
  (** (0018,9435) *)
  val exposure_control_sensing_region_left_vertical_edge : tag
  (** (0018,9436) *)
  val exposure_control_sensing_region_right_vertical_edge : tag
  (** (0018,9437) *)
  val exposure_control_sensing_region_upper_horizontal_edge : tag
  (** (0018,9438) *)
  val exposure_control_sensing_region_lower_horizontal_edge : tag
  (** (0018,9439) *)
  val center_of_circular_exposure_control_sensing_region : tag
  (** (0018,9440) *)
  val radius_of_circular_exposure_control_sensing_region : tag
  (** (0018,9441) *)
  val vertices_of_the_polygonal_exposure_control_sensing_region : tag
  (** (0018,9442) *)
  val column_angulation_patient : tag
  (** (0018,9447) *)
  val beam_angle : tag
  (** (0018,9449) *)
  val frame_detector_parameters_sequence : tag
  (** (0018,9451) *)
  val calculated_anatomy_thickness : tag
  (** (0018,9452) *)
  val calibration_sequence : tag
  (** (0018,9455) *)
  val object_thickness_sequence : tag
  (** (0018,9456) *)
  val plane_identification : tag
  (** (0018,9457) *)
  val field_of_view_dimensions_in_float : tag
  (** (0018,9461) *)
  val isocenter_reference_system_sequence : tag
  (** (0018,9462) *)
  val positioner_isocenter_primary_angle : tag
  (** (0018,9463) *)
  val positioner_isocenter_secondary_angle : tag
  (** (0018,9464) *)
  val positioner_isocenter_detector_rotation_angle : tag
  (** (0018,9465) *)
  val table_xposition_to_isocenter : tag
  (** (0018,9466) *)
  val table_yposition_to_isocenter : tag
  (** (0018,9467) *)
  val table_zposition_to_isocenter : tag
  (** (0018,9468) *)
  val table_horizontal_rotation_angle : tag
  (** (0018,9469) *)
  val table_head_tilt_angle : tag
  (** (0018,9470) *)
  val table_cradle_tilt_angle : tag
  (** (0018,9471) *)
  val frame_display_shutter_sequence : tag
  (** (0018,9472) *)
  val acquired_image_area_dose_product : tag
  (** (0018,9473) *)
  val c_arm_positioner_tabletop_relationship : tag
  (** (0018,9474) *)
  val x_ray_geometry_sequence : tag
  (** (0018,9476) *)
  val irradiation_event_identification_sequence : tag
  (** (0018,9477) *)
  val x_ray_3d_frame_type_sequence : tag
  (** (0018,9504) *)
  val contributing_sources_sequence : tag
  (** (0018,9506) *)
  val x_ray_3d_acquisition_sequence : tag
  (** (0018,9507) *)
  val primary_positioner_scan_arc : tag
  (** (0018,9508) *)
  val secondary_positioner_scan_arc : tag
  (** (0018,9509) *)
  val primary_positioner_scan_start_angle : tag
  (** (0018,9510) *)
  val secondary_positioner_scan_start_angle : tag
  (** (0018,9511) *)
  val primary_positioner_increment : tag
  (** (0018,9514) *)
  val secondary_positioner_increment : tag
  (** (0018,9515) *)
  val start_acquisition_date_time : tag
  (** (0018,9516) *)
  val end_acquisition_date_time : tag
  (** (0018,9517) *)
  val application_name : tag
  (** (0018,9524) *)
  val application_version : tag
  (** (0018,9525) *)
  val application_manufacturer : tag
  (** (0018,9526) *)
  val algorithm_type : tag
  (** (0018,9527) *)
  val algorithm_description : tag
  (** (0018,9528) *)
  val x_ray_3dreconstruction_sequence : tag
  (** (0018,9530) *)
  val reconstruction_description : tag
  (** (0018,9531) *)
  val per_projection_acquisition_sequence : tag
  (** (0018,9538) *)
  val diffusion_bmatrix_sequence : tag
  (** (0018,9601) *)
  val diffusion_b_value_xx : tag
  (** (0018,9602) *)
  val diffusion_b_value_xy : tag
  (** (0018,9603) *)
  val diffusion_b_value_xz : tag
  (** (0018,9604) *)
  val diffusion_b_value_yy : tag
  (** (0018,9605) *)
  val diffusion_b_value_yz : tag
  (** (0018,9606) *)
  val diffusion_b_value_zz : tag
  (** (0018,9607) *)
  val decay_correction_date_time : tag
  (** (0018,9701) *)
  val start_density_threshold : tag
  (** (0018,9715) *)
  val start_relative_density_difference_threshold : tag
  (** (0018,9716) *)
  val start_cardiac_trigger_count_threshold : tag
  (** (0018,9717) *)
  val start_respiratory_trigger_count_threshold : tag
  (** (0018,9718) *)
  val termination_counts_threshold : tag
  (** (0018,9719) *)
  val termination_density_threshold : tag
  (** (0018,9720) *)
  val termination_relative_density_threshold : tag
  (** (0018,9721) *)
  val termination_time_threshold : tag
  (** (0018,9722) *)
  val termination_cardiac_trigger_count_threshold : tag
  (** (0018,9723) *)
  val termination_respiratory_trigger_count_threshold : tag
  (** (0018,9724) *)
  val detector_geometry : tag
  (** (0018,9725) *)
  val transverse_detector_separation : tag
  (** (0018,9726) *)
  val axial_detector_dimension : tag
  (** (0018,9727) *)
  val radiopharmaceutical_agent_number : tag
  (** (0018,9729) *)
  val pet_frame_acquisition_sequence : tag
  (** (0018,9732) *)
  val pet_detector_motion_details_sequence : tag
  (** (0018,9733) *)
  val pettabledynamicssequence : tag
  (** (0018,9734) *)
  val petpositionsequence : tag
  (** (0018,9735) *)
  val petframecorrectionfactorssequence : tag
  (** (0018,9736) *)
  val radiopharmaceutical_usage_sequence : tag
  (** (0018,9737) *)
  val attenuation_correction_source : tag
  (** (0018,9738) *)
  val number_of_iterations : tag
  (** (0018,9739) *)
  val number_of_subsets : tag
  (** (0018,9740) *)
  val pet_reconstruction_sequence : tag
  (** (0018,9749) *)
  val pet_frame_type_sequence : tag
  (** (0018,9751) *)
  val time_of_flight_information_used : tag
  (** (0018,9755) *)
  val reconstruction_type : tag
  (** (0018,9756) *)
  val decay_corrected : tag
  (** (0018,9758) *)
  val attenuation_corrected : tag
  (** (0018,9759) *)
  val scatter_corrected : tag
  (** (0018,9760) *)
  val dead_time_corrected : tag
  (** (0018,9761) *)
  val gantry_motion_corrected : tag
  (** (0018,9762) *)
  val patient_motion_corrected : tag
  (** (0018,9763) *)
  val count_loss_normalization_corrected : tag
  (** (0018,9764) *)
  val randoms_corrected : tag
  (** (0018,9765) *)
  val non_uniform_radial_sampling_corrected : tag
  (** (0018,9766) *)
  val sensitivity_calibrated : tag
  (** (0018,9767) *)
  val detector_normalization_correction : tag
  (** (0018,9768) *)
  val iterative_reconstruction_method : tag
  (** (0018,9769) *)
  val attenuation_correction_temporal_relationship : tag
  (** (0018,9770) *)
  val patient_physiological_state_sequence : tag
  (** (0018,9771) *)
  val patient_physiological_state_code_sequence : tag
  (** (0018,9772) *)
  val depths_of_focus : tag
  (** (0018,9801) *)
  val excluded_intervals_sequence : tag
  (** (0018,9803) *)
  val exclusion_start_datetime : tag
  (** (0018,9804) *)
  val exclusion_duration : tag
  (** (0018,9805) *)
  val u_simage_description_sequence : tag
  (** (0018,9806) *)
  val image_data_type_sequence : tag
  (** (0018,9807) *)
  val data_type : tag
  (** (0018,9808) *)
  val transducer_scan_pattern_code_sequence : tag
  (** (0018,9809) *)
  val aliased_data_type : tag
  (** (0018,980B) *)
  val position_measuring_device_used : tag
  (** (0018,980C) *)
  val transducer_geometry_code_sequence : tag
  (** (0018,980D) *)
  val transducer_beam_steering_code_sequence : tag
  (** (0018,980E) *)
  val transducer_application_code_sequence : tag
  (** (0018,980F) *)
  val contributing_equipment_sequence : tag
  (** (0018,A001) *)
  val contribution_date_time : tag
  (** (0018,A002) *)
  val contribution_description : tag
  (** (0018,A003) *)
  val study_instance_uid : tag
  (** (0020,000D) *)
  val series_instance_uid : tag
  (** (0020,000E) *)
  val study_id : tag
  (** (0020,0010) *)
  val series_number : tag
  (** (0020,0011) *)
  val acquisition_number : tag
  (** (0020,0012) *)
  val instance_number : tag
  (** (0020,0013) *)
  val isotope_number : tag
  (** (0020,0014) *)
  val phase_number : tag
  (** (0020,0015) *)
  val interval_number : tag
  (** (0020,0016) *)
  val time_slot_number : tag
  (** (0020,0017) *)
  val angle_number : tag
  (** (0020,0018) *)
  val item_number : tag
  (** (0020,0019) *)
  val patient_orientation : tag
  (** (0020,0020) *)
  val overlay_number : tag
  (** (0020,0022) *)
  val curve_number : tag
  (** (0020,0024) *)
  val lut_number : tag
  (** (0020,0026) *)
  val image_position : tag
  (** (0020,0030) *)
  val image_position_patient : tag
  (** (0020,0032) *)
  val image_orientation : tag
  (** (0020,0035) *)
  val image_orientation_patient : tag
  (** (0020,0037) *)
  val location : tag
  (** (0020,0050) *)
  val frame_of_reference_uid : tag
  (** (0020,0052) *)
  val laterality : tag
  (** (0020,0060) *)
  val image_laterality : tag
  (** (0020,0062) *)
  val image_geometry_type : tag
  (** (0020,0070) *)
  val masking_image : tag
  (** (0020,0080) *)
  val report_number : tag
  (** (0020,00AA) *)
  val temporal_position_identifier : tag
  (** (0020,0100) *)
  val number_of_temporal_positions : tag
  (** (0020,0105) *)
  val temporal_resolution : tag
  (** (0020,0110) *)
  val synchronization_frame_of_reference_uid : tag
  (** (0020,0200) *)
  val sop_instance_uidofconcatenationsource : tag
  (** (0020,0242) *)
  val series_in_study : tag
  (** (0020,1000) *)
  val acquisitions_in_series : tag
  (** (0020,1001) *)
  val images_in_acquisition : tag
  (** (0020,1002) *)
  val images_in_series : tag
  (** (0020,1003) *)
  val acquisitions_in_study : tag
  (** (0020,1004) *)
  val images_in_study : tag
  (** (0020,1005) *)
  val reference : tag
  (** (0020,1020) *)
  val position_reference_indicator : tag
  (** (0020,1040) *)
  val slice_location : tag
  (** (0020,1041) *)
  val other_study_numbers : tag
  (** (0020,1070) *)
  val number_of_patient_related_studies : tag
  (** (0020,1200) *)
  val number_of_patient_related_series : tag
  (** (0020,1202) *)
  val number_of_patient_related_instances : tag
  (** (0020,1204) *)
  val number_of_study_related_series : tag
  (** (0020,1206) *)
  val number_of_study_related_instances : tag
  (** (0020,1208) *)
  val number_of_series_related_instances : tag
  (** (0020,1209) *)
  val source_image_ids : tag
  (** (0020,3100) *)
  val modifying_device_id : tag
  (** (0020,3401) *)
  val modified_image_id : tag
  (** (0020,3402) *)
  val modified_image_date : tag
  (** (0020,3403) *)
  val modifying_device_manufacturer : tag
  (** (0020,3404) *)
  val modified_image_time : tag
  (** (0020,3405) *)
  val modified_image_description : tag
  (** (0020,3406) *)
  val image_comments : tag
  (** (0020,4000) *)
  val original_image_identification : tag
  (** (0020,5000) *)
  val original_image_identification_nomenclature : tag
  (** (0020,5002) *)
  val stack_id : tag
  (** (0020,9056) *)
  val in_stack_position_number : tag
  (** (0020,9057) *)
  val frame_anatomy_sequence : tag
  (** (0020,9071) *)
  val frame_laterality : tag
  (** (0020,9072) *)
  val frame_content_sequence : tag
  (** (0020,9111) *)
  val plane_position_sequence : tag
  (** (0020,9113) *)
  val plane_orientation_sequence : tag
  (** (0020,9116) *)
  val temporal_position_index : tag
  (** (0020,9128) *)
  val nominal_cardiac_trigger_delay_time : tag
  (** (0020,9153) *)
  val nominal_cardiac_trigger_time_prior_to_rpeak : tag
  (** (0020,9154) *)
  val actual_cardiac_trigger_time_prior_to_rpeak : tag
  (** (0020,9155) *)
  val frame_acquisition_number : tag
  (** (0020,9156) *)
  val dimension_index_values : tag
  (** (0020,9157) *)
  val frame_comments : tag
  (** (0020,9158) *)
  val concatenation_uid : tag
  (** (0020,9161) *)
  val in_concatenation_number : tag
  (** (0020,9162) *)
  val in_concatenation_total_number : tag
  (** (0020,9163) *)
  val dimension_organization_uid : tag
  (** (0020,9164) *)
  val dimension_index_pointer : tag
  (** (0020,9165) *)
  val functional_group_pointer : tag
  (** (0020,9167) *)
  val dimension_index_private_creator : tag
  (** (0020,9213) *)
  val dimension_organization_sequence : tag
  (** (0020,9221) *)
  val dimension_index_sequence : tag
  (** (0020,9222) *)
  val concatenation_frame_offset_number : tag
  (** (0020,9228) *)
  val functional_group_private_creator : tag
  (** (0020,9238) *)
  val nominal_percentage_of_cardiac_phase : tag
  (** (0020,9241) *)
  val nominal_percentage_of_respiratory_phase : tag
  (** (0020,9245) *)
  val starting_respiratory_amplitude : tag
  (** (0020,9246) *)
  val starting_respiratory_phase : tag
  (** (0020,9247) *)
  val ending_respiratory_amplitude : tag
  (** (0020,9248) *)
  val ending_respiratory_phase : tag
  (** (0020,9249) *)
  val respiratory_trigger_type : tag
  (** (0020,9250) *)
  val rr_interval_time_nominal : tag
  (** (0020,9251) *)
  val actual_cardiac_trigger_delay_time : tag
  (** (0020,9252) *)
  val respiratory_synchronization_sequence : tag
  (** (0020,9253) *)
  val respiratory_interval_time : tag
  (** (0020,9254) *)
  val nominal_respiratory_trigger_delay_time : tag
  (** (0020,9255) *)
  val respiratory_trigger_delay_threshold : tag
  (** (0020,9256) *)
  val actual_respiratory_trigger_delay_time : tag
  (** (0020,9257) *)
  val image_position_volume : tag
  (** (0020,9301) *)
  val image_orientation_volume : tag
  (** (0020,9302) *)
  val ultrasound_acquisition_geometry : tag
  (** (0020,9307) *)
  val apex_position : tag
  (** (0020,9308) *)
  val volume_to_transducer_mapping_matrix : tag
  (** (0020,9309) *)
  val volume_to_table_mapping_matrix : tag
  (** (0020,930A) *)
  val patient_frame_of_reference_source : tag
  (** (0020,930C) *)
  val temporal_position_time_offset : tag
  (** (0020,930D) *)
  val plane_position_volume_sequence : tag
  (** (0020,930E) *)
  val plane_orientation_volume_sequence : tag
  (** (0020,930F) *)
  val temporal_position_sequence : tag
  (** (0020,9310) *)
  val dimension_organization_type : tag
  (** (0020,9311) *)
  val volume_frame_of_reference_uid : tag
  (** (0020,9312) *)
  val table_frame_of_reference_uid : tag
  (** (0020,9313) *)
  val dimension_description_label : tag
  (** (0020,9421) *)
  val patient_orientation_in_frame_sequence : tag
  (** (0020,9450) *)
  val frame_label : tag
  (** (0020,9453) *)
  val acquisition_index : tag
  (** (0020,9518) *)
  val contributing_sop_instances_reference_sequence : tag
  (** (0020,9529) *)
  val reconstruction_index : tag
  (** (0020,9536) *)
  val light_path_filter_pass_through_wavelength : tag
  (** (0022,0001) *)
  val light_path_filter_pass_band : tag
  (** (0022,0002) *)
  val image_path_filter_pass_through_wavelength : tag
  (** (0022,0003) *)
  val image_path_filter_pass_band : tag
  (** (0022,0004) *)
  val patient_eye_movement_commanded : tag
  (** (0022,0005) *)
  val patient_eye_movement_command_code_sequence : tag
  (** (0022,0006) *)
  val spherical_lens_power : tag
  (** (0022,0007) *)
  val cylinder_lens_power : tag
  (** (0022,0008) *)
  val cylinder_axis : tag
  (** (0022,0009) *)
  val emmetropic_magnification : tag
  (** (0022,000A) *)
  val intra_ocular_pressure : tag
  (** (0022,000B) *)
  val horizontal_field_of_view : tag
  (** (0022,000C) *)
  val pupil_dilated : tag
  (** (0022,000D) *)
  val degree_of_dilation : tag
  (** (0022,000E) *)
  val stereo_baseline_angle : tag
  (** (0022,0010) *)
  val stereo_baseline_displacement : tag
  (** (0022,0011) *)
  val stereo_horizontal_pixel_offset : tag
  (** (0022,0012) *)
  val stereo_vertical_pixel_offset : tag
  (** (0022,0013) *)
  val stereo_rotation : tag
  (** (0022,0014) *)
  val acquisition_device_type_code_sequence : tag
  (** (0022,0015) *)
  val illumination_type_code_sequence : tag
  (** (0022,0016) *)
  val light_path_filter_type_stack_code_sequence : tag
  (** (0022,0017) *)
  val image_path_filter_type_stack_code_sequence : tag
  (** (0022,0018) *)
  val lenses_code_sequence : tag
  (** (0022,0019) *)
  val channel_description_code_sequence : tag
  (** (0022,001A) *)
  val refractive_state_sequence : tag
  (** (0022,001B) *)
  val mydriatic_agent_code_sequence : tag
  (** (0022,001C) *)
  val relative_image_position_code_sequence : tag
  (** (0022,001D) *)
  val camera_angle_of_view : tag
  (** (0022,001E) *)
  val stereo_pairs_sequence : tag
  (** (0022,0020) *)
  val left_image_sequence : tag
  (** (0022,0021) *)
  val right_image_sequence : tag
  (** (0022,0022) *)
  val axial_length_of_the_eye : tag
  (** (0022,0030) *)
  val ophthalmic_frame_location_sequence : tag
  (** (0022,0031) *)
  val reference_coordinates : tag
  (** (0022,0032) *)
  val depth_spatial_resolution : tag
  (** (0022,0035) *)
  val maximum_depth_distortion : tag
  (** (0022,0036) *)
  val along_scan_spatial_resolution : tag
  (** (0022,0037) *)
  val maximum_along_scan_distortion : tag
  (** (0022,0038) *)
  val ophthalmic_image_orientation : tag
  (** (0022,0039) *)
  val depth_of_transverse_image : tag
  (** (0022,0041) *)
  val mydriatic_agent_concentration_units_sequence : tag
  (** (0022,0042) *)
  val across_scan_spatial_resolution : tag
  (** (0022,0048) *)
  val maximum_across_scan_distortion : tag
  (** (0022,0049) *)
  val mydriatic_agent_concentration : tag
  (** (0022,004E) *)
  val illumination_wave_length : tag
  (** (0022,0055) *)
  val illumination_power : tag
  (** (0022,0056) *)
  val illumination_bandwidth : tag
  (** (0022,0057) *)
  val mydriatic_agent_sequence : tag
  (** (0022,0058) *)
  val ophthalmic_axial_measurements_right_eye_sequence : tag
  (** (0022,1007) *)
  val ophthalmic_axial_measurements_left_eye_sequence : tag
  (** (0022,1008) *)
  val ophthalmic_axial_length_measurements_type : tag
  (** (0022,1010) *)
  val ophthalmic_axial_length : tag
  (** (0022,1019) *)
  val lens_status_code_sequence : tag
  (** (0022,1024) *)
  val vitreous_status_code_sequence : tag
  (** (0022,1025) *)
  val iol_formula_code_sequence : tag
  (** (0022,1028) *)
  val iol_formula_detail : tag
  (** (0022,1029) *)
  val keratometer_index : tag
  (** (0022,1033) *)
  val source_of_ophthalmic_axial_length_code_sequence : tag
  (** (0022,1035) *)
  val target_refraction : tag
  (** (0022,1037) *)
  val refractive_procedure_occurred : tag
  (** (0022,1039) *)
  val refractive_surgery_type_code_sequence : tag
  (** (0022,1040) *)
  val ophthalmic_ultrasound_axial_measurements_type_code_sequence : tag
  (** (0022,1044) *)
  val ophthalmic_axial_length_measurements_sequence : tag
  (** (0022,1050) *)
  val iol_power : tag
  (** (0022,1053) *)
  val predicted_refractive_error : tag
  (** (0022,1054) *)
  val ophthalmic_axial_length_velocity : tag
  (** (0022,1059) *)
  val lens_status_description : tag
  (** (0022,1065) *)
  val vitreous_status_description : tag
  (** (0022,1066) *)
  val iol_power_sequence : tag
  (** (0022,1090) *)
  val lens_constant_sequence : tag
  (** (0022,1092) *)
  val iol_manufacturer : tag
  (** (0022,1093) *)
  val lens_constant_description : tag
  (** (0022,1094) *)
  val keratometry_measurement_type_code_sequence : tag
  (** (0022,1096) *)
  val referenced_ophthalmic_axial_measurements_sequence : tag
  (** (0022,1100) *)
  val ophthalmic_axial_length_measurements_segment_name_code_sequence : tag
  (** (0022,1101) *)
  val refractive_error_before_refractive_surgery_code_sequence : tag
  (** (0022,1103) *)
  val iol_power_for_exact_emmetropia : tag
  (** (0022,1121) *)
  val iol_power_for_exact_target_refraction : tag
  (** (0022,1122) *)
  val anterior_chamber_depth_definition_code_sequence : tag
  (** (0022,1125) *)
  val lens_thickness : tag
  (** (0022,1130) *)
  val anterior_chamber_depth : tag
  (** (0022,1131) *)
  val source_of_lens_thickness_data_code_sequence : tag
  (** (0022,1132) *)
  val source_of_anterior_chamber_depth_data_code_sequence : tag
  (** (0022,1133) *)
  val source_of_refractive_error_data_code_sequence : tag
  (** (0022,1135) *)
  val ophthalmic_axial_length_measurement_modified : tag
  (** (0022,1140) *)
  val ophthalmic_axial_length_data_source_code_sequence : tag
  (** (0022,1150) *)
  val ophthalmic_axial_length_acquisition_method_code_sequence : tag
  (** (0022,1153) *)
  val signal_to_noise_ratio : tag
  (** (0022,1155) *)
  val ophthalmic_axial_length_data_source_description : tag
  (** (0022,1159) *)
  val ophthalmic_axial_length_measurements_total_length_sequence : tag
  (** (0022,1210) *)
  val ophthalmic_axial_length_measurements_segmental_length_sequence : tag
  (** (0022,1211) *)
  val ophthalmic_axial_length_measurements_length_summation_sequence : tag
  (** (0022,1212) *)
  val ultrasound_ophthalmic_axial_length_measurements_sequence : tag
  (** (0022,1220) *)
  val optical_ophthalmic_axial_length_measurements_sequence : tag
  (** (0022,1225) *)
  val ultrasound_selected_ophthalmic_axial_length_sequence : tag
  (** (0022,1230) *)
  val ophthalmic_axial_length_selection_method_code_sequence : tag
  (** (0022,1250) *)
  val optical_selected_ophthalmic_axial_length_sequence : tag
  (** (0022,1255) *)
  val selected_segmental_ophthalmic_axial_length_sequence : tag
  (** (0022,1257) *)
  val selected_total_ophthalmic_axial_length_sequence : tag
  (** (0022,1260) *)
  val ophthalmic_axial_length_quality_metric_sequence : tag
  (** (0022,1262) *)
  val ophthalmic_axial_length_quality_metric_type_description : tag
  (** (0022,1273) *)
  val intraocular_lens_calculations_right_eye_sequence : tag
  (** (0022,1300) *)
  val intraocular_lens_calculations_left_eye_sequence : tag
  (** (0022,1310) *)
  val referenced_ophthalmic_axial_length_measurement_qcimage_sequence : tag
  (** (0022,1330) *)
  val visual_field_horizontal_extent : tag
  (** (0024,0010) *)
  val visual_field_vertical_extent : tag
  (** (0024,0011) *)
  val visual_field_shape : tag
  (** (0024,0012) *)
  val screening_test_mode_code_sequence : tag
  (** (0024,0016) *)
  val maximum_stimulus_luminance : tag
  (** (0024,0018) *)
  val background_luminance : tag
  (** (0024,0020) *)
  val stimulus_color_code_sequence : tag
  (** (0024,0021) *)
  val background_illumination_color_code_sequence : tag
  (** (0024,0024) *)
  val stimulus_area : tag
  (** (0024,0025) *)
  val stimulus_presentation_time : tag
  (** (0024,0028) *)
  val fixation_sequence : tag
  (** (0024,0032) *)
  val fixation_monitoring_code_sequence : tag
  (** (0024,0033) *)
  val visual_field_catch_trial_sequence : tag
  (** (0024,0034) *)
  val fixation_checked_quantity : tag
  (** (0024,0035) *)
  val patient_not_properly_fixated_quantity : tag
  (** (0024,0036) *)
  val presented_visual_stimuli_data_flag : tag
  (** (0024,0037) *)
  val number_of_visual_stimuli : tag
  (** (0024,0038) *)
  val excessive_fixation_losses_data_flag : tag
  (** (0024,0039) *)
  val excessive_fixation_losses : tag
  (** (0024,0040) *)
  val stimuli_retesting_quantity : tag
  (** (0024,0042) *)
  val comments_on_patient_performance_of_visual_field : tag
  (** (0024,0044) *)
  val false_negatives_estimate_flag : tag
  (** (0024,0045) *)
  val false_negatives_estimate : tag
  (** (0024,0046) *)
  val negative_catch_trials_quantity : tag
  (** (0024,0048) *)
  val false_negatives_quantity : tag
  (** (0024,0050) *)
  val excessive_false_negatives_data_flag : tag
  (** (0024,0051) *)
  val excessive_false_negatives : tag
  (** (0024,0052) *)
  val false_positives_estimate_flag : tag
  (** (0024,0053) *)
  val false_positives_estimate : tag
  (** (0024,0054) *)
  val catch_trials_data_flag : tag
  (** (0024,0055) *)
  val positive_catch_trials_quantity : tag
  (** (0024,0056) *)
  val test_point_normals_data_flag : tag
  (** (0024,0057) *)
  val test_point_normals_sequence : tag
  (** (0024,0058) *)
  val global_deviation_probability_normals_flag : tag
  (** (0024,0059) *)
  val false_positives_quantity : tag
  (** (0024,0060) *)
  val excessive_false_positives_data_flag : tag
  (** (0024,0061) *)
  val excessive_false_positives : tag
  (** (0024,0062) *)
  val visual_field_test_normals_flag : tag
  (** (0024,0063) *)
  val results_normals_sequence : tag
  (** (0024,0064) *)
  val age_corrected_sensitivity_deviation_algorithm_sequence : tag
  (** (0024,0065) *)
  val global_deviation_from_normal : tag
  (** (0024,0066) *)
  val generalized_defect_sensitivity_deviation_algorithm_sequence : tag
  (** (0024,0067) *)
  val localized_deviationfrom_normal : tag
  (** (0024,0068) *)
  val patient_reliability_indicator : tag
  (** (0024,0069) *)
  val visual_field_mean_sensitivity : tag
  (** (0024,0070) *)
  val global_deviation_probability : tag
  (** (0024,0071) *)
  val local_deviation_probability_normals_flag : tag
  (** (0024,0072) *)
  val localized_deviation_probability : tag
  (** (0024,0073) *)
  val short_term_fluctuation_calculated : tag
  (** (0024,0074) *)
  val short_term_fluctuation : tag
  (** (0024,0075) *)
  val short_term_fluctuation_probability_calculated : tag
  (** (0024,0076) *)
  val short_term_fluctuation_probability : tag
  (** (0024,0077) *)
  val corrected_localized_deviation_from_normal_calculated : tag
  (** (0024,0078) *)
  val corrected_localized_deviation_from_normal : tag
  (** (0024,0079) *)
  val corrected_localized_deviation_from_normal_probability_calculated : tag
  (** (0024,0080) *)
  val corrected_localized_deviation_from_normal_probability : tag
  (** (0024,0081) *)
  val global_deviation_probability_sequence : tag
  (** (0024,0083) *)
  val localized_deviation_probability_sequence : tag
  (** (0024,0085) *)
  val foveal_sensitivity_measured : tag
  (** (0024,0086) *)
  val foveal_sensitivity : tag
  (** (0024,0087) *)
  val visual_field_test_duration : tag
  (** (0024,0088) *)
  val visual_field_test_point_sequence : tag
  (** (0024,0089) *)
  val visual_field_test_point_xcoordinate : tag
  (** (0024,0090) *)
  val visual_field_test_point_ycoordinate : tag
  (** (0024,0091) *)
  val age_corrected_sensitivity_deviation_value : tag
  (** (0024,0092) *)
  val stimulus_results : tag
  (** (0024,0093) *)
  val sensitivity_value : tag
  (** (0024,0094) *)
  val retest_stimulus_seen : tag
  (** (0024,0095) *)
  val retest_sensitivity_value : tag
  (** (0024,0096) *)
  val visual_field_test_point_normals_sequence : tag
  (** (0024,0097) *)
  val quantified_defect : tag
  (** (0024,0098) *)
  val age_corrected_sensitivity_deviation_probability_value : tag
  (** (0024,0100) *)
  val generalized_defect_corrected_sensitivity_deviation_flag : tag
  (** (0024,0102) *)
  val generalized_defect_corrected_sensitivity_deviation_value : tag
  (** (0024,0103) *)
  val generalized_defect_corrected_sensitivity_deviation_probability_value : tag
  (** (0024,0104) *)
  val minimum_sensitivity_value : tag
  (** (0024,0105) *)
  val blind_spot_localized : tag
  (** (0024,0106) *)
  val blind_spot_xcoordinate : tag
  (** (0024,0107) *)
  val blind_spot_ycoordinate : tag
  (** (0024,0108) *)
  val visual_acuity_measurement_sequence : tag
  (** (0024,0110) *)
  val refractive_parameters_used_on_patient_sequence : tag
  (** (0024,0112) *)
  val measurement_laterality : tag
  (** (0024,0113) *)
  val ophthalmic_patient_clinical_information_left_eye_sequence : tag
  (** (0024,0114) *)
  val ophthalmic_patient_clinical_information_right_eye_sequence : tag
  (** (0024,0115) *)
  val foveal_point_normative_data_flag : tag
  (** (0024,0117) *)
  val foveal_point_probability_value : tag
  (** (0024,0118) *)
  val screening_baseline_measured : tag
  (** (0024,0120) *)
  val screening_baseline_measured_sequence : tag
  (** (0024,0122) *)
  val screening_baseline_type : tag
  (** (0024,0124) *)
  val screening_baseline_value : tag
  (** (0024,0126) *)
  val algorithm_source : tag
  (** (0024,0202) *)
  val data_set_name : tag
  (** (0024,0306) *)
  val data_set_version : tag
  (** (0024,0307) *)
  val data_set_source : tag
  (** (0024,0308) *)
  val data_set_description : tag
  (** (0024,0309) *)
  val visual_field_test_reliability_global_index_sequence : tag
  (** (0024,0317) *)
  val visual_field_global_results_index_sequence : tag
  (** (0024,0320) *)
  val data_observation_sequence : tag
  (** (0024,0325) *)
  val index_normals_flag : tag
  (** (0024,0338) *)
  val index_probability : tag
  (** (0024,0341) *)
  val index_probability_sequence : tag
  (** (0024,0344) *)
  val samples_per_pixel : tag
  (** (0028,0002) *)
  val samples_per_pixel_used : tag
  (** (0028,0003) *)
  val photometric_interpretation : tag
  (** (0028,0004) *)
  val image_dimensions : tag
  (** (0028,0005) *)
  val planar_configuration : tag
  (** (0028,0006) *)
  val number_of_frames : tag
  (** (0028,0008) *)
  val frame_increment_pointer : tag
  (** (0028,0009) *)
  val frame_dimension_pointer : tag
  (** (0028,000A) *)
  val rows : tag
  (** (0028,0010) *)
  val columns : tag
  (** (0028,0011) *)
  val planes : tag
  (** (0028,0012) *)
  val ultrasound_color_data_present : tag
  (** (0028,0014) *)
  val pixel_spacing : tag
  (** (0028,0030) *)
  val zoom_factor : tag
  (** (0028,0031) *)
  val zoom_center : tag
  (** (0028,0032) *)
  val pixel_aspect_ratio : tag
  (** (0028,0034) *)
  val image_format : tag
  (** (0028,0040) *)
  val manipulated_image : tag
  (** (0028,0050) *)
  val corrected_image : tag
  (** (0028,0051) *)
  val compression_recognition_code : tag
  (** (0028,005F) *)
  val compression_code : tag
  (** (0028,0060) *)
  val compression_originator : tag
  (** (0028,0061) *)
  val compression_label : tag
  (** (0028,0062) *)
  val compression_description : tag
  (** (0028,0063) *)
  val compression_sequence : tag
  (** (0028,0065) *)
  val compression_step_pointers : tag
  (** (0028,0066) *)
  val repeat_interval : tag
  (** (0028,0068) *)
  val bits_grouped : tag
  (** (0028,0069) *)
  val perimeter_table : tag
  (** (0028,0070) *)
  val perimeter_value : tag
  (** (0028,0071) *)
  val predictor_rows : tag
  (** (0028,0080) *)
  val predictor_columns : tag
  (** (0028,0081) *)
  val predictor_constants : tag
  (** (0028,0082) *)
  val blocked_pixels : tag
  (** (0028,0090) *)
  val block_rows : tag
  (** (0028,0091) *)
  val block_columns : tag
  (** (0028,0092) *)
  val row_overlap : tag
  (** (0028,0093) *)
  val column_overlap : tag
  (** (0028,0094) *)
  val bits_allocated : tag
  (** (0028,0100) *)
  val bits_stored : tag
  (** (0028,0101) *)
  val high_bit : tag
  (** (0028,0102) *)
  val pixel_representation : tag
  (** (0028,0103) *)
  val smallest_valid_pixel_value : tag
  (** (0028,0104) *)
  val largest_valid_pixel_value : tag
  (** (0028,0105) *)
  val smallest_image_pixel_value : tag
  (** (0028,0106) *)
  val largest_image_pixel_value : tag
  (** (0028,0107) *)
  val smallest_pixel_value_in_series : tag
  (** (0028,0108) *)
  val largest_pixel_value_in_series : tag
  (** (0028,0109) *)
  val smallest_image_pixel_value_in_plane : tag
  (** (0028,0110) *)
  val largest_image_pixel_value_in_plane : tag
  (** (0028,0111) *)
  val pixel_padding_value : tag
  (** (0028,0120) *)
  val pixel_padding_range_limit : tag
  (** (0028,0121) *)
  val image_location : tag
  (** (0028,0200) *)
  val quality_control_image : tag
  (** (0028,0300) *)
  val burned_in_annotation : tag
  (** (0028,0301) *)
  val recognizable_visual_features : tag
  (** (0028,0302) *)
  val longitudinal_temporal_information_modified : tag
  (** (0028,0303) *)
  val transform_label : tag
  (** (0028,0400) *)
  val transform_version_number : tag
  (** (0028,0401) *)
  val number_of_transform_steps : tag
  (** (0028,0402) *)
  val sequence_of_compressed_data : tag
  (** (0028,0403) *)
  val details_of_coefficients : tag
  (** (0028,0404) *)
  val rows_for_nth_order_coefficients : tag
  (** (0028,0400) *)
  val columns_for_nth_order_coefficients : tag
  (** (0028,0401) *)
  val coefficient_coding : tag
  (** (0028,0402) *)
  val coefficient_coding_pointers : tag
  (** (0028,0403) *)
  val dct_label : tag
  (** (0028,0700) *)
  val data_block_description : tag
  (** (0028,0701) *)
  val data_block : tag
  (** (0028,0702) *)
  val normalization_factor_format : tag
  (** (0028,0710) *)
  val zonal_map_number_format : tag
  (** (0028,0720) *)
  val zonal_map_location : tag
  (** (0028,0721) *)
  val zonal_map_format : tag
  (** (0028,0722) *)
  val adaptive_map_format : tag
  (** (0028,0730) *)
  val code_number_format : tag
  (** (0028,0740) *)
  val code_label : tag
  (** (0028,0800) *)
  val number_of_tables : tag
  (** (0028,0802) *)
  val code_table_location : tag
  (** (0028,0803) *)
  val bits_for_code_word : tag
  (** (0028,0804) *)
  val image_data_location : tag
  (** (0028,0808) *)
  val pixel_spacing_calibration_type : tag
  (** (0028,0A02) *)
  val pixel_spacing_calibration_description : tag
  (** (0028,0A04) *)
  val pixel_intensity_relationship : tag
  (** (0028,1040) *)
  val pixel_intensity_relationship_sign : tag
  (** (0028,1041) *)
  val window_center : tag
  (** (0028,1050) *)
  val window_width : tag
  (** (0028,1051) *)
  val rescale_intercept : tag
  (** (0028,1052) *)
  val rescale_slope : tag
  (** (0028,1053) *)
  val rescale_type : tag
  (** (0028,1054) *)
  val window_center_width_explanation : tag
  (** (0028,1055) *)
  val voi_lut_function : tag
  (** (0028,1056) *)
  val gray_scale : tag
  (** (0028,1080) *)
  val recommended_viewing_mode : tag
  (** (0028,1090) *)
  val gray_lookup_table_descriptor : tag
  (** (0028,1100) *)
  val red_palette_color_lookup_table_descriptor : tag
  (** (0028,1101) *)
  val green_palette_color_lookup_table_descriptor : tag
  (** (0028,1102) *)
  val blue_palette_color_lookup_table_descriptor : tag
  (** (0028,1103) *)
  val alpha_palette_color_lookup_table_descriptor : tag
  (** (0028,1104) *)
  val large_red_palette_color_lookup_table_descriptor : tag
  (** (0028,1111) *)
  val large_green_palette_color_lookup_table_descriptor : tag
  (** (0028,1112) *)
  val large_blue_palette_color_lookup_table_descriptor : tag
  (** (0028,1113) *)
  val palette_color_lookup_table_uid : tag
  (** (0028,1199) *)
  val gray_lookup_table_data : tag
  (** (0028,1200) *)
  val red_palette_color_lookup_table_data : tag
  (** (0028,1201) *)
  val green_palette_color_lookup_table_data : tag
  (** (0028,1202) *)
  val blue_palette_color_lookup_table_data : tag
  (** (0028,1203) *)
  val alpha_palette_color_lookup_table_data : tag
  (** (0028,1204) *)
  val large_red_palette_color_lookup_table_data : tag
  (** (0028,1211) *)
  val large_green_palette_color_lookup_table_data : tag
  (** (0028,1212) *)
  val large_blue_palette_color_lookup_table_data : tag
  (** (0028,1213) *)
  val large_palette_color_lookup_table_uid : tag
  (** (0028,1214) *)
  val segmented_red_palette_color_lookup_table_data : tag
  (** (0028,1221) *)
  val segmented_green_palette_color_lookup_table_data : tag
  (** (0028,1222) *)
  val segmented_blue_palette_color_lookup_table_data : tag
  (** (0028,1223) *)
  val breast_implant_present : tag
  (** (0028,1300) *)
  val partial_view : tag
  (** (0028,1350) *)
  val partial_view_description : tag
  (** (0028,1351) *)
  val partial_view_code_sequence : tag
  (** (0028,1352) *)
  val spatial_locations_preserved : tag
  (** (0028,135A) *)
  val data_frame_assignment_sequence : tag
  (** (0028,1401) *)
  val data_path_assignment : tag
  (** (0028,1402) *)
  val bits_mapped_to_color_lookup_table : tag
  (** (0028,1403) *)
  val blending_lut1_sequence : tag
  (** (0028,1404) *)
  val blending_lut1_transfer_function : tag
  (** (0028,1405) *)
  val blending_weight_constant : tag
  (** (0028,1406) *)
  val blending_lookup_table_descriptor : tag
  (** (0028,1407) *)
  val blending_lookup_table_data : tag
  (** (0028,1408) *)
  val enhanced_palette_color_lookup_table_sequence : tag
  (** (0028,140B) *)
  val blending_lut2_sequence : tag
  (** (0028,140C) *)
  val blending_lut2_transfer_function : tag
  (** (0028,140D) *)
  val data_path_id : tag
  (** (0028,140E) *)
  val rgb_lut_transfer_function : tag
  (** (0028,140F) *)
  val alpha_lut_transfer_function : tag
  (** (0028,1410) *)
  val icc_profile : tag
  (** (0028,2000) *)
  val lossy_image_compression : tag
  (** (0028,2110) *)
  val lossy_image_compression_ratio : tag
  (** (0028,2112) *)
  val lossy_image_compression_method : tag
  (** (0028,2114) *)
  val modality_lut_sequence : tag
  (** (0028,3000) *)
  val lut_descriptor : tag
  (** (0028,3002) *)
  val lut_explanation : tag
  (** (0028,3003) *)
  val modality_lut_type : tag
  (** (0028,3004) *)
  val lut_data : tag
  (** (0028,3006) *)
  val voi_lut_sequence : tag
  (** (0028,3010) *)
  val soft_copy_void_lut_sequence : tag
  (** (0028,3110) *)
  val image_presentation_comments : tag
  (** (0028,4000) *)
  val bi_plane_acquisition_sequence : tag
  (** (0028,5000) *)
  val representative_frame_number : tag
  (** (0028,6010) *)
  val frame_numbers_of_interest : tag
  (** (0028,6020) *)
  val frame_of_interest_description : tag
  (** (0028,6022) *)
  val frame_of_interest_type : tag
  (** (0028,6023) *)
  val mask_pointers : tag
  (** (0028,6030) *)
  val r_wave_pointer : tag
  (** (0028,6040) *)
  val mask_subtraction_sequence : tag
  (** (0028,6100) *)
  val mask_operation : tag
  (** (0028,6101) *)
  val applicable_frame_range : tag
  (** (0028,6102) *)
  val mask_frame_numbers : tag
  (** (0028,6110) *)
  val contrast_frame_averaging : tag
  (** (0028,6112) *)
  val mask_sub_pixel_shift : tag
  (** (0028,6114) *)
  val tid_offset : tag
  (** (0028,6120) *)
  val mask_operation_explanation : tag
  (** (0028,6190) *)
  val pixel_data_provider_url : tag
  (** (0028,7FE0) *)
  val data_point_rows : tag
  (** (0028,9001) *)
  val data_point_columns : tag
  (** (0028,9002) *)
  val signal_domain_columns : tag
  (** (0028,9003) *)
  val largest_monochrome_pixel_value : tag
  (** (0028,9099) *)
  val data_representation : tag
  (** (0028,9108) *)
  val pixel_measures_sequence : tag
  (** (0028,9110) *)
  val frame_voi_lut_sequence : tag
  (** (0028,9132) *)
  val pixel_value_transformation_sequence : tag
  (** (0028,9145) *)
  val signal_domain_rows : tag
  (** (0028,9235) *)
  val display_filter_percentage : tag
  (** (0028,9411) *)
  val frame_pixel_shift_sequence : tag
  (** (0028,9415) *)
  val subtraction_item_id : tag
  (** (0028,9416) *)
  val pixel_intensity_relationship_lutsequence : tag
  (** (0028,9422) *)
  val frame_pixel_data_properties_sequence : tag
  (** (0028,9443) *)
  val geometrical_properties : tag
  (** (0028,9444) *)
  val geometric_maximum_distortion : tag
  (** (0028,9445) *)
  val image_processing_applied : tag
  (** (0028,9446) *)
  val mask_selection_mode : tag
  (** (0028,9454) *)
  val lut_function : tag
  (** (0028,9474) *)
  val mask_visibility_percentage : tag
  (** (0028,9478) *)
  val pixel_shift_sequence : tag
  (** (0028,9501) *)
  val region_pixel_shift_sequence : tag
  (** (0028,9502) *)
  val vertices_of_the_region : tag
  (** (0028,9503) *)
  val multi_frame_presentation_sequence : tag
  (** (0028,9505) *)
  val pixel_shift_frame_range : tag
  (** (0028,9506) *)
  val lut_frame_range : tag
  (** (0028,9507) *)
  val image_to_equipment_mapping_matrix : tag
  (** (0028,9520) *)
  val equipment_coordinate_system_identification : tag
  (** (0028,9537) *)
  val study_status_id : tag
  (** (0032,000A) *)
  val study_priority_id : tag
  (** (0032,000C) *)
  val study_id_issuer : tag
  (** (0032,0012) *)
  val study_verified_date : tag
  (** (0032,0032) *)
  val study_verified_time : tag
  (** (0032,0033) *)
  val study_read_date : tag
  (** (0032,0034) *)
  val study_read_time : tag
  (** (0032,0035) *)
  val scheduled_study_start_date : tag
  (** (0032,1000) *)
  val scheduled_study_start_time : tag
  (** (0032,1001) *)
  val scheduled_study_stop_date : tag
  (** (0032,1010) *)
  val scheduled_study_stop_time : tag
  (** (0032,1011) *)
  val scheduled_study_location : tag
  (** (0032,1020) *)
  val scheduled_study_location_aetitle : tag
  (** (0032,1021) *)
  val reason_for_study : tag
  (** (0032,1030) *)
  val requesting_physician_identification_sequence : tag
  (** (0032,1031) *)
  val requesting_physician : tag
  (** (0032,1032) *)
  val requesting_service : tag
  (** (0032,1033) *)
  val requesting_service_code_sequence : tag
  (** (0032,1034) *)
  val study_arrival_date : tag
  (** (0032,1040) *)
  val study_arrival_time : tag
  (** (0032,1041) *)
  val study_completion_date : tag
  (** (0032,1050) *)
  val study_completion_time : tag
  (** (0032,1051) *)
  val study_component_status_id : tag
  (** (0032,1055) *)
  val requested_procedure_description : tag
  (** (0032,1060) *)
  val requested_procedure_code_sequence : tag
  (** (0032,1064) *)
  val requested_contrast_agent : tag
  (** (0032,1070) *)
  val study_comments : tag
  (** (0032,4000) *)
  val referenced_patient_alias_sequence : tag
  (** (0038,0004) *)
  val visit_status_id : tag
  (** (0038,0008) *)
  val admission_id : tag
  (** (0038,0010) *)
  val issuer_of_admission_id : tag
  (** (0038,0011) *)
  val issuer_of_admission_id_sequence : tag
  (** (0038,0014) *)
  val route_of_admissions : tag
  (** (0038,0016) *)
  val scheduled_admission_date : tag
  (** (0038,001A) *)
  val scheduled_admission_time : tag
  (** (0038,001B) *)
  val scheduled_discharge_date : tag
  (** (0038,001C) *)
  val scheduled_discharge_time : tag
  (** (0038,001D) *)
  val scheduled_patient_institution_residence : tag
  (** (0038,001E) *)
  val admitting_date : tag
  (** (0038,0020) *)
  val admitting_time : tag
  (** (0038,0021) *)
  val discharge_date : tag
  (** (0038,0030) *)
  val discharge_time : tag
  (** (0038,0032) *)
  val discharge_diagnosis_description : tag
  (** (0038,0040) *)
  val discharge_diagnosis_code_sequence : tag
  (** (0038,0044) *)
  val special_needs : tag
  (** (0038,0050) *)
  val service_episode_id : tag
  (** (0038,0060) *)
  val issuer_of_service_episode_id : tag
  (** (0038,0061) *)
  val service_episode_description : tag
  (** (0038,0062) *)
  val issuer_of_service_episode_id_sequence : tag
  (** (0038,0064) *)
  val pertinent_documents_sequence : tag
  (** (0038,0100) *)
  val current_patient_location : tag
  (** (0038,0300) *)
  val patient_institution_residence : tag
  (** (0038,0400) *)
  val patient_state : tag
  (** (0038,0500) *)
  val patient_clinical_trial_participation_sequence : tag
  (** (0038,0502) *)
  val visit_comments : tag
  (** (0038,4000) *)
  val waveform_originality : tag
  (** (003A,0004) *)
  val number_of_waveform_channels : tag
  (** (003A,0005) *)
  val number_of_waveform_samples : tag
  (** (003A,0010) *)
  val sampling_frequency : tag
  (** (003A,001A) *)
  val multiplex_group_label : tag
  (** (003A,0020) *)
  val channel_definition_sequence : tag
  (** (003A,0200) *)
  val waveform_channel_number : tag
  (** (003A,0202) *)
  val channel_label : tag
  (** (003A,0203) *)
  val channel_status : tag
  (** (003A,0205) *)
  val channel_source_sequence : tag
  (** (003A,0208) *)
  val channel_source_modifiers_sequence : tag
  (** (003A,0209) *)
  val source_waveform_sequence : tag
  (** (003A,020A) *)
  val channel_derivation_description : tag
  (** (003A,020C) *)
  val channel_sensitivity : tag
  (** (003A,0210) *)
  val channel_sensitivity_units_sequence : tag
  (** (003A,0211) *)
  val channel_sensitivity_correction_factor : tag
  (** (003A,0212) *)
  val channel_baseline : tag
  (** (003A,0213) *)
  val channel_time_skew : tag
  (** (003A,0214) *)
  val channel_sample_skew : tag
  (** (003A,0215) *)
  val channel_offset : tag
  (** (003A,0218) *)
  val waveform_bits_stored : tag
  (** (003A,021A) *)
  val filter_low_frequency : tag
  (** (003A,0220) *)
  val filter_high_frequency : tag
  (** (003A,0221) *)
  val notch_filter_frequency : tag
  (** (003A,0222) *)
  val notch_filter_bandwidth : tag
  (** (003A,0223) *)
  val waveform_data_display_scale : tag
  (** (003A,0230) *)
  val waveform_display_background_cielab_value : tag
  (** (003A,0231) *)
  val waveform_presentation_group_sequence : tag
  (** (003A,0240) *)
  val presentation_group_number : tag
  (** (003A,0241) *)
  val channel_display_sequence : tag
  (** (003A,0242) *)
  val channel_recommended_display_cielab_value : tag
  (** (003A,0244) *)
  val channel_position : tag
  (** (003A,0245) *)
  val display_shading_flag : tag
  (** (003A,0246) *)
  val fractional_channel_display_scale : tag
  (** (003A,0247) *)
  val absolute_channel_display_scale : tag
  (** (003A,0248) *)
  val multiplexed_audio_channels_description_code_sequence : tag
  (** (003A,0300) *)
  val channel_identification_code : tag
  (** (003A,0301) *)
  val channel_mode : tag
  (** (003A,0302) *)
  val scheduled_station_aetitle : tag
  (** (0040,0001) *)
  val scheduled_procedure_step_start_date : tag
  (** (0040,0002) *)
  val scheduled_procedure_step_start_time : tag
  (** (0040,0003) *)
  val scheduled_procedure_step_end_date : tag
  (** (0040,0004) *)
  val scheduled_procedure_step_end_time : tag
  (** (0040,0005) *)
  val scheduled_performing_physician_name : tag
  (** (0040,0006) *)
  val scheduled_procedure_step_description : tag
  (** (0040,0007) *)
  val scheduled_protocol_code_sequence : tag
  (** (0040,0008) *)
  val scheduled_procedure_step_id : tag
  (** (0040,0009) *)
  val stage_code_sequence : tag
  (** (0040,000A) *)
  val scheduled_performing_physician_identification_sequence : tag
  (** (0040,000B) *)
  val scheduled_station_name : tag
  (** (0040,0010) *)
  val scheduled_procedure_step_location : tag
  (** (0040,0011) *)
  val pre_medication : tag
  (** (0040,0012) *)
  val scheduled_procedure_step_status : tag
  (** (0040,0020) *)
  val order_placer_identifier_sequence : tag
  (** (0040,0026) *)
  val order_filler_identifier_sequence : tag
  (** (0040,0027) *)
  val local_namespace_entity_id : tag
  (** (0040,0031) *)
  val universal_entity_id : tag
  (** (0040,0032) *)
  val universal_entity_id_type : tag
  (** (0040,0033) *)
  val identifier_type_code : tag
  (** (0040,0035) *)
  val assigning_facility_sequence : tag
  (** (0040,0036) *)
  val assigning_jurisdiction_code_sequence : tag
  (** (0040,0039) *)
  val assigning_agency_or_department_code_sequence : tag
  (** (0040,003A) *)
  val scheduled_procedure_step_sequence : tag
  (** (0040,0100) *)
  val referenced_non_image_composite_sop_instance_sequence : tag
  (** (0040,0220) *)
  val performed_station_aetitle : tag
  (** (0040,0241) *)
  val performed_station_name : tag
  (** (0040,0242) *)
  val performed_location : tag
  (** (0040,0243) *)
  val performed_procedure_step_start_date : tag
  (** (0040,0244) *)
  val performed_procedure_step_start_time : tag
  (** (0040,0245) *)
  val performed_procedure_step_end_date : tag
  (** (0040,0250) *)
  val performed_procedure_step_end_time : tag
  (** (0040,0251) *)
  val performed_procedure_step_status : tag
  (** (0040,0252) *)
  val performed_procedure_step_id : tag
  (** (0040,0253) *)
  val performed_procedure_step_description : tag
  (** (0040,0254) *)
  val performed_procedure_type_description : tag
  (** (0040,0255) *)
  val performed_protocol_code_sequence : tag
  (** (0040,0260) *)
  val performed_protocol_type : tag
  (** (0040,0261) *)
  val scheduled_step_attributes_sequence : tag
  (** (0040,0270) *)
  val request_attributes_sequence : tag
  (** (0040,0275) *)
  val comments_on_the_performed_procedure_step : tag
  (** (0040,0280) *)
  val performed_procedure_step_discontinuation_reason_code_sequence : tag
  (** (0040,0281) *)
  val quantity_sequence : tag
  (** (0040,0293) *)
  val quantity : tag
  (** (0040,0294) *)
  val measuring_units_sequence : tag
  (** (0040,0295) *)
  val billing_item_sequence : tag
  (** (0040,0296) *)
  val total_time_of_fluoroscopy : tag
  (** (0040,0300) *)
  val total_number_of_exposures : tag
  (** (0040,0301) *)
  val entrance_dose : tag
  (** (0040,0302) *)
  val exposed_area : tag
  (** (0040,0303) *)
  val distance_source_to_entrance : tag
  (** (0040,0306) *)
  val distance_source_to_support : tag
  (** (0040,0307) *)
  val exposure_dose_sequence : tag
  (** (0040,030E) *)
  val comments_on_radiation_dose : tag
  (** (0040,0310) *)
  val x_ray_output : tag
  (** (0040,0312) *)
  val half_value_layer : tag
  (** (0040,0314) *)
  val organ_dose : tag
  (** (0040,0316) *)
  val organ_exposed : tag
  (** (0040,0318) *)
  val billing_procedure_step_sequence : tag
  (** (0040,0320) *)
  val film_consumption_sequence : tag
  (** (0040,0321) *)
  val billing_supplies_and_devices_sequence : tag
  (** (0040,0324) *)
  val referenced_procedure_step_sequence : tag
  (** (0040,0330) *)
  val performed_series_sequence : tag
  (** (0040,0340) *)
  val comments_on_the_scheduled_procedure_step : tag
  (** (0040,0400) *)
  val protocol_context_sequence : tag
  (** (0040,0440) *)
  val content_item_modifier_sequence : tag
  (** (0040,0441) *)
  val scheduled_specimen_sequence : tag
  (** (0040,0500) *)
  val specimen_accession_number : tag
  (** (0040,050A) *)
  val container_identifier : tag
  (** (0040,0512) *)
  val issuer_of_the_container_identifier_sequence : tag
  (** (0040,0513) *)
  val alternate_container_identifier_sequence : tag
  (** (0040,0515) *)
  val container_type_code_sequence : tag
  (** (0040,0518) *)
  val container_description : tag
  (** (0040,051A) *)
  val container_component_sequence : tag
  (** (0040,0520) *)
  val specimen_sequence : tag
  (** (0040,0550) *)
  val specimen_identifier : tag
  (** (0040,0551) *)
  val specimen_description_sequence_trial : tag
  (** (0040,0552) *)
  val specimen_description_trial : tag
  (** (0040,0553) *)
  val specimen_uid : tag
  (** (0040,0554) *)
  val acquisition_context_sequence : tag
  (** (0040,0555) *)
  val acquisition_context_description : tag
  (** (0040,0556) *)
  val specimen_type_code_sequence : tag
  (** (0040,059A) *)
  val specimen_description_sequence : tag
  (** (0040,0560) *)
  val issuer_of_the_specimen_identifier_sequence : tag
  (** (0040,0562) *)
  val specimen_short_description : tag
  (** (0040,0600) *)
  val specimen_detailed_description : tag
  (** (0040,0602) *)
  val specimen_preparation_sequence : tag
  (** (0040,0610) *)
  val specimen_preparation_step_content_item_sequence : tag
  (** (0040,0612) *)
  val specimen_localization_content_item_sequence : tag
  (** (0040,0620) *)
  val slide_identifier : tag
  (** (0040,06FA) *)
  val image_center_point_coordinates_sequence : tag
  (** (0040,071A) *)
  val x_offset_in_slide_coordinate_system : tag
  (** (0040,072A) *)
  val y_offset_in_slide_coordinate_system : tag
  (** (0040,073A) *)
  val z_offset_in_slide_coordinate_system : tag
  (** (0040,074A) *)
  val pixel_spacing_sequence : tag
  (** (0040,08D8) *)
  val coordinate_system_axis_code_sequence : tag
  (** (0040,08DA) *)
  val measurement_units_code_sequence : tag
  (** (0040,08EA) *)
  val vital_stain_code_sequence_trial : tag
  (** (0040,09F8) *)
  val requested_procedure_id : tag
  (** (0040,1001) *)
  val reason_for_the_requested_procedure : tag
  (** (0040,1002) *)
  val requested_procedure_priority : tag
  (** (0040,1003) *)
  val patient_transport_arrangements : tag
  (** (0040,1004) *)
  val requested_procedure_location : tag
  (** (0040,1005) *)
  val placer_order_number_procedure : tag
  (** (0040,1006) *)
  val filler_order_number_procedure : tag
  (** (0040,1007) *)
  val confidentiality_code : tag
  (** (0040,1008) *)
  val reporting_priority : tag
  (** (0040,1009) *)
  val reason_for_requested_procedure_code_sequence : tag
  (** (0040,100A) *)
  val names_of_intended_recipients_of_results : tag
  (** (0040,1010) *)
  val intended_recipients_of_results_identification_sequence : tag
  (** (0040,1011) *)
  val reason_for_performed_procedure_code_sequence : tag
  (** (0040,1012) *)
  val requested_procedure_description_trial : tag
  (** (0040,1060) *)
  val person_identification_code_sequence : tag
  (** (0040,1101) *)
  val person_address : tag
  (** (0040,1102) *)
  val person_telephone_numbers : tag
  (** (0040,1103) *)
  val requested_procedure_comments : tag
  (** (0040,1400) *)
  val reason_for_the_imaging_service_request : tag
  (** (0040,2001) *)
  val issue_date_of_imaging_service_request : tag
  (** (0040,2004) *)
  val issue_time_of_imaging_service_request : tag
  (** (0040,2005) *)
  val placer_order_number_imaging_service_request_retired : tag
  (** (0040,2006) *)
  val filler_order_number_imaging_service_request_retired : tag
  (** (0040,2007) *)
  val order_entered_by : tag
  (** (0040,2008) *)
  val order_enterer_location : tag
  (** (0040,2009) *)
  val order_callback_phone_number : tag
  (** (0040,2010) *)
  val placer_order_number_imaging_service_request : tag
  (** (0040,2016) *)
  val filler_order_number_imaging_service_request : tag
  (** (0040,2017) *)
  val imaging_service_request_comments : tag
  (** (0040,2400) *)
  val confidentiality_constraint_on_patient_data_description : tag
  (** (0040,3001) *)
  val general_purpose_scheduled_procedure_step_status : tag
  (** (0040,4001) *)
  val general_purpose_performed_procedure_step_status : tag
  (** (0040,4002) *)
  val general_purpose_scheduled_procedure_step_priority : tag
  (** (0040,4003) *)
  val scheduled_processing_applications_code_sequence : tag
  (** (0040,4004) *)
  val scheduled_procedure_step_start_date_time : tag
  (** (0040,4005) *)
  val multiple_copies_flag : tag
  (** (0040,4006) *)
  val performed_processing_applications_code_sequence : tag
  (** (0040,4007) *)
  val human_performer_code_sequence : tag
  (** (0040,4009) *)
  val scheduled_procedure_step_modification_date_time : tag
  (** (0040,4010) *)
  val expected_completion_date_time : tag
  (** (0040,4011) *)
  val resulting_general_purpose_performed_procedure_steps_sequence : tag
  (** (0040,4015) *)
  val referenced_general_purpose_scheduled_procedure_step_sequence : tag
  (** (0040,4016) *)
  val scheduled_workitem_code_sequence : tag
  (** (0040,4018) *)
  val performed_workitem_code_sequence : tag
  (** (0040,4019) *)
  val input_availability_flag : tag
  (** (0040,4020) *)
  val input_information_sequence : tag
  (** (0040,4021) *)
  val relevant_information_sequence : tag
  (** (0040,4022) *)
  val referenced_general_purpose_scheduled_procedure_step_transaction_uid : tag
  (** (0040,4023) *)
  val scheduled_station_name_code_sequence : tag
  (** (0040,4025) *)
  val scheduled_station_class_code_sequence : tag
  (** (0040,4026) *)
  val scheduled_station_geographic_location_code_sequence : tag
  (** (0040,4027) *)
  val performed_station_name_code_sequence : tag
  (** (0040,4028) *)
  val performed_station_class_code_sequence : tag
  (** (0040,4029) *)
  val performed_station_geographic_location_code_sequence : tag
  (** (0040,4030) *)
  val requested_subsequent_workitem_code_sequence : tag
  (** (0040,4031) *)
  val non_dicomoutput_code_sequence : tag
  (** (0040,4032) *)
  val output_information_sequence : tag
  (** (0040,4033) *)
  val scheduled_human_performers_sequence : tag
  (** (0040,4034) *)
  val actual_human_performers_sequence : tag
  (** (0040,4035) *)
  val human_performer_organization : tag
  (** (0040,4036) *)
  val human_performer_name : tag
  (** (0040,4037) *)
  val raw_data_handling : tag
  (** (0040,4040) *)
  val input_readiness_state : tag
  (** (0040,4041) *)
  val performed_procedure_step_start_date_time : tag
  (** (0040,4050) *)
  val performed_procedure_step_end_date_time : tag
  (** (0040,4051) *)
  val procedure_step_cancellation_date_time : tag
  (** (0040,4052) *)
  val entrance_dose_inm_gy : tag
  (** (0040,8302) *)
  val referenced_image_real_world_value_mapping_sequence : tag
  (** (0040,9094) *)
  val real_world_value_mapping_sequence : tag
  (** (0040,9096) *)
  val pixel_value_mapping_code_sequence : tag
  (** (0040,9098) *)
  val lut_label : tag
  (** (0040,9210) *)
  val real_world_value_last_value_mapped : tag
  (** (0040,9211) *)
  val real_world_value_lut_data : tag
  (** (0040,9212) *)
  val real_world_value_first_value_mapped : tag
  (** (0040,9216) *)
  val real_world_value_intercept : tag
  (** (0040,9224) *)
  val real_world_value_slope : tag
  (** (0040,9225) *)
  val findings_flag_trial : tag
  (** (0040,A007) *)
  val relationship_type : tag
  (** (0040,A010) *)
  val findings_sequence_trial : tag
  (** (0040,A020) *)
  val findings_group_uid_trial : tag
  (** (0040,A021) *)
  val referenced_findings_group_uid_trial : tag
  (** (0040,A022) *)
  val findings_group_recording_date_trial : tag
  (** (0040,A023) *)
  val findings_group_recording_time_trial : tag
  (** (0040,A024) *)
  val findings_source_category_code_sequence_trial : tag
  (** (0040,A026) *)
  val verifying_organization : tag
  (** (0040,A027) *)
  val documenting_organization_identifier_code_sequence_trial : tag
  (** (0040,A028) *)
  val verification_date_time : tag
  (** (0040,A030) *)
  val observation_date_time : tag
  (** (0040,A032) *)
  val value_type : tag
  (** (0040,A040) *)
  val concept_name_code_sequence : tag
  (** (0040,A043) *)
  val measurement_precision_description_trial : tag
  (** (0040,A047) *)
  val continuity_of_content : tag
  (** (0040,A050) *)
  val urgency_or_priority_alerts_trial : tag
  (** (0040,A057) *)
  val sequencing_indicator_trial : tag
  (** (0040,A060) *)
  val document_identifier_code_sequence_trial : tag
  (** (0040,A066) *)
  val document_author_trial : tag
  (** (0040,A067) *)
  val document_author_identifier_code_sequence_trial : tag
  (** (0040,A068) *)
  val identifier_code_sequence_trial : tag
  (** (0040,A070) *)
  val verifying_observer_sequence : tag
  (** (0040,A073) *)
  val object_binary_identifier_trial : tag
  (** (0040,A074) *)
  val verifying_observer_name : tag
  (** (0040,A075) *)
  val documenting_observer_identifier_code_sequence_trial : tag
  (** (0040,A076) *)
  val author_observer_sequence : tag
  (** (0040,A078) *)
  val participant_sequence : tag
  (** (0040,A07A) *)
  val custodial_organization_sequence : tag
  (** (0040,A07C) *)
  val participation_type : tag
  (** (0040,A080) *)
  val participation_date_time : tag
  (** (0040,A082) *)
  val observer_type : tag
  (** (0040,A084) *)
  val procedure_identifier_code_sequence_trial : tag
  (** (0040,A085) *)
  val verifying_observer_identification_code_sequence : tag
  (** (0040,A088) *)
  val object_directory_binary_identifier_trial : tag
  (** (0040,A089) *)
  val equivalent_cda_document_sequence : tag
  (** (0040,A090) *)
  val referenced_waveform_channels : tag
  (** (0040,A0B0) *)
  val date_of_document_or_verbal_transaction_trial : tag
  (** (0040,A110) *)
  val time_of_document_creation_or_verbal_transaction_trial : tag
  (** (0040,A112) *)
  val date_time : tag
  (** (0040,A120) *)
  val date : tag
  (** (0040,A121) *)
  val time : tag
  (** (0040,A122) *)
  val person_name : tag
  (** (0040,A123) *)
  val uid : tag
  (** (0040,A124) *)
  val report_status_id_trial : tag
  (** (0040,A125) *)
  val temporal_range_type : tag
  (** (0040,A130) *)
  val referenced_sample_positions : tag
  (** (0040,A132) *)
  val referenced_frame_numbers : tag
  (** (0040,A136) *)
  val referenced_time_offsets : tag
  (** (0040,A138) *)
  val referenced_date_time : tag
  (** (0040,A13A) *)
  val text_value : tag
  (** (0040,A160) *)
  val observation_category_code_sequence_trial : tag
  (** (0040,A167) *)
  val concept_code_sequence : tag
  (** (0040,A168) *)
  val bibliographic_citation_trial : tag
  (** (0040,A16A) *)
  val purpose_of_reference_code_sequence : tag
  (** (0040,A170) *)
  val observation_uid_trial : tag
  (** (0040,A171) *)
  val referenced_observation_uid_trial : tag
  (** (0040,A172) *)
  val referenced_observation_class_trial : tag
  (** (0040,A173) *)
  val referenced_object_observation_class_trial : tag
  (** (0040,A174) *)
  val annotation_group_number : tag
  (** (0040,A180) *)
  val observation_date_trial : tag
  (** (0040,A192) *)
  val observation_time_trial : tag
  (** (0040,A193) *)
  val measurement_automation_trial : tag
  (** (0040,A194) *)
  val modifier_code_sequence : tag
  (** (0040,A195) *)
  val identification_description_trial : tag
  (** (0040,A224) *)
  val coordinates_set_geometric_type_trial : tag
  (** (0040,A290) *)
  val algorithm_code_sequence_trial : tag
  (** (0040,A296) *)
  val algorithm_description_trial : tag
  (** (0040,A297) *)
  val pixel_coordinates_set_trial : tag
  (** (0040,A29A) *)
  val measured_value_sequence : tag
  (** (0040,A300) *)
  val numeric_value_qualifier_code_sequence : tag
  (** (0040,A301) *)
  val current_observer_trial : tag
  (** (0040,A307) *)
  val numeric_value : tag
  (** (0040,A30A) *)
  val referenced_accession_sequence_trial : tag
  (** (0040,A313) *)
  val report_status_comment_trial : tag
  (** (0040,A33A) *)
  val procedure_context_sequence_trial : tag
  (** (0040,A340) *)
  val verbal_source_trial : tag
  (** (0040,A352) *)
  val address_trial : tag
  (** (0040,A353) *)
  val telephone_number_trial : tag
  (** (0040,A354) *)
  val verbal_source_identifier_code_sequence_trial : tag
  (** (0040,A358) *)
  val predecessor_documents_sequence : tag
  (** (0040,A360) *)
  val referenced_request_sequence : tag
  (** (0040,A370) *)
  val performed_procedure_code_sequence : tag
  (** (0040,A372) *)
  val current_requested_procedure_evidence_sequence : tag
  (** (0040,A375) *)
  val report_detail_sequence_trial : tag
  (** (0040,A380) *)
  val pertinent_other_evidence_sequence : tag
  (** (0040,A385) *)
  val hl7_structured_document_reference_sequence : tag
  (** (0040,A390) *)
  val observation_subject_uid_trial : tag
  (** (0040,A402) *)
  val observation_subject_class_trial : tag
  (** (0040,A403) *)
  val observation_subject_type_code_sequence_trial : tag
  (** (0040,A404) *)
  val completion_flag : tag
  (** (0040,A491) *)
  val completion_flag_description : tag
  (** (0040,A492) *)
  val verification_flag : tag
  (** (0040,A493) *)
  val archive_requested : tag
  (** (0040,A494) *)
  val preliminary_flag : tag
  (** (0040,A496) *)
  val content_template_sequence : tag
  (** (0040,A504) *)
  val identical_documents_sequence : tag
  (** (0040,A525) *)
  val observation_subject_context_flag_trial : tag
  (** (0040,A600) *)
  val observer_context_flag_trial : tag
  (** (0040,A601) *)
  val procedure_context_flag_trial : tag
  (** (0040,A603) *)
  val content_sequence : tag
  (** (0040,A730) *)
  val relationship_sequence_trial : tag
  (** (0040,A731) *)
  val relationship_type_code_sequence_trial : tag
  (** (0040,A732) *)
  val language_code_sequence_trial : tag
  (** (0040,A744) *)
  val uniform_resource_locator_trial : tag
  (** (0040,A992) *)
  val waveform_annotation_sequence : tag
  (** (0040,B020) *)
  val template_identifier : tag
  (** (0040,DB00) *)
  val template_version : tag
  (** (0040,DB06) *)
  val template_local_version : tag
  (** (0040,DB07) *)
  val template_extension_flag : tag
  (** (0040,DB0B) *)
  val template_extension_organization_uid : tag
  (** (0040,DB0C) *)
  val template_extension_creator_uid : tag
  (** (0040,DB0D) *)
  val referenced_content_item_identifier : tag
  (** (0040,DB73) *)
  val hl7_instance_identifier : tag
  (** (0040,E001) *)
  val hl7_document_effective_time : tag
  (** (0040,E004) *)
  val hl7_document_type_code_sequence : tag
  (** (0040,E006) *)
  val document_class_code_sequence : tag
  (** (0040,E008) *)
  val retrieve_uri : tag
  (** (0040,E010) *)
  val retrieve_location_uid : tag
  (** (0040,E011) *)
  val type_of_instances : tag
  (** (0040,E020) *)
  val dicomretrievalsequence : tag
  (** (0040,E021) *)
  val dicommediaretrievalsequence : tag
  (** (0040,E022) *)
  val wado_retrieval_sequence : tag
  (** (0040,E023) *)
  val xds_retrieval_sequence : tag
  (** (0040,E024) *)
  val repository_unique_id : tag
  (** (0040,E030) *)
  val home_community_id : tag
  (** (0040,E031) *)
  val document_title : tag
  (** (0042,0010) *)
  val encapsulated_document : tag
  (** (0042,0011) *)
  val mime_type_of_encapsulated_document : tag
  (** (0042,0012) *)
  val source_instance_sequence : tag
  (** (0042,0013) *)
  val list_of_mime_types : tag
  (** (0042,0014) *)
  val product_package_identifier : tag
  (** (0044,0001) *)
  val substance_administration_approval : tag
  (** (0044,0002) *)
  val approval_status_further_description : tag
  (** (0044,0003) *)
  val approval_status_date_time : tag
  (** (0044,0004) *)
  val product_type_code_sequence : tag
  (** (0044,0007) *)
  val product_name : tag
  (** (0044,0008) *)
  val product_description : tag
  (** (0044,0009) *)
  val product_lot_identifier : tag
  (** (0044,000A) *)
  val product_expiration_date_time : tag
  (** (0044,000B) *)
  val substance_administration_date_time : tag
  (** (0044,0010) *)
  val substance_administration_notes : tag
  (** (0044,0011) *)
  val substance_administration_device_id : tag
  (** (0044,0012) *)
  val product_parameter_sequence : tag
  (** (0044,0013) *)
  val substance_administration_parameter_sequence : tag
  (** (0044,0019) *)
  val lens_description : tag
  (** (0046,0012) *)
  val right_lens_sequence : tag
  (** (0046,0014) *)
  val left_lens_sequence : tag
  (** (0046,0015) *)
  val unspecified_laterality_lens_sequence : tag
  (** (0046,0016) *)
  val cylinder_sequence : tag
  (** (0046,0018) *)
  val prism_sequence : tag
  (** (0046,0028) *)
  val horizontal_prism_power : tag
  (** (0046,0030) *)
  val horizontal_prism_base : tag
  (** (0046,0032) *)
  val vertical_prism_power : tag
  (** (0046,0034) *)
  val vertical_prism_base : tag
  (** (0046,0036) *)
  val lens_segment_type : tag
  (** (0046,0038) *)
  val optical_transmittance : tag
  (** (0046,0040) *)
  val channel_width : tag
  (** (0046,0042) *)
  val pupil_size : tag
  (** (0046,0044) *)
  val corneal_size : tag
  (** (0046,0046) *)
  val autorefraction_right_eye_sequence : tag
  (** (0046,0050) *)
  val autorefraction_left_eye_sequence : tag
  (** (0046,0052) *)
  val distance_pupillary_distance : tag
  (** (0046,0060) *)
  val near_pupillary_distance : tag
  (** (0046,0062) *)
  val intermediate_pupillary_distance : tag
  (** (0046,0063) *)
  val other_pupillary_distance : tag
  (** (0046,0064) *)
  val keratometry_right_eye_sequence : tag
  (** (0046,0070) *)
  val keratometry_left_eye_sequence : tag
  (** (0046,0071) *)
  val steep_keratometric_axis_sequence : tag
  (** (0046,0074) *)
  val radius_of_curvature : tag
  (** (0046,0075) *)
  val keratometric_power : tag
  (** (0046,0076) *)
  val keratometric_axis : tag
  (** (0046,0077) *)
  val flat_keratometric_axis_sequence : tag
  (** (0046,0080) *)
  val background_color : tag
  (** (0046,0092) *)
  val optotype : tag
  (** (0046,0094) *)
  val optotype_presentation : tag
  (** (0046,0095) *)
  val subjective_refraction_right_eye_sequence : tag
  (** (0046,0097) *)
  val subjective_refraction_left_eye_sequence : tag
  (** (0046,0098) *)
  val add_near_sequence : tag
  (** (0046,0100) *)
  val add_intermediate_sequence : tag
  (** (0046,0101) *)
  val add_other_sequence : tag
  (** (0046,0102) *)
  val add_power : tag
  (** (0046,0104) *)
  val viewing_distance : tag
  (** (0046,0106) *)
  val visual_acuity_type_code_sequence : tag
  (** (0046,0121) *)
  val visual_acuity_right_eye_sequence : tag
  (** (0046,0122) *)
  val visual_acuity_left_eye_sequence : tag
  (** (0046,0123) *)
  val visual_acuity_both_eyes_open_sequence : tag
  (** (0046,0124) *)
  val viewing_distance_type : tag
  (** (0046,0125) *)
  val visual_acuity_modifiers : tag
  (** (0046,0135) *)
  val decimal_visual_acuity : tag
  (** (0046,0137) *)
  val optotype_detailed_definition : tag
  (** (0046,0139) *)
  val referenced_refractive_measurements_sequence : tag
  (** (0046,0145) *)
  val sphere_power : tag
  (** (0046,0146) *)
  val cylinder_power : tag
  (** (0046,0147) *)
  val imaged_volume_width : tag
  (** (0048,0001) *)
  val imaged_volume_height : tag
  (** (0048,0002) *)
  val imaged_volume_depth : tag
  (** (0048,0003) *)
  val total_pixel_matrix_columns : tag
  (** (0048,0006) *)
  val total_pixel_matrix_rows : tag
  (** (0048,0007) *)
  val total_pixel_matrix_origin_sequence : tag
  (** (0048,0008) *)
  val specimen_label_in_image : tag
  (** (0048,0010) *)
  val focus_method : tag
  (** (0048,0011) *)
  val extended_depth_of_field : tag
  (** (0048,0012) *)
  val number_of_focal_planes : tag
  (** (0048,0013) *)
  val distance_between_focal_planes : tag
  (** (0048,0014) *)
  val recommended_absent_pixel_cielab_value : tag
  (** (0048,0015) *)
  val illuminator_type_code_sequence : tag
  (** (0048,0100) *)
  val image_orientation_slide : tag
  (** (0048,0102) *)
  val optical_path_sequence : tag
  (** (0048,0105) *)
  val optical_path_identifier : tag
  (** (0048,0106) *)
  val optical_path_description : tag
  (** (0048,0107) *)
  val illumination_color_code_sequence : tag
  (** (0048,0108) *)
  val specimen_reference_sequence : tag
  (** (0048,0110) *)
  val condenser_lens_power : tag
  (** (0048,0111) *)
  val objective_lens_power : tag
  (** (0048,0112) *)
  val objective_lens_numerical_aperture : tag
  (** (0048,0113) *)
  val palette_color_lookup_table_sequence : tag
  (** (0048,0120) *)
  val referenced_image_navigation_sequence : tag
  (** (0048,0200) *)
  val top_left_hand_corner_of_localizer_area : tag
  (** (0048,0201) *)
  val bottom_right_hand_corner_of_localizer_area : tag
  (** (0048,0202) *)
  val optical_path_identification_sequence : tag
  (** (0048,0207) *)
  val plane_position_slide_sequence : tag
  (** (0048,021A) *)
  val row_position_in_total_image_pixel_matrix : tag
  (** (0048,021E) *)
  val column_position_in_total_image_pixel_matrix : tag
  (** (0048,021F) *)
  val pixel_origin_interpretation : tag
  (** (0048,0301) *)
  val calibration_image : tag
  (** (0050,0004) *)
  val device_sequence : tag
  (** (0050,0010) *)
  val container_component_type_code_sequence : tag
  (** (0050,0012) *)
  val container_component_thickness : tag
  (** (0050,0013) *)
  val device_length : tag
  (** (0050,0014) *)
  val container_component_width : tag
  (** (0050,0015) *)
  val device_diameter : tag
  (** (0050,0016) *)
  val device_diameter_units : tag
  (** (0050,0017) *)
  val device_volume : tag
  (** (0050,0018) *)
  val inter_marker_distance : tag
  (** (0050,0019) *)
  val container_component_material : tag
  (** (0050,001A) *)
  val container_component_id : tag
  (** (0050,001B) *)
  val container_component_length : tag
  (** (0050,001C) *)
  val container_component_diameter : tag
  (** (0050,001D) *)
  val container_component_description : tag
  (** (0050,001E) *)
  val device_description : tag
  (** (0050,0020) *)
  val contrast_bolus_ingredient_percent_by_volume : tag
  (** (0052,0001) *)
  val oct_focal_distance : tag
  (** (0052,0002) *)
  val beam_spot_size : tag
  (** (0052,0003) *)
  val effective_refractive_index : tag
  (** (0052,0004) *)
  val oct_acquisition_domain : tag
  (** (0052,0006) *)
  val oct_optical_center_wavelength : tag
  (** (0052,0007) *)
  val axial_resolution : tag
  (** (0052,0008) *)
  val ranging_depth : tag
  (** (0052,0009) *)
  val a_line_rate : tag
  (** (0052,0011) *)
  val a_lines_per_frame : tag
  (** (0052,0012) *)
  val catheter_rotational_rate : tag
  (** (0052,0013) *)
  val a_line_pixel_spacing : tag
  (** (0052,0014) *)
  val mode_of_percutaneous_access_sequence : tag
  (** (0052,0016) *)
  val intravascular_oct_frame_type_sequence : tag
  (** (0052,0025) *)
  val oct_zoffset_applied : tag
  (** (0052,0026) *)
  val intravascular_frame_content_sequence : tag
  (** (0052,0027) *)
  val intravascular_longitudinal_distance : tag
  (** (0052,0028) *)
  val intravascular_oct_frame_content_sequence : tag
  (** (0052,0029) *)
  val oct_zoffset_correction : tag
  (** (0052,0030) *)
  val catheter_direction_of_rotation : tag
  (** (0052,0031) *)
  val seam_line_location : tag
  (** (0052,0033) *)
  val first_aline_location : tag
  (** (0052,0034) *)
  val seam_line_index : tag
  (** (0052,0036) *)
  val number_of_padded_alines : tag
  (** (0052,0038) *)
  val interpolation_type : tag
  (** (0052,0039) *)
  val refractive_index_applied : tag
  (** (0052,003A) *)
  val energy_window_vector : tag
  (** (0054,0010) *)
  val number_of_energy_windows : tag
  (** (0054,0011) *)
  val energy_window_information_sequence : tag
  (** (0054,0012) *)
  val energy_window_range_sequence : tag
  (** (0054,0013) *)
  val energy_window_lower_limit : tag
  (** (0054,0014) *)
  val energy_window_upper_limit : tag
  (** (0054,0015) *)
  val radiopharmaceutical_information_sequence : tag
  (** (0054,0016) *)
  val residual_syringe_counts : tag
  (** (0054,0017) *)
  val energy_window_name : tag
  (** (0054,0018) *)
  val detector_vector : tag
  (** (0054,0020) *)
  val number_of_detectors : tag
  (** (0054,0021) *)
  val detector_information_sequence : tag
  (** (0054,0022) *)
  val phase_vector : tag
  (** (0054,0030) *)
  val number_of_phases : tag
  (** (0054,0031) *)
  val phase_information_sequence : tag
  (** (0054,0032) *)
  val number_of_frames_in_phase : tag
  (** (0054,0033) *)
  val phase_delay : tag
  (** (0054,0036) *)
  val pause_between_frames : tag
  (** (0054,0038) *)
  val phase_description : tag
  (** (0054,0039) *)
  val rotation_vector : tag
  (** (0054,0050) *)
  val number_of_rotations : tag
  (** (0054,0051) *)
  val rotation_information_sequence : tag
  (** (0054,0052) *)
  val number_of_frames_in_rotation : tag
  (** (0054,0053) *)
  val r_rinterval_vector : tag
  (** (0054,0060) *)
  val number_of_rrintervals : tag
  (** (0054,0061) *)
  val gated_information_sequence : tag
  (** (0054,0062) *)
  val data_information_sequence : tag
  (** (0054,0063) *)
  val time_slot_vector : tag
  (** (0054,0070) *)
  val number_of_time_slots : tag
  (** (0054,0071) *)
  val time_slot_information_sequence : tag
  (** (0054,0072) *)
  val time_slot_time : tag
  (** (0054,0073) *)
  val slice_vector : tag
  (** (0054,0080) *)
  val number_of_slices : tag
  (** (0054,0081) *)
  val angular_view_vector : tag
  (** (0054,0090) *)
  val time_slice_vector : tag
  (** (0054,0100) *)
  val number_of_time_slices : tag
  (** (0054,0101) *)
  val start_angle : tag
  (** (0054,0200) *)
  val type_of_detector_motion : tag
  (** (0054,0202) *)
  val trigger_vector : tag
  (** (0054,0210) *)
  val number_of_triggers_in_phase : tag
  (** (0054,0211) *)
  val view_code_sequence : tag
  (** (0054,0220) *)
  val view_modifier_code_sequence : tag
  (** (0054,0222) *)
  val radionuclide_code_sequence : tag
  (** (0054,0300) *)
  val administration_route_code_sequence : tag
  (** (0054,0302) *)
  val radiopharmaceutical_code_sequence : tag
  (** (0054,0304) *)
  val calibration_data_sequence : tag
  (** (0054,0306) *)
  val energy_window_number : tag
  (** (0054,0308) *)
  val image_id : tag
  (** (0054,0400) *)
  val patient_orientation_code_sequence : tag
  (** (0054,0410) *)
  val patient_orientation_modifier_code_sequence : tag
  (** (0054,0412) *)
  val patient_gantry_relationship_code_sequence : tag
  (** (0054,0414) *)
  val slice_progression_direction : tag
  (** (0054,0500) *)
  val series_type : tag
  (** (0054,1000) *)
  val units : tag
  (** (0054,1001) *)
  val counts_source : tag
  (** (0054,1002) *)
  val reprojection_method : tag
  (** (0054,1004) *)
  val suv_type : tag
  (** (0054,1006) *)
  val randoms_correction_method : tag
  (** (0054,1100) *)
  val attenuation_correction_method : tag
  (** (0054,1101) *)
  val decay_correction : tag
  (** (0054,1102) *)
  val reconstruction_method : tag
  (** (0054,1103) *)
  val detector_lines_of_response_used : tag
  (** (0054,1104) *)
  val scatter_correction_method : tag
  (** (0054,1105) *)
  val axial_acceptance : tag
  (** (0054,1200) *)
  val axial_mash : tag
  (** (0054,1201) *)
  val transverse_mash : tag
  (** (0054,1202) *)
  val detector_element_size : tag
  (** (0054,1203) *)
  val coincidence_window_width : tag
  (** (0054,1210) *)
  val secondary_counts_type : tag
  (** (0054,1220) *)
  val frame_reference_time : tag
  (** (0054,1300) *)
  val primary_prompts_counts_accumulated : tag
  (** (0054,1310) *)
  val secondary_counts_accumulated : tag
  (** (0054,1311) *)
  val slice_sensitivity_factor : tag
  (** (0054,1320) *)
  val decay_factor : tag
  (** (0054,1321) *)
  val dose_calibration_factor : tag
  (** (0054,1322) *)
  val scatter_fraction_factor : tag
  (** (0054,1323) *)
  val dead_time_factor : tag
  (** (0054,1324) *)
  val image_index : tag
  (** (0054,1330) *)
  val counts_included : tag
  (** (0054,1400) *)
  val dead_time_correction_flag : tag
  (** (0054,1401) *)
  val histogram_sequence : tag
  (** (0060,3000) *)
  val histogram_number_of_bins : tag
  (** (0060,3002) *)
  val histogram_first_bin_value : tag
  (** (0060,3004) *)
  val histogram_last_bin_value : tag
  (** (0060,3006) *)
  val histogram_bin_width : tag
  (** (0060,3008) *)
  val histogram_explanation : tag
  (** (0060,3010) *)
  val histogram_data : tag
  (** (0060,3020) *)
  val segmentation_type : tag
  (** (0062,0001) *)
  val segment_sequence : tag
  (** (0062,0002) *)
  val segmented_property_category_code_sequence : tag
  (** (0062,0003) *)
  val segment_number : tag
  (** (0062,0004) *)
  val segment_label : tag
  (** (0062,0005) *)
  val segment_description : tag
  (** (0062,0006) *)
  val segment_algorithm_type : tag
  (** (0062,0008) *)
  val segment_algorithm_name : tag
  (** (0062,0009) *)
  val segment_identification_sequence : tag
  (** (0062,000A) *)
  val referenced_segment_number : tag
  (** (0062,000B) *)
  val recommended_display_grayscale_value : tag
  (** (0062,000C) *)
  val recommended_display_cie_lab_value : tag
  (** (0062,000D) *)
  val maximum_fractional_value : tag
  (** (0062,000E) *)
  val segmented_property_type_code_sequence : tag
  (** (0062,000F) *)
  val segmentation_fractional_type : tag
  (** (0062,0010) *)
  val deformable_registration_sequence : tag
  (** (0064,0002) *)
  val source_frame_of_reference_uid : tag
  (** (0064,0003) *)
  val deformable_registration_grid_sequence : tag
  (** (0064,0005) *)
  val grid_dimensions : tag
  (** (0064,0007) *)
  val grid_resolution : tag
  (** (0064,0008) *)
  val vector_grid_data : tag
  (** (0064,0009) *)
  val pre_deformation_matrix_registration_sequence : tag
  (** (0064,000F) *)
  val post_deformation_matrix_registration_sequence : tag
  (** (0064,0010) *)
  val number_of_surfaces : tag
  (** (0066,0001) *)
  val surface_sequence : tag
  (** (0066,0002) *)
  val surface_number : tag
  (** (0066,0003) *)
  val surface_comments : tag
  (** (0066,0004) *)
  val surface_processing : tag
  (** (0066,0009) *)
  val surface_processing_ratio : tag
  (** (0066,000A) *)
  val surface_processing_description : tag
  (** (0066,000B) *)
  val recommended_presentation_opacity : tag
  (** (0066,000C) *)
  val recommended_presentation_type : tag
  (** (0066,000D) *)
  val finite_volume : tag
  (** (0066,000E) *)
  val manifold : tag
  (** (0066,0010) *)
  val surface_points_sequence : tag
  (** (0066,0011) *)
  val surface_points_normals_sequence : tag
  (** (0066,0012) *)
  val surface_mesh_primitives_sequence : tag
  (** (0066,0013) *)
  val number_of_surface_points : tag
  (** (0066,0015) *)
  val point_coordinates_data : tag
  (** (0066,0016) *)
  val point_position_accuracy : tag
  (** (0066,0017) *)
  val mean_point_distance : tag
  (** (0066,0018) *)
  val maximum_point_distance : tag
  (** (0066,0019) *)
  val points_bounding_box_coordinates : tag
  (** (0066,001A) *)
  val axis_of_rotation : tag
  (** (0066,001B) *)
  val center_of_rotation : tag
  (** (0066,001C) *)
  val number_of_vectors : tag
  (** (0066,001E) *)
  val vector_dimensionality : tag
  (** (0066,001F) *)
  val vector_accuracy : tag
  (** (0066,0020) *)
  val vector_coordinate_data : tag
  (** (0066,0021) *)
  val triangle_point_index_list : tag
  (** (0066,0023) *)
  val edge_point_index_list : tag
  (** (0066,0024) *)
  val vertex_point_index_list : tag
  (** (0066,0025) *)
  val triangle_strip_sequence : tag
  (** (0066,0026) *)
  val triangle_fan_sequence : tag
  (** (0066,0027) *)
  val line_sequence : tag
  (** (0066,0028) *)
  val primitive_point_index_list : tag
  (** (0066,0029) *)
  val surface_count : tag
  (** (0066,002A) *)
  val referenced_surface_sequence : tag
  (** (0066,002B) *)
  val referenced_surface_number : tag
  (** (0066,002C) *)
  val segment_surface_generation_algorithm_identification_sequence : tag
  (** (0066,002D) *)
  val segment_surface_source_instance_sequence : tag
  (** (0066,002E) *)
  val algorithm_family_code_sequence : tag
  (** (0066,002F) *)
  val algorithm_name_code_sequence : tag
  (** (0066,0030) *)
  val algorithm_version : tag
  (** (0066,0031) *)
  val algorithm_parameters : tag
  (** (0066,0032) *)
  val facet_sequence : tag
  (** (0066,0034) *)
  val surface_processing_algorithm_identification_sequence : tag
  (** (0066,0035) *)
  val algorithm_name : tag
  (** (0066,0036) *)
  val implant_size : tag
  (** (0068,6210) *)
  val implant_template_version : tag
  (** (0068,6221) *)
  val replaced_implant_template_sequence : tag
  (** (0068,6222) *)
  val implant_type : tag
  (** (0068,6223) *)
  val derivation_implant_template_sequence : tag
  (** (0068,6224) *)
  val original_implant_template_sequence : tag
  (** (0068,6225) *)
  val effective_date_time : tag
  (** (0068,6226) *)
  val implant_target_anatomy_sequence : tag
  (** (0068,6230) *)
  val information_from_manufacturer_sequence : tag
  (** (0068,6260) *)
  val notification_from_manufacturer_sequence : tag
  (** (0068,6265) *)
  val information_issue_date_time : tag
  (** (0068,6270) *)
  val information_summary : tag
  (** (0068,6280) *)
  val implant_regulatory_disapproval_code_sequence : tag
  (** (0068,62A0) *)
  val overall_template_spatial_tolerance : tag
  (** (0068,62A5) *)
  val hpgldocumentsequence : tag
  (** (0068,62C0) *)
  val hpgldocument_id : tag
  (** (0068,62D0) *)
  val hpgldocumentlabel : tag
  (** (0068,62D5) *)
  val view_orientation_code_sequence : tag
  (** (0068,62E0) *)
  val view_orientation_modifier : tag
  (** (0068,62F0) *)
  val hpgl_document_scaling : tag
  (** (0068,62F2) *)
  val hpgl_document : tag
  (** (0068,6300) *)
  val hpgl_contour_pen_number : tag
  (** (0068,6310) *)
  val hpgl_pen_sequence : tag
  (** (0068,6320) *)
  val hpgl_pen_number : tag
  (** (0068,6330) *)
  val hpgl_pen_label : tag
  (** (0068,6340) *)
  val hpgl_pen_description : tag
  (** (0068,6345) *)
  val recommended_rotation_point : tag
  (** (0068,6346) *)
  val bounding_rectangle : tag
  (** (0068,6347) *)
  val implant_template3_dmodel_surface_number : tag
  (** (0068,6350) *)
  val surface_model_description_sequence : tag
  (** (0068,6360) *)
  val surface_model_label : tag
  (** (0068,6380) *)
  val surface_model_scaling_factor : tag
  (** (0068,6390) *)
  val materials_code_sequence : tag
  (** (0068,63A0) *)
  val coating_materials_code_sequence : tag
  (** (0068,63A4) *)
  val implant_type_code_sequence : tag
  (** (0068,63A8) *)
  val fixation_method_code_sequence : tag
  (** (0068,63AC) *)
  val mating_feature_sets_sequence : tag
  (** (0068,63B0) *)
  val mating_feature_set_id : tag
  (** (0068,63C0) *)
  val mating_feature_set_label : tag
  (** (0068,63D0) *)
  val mating_feature_sequence : tag
  (** (0068,63E0) *)
  val mating_feature_id : tag
  (** (0068,63F0) *)
  val mating_feature_degree_of_freedom_sequence : tag
  (** (0068,6400) *)
  val degree_of_freedom_id : tag
  (** (0068,6410) *)
  val degree_of_freedom_type : tag
  (** (0068,6420) *)
  val two_dmating_feature_coordinates_sequence : tag
  (** (0068,6430) *)
  val referenced_hpgl_document_id : tag
  (** (0068,6440) *)
  val two_d_mating_point : tag
  (** (0068,6450) *)
  val two_d_mating_axes : tag
  (** (0068,6460) *)
  val two_d_degree_of_freedom_sequence : tag
  (** (0068,6470) *)
  val three_d_degree_of_freedom_axis : tag
  (** (0068,6490) *)
  val range_of_freedom : tag
  (** (0068,64A0) *)
  val three_d_mating_point : tag
  (** (0068,64C0) *)
  val three_d_mating_axes : tag
  (** (0068,64D0) *)
  val two_d_degree_of_freedom_axis : tag
  (** (0068,64F0) *)
  val planning_landmark_point_sequence : tag
  (** (0068,6500) *)
  val planning_landmark_line_sequence : tag
  (** (0068,6510) *)
  val planning_landmark_plane_sequence : tag
  (** (0068,6520) *)
  val planning_landmark_id : tag
  (** (0068,6530) *)
  val planning_landmark_description : tag
  (** (0068,6540) *)
  val planning_landmark_identification_code_sequence : tag
  (** (0068,6545) *)
  val two_d_point_coordinates_sequence : tag
  (** (0068,6550) *)
  val two_d_point_coordinates : tag
  (** (0068,6560) *)
  val three_d_point_coordinates : tag
  (** (0068,6590) *)
  val two_d_line_coordinates_sequence : tag
  (** (0068,65A0) *)
  val two_d_line_coordinates : tag
  (** (0068,65B0) *)
  val three_d_line_coordinates : tag
  (** (0068,65D0) *)
  val two_d_plane_coordinates_sequence : tag
  (** (0068,65E0) *)
  val two_d_plane_intersection : tag
  (** (0068,65F0) *)
  val three_d_plane_origin : tag
  (** (0068,6610) *)
  val three_d_plane_normal : tag
  (** (0068,6620) *)
  val graphic_annotation_sequence : tag
  (** (0070,0001) *)
  val graphic_layer : tag
  (** (0070,0002) *)
  val bounding_box_annotation_units : tag
  (** (0070,0003) *)
  val anchor_point_annotation_units : tag
  (** (0070,0004) *)
  val graphic_annotation_units : tag
  (** (0070,0005) *)
  val unformatted_text_value : tag
  (** (0070,0006) *)
  val text_object_sequence : tag
  (** (0070,0008) *)
  val graphic_object_sequence : tag
  (** (0070,0009) *)
  val bounding_box_top_left_hand_corner : tag
  (** (0070,0010) *)
  val bounding_box_bottom_right_hand_corner : tag
  (** (0070,0011) *)
  val bounding_box_text_horizontal_justification : tag
  (** (0070,0012) *)
  val anchor_point : tag
  (** (0070,0014) *)
  val anchor_point_visibility : tag
  (** (0070,0015) *)
  val graphic_dimensions : tag
  (** (0070,0020) *)
  val number_of_graphic_points : tag
  (** (0070,0021) *)
  val graphic_data : tag
  (** (0070,0022) *)
  val graphic_type : tag
  (** (0070,0023) *)
  val graphic_filled : tag
  (** (0070,0024) *)
  val image_rotation_retired : tag
  (** (0070,0040) *)
  val image_horizontal_flip : tag
  (** (0070,0041) *)
  val image_rotation : tag
  (** (0070,0042) *)
  val displayed_area_top_left_hand_corner_trial : tag
  (** (0070,0050) *)
  val displayed_area_bottom_right_hand_corner_trial : tag
  (** (0070,0051) *)
  val displayed_area_top_left_hand_corner : tag
  (** (0070,0052) *)
  val displayed_area_bottom_right_hand_corner : tag
  (** (0070,0053) *)
  val displayed_area_selection_sequence : tag
  (** (0070,005A) *)
  val graphic_layer_sequence : tag
  (** (0070,0060) *)
  val graphic_layer_order : tag
  (** (0070,0062) *)
  val graphic_layer_recommended_display_grayscale_value : tag
  (** (0070,0066) *)
  val graphic_layer_recommended_display_rgbvalue : tag
  (** (0070,0067) *)
  val graphic_layer_description : tag
  (** (0070,0068) *)
  val content_label : tag
  (** (0070,0080) *)
  val content_description : tag
  (** (0070,0081) *)
  val presentation_creation_date : tag
  (** (0070,0082) *)
  val presentation_creation_time : tag
  (** (0070,0083) *)
  val content_creator_name : tag
  (** (0070,0084) *)
  val content_creator_identification_code_sequence : tag
  (** (0070,0086) *)
  val alternate_content_description_sequence : tag
  (** (0070,0087) *)
  val presentation_size_mode : tag
  (** (0070,0100) *)
  val presentation_pixel_spacing : tag
  (** (0070,0101) *)
  val presentation_pixel_aspect_ratio : tag
  (** (0070,0102) *)
  val presentation_pixel_magnification_ratio : tag
  (** (0070,0103) *)
  val graphic_group_label : tag
  (** (0070,0207) *)
  val graphic_group_description : tag
  (** (0070,0208) *)
  val compound_graphic_sequence : tag
  (** (0070,0209) *)
  val compound_graphic_instance_id : tag
  (** (0070,0226) *)
  val font_name : tag
  (** (0070,0227) *)
  val font_name_type : tag
  (** (0070,0228) *)
  val css_font_name : tag
  (** (0070,0229) *)
  val rotation_angle : tag
  (** (0070,0230) *)
  val text_style_sequence : tag
  (** (0070,0231) *)
  val line_style_sequence : tag
  (** (0070,0232) *)
  val fill_style_sequence : tag
  (** (0070,0233) *)
  val graphic_group_sequence : tag
  (** (0070,0234) *)
  val text_color_cie_lab_value : tag
  (** (0070,0241) *)
  val horizontal_alignment : tag
  (** (0070,0242) *)
  val vertical_alignment : tag
  (** (0070,0243) *)
  val shadow_style : tag
  (** (0070,0244) *)
  val shadow_offset_x : tag
  (** (0070,0245) *)
  val shadow_offset_y : tag
  (** (0070,0246) *)
  val shadow_color_cie_lab_value : tag
  (** (0070,0247) *)
  val underlined : tag
  (** (0070,0248) *)
  val bold : tag
  (** (0070,0249) *)
  val italic : tag
  (** (0070,0250) *)
  val pattern_on_color_cie_lab_value : tag
  (** (0070,0251) *)
  val pattern_off_color_cie_lab_value : tag
  (** (0070,0252) *)
  val line_thickness : tag
  (** (0070,0253) *)
  val line_dashing_style : tag
  (** (0070,0254) *)
  val line_pattern : tag
  (** (0070,0255) *)
  val fill_pattern : tag
  (** (0070,0256) *)
  val fill_mode : tag
  (** (0070,0257) *)
  val shadow_opacity : tag
  (** (0070,0258) *)
  val gap_length : tag
  (** (0070,0261) *)
  val diameter_of_visibility : tag
  (** (0070,0262) *)
  val rotation_point : tag
  (** (0070,0273) *)
  val tick_alignment : tag
  (** (0070,0274) *)
  val show_tick_label : tag
  (** (0070,0278) *)
  val tick_label_alignment : tag
  (** (0070,0279) *)
  val compound_graphic_units : tag
  (** (0070,0282) *)
  val pattern_on_opacity : tag
  (** (0070,0284) *)
  val pattern_off_opacity : tag
  (** (0070,0285) *)
  val major_ticks_sequence : tag
  (** (0070,0287) *)
  val tick_position : tag
  (** (0070,0288) *)
  val tick_label : tag
  (** (0070,0289) *)
  val compound_graphic_type : tag
  (** (0070,0294) *)
  val graphic_group_id : tag
  (** (0070,0295) *)
  val shape_type : tag
  (** (0070,0306) *)
  val registration_sequence : tag
  (** (0070,0308) *)
  val matrix_registration_sequence : tag
  (** (0070,0309) *)
  val matrix_sequence : tag
  (** (0070,030A) *)
  val frame_of_reference_transformation_matrix_type : tag
  (** (0070,030C) *)
  val registration_type_code_sequence : tag
  (** (0070,030D) *)
  val fiducial_description : tag
  (** (0070,030F) *)
  val fiducial_identifier : tag
  (** (0070,0310) *)
  val fiducial_identifier_code_sequence : tag
  (** (0070,0311) *)
  val contour_uncertainty_radius : tag
  (** (0070,0312) *)
  val used_fiducials_sequence : tag
  (** (0070,0314) *)
  val graphic_coordinates_data_sequence : tag
  (** (0070,0318) *)
  val fiducial_uid : tag
  (** (0070,031A) *)
  val fiducial_set_sequence : tag
  (** (0070,031C) *)
  val fiducial_sequence : tag
  (** (0070,031E) *)
  val graphic_layer_recommended_display_cielab_value : tag
  (** (0070,0401) *)
  val blending_sequence : tag
  (** (0070,0402) *)
  val relative_opacity : tag
  (** (0070,0403) *)
  val referenced_spatial_registration_sequence : tag
  (** (0070,0404) *)
  val blending_position : tag
  (** (0070,0405) *)
  val hanging_protocol_name : tag
  (** (0072,0002) *)
  val hanging_protocol_description : tag
  (** (0072,0004) *)
  val hanging_protocol_level : tag
  (** (0072,0006) *)
  val hanging_protocol_creator : tag
  (** (0072,0008) *)
  val hanging_protocol_creation_date_time : tag
  (** (0072,000A) *)
  val hanging_protocol_definition_sequence : tag
  (** (0072,000C) *)
  val hanging_protocol_user_identification_code_sequence : tag
  (** (0072,000E) *)
  val hanging_protocol_user_group_name : tag
  (** (0072,0010) *)
  val source_hanging_protocol_sequence : tag
  (** (0072,0012) *)
  val number_of_priors_referenced : tag
  (** (0072,0014) *)
  val image_sets_sequence : tag
  (** (0072,0020) *)
  val image_set_selector_sequence : tag
  (** (0072,0022) *)
  val image_set_selector_usage_flag : tag
  (** (0072,0024) *)
  val selector_attribute : tag
  (** (0072,0026) *)
  val selector_value_number : tag
  (** (0072,0028) *)
  val time_based_image_sets_sequence : tag
  (** (0072,0030) *)
  val image_set_number : tag
  (** (0072,0032) *)
  val image_set_selector_category : tag
  (** (0072,0034) *)
  val relative_time : tag
  (** (0072,0038) *)
  val relative_time_units : tag
  (** (0072,003A) *)
  val abstract_prior_value : tag
  (** (0072,003C) *)
  val abstract_prior_code_sequence : tag
  (** (0072,003E) *)
  val image_set_label : tag
  (** (0072,0040) *)
  val selector_attribute_vr : tag
  (** (0072,0050) *)
  val selector_sequence_pointer : tag
  (** (0072,0052) *)
  val selector_sequence_pointer_private_creator : tag
  (** (0072,0054) *)
  val selector_attribute_private_creator : tag
  (** (0072,0056) *)
  val selector_at_value : tag
  (** (0072,0060) *)
  val selector_cs_value : tag
  (** (0072,0062) *)
  val selector_is_value : tag
  (** (0072,0064) *)
  val selector_lo_value : tag
  (** (0072,0066) *)
  val selector_lt_value : tag
  (** (0072,0068) *)
  val selector_pn_value : tag
  (** (0072,006A) *)
  val selector_sh_value : tag
  (** (0072,006C) *)
  val selector_st_value : tag
  (** (0072,006E) *)
  val selector_ut_value : tag
  (** (0072,0070) *)
  val selector_ds_value : tag
  (** (0072,0072) *)
  val selector_fd_value : tag
  (** (0072,0074) *)
  val selector_fl_value : tag
  (** (0072,0076) *)
  val selector_ul_value : tag
  (** (0072,0078) *)
  val selector_us_value : tag
  (** (0072,007A) *)
  val selector_sl_value : tag
  (** (0072,007C) *)
  val selector_ss_value : tag
  (** (0072,007E) *)
  val selector_code_sequence_value : tag
  (** (0072,0080) *)
  val number_of_screens : tag
  (** (0072,0100) *)
  val nominal_screen_definition_sequence : tag
  (** (0072,0102) *)
  val number_of_vertical_pixels : tag
  (** (0072,0104) *)
  val number_of_horizontal_pixels : tag
  (** (0072,0106) *)
  val display_environment_spatial_position : tag
  (** (0072,0108) *)
  val screen_minimum_grayscale_bit_depth : tag
  (** (0072,010A) *)
  val screen_minimum_color_bit_depth : tag
  (** (0072,010C) *)
  val application_maximum_repaint_time : tag
  (** (0072,010E) *)
  val display_sets_sequence : tag
  (** (0072,0200) *)
  val display_set_number : tag
  (** (0072,0202) *)
  val display_set_label : tag
  (** (0072,0203) *)
  val display_set_presentation_group : tag
  (** (0072,0204) *)
  val display_set_presentation_group_description : tag
  (** (0072,0206) *)
  val partial_data_display_handling : tag
  (** (0072,0208) *)
  val synchronized_scrolling_sequence : tag
  (** (0072,0210) *)
  val display_set_scrolling_group : tag
  (** (0072,0212) *)
  val navigation_indicator_sequence : tag
  (** (0072,0214) *)
  val navigation_display_set : tag
  (** (0072,0216) *)
  val reference_display_sets : tag
  (** (0072,0218) *)
  val image_boxes_sequence : tag
  (** (0072,0300) *)
  val image_box_number : tag
  (** (0072,0302) *)
  val image_box_layout_type : tag
  (** (0072,0304) *)
  val image_box_tile_horizontal_dimension : tag
  (** (0072,0306) *)
  val image_box_tile_vertical_dimension : tag
  (** (0072,0308) *)
  val image_box_scroll_direction : tag
  (** (0072,0310) *)
  val image_box_small_scroll_type : tag
  (** (0072,0312) *)
  val image_box_small_scroll_amount : tag
  (** (0072,0314) *)
  val image_box_large_scroll_type : tag
  (** (0072,0316) *)
  val image_box_large_scroll_amount : tag
  (** (0072,0318) *)
  val image_box_overlap_priority : tag
  (** (0072,0320) *)
  val cine_relative_to_real_time : tag
  (** (0072,0330) *)
  val filter_operations_sequence : tag
  (** (0072,0400) *)
  val filter_by_category : tag
  (** (0072,0402) *)
  val filter_by_attribute_presence : tag
  (** (0072,0404) *)
  val filter_by_operator : tag
  (** (0072,0406) *)
  val structured_display_background_cielab_value : tag
  (** (0072,0420) *)
  val empty_image_box_cie_lab_value : tag
  (** (0072,0421) *)
  val structured_display_image_box_sequence : tag
  (** (0072,0422) *)
  val structured_display_text_box_sequence : tag
  (** (0072,0424) *)
  val referenced_first_frame_sequence : tag
  (** (0072,0427) *)
  val image_box_synchronization_sequence : tag
  (** (0072,0430) *)
  val synchronized_image_box_list : tag
  (** (0072,0432) *)
  val type_of_synchronization : tag
  (** (0072,0434) *)
  val blending_operation_type : tag
  (** (0072,0500) *)
  val reformatting_operation_type : tag
  (** (0072,0510) *)
  val reformatting_thickness : tag
  (** (0072,0512) *)
  val reformatting_interval : tag
  (** (0072,0514) *)
  val reformatting_operation_initial_view_direction : tag
  (** (0072,0516) *)
  val three_drendering_type : tag
  (** (0072,0520) *)
  val sorting_operations_sequence : tag
  (** (0072,0600) *)
  val sort_by_category : tag
  (** (0072,0602) *)
  val sorting_direction : tag
  (** (0072,0604) *)
  val display_set_patient_orientation : tag
  (** (0072,0700) *)
  val voi_type : tag
  (** (0072,0702) *)
  val pseudo_color_type : tag
  (** (0072,0704) *)
  val pseudo_color_palette_instance_reference_sequence : tag
  (** (0072,0705) *)
  val show_grayscale_inverted : tag
  (** (0072,0706) *)
  val show_image_true_size_flag : tag
  (** (0072,0710) *)
  val show_graphic_annotation_flag : tag
  (** (0072,0712) *)
  val show_patient_demographics_flag : tag
  (** (0072,0714) *)
  val show_acquisition_techniques_flag : tag
  (** (0072,0716) *)
  val display_set_horizontal_justification : tag
  (** (0072,0717) *)
  val display_set_vertical_justification : tag
  (** (0072,0718) *)
  val continuation_start_meterset : tag
  (** (0074,0120) *)
  val continuation_end_meterset : tag
  (** (0074,0121) *)
  val procedure_step_state : tag
  (** (0074,1000) *)
  val procedure_step_progress_information_sequence : tag
  (** (0074,1002) *)
  val procedure_step_progress : tag
  (** (0074,1004) *)
  val procedure_step_progress_description : tag
  (** (0074,1006) *)
  val procedure_step_communications_urisequence : tag
  (** (0074,1008) *)
  val contact_uri : tag
  (** (0074,100a) *)
  val contact_display_name : tag
  (** (0074,100c) *)
  val procedure_step_discontinuation_reason_code_sequence : tag
  (** (0074,100e) *)
  val beam_task_sequence : tag
  (** (0074,1020) *)
  val beam_task_type : tag
  (** (0074,1022) *)
  val beam_order_index_trial : tag
  (** (0074,1024) *)
  val table_top_vertical_adjusted_position : tag
  (** (0074,1026) *)
  val table_top_longitudinal_adjusted_position : tag
  (** (0074,1027) *)
  val table_top_lateral_adjusted_position : tag
  (** (0074,1028) *)
  val patient_support_adjusted_angle : tag
  (** (0074,102A) *)
  val table_top_eccentric_adjusted_angle : tag
  (** (0074,102B) *)
  val table_top_pitch_adjusted_angle : tag
  (** (0074,102C) *)
  val table_top_roll_adjusted_angle : tag
  (** (0074,102D) *)
  val delivery_verification_image_sequence : tag
  (** (0074,1030) *)
  val verification_image_timing : tag
  (** (0074,1032) *)
  val double_exposure_flag : tag
  (** (0074,1034) *)
  val double_exposure_ordering : tag
  (** (0074,1036) *)
  val double_exposure_meterset_trial : tag
  (** (0074,1038) *)
  val double_exposure_field_delta_trial : tag
  (** (0074,103A) *)
  val related_reference_rtimage_sequence : tag
  (** (0074,1040) *)
  val general_machine_verification_sequence : tag
  (** (0074,1042) *)
  val conventional_machine_verification_sequence : tag
  (** (0074,1044) *)
  val ion_machine_verification_sequence : tag
  (** (0074,1046) *)
  val failed_attributes_sequence : tag
  (** (0074,1048) *)
  val overridden_attributes_sequence : tag
  (** (0074,104A) *)
  val conventional_control_point_verification_sequence : tag
  (** (0074,104C) *)
  val ion_control_point_verification_sequence : tag
  (** (0074,104E) *)
  val attribute_occurrence_sequence : tag
  (** (0074,1050) *)
  val attribute_occurrence_pointer : tag
  (** (0074,1052) *)
  val attribute_item_selector : tag
  (** (0074,1054) *)
  val attribute_occurrence_private_creator : tag
  (** (0074,1056) *)
  val selector_sequence_pointer_items : tag
  (** (0074,1057) *)
  val scheduled_procedure_step_priority : tag
  (** (0074,1200) *)
  val worklist_label : tag
  (** (0074,1202) *)
  val procedure_step_label : tag
  (** (0074,1204) *)
  val scheduled_processing_parameters_sequence : tag
  (** (0074,1210) *)
  val performed_processing_parameters_sequence : tag
  (** (0074,1212) *)
  val unified_procedure_step_performed_procedure_sequence : tag
  (** (0074,1216) *)
  val related_procedure_step_sequence : tag
  (** (0074,1220) *)
  val procedure_step_relationship_type : tag
  (** (0074,1222) *)
  val replaced_procedure_step_sequence : tag
  (** (0074,1224) *)
  val deletion_lock : tag
  (** (0074,1230) *)
  val receiving_ae : tag
  (** (0074,1234) *)
  val requesting_ae : tag
  (** (0074,1236) *)
  val reason_for_cancellation : tag
  (** (0074,1238) *)
  val scp_status : tag
  (** (0074,1242) *)
  val subscription_list_status : tag
  (** (0074,1244) *)
  val unified_procedure_step_list_status : tag
  (** (0074,1246) *)
  val beam_order_index : tag
  (** (0074,1324) *)
  val double_exposure_meterset : tag
  (** (0074,1338) *)
  val double_exposure_field_delta : tag
  (** (0074,133A) *)
  val implant_assembly_template_name : tag
  (** (0076,0001) *)
  val implant_assembly_template_issuer : tag
  (** (0076,0003) *)
  val implant_assembly_template_version : tag
  (** (0076,0006) *)
  val replaced_implant_assembly_template_sequence : tag
  (** (0076,0008) *)
  val implant_assembly_template_type : tag
  (** (0076,000A) *)
  val original_implant_assembly_template_sequence : tag
  (** (0076,000C) *)
  val derivation_implant_assembly_template_sequence : tag
  (** (0076,000E) *)
  val implant_assembly_template_target_anatomy_sequence : tag
  (** (0076,0010) *)
  val procedure_type_code_sequence : tag
  (** (0076,0020) *)
  val surgical_technique : tag
  (** (0076,0030) *)
  val component_types_sequence : tag
  (** (0076,0032) *)
  val component_type_code_sequence : tag
  (** (0076,0034) *)
  val exclusive_component_type : tag
  (** (0076,0036) *)
  val mandatory_component_type : tag
  (** (0076,0038) *)
  val component_sequence : tag
  (** (0076,0040) *)
  val component_id : tag
  (** (0076,0055) *)
  val component_assembly_sequence : tag
  (** (0076,0060) *)
  val component1_referenced_id : tag
  (** (0076,0070) *)
  val component1_referenced_mating_feature_set_id : tag
  (** (0076,0080) *)
  val component1_referenced_mating_feature_id : tag
  (** (0076,0090) *)
  val component2_referenced_id : tag
  (** (0076,00A0) *)
  val component2_referenced_mating_feature_set_id : tag
  (** (0076,00B0) *)
  val component2_referenced_mating_feature_id : tag
  (** (0076,00C0) *)
  val implant_template_group_name : tag
  (** (0078,0001) *)
  val implant_template_group_description : tag
  (** (0078,0010) *)
  val implant_template_group_issuer : tag
  (** (0078,0020) *)
  val implant_template_group_version : tag
  (** (0078,0024) *)
  val replaced_implant_template_group_sequence : tag
  (** (0078,0026) *)
  val implant_template_group_target_anatomy_sequence : tag
  (** (0078,0028) *)
  val implant_template_group_members_sequence : tag
  (** (0078,002A) *)
  val implant_template_group_member_id : tag
  (** (0078,002E) *)
  val three_d_implant_template_group_member_matching_point : tag
  (** (0078,0050) *)
  val three_d_implant_template_group_member_matching_axes : tag
  (** (0078,0060) *)
  val implant_template_group_member_matching2_dcoordinates_sequence : tag
  (** (0078,0070) *)
  val two_d_implant_template_group_member_matching_point : tag
  (** (0078,0090) *)
  val two_d_implant_template_group_member_matching_axes : tag
  (** (0078,00A0) *)
  val implant_template_group_variation_dimension_sequence : tag
  (** (0078,00B0) *)
  val implant_template_group_variation_dimension_name : tag
  (** (0078,00B2) *)
  val implant_template_group_variation_dimension_rank_sequence : tag
  (** (0078,00B4) *)
  val referenced_implant_template_group_member_id : tag
  (** (0078,00B6) *)
  val implant_template_group_variation_dimension_rank : tag
  (** (0078,00B8) *)
  val storage_media_file_set_id : tag
  (** (0088,0130) *)
  val storage_media_file_set_uid : tag
  (** (0088,0140) *)
  val icon_image_sequence : tag
  (** (0088,0200) *)
  val topic_title : tag
  (** (0088,0904) *)
  val topic_subject : tag
  (** (0088,0906) *)
  val topic_author : tag
  (** (0088,0910) *)
  val topic_keywords : tag
  (** (0088,0912) *)
  val sop_instance_status : tag
  (** (0100,0410) *)
  val sop_authorization_date_time : tag
  (** (0100,0420) *)
  val sop_authorization_comment : tag
  (** (0100,0424) *)
  val authorization_equipment_certification_number : tag
  (** (0100,0426) *)
  val mac_id_number : tag
  (** (0400,0005) *)
  val mac_calculation_transfer_syntax_uid : tag
  (** (0400,0010) *)
  val mac_algorithm : tag
  (** (0400,0015) *)
  val data_elements_signed : tag
  (** (0400,0020) *)
  val digital_signature_uid : tag
  (** (0400,0100) *)
  val digital_signature_date_time : tag
  (** (0400,0105) *)
  val certificate_type : tag
  (** (0400,0110) *)
  val certificate_of_signer : tag
  (** (0400,0115) *)
  val signature : tag
  (** (0400,0120) *)
  val certified_timestamp_type : tag
  (** (0400,0305) *)
  val certified_timestamp : tag
  (** (0400,0310) *)
  val digital_signature_purpose_code_sequence : tag
  (** (0400,0401) *)
  val referenced_digital_signature_sequence : tag
  (** (0400,0402) *)
  val referenced_sop_instance_mac_sequence : tag
  (** (0400,0403) *)
  val mac : tag
  (** (0400,0404) *)
  val encrypted_attributes_sequence : tag
  (** (0400,0500) *)
  val encrypted_content_transfer_syntax_uid : tag
  (** (0400,0510) *)
  val encrypted_content : tag
  (** (0400,0520) *)
  val modified_attributes_sequence : tag
  (** (0400,0550) *)
  val original_attributes_sequence : tag
  (** (0400,0561) *)
  val attribute_modification_date_time : tag
  (** (0400,0562) *)
  val modifying_system : tag
  (** (0400,0563) *)
  val source_of_previous_values : tag
  (** (0400,0564) *)
  val reason_for_the_attribute_modification : tag
  (** (0400,0565) *)
  val escape_triplet : tag
  (** (1000,0000) *)
  val run_length_triplet : tag
  (** (1000,0001) *)
  val huffman_table_size : tag
  (** (1000,0002) *)
  val huffman_table_triplet : tag
  (** (1000,0003) *)
  val shift_table_size : tag
  (** (1000,0004) *)
  val shift_table_triplet : tag
  (** (1000,0005) *)
  val zonal_map : tag
  (** (1010,0000) *)
  val number_of_copies : tag
  (** (2000,0010) *)
  val printer_configuration_sequence : tag
  (** (2000,001E) *)
  val print_priority : tag
  (** (2000,0020) *)
  val medium_type : tag
  (** (2000,0030) *)
  val film_destination : tag
  (** (2000,0040) *)
  val film_session_label : tag
  (** (2000,0050) *)
  val memory_allocation : tag
  (** (2000,0060) *)
  val maximum_memory_allocation : tag
  (** (2000,0061) *)
  val color_image_printing_flag : tag
  (** (2000,0062) *)
  val collation_flag : tag
  (** (2000,0063) *)
  val annotation_flag : tag
  (** (2000,0065) *)
  val image_overlay_flag : tag
  (** (2000,0067) *)
  val presentation_lut_flag : tag
  (** (2000,0069) *)
  val image_box_presentation_lutflag : tag
  (** (2000,006A) *)
  val memory_bit_depth : tag
  (** (2000,00A0) *)
  val printing_bit_depth : tag
  (** (2000,00A1) *)
  val media_installed_sequence : tag
  (** (2000,00A2) *)
  val other_media_available_sequence : tag
  (** (2000,00A4) *)
  val supported_image_display_formats_sequence : tag
  (** (2000,00A8) *)
  val referenced_film_box_sequence : tag
  (** (2000,0500) *)
  val referenced_stored_print_sequence : tag
  (** (2000,0510) *)
  val image_display_format : tag
  (** (2010,0010) *)
  val annotation_display_format_id : tag
  (** (2010,0030) *)
  val film_orientation : tag
  (** (2010,0040) *)
  val film_size_id : tag
  (** (2010,0050) *)
  val printer_resolution_id : tag
  (** (2010,0052) *)
  val default_printer_resolution_id : tag
  (** (2010,0054) *)
  val magnification_type : tag
  (** (2010,0060) *)
  val smoothing_type : tag
  (** (2010,0080) *)
  val default_magnification_type : tag
  (** (2010,00A6) *)
  val other_magnification_types_available : tag
  (** (2010,00A7) *)
  val default_smoothing_type : tag
  (** (2010,00A8) *)
  val other_smoothing_types_available : tag
  (** (2010,00A9) *)
  val border_density : tag
  (** (2010,0100) *)
  val empty_image_density : tag
  (** (2010,0110) *)
  val min_density : tag
  (** (2010,0120) *)
  val max_density : tag
  (** (2010,0130) *)
  val trim : tag
  (** (2010,0140) *)
  val configuration_information : tag
  (** (2010,0150) *)
  val configuration_information_description : tag
  (** (2010,0152) *)
  val maximum_collated_films : tag
  (** (2010,0154) *)
  val illumination : tag
  (** (2010,015E) *)
  val reflected_ambient_light : tag
  (** (2010,0160) *)
  val printer_pixel_spacing : tag
  (** (2010,0376) *)
  val referenced_film_session_sequence : tag
  (** (2010,0500) *)
  val referenced_image_box_sequence : tag
  (** (2010,0510) *)
  val referenced_basic_annotation_box_sequence : tag
  (** (2010,0520) *)
  val image_box_position : tag
  (** (2020,0010) *)
  val polarity : tag
  (** (2020,0020) *)
  val requested_image_size : tag
  (** (2020,0030) *)
  val requested_decimate_crop_behavior : tag
  (** (2020,0040) *)
  val requested_resolution_id : tag
  (** (2020,0050) *)
  val requested_image_size_flag : tag
  (** (2020,00A0) *)
  val decimate_crop_result : tag
  (** (2020,00A2) *)
  val basic_grayscale_image_sequence : tag
  (** (2020,0110) *)
  val basic_color_image_sequence : tag
  (** (2020,0111) *)
  val referenced_image_overlay_box_sequence : tag
  (** (2020,0130) *)
  val referenced_voilutbox_sequence : tag
  (** (2020,0140) *)
  val annotation_position : tag
  (** (2030,0010) *)
  val text_string : tag
  (** (2030,0020) *)
  val referenced_overlay_plane_sequence : tag
  (** (2040,0010) *)
  val referenced_overlay_plane_groups : tag
  (** (2040,0011) *)
  val overlay_pixel_data_sequence : tag
  (** (2040,0020) *)
  val overlay_magnification_type : tag
  (** (2040,0060) *)
  val overlay_smoothing_type : tag
  (** (2040,0070) *)
  val overlay_or_image_magnification : tag
  (** (2040,0072) *)
  val magnify_to_number_of_columns : tag
  (** (2040,0074) *)
  val overlay_foreground_density : tag
  (** (2040,0080) *)
  val overlay_background_density : tag
  (** (2040,0082) *)
  val overlay_mode : tag
  (** (2040,0090) *)
  val threshold_density : tag
  (** (2040,0100) *)
  val referenced_image_box_sequence_retired : tag
  (** (2040,0500) *)
  val presentation_lutsequence : tag
  (** (2050,0010) *)
  val presentation_lutshape : tag
  (** (2050,0020) *)
  val referenced_presentation_lutsequence : tag
  (** (2050,0500) *)
  val print_job_id : tag
  (** (2100,0010) *)
  val execution_status : tag
  (** (2100,0020) *)
  val execution_status_info : tag
  (** (2100,0030) *)
  val creation_date : tag
  (** (2100,0040) *)
  val creation_time : tag
  (** (2100,0050) *)
  val originator : tag
  (** (2100,0070) *)
  val destination_ae : tag
  (** (2100,0140) *)
  val owner_id : tag
  (** (2100,0160) *)
  val number_of_films : tag
  (** (2100,0170) *)
  val referenced_print_job_sequence_pull_stored_print : tag
  (** (2100,0500) *)
  val printer_status : tag
  (** (2110,0010) *)
  val printer_status_info : tag
  (** (2110,0020) *)
  val printer_name : tag
  (** (2110,0030) *)
  val print_queue_id : tag
  (** (2110,0099) *)
  val queue_status : tag
  (** (2120,0010) *)
  val print_job_description_sequence : tag
  (** (2120,0050) *)
  val referenced_print_job_sequence : tag
  (** (2120,0070) *)
  val print_management_capabilities_sequence : tag
  (** (2130,0010) *)
  val printer_characteristics_sequence : tag
  (** (2130,0015) *)
  val film_box_content_sequence : tag
  (** (2130,0030) *)
  val image_box_content_sequence : tag
  (** (2130,0040) *)
  val annotation_content_sequence : tag
  (** (2130,0050) *)
  val image_overlay_box_content_sequence : tag
  (** (2130,0060) *)
  val presentation_lut_content_sequence : tag
  (** (2130,0080) *)
  val proposed_study_sequence : tag
  (** (2130,00A0) *)
  val original_image_sequence : tag
  (** (2130,00C0) *)
  val label_using_information_extracted_from_instances : tag
  (** (2200,0001) *)
  val label_text : tag
  (** (2200,0002) *)
  val label_style_selection : tag
  (** (2200,0003) *)
  val media_disposition : tag
  (** (2200,0004) *)
  val barcode_value : tag
  (** (2200,0005) *)
  val barcode_symbology : tag
  (** (2200,0006) *)
  val allow_media_splitting : tag
  (** (2200,0007) *)
  val include_non_dicomobjects : tag
  (** (2200,0008) *)
  val include_display_application : tag
  (** (2200,0009) *)
  val preserve_composite_instances_after_media_creation : tag
  (** (2200,000A) *)
  val total_number_of_pieces_of_media_created : tag
  (** (2200,000B) *)
  val requested_media_application_profile : tag
  (** (2200,000C) *)
  val referenced_storage_media_sequence : tag
  (** (2200,000D) *)
  val failure_attributes : tag
  (** (2200,000E) *)
  val allow_lossy_compression : tag
  (** (2200,000F) *)
  val request_priority : tag
  (** (2200,0020) *)
  val rt_image_label : tag
  (** (3002,0002) *)
  val rt_image_name : tag
  (** (3002,0003) *)
  val rt_image_description : tag
  (** (3002,0004) *)
  val reported_values_origin : tag
  (** (3002,000A) *)
  val rt_image_plane : tag
  (** (3002,000C) *)
  val x_ray_image_receptor_translation : tag
  (** (3002,000D) *)
  val x_ray_image_receptor_angle : tag
  (** (3002,000E) *)
  val rt_image_orientation : tag
  (** (3002,0010) *)
  val image_plane_pixel_spacing : tag
  (** (3002,0011) *)
  val rt_image_position : tag
  (** (3002,0012) *)
  val radiation_machine_name : tag
  (** (3002,0020) *)
  val radiation_machine_sad : tag
  (** (3002,0022) *)
  val radiation_machine_ssd : tag
  (** (3002,0024) *)
  val rt_image_sid : tag
  (** (3002,0026) *)
  val source_to_reference_object_distance : tag
  (** (3002,0028) *)
  val fraction_number : tag
  (** (3002,0029) *)
  val exposure_sequence : tag
  (** (3002,0030) *)
  val meterset_exposure : tag
  (** (3002,0032) *)
  val diaphragm_position : tag
  (** (3002,0034) *)
  val fluence_map_sequence : tag
  (** (3002,0040) *)
  val fluence_data_source : tag
  (** (3002,0041) *)
  val fluence_data_scale : tag
  (** (3002,0042) *)
  val primary_fluence_mode_sequence : tag
  (** (3002,0050) *)
  val fluence_mode : tag
  (** (3002,0051) *)
  val fluence_mode_id : tag
  (** (3002,0052) *)
  val dvh_type : tag
  (** (3004,0001) *)
  val dose_units : tag
  (** (3004,0002) *)
  val dose_type : tag
  (** (3004,0004) *)
  val dose_comment : tag
  (** (3004,0006) *)
  val normalization_point : tag
  (** (3004,0008) *)
  val dose_summation_type : tag
  (** (3004,000A) *)
  val grid_frame_offset_vector : tag
  (** (3004,000C) *)
  val dose_grid_scaling : tag
  (** (3004,000E) *)
  val rt_dose_roi_sequence : tag
  (** (3004,0010) *)
  val dose_value : tag
  (** (3004,0012) *)
  val tissue_heterogeneity_correction : tag
  (** (3004,0014) *)
  val dvh_normalization_point : tag
  (** (3004,0040) *)
  val dvh_normalization_dose_value : tag
  (** (3004,0042) *)
  val dvh_sequence : tag
  (** (3004,0050) *)
  val dvh_dose_scaling : tag
  (** (3004,0052) *)
  val dvh_volume_units : tag
  (** (3004,0054) *)
  val dvh_number_of_bins : tag
  (** (3004,0056) *)
  val dvh_data : tag
  (** (3004,0058) *)
  val dvh_referenced_roisequence : tag
  (** (3004,0060) *)
  val dvh_roicontribution_type : tag
  (** (3004,0062) *)
  val dvh_minimum_dose : tag
  (** (3004,0070) *)
  val dvh_maximum_dose : tag
  (** (3004,0072) *)
  val dvh_mean_dose : tag
  (** (3004,0074) *)
  val structure_set_label : tag
  (** (3006,0002) *)
  val structure_set_name : tag
  (** (3006,0004) *)
  val structure_set_description : tag
  (** (3006,0006) *)
  val structure_set_date : tag
  (** (3006,0008) *)
  val structure_set_time : tag
  (** (3006,0009) *)
  val referenced_frame_of_reference_sequence : tag
  (** (3006,0010) *)
  val rt_referenced_study_sequence : tag
  (** (3006,0012) *)
  val rt_referenced_series_sequence : tag
  (** (3006,0014) *)
  val contour_image_sequence : tag
  (** (3006,0016) *)
  val structure_set_roisequence : tag
  (** (3006,0020) *)
  val roi_number : tag
  (** (3006,0022) *)
  val referenced_frame_of_reference_uid : tag
  (** (3006,0024) *)
  val roiname : tag
  (** (3006,0026) *)
  val roidescription : tag
  (** (3006,0028) *)
  val roidisplaycolor : tag
  (** (3006,002A) *)
  val roivolume : tag
  (** (3006,002C) *)
  val rtrelatedroisequence : tag
  (** (3006,0030) *)
  val rtroirelationship : tag
  (** (3006,0033) *)
  val roigenerationalgorithm : tag
  (** (3006,0036) *)
  val roigenerationdescription : tag
  (** (3006,0038) *)
  val roicontoursequence : tag
  (** (3006,0039) *)
  val contour_sequence : tag
  (** (3006,0040) *)
  val contour_geometric_type : tag
  (** (3006,0042) *)
  val contour_slab_thickness : tag
  (** (3006,0044) *)
  val contour_offset_vector : tag
  (** (3006,0045) *)
  val number_of_contour_points : tag
  (** (3006,0046) *)
  val contour_number : tag
  (** (3006,0048) *)
  val attached_contours : tag
  (** (3006,0049) *)
  val contour_data : tag
  (** (3006,0050) *)
  val rt_roi_observations_sequence : tag
  (** (3006,0080) *)
  val observation_number : tag
  (** (3006,0082) *)
  val referenced_roinumber : tag
  (** (3006,0084) *)
  val roi_observation_label : tag
  (** (3006,0085) *)
  val rt_roi_identification_code_sequence : tag
  (** (3006,0086) *)
  val roi_observation_description : tag
  (** (3006,0088) *)
  val related_rt_roi_observations_sequence : tag
  (** (3006,00A0) *)
  val rt_roi_interpreted_type : tag
  (** (3006,00A4) *)
  val roi_interpreter : tag
  (** (3006,00A6) *)
  val roi_physical_properties_sequence : tag
  (** (3006,00B0) *)
  val roi_physical_property : tag
  (** (3006,00B2) *)
  val roi_physical_property_value : tag
  (** (3006,00B4) *)
  val roi_elemental_composition_sequence : tag
  (** (3006,00B6) *)
  val roi_elemental_composition_atomic_number : tag
  (** (3006,00B7) *)
  val roi_elemental_composition_atomic_mass_fraction : tag
  (** (3006,00B8) *)
  val frame_of_reference_relationship_sequence : tag
  (** (3006,00C0) *)
  val related_frame_of_reference_uid : tag
  (** (3006,00C2) *)
  val frame_of_reference_transformation_type : tag
  (** (3006,00C4) *)
  val frame_of_reference_transformation_matrix : tag
  (** (3006,00C6) *)
  val frame_of_reference_transformation_comment : tag
  (** (3006,00C8) *)
  val measured_dose_reference_sequence : tag
  (** (3008,0010) *)
  val measured_dose_description : tag
  (** (3008,0012) *)
  val measured_dose_type : tag
  (** (3008,0014) *)
  val measured_dose_value : tag
  (** (3008,0016) *)
  val treatment_session_beam_sequence : tag
  (** (3008,0020) *)
  val treatment_session_ion_beam_sequence : tag
  (** (3008,0021) *)
  val current_fraction_number : tag
  (** (3008,0022) *)
  val treatment_control_point_date : tag
  (** (3008,0024) *)
  val treatment_control_point_time : tag
  (** (3008,0025) *)
  val treatment_termination_status : tag
  (** (3008,002A) *)
  val treatment_termination_code : tag
  (** (3008,002B) *)
  val treatment_verification_status : tag
  (** (3008,002C) *)
  val referenced_treatment_record_sequence : tag
  (** (3008,0030) *)
  val specified_primary_meterset : tag
  (** (3008,0032) *)
  val specified_secondary_meterset : tag
  (** (3008,0033) *)
  val delivered_primary_meterset : tag
  (** (3008,0036) *)
  val delivered_secondary_meterset : tag
  (** (3008,0037) *)
  val specified_treatment_time : tag
  (** (3008,003A) *)
  val delivered_treatment_time : tag
  (** (3008,003B) *)
  val control_point_delivery_sequence : tag
  (** (3008,0040) *)
  val ion_control_point_delivery_sequence : tag
  (** (3008,0041) *)
  val specified_meterset : tag
  (** (3008,0042) *)
  val delivered_meterset : tag
  (** (3008,0044) *)
  val meterset_rate_set : tag
  (** (3008,0045) *)
  val meterset_rate_delivered : tag
  (** (3008,0046) *)
  val scan_spot_metersets_delivered : tag
  (** (3008,0047) *)
  val dose_rate_delivered : tag
  (** (3008,0048) *)
  val treatment_summary_calculated_dose_reference_sequence : tag
  (** (3008,0050) *)
  val cumulative_dose_to_dose_reference : tag
  (** (3008,0052) *)
  val first_treatment_date : tag
  (** (3008,0054) *)
  val most_recent_treatment_date : tag
  (** (3008,0056) *)
  val number_of_fractions_delivered : tag
  (** (3008,005A) *)
  val override_sequence : tag
  (** (3008,0060) *)
  val parameter_sequence_pointer : tag
  (** (3008,0061) *)
  val override_parameter_pointer : tag
  (** (3008,0062) *)
  val parameter_item_index : tag
  (** (3008,0063) *)
  val measured_dose_reference_number : tag
  (** (3008,0064) *)
  val parameter_pointer : tag
  (** (3008,0065) *)
  val override_reason : tag
  (** (3008,0066) *)
  val corrected_parameter_sequence : tag
  (** (3008,0068) *)
  val correction_value : tag
  (** (3008,006A) *)
  val calculated_dose_reference_sequence : tag
  (** (3008,0070) *)
  val calculated_dose_reference_number : tag
  (** (3008,0072) *)
  val calculated_dose_reference_description : tag
  (** (3008,0074) *)
  val calculated_dose_reference_dose_value : tag
  (** (3008,0076) *)
  val start_meterset : tag
  (** (3008,0078) *)
  val end_meterset : tag
  (** (3008,007A) *)
  val referenced_measured_dose_reference_sequence : tag
  (** (3008,0080) *)
  val referenced_measured_dose_reference_number : tag
  (** (3008,0082) *)
  val referenced_calculated_dose_reference_sequence : tag
  (** (3008,0090) *)
  val referenced_calculated_dose_reference_number : tag
  (** (3008,0092) *)
  val beam_limiting_device_leaf_pairs_sequence : tag
  (** (3008,00A0) *)
  val recorded_wedge_sequence : tag
  (** (3008,00B0) *)
  val recorded_compensator_sequence : tag
  (** (3008,00C0) *)
  val recorded_block_sequence : tag
  (** (3008,00D0) *)
  val treatment_summary_measured_dose_reference_sequence : tag
  (** (3008,00E0) *)
  val recorded_snout_sequence : tag
  (** (3008,00F0) *)
  val recorded_range_shifter_sequence : tag
  (** (3008,00F2) *)
  val recorded_lateral_spreading_device_sequence : tag
  (** (3008,00F4) *)
  val recorded_range_modulator_sequence : tag
  (** (3008,00F6) *)
  val recorded_source_sequence : tag
  (** (3008,0100) *)
  val source_serial_number : tag
  (** (3008,0105) *)
  val treatment_session_application_setup_sequence : tag
  (** (3008,0110) *)
  val application_setup_check : tag
  (** (3008,0116) *)
  val recorded_brachy_accessory_device_sequence : tag
  (** (3008,0120) *)
  val referenced_brachy_accessory_device_number : tag
  (** (3008,0122) *)
  val recorded_channel_sequence : tag
  (** (3008,0130) *)
  val specified_channel_total_time : tag
  (** (3008,0132) *)
  val delivered_channel_total_time : tag
  (** (3008,0134) *)
  val specified_number_of_pulses : tag
  (** (3008,0136) *)
  val delivered_number_of_pulses : tag
  (** (3008,0138) *)
  val specified_pulse_repetition_interval : tag
  (** (3008,013A) *)
  val delivered_pulse_repetition_interval : tag
  (** (3008,013C) *)
  val recorded_source_applicator_sequence : tag
  (** (3008,0140) *)
  val referenced_source_applicator_number : tag
  (** (3008,0142) *)
  val recorded_channel_shield_sequence : tag
  (** (3008,0150) *)
  val referenced_channel_shield_number : tag
  (** (3008,0152) *)
  val brachy_control_point_delivered_sequence : tag
  (** (3008,0160) *)
  val safe_position_exit_date : tag
  (** (3008,0162) *)
  val safe_position_exit_time : tag
  (** (3008,0164) *)
  val safe_position_return_date : tag
  (** (3008,0166) *)
  val safe_position_return_time : tag
  (** (3008,0168) *)
  val current_treatment_status : tag
  (** (3008,0200) *)
  val treatment_status_comment : tag
  (** (3008,0202) *)
  val fraction_group_summary_sequence : tag
  (** (3008,0220) *)
  val referenced_fraction_number : tag
  (** (3008,0223) *)
  val fraction_group_type : tag
  (** (3008,0224) *)
  val beam_stopper_position : tag
  (** (3008,0230) *)
  val fraction_status_summary_sequence : tag
  (** (3008,0240) *)
  val treatment_date : tag
  (** (3008,0250) *)
  val treatment_time : tag
  (** (3008,0251) *)
  val rt_plan_label : tag
  (** (300A,0002) *)
  val rt_plan_name : tag
  (** (300A,0003) *)
  val rt_plan_description : tag
  (** (300A,0004) *)
  val rt_plan_date : tag
  (** (300A,0006) *)
  val rt_plan_time : tag
  (** (300A,0007) *)
  val treatment_protocols : tag
  (** (300A,0009) *)
  val plan_intent : tag
  (** (300A,000A) *)
  val treatment_sites : tag
  (** (300A,000B) *)
  val r_tplan_geometry : tag
  (** (300A,000C) *)
  val prescription_description : tag
  (** (300A,000E) *)
  val dose_reference_sequence : tag
  (** (300A,0010) *)
  val dose_reference_number : tag
  (** (300A,0012) *)
  val dose_reference_uid : tag
  (** (300A,0013) *)
  val dose_reference_structure_type : tag
  (** (300A,0014) *)
  val nominal_beam_energy_unit : tag
  (** (300A,0015) *)
  val dose_reference_description : tag
  (** (300A,0016) *)
  val dose_reference_point_coordinates : tag
  (** (300A,0018) *)
  val nominal_prior_dose : tag
  (** (300A,001A) *)
  val dose_reference_type : tag
  (** (300A,0020) *)
  val constraint_weight : tag
  (** (300A,0021) *)
  val delivery_warning_dose : tag
  (** (300A,0022) *)
  val delivery_maximum_dose : tag
  (** (300A,0023) *)
  val target_minimum_dose : tag
  (** (300A,0025) *)
  val target_prescription_dose : tag
  (** (300A,0026) *)
  val target_maximum_dose : tag
  (** (300A,0027) *)
  val target_underdose_volume_fraction : tag
  (** (300A,0028) *)
  val organ_at_risk_full_volume_dose : tag
  (** (300A,002A) *)
  val organ_at_risk_limit_dose : tag
  (** (300A,002B) *)
  val organ_at_risk_maximum_dose : tag
  (** (300A,002C) *)
  val organ_at_risk_overdose_volume_fraction : tag
  (** (300A,002D) *)
  val tolerance_table_sequence : tag
  (** (300A,0040) *)
  val tolerance_table_number : tag
  (** (300A,0042) *)
  val tolerance_table_label : tag
  (** (300A,0043) *)
  val gantry_angle_tolerance : tag
  (** (300A,0044) *)
  val beam_limiting_device_angle_tolerance : tag
  (** (300A,0046) *)
  val beam_limiting_device_tolerance_sequence : tag
  (** (300A,0048) *)
  val beam_limiting_device_position_tolerance : tag
  (** (300A,004A) *)
  val snout_position_tolerance : tag
  (** (300A,004B) *)
  val patient_support_angle_tolerance : tag
  (** (300A,004C) *)
  val table_top_eccentric_angle_tolerance : tag
  (** (300A,004E) *)
  val table_top_pitch_angle_tolerance : tag
  (** (300A,004F) *)
  val table_top_roll_angle_tolerance : tag
  (** (300A,0050) *)
  val table_top_vertical_position_tolerance : tag
  (** (300A,0051) *)
  val table_top_longitudinal_position_tolerance : tag
  (** (300A,0052) *)
  val table_top_lateral_position_tolerance : tag
  (** (300A,0053) *)
  val rt_plan_relationship : tag
  (** (300A,0055) *)
  val fraction_group_sequence : tag
  (** (300A,0070) *)
  val fraction_group_number : tag
  (** (300A,0071) *)
  val fraction_group_description : tag
  (** (300A,0072) *)
  val number_of_fractions_planned : tag
  (** (300A,0078) *)
  val number_of_fraction_pattern_digits_per_day : tag
  (** (300A,0079) *)
  val repeat_fraction_cycle_length : tag
  (** (300A,007A) *)
  val fraction_pattern : tag
  (** (300A,007B) *)
  val number_of_beams : tag
  (** (300A,0080) *)
  val beam_dose_specification_point : tag
  (** (300A,0082) *)
  val beam_dose : tag
  (** (300A,0084) *)
  val beam_meterset : tag
  (** (300A,0086) *)
  val beam_dose_point_depth : tag
  (** (300A,0088) *)
  val beam_dose_point_equivalent_depth : tag
  (** (300A,0089) *)
  val beam_dose_point_ssd : tag
  (** (300A,008A) *)
  val number_of_brachy_application_setups : tag
  (** (300A,00A0) *)
  val brachy_application_setup_dose_specification_point : tag
  (** (300A,00A2) *)
  val brachy_application_setup_dose : tag
  (** (300A,00A4) *)
  val beam_sequence : tag
  (** (300A,00B0) *)
  val treatment_machine_name : tag
  (** (300A,00B2) *)
  val primary_dosimeter_unit : tag
  (** (300A,00B3) *)
  val source_axis_distance : tag
  (** (300A,00B4) *)
  val beam_limiting_device_sequence : tag
  (** (300A,00B6) *)
  val r_tbeam_limiting_device_type : tag
  (** (300A,00B8) *)
  val source_to_beam_limiting_device_distance : tag
  (** (300A,00BA) *)
  val isocenter_to_beam_limiting_device_distance : tag
  (** (300A,00BB) *)
  val number_of_leaf_jaw_pairs : tag
  (** (300A,00BC) *)
  val leaf_position_boundaries : tag
  (** (300A,00BE) *)
  val beam_number : tag
  (** (300A,00C0) *)
  val beam_name : tag
  (** (300A,00C2) *)
  val beam_description : tag
  (** (300A,00C3) *)
  val beam_type : tag
  (** (300A,00C4) *)
  val radiation_type : tag
  (** (300A,00C6) *)
  val high_dose_technique_type : tag
  (** (300A,00C7) *)
  val reference_image_number : tag
  (** (300A,00C8) *)
  val planned_verification_image_sequence : tag
  (** (300A,00CA) *)
  val imaging_device_specific_acquisition_parameters : tag
  (** (300A,00CC) *)
  val treatment_delivery_type : tag
  (** (300A,00CE) *)
  val number_of_wedges : tag
  (** (300A,00D0) *)
  val wedge_sequence : tag
  (** (300A,00D1) *)
  val wedge_number : tag
  (** (300A,00D2) *)
  val wedge_type : tag
  (** (300A,00D3) *)
  val wedge_id : tag
  (** (300A,00D4) *)
  val wedge_angle : tag
  (** (300A,00D5) *)
  val wedge_factor : tag
  (** (300A,00D6) *)
  val total_wedge_tray_water_equivalent_thickness : tag
  (** (300A,00D7) *)
  val wedge_orientation : tag
  (** (300A,00D8) *)
  val isocenter_to_wedge_tray_distance : tag
  (** (300A,00D9) *)
  val source_to_wedge_tray_distance : tag
  (** (300A,00DA) *)
  val wedge_thin_edge_position : tag
  (** (300A,00DB) *)
  val bolus_id : tag
  (** (300A,00DC) *)
  val bolus_description : tag
  (** (300A,00DD) *)
  val number_of_compensators : tag
  (** (300A,00E0) *)
  val material_id : tag
  (** (300A,00E1) *)
  val total_compensator_tray_factor : tag
  (** (300A,00E2) *)
  val compensator_sequence : tag
  (** (300A,00E3) *)
  val compensator_number : tag
  (** (300A,00E4) *)
  val compensator_id : tag
  (** (300A,00E5) *)
  val source_to_compensator_tray_distance : tag
  (** (300A,00E6) *)
  val compensator_rows : tag
  (** (300A,00E7) *)
  val compensator_columns : tag
  (** (300A,00E8) *)
  val compensator_pixel_spacing : tag
  (** (300A,00E9) *)
  val compensator_position : tag
  (** (300A,00EA) *)
  val compensator_transmission_data : tag
  (** (300A,00EB) *)
  val compensator_thickness_data : tag
  (** (300A,00EC) *)
  val number_of_boli : tag
  (** (300A,00ED) *)
  val compensator_type : tag
  (** (300A,00EE) *)
  val number_of_blocks : tag
  (** (300A,00F0) *)
  val total_block_tray_factor : tag
  (** (300A,00F2) *)
  val total_block_tray_water_equivalent_thickness : tag
  (** (300A,00F3) *)
  val block_sequence : tag
  (** (300A,00F4) *)
  val block_tray_id : tag
  (** (300A,00F5) *)
  val source_to_block_tray_distance : tag
  (** (300A,00F6) *)
  val isocenter_to_block_tray_distance : tag
  (** (300A,00F7) *)
  val block_type : tag
  (** (300A,00F8) *)
  val accessory_code : tag
  (** (300A,00F9) *)
  val block_divergence : tag
  (** (300A,00FA) *)
  val block_mounting_position : tag
  (** (300A,00FB) *)
  val block_number : tag
  (** (300A,00FC) *)
  val block_name : tag
  (** (300A,00FE) *)
  val block_thickness : tag
  (** (300A,0100) *)
  val block_transmission : tag
  (** (300A,0102) *)
  val block_number_of_points : tag
  (** (300A,0104) *)
  val block_data : tag
  (** (300A,0106) *)
  val applicator_sequence : tag
  (** (300A,0107) *)
  val applicator_id : tag
  (** (300A,0108) *)
  val applicator_type : tag
  (** (300A,0109) *)
  val applicator_description : tag
  (** (300A,010A) *)
  val cumulative_dose_reference_coefficient : tag
  (** (300A,010C) *)
  val final_cumulative_meterset_weight : tag
  (** (300A,010E) *)
  val number_of_control_points : tag
  (** (300A,0110) *)
  val control_point_sequence : tag
  (** (300A,0111) *)
  val control_point_index : tag
  (** (300A,0112) *)
  val nominal_beam_energy : tag
  (** (300A,0114) *)
  val dose_rate_set : tag
  (** (300A,0115) *)
  val wedge_position_sequence : tag
  (** (300A,0116) *)
  val wedge_position : tag
  (** (300A,0118) *)
  val beam_limiting_device_position_sequence : tag
  (** (300A,011A) *)
  val leaf_jaw_positions : tag
  (** (300A,011C) *)
  val gantry_angle : tag
  (** (300A,011E) *)
  val gantry_rotation_direction : tag
  (** (300A,011F) *)
  val beam_limiting_device_angle : tag
  (** (300A,0120) *)
  val beam_limiting_device_rotation_direction : tag
  (** (300A,0121) *)
  val patient_support_angle : tag
  (** (300A,0122) *)
  val patient_support_rotation_direction : tag
  (** (300A,0123) *)
  val table_top_eccentric_axis_distance : tag
  (** (300A,0124) *)
  val table_top_eccentric_angle : tag
  (** (300A,0125) *)
  val table_top_eccentric_rotation_direction : tag
  (** (300A,0126) *)
  val table_top_vertical_position : tag
  (** (300A,0128) *)
  val table_top_longitudinal_position : tag
  (** (300A,0129) *)
  val table_top_lateral_position : tag
  (** (300A,012A) *)
  val isocenter_position : tag
  (** (300A,012C) *)
  val surface_entry_point : tag
  (** (300A,012E) *)
  val source_to_surface_distance : tag
  (** (300A,0130) *)
  val cumulative_meterset_weight : tag
  (** (300A,0134) *)
  val table_top_pitch_angle : tag
  (** (300A,0140) *)
  val table_top_pitch_rotation_direction : tag
  (** (300A,0142) *)
  val table_top_roll_angle : tag
  (** (300A,0144) *)
  val table_top_roll_rotation_direction : tag
  (** (300A,0146) *)
  val head_fixation_angle : tag
  (** (300A,0148) *)
  val gantry_pitch_angle : tag
  (** (300A,014A) *)
  val gantry_pitch_rotation_direction : tag
  (** (300A,014C) *)
  val gantry_pitch_angle_tolerance : tag
  (** (300A,014E) *)
  val patient_setup_sequence : tag
  (** (300A,0180) *)
  val patient_setup_number : tag
  (** (300A,0182) *)
  val patient_setup_label : tag
  (** (300A,0183) *)
  val patient_additional_position : tag
  (** (300A,0184) *)
  val fixation_device_sequence : tag
  (** (300A,0190) *)
  val fixation_device_type : tag
  (** (300A,0192) *)
  val fixation_device_label : tag
  (** (300A,0194) *)
  val fixation_device_description : tag
  (** (300A,0196) *)
  val fixation_device_position : tag
  (** (300A,0198) *)
  val fixation_device_pitch_angle : tag
  (** (300A,0199) *)
  val fixation_device_roll_angle : tag
  (** (300A,019A) *)
  val shielding_device_sequence : tag
  (** (300A,01A0) *)
  val shielding_device_type : tag
  (** (300A,01A2) *)
  val shielding_device_label : tag
  (** (300A,01A4) *)
  val shielding_device_description : tag
  (** (300A,01A6) *)
  val shielding_device_position : tag
  (** (300A,01A8) *)
  val setup_technique : tag
  (** (300A,01B0) *)
  val setup_technique_description : tag
  (** (300A,01B2) *)
  val setup_device_sequence : tag
  (** (300A,01B4) *)
  val setup_device_type : tag
  (** (300A,01B6) *)
  val setup_device_label : tag
  (** (300A,01B8) *)
  val setup_device_description : tag
  (** (300A,01BA) *)
  val setup_device_parameter : tag
  (** (300A,01BC) *)
  val setup_reference_description : tag
  (** (300A,01D0) *)
  val table_top_vertical_setup_displacement : tag
  (** (300A,01D2) *)
  val table_top_longitudinal_setup_displacement : tag
  (** (300A,01D4) *)
  val table_top_lateral_setup_displacement : tag
  (** (300A,01D6) *)
  val brachy_treatment_technique : tag
  (** (300A,0200) *)
  val brachy_treatment_type : tag
  (** (300A,0202) *)
  val treatment_machine_sequence : tag
  (** (300A,0206) *)
  val source_sequence : tag
  (** (300A,0210) *)
  val source_number : tag
  (** (300A,0212) *)
  val source_type : tag
  (** (300A,0214) *)
  val source_manufacturer : tag
  (** (300A,0216) *)
  val active_source_diameter : tag
  (** (300A,0218) *)
  val active_source_length : tag
  (** (300A,021A) *)
  val source_encapsulation_nominal_thickness : tag
  (** (300A,0222) *)
  val source_encapsulation_nominal_transmission : tag
  (** (300A,0224) *)
  val source_isotope_name : tag
  (** (300A,0226) *)
  val source_isotope_half_life : tag
  (** (300A,0228) *)
  val source_strength_units : tag
  (** (300A,0229) *)
  val reference_air_kerma_rate : tag
  (** (300A,022A) *)
  val source_strength : tag
  (** (300A,022B) *)
  val source_strength_reference_date : tag
  (** (300A,022C) *)
  val source_strength_reference_time : tag
  (** (300A,022E) *)
  val application_setup_sequence : tag
  (** (300A,0230) *)
  val application_setup_type : tag
  (** (300A,0232) *)
  val application_setup_number : tag
  (** (300A,0234) *)
  val application_setup_name : tag
  (** (300A,0236) *)
  val application_setup_manufacturer : tag
  (** (300A,0238) *)
  val template_number : tag
  (** (300A,0240) *)
  val template_type : tag
  (** (300A,0242) *)
  val template_name : tag
  (** (300A,0244) *)
  val total_reference_air_kerma : tag
  (** (300A,0250) *)
  val brachy_accessory_device_sequence : tag
  (** (300A,0260) *)
  val brachy_accessory_device_number : tag
  (** (300A,0262) *)
  val brachy_accessory_device_id : tag
  (** (300A,0263) *)
  val brachy_accessory_device_type : tag
  (** (300A,0264) *)
  val brachy_accessory_device_name : tag
  (** (300A,0266) *)
  val brachy_accessory_device_nominal_thickness : tag
  (** (300A,026A) *)
  val brachy_accessory_device_nominal_transmission : tag
  (** (300A,026C) *)
  val channel_sequence : tag
  (** (300A,0280) *)
  val channel_number : tag
  (** (300A,0282) *)
  val channel_length : tag
  (** (300A,0284) *)
  val channel_total_time : tag
  (** (300A,0286) *)
  val source_movement_type : tag
  (** (300A,0288) *)
  val number_of_pulses : tag
  (** (300A,028A) *)
  val pulse_repetition_interval : tag
  (** (300A,028C) *)
  val source_applicator_number : tag
  (** (300A,0290) *)
  val source_applicator_id : tag
  (** (300A,0291) *)
  val source_applicator_type : tag
  (** (300A,0292) *)
  val source_applicator_name : tag
  (** (300A,0294) *)
  val source_applicator_length : tag
  (** (300A,0296) *)
  val source_applicator_manufacturer : tag
  (** (300A,0298) *)
  val source_applicator_wall_nominal_thickness : tag
  (** (300A,029C) *)
  val source_applicator_wall_nominal_transmission : tag
  (** (300A,029E) *)
  val source_applicator_step_size : tag
  (** (300A,02A0) *)
  val transfer_tube_number : tag
  (** (300A,02A2) *)
  val transfer_tube_length : tag
  (** (300A,02A4) *)
  val channel_shield_sequence : tag
  (** (300A,02B0) *)
  val channel_shield_number : tag
  (** (300A,02B2) *)
  val channel_shield_id : tag
  (** (300A,02B3) *)
  val channel_shield_name : tag
  (** (300A,02B4) *)
  val channel_shield_nominal_thickness : tag
  (** (300A,02B8) *)
  val channel_shield_nominal_transmission : tag
  (** (300A,02BA) *)
  val final_cumulative_time_weight : tag
  (** (300A,02C8) *)
  val brachy_control_point_sequence : tag
  (** (300A,02D0) *)
  val control_point_relative_position : tag
  (** (300A,02D2) *)
  val control_point_3d_position : tag
  (** (300A,02D4) *)
  val cumulative_time_weight : tag
  (** (300A,02D6) *)
  val compensator_divergence : tag
  (** (300A,02E0) *)
  val compensator_mounting_position : tag
  (** (300A,02E1) *)
  val source_to_compensator_distance : tag
  (** (300A,02E2) *)
  val total_compensator_tray_water_equivalent_thickness : tag
  (** (300A,02E3) *)
  val isocenter_to_compensator_tray_distance : tag
  (** (300A,02E4) *)
  val compensator_column_offset : tag
  (** (300A,02E5) *)
  val isocenter_to_compensator_distances : tag
  (** (300A,02E6) *)
  val compensator_relative_stopping_power_ratio : tag
  (** (300A,02E7) *)
  val compensator_milling_tool_diameter : tag
  (** (300A,02E8) *)
  val ion_range_compensator_sequence : tag
  (** (300A,02EA) *)
  val compensator_description : tag
  (** (300A,02EB) *)
  val radiation_mass_number : tag
  (** (300A,0302) *)
  val radiation_atomic_number : tag
  (** (300A,0304) *)
  val radiation_charge_state : tag
  (** (300A,0306) *)
  val scan_mode : tag
  (** (300A,0308) *)
  val virtual_source_axis_distances : tag
  (** (300A,030A) *)
  val snout_sequence : tag
  (** (300A,030C) *)
  val snout_position : tag
  (** (300A,030D) *)
  val snout_id : tag
  (** (300A,030F) *)
  val number_of_range_shifters : tag
  (** (300A,0312) *)
  val range_shifter_sequence : tag
  (** (300A,0314) *)
  val range_shifter_number : tag
  (** (300A,0316) *)
  val range_shifter_id : tag
  (** (300A,0318) *)
  val range_shifter_type : tag
  (** (300A,0320) *)
  val range_shifter_description : tag
  (** (300A,0322) *)
  val number_of_lateral_spreading_devices : tag
  (** (300A,0330) *)
  val lateral_spreading_device_sequence : tag
  (** (300A,0332) *)
  val lateral_spreading_device_number : tag
  (** (300A,0334) *)
  val lateral_spreading_device_id : tag
  (** (300A,0336) *)
  val lateral_spreading_device_type : tag
  (** (300A,0338) *)
  val lateral_spreading_device_description : tag
  (** (300A,033A) *)
  val lateral_spreading_device_water_equivalent_thickness : tag
  (** (300A,033C) *)
  val number_of_range_modulators : tag
  (** (300A,0340) *)
  val range_modulator_sequence : tag
  (** (300A,0342) *)
  val range_modulator_number : tag
  (** (300A,0344) *)
  val range_modulator_id : tag
  (** (300A,0346) *)
  val range_modulator_type : tag
  (** (300A,0348) *)
  val range_modulator_description : tag
  (** (300A,034A) *)
  val beam_current_modulation_id : tag
  (** (300A,034C) *)
  val patient_support_type : tag
  (** (300A,0350) *)
  val patient_support_id : tag
  (** (300A,0352) *)
  val patient_support_accessory_code : tag
  (** (300A,0354) *)
  val fixation_light_azimuthal_angle : tag
  (** (300A,0356) *)
  val fixation_light_polar_angle : tag
  (** (300A,0358) *)
  val meterset_rate : tag
  (** (300A,035A) *)
  val range_shifter_settings_sequence : tag
  (** (300A,0360) *)
  val range_shifter_setting : tag
  (** (300A,0362) *)
  val isocenter_to_range_shifter_distance : tag
  (** (300A,0364) *)
  val range_shifter_water_equivalent_thickness : tag
  (** (300A,0366) *)
  val lateral_spreading_device_settings_sequence : tag
  (** (300A,0370) *)
  val lateral_spreading_device_setting : tag
  (** (300A,0372) *)
  val isocenter_to_lateral_spreading_device_distance : tag
  (** (300A,0374) *)
  val range_modulator_settings_sequence : tag
  (** (300A,0380) *)
  val range_modulator_gating_start_value : tag
  (** (300A,0382) *)
  val range_modulator_gating_stop_value : tag
  (** (300A,0384) *)
  val range_modulator_gating_start_water_equivalent_thickness : tag
  (** (300A,0386) *)
  val range_modulator_gating_stop_water_equivalent_thickness : tag
  (** (300A,0388) *)
  val isocenter_to_range_modulator_distance : tag
  (** (300A,038A) *)
  val scan_spot_tune_id : tag
  (** (300A,0390) *)
  val number_of_scan_spot_positions : tag
  (** (300A,0392) *)
  val scan_spot_position_map : tag
  (** (300A,0394) *)
  val scan_spot_meterset_weights : tag
  (** (300A,0396) *)
  val scanning_spot_size : tag
  (** (300A,0398) *)
  val number_of_paintings : tag
  (** (300A,039A) *)
  val ion_tolerance_table_sequence : tag
  (** (300A,03A0) *)
  val ion_beam_sequence : tag
  (** (300A,03A2) *)
  val ion_beam_limiting_device_sequence : tag
  (** (300A,03A4) *)
  val ion_block_sequence : tag
  (** (300A,03A6) *)
  val ion_control_point_sequence : tag
  (** (300A,03A8) *)
  val ion_wedge_sequence : tag
  (** (300A,03AA) *)
  val ion_wedge_position_sequence : tag
  (** (300A,03AC) *)
  val referenced_setup_image_sequence : tag
  (** (300A,0401) *)
  val setup_image_comment : tag
  (** (300A,0402) *)
  val motion_synchronization_sequence : tag
  (** (300A,0410) *)
  val control_point_orientation : tag
  (** (300A,0412) *)
  val general_accessory_sequence : tag
  (** (300A,0420) *)
  val general_accessory_id : tag
  (** (300A,0421) *)
  val general_accessory_description : tag
  (** (300A,0422) *)
  val general_accessory_type : tag
  (** (300A,0423) *)
  val general_accessory_number : tag
  (** (300A,0424) *)
  val applicator_geometry_sequence : tag
  (** (300A,0431) *)
  val applicator_aperture_shape : tag
  (** (300A,0432) *)
  val applicator_opening : tag
  (** (300A,0433) *)
  val applicator_opening_x : tag
  (** (300A,0434) *)
  val applicator_opening_y : tag
  (** (300A,0435) *)
  val source_to_applicator_mounting_position_distance : tag
  (** (300A,0436) *)
  val referenced_rt_plan_sequence : tag
  (** (300C,0002) *)
  val referenced_beam_sequence : tag
  (** (300C,0004) *)
  val referenced_beam_number : tag
  (** (300C,0006) *)
  val referenced_reference_image_number : tag
  (** (300C,0007) *)
  val start_cumulative_meterset_weight : tag
  (** (300C,0008) *)
  val end_cumulative_meterset_weight : tag
  (** (300C,0009) *)
  val referenced_brachy_application_setup_sequence : tag
  (** (300C,000A) *)
  val referenced_brachy_application_setup_number : tag
  (** (300C,000C) *)
  val referenced_source_number : tag
  (** (300C,000E) *)
  val referenced_fraction_group_sequence : tag
  (** (300C,0020) *)
  val referenced_fraction_group_number : tag
  (** (300C,0022) *)
  val referenced_verification_image_sequence : tag
  (** (300C,0040) *)
  val referenced_reference_image_sequence : tag
  (** (300C,0042) *)
  val referenced_dose_reference_sequence : tag
  (** (300C,0050) *)
  val referenced_dose_reference_number : tag
  (** (300C,0051) *)
  val brachy_referenced_dose_reference_sequence : tag
  (** (300C,0055) *)
  val referenced_structure_set_sequence : tag
  (** (300C,0060) *)
  val referenced_patient_setup_number : tag
  (** (300C,006A) *)
  val referenced_dose_sequence : tag
  (** (300C,0080) *)
  val referenced_tolerance_table_number : tag
  (** (300C,00A0) *)
  val referenced_bolus_sequence : tag
  (** (300C,00B0) *)
  val referenced_wedge_number : tag
  (** (300C,00C0) *)
  val referenced_compensator_number : tag
  (** (300C,00D0) *)
  val referenced_block_number : tag
  (** (300C,00E0) *)
  val referenced_control_point_index : tag
  (** (300C,00F0) *)
  val referenced_control_point_sequence : tag
  (** (300C,00F2) *)
  val referenced_start_control_point_index : tag
  (** (300C,00F4) *)
  val referenced_stop_control_point_index : tag
  (** (300C,00F6) *)
  val referenced_range_shifter_number : tag
  (** (300C,0100) *)
  val referenced_lateral_spreading_device_number : tag
  (** (300C,0102) *)
  val referenced_range_modulator_number : tag
  (** (300C,0104) *)
  val approval_status : tag
  (** (300E,0002) *)
  val review_date : tag
  (** (300E,0004) *)
  val review_time : tag
  (** (300E,0005) *)
  val reviewer_name : tag
  (** (300E,0008) *)
  val arbitrary : tag
  (** (4000,0010) *)
  val text_comments : tag
  (** (4000,4000) *)
  val results_id : tag
  (** (4008,0040) *)
  val results_id_issuer : tag
  (** (4008,0042) *)
  val referenced_interpretation_sequence : tag
  (** (4008,0050) *)
  val report_production_status_trial : tag
  (** (4008,00FF) *)
  val interpretation_recorded_date : tag
  (** (4008,0100) *)
  val interpretation_recorded_time : tag
  (** (4008,0101) *)
  val interpretation_recorder : tag
  (** (4008,0102) *)
  val reference_to_recorded_sound : tag
  (** (4008,0103) *)
  val interpretation_transcription_date : tag
  (** (4008,0108) *)
  val interpretation_transcription_time : tag
  (** (4008,0109) *)
  val interpretation_transcriber : tag
  (** (4008,010A) *)
  val interpretation_text : tag
  (** (4008,010B) *)
  val interpretation_author : tag
  (** (4008,010C) *)
  val interpretation_approver_sequence : tag
  (** (4008,0111) *)
  val interpretation_approval_date : tag
  (** (4008,0112) *)
  val interpretation_approval_time : tag
  (** (4008,0113) *)
  val physician_approving_interpretation : tag
  (** (4008,0114) *)
  val interpretation_diagnosis_description : tag
  (** (4008,0115) *)
  val interpretation_diagnosis_code_sequence : tag
  (** (4008,0117) *)
  val results_distribution_list_sequence : tag
  (** (4008,0118) *)
  val distribution_name : tag
  (** (4008,0119) *)
  val distribution_address : tag
  (** (4008,011A) *)
  val interpretation_id : tag
  (** (4008,0200) *)
  val interpretation_id_issuer : tag
  (** (4008,0202) *)
  val interpretation_type_id : tag
  (** (4008,0210) *)
  val interpretation_status_id : tag
  (** (4008,0212) *)
  val impressions : tag
  (** (4008,0300) *)
  val results_comments : tag
  (** (4008,4000) *)
  val low_energy_detectors : tag
  (** (4010,0001) *)
  val high_energy_detectors : tag
  (** (4010,0002) *)
  val detector_geometry_sequence : tag
  (** (4010,0004) *)
  val threat_roi_voxel_sequence : tag
  (** (4010,1001) *)
  val threat_roi_base : tag
  (** (4010,1004) *)
  val threat_roi_extents : tag
  (** (4010,1005) *)
  val threat_roi_bitmap : tag
  (** (4010,1006) *)
  val route_segment_id : tag
  (** (4010,1007) *)
  val gantry_type : tag
  (** (4010,1008) *)
  val ooi_owner_type : tag
  (** (4010,1009) *)
  val route_segment_sequence : tag
  (** (4010,100A) *)
  val potential_threat_object_id : tag
  (** (4010,1010) *)
  val threat_sequence : tag
  (** (4010,1011) *)
  val threat_category : tag
  (** (4010,1012) *)
  val threat_category_description : tag
  (** (4010,1013) *)
  val atd_ability_assessment : tag
  (** (4010,1014) *)
  val atd_assessment_flag : tag
  (** (4010,1015) *)
  val atd_assessment_probability : tag
  (** (4010,1016) *)
  val mass : tag
  (** (4010,1017) *)
  val density : tag
  (** (4010,1018) *)
  val z_effective : tag
  (** (4010,1019) *)
  val boarding_pass_id : tag
  (** (4010,101A) *)
  val center_of_mass : tag
  (** (4010,101B) *)
  val center_of_pto : tag
  (** (4010,101C) *)
  val bounding_polygon : tag
  (** (4010,101D) *)
  val route_segment_start_location_id : tag
  (** (4010,101E) *)
  val route_segment_end_location_id : tag
  (** (4010,101F) *)
  val route_segment_location_id_type : tag
  (** (4010,1020) *)
  val abort_reason : tag
  (** (4010,1021) *)
  val volume_of_pto : tag
  (** (4010,1023) *)
  val abort_flag : tag
  (** (4010,1024) *)
  val route_segment_start_time : tag
  (** (4010,1025) *)
  val route_segment_end_time : tag
  (** (4010,1026) *)
  val tdr_type : tag
  (** (4010,1027) *)
  val international_route_segment : tag
  (** (4010,1028) *)
  val threat_detection_algorithmand_version : tag
  (** (4010,1029) *)
  val assigned_location : tag
  (** (4010,102A) *)
  val alarm_decision_time : tag
  (** (4010,102B) *)
  val alarm_decision : tag
  (** (4010,1031) *)
  val number_of_total_objects : tag
  (** (4010,1033) *)
  val number_of_alarm_objects : tag
  (** (4010,1034) *)
  val pto_representation_sequence : tag
  (** (4010,1037) *)
  val atd_assessment_sequence : tag
  (** (4010,1038) *)
  val tip_type : tag
  (** (4010,1039) *)
  val dicos_version : tag
  (** (4010,103A) *)
  val ooi_owner_creation_time : tag
  (** (4010,1041) *)
  val ooi_type : tag
  (** (4010,1042) *)
  val ooi_size : tag
  (** (4010,1043) *)
  val acquisition_status : tag
  (** (4010,1044) *)
  val basis_materials_code_sequence : tag
  (** (4010,1045) *)
  val phantom_type : tag
  (** (4010,1046) *)
  val ooi_owner_sequence : tag
  (** (4010,1047) *)
  val scan_type : tag
  (** (4010,1048) *)
  val itinerary_id : tag
  (** (4010,1051) *)
  val itinerary_id_type : tag
  (** (4010,1052) *)
  val itinerary_id_assigning_authority : tag
  (** (4010,1053) *)
  val route_id : tag
  (** (4010,1054) *)
  val route_id_assigning_authority : tag
  (** (4010,1055) *)
  val inbound_arrival_type : tag
  (** (4010,1056) *)
  val carrier_id : tag
  (** (4010,1058) *)
  val carrier_id_assigning_authority : tag
  (** (4010,1059) *)
  val source_orientation : tag
  (** (4010,1060) *)
  val source_position : tag
  (** (4010,1061) *)
  val belt_height : tag
  (** (4010,1062) *)
  val algorithm_routing_code_sequence : tag
  (** (4010,1064) *)
  val transport_classification : tag
  (** (4010,1067) *)
  val ooi_type_descriptor : tag
  (** (4010,1068) *)
  val total_processing_time : tag
  (** (4010,1069) *)
  val detector_calibration_data : tag
  (** (4010,106C) *)
  val macparameterssequence : tag
  (** (4FFE,0001) *)
  val curve_dimensions : tag
  (** (5000,0005) *)
  val number_of_points : tag
  (** (5000,0010) *)
  val type_of_data : tag
  (** (5000,0020) *)
  val curve_description : tag
  (** (5000,0022) *)
  val axis_units : tag
  (** (5000,0030) *)
  val axis_labels : tag
  (** (5000,0040) *)
  val data_value_representation : tag
  (** (5000,0103) *)
  val minimum_coordinate_value : tag
  (** (5000,0104) *)
  val maximum_coordinate_value : tag
  (** (5000,0105) *)
  val curve_range : tag
  (** (5000,0106) *)
  val curve_data_descriptor : tag
  (** (5000,0110) *)
  val coordinate_start_value : tag
  (** (5000,0112) *)
  val coordinate_step_value : tag
  (** (5000,0114) *)
  val curve_activation_layer : tag
  (** (5000,1001) *)
  val audio_type : tag
  (** (5000,2000) *)
  val audio_sample_format : tag
  (** (5000,2002) *)
  val number_of_channels : tag
  (** (5000,2004) *)
  val number_of_samples : tag
  (** (5000,2006) *)
  val sample_rate : tag
  (** (5000,2008) *)
  val total_time : tag
  (** (5000,200A) *)
  val audio_sample_data : tag
  (** (5000,200C) *)
  val audio_comments : tag
  (** (5000,200E) *)
  val curve_label : tag
  (** (5000,2500) *)
  val curve_referenced_overlay_sequence : tag
  (** (5000,2600) *)
  val curve_referenced_overlay_group : tag
  (** (5000,2610) *)
  val curve_data : tag
  (** (5000,3000) *)
  val shared_functional_groups_sequence : tag
  (** (5200,9229) *)
  val per_frame_functional_groups_sequence : tag
  (** (5200,9230) *)
  val waveform_sequence : tag
  (** (5400,0100) *)
  val channel_minimum_value : tag
  (** (5400,0110) *)
  val channel_maximum_value : tag
  (** (5400,0112) *)
  val waveform_bits_allocated : tag
  (** (5400,1004) *)
  val waveform_sample_interpretation : tag
  (** (5400,1006) *)
  val waveform_padding_value : tag
  (** (5400,100A) *)
  val waveform_data : tag
  (** (5400,1010) *)
  val first_order_phase_correction_angle : tag
  (** (5600,0010) *)
  val spectroscopy_data : tag
  (** (5600,0020) *)
  val overlay_rows : tag
  (** (6000,0010) *)
  val overlay_columns : tag
  (** (6000,0011) *)
  val overlay_planes : tag
  (** (6000,0012) *)
  val number_of_frames_in_overlay : tag
  (** (6000,0015) *)
  val overlay_description : tag
  (** (6000,0022) *)
  val overlay_type : tag
  (** (6000,0040) *)
  val overlay_subtype : tag
  (** (6000,0045) *)
  val overlay_origin : tag
  (** (6000,0050) *)
  val image_frame_origin : tag
  (** (6000,0051) *)
  val overlay_plane_origin : tag
  (** (6000,0052) *)
  val overlay_compression_code : tag
  (** (6000,0060) *)
  val overlay_compression_originator : tag
  (** (6000,0061) *)
  val overlay_compression_label : tag
  (** (6000,0062) *)
  val overlay_compression_description : tag
  (** (6000,0063) *)
  val overlay_compression_step_pointers : tag
  (** (6000,0066) *)
  val overlay_repeat_interval : tag
  (** (6000,0068) *)
  val overlay_bits_grouped : tag
  (** (6000,0069) *)
  val overlay_bits_allocated : tag
  (** (6000,0100) *)
  val overlay_bit_position : tag
  (** (6000,0102) *)
  val overlay_format : tag
  (** (6000,0110) *)
  val overlay_location : tag
  (** (6000,0200) *)
  val overlay_code_label : tag
  (** (6000,0800) *)
  val overlay_number_of_tables : tag
  (** (6000,0802) *)
  val overlay_code_table_location : tag
  (** (6000,0803) *)
  val overlay_bits_for_code_word : tag
  (** (6000,0804) *)
  val overlay_activation_layer : tag
  (** (6000,1001) *)
  val overlay_descriptor_gray : tag
  (** (6000,1100) *)
  val overlay_descriptor_red : tag
  (** (6000,1101) *)
  val overlay_descriptor_green : tag
  (** (6000,1102) *)
  val overlay_descriptor_blue : tag
  (** (6000,1103) *)
  val overlays_gray : tag
  (** (6000,1200) *)
  val overlays_red : tag
  (** (6000,1201) *)
  val overlays_green : tag
  (** (6000,1202) *)
  val overlays_blue : tag
  (** (6000,1203) *)
  val roi_area : tag
  (** (6000,1301) *)
  val roi_mean : tag
  (** (6000,1302) *)
  val roi_standard_deviation : tag
  (** (6000,1303) *)
  val overlay_label : tag
  (** (6000,1500) *)
  val overlay_data : tag
  (** (6000,3000) *)
  val overlay_comments : tag
  (** (6000,4000) *)
  val pixel_data : tag
  (** (7FE0,0010) *)
  val coefficients_sdvn : tag
  (** (7FE0,0020) *)
  val coefficients_sdhn : tag
  (** (7FE0,0030) *)
  val coefficients_sddn : tag
  (** (7FE0,0040) *)
  val variable_pixel_data : tag
  (** (7F00,0010) *)
  val variable_next_data_group : tag
  (** (7F00,0011) *)
  val variable_coefficients_sdvn : tag
  (** (7F00,0020) *)
  val variable_coefficients_sdhn : tag
  (** (7F00,0030) *)
  val variable_coefficients_sddn : tag
  (** (7F00,0040) *)
  val digital_signatures_sequence : tag
  (** (FFFA,FFFA) *)
  val data_set_trailing_padding : tag
  (** (FFFC,FFFC) *)
end

(** Unique identifiers (UID). 

    UID names are as found in 
    {{:http://medical.nema.org/Dicom/2011/11_06pu.pdf}PS 3.6 2011}, tables
    A-1, A-2, A-3. *)
module Uid : sig

  (** {1 UIDs} *) 

  type t = string 
  (** The type for DICOM unique identifiers. *) 
  
  val name : t -> string option
  (** [name uid] is the UID's name according to the standard. *)

  val to_syntax : t -> [`LE_explicit | `BE_explicit | `LE_implicit ]
  (** [to_syntax uid] is [uid]'s transfer syntax. Anything unknown is
      mapped to [`LE_explicit] (default syntax for compressed
      formats). *) 
end

type time = [ `Stamp of float * float option | `Daytime of float ] 
(** The type for representing times. 
    {ul
    {- [`Stamp (u, tz)] is used for [`DA] and [`DT] value representations. 
       [u] should be interpreted as an absolute time in POSIX seconds 
       since 1970-01-01 00:00:00 UTC. [tz] is a timezone offset in seconds.
       If [tz] is [None], time is in local time.}
    {- [`Daytime s] is used for [`TM], it's a time point in a day in seconds 
       since 00:00:00.}} *)

val pp_time : Format.formatter -> time -> unit
(** [pp_time ppf t] prints an unspecified representation of [t] on [ppf]. *)

type ('a, 'b) bigarray = ('a, 'b, Bigarray.c_layout) Bigarray.Array1.t
(** The type for bigarrays. *) 

type value = 
  [ `String of [ `One of string | `Many of string list ]
  | `UInt8 of (int, Bigarray.int8_unsigned_elt) bigarray
  | `Int16 of (int, Bigarray.int16_signed_elt) bigarray 
  | `UInt16 of (int, Bigarray.int16_unsigned_elt) bigarray 
  | `Int32 of (int32, Bigarray.int32_elt) bigarray 
  | `UInt32 of (int32, Bigarray.int32_elt) bigarray 
  | `Float32 of (float, Bigarray.float32_elt) bigarray
  | `Float64 of (float, Bigarray.float64_elt) bigarray
  | `Tag of [ `One of Tag.t | `Many of Tag.t list ] 
  | `Time of [ `One of time | `Many of time list ] ]
(** The type for values. VR are mapped to cases as given below.
    {ul
    {- [`String] for [`AE], [`AS], [`CS], [`DA], [`DT], [`LO], [`LT], 
       [`PN], [`SH], [`ST], [`TM], [`UI], [`UT].}
    {- [`UInt8] for [`OB], [`UN]}
    {- [`Int16] for [`SS]} 
    {- [`UInt16] for [`US], [`OW]}
    {- [`Int32] for [`IS], [`SL].}
    {- [`UInt32] for [`UL].}
    {- [`Float32] for [`FL], [`OF]}
    {- [`Float64] for [`DS], [`FD]}
    {- [`Tag] for [`AT]}
    {- [`Time] is TODO}}
    This should be documented in VR cases but ocamldoc doesn't support
    documentation in polymporphic variants. *)

val pp_value : ?limit:int -> Format.formatter -> [< value ] -> unit
(** [pp_value limit ppf v] prints an unspecified textual representation 
    of [v] on [ppf]. [limit] is the maximal number of printed element 
    arrays. *)
  
type element = Tag.t * vr * value
(** The type for data elements. *) 

val pp_element : Format.formatter -> element -> unit
(** [pp_element names ppf v] prints and unspecified textual representation
    of [v] on [ppf]. If [names] is [true] (defaults to [false]*) 

type lexeme = [ `E of element | `Ss of Tag.t | `Se of Tag.t | `I ]
(** The type for DICOM lexemes. [`Ss] and [`Se] are respectively for
    starting and ending sequences of data elements items (SQ value
    representation).

    A {e well-formed} sequence of lexemes belongs to the language of 
    the [dicom] grammar:
{[
  dicom = `E e / `Es t *(`I dicom) `Ee t / dicom
]}

   A {{!section:decode}decoder} returns only well-formed sequences
   of lexemes or [`Error]s are returned. 
*)

val pp_lexeme : Format.formatter -> [< lexeme ] -> unit 
(** [pp_lexeme names ppf l] prints an unspecified textual representation of 
    [l] on ppf. *)

(** {1:decode Decode} *)

type error = [ 
  | `Eoi of [ 
      | `File_preamble | `File_dicom_prefix | `Tag_or_eoi | `Tag
      | `Reserved of Tag.t | `Vr of Tag.t | `Value_length of Tag.t 
      | `Value of Tag.t ]
  | `Value_length_overflow of Tag.t
  | `Value_length_undefined of Tag.t
  | `Value_length_mismatch of Tag.t * int * int 
  | `Unknown_vr of Tag.t * string
  | `Parse_int of Tag.t * string
  | `Parse_float of Tag.t * string 
  | `Parse_time of Tag.t * string
  | `Parse_file_dicom_prefix 
  | `File_syntax_unspecified 
  | `File_syntax_vr_not_uid of vr ]

(** The type for decoding errors. *) 

val pp_error : Format.formatter -> [< error ] -> unit 
(** [pp_error e] prints an unspecified representation of [e] on [ppf]. *)

type src = [ `Channel of Pervasives.in_channel | `Manual | `String of string ]
(** The type for input sources. With a [`Manual] source the client must
    provide input with {!Manual.src}. *)

type decoder 
(** The type for decoders. *)

val decoder : ?vr:(Tag.t -> vr) -> syntax:syntax -> [< src ] -> decoder
(** [decoder private_tag file src] is a DICOM decoder that inputs DICOM data
    elements from [src] according to [syntax].

    If [syntax] is [`File], the decoder first parses a DICOM file
    preamble and the DICM prefix reporting an error if it fails to do
    so. Decodes then return the DICOM file meta information and the
    decoder automatically switch to the right syntax for decoding the
    data object. 

    If decoding is done using the implicit syntax [vr] is called on 
    tags that return [None] on [Tag.vr] to determine the value representation
    to use (defaults to [fun _ -> `UN]). *)

val decode : decoder -> [ `Await | `End | `Error of error | `Lexeme of lexeme ]
(** [decode d] is:
    {ul 
    {- [`Await] if [d] has a [`Manual] source and awaits more imput. 
       The client must use {!Manual.src} to provide it.}
    {- [`Lexeme l] if a lexeme [l] was decoded.}
    {- [`End] if the end of input was reached.}
    {- [`Error e] if a decoding error occured. If the client is interested
       in a best-effort decoding it can still continue to decode after an error
       see {!errors}.}} *)

val decoded_range : decoder -> int * int
(** [decoded_range d] is the range of bytes spanning the last [`Lexeme] or
    [`Error] decoded by [d]. *)

val decoder_src : decoder -> src 
(** [decoder_src d] is [d]'s input source. *)

val decoder_syntax : decoder -> syntax
(** [decoder_syntax d] is [d]'s decoded syntax. *) 

val pp_decode : Format.formatter -> 
  [< `Await | `End | `Error of error | `Lexeme of lexeme ] -> unit 
(** [pp_decode ppf v] prints an unspecified representation of [v] on 
    [ppf]. *)

(** {1:manual Manual sources} *) 

(** Manual sources. 

    {b Warning.} Use only with [`Manual] decoders and encoders. 
*)
module Manual : sig
  val src : decoder -> string -> int -> int -> unit 
  (** [src d s j l] provides [d] with [l] bytes to read, starting at [j]
      in [s]. This byte range is read by calls to [!decode] with [d] until 
      [`Await] is returned. To signal the end of input call the function 
      with [l = 0]. *)
end

(** {1:errors Error recovery}

    After a decoding error, if best-effort decoding is performed. The following
    happens before continuing: 
    {ul 
    {- [`Eoi _], `End is eventually returned.}
    {- [`File_syntax_unspecified], continues with [`LE_implicit].}
    {- [`File_syntax_vr_not_uid], ignores the VR and parses as an UID.}
    {- [`Parse_int], [`Parse_float], [`Parse_time] skips the data element.}
    {- [`Unknown_vr], continues assuming a [UN] value representation.}
    {- [`Value_length_overflow], skips the data element.}
    {- [`Value_length_undefined], skips the data element whose value 
       is assumed to be of 0xFFFFFFFF bytes (this may not be very useful).}
    {- [`Value_length_mismatch], skips the data element.}}
    
    {1:props Features and limitations}
    
    On decoding: 
    {ul
    {- Values are always returned unpadded. Strings are unpadded 
       by '\x20' or '\x00' (DICOM mandates '\x20' for 
       strings but some images are padded with '\x00' in the wild).}
    {- Value representation that exceed their length are not reported 
       as errors.}
    {- Value representation [`AS] is unparsed and returned as 
       a string.}
    {- Value representation [`IS] are parsed with [Int32.of_string] and
       [`FS] with [float_of_string].}
    {- Value representation and multiplicity of data elements are not 
       checked for errors against the standard. You can do so by using
       functions from the {!Tag} module.}
    {- In the implicit syntax, if a tag may have multiple VR (see 
       the result of {!Tag.vr}). In that case we unconditionally map 
       [`OB_or_OW] to [`OW], [`US_or_SS] to [`US], [`US_or_OW] to [`US] 
       [`US_or_SS_or_OW] to [`US]. Depending on contextual information 
       you may want to reinterpret that data differently, 
       see PS 3.5 Annex A.1.}
    {- Item and sequence delimitation items are not returned.} 
    {- Size limitations on 32 bits platforms. Values are limited by 
       {!Sys.max_string_length}, In each of these cases the error 
       [`Size_overflow] is returned and the data element is skipped. 
       Note that none of this should happen on 64 bits platforms.
       This limitation could be lifted in future versions of the library.}}


    {1:pixels Pixel data} 

    On decoding for DICOM bitmap data, the pixel representation 
    tag [(0028,0103)] is captured and if tag [(7FE0, 0010)] has 
    a 16 bits representation the value is mapped to `UInt16 or `Int16
    accordingly.

    {1:examples Examples} *)

(*---------------------------------------------------------------------------
   Copyright (c) 2014 Daniel C. Bünzli.
   All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions
   are met:
     
   1. Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.

   2. Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.

   3. Neither the name of Daniel C. Bünzli nor the names of
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  ---------------------------------------------------------------------------*)
