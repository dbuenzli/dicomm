(*---------------------------------------------------------------------------
   Copyright (c) 2014 Daniel C. Bünzli. All rights reserved.
   Distributed under the BSD3 license, see license at the end of the file.
   %%NAME%% release %%VERSION%%
  ---------------------------------------------------------------------------*)

type vr = 
  [ `AE | `AS | `AT | `CS | `DA | `DS | `DT | `FD | `FL | `IS | `LO | `LT 
  | `OB | `OF | `OW | `PN | `SH | `SL | `SQ | `SS | `ST | `TM | `UI | `UL 
  | `UN | `US | `UT | `OB_or_OW | `US_or_SS | `US_or_OW | `US_or_SS_or_OW ]

type vm = 
  [ `One | `One_2 | `One_3 | `One_8 | `One_32 | `One_99 | `One_n 
  | `Two | `Two_n | `Two_2n | `Three | `Three_n | `Three_3n 
  | `Four | `Six | `Six_n | `Nine | `Sixteen ]

(* Element sepecifications as found in PS 3.6 2011 §6,7,8 and 
   PS 3.7 2011 Annex E *) 

let elements = [
(* 3.7 Annex E, table E.1-1 *)
0x0000_0000l, ("Command Group Length", "CommandGroupLength", `UL, `One, false);
0x0000_0002l, ("Affected SOP Class UID", "AffectedSOPClassUID", `UI, `One, false);
0x0000_0003l, ("Requested SOP Class UID", "RequestedSOPClassUID", `UI, `One, false);
0x0000_0100l, ("Command Field", "CommandField", `US, `One, false);
0x0000_0110l, ("Message ID", "MessageID", `US, `One, false);
0x0000_0120l, ("Message ID Being Responded To", "MessageIDBeingRespondedTo", `US, `One, false);
0x0000_0600l, ("Move Destination", "MoveDestination", `AE, `One, false);
0x0000_0700l, ("Priority", "Priority", `US, `One, false);
0x0000_0800l, ("Command Data Set Type", "CommandDataSetType", `US, `One, false);
0x0000_0900l, ("Status", "Status", `US, `One, false);
0x0000_0901l, ("Offending Element", "OffendingElement", `AT, `One_n, false);
0x0000_0902l, ("Error Comment", "ErrorComment", `LO, `One, false);
0x0000_0903l, ("Error ID", "ErrorID", `US, `One, false);
0x0000_1000l, ("Affected SOP Instance UID", "AffectedSOPInstanceUID", `UI, `One, false);
0x0000_1001l, ("Requested SOP Instance UID", "RequestedSOPInstanceUID", `UI, `One, false);
0x0000_1002l, ("Event Type ID", "EventTypeID", `US, `One, false);
0x0000_1005l, ("Attribute Identifier List", "AttributeIdentifierList", `AT, `One_n, false);
0x0000_1008l, ("Action Type ID", "ActionTypeID", `US, `One, false);
0x0000_1020l, ("Number of Remaining Sub-operations", "NumberOfRemainingSuboperations", `US, `One, false);
0x0000_1021l, ("Number of Completed Sub-operations", "NumberOfCompletedSuboperations", `US, `One, false);
0x0000_1022l, ("Number of Failed Sub-operations", "NumberOfFailedSuboperations", `US, `One, false);
0x0000_1023l, ("Number of Warning Sub-operations", "NumberOfWarningSuboperations", `US, `One, false);
0x0000_1030l, ("Move Originator Application Entity Title", "MoveOriginatorApplicationEntityTitle", `AE, `One, false);
0x0000_1031l, ("Move Originator Message ID", "MoveOriginatorMessageID", `US, `One, false);

(* 3.7 Annex E, table E.1-2 *)
0x0000_0001l, ("Command Length to End", "CommandLengthToEnd", `UL, `One, true);
0x0000_0010l, ("Command Recognition Code", "CommandRecognitionCode", `SH, `One, true);
0x0000_0200l, ("Initiator", "Initiator", `AE, `One, true);
0x0000_0300l, ("Receiver", "Receiver", `AE, `One, true);
0x0000_0400l, ("Find Location", "FindLocation", `AE, `One, true);
0x0000_0850l, ("Number of Matches", "NumberOfMatches", `US, `One, true);
0x0000_0860l, ("Response Sequence Number", "ResponseSequenceNumber", `US, `One, true);
0x0000_4000l, ("Dialog Receiver", "DialogReceiver", `LT, `One, true);
0x0000_4010l, ("Terminal Type", "TerminalType", `LT, `One, true);
0x0000_5010l, ("Message Set ID", "MessageSetID", `SH, `One, true);
0x0000_5020l, ("End Message ID", "EndMessageID", `SH, `One, true);
0x0000_5110l, ("Display Format", "DisplayFormat", `LT, `One, true);
0x0000_5120l, ("Page Position ID", "PagePositionID", `LT, `One, true);
0x0000_5130l, ("Text Format ID", "TextFormatID", `CS, `One, true);
0x0000_5140l, ("Normal/Reverse", "NormalReverse", `CS, `One, true);
0x0000_5150l, ("Add Gray Scale", "AddGrayScale", `CS, `One, true);
0x0000_5160l, ("Borders", "Borders", `CS, `One, true);
0x0000_5170l, ("Copies", "Copies", `IS, `One, true);
0x0000_5180l, ("Command Magnification Type", "CommandMagnificationType", `CS, `One, true);
0x0000_5190l, ("Erase", "Erase", `CS, `One, true);
0x0000_51A0l, ("Print", "Print", `CS, `One, true);
0x0000_51B0l, ("Overlays", "Overlays", `US, `One_n, true);

(* 3.6 §7 File meta elements *) 
0x0002_0000l, ("File Meta Information Group Length", "FileMetaInformationGroupLength", `UL, `One, false);
0x0002_0001l, ("File Meta Information Version", "FileMetaInformationVersion", `OB, `One, false);
0x0002_0002l, ("Media Storage SOP Class UID", "MediaStorageSOPClassUID", `UI, `One, false);
0x0002_0003l, ("Media Storage SOP Instance UID", "MediaStorageSOPInstanceUID", `UI, `One, false);
0x0002_0010l, ("Transfer Syntax UID", "TransferSyntaxUID", `UI, `One, false);
0x0002_0012l, ("Implementation Class UID", "ImplementationClassUID", `UI, `One, false);
0x0002_0013l, ("Implementation Version Name", "ImplementationVersionName", `SH, `One, false);
0x0002_0016l, ("Source Application Entity Title", "SourceApplicationEntityTitle", `AE, `One, false);
0x0002_0100l, ("Private Information Creator UID", "PrivateInformationCreatorUID", `UI, `One, false);
0x0002_0102l, ("Private Information", "PrivateInformation", `OB, `One, false);

(* §8 Directory structuring elements *) 
0x0004_1130l, ("File-set ID", "FileSetID", `CS, `One, false);
0x0004_1141l, ("File-set Descriptor File ID", "FileSetDescriptorFileID", `CS, `One_8, false);
0x0004_1142l, ("Specific Character Set of File-set Descriptor File", "SpecificCharacterSetOfFileSetDescriptorFile", `CS, `One, false);
0x0004_1200l, ("Offset of the First Directory Record of the Root Directory Entity", "OffsetOfTheFirstDirectoryRecordOfTheRootDirectoryEntity", `UL, `One, false);
0x0004_1202l, ("Offset of the Last Directory Record of the Root Directory Entity", "OffsetOfTheLastDirectoryRecordOfTheRootDirectoryEntity", `UL, `One, false);
0x0004_1212l, ("File-set Consistency Flag", "FileSetConsistencyFlag", `US, `One, false);
0x0004_1220l, ("Directory Record Sequence", "DirectoryRecordSequence", `SQ, `One, false);
0x0004_1400l, ("Offset of the Next Directory Record", "OffsetOfTheNextDirectoryRecord", `UL, `One, false);
0x0004_1410l, ("Record In-use Flag", "RecordInUseFlag", `US, `One, false);
0x0004_1420l, ("Offset of Referenced Lower-Level Directory Entity", "OffsetOfReferencedLowerLevelDirectoryEntity", `UL, `One, false);
0x0004_1430l, ("Directory Record Type", "DirectoryRecordType", `CS, `One, false);
0x0004_1432l, ("Private Record UID", "PrivateRecordUID", `UI, `One, false);
0x0004_1500l, ("Referenced File ID", "ReferencedFileID", `CS, `One_8, false);
0x0004_1504l, ("MRDR Directory Record Offset", "MRDRDirectoryRecordOffset", `UL, `One, true);
0x0004_1510l, ("Referenced SOP Class UID in File", "ReferencedSOPClassUIDInFile", `UI, `One, false);
0x0004_1511l, ("Referenced SOP Instance UID in File", "ReferencedSOPInstanceUIDInFile", `UI, `One, false);
0x0004_1512l, ("Referenced Transfer Syntax UID in File", "ReferencedTransferSyntaxUIDInFile", `UI, `One, false);
0x0004_151Al, ("Referenced Related General SOP Class UID in File", "ReferencedRelatedGeneralSOPClassUIDInFile", `UI, `One_n, false);
0x0004_1600l, ("Number of References", "NumberOfReferences", `UL, `One, true);

(* §6 Data elements *) 
0x0008_0001l, ("Length to End", "LengthToEnd", `UL, `One, true);
0x0008_0005l, ("Specific Character Set", "SpecificCharacterSet", `CS, `One_n, false);
0x0008_0006l, ("Language Code Sequence", "LanguageCodeSequence", `SQ, `One, false);
0x0008_0008l, ("Image Type", "ImageType", `CS, `Two_n, false);
0x0008_0010l, ("Recognition Code", "RecognitionCode", `SH, `One, true);
0x0008_0012l, ("Instance Creation Date", "InstanceCreationDate", `DA, `One, false);
0x0008_0013l, ("Instance Creation Time", "InstanceCreationTime", `TM, `One, false);
0x0008_0014l, ("Instance Creator UID", "InstanceCreatorUID", `UI, `One, false);
0x0008_0016l, ("SOP Class UID", "SOPClassUID", `UI, `One, false);
0x0008_0018l, ("SOP Instance UID", "SOPInstanceUID", `UI, `One, false);
0x0008_001Al, ("Related General SOP Class UID", "RelatedGeneralSOPClassUID", `UI, `One_n, false);
0x0008_001Bl, ("Original Specialized SOP Class UID", "OriginalSpecializedSOPClassUID", `UI, `One, false);
0x0008_0020l, ("Study Date", "StudyDate", `DA, `One, false);
0x0008_0021l, ("Series Date", "SeriesDate", `DA, `One, false);
0x0008_0022l, ("Acquisition Date", "AcquisitionDate", `DA, `One, false);
0x0008_0023l, ("Content Date", "ContentDate", `DA, `One, false);
0x0008_0024l, ("Overlay Date", "OverlayDate", `DA, `One, true);
0x0008_0025l, ("Curve Date", "CurveDate", `DA, `One, true);
0x0008_002Al, ("Acquisition DateTime", "AcquisitionDateTime", `DT, `One, false);
0x0008_0030l, ("Study Time", "StudyTime", `TM, `One, false);
0x0008_0031l, ("Series Time", "SeriesTime", `TM, `One, false);
0x0008_0032l, ("Acquisition Time", "AcquisitionTime", `TM, `One, false);
0x0008_0033l, ("Content Time", "ContentTime", `TM, `One, false);
0x0008_0034l, ("Overlay Time", "OverlayTime", `TM, `One, true);
0x0008_0035l, ("Curve Time", "CurveTime", `TM, `One, true);
0x0008_0040l, ("Data Set Type", "DataSetType", `US, `One, true);
0x0008_0041l, ("Data Set Subtype", "DataSetSubtype", `LO, `One, true);
0x0008_0042l, ("Nuclear Medicine Series Type", "NuclearMedicineSeriesType", `CS, `One, true);
0x0008_0050l, ("Accession Number", "AccessionNumber", `SH, `One, false);
0x0008_0051l, ("Issuer of Accession Number Sequence", "IssuerOfAccessionNumberSequence", `SQ, `One, false);
0x0008_0052l, ("Query/Retrieve Level", "QueryRetrieveLevel", `CS, `One, false);
0x0008_0054l, ("Retrieve AE Title", "RetrieveAETitle", `AE, `One_n, false);
0x0008_0056l, ("Instance Availability", "InstanceAvailability", `CS, `One, false);
0x0008_0058l, ("Failed SOP Instance UID List", "FailedSOPInstanceUIDList", `UI, `One_n, false);
0x0008_0060l, ("Modality", "Modality", `CS, `One, false);
0x0008_0061l, ("Modalities in Study", "ModalitiesInStudy", `CS, `One_n, false);
0x0008_0062l, ("SOP Classes in Study", "SOPClassesInStudy", `UI, `One_n, false);
0x0008_0064l, ("Conversion Type", "ConversionType", `CS, `One, false);
0x0008_0068l, ("Presentation Intent Type", "PresentationIntentType", `CS, `One, false);
0x0008_0070l, ("Manufacturer", "Manufacturer", `LO, `One, false);
0x0008_0080l, ("Institution Name", "InstitutionName", `LO, `One, false);
0x0008_0081l, ("Institution Address", "InstitutionAddress", `ST, `One, false);
0x0008_0082l, ("Institution Code Sequence", "InstitutionCodeSequence", `SQ, `One, false);
0x0008_0090l, ("Referring Physician’s Name", "ReferringPhysicianName", `PN, `One, false);
0x0008_0092l, ("Referring Physician’s Address", "ReferringPhysicianAddress", `ST, `One, false);
0x0008_0094l, ("Referring Physician’s Telephone Numbers", "ReferringPhysicianTelephoneNumbers", `SH, `One_n, false);
0x0008_0096l, ("Referring Physician Identification Sequence", "ReferringPhysicianIdentificationSequence", `SQ, `One, false);
0x0008_0100l, ("Code Value", "CodeValue", `SH, `One, false);
0x0008_0102l, ("Coding Scheme Designator", "CodingSchemeDesignator", `SH, `One, false);
0x0008_0103l, ("Coding Scheme Version", "CodingSchemeVersion", `SH, `One, false);
0x0008_0104l, ("Code Meaning", "CodeMeaning", `LO, `One, false);
0x0008_0105l, ("Mapping Resource", "MappingResource", `CS, `One, false);
0x0008_0106l, ("Context Group Version", "ContextGroupVersion", `DT, `One, false);
0x0008_0107l, ("Context Group Local Version", "ContextGroupLocalVersion", `DT, `One, false);
0x0008_010Bl, ("Context Group Extension Flag", "ContextGroupExtensionFlag", `CS, `One, false);
0x0008_010Cl, ("Coding Scheme UID", "CodingSchemeUID", `UI, `One, false);
0x0008_010Dl, ("Context Group Extension Creator UID", "ContextGroupExtensionCreatorUID", `UI, `One, false);
0x0008_010Fl, ("Context Identifier", "ContextIdentifier", `CS, `One, false);
0x0008_0110l, ("Coding Scheme Identification Sequence", "CodingSchemeIdentificationSequence", `SQ, `One, false);
0x0008_0112l, ("Coding Scheme Registry", "CodingSchemeRegistry", `LO, `One, false);
0x0008_0114l, ("Coding Scheme External ID", "CodingSchemeExternalID", `ST, `One, false);
0x0008_0115l, ("Coding Scheme Name", "CodingSchemeName", `ST, `One, false);
0x0008_0116l, ("Coding Scheme Responsible Organization", "CodingSchemeResponsibleOrganization", `ST, `One, false);
0x0008_0117l, ("Context UID", "ContextUID", `UI, `One, false);
0x0008_0201l, ("Timezone Offset From UTC", "TimezoneOffsetFromUTC", `SH, `One, false);
0x0008_1000l, ("Network ID", "NetworkID", `AE, `One, true);
0x0008_1010l, ("Station Name", "StationName", `SH, `One, false);
0x0008_1030l, ("Study Description", "StudyDescription", `LO, `One, false);
0x0008_1032l, ("Procedure Code Sequence", "ProcedureCodeSequence", `SQ, `One, false);
0x0008_103El, ("Series Description", "SeriesDescription", `LO, `One, false);
0x0008_103Fl, ("Series Description Code Sequence", "SeriesDescriptionCodeSequence", `SQ, `One, false);
0x0008_1040l, ("Institutional Department Name", "InstitutionalDepartmentName", `LO, `One, false);
0x0008_1048l, ("Physician(s) of Record", "PhysiciansOfRecord", `PN, `One_n, false);
0x0008_1049l, ("Physician(s) of Record Identification Sequence", "PhysiciansOfRecordIdentificationSequence", `SQ, `One, false);
0x0008_1050l, ("Performing Physician’s Name", "PerformingPhysicianName", `PN, `One_n, false);
0x0008_1052l, ("Performing Physician Identification Sequence", "PerformingPhysicianIdentificationSequence", `SQ, `One, false);
0x0008_1060l, ("Name of Physician(s) Reading Study", "NameOfPhysiciansReadingStudy", `PN, `One_n, false);
0x0008_1062l, ("Physician(s) Reading Study Identification Sequence", "PhysiciansReadingStudyIdentificationSequence", `SQ, `One, false);
0x0008_1070l, ("Operators’ Name", "OperatorsName", `PN, `One_n, false);
0x0008_1072l, ("Operator Identification Sequence", "OperatorIdentificationSequence", `SQ, `One, false);
0x0008_1080l, ("Admitting Diagnoses Description", "AdmittingDiagnosesDescription", `LO, `One_n, false);
0x0008_1084l, ("Admitting Diagnoses Code Sequence", "AdmittingDiagnosesCodeSequence", `SQ, `One, false);
0x0008_1090l, ("Manufacturer’s Model Name", "ManufacturerModelName", `LO, `One, false);
0x0008_1100l, ("Referenced Results Sequence", "ReferencedResultsSequence", `SQ, `One, true);
0x0008_1110l, ("Referenced Study Sequence", "ReferencedStudySequence", `SQ, `One, false);
0x0008_1111l, ("Referenced Performed Procedure Step Sequence", "ReferencedPerformedProcedureStepSequence", `SQ, `One, false);
0x0008_1115l, ("Referenced Series Sequence", "ReferencedSeriesSequence", `SQ, `One, false);
0x0008_1120l, ("Referenced Patient Sequence", "ReferencedPatientSequence", `SQ, `One, false);
0x0008_1125l, ("Referenced Visit Sequence", "ReferencedVisitSequence", `SQ, `One, false);
0x0008_1130l, ("Referenced Overlay Sequence", "ReferencedOverlaySequence", `SQ, `One, true);
0x0008_1134l, ("Referenced Stereometric Instance Sequence", "ReferencedStereometricInstanceSequence", `SQ, `One, false);
0x0008_113Al, ("Referenced Waveform Sequence", "ReferencedWaveformSequence", `SQ, `One, false);
0x0008_1140l, ("Referenced Image Sequence", "ReferencedImageSequence", `SQ, `One, false);
0x0008_1145l, ("Referenced Curve Sequence", "ReferencedCurveSequence", `SQ, `One, true);
0x0008_114Al, ("Referenced Instance Sequence", "ReferencedInstanceSequence", `SQ, `One, false);
0x0008_114Bl, ("Referenced Real World Value Mapping Instance Sequence", "ReferencedRealWorldValueMappingInstanceSequence", `SQ, `One, false);
0x0008_1150l, ("Referenced SOP Class UID", "ReferencedSOPClassUID", `UI, `One, false);
0x0008_1155l, ("Referenced SOP Instance UID", "ReferencedSOPInstanceUID", `UI, `One, false);
0x0008_115Al, ("SOP Classes Supported", "SOPClassesSupported", `UI, `One_n, false);
0x0008_1160l, ("Referenced Frame Number", "ReferencedFrameNumber", `IS, `One_n, false);
0x0008_1161l, ("Simple Frame List", "SimpleFrameList", `UL, `One_n, false);
0x0008_1162l, ("Calculated Frame List", "CalculatedFrameList", `UL, `Three_3n, false);
0x0008_1163l, ("Time Range", "TimeRange", `FD, `Two, false);
0x0008_1164l, ("Frame Extraction Sequence", "FrameExtractionSequence", `SQ, `One, false);
0x0008_1167l, ("Multi-Frame Source SOP Instance UID", "MultiFrameSourceSOPInstanceUID", `UI, `One, false);
0x0008_1195l, ("Transaction UID", "TransactionUID", `UI, `One, false);
0x0008_1197l, ("Failure Reason", "FailureReason", `US, `One, false);
0x0008_1198l, ("Failed SOP Sequence", "FailedSOPSequence", `SQ, `One, false);
0x0008_1199l, ("Referenced SOP Sequence", "ReferencedSOPSequence", `SQ, `One, false);
0x0008_1200l, ("Studies Containing Other Referenced Instances Sequence", "StudiesContainingOtherReferencedInstancesSequence", `SQ, `One, false);
0x0008_1250l, ("Related Series Sequence", "RelatedSeriesSequence", `SQ, `One, false);
0x0008_2110l, ("Lossy Image Compression (Retired)", "LossyImageCompressionRetired", `CS, `One, true);
0x0008_2111l, ("Derivation Description", "DerivationDescription", `ST, `One, false);
0x0008_2112l, ("Source Image Sequence", "SourceImageSequence", `SQ, `One, false);
0x0008_2120l, ("Stage Name", "StageName", `SH, `One, false);
0x0008_2122l, ("Stage Number", "StageNumber", `IS, `One, false);
0x0008_2124l, ("Number of Stages", "NumberOfStages", `IS, `One, false);
0x0008_2127l, ("View Name", "ViewName", `SH, `One, false);
0x0008_2128l, ("View Number", "ViewNumber", `IS, `One, false);
0x0008_2129l, ("Number of Event Timers", "NumberOfEventTimers", `IS, `One, false);
0x0008_212Al, ("Number of Views in Stage", "NumberOfViewsInStage", `IS, `One, false);
0x0008_2130l, ("Event Elapsed Time(s)", "EventElapsedTimes", `DS, `One_n, false);
0x0008_2132l, ("Event Timer Name(s)", "EventTimerNames", `LO, `One_n, false);
0x0008_2133l, ("Event Timer Sequence", "EventTimerSequence", `SQ, `One, false);
0x0008_2134l, ("Event Time Offset", "EventTimeOffset", `FD, `One, false);
0x0008_2135l, ("Event Code Sequence", "EventCodeSequence", `SQ, `One, false);
0x0008_2142l, ("Start Trim", "StartTrim", `IS, `One, false);
0x0008_2143l, ("Stop Trim", "StopTrim", `IS, `One, false);
0x0008_2144l, ("Recommended Display Frame Rate", "RecommendedDisplayFrameRate", `IS, `One, false);
0x0008_2200l, ("Transducer Position", "TransducerPosition", `CS, `One, true);
0x0008_2204l, ("Transducer Orientation", "TransducerOrientation", `CS, `One, true);
0x0008_2208l, ("Anatomic Structure", "AnatomicStructure", `CS, `One, true);
0x0008_2218l, ("Anatomic Region Sequence", "AnatomicRegionSequence", `SQ, `One, false);
0x0008_2220l, ("Anatomic Region Modifier Sequence", "AnatomicRegionModifierSequence", `SQ, `One, false);
0x0008_2228l, ("Primary Anatomic Structure Sequence", "PrimaryAnatomicStructureSequence", `SQ, `One, false);
0x0008_2229l, ("Anatomic Structure, Space or Region Sequence", "AnatomicStructureSpaceOrRegionSequence", `SQ, `One, false);
0x0008_2230l, ("Primary Anatomic Structure Modifier Sequence", "PrimaryAnatomicStructureModifierSequence", `SQ, `One, false);
0x0008_2240l, ("Transducer Position Sequence", "TransducerPositionSequence", `SQ, `One, true);
0x0008_2242l, ("Transducer Position Modifier Sequence", "TransducerPositionModifierSequence", `SQ, `One, true);
0x0008_2244l, ("Transducer Orientation Sequence", "TransducerOrientationSequence", `SQ, `One, true);
0x0008_2246l, ("Transducer Orientation Modifier Sequence", "TransducerOrientationModifierSequence", `SQ, `One, true);
0x0008_2251l, ("Anatomic Structure Space Or Region Code Sequence (Trial)", "AnatomicStructureSpaceOrRegionCodeSequenceTrial", `SQ, `One, true);
0x0008_2253l, ("Anatomic Portal Of Entrance Code Sequence (Trial)", "AnatomicPortalOfEntranceCodeSequenceTrial", `SQ, `One, true);
0x0008_2255l, ("Anatomic Approach Direction Code Sequence (Trial)", "AnatomicApproachDirectionCodeSequenceTrial", `SQ, `One, true);
0x0008_2256l, ("Anatomic Perspective Description (Trial)", "AnatomicPerspectiveDescriptionTrial", `ST, `One, true);
0x0008_2257l, ("Anatomic Perspective Code Sequence (Trial)", "AnatomicPerspectiveCodeSequenceTrial", `SQ, `One, true);
0x0008_2258l, ("Anatomic Location Of Examining Instrument Description (Trial)", "AnatomicLocationOfExaminingInstrumentDescriptionTrial", `ST, `One, true);
0x0008_2259l, ("Anatomic Location Of Examining Instrument Code Sequence (Trial)", "AnatomicLocationOfExaminingInstrumentCodeSequenceTrial", `SQ, `One, true);
0x0008_225Al, ("Anatomic Structure Space Or Region Modifier Code Sequence (Trial)", "AnatomicStructureSpaceOrRegionModifierCodeSequenceTrial", `SQ, `One, true);
0x0008_225Cl, ("OnAxis Background Anatomic Structure Code Sequence (Trial)", "OnAxisBackgroundAnatomicStructureCodeSequenceTrial", `SQ, `One, true);
0x0008_3001l, ("Alternate Representation Sequence", "AlternateRepresentationSequence", `SQ, `One, false);
0x0008_3010l, ("Irradiation Event UID", "IrradiationEventUID", `UI, `One, false);
0x0008_4000l, ("Identifying Comments", "IdentifyingComments", `LT, `One, true);
0x0008_9007l, ("Frame Type", "FrameType", `CS, `Four, false);
0x0008_9092l, ("Referenced Image Evidence Sequence", "ReferencedImageEvidenceSequence", `SQ, `One, false);
0x0008_9121l, ("Referenced Raw Data Sequence", "ReferencedRawDataSequence", `SQ, `One, false);
0x0008_9123l, ("Creator-Version UID", "CreatorVersionUID", `UI, `One, false);
0x0008_9124l, ("Derivation Image Sequence", "DerivationImageSequence", `SQ, `One, false);
0x0008_9154l, ("Source Image Evidence Sequence", "SourceImageEvidenceSequence", `SQ, `One, false);
0x0008_9205l, ("Pixel Presentation", "PixelPresentation", `CS, `One, false);
0x0008_9206l, ("Volumetric Properties", "VolumetricProperties", `CS, `One, false);
0x0008_9207l, ("Volume Based Calculation Technique", "VolumeBasedCalculationTechnique", `CS, `One, false);
0x0008_9208l, ("Complex Image Component", "ComplexImageComponent", `CS, `One, false);
0x0008_9209l, ("Acquisition Contrast", "AcquisitionContrast", `CS, `One, false);
0x0008_9215l, ("Derivation Code Sequence", "DerivationCodeSequence", `SQ, `One, false);
0x0008_9237l, ("Referenced Presentation State Sequence", "ReferencedPresentationStateSequence", `SQ, `One, false);
0x0008_9410l, ("Referenced Other Plane Sequence", "ReferencedOtherPlaneSequence", `SQ, `One, false);
0x0008_9458l, ("Frame Display Sequence", "FrameDisplaySequence", `SQ, `One, false);
0x0008_9459l, ("Recommended Display Frame Rate in Float", "RecommendedDisplayFrameRateInFloat", `FL, `One, false);
0x0008_9460l, ("Skip Frame Range Flag", "SkipFrameRangeFlag", `CS, `One, false);
0x0010_0010l, ("Patient’s Name", "PatientName", `PN, `One, false);
0x0010_0020l, ("Patient ID", "PatientID", `LO, `One, false);
0x0010_0021l, ("Issuer of Patient ID", "IssuerOfPatientID", `LO, `One, false);
0x0010_0022l, ("Type of Patient ID", "TypeOfPatientID", `CS, `One, false);
0x0010_0024l, ("Issuer of Patient ID Qualifiers Sequence", "IssuerOfPatientIDQualifiersSequence", `SQ, `One, false);
0x0010_0030l, ("Patient’s Birth Date", "PatientBirthDate", `DA, `One, false);
0x0010_0032l, ("Patient’s Birth Time", "PatientBirthTime", `TM, `One, false);
0x0010_0040l, ("Patient’s Sex", "PatientSex", `CS, `One, false);
0x0010_0050l, ("Patient’s Insurance Plan Code Sequence", "PatientInsurancePlanCodeSequence", `SQ, `One, false);
0x0010_0101l, ("Patient’s Primary Language Code Sequence", "PatientPrimaryLanguageCodeSequence", `SQ, `One, false);
0x0010_0102l, ("Patient’s Primary Language Modifier Code Sequence", "PatientPrimaryLanguageModifierCodeSequence", `SQ, `One, false);
0x0010_1000l, ("Other Patient IDs", "OtherPatientIDs", `LO, `One_n, false);
0x0010_1001l, ("Other Patient Names", "OtherPatientNames", `PN, `One_n, false);
0x0010_1002l, ("Other Patient IDs Sequence", "OtherPatientIDsSequence", `SQ, `One, false);
0x0010_1005l, ("Patient’s Birth Name", "PatientBirthName", `PN, `One, false);
0x0010_1010l, ("Patient’s Age", "PatientAge", `AS, `One, false);
0x0010_1020l, ("Patient’s Size", "PatientSize", `DS, `One, false);
0x0010_1021l, ("Patient’s Size Code Sequence", "PatientSizeCodeSequence", `SQ, `One, false);
0x0010_1030l, ("Patient’s Weight", "PatientWeight", `DS, `One, false);
0x0010_1040l, ("Patient’s Address", "PatientAddress", `LO, `One, false);
0x0010_1050l, ("Insurance Plan Identification", "InsurancePlanIdentification", `LO, `One_n, true);
0x0010_1060l, ("Patient’s Mother’s Birth Name", "PatientMotherBirthName", `PN, `One, false);
0x0010_1080l, ("Military Rank", "MilitaryRank", `LO, `One, false);
0x0010_1081l, ("Branch of Service", "BranchOfService", `LO, `One, false);
0x0010_1090l, ("Medical Record Locator", "MedicalRecordLocator", `LO, `One, false);
0x0010_2000l, ("Medical Alerts", "MedicalAlerts", `LO, `One_n, false);
0x0010_2110l, ("Allergies", "Allergies", `LO, `One_n, false);
0x0010_2150l, ("Country of Residence", "CountryOfResidence", `LO, `One, false);
0x0010_2152l, ("Region of Residence", "RegionOfResidence", `LO, `One, false);
0x0010_2154l, ("Patient’s Telephone Numbers", "PatientTelephoneNumbers", `SH, `One_n, false);
0x0010_2160l, ("Ethnic Group", "EthnicGroup", `SH, `One, false);
0x0010_2180l, ("Occupation", "Occupation", `SH, `One, false);
0x0010_21A0l, ("Smoking Status", "SmokingStatus", `CS, `One, false);
0x0010_21B0l, ("Additional Patient History", "AdditionalPatientHistory", `LT, `One, false);
0x0010_21C0l, ("Pregnancy Status", "PregnancyStatus", `US, `One, false);
0x0010_21D0l, ("Last Menstrual Date", "LastMenstrualDate", `DA, `One, false);
0x0010_21F0l, ("Patient’s Religious Preference", "PatientReligiousPreference", `LO, `One, false);
0x0010_2201l, ("Patient Species Description", "PatientSpeciesDescription", `LO, `One, false);
0x0010_2202l, ("Patient Species Code Sequence", "PatientSpeciesCodeSequence", `SQ, `One, false);
0x0010_2203l, ("Patient’s Sex Neutered", "PatientSexNeutered", `CS, `One, false);
0x0010_2210l, ("Anatomical Orientation Type", "AnatomicalOrientationType", `CS, `One, false);
0x0010_2292l, ("Patient Breed Description", "PatientBreedDescription", `LO, `One, false);
0x0010_2293l, ("Patient Breed Code Sequence", "PatientBreedCodeSequence", `SQ, `One, false);
0x0010_2294l, ("Breed Registration Sequence", "BreedRegistrationSequence", `SQ, `One, false);
0x0010_2295l, ("Breed Registration Number", "BreedRegistrationNumber", `LO, `One, false);
0x0010_2296l, ("Breed Registry Code Sequence", "BreedRegistryCodeSequence", `SQ, `One, false);
0x0010_2297l, ("Responsible Person", "ResponsiblePerson", `PN, `One, false);
0x0010_2298l, ("Responsible Person Role", "ResponsiblePersonRole", `CS, `One, false);
0x0010_2299l, ("Responsible Organization", "ResponsibleOrganization", `LO, `One, false);
0x0010_4000l, ("Patient Comments", "PatientComments", `LT, `One, false);
0x0010_9431l, ("Examined Body Thickness", "ExaminedBodyThickness", `FL, `One, false);
0x0012_0010l, ("Clinical Trial Sponsor Name", "ClinicalTrialSponsorName", `LO, `One, false);
0x0012_0020l, ("Clinical Trial Protocol ID", "ClinicalTrialProtocolID", `LO, `One, false);
0x0012_0021l, ("Clinical Trial Protocol Name", "ClinicalTrialProtocolName", `LO, `One, false);
0x0012_0030l, ("Clinical Trial Site ID", "ClinicalTrialSiteID", `LO, `One, false);
0x0012_0031l, ("Clinical Trial Site Name", "ClinicalTrialSiteName", `LO, `One, false);
0x0012_0040l, ("Clinical Trial Subject ID", "ClinicalTrialSubjectID", `LO, `One, false);
0x0012_0042l, ("Clinical Trial Subject Reading ID", "ClinicalTrialSubjectReadingID", `LO, `One, false);
0x0012_0050l, ("Clinical Trial Time Point ID", "ClinicalTrialTimePointID", `LO, `One, false);
0x0012_0051l, ("Clinical Trial Time Point Description", "ClinicalTrialTimePointDescription", `ST, `One, false);
0x0012_0060l, ("Clinical Trial Coordinating Center Name", "ClinicalTrialCoordinatingCenterName", `LO, `One, false);
0x0012_0062l, ("Patient Identity Removed", "PatientIdentityRemoved", `CS, `One, false);
0x0012_0063l, ("De-identification Method", "DeidentificationMethod", `LO, `One_n, false);
0x0012_0064l, ("De-identification Method Code Sequence", "DeidentificationMethodCodeSequence", `SQ, `One, false);
0x0012_0071l, ("Clinical Trial Series ID", "ClinicalTrialSeriesID", `LO, `One, false);
0x0012_0072l, ("Clinical Trial Series Description", "ClinicalTrialSeriesDescription", `LO, `One, false);
0x0012_0081l, ("Clinical Trial Protocol Ethics Committee Name", "ClinicalTrialProtocolEthicsCommitteeName", `LO, `One, false);
0x0012_0082l, ("Clinical Trial Protocol Ethics Committee Approval Number", "ClinicalTrialProtocolEthicsCommitteeApprovalNumber", `LO, `One, false);
0x0012_0083l, ("Consent for Clinical Trial Use Sequence", "ConsentForClinicalTrialUseSequence", `SQ, `One, false);
0x0012_0084l, ("Distribution Type", "DistributionType", `CS, `One, false);
0x0012_0085l, ("Consent for Distribution Flag", "ConsentForDistributionFlag", `CS, `One, false);
0x0014_0023l, ("CAD File Format", "CADFileFormat", `ST, `One_n, false);
0x0014_0024l, ("Component Reference System", "ComponentReferenceSystem", `ST, `One_n, false);
0x0014_0025l, ("Component Manufacturing Procedure", "ComponentManufacturingProcedure", `ST, `One_n, false);
0x0014_0028l, ("Component Manufacturer", "ComponentManufacturer", `ST, `One_n, false);
0x0014_0030l, ("Material Thickness", "MaterialThickness", `DS, `One_n, false);
0x0014_0032l, ("Material Pipe Diameter", "MaterialPipeDiameter", `DS, `One_n, false);
0x0014_0034l, ("Material Isolation Diameter", "MaterialIsolationDiameter", `DS, `One_n, false);
0x0014_0042l, ("Material Grade", "MaterialGrade", `ST, `One_n, false);
0x0014_0044l, ("Material Properties File ID", "MaterialPropertiesFileID", `ST, `One_n, false);
0x0014_0045l, ("Material Properties File Format", "MaterialPropertiesFileFormat", `ST, `One_n, false);
0x0014_0046l, ("Material Notes", "MaterialNotes", `LT, `One, false);
0x0014_0050l, ("Component Shape", "ComponentShape", `CS, `One, false);
0x0014_0052l, ("Curvature Type", "CurvatureType", `CS, `One, false);
0x0014_0054l, ("Outer Diameter", "OuterDiameter", `DS, `One, false);
0x0014_0056l, ("Inner Diameter", "InnerDiameter", `DS, `One, false);
0x0014_1010l, ("Actual Environmental Conditions", "ActualEnvironmentalConditions", `ST, `One, false);
0x0014_1020l, ("Expiry Date", "ExpiryDate", `DA, `One, false);
0x0014_1040l, ("Environmental Conditions", "EnvironmentalConditions", `ST, `One, false);
0x0014_2002l, ("Evaluator Sequence", "EvaluatorSequence", `SQ, `One, false);
0x0014_2004l, ("Evaluator Number", "EvaluatorNumber", `IS, `One, false);
0x0014_2006l, ("Evaluator Name", "EvaluatorName", `PN, `One, false);
0x0014_2008l, ("Evaluation Attempt", "EvaluationAttempt", `IS, `One, false);
0x0014_2012l, ("Indication Sequence", "IndicationSequence", `SQ, `One, false);
0x0014_2014l, ("Indication Number", "IndicationNumber", `IS, `One, false);
0x0014_2016l, ("Indication Label", "IndicationLabel", `SH, `One, false);
0x0014_2018l, ("Indication Description", "IndicationDescription", `ST, `One, false);
0x0014_201Al, ("Indication Type", "IndicationType", `CS, `One_n, false);
0x0014_201Cl, ("Indication Disposition", "IndicationDisposition", `CS, `One, false);
0x0014_201El, ("Indication ROI Sequence", "IndicationROISequence", `SQ, `One, false);
0x0014_2030l, ("Indication Physical Property Sequence", "IndicationPhysicalPropertySequence", `SQ, `One, false);
0x0014_2032l, ("Property Label", "PropertyLabel", `SH, `One, false);
0x0014_2202l, ("Coordinate System Number of Axes", "CoordinateSystemNumberOfAxes", `IS, `One, false);
0x0014_2204l, ("Coordinate System Axes Sequence", "CoordinateSystemAxesSequence", `SQ, `One, false);
0x0014_2206l, ("Coordinate System Axis Description", "CoordinateSystemAxisDescription", `ST, `One, false);
0x0014_2208l, ("Coordinate System Data Set Mapping", "CoordinateSystemDataSetMapping", `CS, `One, false);
0x0014_220Al, ("Coordinate System Axis Number", "CoordinateSystemAxisNumber", `IS, `One, false);
0x0014_220Cl, ("Coordinate System Axis Type", "CoordinateSystemAxisType", `CS, `One, false);
0x0014_220El, ("Coordinate System Axis Units", "CoordinateSystemAxisUnits", `CS, `One, false);
0x0014_2210l, ("Coordinate System Axis Values", "CoordinateSystemAxisValues", `OB, `One, false);
0x0014_2220l, ("Coordinate System Transform Sequence", "CoordinateSystemTransformSequence", `SQ, `One, false);
0x0014_2222l, ("Transform Description", "TransformDescription", `ST, `One, false);
0x0014_2224l, ("Transform Number of Axes", "TransformNumberOfAxes", `IS, `One, false);
0x0014_2226l, ("Transform Order of Axes", "TransformOrderOfAxes", `IS, `One_n, false);
0x0014_2228l, ("Transformed Axis Units", "TransformedAxisUnits", `CS, `One, false);
0x0014_222Al, ("Coordinate System Transform Rotation and Scale Matrix", "CoordinateSystemTransformRotationAndScaleMatrix", `DS, `One_n, false);
0x0014_222Cl, ("Coordinate System Transform Translation Matrix", "CoordinateSystemTransformTranslationMatrix", `DS, `One_n, false);
0x0014_3011l, ("Internal Detector Frame Time", "InternalDetectorFrameTime", `DS, `One, false);
0x0014_3012l, ("Number of Frames Integrated", "NumberOfFramesIntegrated", `DS, `One, false);
0x0014_3020l, ("Detector Temperature Sequence", "DetectorTemperatureSequence", `SQ, `One, false);
0x0014_3022l, ("Sensor Name", "SensorName", `DS, `One, false);
0x0014_3024l, ("Horizontal Offset of Sensor", "HorizontalOffsetOfSensor", `DS, `One, false);
0x0014_3026l, ("Vertical Offset of Sensor", "VerticalOffsetOfSensor", `DS, `One, false);
0x0014_3028l, ("Sensor Temperature", "SensorTemperature", `DS, `One, false);
0x0014_3040l, ("Dark Current Sequence", "DarkCurrentSequence", `SQ, `One, false);
0x0014_3050l, ("Dark Current Counts", "DarkCurrentCounts", `OB_or_OW, `One, false);
0x0014_3060l, ("Gain Correction Reference Sequence", "GainCorrectionReferenceSequence", `SQ, `One, false);
0x0014_3070l, ("Air Counts", "AirCounts", `OB_or_OW, `One, false);
0x0014_3071l, ("KV Used in Gain Calibration", "KVUsedInGainCalibration", `DS, `One, false);
0x0014_3072l, ("MA Used in Gain Calibration", "MAUsedInGainCalibration", `DS, `One, false);
0x0014_3073l, ("Number of Frames Used for Integration", "NumberOfFramesUsedForIntegration", `DS, `One, false);
0x0014_3074l, ("Filter Material Used in Gain Calibration", "FilterMaterialUsedInGainCalibration", `LO, `One, false);
0x0014_3075l, ("Filter Thickness Used in Gain Calibration", "FilterThicknessUsedInGainCalibration", `DS, `One, false);
0x0014_3076l, ("Date of Gain Calibration", "DateOfGainCalibration", `DA, `One, false);
0x0014_3077l, ("Time of Gain Calibration", "TimeOfGainCalibration", `TM, `One, false);
0x0014_3080l, ("Bad Pixel Image", "BadPixelImage", `OB, `One, false);
0x0014_3099l, ("Calibration Notes", "CalibrationNotes", `LT, `One, false);
0x0014_4002l, ("Pulser Equipment Sequence", "PulserEquipmentSequence", `SQ, `One, false);
0x0014_4004l, ("Pulser Type", "PulserType", `CS, `One, false);
0x0014_4006l, ("Pulser Notes", "PulserNotes", `LT, `One, false);
0x0014_4008l, ("Receiver Equipment Sequence", "ReceiverEquipmentSequence", `SQ, `One, false);
0x0014_400Al, ("Amplifier Type", "AmplifierType", `CS, `One, false);
0x0014_400Cl, ("Receiver Notes", "ReceiverNotes", `LT, `One, false);
0x0014_400El, ("Pre-Amplifier Equipment Sequence", "PreAmplifierEquipmentSequence", `SQ, `One, false);
0x0014_400Fl, ("Pre-Amplifier Notes", "PreAmplifierNotes", `LT, `One, false);
0x0014_4010l, ("Transmit Transducer Sequence", "TransmitTransducerSequence", `SQ, `One, false);
0x0014_4011l, ("Receive Transducer Sequence", "ReceiveTransducerSequence", `SQ, `One, false);
0x0014_4012l, ("Number of Elements", "NumberOfElements", `US, `One, false);
0x0014_4013l, ("Element Shape", "ElementShape", `CS, `One, false);
0x0014_4014l, ("Element Dimension A", "ElementDimensionA", `DS, `One, false);
0x0014_4015l, ("Element Dimension B", "ElementDimensionB", `DS, `One, false);
0x0014_4016l, ("Element Pitch", "ElementPitch", `DS, `One, false);
0x0014_4017l, ("Measured Beam Dimension A", "MeasuredBeamDimensionA", `DS, `One, false);
0x0014_4018l, ("Measured Beam Dimension B", "MeasuredBeamDimensionB", `DS, `One, false);
0x0014_4019l, ("Location of Measured Beam Diameter", "LocationOfMeasuredBeamDiameter", `DS, `One, false);
0x0014_401Al, ("Nominal Frequency", "NominalFrequency", `DS, `One, false);
0x0014_401Bl, ("Measured Center Frequency", "MeasuredCenterFrequency", `DS, `One, false);
0x0014_401Cl, ("Measured Bandwidth", "MeasuredBandwidth", `DS, `One, false);
0x0014_4020l, ("Pulser Settings Sequence", "PulserSettingsSequence", `SQ, `One, false);
0x0014_4022l, ("Pulse Width", "PulseWidth", `DS, `One, false);
0x0014_4024l, ("Excitation Frequency", "ExcitationFrequency", `DS, `One, false);
0x0014_4026l, ("Modulation Type", "ModulationType", `CS, `One, false);
0x0014_4028l, ("Damping", "Damping", `DS, `One, false);
0x0014_4030l, ("Receiver Settings Sequence", "ReceiverSettingsSequence", `SQ, `One, false);
0x0014_4031l, ("Acquired Soundpath Length", "AcquiredSoundpathLength", `DS, `One, false);
0x0014_4032l, ("Acquisition Compression Type", "AcquisitionCompressionType", `CS, `One, false);
0x0014_4033l, ("Acquisition Sample Size", "AcquisitionSampleSize", `IS, `One, false);
0x0014_4034l, ("Rectifier Smoothing", "RectifierSmoothing", `DS, `One, false);
0x0014_4035l, ("DAC Sequence", "DACSequence", `SQ, `One, false);
0x0014_4036l, ("DAC Type", "DACType", `CS, `One, false);
0x0014_4038l, ("DAC Gain Points", "DACGainPoints", `DS, `One_n, false);
0x0014_403Al, ("DAC Time Points", "DACTimePoints", `DS, `One_n, false);
0x0014_403Cl, ("DAC Amplitude", "DACAmplitude", `DS, `One_n, false);
0x0014_4040l, ("Pre-Amplifier Settings Sequence", "PreAmplifierSettingsSequence", `SQ, `One, false);
0x0014_4050l, ("Transmit Transducer Settings Sequence", "TransmitTransducerSettingsSequence", `SQ, `One, false);
0x0014_4051l, ("Receive Transducer Settings Sequence", "ReceiveTransducerSettingsSequence", `SQ, `One, false);
0x0014_4052l, ("Incident Angle", "IncidentAngle", `DS, `One, false);
0x0014_4054l, ("Coupling Technique", "CouplingTechnique", `ST, `One, false);
0x0014_4056l, ("Coupling Medium", "CouplingMedium", `ST, `One, false);
0x0014_4057l, ("Coupling Velocity", "CouplingVelocity", `DS, `One, false);
0x0014_4058l, ("Crystal Center Location X", "CrystalCenterLocationX", `DS, `One, false);
0x0014_4059l, ("Crystal Center Location Z", "CrystalCenterLocationZ", `DS, `One, false);
0x0014_405Al, ("Sound Path Length", "SoundPathLength", `DS, `One, false);
0x0014_405Cl, ("Delay Law Identifier", "DelayLawIdentifier", `ST, `One, false);
0x0014_4060l, ("Gate Settings Sequence", "GateSettingsSequence", `SQ, `One, false);
0x0014_4062l, ("Gate Threshold", "GateThreshold", `DS, `One, false);
0x0014_4064l, ("Velocity of Sound", "VelocityOfSound", `DS, `One, false);
0x0014_4070l, ("Calibration Settings Sequence", "CalibrationSettingsSequence", `SQ, `One, false);
0x0014_4072l, ("Calibration Procedure", "CalibrationProcedure", `ST, `One, false);
0x0014_4074l, ("Procedure Version", "ProcedureVersion", `SH, `One, false);
0x0014_4076l, ("Procedure Creation Date", "ProcedureCreationDate", `DA, `One, false);
0x0014_4078l, ("Procedure Expiration Date", "ProcedureExpirationDate", `DA, `One, false);
0x0014_407Al, ("Procedure Last Modified Date", "ProcedureLastModifiedDate", `DA, `One, false);
0x0014_407Cl, ("Calibration Time", "CalibrationTime", `TM, `One_n, false);
0x0014_407El, ("Calibration Date", "CalibrationDate", `DA, `One_n, false);
0x0014_5002l, ("LINAC Energy", "LINACEnergy", `IS, `One, false);
0x0014_5004l, ("LINAC Output", "LINACOutput", `IS, `One, false);
0x0018_0010l, ("Contrast/Bolus Agent", "ContrastBolusAgent", `LO, `One, false);
0x0018_0012l, ("Contrast/Bolus Agent Sequence", "ContrastBolusAgentSequence", `SQ, `One, false);
0x0018_0014l, ("Contrast/Bolus Administration Route Sequence", "ContrastBolusAdministrationRouteSequence", `SQ, `One, false);
0x0018_0015l, ("Body Part Examined", "BodyPartExamined", `CS, `One, false);
0x0018_0020l, ("Scanning Sequence", "ScanningSequence", `CS, `One_n, false);
0x0018_0021l, ("Sequence Variant", "SequenceVariant", `CS, `One_n, false);
0x0018_0022l, ("Scan Options", "ScanOptions", `CS, `One_n, false);
0x0018_0023l, ("MR Acquisition Type", "MRAcquisitionType", `CS, `One, false);
0x0018_0024l, ("Sequence Name", "SequenceName", `SH, `One, false);
0x0018_0025l, ("Angio Flag", "AngioFlag", `CS, `One, false);
0x0018_0026l, ("Intervention Drug Information Sequence", "InterventionDrugInformationSequence", `SQ, `One, false);
0x0018_0027l, ("Intervention Drug Stop Time", "InterventionDrugStopTime", `TM, `One, false);
0x0018_0028l, ("Intervention Drug Dose", "InterventionDrugDose", `DS, `One, false);
0x0018_0029l, ("Intervention Drug Code Sequence", "InterventionDrugCodeSequence", `SQ, `One, false);
0x0018_002Al, ("Additional Drug Sequence", "AdditionalDrugSequence", `SQ, `One, false);
0x0018_0030l, ("Radionuclide", "Radionuclide", `LO, `One_n, true);
0x0018_0031l, ("Radiopharmaceutical", "Radiopharmaceutical", `LO, `One, false);
0x0018_0032l, ("Energy Window Centerline", "EnergyWindowCenterline", `DS, `One, true);
0x0018_0033l, ("Energy Window Total Width", "EnergyWindowTotalWidth", `DS, `One_n, true);
0x0018_0034l, ("Intervention Drug Name", "InterventionDrugName", `LO, `One, false);
0x0018_0035l, ("Intervention Drug Start Time", "InterventionDrugStartTime", `TM, `One, false);
0x0018_0036l, ("Intervention Sequence", "InterventionSequence", `SQ, `One, false);
0x0018_0037l, ("Therapy Type", "TherapyType", `CS, `One, true);
0x0018_0038l, ("Intervention Status", "InterventionStatus", `CS, `One, false);
0x0018_0039l, ("Therapy Description", "TherapyDescription", `CS, `One, true);
0x0018_003Al, ("Intervention Description", "InterventionDescription", `ST, `One, false);
0x0018_0040l, ("Cine Rate", "CineRate", `IS, `One, false);
0x0018_0042l, ("Initial Cine Run State", "InitialCineRunState", `CS, `One, false);
0x0018_0050l, ("Slice Thickness", "SliceThickness", `DS, `One, false);
0x0018_0060l, ("KVP", "KVP", `DS, `One, false);
0x0018_0070l, ("Counts Accumulated", "CountsAccumulated", `IS, `One, false);
0x0018_0071l, ("Acquisition Termination Condition", "AcquisitionTerminationCondition", `CS, `One, false);
0x0018_0072l, ("Effective Duration", "EffectiveDuration", `DS, `One, false);
0x0018_0073l, ("Acquisition Start Condition", "AcquisitionStartCondition", `CS, `One, false);
0x0018_0074l, ("Acquisition Start Condition Data", "AcquisitionStartConditionData", `IS, `One, false);
0x0018_0075l, ("Acquisition Termination Condition Data", "AcquisitionTerminationConditionData", `IS, `One, false);
0x0018_0080l, ("Repetition Time", "RepetitionTime", `DS, `One, false);
0x0018_0081l, ("Echo Time", "EchoTime", `DS, `One, false);
0x0018_0082l, ("Inversion Time", "InversionTime", `DS, `One, false);
0x0018_0083l, ("Number of Averages", "NumberOfAverages", `DS, `One, false);
0x0018_0084l, ("Imaging Frequency", "ImagingFrequency", `DS, `One, false);
0x0018_0085l, ("Imaged Nucleus", "ImagedNucleus", `SH, `One, false);
0x0018_0086l, ("Echo Number(s)", "EchoNumbers", `IS, `One_n, false);
0x0018_0087l, ("Magnetic Field Strength", "MagneticFieldStrength", `DS, `One, false);
0x0018_0088l, ("Spacing Between Slices", "SpacingBetweenSlices", `DS, `One, false);
0x0018_0089l, ("Number of Phase Encoding Steps", "NumberOfPhaseEncodingSteps", `IS, `One, false);
0x0018_0090l, ("Data Collection Diameter", "DataCollectionDiameter", `DS, `One, false);
0x0018_0091l, ("Echo Train Length", "EchoTrainLength", `IS, `One, false);
0x0018_0093l, ("Percent Sampling", "PercentSampling", `DS, `One, false);
0x0018_0094l, ("Percent Phase Field of View", "PercentPhaseFieldOfView", `DS, `One, false);
0x0018_0095l, ("Pixel Bandwidth", "PixelBandwidth", `DS, `One, false);
0x0018_1000l, ("Device Serial Number", "DeviceSerialNumber", `LO, `One, false);
0x0018_1002l, ("Device UID", "DeviceUID", `UI, `One, false);
0x0018_1003l, ("Device ID", "DeviceID", `LO, `One, false);
0x0018_1004l, ("Plate ID", "PlateID", `LO, `One, false);
0x0018_1005l, ("Generator ID", "GeneratorID", `LO, `One, false);
0x0018_1006l, ("Grid ID", "GridID", `LO, `One, false);
0x0018_1007l, ("Cassette ID", "CassetteID", `LO, `One, false);
0x0018_1008l, ("Gantry ID", "GantryID", `LO, `One, false);
0x0018_1010l, ("Secondary Capture Device ID", "SecondaryCaptureDeviceID", `LO, `One, false);
0x0018_1011l, ("Hardcopy Creation Device ID", "HardcopyCreationDeviceID", `LO, `One, true);
0x0018_1012l, ("Date of Secondary Capture", "DateOfSecondaryCapture", `DA, `One, false);
0x0018_1014l, ("Time of Secondary Capture", "TimeOfSecondaryCapture", `TM, `One, false);
0x0018_1016l, ("Secondary Capture Device Manufacturer", "SecondaryCaptureDeviceManufacturer", `LO, `One, false);
0x0018_1017l, ("Hardcopy Device Manufacturer", "HardcopyDeviceManufacturer", `LO, `One, true);
0x0018_1018l, ("Secondary Capture Device Manufacturer’s Model Name", "SecondaryCaptureDeviceManufacturerModelName", `LO, `One, false);
0x0018_1019l, ("Secondary Capture Device Software Versions", "SecondaryCaptureDeviceSoftwareVersions", `LO, `One_n, false);
0x0018_101Al, ("Hardcopy Device Software Version", "HardcopyDeviceSoftwareVersion", `LO, `One_n, true);
0x0018_101Bl, ("Hardcopy Device Manufacturer’s Model Name", "HardcopyDeviceManufacturerModelName", `LO, `One, true);
0x0018_1020l, ("Software Version(s)", "SoftwareVersions", `LO, `One_n, false);
0x0018_1022l, ("Video Image Format Acquired", "VideoImageFormatAcquired", `SH, `One, false);
0x0018_1023l, ("Digital Image Format Acquired", "DigitalImageFormatAcquired", `LO, `One, false);
0x0018_1030l, ("Protocol Name", "ProtocolName", `LO, `One, false);
0x0018_1040l, ("Contrast/Bolus Route", "ContrastBolusRoute", `LO, `One, false);
0x0018_1041l, ("Contrast/Bolus Volume", "ContrastBolusVolume", `DS, `One, false);
0x0018_1042l, ("Contrast/Bolus Start Time", "ContrastBolusStartTime", `TM, `One, false);
0x0018_1043l, ("Contrast/Bolus Stop Time", "ContrastBolusStopTime", `TM, `One, false);
0x0018_1044l, ("Contrast/Bolus Total Dose", "ContrastBolusTotalDose", `DS, `One, false);
0x0018_1045l, ("Syringe Counts", "SyringeCounts", `IS, `One, false);
0x0018_1046l, ("Contrast Flow Rate", "ContrastFlowRate", `DS, `One_n, false);
0x0018_1047l, ("Contrast Flow Duration", "ContrastFlowDuration", `DS, `One_n, false);
0x0018_1048l, ("Contrast/Bolus Ingredient", "ContrastBolusIngredient", `CS, `One, false);
0x0018_1049l, ("Contrast/Bolus Ingredient Concentration", "ContrastBolusIngredientConcentration", `DS, `One, false);
0x0018_1050l, ("Spatial Resolution", "SpatialResolution", `DS, `One, false);
0x0018_1060l, ("Trigger Time", "TriggerTime", `DS, `One, false);
0x0018_1061l, ("Trigger Source or Type", "TriggerSourceOrType", `LO, `One, false);
0x0018_1062l, ("Nominal Interval", "NominalInterval", `IS, `One, false);
0x0018_1063l, ("Frame Time", "FrameTime", `DS, `One, false);
0x0018_1064l, ("Cardiac Framing Type", "CardiacFramingType", `LO, `One, false);
0x0018_1065l, ("Frame Time Vector", "FrameTimeVector", `DS, `One_n, false);
0x0018_1066l, ("Frame Delay", "FrameDelay", `DS, `One, false);
0x0018_1067l, ("Image Trigger Delay", "ImageTriggerDelay", `DS, `One, false);
0x0018_1068l, ("Multiplex Group Time Offset", "MultiplexGroupTimeOffset", `DS, `One, false);
0x0018_1069l, ("Trigger Time Offset", "TriggerTimeOffset", `DS, `One, false);
0x0018_106Al, ("Synchronization Trigger", "SynchronizationTrigger", `CS, `One, false);
0x0018_106Cl, ("Synchronization Channel", "SynchronizationChannel", `US, `Two, false);
0x0018_106El, ("Trigger Sample Position", "TriggerSamplePosition", `UL, `One, false);
0x0018_1070l, ("Radiopharmaceutical Route", "RadiopharmaceuticalRoute", `LO, `One, false);
0x0018_1071l, ("Radiopharmaceutical Volume", "RadiopharmaceuticalVolume", `DS, `One, false);
0x0018_1072l, ("Radiopharmaceutical Start Time", "RadiopharmaceuticalStartTime", `TM, `One, false);
0x0018_1073l, ("Radiopharmaceutical Stop Time", "RadiopharmaceuticalStopTime", `TM, `One, false);
0x0018_1074l, ("Radionuclide Total Dose", "RadionuclideTotalDose", `DS, `One, false);
0x0018_1075l, ("Radionuclide Half Life", "RadionuclideHalfLife", `DS, `One, false);
0x0018_1076l, ("Radionuclide Positron Fraction", "RadionuclidePositronFraction", `DS, `One, false);
0x0018_1077l, ("Radiopharmaceutical Specific Activity", "RadiopharmaceuticalSpecificActivity", `DS, `One, false);
0x0018_1078l, ("Radiopharmaceutical Start DateTime", "RadiopharmaceuticalStartDateTime", `DT, `One, false);
0x0018_1079l, ("Radiopharmaceutical Stop DateTime", "RadiopharmaceuticalStopDateTime", `DT, `One, false);
0x0018_1080l, ("Beat Rejection Flag", "BeatRejectionFlag", `CS, `One, false);
0x0018_1081l, ("Low R-R Value", "LowRRValue", `IS, `One, false);
0x0018_1082l, ("High R-R Value", "HighRRValue", `IS, `One, false);
0x0018_1083l, ("Intervals Acquired", "IntervalsAcquired", `IS, `One, false);
0x0018_1084l, ("Intervals Rejected", "IntervalsRejected", `IS, `One, false);
0x0018_1085l, ("PVC Rejection", "PVCRejection", `LO, `One, false);
0x0018_1086l, ("Skip Beats", "SkipBeats", `IS, `One, false);
0x0018_1088l, ("Heart Rate", "HeartRate", `IS, `One, false);
0x0018_1090l, ("Cardiac Number of Images", "CardiacNumberOfImages", `IS, `One, false);
0x0018_1094l, ("Trigger Window", "TriggerWindow", `IS, `One, false);
0x0018_1100l, ("Reconstruction Diameter", "ReconstructionDiameter", `DS, `One, false);
0x0018_1110l, ("Distance Source to Detector", "DistanceSourceToDetector", `DS, `One, false);
0x0018_1111l, ("Distance Source to Patient", "DistanceSourceToPatient", `DS, `One, false);
0x0018_1114l, ("Estimated Radiographic Magnification Factor", "EstimatedRadiographicMagnificationFactor", `DS, `One, false);
0x0018_1120l, ("Gantry/Detector Tilt", "GantryDetectorTilt", `DS, `One, false);
0x0018_1121l, ("Gantry/Detector Slew", "GantryDetectorSlew", `DS, `One, false);
0x0018_1130l, ("Table Height", "TableHeight", `DS, `One, false);
0x0018_1131l, ("Table Traverse", "TableTraverse", `DS, `One, false);
0x0018_1134l, ("Table Motion", "TableMotion", `CS, `One, false);
0x0018_1135l, ("Table Vertical Increment", "TableVerticalIncrement", `DS, `One_n, false);
0x0018_1136l, ("Table Lateral Increment", "TableLateralIncrement", `DS, `One_n, false);
0x0018_1137l, ("Table Longitudinal Increment", "TableLongitudinalIncrement", `DS, `One_n, false);
0x0018_1138l, ("Table Angle", "TableAngle", `DS, `One, false);
0x0018_113Al, ("Table Type", "TableType", `CS, `One, false);
0x0018_1140l, ("Rotation Direction", "RotationDirection", `CS, `One, false);
0x0018_1141l, ("Angular Position", "AngularPosition", `DS, `One, true);
0x0018_1142l, ("Radial Position", "RadialPosition", `DS, `One_n, false);
0x0018_1143l, ("Scan Arc", "ScanArc", `DS, `One, false);
0x0018_1144l, ("Angular Step", "AngularStep", `DS, `One, false);
0x0018_1145l, ("Center of Rotation Offset", "CenterOfRotationOffset", `DS, `One, false);
0x0018_1146l, ("Rotation Offset", "RotationOffset", `DS, `One_n, true);
0x0018_1147l, ("Field of View Shape", "FieldOfViewShape", `CS, `One, false);
0x0018_1149l, ("Field of View Dimension(s)", "FieldOfViewDimensions", `IS, `One_2, false);
0x0018_1150l, ("Exposure Time", "ExposureTime", `IS, `One, false);
0x0018_1151l, ("X-Ray Tube Current", "XRayTubeCurrent", `IS, `One, false);
0x0018_1152l, ("Exposure", "Exposure", `IS, `One, false);
0x0018_1153l, ("Exposure in µAs", "ExposureInuAs", `IS, `One, false);
0x0018_1154l, ("Average Pulse Width", "AveragePulseWidth", `DS, `One, false);
0x0018_1155l, ("Radiation Setting", "RadiationSetting", `CS, `One, false);
0x0018_1156l, ("Rectification Type", "RectificationType", `CS, `One, false);
0x0018_115Al, ("Radiation Mode", "RadiationMode", `CS, `One, false);
0x0018_115El, ("Image and Fluoroscopy Area Dose Product", "ImageAndFluoroscopyAreaDoseProduct", `DS, `One, false);
0x0018_1160l, ("Filter Type", "FilterType", `SH, `One, false);
0x0018_1161l, ("Type of Filters", "TypeOfFilters", `LO, `One_n, false);
0x0018_1162l, ("Intensifier Size", "IntensifierSize", `DS, `One, false);
0x0018_1164l, ("Imager Pixel Spacing", "ImagerPixelSpacing", `DS, `Two, false);
0x0018_1166l, ("Grid", "Grid", `CS, `One_n, false);
0x0018_1170l, ("Generator Power", "GeneratorPower", `IS, `One, false);
0x0018_1180l, ("Collimator/grid Name", "CollimatorGridName", `SH, `One, false);
0x0018_1181l, ("Collimator Type", "CollimatorType", `CS, `One, false);
0x0018_1182l, ("Focal Distance", "FocalDistance", `IS, `One_2, false);
0x0018_1183l, ("X Focus Center", "XFocusCenter", `DS, `One_2, false);
0x0018_1184l, ("Y Focus Center", "YFocusCenter", `DS, `One_2, false);
0x0018_1190l, ("Focal Spot(s)", "FocalSpots", `DS, `One_n, false);
0x0018_1191l, ("Anode Target Material", "AnodeTargetMaterial", `CS, `One, false);
0x0018_11A0l, ("Body Part Thickness", "BodyPartThickness", `DS, `One, false);
0x0018_11A2l, ("Compression Force", "CompressionForce", `DS, `One, false);
0x0018_1200l, ("Date of Last Calibration", "DateOfLastCalibration", `DA, `One_n, false);
0x0018_1201l, ("Time of Last Calibration", "TimeOfLastCalibration", `TM, `One_n, false);
0x0018_1210l, ("Convolution Kernel", "ConvolutionKernel", `SH, `One_n, false);
0x0018_1240l, ("Upper/Lower Pixel Values", "UpperLowerPixelValues", `IS, `One_n, true);
0x0018_1242l, ("Actual Frame Duration", "ActualFrameDuration", `IS, `One, false);
0x0018_1243l, ("Count Rate", "CountRate", `IS, `One, false);
0x0018_1244l, ("Preferred Playback Sequencing", "PreferredPlaybackSequencing", `US, `One, false);
0x0018_1250l, ("Receive Coil Name", "ReceiveCoilName", `SH, `One, false);
0x0018_1251l, ("Transmit Coil Name", "TransmitCoilName", `SH, `One, false);
0x0018_1260l, ("Plate Type", "PlateType", `SH, `One, false);
0x0018_1261l, ("Phosphor Type", "PhosphorType", `LO, `One, false);
0x0018_1300l, ("Scan Velocity", "ScanVelocity", `DS, `One, false);
0x0018_1301l, ("Whole Body Technique", "WholeBodyTechnique", `CS, `One_n, false);
0x0018_1302l, ("Scan Length", "ScanLength", `IS, `One, false);
0x0018_1310l, ("Acquisition Matrix", "AcquisitionMatrix", `US, `Four, false);
0x0018_1312l, ("In-plane Phase Encoding Direction", "InPlanePhaseEncodingDirection", `CS, `One, false);
0x0018_1314l, ("Flip Angle", "FlipAngle", `DS, `One, false);
0x0018_1315l, ("Variable Flip Angle Flag", "VariableFlipAngleFlag", `CS, `One, false);
0x0018_1316l, ("SAR", "SAR", `DS, `One, false);
0x0018_1318l, ("dB/dt", "dBdt", `DS, `One, false);
0x0018_1400l, ("Acquisition Device Processing Description", "AcquisitionDeviceProcessingDescription", `LO, `One, false);
0x0018_1401l, ("Acquisition Device Processing Code", "AcquisitionDeviceProcessingCode", `LO, `One, false);
0x0018_1402l, ("Cassette Orientation", "CassetteOrientation", `CS, `One, false);
0x0018_1403l, ("Cassette Size", "CassetteSize", `CS, `One, false);
0x0018_1404l, ("Exposures on Plate", "ExposuresOnPlate", `US, `One, false);
0x0018_1405l, ("Relative X-Ray Exposure", "RelativeXRayExposure", `IS, `One, false);
0x0018_1411l, ("Exposure Index", "ExposureIndex", `DS, `One, false);
0x0018_1412l, ("Target Exposure Index", "TargetExposureIndex", `DS, `One, false);
0x0018_1413l, ("Deviation Index", "DeviationIndex", `DS, `One, false);
0x0018_1450l, ("Column Angulation", "ColumnAngulation", `DS, `One, false);
0x0018_1460l, ("Tomo Layer Height", "TomoLayerHeight", `DS, `One, false);
0x0018_1470l, ("Tomo Angle", "TomoAngle", `DS, `One, false);
0x0018_1480l, ("Tomo Time", "TomoTime", `DS, `One, false);
0x0018_1490l, ("Tomo Type", "TomoType", `CS, `One, false);
0x0018_1491l, ("Tomo Class", "TomoClass", `CS, `One, false);
0x0018_1495l, ("Number of Tomosynthesis Source Images", "NumberOfTomosynthesisSourceImages", `IS, `One, false);
0x0018_1500l, ("Positioner Motion", "PositionerMotion", `CS, `One, false);
0x0018_1508l, ("Positioner Type", "PositionerType", `CS, `One, false);
0x0018_1510l, ("Positioner Primary Angle", "PositionerPrimaryAngle", `DS, `One, false);
0x0018_1511l, ("Positioner Secondary Angle", "PositionerSecondaryAngle", `DS, `One, false);
0x0018_1520l, ("Positioner Primary Angle Increment", "PositionerPrimaryAngleIncrement", `DS, `One_n, false);
0x0018_1521l, ("Positioner Secondary Angle Increment", "PositionerSecondaryAngleIncrement", `DS, `One_n, false);
0x0018_1530l, ("Detector Primary Angle", "DetectorPrimaryAngle", `DS, `One, false);
0x0018_1531l, ("Detector Secondary Angle", "DetectorSecondaryAngle", `DS, `One, false);
0x0018_1600l, ("Shutter Shape", "ShutterShape", `CS, `One_3, false);
0x0018_1602l, ("Shutter Left Vertical Edge", "ShutterLeftVerticalEdge", `IS, `One, false);
0x0018_1604l, ("Shutter Right Vertical Edge", "ShutterRightVerticalEdge", `IS, `One, false);
0x0018_1606l, ("Shutter Upper Horizontal Edge", "ShutterUpperHorizontalEdge", `IS, `One, false);
0x0018_1608l, ("Shutter Lower Horizontal Edge", "ShutterLowerHorizontalEdge", `IS, `One, false);
0x0018_1610l, ("Center of Circular Shutter", "CenterOfCircularShutter", `IS, `Two, false);
0x0018_1612l, ("Radius of Circular Shutter", "RadiusOfCircularShutter", `IS, `One, false);
0x0018_1620l, ("Vertices of the Polygonal Shutter", "VerticesOfThePolygonalShutter", `IS, `Two_2n, false);
0x0018_1622l, ("Shutter Presentation Value", "ShutterPresentationValue", `US, `One, false);
0x0018_1623l, ("Shutter Overlay Group", "ShutterOverlayGroup", `US, `One, false);
0x0018_1624l, ("Shutter Presentation Color CIELab Value", "ShutterPresentationColorCIELabValue", `US, `Three, false);
0x0018_1700l, ("Collimator Shape", "CollimatorShape", `CS, `One_3, false);
0x0018_1702l, ("Collimator Left Vertical Edge", "CollimatorLeftVerticalEdge", `IS, `One, false);
0x0018_1704l, ("Collimator Right Vertical Edge", "CollimatorRightVerticalEdge", `IS, `One, false);
0x0018_1706l, ("Collimator Upper Horizontal Edge", "CollimatorUpperHorizontalEdge", `IS, `One, false);
0x0018_1708l, ("Collimator Lower Horizontal Edge", "CollimatorLowerHorizontalEdge", `IS, `One, false);
0x0018_1710l, ("Center of Circular Collimator", "CenterOfCircularCollimator", `IS, `Two, false);
0x0018_1712l, ("Radius of Circular Collimator", "RadiusOfCircularCollimator", `IS, `One, false);
0x0018_1720l, ("Vertices of the Polygonal Collimator", "VerticesOfThePolygonalCollimator", `IS, `Two_2n, false);
0x0018_1800l, ("Acquisition Time Synchronized", "AcquisitionTimeSynchronized", `CS, `One, false);
0x0018_1801l, ("Time Source", "TimeSource", `SH, `One, false);
0x0018_1802l, ("Time Distribution Protocol", "TimeDistributionProtocol", `CS, `One, false);
0x0018_1803l, ("NTP Source Address", "NTPSourceAddress", `LO, `One, false);
0x0018_2001l, ("Page Number Vector", "PageNumberVector", `IS, `One_n, false);
0x0018_2002l, ("Frame Label Vector", "FrameLabelVector", `SH, `One_n, false);
0x0018_2003l, ("Frame Primary Angle Vector", "FramePrimaryAngleVector", `DS, `One_n, false);
0x0018_2004l, ("Frame Secondary Angle Vector", "FrameSecondaryAngleVector", `DS, `One_n, false);
0x0018_2005l, ("Slice Location Vector", "SliceLocationVector", `DS, `One_n, false);
0x0018_2006l, ("Display Window Label Vector", "DisplayWindowLabelVector", `SH, `One_n, false);
0x0018_2010l, ("Nominal Scanned Pixel Spacing", "NominalScannedPixelSpacing", `DS, `Two, false);
0x0018_2020l, ("Digitizing Device Transport Direction", "DigitizingDeviceTransportDirection", `CS, `One, false);
0x0018_2030l, ("Rotation of Scanned Film", "RotationOfScannedFilm", `DS, `One, false);
0x0018_3100l, ("IVUS Acquisition", "IVUSAcquisition", `CS, `One, false);
0x0018_3101l, ("IVUS Pullback Rate", "IVUSPullbackRate", `DS, `One, false);
0x0018_3102l, ("IVUS Gated Rate", "IVUSGatedRate", `DS, `One, false);
0x0018_3103l, ("IVUS Pullback Start Frame Number", "IVUSPullbackStartFrameNumber", `IS, `One, false);
0x0018_3104l, ("IVUS Pullback Stop Frame Number", "IVUSPullbackStopFrameNumber", `IS, `One, false);
0x0018_3105l, ("Lesion Number", "LesionNumber", `IS, `One_n, false);
0x0018_4000l, ("Acquisition Comments", "AcquisitionComments", `LT, `One, true);
0x0018_5000l, ("Output Power", "OutputPower", `SH, `One_n, false);
0x0018_5010l, ("Transducer Data", "TransducerData", `LO, `One_n, false);
0x0018_5012l, ("Focus Depth", "FocusDepth", `DS, `One, false);
0x0018_5020l, ("Processing Function", "ProcessingFunction", `LO, `One, false);
0x0018_5021l, ("Postprocessing Function", "PostprocessingFunction", `LO, `One, true);
0x0018_5022l, ("Mechanical Index", "MechanicalIndex", `DS, `One, false);
0x0018_5024l, ("Bone Thermal Index", "BoneThermalIndex", `DS, `One, false);
0x0018_5026l, ("Cranial Thermal Index", "CranialThermalIndex", `DS, `One, false);
0x0018_5027l, ("Soft Tissue Thermal Index", "SoftTissueThermalIndex", `DS, `One, false);
0x0018_5028l, ("Soft Tissue-focus Thermal Index", "SoftTissueFocusThermalIndex", `DS, `One, false);
0x0018_5029l, ("Soft Tissue-surface Thermal Index", "SoftTissueSurfaceThermalIndex", `DS, `One, false);
0x0018_5030l, ("Dynamic Range", "DynamicRange", `DS, `One, true);
0x0018_5040l, ("Total Gain", "TotalGain", `DS, `One, true);
0x0018_5050l, ("Depth of Scan Field", "DepthOfScanField", `IS, `One, false);
0x0018_5100l, ("Patient Position", "PatientPosition", `CS, `One, false);
0x0018_5101l, ("View Position", "ViewPosition", `CS, `One, false);
0x0018_5104l, ("Projection Eponymous Name Code Sequence", "ProjectionEponymousNameCodeSequence", `SQ, `One, false);
0x0018_5210l, ("Image Transformation Matrix", "ImageTransformationMatrix", `DS, `Six, true);
0x0018_5212l, ("Image Translation Vector", "ImageTranslationVector", `DS, `Three, true);
0x0018_6000l, ("Sensitivity", "Sensitivity", `DS, `One, false);
0x0018_6011l, ("Sequence of Ultrasound Regions", "SequenceOfUltrasoundRegions", `SQ, `One, false);
0x0018_6012l, ("Region Spatial Format", "RegionSpatialFormat", `US, `One, false);
0x0018_6014l, ("Region Data Type", "RegionDataType", `US, `One, false);
0x0018_6016l, ("Region Flags", "RegionFlags", `UL, `One, false);
0x0018_6018l, ("Region Location Min X0", "RegionLocationMinX0", `UL, `One, false);
0x0018_601Al, ("Region Location Min Y0", "RegionLocationMinY0", `UL, `One, false);
0x0018_601Cl, ("Region Location Max X1", "RegionLocationMaxX1", `UL, `One, false);
0x0018_601El, ("Region Location Max Y1", "RegionLocationMaxY1", `UL, `One, false);
0x0018_6020l, ("Reference Pixel X0", "ReferencePixelX0", `SL, `One, false);
0x0018_6022l, ("Reference Pixel Y0", "ReferencePixelY0", `SL, `One, false);
0x0018_6024l, ("Physical Units X Direction", "PhysicalUnitsXDirection", `US, `One, false);
0x0018_6026l, ("Physical Units Y Direction", "PhysicalUnitsYDirection", `US, `One, false);
0x0018_6028l, ("Reference Pixel Physical Value X", "ReferencePixelPhysicalValueX", `FD, `One, false);
0x0018_602Al, ("Reference Pixel Physical Value Y", "ReferencePixelPhysicalValueY", `FD, `One, false);
0x0018_602Cl, ("Physical Delta X", "PhysicalDeltaX", `FD, `One, false);
0x0018_602El, ("Physical Delta Y", "PhysicalDeltaY", `FD, `One, false);
0x0018_6030l, ("Transducer Frequency", "TransducerFrequency", `UL, `One, false);
0x0018_6031l, ("Transducer Type", "TransducerType", `CS, `One, false);
0x0018_6032l, ("Pulse Repetition Frequency", "PulseRepetitionFrequency", `UL, `One, false);
0x0018_6034l, ("Doppler Correction Angle", "DopplerCorrectionAngle", `FD, `One, false);
0x0018_6036l, ("Steering Angle", "SteeringAngle", `FD, `One, false);
0x0018_6038l, ("Doppler Sample Volume X Position (Retired)", "DopplerSampleVolumeXPositionRetired", `UL, `One, true);
0x0018_6039l, ("Doppler Sample Volume X Position", "DopplerSampleVolumeXPosition", `SL, `One, false);
0x0018_603Al, ("Doppler Sample Volume Y Position (Retired)", "DopplerSampleVolumeYPositionRetired", `UL, `One, true);
0x0018_603Bl, ("Doppler Sample Volume Y Position", "DopplerSampleVolumeYPosition", `SL, `One, false);
0x0018_603Cl, ("TM-Line Position X0 (Retired)", "TMLinePositionX0Retired", `UL, `One, true);
0x0018_603Dl, ("TM-Line Position X0", "TMLinePositionX0", `SL, `One, false);
0x0018_603El, ("TM-Line Position Y0 (Retired)", "TMLinePositionY0Retired", `UL, `One, true);
0x0018_603Fl, ("TM-Line Position Y0", "TMLinePositionY0", `SL, `One, false);
0x0018_6040l, ("TM-Line Position X1 (Retired)", "TMLinePositionX1Retired", `UL, `One, true);
0x0018_6041l, ("TM-Line Position X1", "TMLinePositionX1", `SL, `One, false);
0x0018_6042l, ("TM-Line Position Y1 (Retired)", "TMLinePositionY1Retired", `UL, `One, true);
0x0018_6043l, ("TM-Line Position Y1", "TMLinePositionY1", `SL, `One, false);
0x0018_6044l, ("Pixel Component Organization", "PixelComponentOrganization", `US, `One, false);
0x0018_6046l, ("Pixel Component Mask", "PixelComponentMask", `UL, `One, false);
0x0018_6048l, ("Pixel Component Range Start", "PixelComponentRangeStart", `UL, `One, false);
0x0018_604Al, ("Pixel Component Range Stop", "PixelComponentRangeStop", `UL, `One, false);
0x0018_604Cl, ("Pixel Component Physical Units", "PixelComponentPhysicalUnits", `US, `One, false);
0x0018_604El, ("Pixel Component Data Type", "PixelComponentDataType", `US, `One, false);
0x0018_6050l, ("Number of Table Break Points", "NumberOfTableBreakPoints", `UL, `One, false);
0x0018_6052l, ("Table of X Break Points", "TableOfXBreakPoints", `UL, `One_n, false);
0x0018_6054l, ("Table of Y Break Points", "TableOfYBreakPoints", `FD, `One_n, false);
0x0018_6056l, ("Number of Table Entries", "NumberOfTableEntries", `UL, `One, false);
0x0018_6058l, ("Table of Pixel Values", "TableOfPixelValues", `UL, `One_n, false);
0x0018_605Al, ("Table of Parameter Values", "TableOfParameterValues", `FL, `One_n, false);
0x0018_6060l, ("R Wave Time Vector", "RWaveTimeVector", `FL, `One_n, false);
0x0018_7000l, ("Detector Conditions Nominal Flag", "DetectorConditionsNominalFlag", `CS, `One, false);
0x0018_7001l, ("Detector Temperature", "DetectorTemperature", `DS, `One, false);
0x0018_7004l, ("Detector Type", "DetectorType", `CS, `One, false);
0x0018_7005l, ("Detector Configuration", "DetectorConfiguration", `CS, `One, false);
0x0018_7006l, ("Detector Description", "DetectorDescription", `LT, `One, false);
0x0018_7008l, ("Detector Mode", "DetectorMode", `LT, `One, false);
0x0018_700Al, ("Detector ID", "DetectorID", `SH, `One, false);
0x0018_700Cl, ("Date of Last Detector Calibration", "DateOfLastDetectorCalibration", `DA, `One, false);
0x0018_700El, ("Time of Last Detector Calibration", "TimeOfLastDetectorCalibration", `TM, `One, false);
0x0018_7010l, ("Exposures on Detector Since Last Calibration", "ExposuresOnDetectorSinceLastCalibration", `IS, `One, false);
0x0018_7011l, ("Exposures on Detector Since Manufactured", "ExposuresOnDetectorSinceManufactured", `IS, `One, false);
0x0018_7012l, ("Detector Time Since Last Exposure", "DetectorTimeSinceLastExposure", `DS, `One, false);
0x0018_7014l, ("Detector Active Time", "DetectorActiveTime", `DS, `One, false);
0x0018_7016l, ("Detector Activation Offset From Exposure", "DetectorActivationOffsetFromExposure", `DS, `One, false);
0x0018_701Al, ("Detector Binning", "DetectorBinning", `DS, `Two, false);
0x0018_7020l, ("Detector Element Physical Size", "DetectorElementPhysicalSize", `DS, `Two, false);
0x0018_7022l, ("Detector Element Spacing", "DetectorElementSpacing", `DS, `Two, false);
0x0018_7024l, ("Detector Active Shape", "DetectorActiveShape", `CS, `One, false);
0x0018_7026l, ("Detector Active Dimension(s)", "DetectorActiveDimensions", `DS, `One_2, false);
0x0018_7028l, ("Detector Active Origin", "DetectorActiveOrigin", `DS, `Two, false);
0x0018_702Al, ("Detector Manufacturer Name", "DetectorManufacturerName", `LO, `One, false);
0x0018_702Bl, ("Detector Manufacturer’s Model Name", "DetectorManufacturerModelName", `LO, `One, false);
0x0018_7030l, ("Field of View Origin", "FieldOfViewOrigin", `DS, `Two, false);
0x0018_7032l, ("Field of View Rotation", "FieldOfViewRotation", `DS, `One, false);
0x0018_7034l, ("Field of View Horizontal Flip", "FieldOfViewHorizontalFlip", `CS, `One, false);
0x0018_7036l, ("Pixel Data Area Origin Relative To FOV", "PixelDataAreaOriginRelativeToFOV", `FL, `Two, false);
0x0018_7038l, ("Pixel Data Area Rotation Angle Relative To FOV", "PixelDataAreaRotationAngleRelativeToFOV", `FL, `One, false);
0x0018_7040l, ("Grid Absorbing Material", "GridAbsorbingMaterial", `LT, `One, false);
0x0018_7041l, ("Grid Spacing Material", "GridSpacingMaterial", `LT, `One, false);
0x0018_7042l, ("Grid Thickness", "GridThickness", `DS, `One, false);
0x0018_7044l, ("Grid Pitch", "GridPitch", `DS, `One, false);
0x0018_7046l, ("Grid Aspect Ratio", "GridAspectRatio", `IS, `Two, false);
0x0018_7048l, ("Grid Period", "GridPeriod", `DS, `One, false);
0x0018_704Cl, ("Grid Focal Distance", "GridFocalDistance", `DS, `One, false);
0x0018_7050l, ("Filter Material", "FilterMaterial", `CS, `One_n, false);
0x0018_7052l, ("Filter Thickness Minimum", "FilterThicknessMinimum", `DS, `One_n, false);
0x0018_7054l, ("Filter Thickness Maximum", "FilterThicknessMaximum", `DS, `One_n, false);
0x0018_7056l, ("Filter Beam Path Length Minimum", "FilterBeamPathLengthMinimum", `FL, `One_n, false);
0x0018_7058l, ("Filter Beam Path Length Maximum", "FilterBeamPathLengthMaximum", `FL, `One_n, false);
0x0018_7060l, ("Exposure Control Mode", "ExposureControlMode", `CS, `One, false);
0x0018_7062l, ("Exposure Control Mode Description", "ExposureControlModeDescription", `LT, `One, false);
0x0018_7064l, ("Exposure Status", "ExposureStatus", `CS, `One, false);
0x0018_7065l, ("Phototimer Setting", "PhototimerSetting", `DS, `One, false);
0x0018_8150l, ("Exposure Time in µS", "ExposureTimeInuS", `DS, `One, false);
0x0018_8151l, ("X-Ray Tube Current in µA", "XRayTubeCurrentInuA", `DS, `One, false);
0x0018_9004l, ("Content Qualification", "ContentQualification", `CS, `One, false);
0x0018_9005l, ("Pulse Sequence Name", "PulseSequenceName", `SH, `One, false);
0x0018_9006l, ("MR Imaging Modifier Sequence", "MRImagingModifierSequence", `SQ, `One, false);
0x0018_9008l, ("Echo Pulse Sequence", "EchoPulseSequence", `CS, `One, false);
0x0018_9009l, ("Inversion Recovery", "InversionRecovery", `CS, `One, false);
0x0018_9010l, ("Flow Compensation", "FlowCompensation", `CS, `One, false);
0x0018_9011l, ("Multiple Spin Echo", "MultipleSpinEcho", `CS, `One, false);
0x0018_9012l, ("Multi-planar Excitation", "MultiPlanarExcitation", `CS, `One, false);
0x0018_9014l, ("Phase Contrast", "PhaseContrast", `CS, `One, false);
0x0018_9015l, ("Time of Flight Contrast", "TimeOfFlightContrast", `CS, `One, false);
0x0018_9016l, ("Spoiling", "Spoiling", `CS, `One, false);
0x0018_9017l, ("Steady State Pulse Sequence", "SteadyStatePulseSequence", `CS, `One, false);
0x0018_9018l, ("Echo Planar Pulse Sequence", "EchoPlanarPulseSequence", `CS, `One, false);
0x0018_9019l, ("Tag Angle First Axis", "TagAngleFirstAxis", `FD, `One, false);
0x0018_9020l, ("Magnetization Transfer", "MagnetizationTransfer", `CS, `One, false);
0x0018_9021l, ("T2 Preparation", "T2Preparation", `CS, `One, false);
0x0018_9022l, ("Blood Signal Nulling", "BloodSignalNulling", `CS, `One, false);
0x0018_9024l, ("Saturation Recovery", "SaturationRecovery", `CS, `One, false);
0x0018_9025l, ("Spectrally Selected Suppression", "SpectrallySelectedSuppression", `CS, `One, false);
0x0018_9026l, ("Spectrally Selected Excitation", "SpectrallySelectedExcitation", `CS, `One, false);
0x0018_9027l, ("Spatial Pre-saturation", "SpatialPresaturation", `CS, `One, false);
0x0018_9028l, ("Tagging", "Tagging", `CS, `One, false);
0x0018_9029l, ("Oversampling Phase", "OversamplingPhase", `CS, `One, false);
0x0018_9030l, ("Tag Spacing First Dimension", "TagSpacingFirstDimension", `FD, `One, false);
0x0018_9032l, ("Geometry of k-Space Traversal", "GeometryOfKSpaceTraversal", `CS, `One, false);
0x0018_9033l, ("Segmented k-Space Traversal", "SegmentedKSpaceTraversal", `CS, `One, false);
0x0018_9034l, ("Rectilinear Phase Encode Reordering", "RectilinearPhaseEncodeReordering", `CS, `One, false);
0x0018_9035l, ("Tag Thickness", "TagThickness", `FD, `One, false);
0x0018_9036l, ("Partial Fourier Direction", "PartialFourierDirection", `CS, `One, false);
0x0018_9037l, ("Cardiac Synchronization Technique", "CardiacSynchronizationTechnique", `CS, `One, false);
0x0018_9041l, ("Receive Coil Manufacturer Name", "ReceiveCoilManufacturerName", `LO, `One, false);
0x0018_9042l, ("MR Receive Coil Sequence", "MRReceiveCoilSequence", `SQ, `One, false);
0x0018_9043l, ("Receive Coil Type", "ReceiveCoilType", `CS, `One, false);
0x0018_9044l, ("Quadrature Receive Coil", "QuadratureReceiveCoil", `CS, `One, false);
0x0018_9045l, ("Multi-Coil Definition Sequence", "MultiCoilDefinitionSequence", `SQ, `One, false);
0x0018_9046l, ("Multi-Coil Configuration", "MultiCoilConfiguration", `LO, `One, false);
0x0018_9047l, ("Multi-Coil Element Name", "MultiCoilElementName", `SH, `One, false);
0x0018_9048l, ("Multi-Coil Element Used", "MultiCoilElementUsed", `CS, `One, false);
0x0018_9049l, ("MR Transmit Coil Sequence", "MRTransmitCoilSequence", `SQ, `One, false);
0x0018_9050l, ("Transmit Coil Manufacturer Name", "TransmitCoilManufacturerName", `LO, `One, false);
0x0018_9051l, ("Transmit Coil Type", "TransmitCoilType", `CS, `One, false);
0x0018_9052l, ("Spectral Width", "SpectralWidth", `FD, `One_2, false);
0x0018_9053l, ("Chemical Shift Reference", "ChemicalShiftReference", `FD, `One_2, false);
0x0018_9054l, ("Volume Localization Technique", "VolumeLocalizationTechnique", `CS, `One, false);
0x0018_9058l, ("MR Acquisition Frequency Encoding Steps", "MRAcquisitionFrequencyEncodingSteps", `US, `One, false);
0x0018_9059l, ("De-coupling", "Decoupling", `CS, `One, false);
0x0018_9060l, ("De-coupled Nucleus", "DecoupledNucleus", `CS, `One_2, false);
0x0018_9061l, ("De-coupling Frequency", "DecouplingFrequency", `FD, `One_2, false);
0x0018_9062l, ("De-coupling Method", "DecouplingMethod", `CS, `One, false);
0x0018_9063l, ("De-coupling Chemical Shift Reference", "DecouplingChemicalShiftReference", `FD, `One_2, false);
0x0018_9064l, ("k-space Filtering", "KSpaceFiltering", `CS, `One, false);
0x0018_9065l, ("Time Domain Filtering", "TimeDomainFiltering", `CS, `One_2, false);
0x0018_9066l, ("Number of Zero Fills", "NumberOfZeroFills", `US, `One_2, false);
0x0018_9067l, ("Baseline Correction", "BaselineCorrection", `CS, `One, false);
0x0018_9069l, ("Parallel Reduction Factor In-plane", "ParallelReductionFactorInPlane", `FD, `One, false);
0x0018_9070l, ("Cardiac R-R Interval Specified", "CardiacRRIntervalSpecified", `FD, `One, false);
0x0018_9073l, ("Acquisition Duration", "AcquisitionDuration", `FD, `One, false);
0x0018_9074l, ("Frame Acquisition DateTime", "FrameAcquisitionDateTime", `DT, `One, false);
0x0018_9075l, ("Diffusion Directionality", "DiffusionDirectionality", `CS, `One, false);
0x0018_9076l, ("Diffusion Gradient Direction Sequence", "DiffusionGradientDirectionSequence", `SQ, `One, false);
0x0018_9077l, ("Parallel Acquisition", "ParallelAcquisition", `CS, `One, false);
0x0018_9078l, ("Parallel Acquisition Technique", "ParallelAcquisitionTechnique", `CS, `One, false);
0x0018_9079l, ("Inversion Times", "InversionTimes", `FD, `One_n, false);
0x0018_9080l, ("Metabolite Map Description", "MetaboliteMapDescription", `ST, `One, false);
0x0018_9081l, ("Partial Fourier", "PartialFourier", `CS, `One, false);
0x0018_9082l, ("Effective Echo Time", "EffectiveEchoTime", `FD, `One, false);
0x0018_9083l, ("Metabolite Map Code Sequence", "MetaboliteMapCodeSequence", `SQ, `One, false);
0x0018_9084l, ("Chemical Shift Sequence", "ChemicalShiftSequence", `SQ, `One, false);
0x0018_9085l, ("Cardiac Signal Source", "CardiacSignalSource", `CS, `One, false);
0x0018_9087l, ("Diffusion b-value", "DiffusionBValue", `FD, `One, false);
0x0018_9089l, ("Diffusion Gradient Orientation", "DiffusionGradientOrientation", `FD, `Three, false);
0x0018_9090l, ("Velocity Encoding Direction", "VelocityEncodingDirection", `FD, `Three, false);
0x0018_9091l, ("Velocity Encoding Minimum Value", "VelocityEncodingMinimumValue", `FD, `One, false);
0x0018_9092l, ("Velocity Encoding Acquisition Sequence", "VelocityEncodingAcquisitionSequence", `SQ, `One, false);
0x0018_9093l, ("Number of k-Space Trajectories", "NumberOfKSpaceTrajectories", `US, `One, false);
0x0018_9094l, ("Coverage of k-Space", "CoverageOfKSpace", `CS, `One, false);
0x0018_9095l, ("Spectroscopy Acquisition Phase Rows", "SpectroscopyAcquisitionPhaseRows", `UL, `One, false);
0x0018_9096l, ("Parallel Reduction Factor In-plane (Retired)", "ParallelReductionFactorInPlaneRetired", `FD, `One, true);
0x0018_9098l, ("Transmitter Frequency", "TransmitterFrequency", `FD, `One_2, false);
0x0018_9100l, ("Resonant Nucleus", "ResonantNucleus", `CS, `One_2, false);
0x0018_9101l, ("Frequency Correction", "FrequencyCorrection", `CS, `One, false);
0x0018_9103l, ("MR Spectroscopy FOV/Geometry Sequence", "MRSpectroscopyFOVGeometrySequence", `SQ, `One, false);
0x0018_9104l, ("Slab Thickness", "SlabThickness", `FD, `One, false);
0x0018_9105l, ("Slab Orientation", "SlabOrientation", `FD, `Three, false);
0x0018_9106l, ("Mid Slab Position", "MidSlabPosition", `FD, `Three, false);
0x0018_9107l, ("MR Spatial Saturation Sequence", "MRSpatialSaturationSequence", `SQ, `One, false);
0x0018_9112l, ("MR Timing and Related Parameters Sequence", "MRTimingAndRelatedParametersSequence", `SQ, `One, false);
0x0018_9114l, ("MR Echo Sequence", "MREchoSequence", `SQ, `One, false);
0x0018_9115l, ("MR Modifier Sequence", "MRModifierSequence", `SQ, `One, false);
0x0018_9117l, ("MR Diffusion Sequence", "MRDiffusionSequence", `SQ, `One, false);
0x0018_9118l, ("Cardiac Synchronization Sequence", "CardiacSynchronizationSequence", `SQ, `One, false);
0x0018_9119l, ("MR Averages Sequence", "MRAveragesSequence", `SQ, `One, false);
0x0018_9125l, ("MR FOV/Geometry Sequence", "MRFOVGeometrySequence", `SQ, `One, false);
0x0018_9126l, ("Volume Localization Sequence", "VolumeLocalizationSequence", `SQ, `One, false);
0x0018_9127l, ("Spectroscopy Acquisition Data Columns", "SpectroscopyAcquisitionDataColumns", `UL, `One, false);
0x0018_9147l, ("Diffusion Anisotropy Type", "DiffusionAnisotropyType", `CS, `One, false);
0x0018_9151l, ("Frame Reference DateTime", "FrameReferenceDateTime", `DT, `One, false);
0x0018_9152l, ("MR Metabolite Map Sequence", "MRMetaboliteMapSequence", `SQ, `One, false);
0x0018_9155l, ("Parallel Reduction Factor out-of-plane", "ParallelReductionFactorOutOfPlane", `FD, `One, false);
0x0018_9159l, ("Spectroscopy Acquisition Out-of-plane Phase Steps", "SpectroscopyAcquisitionOutOfPlanePhaseSteps", `UL, `One, false);
0x0018_9166l, ("Bulk Motion Status", "BulkMotionStatus", `CS, `One, true);
0x0018_9168l, ("Parallel Reduction Factor Second In-plane", "ParallelReductionFactorSecondInPlane", `FD, `One, false);
0x0018_9169l, ("Cardiac Beat Rejection Technique", "CardiacBeatRejectionTechnique", `CS, `One, false);
0x0018_9170l, ("Respiratory Motion Compensation Technique", "RespiratoryMotionCompensationTechnique", `CS, `One, false);
0x0018_9171l, ("Respiratory Signal Source", "RespiratorySignalSource", `CS, `One, false);
0x0018_9172l, ("Bulk Motion Compensation Technique", "BulkMotionCompensationTechnique", `CS, `One, false);
0x0018_9173l, ("Bulk Motion Signal Source", "BulkMotionSignalSource", `CS, `One, false);
0x0018_9174l, ("Applicable Safety Standard Agency", "ApplicableSafetyStandardAgency", `CS, `One, false);
0x0018_9175l, ("Applicable Safety Standard Description", "ApplicableSafetyStandardDescription", `LO, `One, false);
0x0018_9176l, ("Operating Mode Sequence", "OperatingModeSequence", `SQ, `One, false);
0x0018_9177l, ("Operating Mode Type", "OperatingModeType", `CS, `One, false);
0x0018_9178l, ("Operating Mode", "OperatingMode", `CS, `One, false);
0x0018_9179l, ("Specific Absorption Rate Definition", "SpecificAbsorptionRateDefinition", `CS, `One, false);
0x0018_9180l, ("Gradient Output Type", "GradientOutputType", `CS, `One, false);
0x0018_9181l, ("Specific Absorption Rate Value", "SpecificAbsorptionRateValue", `FD, `One, false);
0x0018_9182l, ("Gradient Output", "GradientOutput", `FD, `One, false);
0x0018_9183l, ("Flow Compensation Direction", "FlowCompensationDirection", `CS, `One, false);
0x0018_9184l, ("Tagging Delay", "TaggingDelay", `FD, `One, false);
0x0018_9185l, ("Respiratory Motion Compensation Technique Description", "RespiratoryMotionCompensationTechniqueDescription", `ST, `One, false);
0x0018_9186l, ("Respiratory Signal Source ID", "RespiratorySignalSourceID", `SH, `One, false);
0x0018_9195l, ("Chemical Shift Minimum Integration Limit in Hz", "ChemicalShiftMinimumIntegrationLimitInHz", `FD, `One, true);
0x0018_9196l, ("Chemical Shift Maximum Integration Limit in Hz", "ChemicalShiftMaximumIntegrationLimitInHz", `FD, `One, true);
0x0018_9197l, ("MR Velocity Encoding Sequence", "MRVelocityEncodingSequence", `SQ, `One, false);
0x0018_9198l, ("First Order Phase Correction", "FirstOrderPhaseCorrection", `CS, `One, false);
0x0018_9199l, ("Water Referenced Phase Correction", "WaterReferencedPhaseCorrection", `CS, `One, false);
0x0018_9200l, ("MR Spectroscopy Acquisition Type", "MRSpectroscopyAcquisitionType", `CS, `One, false);
0x0018_9214l, ("Respiratory Cycle Position", "RespiratoryCyclePosition", `CS, `One, false);
0x0018_9217l, ("Velocity Encoding Maximum Value", "VelocityEncodingMaximumValue", `FD, `One, false);
0x0018_9218l, ("Tag Spacing Second Dimension", "TagSpacingSecondDimension", `FD, `One, false);
0x0018_9219l, ("Tag Angle Second Axis", "TagAngleSecondAxis", `SS, `One, false);
0x0018_9220l, ("Frame Acquisition Duration", "FrameAcquisitionDuration", `FD, `One, false);
0x0018_9226l, ("MR Image Frame Type Sequence", "MRImageFrameTypeSequence", `SQ, `One, false);
0x0018_9227l, ("MR Spectroscopy Frame Type Sequence", "MRSpectroscopyFrameTypeSequence", `SQ, `One, false);
0x0018_9231l, ("MR Acquisition Phase Encoding Steps in-plane", "MRAcquisitionPhaseEncodingStepsInPlane", `US, `One, false);
0x0018_9232l, ("MR Acquisition Phase Encoding Steps out-of-plane", "MRAcquisitionPhaseEncodingStepsOutOfPlane", `US, `One, false);
0x0018_9234l, ("Spectroscopy Acquisition Phase Columns", "SpectroscopyAcquisitionPhaseColumns", `UL, `One, false);
0x0018_9236l, ("Cardiac Cycle Position", "CardiacCyclePosition", `CS, `One, false);
0x0018_9239l, ("Specific Absorption Rate Sequence", "SpecificAbsorptionRateSequence", `SQ, `One, false);
0x0018_9240l, ("RF Echo Train Length", "RFEchoTrainLength", `US, `One, false);
0x0018_9241l, ("Gradient Echo Train Length", "GradientEchoTrainLength", `US, `One, false);
0x0018_9250l, ("Arterial Spin Labeling Contrast", "ArterialSpinLabelingContrast", `CS, `One, false);
0x0018_9251l, ("MR Arterial Spin Labeling Sequence", "MRArterialSpinLabelingSequence", `SQ, `One, false);
0x0018_9252l, ("ASL Technique Description", "ASLTechniqueDescription", `LO, `One, false);
0x0018_9253l, ("ASL Slab Number", "ASLSlabNumber", `US, `One, false);
0x0018_9254l, ("ASL Slab Thickness", "ASLSlabThickness", `FD, `One, false);
0x0018_9255l, ("ASL Slab Orientation", "ASLSlabOrientation", `FD, `Three, false);
0x0018_9256l, ("ASL Mid Slab Position", "ASLMidSlabPosition", `FD, `Three, false);
0x0018_9257l, ("ASL Context", "ASLContext", `CS, `One, false);
0x0018_9258l, ("ASL Pulse Train Duration", "ASLPulseTrainDuration", `UL, `One, false);
0x0018_9259l, ("ASL Crusher Flag", "ASLCrusherFlag", `CS, `One, false);
0x0018_925Al, ("ASL Crusher Flow", "ASLCrusherFlow", `FD, `One, false);
0x0018_925Bl, ("ASL Crusher Description", "ASLCrusherDescription", `LO, `One, false);
0x0018_925Cl, ("ASL Bolus Cut-off Flag", "ASLBolusCutoffFlag", `CS, `One, false);
0x0018_925Dl, ("ASL Bolus Cut-off Timing Sequence", "ASLBolusCutoffTimingSequence", `SQ, `One, false);
0x0018_925El, ("ASL Bolus Cut-off Technique", "ASLBolusCutoffTechnique", `LO, `One, false);
0x0018_925Fl, ("ASL Bolus Cut-off Delay Time", "ASLBolusCutoffDelayTime", `UL, `One, false);
0x0018_9260l, ("ASL Slab Sequence", "ASLSlabSequence", `SQ, `One, false);
0x0018_9295l, ("Chemical Shift Minimum Integration Limit in ppm", "ChemicalShiftMinimumIntegrationLimitInppm", `FD, `One, false);
0x0018_9296l, ("Chemical Shift Maximum Integration Limit in ppm", "ChemicalShiftMaximumIntegrationLimitInppm", `FD, `One, false);
0x0018_9301l, ("CT Acquisition Type Sequence", "CTAcquisitionTypeSequence", `SQ, `One, false);
0x0018_9302l, ("Acquisition Type", "AcquisitionType", `CS, `One, false);
0x0018_9303l, ("Tube Angle", "TubeAngle", `FD, `One, false);
0x0018_9304l, ("CT Acquisition Details Sequence", "CTAcquisitionDetailsSequence", `SQ, `One, false);
0x0018_9305l, ("Revolution Time", "RevolutionTime", `FD, `One, false);
0x0018_9306l, ("Single Collimation Width", "SingleCollimationWidth", `FD, `One, false);
0x0018_9307l, ("Total Collimation Width", "TotalCollimationWidth", `FD, `One, false);
0x0018_9308l, ("CT Table Dynamics Sequence", "CTTableDynamicsSequence", `SQ, `One, false);
0x0018_9309l, ("Table Speed", "TableSpeed", `FD, `One, false);
0x0018_9310l, ("Table Feed per Rotation", "TableFeedPerRotation", `FD, `One, false);
0x0018_9311l, ("Spiral Pitch Factor", "SpiralPitchFactor", `FD, `One, false);
0x0018_9312l, ("CT Geometry Sequence", "CTGeometrySequence", `SQ, `One, false);
0x0018_9313l, ("Data Collection Center (Patient)", "DataCollectionCenterPatient", `FD, `Three, false);
0x0018_9314l, ("CT Reconstruction Sequence", "CTReconstructionSequence", `SQ, `One, false);
0x0018_9315l, ("Reconstruction Algorithm", "ReconstructionAlgorithm", `CS, `One, false);
0x0018_9316l, ("Convolution Kernel Group", "ConvolutionKernelGroup", `CS, `One, false);
0x0018_9317l, ("Reconstruction Field of View", "ReconstructionFieldOfView", `FD, `Two, false);
0x0018_9318l, ("Reconstruction Target Center (Patient)", "ReconstructionTargetCenterPatient", `FD, `Three, false);
0x0018_9319l, ("Reconstruction Angle", "ReconstructionAngle", `FD, `One, false);
0x0018_9320l, ("Image Filter", "ImageFilter", `SH, `One, false);
0x0018_9321l, ("CT Exposure Sequence", "CTExposureSequence", `SQ, `One, false);
0x0018_9322l, ("Reconstruction Pixel Spacing", "ReconstructionPixelSpacing", `FD, `Two, false);
0x0018_9323l, ("Exposure Modulation Type", "ExposureModulationType", `CS, `One, false);
0x0018_9324l, ("Estimated Dose Saving", "EstimatedDoseSaving", `FD, `One, false);
0x0018_9325l, ("CT X-Ray Details Sequence", "CTXRayDetailsSequence", `SQ, `One, false);
0x0018_9326l, ("CT Position Sequence", "CTPositionSequence", `SQ, `One, false);
0x0018_9327l, ("Table Position", "TablePosition", `FD, `One, false);
0x0018_9328l, ("Exposure Time in ms", "ExposureTimeInms", `FD, `One, false);
0x0018_9329l, ("CT Image Frame Type Sequence", "CTImageFrameTypeSequence", `SQ, `One, false);
0x0018_9330l, ("X-Ray Tube Current in mA", "XRayTubeCurrentInmA", `FD, `One, false);
0x0018_9332l, ("Exposure in mAs", "ExposureInmAs", `FD, `One, false);
0x0018_9333l, ("Constant Volume Flag", "ConstantVolumeFlag", `CS, `One, false);
0x0018_9334l, ("Fluoroscopy Flag", "FluoroscopyFlag", `CS, `One, false);
0x0018_9335l, ("Distance Source to Data Collection Center", "DistanceSourceToDataCollectionCenter", `FD, `One, false);
0x0018_9337l, ("Contrast/Bolus Agent Number", "ContrastBolusAgentNumber", `US, `One, false);
0x0018_9338l, ("Contrast/Bolus Ingredient Code Sequence", "ContrastBolusIngredientCodeSequence", `SQ, `One, false);
0x0018_9340l, ("Contrast Administration Profile Sequence", "ContrastAdministrationProfileSequence", `SQ, `One, false);
0x0018_9341l, ("Contrast/Bolus Usage Sequence", "ContrastBolusUsageSequence", `SQ, `One, false);
0x0018_9342l, ("Contrast/Bolus Agent Administered", "ContrastBolusAgentAdministered", `CS, `One, false);
0x0018_9343l, ("Contrast/Bolus Agent Detected", "ContrastBolusAgentDetected", `CS, `One, false);
0x0018_9344l, ("Contrast/Bolus Agent Phase", "ContrastBolusAgentPhase", `CS, `One, false);
0x0018_9345l, ("CTDIvol", "CTDIvol", `FD, `One, false);
0x0018_9346l, ("CTDI Phantom Type Code Sequence", "CTDIPhantomTypeCodeSequence", `SQ, `One, false);
0x0018_9351l, ("Calcium Scoring Mass Factor Patient", "CalciumScoringMassFactorPatient", `FL, `One, false);
0x0018_9352l, ("Calcium Scoring Mass Factor Device", "CalciumScoringMassFactorDevice", `FL, `Three, false);
0x0018_9353l, ("Energy Weighting Factor", "EnergyWeightingFactor", `FL, `One, false);
0x0018_9360l, ("CT Additional X-Ray Source Sequence", "CTAdditionalXRaySourceSequence", `SQ, `One, false);
0x0018_9401l, ("Projection Pixel Calibration Sequence", "ProjectionPixelCalibrationSequence", `SQ, `One, false);
0x0018_9402l, ("Distance Source to Isocenter", "DistanceSourceToIsocenter", `FL, `One, false);
0x0018_9403l, ("Distance Object to Table Top", "DistanceObjectToTableTop", `FL, `One, false);
0x0018_9404l, ("Object Pixel Spacing in Center of Beam", "ObjectPixelSpacingInCenterOfBeam", `FL, `Two, false);
0x0018_9405l, ("Positioner Position Sequence", "PositionerPositionSequence", `SQ, `One, false);
0x0018_9406l, ("Table Position Sequence", "TablePositionSequence", `SQ, `One, false);
0x0018_9407l, ("Collimator Shape Sequence", "CollimatorShapeSequence", `SQ, `One, false);
0x0018_9410l, ("Planes in Acquisition", "PlanesInAcquisition", `CS, `One, false);
0x0018_9412l, ("XA/XRF Frame Characteristics Sequence", "XAXRFFrameCharacteristicsSequence", `SQ, `One, false);
0x0018_9417l, ("Frame Acquisition Sequence", "FrameAcquisitionSequence", `SQ, `One, false);
0x0018_9420l, ("X-Ray Receptor Type", "XRayReceptorType", `CS, `One, false);
0x0018_9423l, ("Acquisition Protocol Name", "AcquisitionProtocolName", `LO, `One, false);
0x0018_9424l, ("Acquisition Protocol Description", "AcquisitionProtocolDescription", `LT, `One, false);
0x0018_9425l, ("Contrast/Bolus Ingredient Opaque", "ContrastBolusIngredientOpaque", `CS, `One, false);
0x0018_9426l, ("Distance Receptor Plane to Detector Housing", "DistanceReceptorPlaneToDetectorHousing", `FL, `One, false);
0x0018_9427l, ("Intensifier Active Shape", "IntensifierActiveShape", `CS, `One, false);
0x0018_9428l, ("Intensifier Active Dimension(s)", "IntensifierActiveDimensions", `FL, `One_2, false);
0x0018_9429l, ("Physical Detector Size", "PhysicalDetectorSize", `FL, `Two, false);
0x0018_9430l, ("Position of Isocenter Projection", "PositionOfIsocenterProjection", `FL, `Two, false);
0x0018_9432l, ("Field of View Sequence", "FieldOfViewSequence", `SQ, `One, false);
0x0018_9433l, ("Field of View Description", "FieldOfViewDescription", `LO, `One, false);
0x0018_9434l, ("Exposure Control Sensing Regions Sequence", "ExposureControlSensingRegionsSequence", `SQ, `One, false);
0x0018_9435l, ("Exposure Control Sensing Region Shape", "ExposureControlSensingRegionShape", `CS, `One, false);
0x0018_9436l, ("Exposure Control Sensing Region Left Vertical Edge", "ExposureControlSensingRegionLeftVerticalEdge", `SS, `One, false);
0x0018_9437l, ("Exposure Control Sensing Region Right Vertical Edge", "ExposureControlSensingRegionRightVerticalEdge", `SS, `One, false);
0x0018_9438l, ("Exposure Control Sensing Region Upper Horizontal Edge", "ExposureControlSensingRegionUpperHorizontalEdge", `SS, `One, false);
0x0018_9439l, ("Exposure Control Sensing Region Lower Horizontal Edge", "ExposureControlSensingRegionLowerHorizontalEdge", `SS, `One, false);
0x0018_9440l, ("Center of Circular Exposure Control Sensing Region", "CenterOfCircularExposureControlSensingRegion", `SS, `Two, false);
0x0018_9441l, ("Radius of Circular Exposure Control Sensing Region", "RadiusOfCircularExposureControlSensingRegion", `US, `One, false);
0x0018_9442l, ("Vertices of the Polygonal Exposure Control Sensing Region", "VerticesOfThePolygonalExposureControlSensingRegion", `SS, `Two_n, false);
0x0018_9445l, ("Tag (0018,9445)", "T_0018_9445", `UN, `One, true);
0x0018_9447l, ("Column Angulation (Patient)", "ColumnAngulationPatient", `FL, `One, false);
0x0018_9449l, ("Beam Angle", "BeamAngle", `FL, `One, false);
0x0018_9451l, ("Frame Detector Parameters Sequence", "FrameDetectorParametersSequence", `SQ, `One, false);
0x0018_9452l, ("Calculated Anatomy Thickness", "CalculatedAnatomyThickness", `FL, `One, false);
0x0018_9455l, ("Calibration Sequence", "CalibrationSequence", `SQ, `One, false);
0x0018_9456l, ("Object Thickness Sequence", "ObjectThicknessSequence", `SQ, `One, false);
0x0018_9457l, ("Plane Identification", "PlaneIdentification", `CS, `One, false);
0x0018_9461l, ("Field of View Dimension(s) in Float", "FieldOfViewDimensionsInFloat", `FL, `One_2, false);
0x0018_9462l, ("Isocenter Reference System Sequence", "IsocenterReferenceSystemSequence", `SQ, `One, false);
0x0018_9463l, ("Positioner Isocenter Primary Angle", "PositionerIsocenterPrimaryAngle", `FL, `One, false);
0x0018_9464l, ("Positioner Isocenter Secondary Angle", "PositionerIsocenterSecondaryAngle", `FL, `One, false);
0x0018_9465l, ("Positioner Isocenter Detector Rotation Angle", "PositionerIsocenterDetectorRotationAngle", `FL, `One, false);
0x0018_9466l, ("Table X Position to Isocenter", "TableXPositionToIsocenter", `FL, `One, false);
0x0018_9467l, ("Table Y Position to Isocenter", "TableYPositionToIsocenter", `FL, `One, false);
0x0018_9468l, ("Table Z Position to Isocenter", "TableZPositionToIsocenter", `FL, `One, false);
0x0018_9469l, ("Table Horizontal Rotation Angle", "TableHorizontalRotationAngle", `FL, `One, false);
0x0018_9470l, ("Table Head Tilt Angle", "TableHeadTiltAngle", `FL, `One, false);
0x0018_9471l, ("Table Cradle Tilt Angle", "TableCradleTiltAngle", `FL, `One, false);
0x0018_9472l, ("Frame Display Shutter Sequence", "FrameDisplayShutterSequence", `SQ, `One, false);
0x0018_9473l, ("Acquired Image Area Dose Product", "AcquiredImageAreaDoseProduct", `FL, `One, false);
0x0018_9474l, ("C-arm Positioner Tabletop Relationship", "CArmPositionerTabletopRelationship", `CS, `One, false);
0x0018_9476l, ("X-Ray Geometry Sequence", "XRayGeometrySequence", `SQ, `One, false);
0x0018_9477l, ("Irradiation Event Identification Sequence", "IrradiationEventIdentificationSequence", `SQ, `One, false);
0x0018_9504l, ("X-Ray 3D Frame Type Sequence", "XRay3DFrameTypeSequence", `SQ, `One, false);
0x0018_9506l, ("Contributing Sources Sequence", "ContributingSourcesSequence", `SQ, `One, false);
0x0018_9507l, ("X-Ray 3D Acquisition Sequence", "XRay3DAcquisitionSequence", `SQ, `One, false);
0x0018_9508l, ("Primary Positioner Scan Arc", "PrimaryPositionerScanArc", `FL, `One, false);
0x0018_9509l, ("Secondary Positioner Scan Arc", "SecondaryPositionerScanArc", `FL, `One, false);
0x0018_9510l, ("Primary Positioner Scan Start Angle", "PrimaryPositionerScanStartAngle", `FL, `One, false);
0x0018_9511l, ("Secondary Positioner Scan Start Angle", "SecondaryPositionerScanStartAngle", `FL, `One, false);
0x0018_9514l, ("Primary Positioner Increment", "PrimaryPositionerIncrement", `FL, `One, false);
0x0018_9515l, ("Secondary Positioner Increment", "SecondaryPositionerIncrement", `FL, `One, false);
0x0018_9516l, ("Start Acquisition DateTime", "StartAcquisitionDateTime", `DT, `One, false);
0x0018_9517l, ("End Acquisition DateTime", "EndAcquisitionDateTime", `DT, `One, false);
0x0018_9524l, ("Application Name", "ApplicationName", `LO, `One, false);
0x0018_9525l, ("Application Version", "ApplicationVersion", `LO, `One, false);
0x0018_9526l, ("Application Manufacturer", "ApplicationManufacturer", `LO, `One, false);
0x0018_9527l, ("Algorithm Type", "AlgorithmType", `CS, `One, false);
0x0018_9528l, ("Algorithm Description", "AlgorithmDescription", `LO, `One, false);
0x0018_9530l, ("X-Ray 3D Reconstruction Sequence", "XRay3DReconstructionSequence", `SQ, `One, false);
0x0018_9531l, ("Reconstruction Description", "ReconstructionDescription", `LO, `One, false);
0x0018_9538l, ("Per Projection Acquisition Sequence", "PerProjectionAcquisitionSequence", `SQ, `One, false);
0x0018_9601l, ("Diffusion b-matrix Sequence", "DiffusionBMatrixSequence", `SQ, `One, false);
0x0018_9602l, ("Diffusion b-value XX", "DiffusionBValueXX", `FD, `One, false);
0x0018_9603l, ("Diffusion b-value XY", "DiffusionBValueXY", `FD, `One, false);
0x0018_9604l, ("Diffusion b-value XZ", "DiffusionBValueXZ", `FD, `One, false);
0x0018_9605l, ("Diffusion b-value YY", "DiffusionBValueYY", `FD, `One, false);
0x0018_9606l, ("Diffusion b-value YZ", "DiffusionBValueYZ", `FD, `One, false);
0x0018_9607l, ("Diffusion b-value ZZ", "DiffusionBValueZZ", `FD, `One, false);
0x0018_9701l, ("Decay Correction DateTime", "DecayCorrectionDateTime", `DT, `One, false);
0x0018_9715l, ("Start Density Threshold", "StartDensityThreshold", `FD, `One, false);
0x0018_9716l, ("Start Relative Density Difference Threshold", "StartRelativeDensityDifferenceThreshold", `FD, `One, false);
0x0018_9717l, ("Start Cardiac Trigger Count Threshold", "StartCardiacTriggerCountThreshold", `FD, `One, false);
0x0018_9718l, ("Start Respiratory Trigger Count Threshold", "StartRespiratoryTriggerCountThreshold", `FD, `One, false);
0x0018_9719l, ("Termination Counts Threshold", "TerminationCountsThreshold", `FD, `One, false);
0x0018_9720l, ("Termination Density Threshold", "TerminationDensityThreshold", `FD, `One, false);
0x0018_9721l, ("Termination Relative Density Threshold", "TerminationRelativeDensityThreshold", `FD, `One, false);
0x0018_9722l, ("Termination Time Threshold", "TerminationTimeThreshold", `FD, `One, false);
0x0018_9723l, ("Termination Cardiac Trigger Count Threshold", "TerminationCardiacTriggerCountThreshold", `FD, `One, false);
0x0018_9724l, ("Termination Respiratory Trigger Count Threshold", "TerminationRespiratoryTriggerCountThreshold", `FD, `One, false);
0x0018_9725l, ("Detector Geometry", "DetectorGeometry", `CS, `One, false);
0x0018_9726l, ("Transverse Detector Separation", "TransverseDetectorSeparation", `FD, `One, false);
0x0018_9727l, ("Axial Detector Dimension", "AxialDetectorDimension", `FD, `One, false);
0x0018_9729l, ("Radiopharmaceutical Agent Number", "RadiopharmaceuticalAgentNumber", `US, `One, false);
0x0018_9732l, ("PET Frame Acquisition Sequence", "PETFrameAcquisitionSequence", `SQ, `One, false);
0x0018_9733l, ("PET Detector Motion Details Sequence", "PETDetectorMotionDetailsSequence", `SQ, `One, false);
0x0018_9734l, ("PET Table Dynamics Sequence", "PETTableDynamicsSequence", `SQ, `One, false);
0x0018_9735l, ("PET Position Sequence", "PETPositionSequence", `SQ, `One, false);
0x0018_9736l, ("PET Frame Correction Factors Sequence", "PETFrameCorrectionFactorsSequence", `SQ, `One, false);
0x0018_9737l, ("Radiopharmaceutical Usage Sequence", "RadiopharmaceuticalUsageSequence", `SQ, `One, false);
0x0018_9738l, ("Attenuation Correction Source", "AttenuationCorrectionSource", `CS, `One, false);
0x0018_9739l, ("Number of Iterations", "NumberOfIterations", `US, `One, false);
0x0018_9740l, ("Number of Subsets", "NumberOfSubsets", `US, `One, false);
0x0018_9749l, ("PET Reconstruction Sequence", "PETReconstructionSequence", `SQ, `One, false);
0x0018_9751l, ("PET Frame Type Sequence", "PETFrameTypeSequence", `SQ, `One, false);
0x0018_9755l, ("Time of Flight Information Used", "TimeOfFlightInformationUsed", `CS, `One, false);
0x0018_9756l, ("Reconstruction Type", "ReconstructionType", `CS, `One, false);
0x0018_9758l, ("Decay Corrected", "DecayCorrected", `CS, `One, false);
0x0018_9759l, ("Attenuation Corrected", "AttenuationCorrected", `CS, `One, false);
0x0018_9760l, ("Scatter Corrected", "ScatterCorrected", `CS, `One, false);
0x0018_9761l, ("Dead Time Corrected", "DeadTimeCorrected", `CS, `One, false);
0x0018_9762l, ("Gantry Motion Corrected", "GantryMotionCorrected", `CS, `One, false);
0x0018_9763l, ("Patient Motion Corrected", "PatientMotionCorrected", `CS, `One, false);
0x0018_9764l, ("Count Loss Normalization Corrected", "CountLossNormalizationCorrected", `CS, `One, false);
0x0018_9765l, ("Randoms Corrected", "RandomsCorrected", `CS, `One, false);
0x0018_9766l, ("Non-uniform Radial Sampling Corrected", "NonUniformRadialSamplingCorrected", `CS, `One, false);
0x0018_9767l, ("Sensitivity Calibrated", "SensitivityCalibrated", `CS, `One, false);
0x0018_9768l, ("Detector Normalization Correction", "DetectorNormalizationCorrection", `CS, `One, false);
0x0018_9769l, ("Iterative Reconstruction Method", "IterativeReconstructionMethod", `CS, `One, false);
0x0018_9770l, ("Attenuation Correction Temporal Relationship", "AttenuationCorrectionTemporalRelationship", `CS, `One, false);
0x0018_9771l, ("Patient Physiological State Sequence", "PatientPhysiologicalStateSequence", `SQ, `One, false);
0x0018_9772l, ("Patient Physiological State Code Sequence", "PatientPhysiologicalStateCodeSequence", `SQ, `One, false);
0x0018_9801l, ("Depth(s) of Focus", "DepthsOfFocus", `FD, `One_n, false);
0x0018_9803l, ("Excluded Intervals Sequence", "ExcludedIntervalsSequence", `SQ, `One, false);
0x0018_9804l, ("Exclusion Start Datetime", "ExclusionStartDatetime", `DT, `One, false);
0x0018_9805l, ("Exclusion Duration", "ExclusionDuration", `FD, `One, false);
0x0018_9806l, ("US Image Description Sequence", "USImageDescriptionSequence", `SQ, `One, false);
0x0018_9807l, ("Image Data Type Sequence", "ImageDataTypeSequence", `SQ, `One, false);
0x0018_9808l, ("Data Type", "DataType", `CS, `One, false);
0x0018_9809l, ("Transducer Scan Pattern Code Sequence", "TransducerScanPatternCodeSequence", `SQ, `One, false);
0x0018_980Bl, ("Aliased Data Type", "AliasedDataType", `CS, `One, false);
0x0018_980Cl, ("Position Measuring Device Used", "PositionMeasuringDeviceUsed", `CS, `One, false);
0x0018_980Dl, ("Transducer Geometry Code Sequence", "TransducerGeometryCodeSequence", `SQ, `One, false);
0x0018_980El, ("Transducer Beam Steering Code Sequence", "TransducerBeamSteeringCodeSequence", `SQ, `One, false);
0x0018_980Fl, ("Transducer Application Code Sequence", "TransducerApplicationCodeSequence", `SQ, `One, false);
0x0018_A001l, ("Contributing Equipment Sequence", "ContributingEquipmentSequence", `SQ, `One, false);
0x0018_A002l, ("Contribution Date Time", "ContributionDateTime", `DT, `One, false);
0x0018_A003l, ("Contribution Description", "ContributionDescription", `ST, `One, false);
0x0020_000Dl, ("Study Instance UID", "StudyInstanceUID", `UI, `One, false);
0x0020_000El, ("Series Instance UID", "SeriesInstanceUID", `UI, `One, false);
0x0020_0010l, ("Study ID", "StudyID", `SH, `One, false);
0x0020_0011l, ("Series Number", "SeriesNumber", `IS, `One, false);
0x0020_0012l, ("Acquisition Number", "AcquisitionNumber", `IS, `One, false);
0x0020_0013l, ("Instance Number", "InstanceNumber", `IS, `One, false);
0x0020_0014l, ("Isotope Number", "IsotopeNumber", `IS, `One, true);
0x0020_0015l, ("Phase Number", "PhaseNumber", `IS, `One, true);
0x0020_0016l, ("Interval Number", "IntervalNumber", `IS, `One, true);
0x0020_0017l, ("Time Slot Number", "TimeSlotNumber", `IS, `One, true);
0x0020_0018l, ("Angle Number", "AngleNumber", `IS, `One, true);
0x0020_0019l, ("Item Number", "ItemNumber", `IS, `One, false);
0x0020_0020l, ("Patient Orientation", "PatientOrientation", `CS, `Two, false);
0x0020_0022l, ("Overlay Number", "OverlayNumber", `IS, `One, true);
0x0020_0024l, ("Curve Number", "CurveNumber", `IS, `One, true);
0x0020_0026l, ("LUT Number", "LUTNumber", `IS, `One, true);
0x0020_0030l, ("Image Position", "ImagePosition", `DS, `Three, true);
0x0020_0032l, ("Image Position (Patient)", "ImagePositionPatient", `DS, `Three, false);
0x0020_0035l, ("Image Orientation", "ImageOrientation", `DS, `Six, true);
0x0020_0037l, ("Image Orientation (Patient)", "ImageOrientationPatient", `DS, `Six, false);
0x0020_0050l, ("Location", "Location", `DS, `One, true);
0x0020_0052l, ("Frame of Reference UID", "FrameOfReferenceUID", `UI, `One, false);
0x0020_0060l, ("Laterality", "Laterality", `CS, `One, false);
0x0020_0062l, ("Image Laterality", "ImageLaterality", `CS, `One, false);
0x0020_0070l, ("Image Geometry Type", "ImageGeometryType", `LO, `One, true);
0x0020_0080l, ("Masking Image", "MaskingImage", `CS, `One_n, true);
0x0020_00AAl, ("Report Number", "ReportNumber", `IS, `One, true);
0x0020_0100l, ("Temporal Position Identifier", "TemporalPositionIdentifier", `IS, `One, false);
0x0020_0105l, ("Number of Temporal Positions", "NumberOfTemporalPositions", `IS, `One, false);
0x0020_0110l, ("Temporal Resolution", "TemporalResolution", `DS, `One, false);
0x0020_0200l, ("Synchronization Frame of Reference UID", "SynchronizationFrameOfReferenceUID", `UI, `One, false);
0x0020_0242l, ("SOP Instance UID of Concatenation Source", "SOPInstanceUIDOfConcatenationSource", `UI, `One, false);
0x0020_1000l, ("Series in Study", "SeriesInStudy", `IS, `One, true);
0x0020_1001l, ("Acquisitions in Series", "AcquisitionsInSeries", `IS, `One, true);
0x0020_1002l, ("Images in Acquisition", "ImagesInAcquisition", `IS, `One, false);
0x0020_1003l, ("Images in Series", "ImagesInSeries", `IS, `One, true);
0x0020_1004l, ("Acquisitions in Study", "AcquisitionsInStudy", `IS, `One, true);
0x0020_1005l, ("Images in Study", "ImagesInStudy", `IS, `One, true);
0x0020_1020l, ("Reference", "Reference", `LO, `One_n, true);
0x0020_1040l, ("Position Reference Indicator", "PositionReferenceIndicator", `LO, `One, false);
0x0020_1041l, ("Slice Location", "SliceLocation", `DS, `One, false);
0x0020_1070l, ("Other Study Numbers", "OtherStudyNumbers", `IS, `One_n, true);
0x0020_1200l, ("Number of Patient Related Studies", "NumberOfPatientRelatedStudies", `IS, `One, false);
0x0020_1202l, ("Number of Patient Related Series", "NumberOfPatientRelatedSeries", `IS, `One, false);
0x0020_1204l, ("Number of Patient Related Instances", "NumberOfPatientRelatedInstances", `IS, `One, false);
0x0020_1206l, ("Number of Study Related Series", "NumberOfStudyRelatedSeries", `IS, `One, false);
0x0020_1208l, ("Number of Study Related Instances", "NumberOfStudyRelatedInstances", `IS, `One, false);
0x0020_1209l, ("Number of Series Related Instances", "NumberOfSeriesRelatedInstances", `IS, `One, false);
0x0020_3100l, ("Source Image IDs", "SourceImageIDs", `CS, `One_n, true);
0x0020_3401l, ("Modifying Device ID", "ModifyingDeviceID", `CS, `One, true);
0x0020_3402l, ("Modified Image ID", "ModifiedImageID", `CS, `One, true);
0x0020_3403l, ("Modified Image Date", "ModifiedImageDate", `DA, `One, true);
0x0020_3404l, ("Modifying Device Manufacturer", "ModifyingDeviceManufacturer", `LO, `One, true);
0x0020_3405l, ("Modified Image Time", "ModifiedImageTime", `TM, `One, true);
0x0020_3406l, ("Modified Image Description", "ModifiedImageDescription", `LO, `One, true);
0x0020_4000l, ("Image Comments", "ImageComments", `LT, `One, false);
0x0020_5000l, ("Original Image Identification", "OriginalImageIdentification", `AT, `One_n, true);
0x0020_5002l, ("Original Image Identification Nomenclature", "OriginalImageIdentificationNomenclature", `LO, `One_n, true);
0x0020_9056l, ("Stack ID", "StackID", `SH, `One, false);
0x0020_9057l, ("In-Stack Position Number", "InStackPositionNumber", `UL, `One, false);
0x0020_9071l, ("Frame Anatomy Sequence", "FrameAnatomySequence", `SQ, `One, false);
0x0020_9072l, ("Frame Laterality", "FrameLaterality", `CS, `One, false);
0x0020_9111l, ("Frame Content Sequence", "FrameContentSequence", `SQ, `One, false);
0x0020_9113l, ("Plane Position Sequence", "PlanePositionSequence", `SQ, `One, false);
0x0020_9116l, ("Plane Orientation Sequence", "PlaneOrientationSequence", `SQ, `One, false);
0x0020_9128l, ("Temporal Position Index", "TemporalPositionIndex", `UL, `One, false);
0x0020_9153l, ("Nominal Cardiac Trigger Delay Time", "NominalCardiacTriggerDelayTime", `FD, `One, false);
0x0020_9154l, ("Nominal Cardiac Trigger Time Prior To R-Peak", "NominalCardiacTriggerTimePriorToRPeak", `FL, `One, false);
0x0020_9155l, ("Actual Cardiac Trigger Time Prior To R-Peak", "ActualCardiacTriggerTimePriorToRPeak", `FL, `One, false);
0x0020_9156l, ("Frame Acquisition Number", "FrameAcquisitionNumber", `US, `One, false);
0x0020_9157l, ("Dimension Index Values", "DimensionIndexValues", `UL, `One_n, false);
0x0020_9158l, ("Frame Comments", "FrameComments", `LT, `One, false);
0x0020_9161l, ("Concatenation UID", "ConcatenationUID", `UI, `One, false);
0x0020_9162l, ("In-concatenation Number", "InConcatenationNumber", `US, `One, false);
0x0020_9163l, ("In-concatenation Total Number", "InConcatenationTotalNumber", `US, `One, false);
0x0020_9164l, ("Dimension Organization UID", "DimensionOrganizationUID", `UI, `One, false);
0x0020_9165l, ("Dimension Index Pointer", "DimensionIndexPointer", `AT, `One, false);
0x0020_9167l, ("Functional Group Pointer", "FunctionalGroupPointer", `AT, `One, false);
0x0020_9213l, ("Dimension Index Private Creator", "DimensionIndexPrivateCreator", `LO, `One, false);
0x0020_9221l, ("Dimension Organization Sequence", "DimensionOrganizationSequence", `SQ, `One, false);
0x0020_9222l, ("Dimension Index Sequence", "DimensionIndexSequence", `SQ, `One, false);
0x0020_9228l, ("Concatenation Frame Offset Number", "ConcatenationFrameOffsetNumber", `UL, `One, false);
0x0020_9238l, ("Functional Group Private Creator", "FunctionalGroupPrivateCreator", `LO, `One, false);
0x0020_9241l, ("Nominal Percentage of Cardiac Phase", "NominalPercentageOfCardiacPhase", `FL, `One, false);
0x0020_9245l, ("Nominal Percentage of Respiratory Phase", "NominalPercentageOfRespiratoryPhase", `FL, `One, false);
0x0020_9246l, ("Starting Respiratory Amplitude", "StartingRespiratoryAmplitude", `FL, `One, false);
0x0020_9247l, ("Starting Respiratory Phase", "StartingRespiratoryPhase", `CS, `One, false);
0x0020_9248l, ("Ending Respiratory Amplitude", "EndingRespiratoryAmplitude", `FL, `One, false);
0x0020_9249l, ("Ending Respiratory Phase", "EndingRespiratoryPhase", `CS, `One, false);
0x0020_9250l, ("Respiratory Trigger Type", "RespiratoryTriggerType", `CS, `One, false);
0x0020_9251l, ("R-R Interval Time Nominal", "RRIntervalTimeNominal", `FD, `One, false);
0x0020_9252l, ("Actual Cardiac Trigger Delay Time", "ActualCardiacTriggerDelayTime", `FD, `One, false);
0x0020_9253l, ("Respiratory Synchronization Sequence", "RespiratorySynchronizationSequence", `SQ, `One, false);
0x0020_9254l, ("Respiratory Interval Time", "RespiratoryIntervalTime", `FD, `One, false);
0x0020_9255l, ("Nominal Respiratory Trigger Delay Time", "NominalRespiratoryTriggerDelayTime", `FD, `One, false);
0x0020_9256l, ("Respiratory Trigger Delay Threshold", "RespiratoryTriggerDelayThreshold", `FD, `One, false);
0x0020_9257l, ("Actual Respiratory Trigger Delay Time", "ActualRespiratoryTriggerDelayTime", `FD, `One, false);
0x0020_9301l, ("Image Position (Volume)", "ImagePositionVolume", `FD, `Three, false);
0x0020_9302l, ("Image Orientation (Volume)", "ImageOrientationVolume", `FD, `Six, false);
0x0020_9307l, ("Ultrasound Acquisition Geometry", "UltrasoundAcquisitionGeometry", `CS, `One, false);
0x0020_9308l, ("Apex Position", "ApexPosition", `FD, `Three, false);
0x0020_9309l, ("Volume to Transducer Mapping Matrix", "VolumeToTransducerMappingMatrix", `FD, `Sixteen, false);
0x0020_930Al, ("Volume to Table Mapping Matrix", "VolumeToTableMappingMatrix", `FD, `Sixteen, false);
0x0020_930Cl, ("Patient Frame of Reference Source", "PatientFrameOfReferenceSource", `CS, `One, false);
0x0020_930Dl, ("Temporal Position Time Offset", "TemporalPositionTimeOffset", `FD, `One, false);
0x0020_930El, ("Plane Position (Volume) Sequence", "PlanePositionVolumeSequence", `SQ, `One, false);
0x0020_930Fl, ("Plane Orientation (Volume) Sequence", "PlaneOrientationVolumeSequence", `SQ, `One, false);
0x0020_9310l, ("Temporal Position Sequence", "TemporalPositionSequence", `SQ, `One, false);
0x0020_9311l, ("Dimension Organization Type", "DimensionOrganizationType", `CS, `One, false);
0x0020_9312l, ("Volume Frame of Reference UID", "VolumeFrameOfReferenceUID", `UI, `One, false);
0x0020_9313l, ("Table Frame of Reference UID", "TableFrameOfReferenceUID", `UI, `One, false);
0x0020_9421l, ("Dimension Description Label", "DimensionDescriptionLabel", `LO, `One, false);
0x0020_9450l, ("Patient Orientation in Frame Sequence", "PatientOrientationInFrameSequence", `SQ, `One, false);
0x0020_9453l, ("Frame Label", "FrameLabel", `LO, `One, false);
0x0020_9518l, ("Acquisition Index", "AcquisitionIndex", `US, `One_n, false);
0x0020_9529l, ("Contributing SOP Instances Reference Sequence", "ContributingSOPInstancesReferenceSequence", `SQ, `One, false);
0x0020_9536l, ("Reconstruction Index", "ReconstructionIndex", `US, `One, false);
0x0022_0001l, ("Light Path Filter Pass-Through Wavelength", "LightPathFilterPassThroughWavelength", `US, `One, false);
0x0022_0002l, ("Light Path Filter Pass Band", "LightPathFilterPassBand", `US, `Two, false);
0x0022_0003l, ("Image Path Filter Pass-Through Wavelength", "ImagePathFilterPassThroughWavelength", `US, `One, false);
0x0022_0004l, ("Image Path Filter Pass Band", "ImagePathFilterPassBand", `US, `Two, false);
0x0022_0005l, ("Patient Eye Movement Commanded", "PatientEyeMovementCommanded", `CS, `One, false);
0x0022_0006l, ("Patient Eye Movement Command Code Sequence", "PatientEyeMovementCommandCodeSequence", `SQ, `One, false);
0x0022_0007l, ("Spherical Lens Power", "SphericalLensPower", `FL, `One, false);
0x0022_0008l, ("Cylinder Lens Power", "CylinderLensPower", `FL, `One, false);
0x0022_0009l, ("Cylinder Axis", "CylinderAxis", `FL, `One, false);
0x0022_000Al, ("Emmetropic Magnification", "EmmetropicMagnification", `FL, `One, false);
0x0022_000Bl, ("Intra Ocular Pressure", "IntraOcularPressure", `FL, `One, false);
0x0022_000Cl, ("Horizontal Field of View", "HorizontalFieldOfView", `FL, `One, false);
0x0022_000Dl, ("Pupil Dilated", "PupilDilated", `CS, `One, false);
0x0022_000El, ("Degree of Dilation", "DegreeOfDilation", `FL, `One, false);
0x0022_0010l, ("Stereo Baseline Angle", "StereoBaselineAngle", `FL, `One, false);
0x0022_0011l, ("Stereo Baseline Displacement", "StereoBaselineDisplacement", `FL, `One, false);
0x0022_0012l, ("Stereo Horizontal Pixel Offset", "StereoHorizontalPixelOffset", `FL, `One, false);
0x0022_0013l, ("Stereo Vertical Pixel Offset", "StereoVerticalPixelOffset", `FL, `One, false);
0x0022_0014l, ("Stereo Rotation", "StereoRotation", `FL, `One, false);
0x0022_0015l, ("Acquisition Device Type Code Sequence", "AcquisitionDeviceTypeCodeSequence", `SQ, `One, false);
0x0022_0016l, ("Illumination Type Code Sequence", "IlluminationTypeCodeSequence", `SQ, `One, false);
0x0022_0017l, ("Light Path Filter Type Stack Code Sequence", "LightPathFilterTypeStackCodeSequence", `SQ, `One, false);
0x0022_0018l, ("Image Path Filter Type Stack Code Sequence", "ImagePathFilterTypeStackCodeSequence", `SQ, `One, false);
0x0022_0019l, ("Lenses Code Sequence", "LensesCodeSequence", `SQ, `One, false);
0x0022_001Al, ("Channel Description Code Sequence", "ChannelDescriptionCodeSequence", `SQ, `One, false);
0x0022_001Bl, ("Refractive State Sequence", "RefractiveStateSequence", `SQ, `One, false);
0x0022_001Cl, ("Mydriatic Agent Code Sequence", "MydriaticAgentCodeSequence", `SQ, `One, false);
0x0022_001Dl, ("Relative Image Position Code Sequence", "RelativeImagePositionCodeSequence", `SQ, `One, false);
0x0022_001El, ("Camera Angle of View", "CameraAngleOfView", `FL, `One, false);
0x0022_0020l, ("Stereo Pairs Sequence", "StereoPairsSequence", `SQ, `One, false);
0x0022_0021l, ("Left Image Sequence", "LeftImageSequence", `SQ, `One, false);
0x0022_0022l, ("Right Image Sequence", "RightImageSequence", `SQ, `One, false);
0x0022_0030l, ("Axial Length of the Eye", "AxialLengthOfTheEye", `FL, `One, false);
0x0022_0031l, ("Ophthalmic Frame Location Sequence", "OphthalmicFrameLocationSequence", `SQ, `One, false);
0x0022_0032l, ("Reference Coordinates", "ReferenceCoordinates", `FL, `Two_2n, false);
0x0022_0035l, ("Depth Spatial Resolution", "DepthSpatialResolution", `FL, `One, false);
0x0022_0036l, ("Maximum Depth Distortion", "MaximumDepthDistortion", `FL, `One, false);
0x0022_0037l, ("Along-scan Spatial Resolution", "AlongScanSpatialResolution", `FL, `One, false);
0x0022_0038l, ("Maximum Along-scan Distortion", "MaximumAlongScanDistortion", `FL, `One, false);
0x0022_0039l, ("Ophthalmic Image Orientation", "OphthalmicImageOrientation", `CS, `One, false);
0x0022_0041l, ("Depth of Transverse Image", "DepthOfTransverseImage", `FL, `One, false);
0x0022_0042l, ("Mydriatic Agent Concentration Units Sequence", "MydriaticAgentConcentrationUnitsSequence", `SQ, `One, false);
0x0022_0048l, ("Across-scan Spatial Resolution", "AcrossScanSpatialResolution", `FL, `One, false);
0x0022_0049l, ("Maximum Across-scan Distortion", "MaximumAcrossScanDistortion", `FL, `One, false);
0x0022_004El, ("Mydriatic Agent Concentration", "MydriaticAgentConcentration", `DS, `One, false);
0x0022_0055l, ("Illumination Wave Length", "IlluminationWaveLength", `FL, `One, false);
0x0022_0056l, ("Illumination Power", "IlluminationPower", `FL, `One, false);
0x0022_0057l, ("Illumination Bandwidth", "IlluminationBandwidth", `FL, `One, false);
0x0022_0058l, ("Mydriatic Agent Sequence", "MydriaticAgentSequence", `SQ, `One, false);
0x0022_1007l, ("Ophthalmic Axial Measurements Right Eye Sequence", "OphthalmicAxialMeasurementsRightEyeSequence", `SQ, `One, false);
0x0022_1008l, ("Ophthalmic Axial Measurements Left Eye Sequence", "OphthalmicAxialMeasurementsLeftEyeSequence", `SQ, `One, false);
0x0022_1010l, ("Ophthalmic Axial Length Measurements Type", "OphthalmicAxialLengthMeasurementsType", `CS, `One, false);
0x0022_1019l, ("Ophthalmic Axial Length", "OphthalmicAxialLength", `FL, `One, false);
0x0022_1024l, ("Lens Status Code Sequence", "LensStatusCodeSequence", `SQ, `One, false);
0x0022_1025l, ("Vitreous Status Code Sequence", "VitreousStatusCodeSequence", `SQ, `One, false);
0x0022_1028l, ("IOL Formula Code Sequence", "IOLFormulaCodeSequence", `SQ, `One, false);
0x0022_1029l, ("IOL Formula Detail", "IOLFormulaDetail", `LO, `One, false);
0x0022_1033l, ("Keratometer Index", "KeratometerIndex", `FL, `One, false);
0x0022_1035l, ("Source of Ophthalmic Axial Length Code Sequence", "SourceOfOphthalmicAxialLengthCodeSequence", `SQ, `One, false);
0x0022_1037l, ("Target Refraction", "TargetRefraction", `FL, `One, false);
0x0022_1039l, ("Refractive Procedure Occurred", "RefractiveProcedureOccurred", `CS, `One, false);
0x0022_1040l, ("Refractive Surgery Type Code Sequence", "RefractiveSurgeryTypeCodeSequence", `SQ, `One, false);
0x0022_1044l, ("Ophthalmic Ultrasound Axial Measurements Type Code Sequence", "OphthalmicUltrasoundAxialMeasurementsTypeCodeSequence", `SQ, `One, false);
0x0022_1050l, ("Ophthalmic Axial Length Measurements Sequence", "OphthalmicAxialLengthMeasurementsSequence", `SQ, `One, false);
0x0022_1053l, ("IOL Power", "IOLPower", `FL, `One, false);
0x0022_1054l, ("Predicted Refractive Error", "PredictedRefractiveError", `FL, `One, false);
0x0022_1059l, ("Ophthalmic Axial Length Velocity", "OphthalmicAxialLengthVelocity", `FL, `One, false);
0x0022_1065l, ("Lens Status Description", "LensStatusDescription", `LO, `One, false);
0x0022_1066l, ("Vitreous Status Description", "VitreousStatusDescription", `LO, `One, false);
0x0022_1090l, ("IOL Power Sequence", "IOLPowerSequence", `SQ, `One, false);
0x0022_1092l, ("Lens Constant Sequence", "LensConstantSequence", `SQ, `One, false);
0x0022_1093l, ("IOL Manufacturer", "IOLManufacturer", `LO, `One, false);
0x0022_1094l, ("Lens Constant Description", "LensConstantDescription", `LO, `One, false);
0x0022_1096l, ("Keratometry Measurement Type Code Sequence", "KeratometryMeasurementTypeCodeSequence", `SQ, `One, false);
0x0022_1100l, ("Referenced Ophthalmic Axial Measurements Sequence", "ReferencedOphthalmicAxialMeasurementsSequence", `SQ, `One, false);
0x0022_1101l, ("Ophthalmic Axial Length Measurements Segment Name Code Sequence", "OphthalmicAxialLengthMeasurementsSegmentNameCodeSequence", `SQ, `One, false);
0x0022_1103l, ("Refractive Error Before Refractive Surgery Code Sequence", "RefractiveErrorBeforeRefractiveSurgeryCodeSequence", `SQ, `One, false);
0x0022_1121l, ("IOL Power For Exact Emmetropia", "IOLPowerForExactEmmetropia", `FL, `One, false);
0x0022_1122l, ("IOL Power For Exact Target Refraction", "IOLPowerForExactTargetRefraction", `FL, `One, false);
0x0022_1125l, ("Anterior Chamber Depth Definition Code Sequence", "AnteriorChamberDepthDefinitionCodeSequence", `SQ, `One, false);
0x0022_1130l, ("Lens Thickness", "LensThickness", `FL, `One, false);
0x0022_1131l, ("Anterior Chamber Depth", "AnteriorChamberDepth", `FL, `One, false);
0x0022_1132l, ("Source of Lens Thickness Data Code Sequence", "SourceOfLensThicknessDataCodeSequence", `SQ, `One, false);
0x0022_1133l, ("Source of Anterior Chamber Depth Data Code Sequence", "SourceOfAnteriorChamberDepthDataCodeSequence", `SQ, `One, false);
0x0022_1135l, ("Source of Refractive Error Data Code Sequence", "SourceOfRefractiveErrorDataCodeSequence", `SQ, `One, false);
0x0022_1140l, ("Ophthalmic Axial Length Measurement Modified", "OphthalmicAxialLengthMeasurementModified", `CS, `One, false);
0x0022_1150l, ("Ophthalmic Axial Length Data Source Code Sequence", "OphthalmicAxialLengthDataSourceCodeSequence", `SQ, `One, false);
0x0022_1153l, ("Ophthalmic Axial Length Acquisition Method Code Sequence", "OphthalmicAxialLengthAcquisitionMethodCodeSequence", `SQ, `One, false);
0x0022_1155l, ("Signal to Noise Ratio", "SignalToNoiseRatio", `FL, `One, false);
0x0022_1159l, ("Ophthalmic Axial Length Data Source Description", "OphthalmicAxialLengthDataSourceDescription", `LO, `One, false);
0x0022_1210l, ("Ophthalmic Axial Length Measurements Total Length Sequence", "OphthalmicAxialLengthMeasurementsTotalLengthSequence", `SQ, `One, false);
0x0022_1211l, ("Ophthalmic Axial Length Measurements Segmental Length Sequence", "OphthalmicAxialLengthMeasurementsSegmentalLengthSequence", `SQ, `One, false);
0x0022_1212l, ("Ophthalmic Axial Length Measurements Length Summation Sequence", "OphthalmicAxialLengthMeasurementsLengthSummationSequence", `SQ, `One, false);
0x0022_1220l, ("Ultrasound Ophthalmic Axial Length Measurements Sequence", "UltrasoundOphthalmicAxialLengthMeasurementsSequence", `SQ, `One, false);
0x0022_1225l, ("Optical Ophthalmic Axial Length Measurements Sequence", "OpticalOphthalmicAxialLengthMeasurementsSequence", `SQ, `One, false);
0x0022_1230l, ("Ultrasound Selected Ophthalmic Axial Length Sequence", "UltrasoundSelectedOphthalmicAxialLengthSequence", `SQ, `One, false);
0x0022_1250l, ("Ophthalmic Axial Length Selection Method Code Sequence", "OphthalmicAxialLengthSelectionMethodCodeSequence", `SQ, `One, false);
0x0022_1255l, ("Optical Selected Ophthalmic Axial Length Sequence", "OpticalSelectedOphthalmicAxialLengthSequence", `SQ, `One, false);
0x0022_1257l, ("Selected Segmental Ophthalmic Axial Length Sequence", "SelectedSegmentalOphthalmicAxialLengthSequence", `SQ, `One, false);
0x0022_1260l, ("Selected Total Ophthalmic Axial Length Sequence", "SelectedTotalOphthalmicAxialLengthSequence", `SQ, `One, false);
0x0022_1262l, ("Ophthalmic Axial Length Quality Metric Sequence", "OphthalmicAxialLengthQualityMetricSequence", `SQ, `One, false);
0x0022_1273l, ("Ophthalmic Axial Length Quality Metric Type Description", "OphthalmicAxialLengthQualityMetricTypeDescription", `LO, `One, false);
0x0022_1300l, ("Intraocular Lens Calculations Right Eye Sequence", "IntraocularLensCalculationsRightEyeSequence", `SQ, `One, false);
0x0022_1310l, ("Intraocular Lens Calculations Left Eye Sequence", "IntraocularLensCalculationsLeftEyeSequence", `SQ, `One, false);
0x0022_1330l, ("Referenced Ophthalmic Axial Length Measurement QC Image Sequence", "ReferencedOphthalmicAxialLengthMeasurementQCImageSequence", `SQ, `One, false);
0x0024_0010l, ("Visual Field Horizontal Extent", "VisualFieldHorizontalExtent", `FL, `One, false);
0x0024_0011l, ("Visual Field Vertical Extent", "VisualFieldVerticalExtent", `FL, `One, false);
0x0024_0012l, ("Visual Field Shape", "VisualFieldShape", `CS, `One, false);
0x0024_0016l, ("Screening Test Mode Code Sequence", "ScreeningTestModeCodeSequence", `SQ, `One, false);
0x0024_0018l, ("Maximum Stimulus Luminance", "MaximumStimulusLuminance", `FL, `One, false);
0x0024_0020l, ("Background Luminance", "BackgroundLuminance", `FL, `One, false);
0x0024_0021l, ("Stimulus Color Code Sequence", "StimulusColorCodeSequence", `SQ, `One, false);
0x0024_0024l, ("Background Illumination Color Code Sequence", "BackgroundIlluminationColorCodeSequence", `SQ, `One, false);
0x0024_0025l, ("Stimulus Area", "StimulusArea", `FL, `One, false);
0x0024_0028l, ("Stimulus Presentation Time", "StimulusPresentationTime", `FL, `One, false);
0x0024_0032l, ("Fixation Sequence", "FixationSequence", `SQ, `One, false);
0x0024_0033l, ("Fixation Monitoring Code Sequence", "FixationMonitoringCodeSequence", `SQ, `One, false);
0x0024_0034l, ("Visual Field Catch Trial Sequence", "VisualFieldCatchTrialSequence", `SQ, `One, false);
0x0024_0035l, ("Fixation Checked Quantity", "FixationCheckedQuantity", `US, `One, false);
0x0024_0036l, ("Patient Not Properly Fixated Quantity", "PatientNotProperlyFixatedQuantity", `US, `One, false);
0x0024_0037l, ("Presented Visual Stimuli Data Flag", "PresentedVisualStimuliDataFlag", `CS, `One, false);
0x0024_0038l, ("Number of Visual Stimuli", "NumberOfVisualStimuli", `US, `One, false);
0x0024_0039l, ("Excessive Fixation Losses Data Flag", "ExcessiveFixationLossesDataFlag", `CS, `One, false);
0x0024_0040l, ("Excessive Fixation Losses", "ExcessiveFixationLosses", `CS, `One, false);
0x0024_0042l, ("Stimuli Retesting Quantity", "StimuliRetestingQuantity", `US, `One, false);
0x0024_0044l, ("Comments on Patient’s Performance of Visual Field", "CommentsOnPatientPerformanceOfVisualField", `LT, `One, false);
0x0024_0045l, ("False Negatives Estimate Flag", "FalseNegativesEstimateFlag", `CS, `One, false);
0x0024_0046l, ("False Negatives Estimate", "FalseNegativesEstimate", `FL, `One, false);
0x0024_0048l, ("Negative Catch Trials Quantity", "NegativeCatchTrialsQuantity", `US, `One, false);
0x0024_0050l, ("False Negatives Quantity", "FalseNegativesQuantity", `US, `One, false);
0x0024_0051l, ("Excessive False Negatives Data Flag", "ExcessiveFalseNegativesDataFlag", `CS, `One, false);
0x0024_0052l, ("Excessive False Negatives", "ExcessiveFalseNegatives", `CS, `One, false);
0x0024_0053l, ("False Positives Estimate Flag", "FalsePositivesEstimateFlag", `CS, `One, false);
0x0024_0054l, ("False Positives Estimate", "FalsePositivesEstimate", `FL, `One, false);
0x0024_0055l, ("Catch Trials Data Flag", "CatchTrialsDataFlag", `CS, `One, false);
0x0024_0056l, ("Positive Catch Trials Quantity", "PositiveCatchTrialsQuantity", `US, `One, false);
0x0024_0057l, ("Test Point Normals Data Flag", "TestPointNormalsDataFlag", `CS, `One, false);
0x0024_0058l, ("Test Point Normals Sequence", "TestPointNormalsSequence", `SQ, `One, false);
0x0024_0059l, ("Global Deviation Probability Normals Flag", "GlobalDeviationProbabilityNormalsFlag", `CS, `One, false);
0x0024_0060l, ("False Positives Quantity", "FalsePositivesQuantity", `US, `One, false);
0x0024_0061l, ("Excessive False Positives Data Flag", "ExcessiveFalsePositivesDataFlag", `CS, `One, false);
0x0024_0062l, ("Excessive False Positives", "ExcessiveFalsePositives", `CS, `One, false);
0x0024_0063l, ("Visual Field Test Normals Flag", "VisualFieldTestNormalsFlag", `CS, `One, false);
0x0024_0064l, ("Results Normals Sequence", "ResultsNormalsSequence", `SQ, `One, false);
0x0024_0065l, ("Age Corrected Sensitivity Deviation Algorithm Sequence", "AgeCorrectedSensitivityDeviationAlgorithmSequence", `SQ, `One, false);
0x0024_0066l, ("Global Deviation From Normal", "GlobalDeviationFromNormal", `FL, `One, false);
0x0024_0067l, ("Generalized Defect Sensitivity Deviation Algorithm Sequence", "GeneralizedDefectSensitivityDeviationAlgorithmSequence", `SQ, `One, false);
0x0024_0068l, ("Localized Deviation from Normal", "LocalizedDeviationfromNormal", `FL, `One, false);
0x0024_0069l, ("Patient Reliability Indicator", "PatientReliabilityIndicator", `LO, `One, false);
0x0024_0070l, ("Visual Field Mean Sensitivity", "VisualFieldMeanSensitivity", `FL, `One, false);
0x0024_0071l, ("Global Deviation Probability", "GlobalDeviationProbability", `FL, `One, false);
0x0024_0072l, ("Local Deviation Probability Normals Flag", "LocalDeviationProbabilityNormalsFlag", `CS, `One, false);
0x0024_0073l, ("Localized Deviation Probability", "LocalizedDeviationProbability", `FL, `One, false);
0x0024_0074l, ("Short Term Fluctuation Calculated", "ShortTermFluctuationCalculated", `CS, `One, false);
0x0024_0075l, ("Short Term Fluctuation", "ShortTermFluctuation", `FL, `One, false);
0x0024_0076l, ("Short Term Fluctuation Probability Calculated", "ShortTermFluctuationProbabilityCalculated", `CS, `One, false);
0x0024_0077l, ("Short Term Fluctuation Probability", "ShortTermFluctuationProbability", `FL, `One, false);
0x0024_0078l, ("Corrected Localized Deviation From Normal Calculated", "CorrectedLocalizedDeviationFromNormalCalculated", `CS, `One, false);
0x0024_0079l, ("Corrected Localized Deviation From Normal", "CorrectedLocalizedDeviationFromNormal", `FL, `One, false);
0x0024_0080l, ("Corrected Localized Deviation From Normal Probability Calculated", "CorrectedLocalizedDeviationFromNormalProbabilityCalculated", `CS, `One, false);
0x0024_0081l, ("Corrected Localized Deviation From Normal Probability", "CorrectedLocalizedDeviationFromNormalProbability", `FL, `One, false);
0x0024_0083l, ("Global Deviation Probability Sequence", "GlobalDeviationProbabilitySequence", `SQ, `One, false);
0x0024_0085l, ("Localized Deviation Probability Sequence", "LocalizedDeviationProbabilitySequence", `SQ, `One, false);
0x0024_0086l, ("Foveal Sensitivity Measured", "FovealSensitivityMeasured", `CS, `One, false);
0x0024_0087l, ("Foveal Sensitivity", "FovealSensitivity", `FL, `One, false);
0x0024_0088l, ("Visual Field Test Duration", "VisualFieldTestDuration", `FL, `One, false);
0x0024_0089l, ("Visual Field Test Point Sequence", "VisualFieldTestPointSequence", `SQ, `One, false);
0x0024_0090l, ("Visual Field Test Point X-Coordinate", "VisualFieldTestPointXCoordinate", `FL, `One, false);
0x0024_0091l, ("Visual Field Test Point Y-Coordinate", "VisualFieldTestPointYCoordinate", `FL, `One, false);
0x0024_0092l, ("Age Corrected Sensitivity Deviation Value", "AgeCorrectedSensitivityDeviationValue", `FL, `One, false);
0x0024_0093l, ("Stimulus Results", "StimulusResults", `CS, `One, false);
0x0024_0094l, ("Sensitivity Value", "SensitivityValue", `FL, `One, false);
0x0024_0095l, ("Retest Stimulus Seen", "RetestStimulusSeen", `CS, `One, false);
0x0024_0096l, ("Retest Sensitivity Value", "RetestSensitivityValue", `FL, `One, false);
0x0024_0097l, ("Visual Field Test Point Normals Sequence", "VisualFieldTestPointNormalsSequence", `SQ, `One, false);
0x0024_0098l, ("Quantified Defect", "QuantifiedDefect", `FL, `One, false);
0x0024_0100l, ("Age Corrected Sensitivity Deviation Probability Value", "AgeCorrectedSensitivityDeviationProbabilityValue", `FL, `One, false);
0x0024_0102l, ("Generalized Defect Corrected Sensitivity Deviation Flag", "GeneralizedDefectCorrectedSensitivityDeviationFlag", `CS, `One, false);
0x0024_0103l, ("Generalized Defect Corrected Sensitivity Deviation Value", "GeneralizedDefectCorrectedSensitivityDeviationValue", `FL, `One, false);
0x0024_0104l, ("Generalized Defect Corrected Sensitivity Deviation Probability Value", "GeneralizedDefectCorrectedSensitivityDeviationProbabilityValue", `FL, `One, false);
0x0024_0105l, ("Minimum Sensitivity Value", "MinimumSensitivityValue", `FL, `One, false);
0x0024_0106l, ("Blind Spot Localized", "BlindSpotLocalized", `CS, `One, false);
0x0024_0107l, ("Blind Spot X-Coordinate", "BlindSpotXCoordinate", `FL, `One, false);
0x0024_0108l, ("Blind Spot Y-Coordinate", "BlindSpotYCoordinate", `FL, `One, false);
0x0024_0110l, ("Visual Acuity Measurement Sequence", "VisualAcuityMeasurementSequence", `SQ, `One, false);
0x0024_0112l, ("Refractive Parameters Used on Patient Sequence", "RefractiveParametersUsedOnPatientSequence", `SQ, `One, false);
0x0024_0113l, ("Measurement Laterality", "MeasurementLaterality", `CS, `One, false);
0x0024_0114l, ("Ophthalmic Patient Clinical Information Left Eye Sequence", "OphthalmicPatientClinicalInformationLeftEyeSequence", `SQ, `One, false);
0x0024_0115l, ("Ophthalmic Patient Clinical Information Right Eye Sequence", "OphthalmicPatientClinicalInformationRightEyeSequence", `SQ, `One, false);
0x0024_0117l, ("Foveal Point Normative Data Flag", "FovealPointNormativeDataFlag", `CS, `One, false);
0x0024_0118l, ("Foveal Point Probability Value", "FovealPointProbabilityValue", `FL, `One, false);
0x0024_0120l, ("Screening Baseline Measured", "ScreeningBaselineMeasured", `CS, `One, false);
0x0024_0122l, ("Screening Baseline Measured Sequence", "ScreeningBaselineMeasuredSequence", `SQ, `One, false);
0x0024_0124l, ("Screening Baseline Type", "ScreeningBaselineType", `CS, `One, false);
0x0024_0126l, ("Screening Baseline Value", "ScreeningBaselineValue", `FL, `One, false);
0x0024_0202l, ("Algorithm Source", "AlgorithmSource", `LO, `One, false);
0x0024_0306l, ("Data Set Name", "DataSetName", `LO, `One, false);
0x0024_0307l, ("Data Set Version", "DataSetVersion", `LO, `One, false);
0x0024_0308l, ("Data Set Source", "DataSetSource", `LO, `One, false);
0x0024_0309l, ("Data Set Description", "DataSetDescription", `LO, `One, false);
0x0024_0317l, ("Visual Field Test Reliability Global Index Sequence", "VisualFieldTestReliabilityGlobalIndexSequence", `SQ, `One, false);
0x0024_0320l, ("Visual Field Global Results Index Sequence", "VisualFieldGlobalResultsIndexSequence", `SQ, `One, false);
0x0024_0325l, ("Data Observation Sequence", "DataObservationSequence", `SQ, `One, false);
0x0024_0338l, ("Index Normals Flag", "IndexNormalsFlag", `CS, `One, false);
0x0024_0341l, ("Index Probability", "IndexProbability", `FL, `One, false);
0x0024_0344l, ("Index Probability Sequence", "IndexProbabilitySequence", `SQ, `One, false);
0x0028_0002l, ("Samples per Pixel", "SamplesPerPixel", `US, `One, false);
0x0028_0003l, ("Samples per Pixel Used", "SamplesPerPixelUsed", `US, `One, false);
0x0028_0004l, ("Photometric Interpretation", "PhotometricInterpretation", `CS, `One, false);
0x0028_0005l, ("Image Dimensions", "ImageDimensions", `US, `One, true);
0x0028_0006l, ("Planar Configuration", "PlanarConfiguration", `US, `One, false);
0x0028_0008l, ("Number of Frames", "NumberOfFrames", `IS, `One, false);
0x0028_0009l, ("Frame Increment Pointer", "FrameIncrementPointer", `AT, `One_n, false);
0x0028_000Al, ("Frame Dimension Pointer", "FrameDimensionPointer", `AT, `One_n, false);
0x0028_0010l, ("Rows", "Rows", `US, `One, false);
0x0028_0011l, ("Columns", "Columns", `US, `One, false);
0x0028_0012l, ("Planes", "Planes", `US, `One, true);
0x0028_0014l, ("Ultrasound Color Data Present", "UltrasoundColorDataPresent", `US, `One, false);
0x0028_0020l, ("Tag (0028,0020)", "T_0028_0020", `UN, `One, true);
0x0028_0030l, ("Pixel Spacing", "PixelSpacing", `DS, `Two, false);
0x0028_0031l, ("Zoom Factor", "ZoomFactor", `DS, `Two, false);
0x0028_0032l, ("Zoom Center", "ZoomCenter", `DS, `Two, false);
0x0028_0034l, ("Pixel Aspect Ratio", "PixelAspectRatio", `IS, `Two, false);
0x0028_0040l, ("Image Format", "ImageFormat", `CS, `One, true);
0x0028_0050l, ("Manipulated Image", "ManipulatedImage", `LO, `One_n, true);
0x0028_0051l, ("Corrected Image", "CorrectedImage", `CS, `One_n, false);
0x0028_005Fl, ("Compression Recognition Code", "CompressionRecognitionCode", `LO, `One, true);
0x0028_0060l, ("Compression Code", "CompressionCode", `CS, `One, true);
0x0028_0061l, ("Compression Originator", "CompressionOriginator", `SH, `One, true);
0x0028_0062l, ("Compression Label", "CompressionLabel", `LO, `One, true);
0x0028_0063l, ("Compression Description", "CompressionDescription", `SH, `One, true);
0x0028_0065l, ("Compression Sequence", "CompressionSequence", `CS, `One_n, true);
0x0028_0066l, ("Compression Step Pointers", "CompressionStepPointers", `AT, `One_n, true);
0x0028_0068l, ("Repeat Interval", "RepeatInterval", `US, `One, true);
0x0028_0069l, ("Bits Grouped", "BitsGrouped", `US, `One, true);
0x0028_0070l, ("Perimeter Table", "PerimeterTable", `US, `One_n, true);
0x0028_0071l, ("Perimeter Value", "PerimeterValue", `US_or_SS, `One, true);
0x0028_0080l, ("Predictor Rows", "PredictorRows", `US, `One, true);
0x0028_0081l, ("Predictor Columns", "PredictorColumns", `US, `One, true);
0x0028_0082l, ("Predictor Constants", "PredictorConstants", `US, `One_n, true);
0x0028_0090l, ("Blocked Pixels", "BlockedPixels", `CS, `One, true);
0x0028_0091l, ("Block Rows", "BlockRows", `US, `One, true);
0x0028_0092l, ("Block Columns", "BlockColumns", `US, `One, true);
0x0028_0093l, ("Row Overlap", "RowOverlap", `US, `One, true);
0x0028_0094l, ("Column Overlap", "ColumnOverlap", `US, `One, true);
0x0028_0100l, ("Bits Allocated", "BitsAllocated", `US, `One, false);
0x0028_0101l, ("Bits Stored", "BitsStored", `US, `One, false);
0x0028_0102l, ("High Bit", "HighBit", `US, `One, false);
0x0028_0103l, ("Pixel Representation", "PixelRepresentation", `US, `One, false);
0x0028_0104l, ("Smallest Valid Pixel Value", "SmallestValidPixelValue", `US_or_SS, `One, true);
0x0028_0105l, ("Largest Valid Pixel Value", "LargestValidPixelValue", `US_or_SS, `One, true);
0x0028_0106l, ("Smallest Image Pixel Value", "SmallestImagePixelValue", `US_or_SS, `One, false);
0x0028_0107l, ("Largest Image Pixel Value", "LargestImagePixelValue", `US_or_SS, `One, false);
0x0028_0108l, ("Smallest Pixel Value in Series", "SmallestPixelValueInSeries", `US_or_SS, `One, false);
0x0028_0109l, ("Largest Pixel Value in Series", "LargestPixelValueInSeries", `US_or_SS, `One, false);
0x0028_0110l, ("Smallest Image Pixel Value in Plane", "SmallestImagePixelValueInPlane", `US_or_SS, `One, true);
0x0028_0111l, ("Largest Image Pixel Value in Plane", "LargestImagePixelValueInPlane", `US_or_SS, `One, true);
0x0028_0120l, ("Pixel Padding Value", "PixelPaddingValue", `US_or_SS, `One, false);
0x0028_0121l, ("Pixel Padding Range Limit", "PixelPaddingRangeLimit", `US_or_SS, `One, false);
0x0028_0200l, ("Image Location", "ImageLocation", `US, `One, true);
0x0028_0300l, ("Quality Control Image", "QualityControlImage", `CS, `One, false);
0x0028_0301l, ("Burned In Annotation", "BurnedInAnnotation", `CS, `One, false);
0x0028_0302l, ("Recognizable Visual Features", "RecognizableVisualFeatures", `CS, `One, false);
0x0028_0303l, ("Longitudinal Temporal Information Modified", "LongitudinalTemporalInformationModified", `CS, `One, false);
0x0028_0400l, ("Transform Label", "TransformLabel", `LO, `One, true);
0x0028_0401l, ("Transform Version Number", "TransformVersionNumber", `LO, `One, true);
0x0028_0402l, ("Number of Transform Steps", "NumberOfTransformSteps", `US, `One, true);
0x0028_0403l, ("Sequence of Compressed Data", "SequenceOfCompressedData", `LO, `One_n, true);
0x0028_0404l, ("Details of Coefficients", "DetailsOfCoefficients", `AT, `One_n, true);
0x0028_0400l, ("Rows For Nth Order Coefficients", "RowsForNthOrderCoefficients", `US, `One, true);
0x0028_0401l, ("Columns For Nth Order Coefficients", "ColumnsForNthOrderCoefficients", `US, `One, true);
0x0028_0402l, ("Coefficient Coding", "CoefficientCoding", `LO, `One_n, true);
0x0028_0403l, ("Coefficient Coding Pointers", "CoefficientCodingPointers", `AT, `One_n, true);
0x0028_0700l, ("DCT Label", "DCTLabel", `LO, `One, true);
0x0028_0701l, ("Data Block Description", "DataBlockDescription", `CS, `One_n, true);
0x0028_0702l, ("Data Block", "DataBlock", `AT, `One_n, true);
0x0028_0710l, ("Normalization Factor Format", "NormalizationFactorFormat", `US, `One, true);
0x0028_0720l, ("Zonal Map Number Format", "ZonalMapNumberFormat", `US, `One, true);
0x0028_0721l, ("Zonal Map Location", "ZonalMapLocation", `AT, `One_n, true);
0x0028_0722l, ("Zonal Map Format", "ZonalMapFormat", `US, `One, true);
0x0028_0730l, ("Adaptive Map Format", "AdaptiveMapFormat", `US, `One, true);
0x0028_0740l, ("Code Number Format", "CodeNumberFormat", `US, `One, true);
0x0028_0800l, ("Code Label", "CodeLabel", `CS, `One_n, true);
0x0028_0802l, ("Number of Tables", "NumberOfTables", `US, `One, true);
0x0028_0803l, ("Code Table Location", "CodeTableLocation", `AT, `One_n, true);
0x0028_0804l, ("Bits For Code Word", "BitsForCodeWord", `US, `One, true);
0x0028_0808l, ("Image Data Location", "ImageDataLocation", `AT, `One_n, true);
0x0028_0A02l, ("Pixel Spacing Calibration Type", "PixelSpacingCalibrationType", `CS, `One, false);
0x0028_0A04l, ("Pixel Spacing Calibration Description", "PixelSpacingCalibrationDescription", `LO, `One, false);
0x0028_1040l, ("Pixel Intensity Relationship", "PixelIntensityRelationship", `CS, `One, false);
0x0028_1041l, ("Pixel Intensity Relationship Sign", "PixelIntensityRelationshipSign", `SS, `One, false);
0x0028_1050l, ("Window Center", "WindowCenter", `DS, `One_n, false);
0x0028_1051l, ("Window Width", "WindowWidth", `DS, `One_n, false);
0x0028_1052l, ("Rescale Intercept", "RescaleIntercept", `DS, `One, false);
0x0028_1053l, ("Rescale Slope", "RescaleSlope", `DS, `One, false);
0x0028_1054l, ("Rescale Type", "RescaleType", `LO, `One, false);
0x0028_1055l, ("Window Center & Width Explanation", "WindowCenterWidthExplanation", `LO, `One_n, false);
0x0028_1056l, ("VOI LUT Function", "VOILUTFunction", `CS, `One, false);
0x0028_1080l, ("Gray Scale", "GrayScale", `CS, `One, true);
0x0028_1090l, ("Recommended Viewing Mode", "RecommendedViewingMode", `CS, `One, false);
0x0028_1100l, ("Gray Lookup Table Descriptor", "GrayLookupTableDescriptor", `US_or_SS, `Three, true);
0x0028_1101l, ("Red Palette Color Lookup Table Descriptor", "RedPaletteColorLookupTableDescriptor", `US_or_SS, `Three, false);
0x0028_1102l, ("Green Palette Color Lookup Table Descriptor", "GreenPaletteColorLookupTableDescriptor", `US_or_SS, `Three, false);
0x0028_1103l, ("Blue Palette Color Lookup Table Descriptor", "BluePaletteColorLookupTableDescriptor", `US_or_SS, `Three, false);
0x0028_1104l, ("Alpha Palette Color Lookup Table Descriptor", "AlphaPaletteColorLookupTableDescriptor", `US, `Three, false);
0x0028_1111l, ("Large Red Palette Color Lookup Table Descriptor", "LargeRedPaletteColorLookupTableDescriptor", `US_or_SS, `Four, true);
0x0028_1112l, ("Large Green Palette Color Lookup Table Descriptor", "LargeGreenPaletteColorLookupTableDescriptor", `US_or_SS, `Four, true);
0x0028_1113l, ("Large Blue Palette Color Lookup Table Descriptor", "LargeBluePaletteColorLookupTableDescriptor", `US_or_SS, `Four, true);
0x0028_1199l, ("Palette Color Lookup Table UID", "PaletteColorLookupTableUID", `UI, `One, false);
0x0028_1200l, ("Gray Lookup Table Data", "GrayLookupTableData", `US_or_SS_or_OW, `One_n, true);
0x0028_1201l, ("Red Palette Color Lookup Table Data", "RedPaletteColorLookupTableData", `OW, `One, false);
0x0028_1202l, ("Green Palette Color Lookup Table Data", "GreenPaletteColorLookupTableData", `OW, `One, false);
0x0028_1203l, ("Blue Palette Color Lookup Table Data", "BluePaletteColorLookupTableData", `OW, `One, false);
0x0028_1204l, ("Alpha Palette Color Lookup Table Data", "AlphaPaletteColorLookupTableData", `OW, `One, false);
0x0028_1211l, ("Large Red Palette Color Lookup Table Data", "LargeRedPaletteColorLookupTableData", `OW, `One, true);
0x0028_1212l, ("Large Green Palette Color Lookup Table Data", "LargeGreenPaletteColorLookupTableData", `OW, `One, true);
0x0028_1213l, ("Large Blue Palette Color Lookup Table Data", "LargeBluePaletteColorLookupTableData", `OW, `One, true);
0x0028_1214l, ("Large Palette Color Lookup Table UID", "LargePaletteColorLookupTableUID", `UI, `One, true);
0x0028_1221l, ("Segmented Red Palette Color Lookup Table Data", "SegmentedRedPaletteColorLookupTableData", `OW, `One, false);
0x0028_1222l, ("Segmented Green Palette Color Lookup Table Data", "SegmentedGreenPaletteColorLookupTableData", `OW, `One, false);
0x0028_1223l, ("Segmented Blue Palette Color Lookup Table Data", "SegmentedBluePaletteColorLookupTableData", `OW, `One, false);
0x0028_1300l, ("Breast Implant Present", "BreastImplantPresent", `CS, `One, false);
0x0028_1350l, ("Partial View", "PartialView", `CS, `One, false);
0x0028_1351l, ("Partial View Description", "PartialViewDescription", `ST, `One, false);
0x0028_1352l, ("Partial View Code Sequence", "PartialViewCodeSequence", `SQ, `One, false);
0x0028_135Al, ("Spatial Locations Preserved", "SpatialLocationsPreserved", `CS, `One, false);
0x0028_1401l, ("Data Frame Assignment Sequence", "DataFrameAssignmentSequence", `SQ, `One, false);
0x0028_1402l, ("Data Path Assignment", "DataPathAssignment", `CS, `One, false);
0x0028_1403l, ("Bits Mapped to Color Lookup Table", "BitsMappedToColorLookupTable", `US, `One, false);
0x0028_1404l, ("Blending LUT 1 Sequence", "BlendingLUT1Sequence", `SQ, `One, false);
0x0028_1405l, ("Blending LUT 1 Transfer Function", "BlendingLUT1TransferFunction", `CS, `One, false);
0x0028_1406l, ("Blending Weight Constant", "BlendingWeightConstant", `FD, `One, false);
0x0028_1407l, ("Blending Lookup Table Descriptor", "BlendingLookupTableDescriptor", `US, `Three, false);
0x0028_1408l, ("Blending Lookup Table Data", "BlendingLookupTableData", `OW, `One, false);
0x0028_140Bl, ("Enhanced Palette Color Lookup Table Sequence", "EnhancedPaletteColorLookupTableSequence", `SQ, `One, false);
0x0028_140Cl, ("Blending LUT 2 Sequence", "BlendingLUT2Sequence", `SQ, `One, false);
0x0028_140Dl, ("Blending LUT 2 Transfer Function", "BlendingLUT2TransferFunction", `CS, `One, false);
0x0028_140El, ("Data Path ID", "DataPathID", `CS, `One, false);
0x0028_140Fl, ("RGB LUT Transfer Function", "RGBLUTTransferFunction", `CS, `One, false);
0x0028_1410l, ("Alpha LUT Transfer Function", "AlphaLUTTransferFunction", `CS, `One, false);
0x0028_2000l, ("ICC Profile", "ICCProfile", `OB, `One, false);
0x0028_2110l, ("Lossy Image Compression", "LossyImageCompression", `CS, `One, false);
0x0028_2112l, ("Lossy Image Compression Ratio", "LossyImageCompressionRatio", `DS, `One_n, false);
0x0028_2114l, ("Lossy Image Compression Method", "LossyImageCompressionMethod", `CS, `One_n, false);
0x0028_3000l, ("Modality LUT Sequence", "ModalityLUTSequence", `SQ, `One, false);
0x0028_3002l, ("LUT Descriptor", "LUTDescriptor", `US_or_SS, `Three, false);
0x0028_3003l, ("LUT Explanation", "LUTExplanation", `LO, `One, false);
0x0028_3004l, ("Modality LUT Type", "ModalityLUTType", `LO, `One, false);
0x0028_3006l, ("LUT Data", "LUTData", `US_or_OW, `One_n, false);
0x0028_3010l, ("VOI LUT Sequence", "VOILUTSequence", `SQ, `One, false);
0x0028_3110l, ("Softcopy VOI LUT Sequence", "SoftcopyVOILUTSequence", `SQ, `One, false);
0x0028_4000l, ("Image Presentation Comments", "ImagePresentationComments", `LT, `One, true);
0x0028_5000l, ("Bi-Plane Acquisition Sequence", "BiPlaneAcquisitionSequence", `SQ, `One, true);
0x0028_6010l, ("Representative Frame Number", "RepresentativeFrameNumber", `US, `One, false);
0x0028_6020l, ("Frame Numbers of Interest (FOI)", "FrameNumbersOfInterest", `US, `One_n, false);
0x0028_6022l, ("Frame of Interest Description", "FrameOfInterestDescription", `LO, `One_n, false);
0x0028_6023l, ("Frame of Interest Type", "FrameOfInterestType", `CS, `One_n, false);
0x0028_6030l, ("Mask Pointer(s)", "MaskPointers", `US, `One_n, true);
0x0028_6040l, ("R Wave Pointer", "RWavePointer", `US, `One_n, false);
0x0028_6100l, ("Mask Subtraction Sequence", "MaskSubtractionSequence", `SQ, `One, false);
0x0028_6101l, ("Mask Operation", "MaskOperation", `CS, `One, false);
0x0028_6102l, ("Applicable Frame Range", "ApplicableFrameRange", `US, `Two_2n, false);
0x0028_6110l, ("Mask Frame Numbers", "MaskFrameNumbers", `US, `One_n, false);
0x0028_6112l, ("Contrast Frame Averaging", "ContrastFrameAveraging", `US, `One, false);
0x0028_6114l, ("Mask Sub-pixel Shift", "MaskSubPixelShift", `FL, `Two, false);
0x0028_6120l, ("TID Offset", "TIDOffset", `SS, `One, false);
0x0028_6190l, ("Mask Operation Explanation", "MaskOperationExplanation", `ST, `One, false);
0x0028_7FE0l, ("Pixel Data Provider URL", "PixelDataProviderURL", `UT, `One, false);
0x0028_9001l, ("Data Point Rows", "DataPointRows", `UL, `One, false);
0x0028_9002l, ("Data Point Columns", "DataPointColumns", `UL, `One, false);
0x0028_9003l, ("Signal Domain Columns", "SignalDomainColumns", `CS, `One, false);
0x0028_9099l, ("Largest Monochrome Pixel Value", "LargestMonochromePixelValue", `US, `One, true);
0x0028_9108l, ("Data Representation", "DataRepresentation", `CS, `One, false);
0x0028_9110l, ("Pixel Measures Sequence", "PixelMeasuresSequence", `SQ, `One, false);
0x0028_9132l, ("Frame VOI LUT Sequence", "FrameVOILUTSequence", `SQ, `One, false);
0x0028_9145l, ("Pixel Value Transformation Sequence", "PixelValueTransformationSequence", `SQ, `One, false);
0x0028_9235l, ("Signal Domain Rows", "SignalDomainRows", `CS, `One, false);
0x0028_9411l, ("Display Filter Percentage", "DisplayFilterPercentage", `FL, `One, false);
0x0028_9415l, ("Frame Pixel Shift Sequence", "FramePixelShiftSequence", `SQ, `One, false);
0x0028_9416l, ("Subtraction Item ID", "SubtractionItemID", `US, `One, false);
0x0028_9422l, ("Pixel Intensity Relationship LUT Sequence", "PixelIntensityRelationshipLUTSequence", `SQ, `One, false);
0x0028_9443l, ("Frame Pixel Data Properties Sequence", "FramePixelDataPropertiesSequence", `SQ, `One, false);
0x0028_9444l, ("Geometrical Properties", "GeometricalProperties", `CS, `One, false);
0x0028_9445l, ("Geometric Maximum Distortion", "GeometricMaximumDistortion", `FL, `One, false);
0x0028_9446l, ("Image Processing Applied", "ImageProcessingApplied", `CS, `One_n, false);
0x0028_9454l, ("Mask Selection Mode", "MaskSelectionMode", `CS, `One, false);
0x0028_9474l, ("LUT Function", "LUTFunction", `CS, `One, false);
0x0028_9478l, ("Mask Visibility Percentage", "MaskVisibilityPercentage", `FL, `One, false);
0x0028_9501l, ("Pixel Shift Sequence", "PixelShiftSequence", `SQ, `One, false);
0x0028_9502l, ("Region Pixel Shift Sequence", "RegionPixelShiftSequence", `SQ, `One, false);
0x0028_9503l, ("Vertices of the Region", "VerticesOfTheRegion", `SS, `Two_2n, false);
0x0028_9505l, ("Multi-frame Presentation Sequence", "MultiFramePresentationSequence", `SQ, `One, false);
0x0028_9506l, ("Pixel Shift Frame Range", "PixelShiftFrameRange", `US, `Two_2n, false);
0x0028_9507l, ("LUT Frame Range", "LUTFrameRange", `US, `Two_2n, false);
0x0028_9520l, ("Image to Equipment Mapping Matrix", "ImageToEquipmentMappingMatrix", `DS, `Sixteen, false);
0x0028_9537l, ("Equipment Coordinate System Identification", "EquipmentCoordinateSystemIdentification", `CS, `One, false);
0x0032_000Al, ("Study Status ID", "StudyStatusID", `CS, `One, true);
0x0032_000Cl, ("Study Priority ID", "StudyPriorityID", `CS, `One, true);
0x0032_0012l, ("Study ID Issuer", "StudyIDIssuer", `LO, `One, true);
0x0032_0032l, ("Study Verified Date", "StudyVerifiedDate", `DA, `One, true);
0x0032_0033l, ("Study Verified Time", "StudyVerifiedTime", `TM, `One, true);
0x0032_0034l, ("Study Read Date", "StudyReadDate", `DA, `One, true);
0x0032_0035l, ("Study Read Time", "StudyReadTime", `TM, `One, true);
0x0032_1000l, ("Scheduled Study Start Date", "ScheduledStudyStartDate", `DA, `One, true);
0x0032_1001l, ("Scheduled Study Start Time", "ScheduledStudyStartTime", `TM, `One, true);
0x0032_1010l, ("Scheduled Study Stop Date", "ScheduledStudyStopDate", `DA, `One, true);
0x0032_1011l, ("Scheduled Study Stop Time", "ScheduledStudyStopTime", `TM, `One, true);
0x0032_1020l, ("Scheduled Study Location", "ScheduledStudyLocation", `LO, `One, true);
0x0032_1021l, ("Scheduled Study Location AE Title", "ScheduledStudyLocationAETitle", `AE, `One_n, true);
0x0032_1030l, ("Reason for Study", "ReasonForStudy", `LO, `One, true);
0x0032_1031l, ("Requesting Physician Identification Sequence", "RequestingPhysicianIdentificationSequence", `SQ, `One, false);
0x0032_1032l, ("Requesting Physician", "RequestingPhysician", `PN, `One, false);
0x0032_1033l, ("Requesting Service", "RequestingService", `LO, `One, false);
0x0032_1034l, ("Requesting Service Code Sequence", "RequestingServiceCodeSequence", `SQ, `One, false);
0x0032_1040l, ("Study Arrival Date", "StudyArrivalDate", `DA, `One, true);
0x0032_1041l, ("Study Arrival Time", "StudyArrivalTime", `TM, `One, true);
0x0032_1050l, ("Study Completion Date", "StudyCompletionDate", `DA, `One, true);
0x0032_1051l, ("Study Completion Time", "StudyCompletionTime", `TM, `One, true);
0x0032_1055l, ("Study Component Status ID", "StudyComponentStatusID", `CS, `One, true);
0x0032_1060l, ("Requested Procedure Description", "RequestedProcedureDescription", `LO, `One, false);
0x0032_1064l, ("Requested Procedure Code Sequence", "RequestedProcedureCodeSequence", `SQ, `One, false);
0x0032_1070l, ("Requested Contrast Agent", "RequestedContrastAgent", `LO, `One, false);
0x0032_4000l, ("Study Comments", "StudyComments", `LT, `One, true);
0x0038_0004l, ("Referenced Patient Alias Sequence", "ReferencedPatientAliasSequence", `SQ, `One, false);
0x0038_0008l, ("Visit Status ID", "VisitStatusID", `CS, `One, false);
0x0038_0010l, ("Admission ID", "AdmissionID", `LO, `One, false);
0x0038_0011l, ("Issuer of Admission ID", "IssuerOfAdmissionID", `LO, `One, true);
0x0038_0014l, ("Issuer of Admission ID Sequence", "IssuerOfAdmissionIDSequence", `SQ, `One, false);
0x0038_0016l, ("Route of Admissions", "RouteOfAdmissions", `LO, `One, false);
0x0038_001Al, ("Scheduled Admission Date", "ScheduledAdmissionDate", `DA, `One, true);
0x0038_001Bl, ("Scheduled Admission Time", "ScheduledAdmissionTime", `TM, `One, true);
0x0038_001Cl, ("Scheduled Discharge Date", "ScheduledDischargeDate", `DA, `One, true);
0x0038_001Dl, ("Scheduled Discharge Time", "ScheduledDischargeTime", `TM, `One, true);
0x0038_001El, ("Scheduled Patient Institution Residence", "ScheduledPatientInstitutionResidence", `LO, `One, true);
0x0038_0020l, ("Admitting Date", "AdmittingDate", `DA, `One, false);
0x0038_0021l, ("Admitting Time", "AdmittingTime", `TM, `One, false);
0x0038_0030l, ("Discharge Date", "DischargeDate", `DA, `One, true);
0x0038_0032l, ("Discharge Time", "DischargeTime", `TM, `One, true);
0x0038_0040l, ("Discharge Diagnosis Description", "DischargeDiagnosisDescription", `LO, `One, true);
0x0038_0044l, ("Discharge Diagnosis Code Sequence", "DischargeDiagnosisCodeSequence", `SQ, `One, true);
0x0038_0050l, ("Special Needs", "SpecialNeeds", `LO, `One, false);
0x0038_0060l, ("Service Episode ID", "ServiceEpisodeID", `LO, `One, false);
0x0038_0061l, ("Issuer of Service Episode ID", "IssuerOfServiceEpisodeID", `LO, `One, true);
0x0038_0062l, ("Service Episode Description", "ServiceEpisodeDescription", `LO, `One, false);
0x0038_0064l, ("Issuer of Service Episode ID Sequence", "IssuerOfServiceEpisodeIDSequence", `SQ, `One, false);
0x0038_0100l, ("Pertinent Documents Sequence", "PertinentDocumentsSequence", `SQ, `One, false);
0x0038_0300l, ("Current Patient Location", "CurrentPatientLocation", `LO, `One, false);
0x0038_0400l, ("Patient’s Institution Residence", "PatientInstitutionResidence", `LO, `One, false);
0x0038_0500l, ("Patient State", "PatientState", `LO, `One, false);
0x0038_0502l, ("Patient Clinical Trial Participation Sequence", "PatientClinicalTrialParticipationSequence", `SQ, `One, false);
0x0038_4000l, ("Visit Comments", "VisitComments", `LT, `One, false);
0x003A_0004l, ("Waveform Originality", "WaveformOriginality", `CS, `One, false);
0x003A_0005l, ("Number of Waveform Channels", "NumberOfWaveformChannels", `US, `One, false);
0x003A_0010l, ("Number of Waveform Samples", "NumberOfWaveformSamples", `UL, `One, false);
0x003A_001Al, ("Sampling Frequency", "SamplingFrequency", `DS, `One, false);
0x003A_0020l, ("Multiplex Group Label", "MultiplexGroupLabel", `SH, `One, false);
0x003A_0200l, ("Channel Definition Sequence", "ChannelDefinitionSequence", `SQ, `One, false);
0x003A_0202l, ("Waveform Channel Number", "WaveformChannelNumber", `IS, `One, false);
0x003A_0203l, ("Channel Label", "ChannelLabel", `SH, `One, false);
0x003A_0205l, ("Channel Status", "ChannelStatus", `CS, `One_n, false);
0x003A_0208l, ("Channel Source Sequence", "ChannelSourceSequence", `SQ, `One, false);
0x003A_0209l, ("Channel Source Modifiers Sequence", "ChannelSourceModifiersSequence", `SQ, `One, false);
0x003A_020Al, ("Source Waveform Sequence", "SourceWaveformSequence", `SQ, `One, false);
0x003A_020Cl, ("Channel Derivation Description", "ChannelDerivationDescription", `LO, `One, false);
0x003A_0210l, ("Channel Sensitivity", "ChannelSensitivity", `DS, `One, false);
0x003A_0211l, ("Channel Sensitivity Units Sequence", "ChannelSensitivityUnitsSequence", `SQ, `One, false);
0x003A_0212l, ("Channel Sensitivity Correction Factor", "ChannelSensitivityCorrectionFactor", `DS, `One, false);
0x003A_0213l, ("Channel Baseline", "ChannelBaseline", `DS, `One, false);
0x003A_0214l, ("Channel Time Skew", "ChannelTimeSkew", `DS, `One, false);
0x003A_0215l, ("Channel Sample Skew", "ChannelSampleSkew", `DS, `One, false);
0x003A_0218l, ("Channel Offset", "ChannelOffset", `DS, `One, false);
0x003A_021Al, ("Waveform Bits Stored", "WaveformBitsStored", `US, `One, false);
0x003A_0220l, ("Filter Low Frequency", "FilterLowFrequency", `DS, `One, false);
0x003A_0221l, ("Filter High Frequency", "FilterHighFrequency", `DS, `One, false);
0x003A_0222l, ("Notch Filter Frequency", "NotchFilterFrequency", `DS, `One, false);
0x003A_0223l, ("Notch Filter Bandwidth", "NotchFilterBandwidth", `DS, `One, false);
0x003A_0230l, ("Waveform Data Display Scale", "WaveformDataDisplayScale", `FL, `One, false);
0x003A_0231l, ("Waveform Display Background CIELab Value", "WaveformDisplayBackgroundCIELabValue", `US, `Three, false);
0x003A_0240l, ("Waveform Presentation Group Sequence", "WaveformPresentationGroupSequence", `SQ, `One, false);
0x003A_0241l, ("Presentation Group Number", "PresentationGroupNumber", `US, `One, false);
0x003A_0242l, ("Channel Display Sequence", "ChannelDisplaySequence", `SQ, `One, false);
0x003A_0244l, ("Channel Recommended Display CIELab Value", "ChannelRecommendedDisplayCIELabValue", `US, `Three, false);
0x003A_0245l, ("Channel Position", "ChannelPosition", `FL, `One, false);
0x003A_0246l, ("Display Shading Flag", "DisplayShadingFlag", `CS, `One, false);
0x003A_0247l, ("Fractional Channel Display Scale", "FractionalChannelDisplayScale", `FL, `One, false);
0x003A_0248l, ("Absolute Channel Display Scale", "AbsoluteChannelDisplayScale", `FL, `One, false);
0x003A_0300l, ("Multiplexed Audio Channels Description Code Sequence", "MultiplexedAudioChannelsDescriptionCodeSequence", `SQ, `One, false);
0x003A_0301l, ("Channel Identification Code", "ChannelIdentificationCode", `IS, `One, false);
0x003A_0302l, ("Channel Mode", "ChannelMode", `CS, `One, false);
0x0040_0001l, ("Scheduled Station AE Title", "ScheduledStationAETitle", `AE, `One_n, false);
0x0040_0002l, ("Scheduled Procedure Step Start Date", "ScheduledProcedureStepStartDate", `DA, `One, false);
0x0040_0003l, ("Scheduled Procedure Step Start Time", "ScheduledProcedureStepStartTime", `TM, `One, false);
0x0040_0004l, ("Scheduled Procedure Step End Date", "ScheduledProcedureStepEndDate", `DA, `One, false);
0x0040_0005l, ("Scheduled Procedure Step End Time", "ScheduledProcedureStepEndTime", `TM, `One, false);
0x0040_0006l, ("Scheduled Performing Physician’s Name", "ScheduledPerformingPhysicianName", `PN, `One, false);
0x0040_0007l, ("Scheduled Procedure Step Description", "ScheduledProcedureStepDescription", `LO, `One, false);
0x0040_0008l, ("Scheduled Protocol Code Sequence", "ScheduledProtocolCodeSequence", `SQ, `One, false);
0x0040_0009l, ("Scheduled Procedure Step ID", "ScheduledProcedureStepID", `SH, `One, false);
0x0040_000Al, ("Stage Code Sequence", "StageCodeSequence", `SQ, `One, false);
0x0040_000Bl, ("Scheduled Performing Physician Identification Sequence", "ScheduledPerformingPhysicianIdentificationSequence", `SQ, `One, false);
0x0040_0010l, ("Scheduled Station Name", "ScheduledStationName", `SH, `One_n, false);
0x0040_0011l, ("Scheduled Procedure Step Location", "ScheduledProcedureStepLocation", `SH, `One, false);
0x0040_0012l, ("Pre-Medication", "PreMedication", `LO, `One, false);
0x0040_0020l, ("Scheduled Procedure Step Status", "ScheduledProcedureStepStatus", `CS, `One, false);
0x0040_0026l, ("Order Placer Identifier Sequence", "OrderPlacerIdentifierSequence", `SQ, `One, false);
0x0040_0027l, ("Order Filler Identifier Sequence", "OrderFillerIdentifierSequence", `SQ, `One, false);
0x0040_0031l, ("Local Namespace Entity ID", "LocalNamespaceEntityID", `UT, `One, false);
0x0040_0032l, ("Universal Entity ID", "UniversalEntityID", `UT, `One, false);
0x0040_0033l, ("Universal Entity ID Type", "UniversalEntityIDType", `CS, `One, false);
0x0040_0035l, ("Identifier Type Code", "IdentifierTypeCode", `CS, `One, false);
0x0040_0036l, ("Assigning Facility Sequence", "AssigningFacilitySequence", `SQ, `One, false);
0x0040_0039l, ("Assigning Jurisdiction Code Sequence", "AssigningJurisdictionCodeSequence", `SQ, `One, false);
0x0040_003Al, ("Assigning Agency or Department Code Sequence", "AssigningAgencyOrDepartmentCodeSequence", `SQ, `One, false);
0x0040_0100l, ("Scheduled Procedure Step Sequence", "ScheduledProcedureStepSequence", `SQ, `One, false);
0x0040_0220l, ("Referenced Non-Image Composite SOP Instance Sequence", "ReferencedNonImageCompositeSOPInstanceSequence", `SQ, `One, false);
0x0040_0241l, ("Performed Station AE Title", "PerformedStationAETitle", `AE, `One, false);
0x0040_0242l, ("Performed Station Name", "PerformedStationName", `SH, `One, false);
0x0040_0243l, ("Performed Location", "PerformedLocation", `SH, `One, false);
0x0040_0244l, ("Performed Procedure Step Start Date", "PerformedProcedureStepStartDate", `DA, `One, false);
0x0040_0245l, ("Performed Procedure Step Start Time", "PerformedProcedureStepStartTime", `TM, `One, false);
0x0040_0250l, ("Performed Procedure Step End Date", "PerformedProcedureStepEndDate", `DA, `One, false);
0x0040_0251l, ("Performed Procedure Step End Time", "PerformedProcedureStepEndTime", `TM, `One, false);
0x0040_0252l, ("Performed Procedure Step Status", "PerformedProcedureStepStatus", `CS, `One, false);
0x0040_0253l, ("Performed Procedure Step ID", "PerformedProcedureStepID", `SH, `One, false);
0x0040_0254l, ("Performed Procedure Step Description", "PerformedProcedureStepDescription", `LO, `One, false);
0x0040_0255l, ("Performed Procedure Type Description", "PerformedProcedureTypeDescription", `LO, `One, false);
0x0040_0260l, ("Performed Protocol Code Sequence", "PerformedProtocolCodeSequence", `SQ, `One, false);
0x0040_0261l, ("Performed Protocol Type", "PerformedProtocolType", `CS, `One, false);
0x0040_0270l, ("Scheduled Step Attributes Sequence", "ScheduledStepAttributesSequence", `SQ, `One, false);
0x0040_0275l, ("Request Attributes Sequence", "RequestAttributesSequence", `SQ, `One, false);
0x0040_0280l, ("Comments on the Performed Procedure Step", "CommentsOnThePerformedProcedureStep", `ST, `One, false);
0x0040_0281l, ("Performed Procedure Step Discontinuation Reason Code Sequence", "PerformedProcedureStepDiscontinuationReasonCodeSequence", `SQ, `One, false);
0x0040_0293l, ("Quantity Sequence", "QuantitySequence", `SQ, `One, false);
0x0040_0294l, ("Quantity", "Quantity", `DS, `One, false);
0x0040_0295l, ("Measuring Units Sequence", "MeasuringUnitsSequence", `SQ, `One, false);
0x0040_0296l, ("Billing Item Sequence", "BillingItemSequence", `SQ, `One, false);
0x0040_0300l, ("Total Time of Fluoroscopy", "TotalTimeOfFluoroscopy", `US, `One, false);
0x0040_0301l, ("Total Number of Exposures", "TotalNumberOfExposures", `US, `One, false);
0x0040_0302l, ("Entrance Dose", "EntranceDose", `US, `One, false);
0x0040_0303l, ("Exposed Area", "ExposedArea", `US, `One_2, false);
0x0040_0306l, ("Distance Source to Entrance", "DistanceSourceToEntrance", `DS, `One, false);
0x0040_0307l, ("Distance Source to Support", "DistanceSourceToSupport", `DS, `One, true);
0x0040_030El, ("Exposure Dose Sequence", "ExposureDoseSequence", `SQ, `One, false);
0x0040_0310l, ("Comments on Radiation Dose", "CommentsOnRadiationDose", `ST, `One, false);
0x0040_0312l, ("X-Ray Output", "XRayOutput", `DS, `One, false);
0x0040_0314l, ("Half Value Layer", "HalfValueLayer", `DS, `One, false);
0x0040_0316l, ("Organ Dose", "OrganDose", `DS, `One, false);
0x0040_0318l, ("Organ Exposed", "OrganExposed", `CS, `One, false);
0x0040_0320l, ("Billing Procedure Step Sequence", "BillingProcedureStepSequence", `SQ, `One, false);
0x0040_0321l, ("Film Consumption Sequence", "FilmConsumptionSequence", `SQ, `One, false);
0x0040_0324l, ("Billing Supplies and Devices Sequence", "BillingSuppliesAndDevicesSequence", `SQ, `One, false);
0x0040_0330l, ("Referenced Procedure Step Sequence", "ReferencedProcedureStepSequence", `SQ, `One, true);
0x0040_0340l, ("Performed Series Sequence", "PerformedSeriesSequence", `SQ, `One, false);
0x0040_0400l, ("Comments on the Scheduled Procedure Step", "CommentsOnTheScheduledProcedureStep", `LT, `One, false);
0x0040_0440l, ("Protocol Context Sequence", "ProtocolContextSequence", `SQ, `One, false);
0x0040_0441l, ("Content Item Modifier Sequence", "ContentItemModifierSequence", `SQ, `One, false);
0x0040_0500l, ("Scheduled Specimen Sequence", "ScheduledSpecimenSequence", `SQ, `One, false);
0x0040_050Al, ("Specimen Accession Number", "SpecimenAccessionNumber", `LO, `One, true);
0x0040_0512l, ("Container Identifier", "ContainerIdentifier", `LO, `One, false);
0x0040_0513l, ("Issuer of the Container Identifier Sequence", "IssuerOfTheContainerIdentifierSequence", `SQ, `One, false);
0x0040_0515l, ("Alternate Container Identifier Sequence", "AlternateContainerIdentifierSequence", `SQ, `One, false);
0x0040_0518l, ("Container Type Code Sequence", "ContainerTypeCodeSequence", `SQ, `One, false);
0x0040_051Al, ("Container Description", "ContainerDescription", `LO, `One, false);
0x0040_0520l, ("Container Component Sequence", "ContainerComponentSequence", `SQ, `One, false);
0x0040_0550l, ("Specimen Sequence", "SpecimenSequence", `SQ, `One, true);
0x0040_0551l, ("Specimen Identifier", "SpecimenIdentifier", `LO, `One, false);
0x0040_0552l, ("Specimen Description Sequence (Trial)", "SpecimenDescriptionSequenceTrial", `SQ, `One, true);
0x0040_0553l, ("Specimen Description (Trial)", "SpecimenDescriptionTrial", `ST, `One, true);
0x0040_0554l, ("Specimen UID", "SpecimenUID", `UI, `One, false);
0x0040_0555l, ("Acquisition Context Sequence", "AcquisitionContextSequence", `SQ, `One, false);
0x0040_0556l, ("Acquisition Context Description", "AcquisitionContextDescription", `ST, `One, false);
0x0040_059Al, ("Specimen Type Code Sequence", "SpecimenTypeCodeSequence", `SQ, `One, false);
0x0040_0560l, ("Specimen Description Sequence", "SpecimenDescriptionSequence", `SQ, `One, false);
0x0040_0562l, ("Issuer of the Specimen Identifier Sequence", "IssuerOfTheSpecimenIdentifierSequence", `SQ, `One, false);
0x0040_0600l, ("Specimen Short Description", "SpecimenShortDescription", `LO, `One, false);
0x0040_0602l, ("Specimen Detailed Description", "SpecimenDetailedDescription", `UT, `One, false);
0x0040_0610l, ("Specimen Preparation Sequence", "SpecimenPreparationSequence", `SQ, `One, false);
0x0040_0612l, ("Specimen Preparation Step Content Item Sequence", "SpecimenPreparationStepContentItemSequence", `SQ, `One, false);
0x0040_0620l, ("Specimen Localization Content Item Sequence", "SpecimenLocalizationContentItemSequence", `SQ, `One, false);
0x0040_06FAl, ("Slide Identifier", "SlideIdentifier", `LO, `One, true);
0x0040_071Al, ("Image Center Point Coordinates Sequence", "ImageCenterPointCoordinatesSequence", `SQ, `One, false);
0x0040_072Al, ("X Offset in Slide Coordinate System", "XOffsetInSlideCoordinateSystem", `DS, `One, false);
0x0040_073Al, ("Y Offset in Slide Coordinate System", "YOffsetInSlideCoordinateSystem", `DS, `One, false);
0x0040_074Al, ("Z Offset in Slide Coordinate System", "ZOffsetInSlideCoordinateSystem", `DS, `One, false);
0x0040_08D8l, ("Pixel Spacing Sequence", "PixelSpacingSequence", `SQ, `One, true);
0x0040_08DAl, ("Coordinate System Axis Code Sequence", "CoordinateSystemAxisCodeSequence", `SQ, `One, true);
0x0040_08EAl, ("Measurement Units Code Sequence", "MeasurementUnitsCodeSequence", `SQ, `One, false);
0x0040_09F8l, ("Vital Stain Code Sequence (Trial)", "VitalStainCodeSequenceTrial", `SQ, `One, true);
0x0040_1001l, ("Requested Procedure ID", "RequestedProcedureID", `SH, `One, false);
0x0040_1002l, ("Reason for the Requested Procedure", "ReasonForTheRequestedProcedure", `LO, `One, false);
0x0040_1003l, ("Requested Procedure Priority", "RequestedProcedurePriority", `SH, `One, false);
0x0040_1004l, ("Patient Transport Arrangements", "PatientTransportArrangements", `LO, `One, false);
0x0040_1005l, ("Requested Procedure Location", "RequestedProcedureLocation", `LO, `One, false);
0x0040_1006l, ("Placer Order Number / Procedure", "PlacerOrderNumberProcedure", `SH, `One, true);
0x0040_1007l, ("Filler Order Number / Procedure", "FillerOrderNumberProcedure", `SH, `One, true);
0x0040_1008l, ("Confidentiality Code", "ConfidentialityCode", `LO, `One, false);
0x0040_1009l, ("Reporting Priority", "ReportingPriority", `SH, `One, false);
0x0040_100Al, ("Reason for Requested Procedure Code Sequence", "ReasonForRequestedProcedureCodeSequence", `SQ, `One, false);
0x0040_1010l, ("Names of Intended Recipients of Results", "NamesOfIntendedRecipientsOfResults", `PN, `One_n, false);
0x0040_1011l, ("Intended Recipients of Results Identification Sequence", "IntendedRecipientsOfResultsIdentificationSequence", `SQ, `One, false);
0x0040_1012l, ("Reason For Performed Procedure Code Sequence", "ReasonForPerformedProcedureCodeSequence", `SQ, `One, false);
0x0040_1060l, ("Requested Procedure Description (Trial)", "RequestedProcedureDescriptionTrial", `LO, `One, true);
0x0040_1101l, ("Person Identification Code Sequence", "PersonIdentificationCodeSequence", `SQ, `One, false);
0x0040_1102l, ("Person’s Address", "PersonAddress", `ST, `One, false);
0x0040_1103l, ("Person’s Telephone Numbers", "PersonTelephoneNumbers", `LO, `One_n, false);
0x0040_1400l, ("Requested Procedure Comments", "RequestedProcedureComments", `LT, `One, false);
0x0040_2001l, ("Reason for the Imaging Service Request", "ReasonForTheImagingServiceRequest", `LO, `One, true);
0x0040_2004l, ("Issue Date of Imaging Service Request", "IssueDateOfImagingServiceRequest", `DA, `One, false);
0x0040_2005l, ("Issue Time of Imaging Service Request", "IssueTimeOfImagingServiceRequest", `TM, `One, false);
0x0040_2006l, ("Placer Order Number / Imaging Service Request (Retired)", "PlacerOrderNumberImagingServiceRequestRetired", `SH, `One, true);
0x0040_2007l, ("Filler Order Number / Imaging Service Request (Retired)", "FillerOrderNumberImagingServiceRequestRetired", `SH, `One, true);
0x0040_2008l, ("Order Entered By", "OrderEnteredBy", `PN, `One, false);
0x0040_2009l, ("Order Enterer’s Location", "OrderEntererLocation", `SH, `One, false);
0x0040_2010l, ("Order Callback Phone Number", "OrderCallbackPhoneNumber", `SH, `One, false);
0x0040_2016l, ("Placer Order Number / Imaging Service Request", "PlacerOrderNumberImagingServiceRequest", `LO, `One, false);
0x0040_2017l, ("Filler Order Number / Imaging Service Request", "FillerOrderNumberImagingServiceRequest", `LO, `One, false);
0x0040_2400l, ("Imaging Service Request Comments", "ImagingServiceRequestComments", `LT, `One, false);
0x0040_3001l, ("Confidentiality Constraint on Patient Data Description", "ConfidentialityConstraintOnPatientDataDescription", `LO, `One, false);
0x0040_4001l, ("General Purpose Scheduled Procedure Step Status", "GeneralPurposeScheduledProcedureStepStatus", `CS, `One, false);
0x0040_4002l, ("General Purpose Performed Procedure Step Status", "GeneralPurposePerformedProcedureStepStatus", `CS, `One, false);
0x0040_4003l, ("General Purpose Scheduled Procedure Step Priority", "GeneralPurposeScheduledProcedureStepPriority", `CS, `One, false);
0x0040_4004l, ("Scheduled Processing Applications Code Sequence", "ScheduledProcessingApplicationsCodeSequence", `SQ, `One, false);
0x0040_4005l, ("Scheduled Procedure Step Start DateTime", "ScheduledProcedureStepStartDateTime", `DT, `One, false);
0x0040_4006l, ("Multiple Copies Flag", "MultipleCopiesFlag", `CS, `One, false);
0x0040_4007l, ("Performed Processing Applications Code Sequence", "PerformedProcessingApplicationsCodeSequence", `SQ, `One, false);
0x0040_4009l, ("Human Performer Code Sequence", "HumanPerformerCodeSequence", `SQ, `One, false);
0x0040_4010l, ("Scheduled Procedure Step Modification Date Time", "ScheduledProcedureStepModificationDateTime", `DT, `One, false);
0x0040_4011l, ("Expected Completion Date Time", "ExpectedCompletionDateTime", `DT, `One, false);
0x0040_4015l, ("Resulting General Purpose Performed Procedure Steps Sequence", "ResultingGeneralPurposePerformedProcedureStepsSequence", `SQ, `One, false);
0x0040_4016l, ("Referenced General Purpose Scheduled Procedure Step Sequence", "ReferencedGeneralPurposeScheduledProcedureStepSequence", `SQ, `One, false);
0x0040_4018l, ("Scheduled Workitem Code Sequence", "ScheduledWorkitemCodeSequence", `SQ, `One, false);
0x0040_4019l, ("Performed Workitem Code Sequence", "PerformedWorkitemCodeSequence", `SQ, `One, false);
0x0040_4020l, ("Input Availability Flag", "InputAvailabilityFlag", `CS, `One, false);
0x0040_4021l, ("Input Information Sequence", "InputInformationSequence", `SQ, `One, false);
0x0040_4022l, ("Relevant Information Sequence", "RelevantInformationSequence", `SQ, `One, false);
0x0040_4023l, ("Referenced General Purpose Scheduled Procedure Step Transaction UID", "ReferencedGeneralPurposeScheduledProcedureStepTransactionUID", `UI, `One, false);
0x0040_4025l, ("Scheduled Station Name Code Sequence", "ScheduledStationNameCodeSequence", `SQ, `One, false);
0x0040_4026l, ("Scheduled Station Class Code Sequence", "ScheduledStationClassCodeSequence", `SQ, `One, false);
0x0040_4027l, ("Scheduled Station Geographic Location Code Sequence", "ScheduledStationGeographicLocationCodeSequence", `SQ, `One, false);
0x0040_4028l, ("Performed Station Name Code Sequence", "PerformedStationNameCodeSequence", `SQ, `One, false);
0x0040_4029l, ("Performed Station Class Code Sequence", "PerformedStationClassCodeSequence", `SQ, `One, false);
0x0040_4030l, ("Performed Station Geographic Location Code Sequence", "PerformedStationGeographicLocationCodeSequence", `SQ, `One, false);
0x0040_4031l, ("Requested Subsequent Workitem Code Sequence", "RequestedSubsequentWorkitemCodeSequence", `SQ, `One, false);
0x0040_4032l, ("Non-DICOM Output Code Sequence", "NonDICOMOutputCodeSequence", `SQ, `One, false);
0x0040_4033l, ("Output Information Sequence", "OutputInformationSequence", `SQ, `One, false);
0x0040_4034l, ("Scheduled Human Performers Sequence", "ScheduledHumanPerformersSequence", `SQ, `One, false);
0x0040_4035l, ("Actual Human Performers Sequence", "ActualHumanPerformersSequence", `SQ, `One, false);
0x0040_4036l, ("Human Performer’s Organization", "HumanPerformerOrganization", `LO, `One, false);
0x0040_4037l, ("Human Performer’s Name", "HumanPerformerName", `PN, `One, false);
0x0040_4040l, ("Raw Data Handling", "RawDataHandling", `CS, `One, false);
0x0040_4041l, ("Input Readiness State", "InputReadinessState", `CS, `One, false);
0x0040_4050l, ("Performed Procedure Step Start DateTime", "PerformedProcedureStepStartDateTime", `DT, `One, false);
0x0040_4051l, ("Performed Procedure Step End DateTime", "PerformedProcedureStepEndDateTime", `DT, `One, false);
0x0040_4052l, ("Procedure Step Cancellation DateTime", "ProcedureStepCancellationDateTime", `DT, `One, false);
0x0040_8302l, ("Entrance Dose in mGy", "EntranceDoseInmGy", `DS, `One, false);
0x0040_9094l, ("Referenced Image Real World Value Mapping Sequence", "ReferencedImageRealWorldValueMappingSequence", `SQ, `One, false);
0x0040_9096l, ("Real World Value Mapping Sequence", "RealWorldValueMappingSequence", `SQ, `One, false);
0x0040_9098l, ("Pixel Value Mapping Code Sequence", "PixelValueMappingCodeSequence", `SQ, `One, false);
0x0040_9210l, ("LUT Label", "LUTLabel", `SH, `One, false);
0x0040_9211l, ("Real World Value Last Value Mapped", "RealWorldValueLastValueMapped", `US_or_SS, `One, false);
0x0040_9212l, ("Real World Value LUT Data", "RealWorldValueLUTData", `FD, `One_n, false);
0x0040_9216l, ("Real World Value First Value Mapped", "RealWorldValueFirstValueMapped", `US_or_SS, `One, false);
0x0040_9224l, ("Real World Value Intercept", "RealWorldValueIntercept", `FD, `One, false);
0x0040_9225l, ("Real World Value Slope", "RealWorldValueSlope", `FD, `One, false);
0x0040_A007l, ("Findings Flag (Trial)", "FindingsFlagTrial", `CS, `One, true);
0x0040_A010l, ("Relationship Type", "RelationshipType", `CS, `One, false);
0x0040_A020l, ("Findings Sequence (Trial)", "FindingsSequenceTrial", `SQ, `One, true);
0x0040_A021l, ("Findings Group UID (Trial)", "FindingsGroupUIDTrial", `UI, `One, true);
0x0040_A022l, ("Referenced Findings Group UID (Trial)", "ReferencedFindingsGroupUIDTrial", `UI, `One, true);
0x0040_A023l, ("Findings Group Recording Date (Trial)", "FindingsGroupRecordingDateTrial", `DA, `One, true);
0x0040_A024l, ("Findings Group Recording Time (Trial)", "FindingsGroupRecordingTimeTrial", `TM, `One, true);
0x0040_A026l, ("Findings Source Category Code Sequence (Trial)", "FindingsSourceCategoryCodeSequenceTrial", `SQ, `One, true);
0x0040_A027l, ("Verifying Organization", "VerifyingOrganization", `LO, `One, false);
0x0040_A028l, ("Documenting Organization Identifier Code Sequence (Trial)", "DocumentingOrganizationIdentifierCodeSequenceTrial", `SQ, `One, true);
0x0040_A030l, ("Verification Date Time", "VerificationDateTime", `DT, `One, false);
0x0040_A032l, ("Observation Date Time", "ObservationDateTime", `DT, `One, false);
0x0040_A040l, ("Value Type", "ValueType", `CS, `One, false);
0x0040_A043l, ("Concept Name Code Sequence", "ConceptNameCodeSequence", `SQ, `One, false);
0x0040_A047l, ("Measurement Precision Description (Trial)", "MeasurementPrecisionDescriptionTrial", `LO, `One, true);
0x0040_A050l, ("Continuity Of Content", "ContinuityOfContent", `CS, `One, false);
0x0040_A057l, ("Urgency or Priority Alerts (Trial)", "UrgencyOrPriorityAlertsTrial", `CS, `One_n, true);
0x0040_A060l, ("Sequencing Indicator (Trial)", "SequencingIndicatorTrial", `LO, `One, true);
0x0040_A066l, ("Document Identifier Code Sequence (Trial)", "DocumentIdentifierCodeSequenceTrial", `SQ, `One, true);
0x0040_A067l, ("Document Author (Trial)", "DocumentAuthorTrial", `PN, `One, true);
0x0040_A068l, ("Document Author Identifier Code Sequence (Trial)", "DocumentAuthorIdentifierCodeSequenceTrial", `SQ, `One, true);
0x0040_A070l, ("Identifier Code Sequence (Trial)", "IdentifierCodeSequenceTrial", `SQ, `One, true);
0x0040_A073l, ("Verifying Observer Sequence", "VerifyingObserverSequence", `SQ, `One, false);
0x0040_A074l, ("Object Binary Identifier (Trial)", "ObjectBinaryIdentifierTrial", `OB, `One, true);
0x0040_A075l, ("Verifying Observer Name", "VerifyingObserverName", `PN, `One, false);
0x0040_A076l, ("Documenting Observer Identifier Code Sequence (Trial)", "DocumentingObserverIdentifierCodeSequenceTrial", `SQ, `One, true);
0x0040_A078l, ("Author Observer Sequence", "AuthorObserverSequence", `SQ, `One, false);
0x0040_A07Al, ("Participant Sequence", "ParticipantSequence", `SQ, `One, false);
0x0040_A07Cl, ("Custodial Organization Sequence", "CustodialOrganizationSequence", `SQ, `One, false);
0x0040_A080l, ("Participation Type", "ParticipationType", `CS, `One, false);
0x0040_A082l, ("Participation DateTime", "ParticipationDateTime", `DT, `One, false);
0x0040_A084l, ("Observer Type", "ObserverType", `CS, `One, false);
0x0040_A085l, ("Procedure Identifier Code Sequence (Trial)", "ProcedureIdentifierCodeSequenceTrial", `SQ, `One, true);
0x0040_A088l, ("Verifying Observer Identification Code Sequence", "VerifyingObserverIdentificationCodeSequence", `SQ, `One, false);
0x0040_A089l, ("Object Directory Binary Identifier (Trial)", "ObjectDirectoryBinaryIdentifierTrial", `OB, `One, true);
0x0040_A090l, ("Equivalent CDA Document Sequence", "EquivalentCDADocumentSequence", `SQ, `One, true);
0x0040_A0B0l, ("Referenced Waveform Channels", "ReferencedWaveformChannels", `US, `Two_2n, false);
0x0040_A110l, ("Date of Document or Verbal Transaction (Trial)", "DateOfDocumentOrVerbalTransactionTrial", `DA, `One, true);
0x0040_A112l, ("Time of Document Creation or Verbal Transaction (Trial)", "TimeOfDocumentCreationOrVerbalTransactionTrial", `TM, `One, true);
0x0040_A120l, ("DateTime", "DateTime", `DT, `One, false);
0x0040_A121l, ("Date", "Date", `DA, `One, false);
0x0040_A122l, ("Time", "Time", `TM, `One, false);
0x0040_A123l, ("Person Name", "PersonName", `PN, `One, false);
0x0040_A124l, ("UID", "UID", `UI, `One, false);
0x0040_A125l, ("Report Status ID (Trial)", "ReportStatusIDTrial", `CS, `Two, true);
0x0040_A130l, ("Temporal Range Type", "TemporalRangeType", `CS, `One, false);
0x0040_A132l, ("Referenced Sample Positions", "ReferencedSamplePositions", `UL, `One_n, false);
0x0040_A136l, ("Referenced Frame Numbers", "ReferencedFrameNumbers", `US, `One_n, false);
0x0040_A138l, ("Referenced Time Offsets", "ReferencedTimeOffsets", `DS, `One_n, false);
0x0040_A13Al, ("Referenced DateTime", "ReferencedDateTime", `DT, `One_n, false);
0x0040_A160l, ("Text Value", "TextValue", `UT, `One, false);
0x0040_A167l, ("Observation Category Code Sequence (Trial)", "ObservationCategoryCodeSequenceTrial", `SQ, `One, true);
0x0040_A168l, ("Concept Code Sequence", "ConceptCodeSequence", `SQ, `One, false);
0x0040_A16Al, ("Bibliographic Citation (Trial)", "BibliographicCitationTrial", `ST, `One, true);
0x0040_A170l, ("Purpose of Reference Code Sequence", "PurposeOfReferenceCodeSequence", `SQ, `One, false);
0x0040_A171l, ("Observation UID (Trial)", "ObservationUIDTrial", `UI, `One, true);
0x0040_A172l, ("Referenced Observation UID (Trial)", "ReferencedObservationUIDTrial", `UI, `One, true);
0x0040_A173l, ("Referenced Observation Class (Trial)", "ReferencedObservationClassTrial", `CS, `One, true);
0x0040_A174l, ("Referenced Object Observation Class (Trial)", "ReferencedObjectObservationClassTrial", `CS, `One, true);
0x0040_A180l, ("Annotation Group Number", "AnnotationGroupNumber", `US, `One, false);
0x0040_A192l, ("Observation Date (Trial)", "ObservationDateTrial", `DA, `One, true);
0x0040_A193l, ("Observation Time (Trial)", "ObservationTimeTrial", `TM, `One, true);
0x0040_A194l, ("Measurement Automation (Trial)", "MeasurementAutomationTrial", `CS, `One, true);
0x0040_A195l, ("Modifier Code Sequence", "ModifierCodeSequence", `SQ, `One, false);
0x0040_A224l, ("Identification Description (Trial)", "IdentificationDescriptionTrial", `ST, `One, true);
0x0040_A290l, ("Coordinates Set Geometric Type (Trial)", "CoordinatesSetGeometricTypeTrial", `CS, `One, true);
0x0040_A296l, ("Algorithm Code Sequence (Trial)", "AlgorithmCodeSequenceTrial", `SQ, `One, true);
0x0040_A297l, ("Algorithm Description (Trial)", "AlgorithmDescriptionTrial", `ST, `One, true);
0x0040_A29Al, ("Pixel Coordinates Set (Trial)", "PixelCoordinatesSetTrial", `SL, `Two_2n, true);
0x0040_A300l, ("Measured Value Sequence", "MeasuredValueSequence", `SQ, `One, false);
0x0040_A301l, ("Numeric Value Qualifier Code Sequence", "NumericValueQualifierCodeSequence", `SQ, `One, false);
0x0040_A307l, ("Current Observer (Trial)", "CurrentObserverTrial", `PN, `One, true);
0x0040_A30Al, ("Numeric Value", "NumericValue", `DS, `One_n, false);
0x0040_A313l, ("Referenced Accession Sequence (Trial)", "ReferencedAccessionSequenceTrial", `SQ, `One, true);
0x0040_A33Al, ("Report Status Comment (Trial)", "ReportStatusCommentTrial", `ST, `One, true);
0x0040_A340l, ("Procedure Context Sequence (Trial)", "ProcedureContextSequenceTrial", `SQ, `One, true);
0x0040_A352l, ("Verbal Source (Trial)", "VerbalSourceTrial", `PN, `One, true);
0x0040_A353l, ("Address (Trial)", "AddressTrial", `ST, `One, true);
0x0040_A354l, ("Telephone Number (Trial)", "TelephoneNumberTrial", `LO, `One, true);
0x0040_A358l, ("Verbal Source Identifier Code Sequence (Trial)", "VerbalSourceIdentifierCodeSequenceTrial", `SQ, `One, true);
0x0040_A360l, ("Predecessor Documents Sequence", "PredecessorDocumentsSequence", `SQ, `One, false);
0x0040_A370l, ("Referenced Request Sequence", "ReferencedRequestSequence", `SQ, `One, false);
0x0040_A372l, ("Performed Procedure Code Sequence", "PerformedProcedureCodeSequence", `SQ, `One, false);
0x0040_A375l, ("Current Requested Procedure Evidence Sequence", "CurrentRequestedProcedureEvidenceSequence", `SQ, `One, false);
0x0040_A380l, ("Report Detail Sequence (Trial)", "ReportDetailSequenceTrial", `SQ, `One, true);
0x0040_A385l, ("Pertinent Other Evidence Sequence", "PertinentOtherEvidenceSequence", `SQ, `One, false);
0x0040_A390l, ("HL7 Structured Document Reference Sequence", "HL7StructuredDocumentReferenceSequence", `SQ, `One, false);
0x0040_A402l, ("Observation Subject UID (Trial)", "ObservationSubjectUIDTrial", `UI, `One, true);
0x0040_A403l, ("Observation Subject Class (Trial)", "ObservationSubjectClassTrial", `CS, `One, true);
0x0040_A404l, ("Observation Subject Type Code Sequence (Trial)", "ObservationSubjectTypeCodeSequenceTrial", `SQ, `One, true);
0x0040_A491l, ("Completion Flag", "CompletionFlag", `CS, `One, false);
0x0040_A492l, ("Completion Flag Description", "CompletionFlagDescription", `LO, `One, false);
0x0040_A493l, ("Verification Flag", "VerificationFlag", `CS, `One, false);
0x0040_A494l, ("Archive Requested", "ArchiveRequested", `CS, `One, false);
0x0040_A496l, ("Preliminary Flag", "PreliminaryFlag", `CS, `One, false);
0x0040_A504l, ("Content Template Sequence", "ContentTemplateSequence", `SQ, `One, false);
0x0040_A525l, ("Identical Documents Sequence", "IdenticalDocumentsSequence", `SQ, `One, false);
0x0040_A600l, ("Observation Subject Context Flag (Trial)", "ObservationSubjectContextFlagTrial", `CS, `One, true);
0x0040_A601l, ("Observer Context Flag (Trial)", "ObserverContextFlagTrial", `CS, `One, true);
0x0040_A603l, ("Procedure Context Flag (Trial)", "ProcedureContextFlagTrial", `CS, `One, true);
0x0040_A730l, ("Content Sequence", "ContentSequence", `SQ, `One, false);
0x0040_A731l, ("Relationship Sequence (Trial)", "RelationshipSequenceTrial", `SQ, `One, true);
0x0040_A732l, ("Relationship Type Code Sequence (Trial)", "RelationshipTypeCodeSequenceTrial", `SQ, `One, true);
0x0040_A744l, ("Language Code Sequence (Trial)", "LanguageCodeSequenceTrial", `SQ, `One, true);
0x0040_A992l, ("Uniform Resource Locator (Trial)", "UniformResourceLocatorTrial", `ST, `One, true);
0x0040_B020l, ("Waveform Annotation Sequence", "WaveformAnnotationSequence", `SQ, `One, false);
0x0040_DB00l, ("Template Identifier", "TemplateIdentifier", `CS, `One, false);
0x0040_DB06l, ("Template Version", "TemplateVersion", `DT, `One, true);
0x0040_DB07l, ("Template Local Version", "TemplateLocalVersion", `DT, `One, true);
0x0040_DB0Bl, ("Template Extension Flag", "TemplateExtensionFlag", `CS, `One, true);
0x0040_DB0Cl, ("Template Extension Organization UID", "TemplateExtensionOrganizationUID", `UI, `One, true);
0x0040_DB0Dl, ("Template Extension Creator UID", "TemplateExtensionCreatorUID", `UI, `One, true);
0x0040_DB73l, ("Referenced Content Item Identifier", "ReferencedContentItemIdentifier", `UL, `One_n, false);
0x0040_E001l, ("HL7 Instance Identifier", "HL7InstanceIdentifier", `ST, `One, false);
0x0040_E004l, ("HL7 Document Effective Time", "HL7DocumentEffectiveTime", `DT, `One, false);
0x0040_E006l, ("HL7 Document Type Code Sequence", "HL7DocumentTypeCodeSequence", `SQ, `One, false);
0x0040_E008l, ("Document Class Code Sequence", "DocumentClassCodeSequence", `SQ, `One, false);
0x0040_E010l, ("Retrieve URI", "RetrieveURI", `UT, `One, false);
0x0040_E011l, ("Retrieve Location UID", "RetrieveLocationUID", `UI, `One, false);
0x0040_E020l, ("Type of Instances", "TypeOfInstances", `CS, `One, false);
0x0040_E021l, ("DICOM Retrieval Sequence", "DICOMRetrievalSequence", `SQ, `One, false);
0x0040_E022l, ("DICOM Media Retrieval Sequence", "DICOMMediaRetrievalSequence", `SQ, `One, false);
0x0040_E023l, ("WADO Retrieval Sequence", "WADORetrievalSequence", `SQ, `One, false);
0x0040_E024l, ("XDS Retrieval Sequence", "XDSRetrievalSequence", `SQ, `One, false);
0x0040_E030l, ("Repository Unique ID", "RepositoryUniqueID", `UI, `One, false);
0x0040_E031l, ("Home Community ID", "HomeCommunityID", `UI, `One, false);
0x0042_0010l, ("Document Title", "DocumentTitle", `ST, `One, false);
0x0042_0011l, ("Encapsulated Document", "EncapsulatedDocument", `OB, `One, false);
0x0042_0012l, ("MIME Type of Encapsulated Document", "MIMETypeOfEncapsulatedDocument", `LO, `One, false);
0x0042_0013l, ("Source Instance Sequence", "SourceInstanceSequence", `SQ, `One, false);
0x0042_0014l, ("List of MIME Types", "ListOfMIMETypes", `LO, `One_n, false);
0x0044_0001l, ("Product Package Identifier", "ProductPackageIdentifier", `ST, `One, false);
0x0044_0002l, ("Substance Administration Approval", "SubstanceAdministrationApproval", `CS, `One, false);
0x0044_0003l, ("Approval Status Further Description", "ApprovalStatusFurtherDescription", `LT, `One, false);
0x0044_0004l, ("Approval Status DateTime", "ApprovalStatusDateTime", `DT, `One, false);
0x0044_0007l, ("Product Type Code Sequence", "ProductTypeCodeSequence", `SQ, `One, false);
0x0044_0008l, ("Product Name", "ProductName", `LO, `One_n, false);
0x0044_0009l, ("Product Description", "ProductDescription", `LT, `One, false);
0x0044_000Al, ("Product Lot Identifier", "ProductLotIdentifier", `LO, `One, false);
0x0044_000Bl, ("Product Expiration DateTime", "ProductExpirationDateTime", `DT, `One, false);
0x0044_0010l, ("Substance Administration DateTime", "SubstanceAdministrationDateTime", `DT, `One, false);
0x0044_0011l, ("Substance Administration Notes", "SubstanceAdministrationNotes", `LO, `One, false);
0x0044_0012l, ("Substance Administration Device ID", "SubstanceAdministrationDeviceID", `LO, `One, false);
0x0044_0013l, ("Product Parameter Sequence", "ProductParameterSequence", `SQ, `One, false);
0x0044_0019l, ("Substance Administration Parameter Sequence", "SubstanceAdministrationParameterSequence", `SQ, `One, false);
0x0046_0012l, ("Lens Description", "LensDescription", `LO, `One, false);
0x0046_0014l, ("Right Lens Sequence", "RightLensSequence", `SQ, `One, false);
0x0046_0015l, ("Left Lens Sequence", "LeftLensSequence", `SQ, `One, false);
0x0046_0016l, ("Unspecified Laterality Lens Sequence", "UnspecifiedLateralityLensSequence", `SQ, `One, false);
0x0046_0018l, ("Cylinder Sequence", "CylinderSequence", `SQ, `One, false);
0x0046_0028l, ("Prism Sequence", "PrismSequence", `SQ, `One, false);
0x0046_0030l, ("Horizontal Prism Power", "HorizontalPrismPower", `FD, `One, false);
0x0046_0032l, ("Horizontal Prism Base", "HorizontalPrismBase", `CS, `One, false);
0x0046_0034l, ("Vertical Prism Power", "VerticalPrismPower", `FD, `One, false);
0x0046_0036l, ("Vertical Prism Base", "VerticalPrismBase", `CS, `One, false);
0x0046_0038l, ("Lens Segment Type", "LensSegmentType", `CS, `One, false);
0x0046_0040l, ("Optical Transmittance", "OpticalTransmittance", `FD, `One, false);
0x0046_0042l, ("Channel Width", "ChannelWidth", `FD, `One, false);
0x0046_0044l, ("Pupil Size", "PupilSize", `FD, `One, false);
0x0046_0046l, ("Corneal Size", "CornealSize", `FD, `One, false);
0x0046_0050l, ("Autorefraction Right Eye Sequence", "AutorefractionRightEyeSequence", `SQ, `One, false);
0x0046_0052l, ("Autorefraction Left Eye Sequence", "AutorefractionLeftEyeSequence", `SQ, `One, false);
0x0046_0060l, ("Distance Pupillary Distance", "DistancePupillaryDistance", `FD, `One, false);
0x0046_0062l, ("Near Pupillary Distance", "NearPupillaryDistance", `FD, `One, false);
0x0046_0063l, ("Intermediate Pupillary Distance", "IntermediatePupillaryDistance", `FD, `One, false);
0x0046_0064l, ("Other Pupillary Distance", "OtherPupillaryDistance", `FD, `One, false);
0x0046_0070l, ("Keratometry Right Eye Sequence", "KeratometryRightEyeSequence", `SQ, `One, false);
0x0046_0071l, ("Keratometry Left Eye Sequence", "KeratometryLeftEyeSequence", `SQ, `One, false);
0x0046_0074l, ("Steep Keratometric Axis Sequence", "SteepKeratometricAxisSequence", `SQ, `One, false);
0x0046_0075l, ("Radius of Curvature", "RadiusOfCurvature", `FD, `One, false);
0x0046_0076l, ("Keratometric Power", "KeratometricPower", `FD, `One, false);
0x0046_0077l, ("Keratometric Axis", "KeratometricAxis", `FD, `One, false);
0x0046_0080l, ("Flat Keratometric Axis Sequence", "FlatKeratometricAxisSequence", `SQ, `One, false);
0x0046_0092l, ("Background Color", "BackgroundColor", `CS, `One, false);
0x0046_0094l, ("Optotype", "Optotype", `CS, `One, false);
0x0046_0095l, ("Optotype Presentation", "OptotypePresentation", `CS, `One, false);
0x0046_0097l, ("Subjective Refraction Right Eye Sequence", "SubjectiveRefractionRightEyeSequence", `SQ, `One, false);
0x0046_0098l, ("Subjective Refraction Left Eye Sequence", "SubjectiveRefractionLeftEyeSequence", `SQ, `One, false);
0x0046_0100l, ("Add Near Sequence", "AddNearSequence", `SQ, `One, false);
0x0046_0101l, ("Add Intermediate Sequence", "AddIntermediateSequence", `SQ, `One, false);
0x0046_0102l, ("Add Other Sequence", "AddOtherSequence", `SQ, `One, false);
0x0046_0104l, ("Add Power", "AddPower", `FD, `One, false);
0x0046_0106l, ("Viewing Distance", "ViewingDistance", `FD, `One, false);
0x0046_0121l, ("Visual Acuity Type Code Sequence", "VisualAcuityTypeCodeSequence", `SQ, `One, false);
0x0046_0122l, ("Visual Acuity Right Eye Sequence", "VisualAcuityRightEyeSequence", `SQ, `One, false);
0x0046_0123l, ("Visual Acuity Left Eye Sequence", "VisualAcuityLeftEyeSequence", `SQ, `One, false);
0x0046_0124l, ("Visual Acuity Both Eyes Open Sequence", "VisualAcuityBothEyesOpenSequence", `SQ, `One, false);
0x0046_0125l, ("Viewing Distance Type", "ViewingDistanceType", `CS, `One, false);
0x0046_0135l, ("Visual Acuity Modifiers", "VisualAcuityModifiers", `SS, `Two, false);
0x0046_0137l, ("Decimal Visual Acuity", "DecimalVisualAcuity", `FD, `One, false);
0x0046_0139l, ("Optotype Detailed Definition", "OptotypeDetailedDefinition", `LO, `One, false);
0x0046_0145l, ("Referenced Refractive Measurements Sequence", "ReferencedRefractiveMeasurementsSequence", `SQ, `One, false);
0x0046_0146l, ("Sphere Power", "SpherePower", `FD, `One, false);
0x0046_0147l, ("Cylinder Power", "CylinderPower", `FD, `One, false);
0x0048_0001l, ("Imaged Volume Width", "ImagedVolumeWidth", `FL, `One, false);
0x0048_0002l, ("Imaged Volume Height", "ImagedVolumeHeight", `FL, `One, false);
0x0048_0003l, ("Imaged Volume Depth", "ImagedVolumeDepth", `FL, `One, false);
0x0048_0006l, ("Total Pixel Matrix Columns", "TotalPixelMatrixColumns", `UL, `One, false);
0x0048_0007l, ("Total Pixel Matrix Rows", "TotalPixelMatrixRows", `UL, `One, false);
0x0048_0008l, ("Total Pixel Matrix Origin Sequence", "TotalPixelMatrixOriginSequence", `SQ, `One, false);
0x0048_0010l, ("Specimen Label in Image", "SpecimenLabelInImage", `CS, `One, false);
0x0048_0011l, ("Focus Method", "FocusMethod", `CS, `One, false);
0x0048_0012l, ("Extended Depth of Field", "ExtendedDepthOfField", `CS, `One, false);
0x0048_0013l, ("Number of Focal Planes", "NumberOfFocalPlanes", `US, `One, false);
0x0048_0014l, ("Distance Between Focal Planes", "DistanceBetweenFocalPlanes", `FL, `One, false);
0x0048_0015l, ("Recommended Absent Pixel CIELab Value", "RecommendedAbsentPixelCIELabValue", `US, `Three, false);
0x0048_0100l, ("Illuminator Type Code Sequence", "IlluminatorTypeCodeSequence", `SQ, `One, false);
0x0048_0102l, ("Image Orientation (Slide)", "ImageOrientationSlide", `DS, `Six, false);
0x0048_0105l, ("Optical Path Sequence", "OpticalPathSequence", `SQ, `One, false);
0x0048_0106l, ("Optical Path Identifier", "OpticalPathIdentifier", `SH, `One, false);
0x0048_0107l, ("Optical Path Description", "OpticalPathDescription", `ST, `One, false);
0x0048_0108l, ("Illumination Color Code Sequence", "IlluminationColorCodeSequence", `SQ, `One, false);
0x0048_0110l, ("Specimen Reference Sequence", "SpecimenReferenceSequence", `SQ, `One, false);
0x0048_0111l, ("Condenser Lens Power", "CondenserLensPower", `DS, `One, false);
0x0048_0112l, ("Objective Lens Power", "ObjectiveLensPower", `DS, `One, false);
0x0048_0113l, ("Objective Lens Numerical Aperture", "ObjectiveLensNumericalAperture", `DS, `One, false);
0x0048_0120l, ("Palette Color Lookup Table Sequence", "PaletteColorLookupTableSequence", `SQ, `One, false);
0x0048_0200l, ("Referenced Image Navigation Sequence", "ReferencedImageNavigationSequence", `SQ, `One, false);
0x0048_0201l, ("Top Left Hand Corner of Localizer Area", "TopLeftHandCornerOfLocalizerArea", `US, `Two, false);
0x0048_0202l, ("Bottom Right Hand Corner of Localizer Area", "BottomRightHandCornerOfLocalizerArea", `US, `Two, false);
0x0048_0207l, ("Optical Path Identification Sequence", "OpticalPathIdentificationSequence", `SQ, `One, false);
0x0048_021Al, ("Plane Position (Slide) Sequence", "PlanePositionSlideSequence", `SQ, `One, false);
0x0048_021El, ("Row Position In Total Image Pixel Matrix", "RowPositionInTotalImagePixelMatrix", `SL, `One, false);
0x0048_021Fl, ("Column Position In Total Image Pixel Matrix", "ColumnPositionInTotalImagePixelMatrix", `SL, `One, false);
0x0048_0301l, ("Pixel Origin Interpretation", "PixelOriginInterpretation", `CS, `One, false);
0x0050_0004l, ("Calibration Image", "CalibrationImage", `CS, `One, false);
0x0050_0010l, ("Device Sequence", "DeviceSequence", `SQ, `One, false);
0x0050_0012l, ("Container Component Type Code Sequence", "ContainerComponentTypeCodeSequence", `SQ, `One, false);
0x0050_0013l, ("Container Component Thickness", "ContainerComponentThickness", `FD, `One, false);
0x0050_0014l, ("Device Length", "DeviceLength", `DS, `One, false);
0x0050_0015l, ("Container Component Width", "ContainerComponentWidth", `FD, `One, false);
0x0050_0016l, ("Device Diameter", "DeviceDiameter", `DS, `One, false);
0x0050_0017l, ("Device Diameter Units", "DeviceDiameterUnits", `CS, `One, false);
0x0050_0018l, ("Device Volume", "DeviceVolume", `DS, `One, false);
0x0050_0019l, ("Inter-Marker Distance", "InterMarkerDistance", `DS, `One, false);
0x0050_001Al, ("Container Component Material", "ContainerComponentMaterial", `CS, `One, false);
0x0050_001Bl, ("Container Component ID", "ContainerComponentID", `LO, `One, false);
0x0050_001Cl, ("Container Component Length", "ContainerComponentLength", `FD, `One, false);
0x0050_001Dl, ("Container Component Diameter", "ContainerComponentDiameter", `FD, `One, false);
0x0050_001El, ("Container Component Description", "ContainerComponentDescription", `LO, `One, false);
0x0050_0020l, ("Device Description", "DeviceDescription", `LO, `One, false);
0x0052_0001l, ("Contrast/Bolus Ingredient Percent by Volume", "ContrastBolusIngredientPercentByVolume", `FL, `One, false);
0x0052_0002l, ("OCT Focal Distance", "OCTFocalDistance", `FD, `One, false);
0x0052_0003l, ("Beam Spot Size", "BeamSpotSize", `FD, `One, false);
0x0052_0004l, ("Effective Refractive Index", "EffectiveRefractiveIndex", `FD, `One, false);
0x0052_0006l, ("OCT Acquisition Domain", "OCTAcquisitionDomain", `CS, `One, false);
0x0052_0007l, ("OCT Optical Center Wavelength", "OCTOpticalCenterWavelength", `FD, `One, false);
0x0052_0008l, ("Axial Resolution", "AxialResolution", `FD, `One, false);
0x0052_0009l, ("Ranging Depth", "RangingDepth", `FD, `One, false);
0x0052_0011l, ("A-line Rate", "ALineRate", `FD, `One, false);
0x0052_0012l, ("A-lines Per Frame", "ALinesPerFrame", `US, `One, false);
0x0052_0013l, ("Catheter Rotational Rate", "CatheterRotationalRate", `FD, `One, false);
0x0052_0014l, ("A-line Pixel Spacing", "ALinePixelSpacing", `FD, `One, false);
0x0052_0016l, ("Mode of Percutaneous Access Sequence", "ModeOfPercutaneousAccessSequence", `SQ, `One, false);
0x0052_0025l, ("Intravascular OCT Frame Type Sequence", "IntravascularOCTFrameTypeSequence", `SQ, `One, false);
0x0052_0026l, ("OCT Z Offset Applied", "OCTZOffsetApplied", `CS, `One, false);
0x0052_0027l, ("Intravascular Frame Content Sequence", "IntravascularFrameContentSequence", `SQ, `One, false);
0x0052_0028l, ("Intravascular Longitudinal Distance", "IntravascularLongitudinalDistance", `FD, `One, false);
0x0052_0029l, ("Intravascular OCT Frame Content Sequence", "IntravascularOCTFrameContentSequence", `SQ, `One, false);
0x0052_0030l, ("OCT Z Offset Correction", "OCTZOffsetCorrection", `SS, `One, false);
0x0052_0031l, ("Catheter Direction of Rotation", "CatheterDirectionOfRotation", `CS, `One, false);
0x0052_0033l, ("Seam Line Location", "SeamLineLocation", `FD, `One, false);
0x0052_0034l, ("First A-line Location", "FirstALineLocation", `FD, `One, false);
0x0052_0036l, ("Seam Line Index", "SeamLineIndex", `US, `One, false);
0x0052_0038l, ("Number of Padded A-lines", "NumberOfPaddedAlines", `US, `One, false);
0x0052_0039l, ("Interpolation Type", "InterpolationType", `CS, `One, false);
0x0052_003Al, ("Refractive Index Applied", "RefractiveIndexApplied", `CS, `One, false);
0x0054_0010l, ("Energy Window Vector", "EnergyWindowVector", `US, `One_n, false);
0x0054_0011l, ("Number of Energy Windows", "NumberOfEnergyWindows", `US, `One, false);
0x0054_0012l, ("Energy Window Information Sequence", "EnergyWindowInformationSequence", `SQ, `One, false);
0x0054_0013l, ("Energy Window Range Sequence", "EnergyWindowRangeSequence", `SQ, `One, false);
0x0054_0014l, ("Energy Window Lower Limit", "EnergyWindowLowerLimit", `DS, `One, false);
0x0054_0015l, ("Energy Window Upper Limit", "EnergyWindowUpperLimit", `DS, `One, false);
0x0054_0016l, ("Radiopharmaceutical Information Sequence", "RadiopharmaceuticalInformationSequence", `SQ, `One, false);
0x0054_0017l, ("Residual Syringe Counts", "ResidualSyringeCounts", `IS, `One, false);
0x0054_0018l, ("Energy Window Name", "EnergyWindowName", `SH, `One, false);
0x0054_0020l, ("Detector Vector", "DetectorVector", `US, `One_n, false);
0x0054_0021l, ("Number of Detectors", "NumberOfDetectors", `US, `One, false);
0x0054_0022l, ("Detector Information Sequence", "DetectorInformationSequence", `SQ, `One, false);
0x0054_0030l, ("Phase Vector", "PhaseVector", `US, `One_n, false);
0x0054_0031l, ("Number of Phases", "NumberOfPhases", `US, `One, false);
0x0054_0032l, ("Phase Information Sequence", "PhaseInformationSequence", `SQ, `One, false);
0x0054_0033l, ("Number of Frames in Phase", "NumberOfFramesInPhase", `US, `One, false);
0x0054_0036l, ("Phase Delay", "PhaseDelay", `IS, `One, false);
0x0054_0038l, ("Pause Between Frames", "PauseBetweenFrames", `IS, `One, false);
0x0054_0039l, ("Phase Description", "PhaseDescription", `CS, `One, false);
0x0054_0050l, ("Rotation Vector", "RotationVector", `US, `One_n, false);
0x0054_0051l, ("Number of Rotations", "NumberOfRotations", `US, `One, false);
0x0054_0052l, ("Rotation Information Sequence", "RotationInformationSequence", `SQ, `One, false);
0x0054_0053l, ("Number of Frames in Rotation", "NumberOfFramesInRotation", `US, `One, false);
0x0054_0060l, ("R-R Interval Vector", "RRIntervalVector", `US, `One_n, false);
0x0054_0061l, ("Number of R-R Intervals", "NumberOfRRIntervals", `US, `One, false);
0x0054_0062l, ("Gated Information Sequence", "GatedInformationSequence", `SQ, `One, false);
0x0054_0063l, ("Data Information Sequence", "DataInformationSequence", `SQ, `One, false);
0x0054_0070l, ("Time Slot Vector", "TimeSlotVector", `US, `One_n, false);
0x0054_0071l, ("Number of Time Slots", "NumberOfTimeSlots", `US, `One, false);
0x0054_0072l, ("Time Slot Information Sequence", "TimeSlotInformationSequence", `SQ, `One, false);
0x0054_0073l, ("Time Slot Time", "TimeSlotTime", `DS, `One, false);
0x0054_0080l, ("Slice Vector", "SliceVector", `US, `One_n, false);
0x0054_0081l, ("Number of Slices", "NumberOfSlices", `US, `One, false);
0x0054_0090l, ("Angular View Vector", "AngularViewVector", `US, `One_n, false);
0x0054_0100l, ("Time Slice Vector", "TimeSliceVector", `US, `One_n, false);
0x0054_0101l, ("Number of Time Slices", "NumberOfTimeSlices", `US, `One, false);
0x0054_0200l, ("Start Angle", "StartAngle", `DS, `One, false);
0x0054_0202l, ("Type of Detector Motion", "TypeOfDetectorMotion", `CS, `One, false);
0x0054_0210l, ("Trigger Vector", "TriggerVector", `IS, `One_n, false);
0x0054_0211l, ("Number of Triggers in Phase", "NumberOfTriggersInPhase", `US, `One, false);
0x0054_0220l, ("View Code Sequence", "ViewCodeSequence", `SQ, `One, false);
0x0054_0222l, ("View Modifier Code Sequence", "ViewModifierCodeSequence", `SQ, `One, false);
0x0054_0300l, ("Radionuclide Code Sequence", "RadionuclideCodeSequence", `SQ, `One, false);
0x0054_0302l, ("Administration Route Code Sequence", "AdministrationRouteCodeSequence", `SQ, `One, false);
0x0054_0304l, ("Radiopharmaceutical Code Sequence", "RadiopharmaceuticalCodeSequence", `SQ, `One, false);
0x0054_0306l, ("Calibration Data Sequence", "CalibrationDataSequence", `SQ, `One, false);
0x0054_0308l, ("Energy Window Number", "EnergyWindowNumber", `US, `One, false);
0x0054_0400l, ("Image ID", "ImageID", `SH, `One, false);
0x0054_0410l, ("Patient Orientation Code Sequence", "PatientOrientationCodeSequence", `SQ, `One, false);
0x0054_0412l, ("Patient Orientation Modifier Code Sequence", "PatientOrientationModifierCodeSequence", `SQ, `One, false);
0x0054_0414l, ("Patient Gantry Relationship Code Sequence", "PatientGantryRelationshipCodeSequence", `SQ, `One, false);
0x0054_0500l, ("Slice Progression Direction", "SliceProgressionDirection", `CS, `One, false);
0x0054_1000l, ("Series Type", "SeriesType", `CS, `Two, false);
0x0054_1001l, ("Units", "Units", `CS, `One, false);
0x0054_1002l, ("Counts Source", "CountsSource", `CS, `One, false);
0x0054_1004l, ("Reprojection Method", "ReprojectionMethod", `CS, `One, false);
0x0054_1006l, ("SUV Type", "SUVType", `CS, `One, false);
0x0054_1100l, ("Randoms Correction Method", "RandomsCorrectionMethod", `CS, `One, false);
0x0054_1101l, ("Attenuation Correction Method", "AttenuationCorrectionMethod", `LO, `One, false);
0x0054_1102l, ("Decay Correction", "DecayCorrection", `CS, `One, false);
0x0054_1103l, ("Reconstruction Method", "ReconstructionMethod", `LO, `One, false);
0x0054_1104l, ("Detector Lines of Response Used", "DetectorLinesOfResponseUsed", `LO, `One, false);
0x0054_1105l, ("Scatter Correction Method", "ScatterCorrectionMethod", `LO, `One, false);
0x0054_1200l, ("Axial Acceptance", "AxialAcceptance", `DS, `One, false);
0x0054_1201l, ("Axial Mash", "AxialMash", `IS, `Two, false);
0x0054_1202l, ("Transverse Mash", "TransverseMash", `IS, `One, false);
0x0054_1203l, ("Detector Element Size", "DetectorElementSize", `DS, `Two, false);
0x0054_1210l, ("Coincidence Window Width", "CoincidenceWindowWidth", `DS, `One, false);
0x0054_1220l, ("Secondary Counts Type", "SecondaryCountsType", `CS, `One_n, false);
0x0054_1300l, ("Frame Reference Time", "FrameReferenceTime", `DS, `One, false);
0x0054_1310l, ("Primary (Prompts) Counts Accumulated", "PrimaryPromptsCountsAccumulated", `IS, `One, false);
0x0054_1311l, ("Secondary Counts Accumulated", "SecondaryCountsAccumulated", `IS, `One_n, false);
0x0054_1320l, ("Slice Sensitivity Factor", "SliceSensitivityFactor", `DS, `One, false);
0x0054_1321l, ("Decay Factor", "DecayFactor", `DS, `One, false);
0x0054_1322l, ("Dose Calibration Factor", "DoseCalibrationFactor", `DS, `One, false);
0x0054_1323l, ("Scatter Fraction Factor", "ScatterFractionFactor", `DS, `One, false);
0x0054_1324l, ("Dead Time Factor", "DeadTimeFactor", `DS, `One, false);
0x0054_1330l, ("Image Index", "ImageIndex", `US, `One, false);
0x0054_1400l, ("Counts Included", "CountsIncluded", `CS, `One_n, true);
0x0054_1401l, ("Dead Time Correction Flag", "DeadTimeCorrectionFlag", `CS, `One, true);
0x0060_3000l, ("Histogram Sequence", "HistogramSequence", `SQ, `One, false);
0x0060_3002l, ("Histogram Number of Bins", "HistogramNumberOfBins", `US, `One, false);
0x0060_3004l, ("Histogram First Bin Value", "HistogramFirstBinValue", `US_or_SS, `One, false);
0x0060_3006l, ("Histogram Last Bin Value", "HistogramLastBinValue", `US_or_SS, `One, false);
0x0060_3008l, ("Histogram Bin Width", "HistogramBinWidth", `US, `One, false);
0x0060_3010l, ("Histogram Explanation", "HistogramExplanation", `LO, `One, false);
0x0060_3020l, ("Histogram Data", "HistogramData", `UL, `One_n, false);
0x0062_0001l, ("Segmentation Type", "SegmentationType", `CS, `One, false);
0x0062_0002l, ("Segment Sequence", "SegmentSequence", `SQ, `One, false);
0x0062_0003l, ("Segmented Property Category Code Sequence", "SegmentedPropertyCategoryCodeSequence", `SQ, `One, false);
0x0062_0004l, ("Segment Number", "SegmentNumber", `US, `One, false);
0x0062_0005l, ("Segment Label", "SegmentLabel", `LO, `One, false);
0x0062_0006l, ("Segment Description", "SegmentDescription", `ST, `One, false);
0x0062_0008l, ("Segment Algorithm Type", "SegmentAlgorithmType", `CS, `One, false);
0x0062_0009l, ("Segment Algorithm Name", "SegmentAlgorithmName", `LO, `One, false);
0x0062_000Al, ("Segment Identification Sequence", "SegmentIdentificationSequence", `SQ, `One, false);
0x0062_000Bl, ("Referenced Segment Number", "ReferencedSegmentNumber", `US, `One_n, false);
0x0062_000Cl, ("Recommended Display Grayscale Value", "RecommendedDisplayGrayscaleValue", `US, `One, false);
0x0062_000Dl, ("Recommended Display CIELab Value", "RecommendedDisplayCIELabValue", `US, `Three, false);
0x0062_000El, ("Maximum Fractional Value", "MaximumFractionalValue", `US, `One, false);
0x0062_000Fl, ("Segmented Property Type Code Sequence", "SegmentedPropertyTypeCodeSequence", `SQ, `One, false);
0x0062_0010l, ("Segmentation Fractional Type", "SegmentationFractionalType", `CS, `One, false);
0x0064_0002l, ("Deformable Registration Sequence", "DeformableRegistrationSequence", `SQ, `One, false);
0x0064_0003l, ("Source Frame of Reference UID", "SourceFrameOfReferenceUID", `UI, `One, false);
0x0064_0005l, ("Deformable Registration Grid Sequence", "DeformableRegistrationGridSequence", `SQ, `One, false);
0x0064_0007l, ("Grid Dimensions", "GridDimensions", `UL, `Three, false);
0x0064_0008l, ("Grid Resolution", "GridResolution", `FD, `Three, false);
0x0064_0009l, ("Vector Grid Data", "VectorGridData", `OF, `One, false);
0x0064_000Fl, ("Pre Deformation Matrix Registration Sequence", "PreDeformationMatrixRegistrationSequence", `SQ, `One, false);
0x0064_0010l, ("Post Deformation Matrix Registration Sequence", "PostDeformationMatrixRegistrationSequence", `SQ, `One, false);
0x0066_0001l, ("Number of Surfaces", "NumberOfSurfaces", `UL, `One, false);
0x0066_0002l, ("Surface Sequence", "SurfaceSequence", `SQ, `One, false);
0x0066_0003l, ("Surface Number", "SurfaceNumber", `UL, `One, false);
0x0066_0004l, ("Surface Comments", "SurfaceComments", `LT, `One, false);
0x0066_0009l, ("Surface Processing", "SurfaceProcessing", `CS, `One, false);
0x0066_000Al, ("Surface Processing Ratio", "SurfaceProcessingRatio", `FL, `One, false);
0x0066_000Bl, ("Surface Processing Description", "SurfaceProcessingDescription", `LO, `One, false);
0x0066_000Cl, ("Recommended Presentation Opacity", "RecommendedPresentationOpacity", `FL, `One, false);
0x0066_000Dl, ("Recommended Presentation Type", "RecommendedPresentationType", `CS, `One, false);
0x0066_000El, ("Finite Volume", "FiniteVolume", `CS, `One, false);
0x0066_0010l, ("Manifold", "Manifold", `CS, `One, false);
0x0066_0011l, ("Surface Points Sequence", "SurfacePointsSequence", `SQ, `One, false);
0x0066_0012l, ("Surface Points Normals Sequence", "SurfacePointsNormalsSequence", `SQ, `One, false);
0x0066_0013l, ("Surface Mesh Primitives Sequence", "SurfaceMeshPrimitivesSequence", `SQ, `One, false);
0x0066_0015l, ("Number of Surface Points", "NumberOfSurfacePoints", `UL, `One, false);
0x0066_0016l, ("Point Coordinates Data", "PointCoordinatesData", `OF, `One, false);
0x0066_0017l, ("Point Position Accuracy", "PointPositionAccuracy", `FL, `Three, false);
0x0066_0018l, ("Mean Point Distance", "MeanPointDistance", `FL, `One, false);
0x0066_0019l, ("Maximum Point Distance", "MaximumPointDistance", `FL, `One, false);
0x0066_001Al, ("Points Bounding Box Coordinates", "PointsBoundingBoxCoordinates", `FL, `Six, false);
0x0066_001Bl, ("Axis of Rotation", "AxisOfRotation", `FL, `Three, false);
0x0066_001Cl, ("Center of Rotation", "CenterOfRotation", `FL, `Three, false);
0x0066_001El, ("Number of Vectors", "NumberOfVectors", `UL, `One, false);
0x0066_001Fl, ("Vector Dimensionality", "VectorDimensionality", `US, `One, false);
0x0066_0020l, ("Vector Accuracy", "VectorAccuracy", `FL, `One_n, false);
0x0066_0021l, ("Vector Coordinate Data", "VectorCoordinateData", `OF, `One, false);
0x0066_0023l, ("Triangle Point Index List", "TrianglePointIndexList", `OW, `One, false);
0x0066_0024l, ("Edge Point Index List", "EdgePointIndexList", `OW, `One, false);
0x0066_0025l, ("Vertex Point Index List", "VertexPointIndexList", `OW, `One, false);
0x0066_0026l, ("Triangle Strip Sequence", "TriangleStripSequence", `SQ, `One, false);
0x0066_0027l, ("Triangle Fan Sequence", "TriangleFanSequence", `SQ, `One, false);
0x0066_0028l, ("Line Sequence", "LineSequence", `SQ, `One, false);
0x0066_0029l, ("Primitive Point Index List", "PrimitivePointIndexList", `OW, `One, false);
0x0066_002Al, ("Surface Count", "SurfaceCount", `UL, `One, false);
0x0066_002Bl, ("Referenced Surface Sequence", "ReferencedSurfaceSequence", `SQ, `One, false);
0x0066_002Cl, ("Referenced Surface Number", "ReferencedSurfaceNumber", `UL, `One, false);
0x0066_002Dl, ("Segment Surface Generation Algorithm Identification Sequence", "SegmentSurfaceGenerationAlgorithmIdentificationSequence", `SQ, `One, false);
0x0066_002El, ("Segment Surface Source Instance Sequence", "SegmentSurfaceSourceInstanceSequence", `SQ, `One, false);
0x0066_002Fl, ("Algorithm Family Code Sequence", "AlgorithmFamilyCodeSequence", `SQ, `One, false);
0x0066_0030l, ("Algorithm Name Code Sequence", "AlgorithmNameCodeSequence", `SQ, `One, false);
0x0066_0031l, ("Algorithm Version", "AlgorithmVersion", `LO, `One, false);
0x0066_0032l, ("Algorithm Parameters", "AlgorithmParameters", `LT, `One, false);
0x0066_0034l, ("Facet Sequence", "FacetSequence", `SQ, `One, false);
0x0066_0035l, ("Surface Processing Algorithm Identification Sequence", "SurfaceProcessingAlgorithmIdentificationSequence", `SQ, `One, false);
0x0066_0036l, ("Algorithm Name", "AlgorithmName", `LO, `One, false);
0x0068_6210l, ("Implant Size", "ImplantSize", `LO, `One, false);
0x0068_6221l, ("Implant Template Version", "ImplantTemplateVersion", `LO, `One, false);
0x0068_6222l, ("Replaced Implant Template Sequence", "ReplacedImplantTemplateSequence", `SQ, `One, false);
0x0068_6223l, ("Implant Type", "ImplantType", `CS, `One, false);
0x0068_6224l, ("Derivation Implant Template Sequence", "DerivationImplantTemplateSequence", `SQ, `One, false);
0x0068_6225l, ("Original Implant Template Sequence", "OriginalImplantTemplateSequence", `SQ, `One, false);
0x0068_6226l, ("Effective DateTime", "EffectiveDateTime", `DT, `One, false);
0x0068_6230l, ("Implant Target Anatomy Sequence", "ImplantTargetAnatomySequence", `SQ, `One, false);
0x0068_6260l, ("Information From Manufacturer Sequence", "InformationFromManufacturerSequence", `SQ, `One, false);
0x0068_6265l, ("Notification From Manufacturer Sequence", "NotificationFromManufacturerSequence", `SQ, `One, false);
0x0068_6270l, ("Information Issue DateTime", "InformationIssueDateTime", `DT, `One, false);
0x0068_6280l, ("Information Summary", "InformationSummary", `ST, `One, false);
0x0068_62A0l, ("Implant Regulatory Disapproval Code Sequence", "ImplantRegulatoryDisapprovalCodeSequence", `SQ, `One, false);
0x0068_62A5l, ("Overall Template Spatial Tolerance", "OverallTemplateSpatialTolerance", `FD, `One, false);
0x0068_62C0l, ("HPGL Document Sequence", "HPGLDocumentSequence", `SQ, `One, false);
0x0068_62D0l, ("HPGL Document ID", "HPGLDocumentID", `US, `One, false);
0x0068_62D5l, ("HPGL Document Label", "HPGLDocumentLabel", `LO, `One, false);
0x0068_62E0l, ("View Orientation Code Sequence", "ViewOrientationCodeSequence", `SQ, `One, false);
0x0068_62F0l, ("View Orientation Modifier", "ViewOrientationModifier", `FD, `Nine, false);
0x0068_62F2l, ("HPGL Document Scaling", "HPGLDocumentScaling", `FD, `One, false);
0x0068_6300l, ("HPGL Document", "HPGLDocument", `OB, `One, false);
0x0068_6310l, ("HPGL Contour Pen Number", "HPGLContourPenNumber", `US, `One, false);
0x0068_6320l, ("HPGL Pen Sequence", "HPGLPenSequence", `SQ, `One, false);
0x0068_6330l, ("HPGL Pen Number", "HPGLPenNumber", `US, `One, false);
0x0068_6340l, ("HPGL Pen Label", "HPGLPenLabel", `LO, `One, false);
0x0068_6345l, ("HPGL Pen Description", "HPGLPenDescription", `ST, `One, false);
0x0068_6346l, ("Recommended Rotation Point", "RecommendedRotationPoint", `FD, `Two, false);
0x0068_6347l, ("Bounding Rectangle", "BoundingRectangle", `FD, `Four, false);
0x0068_6350l, ("Implant Template 3D Model Surface Number", "ImplantTemplate3DModelSurfaceNumber", `US, `One_n, false);
0x0068_6360l, ("Surface Model Description Sequence", "SurfaceModelDescriptionSequence", `SQ, `One, false);
0x0068_6380l, ("Surface Model Label", "SurfaceModelLabel", `LO, `One, false);
0x0068_6390l, ("Surface Model Scaling Factor", "SurfaceModelScalingFactor", `FD, `One, false);
0x0068_63A0l, ("Materials Code Sequence", "MaterialsCodeSequence", `SQ, `One, false);
0x0068_63A4l, ("Coating Materials Code Sequence", "CoatingMaterialsCodeSequence", `SQ, `One, false);
0x0068_63A8l, ("Implant Type Code Sequence", "ImplantTypeCodeSequence", `SQ, `One, false);
0x0068_63ACl, ("Fixation Method Code Sequence", "FixationMethodCodeSequence", `SQ, `One, false);
0x0068_63B0l, ("Mating Feature Sets Sequence", "MatingFeatureSetsSequence", `SQ, `One, false);
0x0068_63C0l, ("Mating Feature Set ID", "MatingFeatureSetID", `US, `One, false);
0x0068_63D0l, ("Mating Feature Set Label", "MatingFeatureSetLabel", `LO, `One, false);
0x0068_63E0l, ("Mating Feature Sequence", "MatingFeatureSequence", `SQ, `One, false);
0x0068_63F0l, ("Mating Feature ID", "MatingFeatureID", `US, `One, false);
0x0068_6400l, ("Mating Feature Degree of Freedom Sequence", "MatingFeatureDegreeOfFreedomSequence", `SQ, `One, false);
0x0068_6410l, ("Degree of Freedom ID", "DegreeOfFreedomID", `US, `One, false);
0x0068_6420l, ("Degree of Freedom Type", "DegreeOfFreedomType", `CS, `One, false);
0x0068_6430l, ("2D Mating Feature Coordinates Sequence", "TwoDMatingFeatureCoordinatesSequence", `SQ, `One, false);
0x0068_6440l, ("Referenced HPGL Document ID", "ReferencedHPGLDocumentID", `US, `One, false);
0x0068_6450l, ("2D Mating Point", "TwoDMatingPoint", `FD, `Two, false);
0x0068_6460l, ("2D Mating Axes", "TwoDMatingAxes", `FD, `Four, false);
0x0068_6470l, ("2D Degree of Freedom Sequence", "TwoDDegreeOfFreedomSequence", `SQ, `One, false);
0x0068_6490l, ("3D Degree of Freedom Axis", "ThreeDDegreeOfFreedomAxis", `FD, `Three, false);
0x0068_64A0l, ("Range of Freedom", "RangeOfFreedom", `FD, `Two, false);
0x0068_64C0l, ("3D Mating Point", "ThreeDMatingPoint", `FD, `Three, false);
0x0068_64D0l, ("3D Mating Axes", "ThreeDMatingAxes", `FD, `Nine, false);
0x0068_64F0l, ("2D Degree of Freedom Axis", "TwoDDegreeOfFreedomAxis", `FD, `Three, false);
0x0068_6500l, ("Planning Landmark Point Sequence", "PlanningLandmarkPointSequence", `SQ, `One, false);
0x0068_6510l, ("Planning Landmark Line Sequence", "PlanningLandmarkLineSequence", `SQ, `One, false);
0x0068_6520l, ("Planning Landmark Plane Sequence", "PlanningLandmarkPlaneSequence", `SQ, `One, false);
0x0068_6530l, ("Planning Landmark ID", "PlanningLandmarkID", `US, `One, false);
0x0068_6540l, ("Planning Landmark Description", "PlanningLandmarkDescription", `LO, `One, false);
0x0068_6545l, ("Planning Landmark Identification Code Sequence", "PlanningLandmarkIdentificationCodeSequence", `SQ, `One, false);
0x0068_6550l, ("2D Point Coordinates Sequence", "TwoDPointCoordinatesSequence", `SQ, `One, false);
0x0068_6560l, ("2D Point Coordinates", "TwoDPointCoordinates", `FD, `Two, false);
0x0068_6590l, ("3D Point Coordinates", "ThreeDPointCoordinates", `FD, `Three, false);
0x0068_65A0l, ("2D Line Coordinates Sequence", "TwoDLineCoordinatesSequence", `SQ, `One, false);
0x0068_65B0l, ("2D Line Coordinates", "TwoDLineCoordinates", `FD, `Four, false);
0x0068_65D0l, ("3D Line Coordinates", "ThreeDLineCoordinates", `FD, `Six, false);
0x0068_65E0l, ("2D Plane Coordinates Sequence", "TwoDPlaneCoordinatesSequence", `SQ, `One, false);
0x0068_65F0l, ("2D Plane Intersection", "TwoDPlaneIntersection", `FD, `Four, false);
0x0068_6610l, ("3D Plane Origin", "ThreeDPlaneOrigin", `FD, `Three, false);
0x0068_6620l, ("3D Plane Normal", "ThreeDPlaneNormal", `FD, `Three, false);
0x0070_0001l, ("Graphic Annotation Sequence", "GraphicAnnotationSequence", `SQ, `One, false);
0x0070_0002l, ("Graphic Layer", "GraphicLayer", `CS, `One, false);
0x0070_0003l, ("Bounding Box Annotation Units", "BoundingBoxAnnotationUnits", `CS, `One, false);
0x0070_0004l, ("Anchor Point Annotation Units", "AnchorPointAnnotationUnits", `CS, `One, false);
0x0070_0005l, ("Graphic Annotation Units", "GraphicAnnotationUnits", `CS, `One, false);
0x0070_0006l, ("Unformatted Text Value", "UnformattedTextValue", `ST, `One, false);
0x0070_0008l, ("Text Object Sequence", "TextObjectSequence", `SQ, `One, false);
0x0070_0009l, ("Graphic Object Sequence", "GraphicObjectSequence", `SQ, `One, false);
0x0070_0010l, ("Bounding Box Top Left Hand Corner", "BoundingBoxTopLeftHandCorner", `FL, `Two, false);
0x0070_0011l, ("Bounding Box Bottom Right Hand Corner", "BoundingBoxBottomRightHandCorner", `FL, `Two, false);
0x0070_0012l, ("Bounding Box Text Horizontal Justification", "BoundingBoxTextHorizontalJustification", `CS, `One, false);
0x0070_0014l, ("Anchor Point", "AnchorPoint", `FL, `Two, false);
0x0070_0015l, ("Anchor Point Visibility", "AnchorPointVisibility", `CS, `One, false);
0x0070_0020l, ("Graphic Dimensions", "GraphicDimensions", `US, `One, false);
0x0070_0021l, ("Number of Graphic Points", "NumberOfGraphicPoints", `US, `One, false);
0x0070_0022l, ("Graphic Data", "GraphicData", `FL, `Two_n, false);
0x0070_0023l, ("Graphic Type", "GraphicType", `CS, `One, false);
0x0070_0024l, ("Graphic Filled", "GraphicFilled", `CS, `One, false);
0x0070_0040l, ("Image Rotation (Retired)", "ImageRotationRetired", `IS, `One, true);
0x0070_0041l, ("Image Horizontal Flip", "ImageHorizontalFlip", `CS, `One, false);
0x0070_0042l, ("Image Rotation", "ImageRotation", `US, `One, false);
0x0070_0050l, ("Displayed Area Top Left Hand Corner (Trial)", "DisplayedAreaTopLeftHandCornerTrial", `US, `Two, true);
0x0070_0051l, ("Displayed Area Bottom Right Hand Corner (Trial)", "DisplayedAreaBottomRightHandCornerTrial", `US, `Two, true);
0x0070_0052l, ("Displayed Area Top Left Hand Corner", "DisplayedAreaTopLeftHandCorner", `SL, `Two, false);
0x0070_0053l, ("Displayed Area Bottom Right Hand Corner", "DisplayedAreaBottomRightHandCorner", `SL, `Two, false);
0x0070_005Al, ("Displayed Area Selection Sequence", "DisplayedAreaSelectionSequence", `SQ, `One, false);
0x0070_0060l, ("Graphic Layer Sequence", "GraphicLayerSequence", `SQ, `One, false);
0x0070_0062l, ("Graphic Layer Order", "GraphicLayerOrder", `IS, `One, false);
0x0070_0066l, ("Graphic Layer Recommended Display Grayscale Value", "GraphicLayerRecommendedDisplayGrayscaleValue", `US, `One, false);
0x0070_0067l, ("Graphic Layer Recommended Display RGB Value", "GraphicLayerRecommendedDisplayRGBValue", `US, `Three, true);
0x0070_0068l, ("Graphic Layer Description", "GraphicLayerDescription", `LO, `One, false);
0x0070_0080l, ("Content Label", "ContentLabel", `CS, `One, false);
0x0070_0081l, ("Content Description", "ContentDescription", `LO, `One, false);
0x0070_0082l, ("Presentation Creation Date", "PresentationCreationDate", `DA, `One, false);
0x0070_0083l, ("Presentation Creation Time", "PresentationCreationTime", `TM, `One, false);
0x0070_0084l, ("Content Creator’s Name", "ContentCreatorName", `PN, `One, false);
0x0070_0086l, ("Content Creator’s Identification Code Sequence", "ContentCreatorIdentificationCodeSequence", `SQ, `One, false);
0x0070_0087l, ("Alternate Content Description Sequence", "AlternateContentDescriptionSequence", `SQ, `One, false);
0x0070_0100l, ("Presentation Size Mode", "PresentationSizeMode", `CS, `One, false);
0x0070_0101l, ("Presentation Pixel Spacing", "PresentationPixelSpacing", `DS, `Two, false);
0x0070_0102l, ("Presentation Pixel Aspect Ratio", "PresentationPixelAspectRatio", `IS, `Two, false);
0x0070_0103l, ("Presentation Pixel Magnification Ratio", "PresentationPixelMagnificationRatio", `FL, `One, false);
0x0070_0207l, ("Graphic Group Label", "GraphicGroupLabel", `LO, `One, false);
0x0070_0208l, ("Graphic Group Description", "GraphicGroupDescription", `ST, `One, false);
0x0070_0209l, ("Compound Graphic Sequence", "CompoundGraphicSequence", `SQ, `One, false);
0x0070_0226l, ("Compound Graphic Instance ID", "CompoundGraphicInstanceID", `UL, `One, false);
0x0070_0227l, ("Font Name", "FontName", `LO, `One, false);
0x0070_0228l, ("Font Name Type", "FontNameType", `CS, `One, false);
0x0070_0229l, ("CSS Font Name", "CSSFontName", `LO, `One, false);
0x0070_0230l, ("Rotation Angle", "RotationAngle", `FD, `One, false);
0x0070_0231l, ("Text Style Sequence", "TextStyleSequence", `SQ, `One, false);
0x0070_0232l, ("Line Style Sequence", "LineStyleSequence", `SQ, `One, false);
0x0070_0233l, ("Fill Style Sequence", "FillStyleSequence", `SQ, `One, false);
0x0070_0234l, ("Graphic Group Sequence", "GraphicGroupSequence", `SQ, `One, false);
0x0070_0241l, ("Text Color CIELab Value", "TextColorCIELabValue", `US, `Three, false);
0x0070_0242l, ("Horizontal Alignment", "HorizontalAlignment", `CS, `One, false);
0x0070_0243l, ("Vertical Alignment", "VerticalAlignment", `CS, `One, false);
0x0070_0244l, ("Shadow Style", "ShadowStyle", `CS, `One, false);
0x0070_0245l, ("Shadow Offset X", "ShadowOffsetX", `FL, `One, false);
0x0070_0246l, ("Shadow Offset Y", "ShadowOffsetY", `FL, `One, false);
0x0070_0247l, ("Shadow Color CIELab Value", "ShadowColorCIELabValue", `US, `Three, false);
0x0070_0248l, ("Underlined", "Underlined", `CS, `One, false);
0x0070_0249l, ("Bold", "Bold", `CS, `One, false);
0x0070_0250l, ("Italic", "Italic", `CS, `One, false);
0x0070_0251l, ("Pattern On Color CIELab Value", "PatternOnColorCIELabValue", `US, `Three, false);
0x0070_0252l, ("Pattern Off Color CIELab Value", "PatternOffColorCIELabValue", `US, `Three, false);
0x0070_0253l, ("Line Thickness", "LineThickness", `FL, `One, false);
0x0070_0254l, ("Line Dashing Style", "LineDashingStyle", `CS, `One, false);
0x0070_0255l, ("Line Pattern", "LinePattern", `UL, `One, false);
0x0070_0256l, ("Fill Pattern", "FillPattern", `OB, `One, false);
0x0070_0257l, ("Fill Mode", "FillMode", `CS, `One, false);
0x0070_0258l, ("Shadow Opacity", "ShadowOpacity", `FL, `One, false);
0x0070_0261l, ("Gap Length", "GapLength", `FL, `One, false);
0x0070_0262l, ("Diameter of Visibility", "DiameterOfVisibility", `FL, `One, false);
0x0070_0273l, ("Rotation Point", "RotationPoint", `FL, `Two, false);
0x0070_0274l, ("Tick Alignment", "TickAlignment", `CS, `One, false);
0x0070_0278l, ("Show Tick Label", "ShowTickLabel", `CS, `One, false);
0x0070_0279l, ("Tick Label Alignment", "TickLabelAlignment", `CS, `One, false);
0x0070_0282l, ("Compound Graphic Units", "CompoundGraphicUnits", `CS, `One, false);
0x0070_0284l, ("Pattern On Opacity", "PatternOnOpacity", `FL, `One, false);
0x0070_0285l, ("Pattern Off Opacity", "PatternOffOpacity", `FL, `One, false);
0x0070_0287l, ("Major Ticks Sequence", "MajorTicksSequence", `SQ, `One, false);
0x0070_0288l, ("Tick Position", "TickPosition", `FL, `One, false);
0x0070_0289l, ("Tick Label", "TickLabel", `SH, `One, false);
0x0070_0294l, ("Compound Graphic Type", "CompoundGraphicType", `CS, `One, false);
0x0070_0295l, ("Graphic Group ID", "GraphicGroupID", `UL, `One, false);
0x0070_0306l, ("Shape Type", "ShapeType", `CS, `One, false);
0x0070_0308l, ("Registration Sequence", "RegistrationSequence", `SQ, `One, false);
0x0070_0309l, ("Matrix Registration Sequence", "MatrixRegistrationSequence", `SQ, `One, false);
0x0070_030Al, ("Matrix Sequence", "MatrixSequence", `SQ, `One, false);
0x0070_030Cl, ("Frame of Reference Transformation Matrix Type", "FrameOfReferenceTransformationMatrixType", `CS, `One, false);
0x0070_030Dl, ("Registration Type Code Sequence", "RegistrationTypeCodeSequence", `SQ, `One, false);
0x0070_030Fl, ("Fiducial Description", "FiducialDescription", `ST, `One, false);
0x0070_0310l, ("Fiducial Identifier", "FiducialIdentifier", `SH, `One, false);
0x0070_0311l, ("Fiducial Identifier Code Sequence", "FiducialIdentifierCodeSequence", `SQ, `One, false);
0x0070_0312l, ("Contour Uncertainty Radius", "ContourUncertaintyRadius", `FD, `One, false);
0x0070_0314l, ("Used Fiducials Sequence", "UsedFiducialsSequence", `SQ, `One, false);
0x0070_0318l, ("Graphic Coordinates Data Sequence", "GraphicCoordinatesDataSequence", `SQ, `One, false);
0x0070_031Al, ("Fiducial UID", "FiducialUID", `UI, `One, false);
0x0070_031Cl, ("Fiducial Set Sequence", "FiducialSetSequence", `SQ, `One, false);
0x0070_031El, ("Fiducial Sequence", "FiducialSequence", `SQ, `One, false);
0x0070_0401l, ("Graphic Layer Recommended Display CIELab Value", "GraphicLayerRecommendedDisplayCIELabValue", `US, `Three, false);
0x0070_0402l, ("Blending Sequence", "BlendingSequence", `SQ, `One, false);
0x0070_0403l, ("Relative Opacity", "RelativeOpacity", `FL, `One, false);
0x0070_0404l, ("Referenced Spatial Registration Sequence", "ReferencedSpatialRegistrationSequence", `SQ, `One, false);
0x0070_0405l, ("Blending Position", "BlendingPosition", `CS, `One, false);
0x0072_0002l, ("Hanging Protocol Name", "HangingProtocolName", `SH, `One, false);
0x0072_0004l, ("Hanging Protocol Description", "HangingProtocolDescription", `LO, `One, false);
0x0072_0006l, ("Hanging Protocol Level", "HangingProtocolLevel", `CS, `One, false);
0x0072_0008l, ("Hanging Protocol Creator", "HangingProtocolCreator", `LO, `One, false);
0x0072_000Al, ("Hanging Protocol Creation DateTime", "HangingProtocolCreationDateTime", `DT, `One, false);
0x0072_000Cl, ("Hanging Protocol Definition Sequence", "HangingProtocolDefinitionSequence", `SQ, `One, false);
0x0072_000El, ("Hanging Protocol User Identification Code Sequence", "HangingProtocolUserIdentificationCodeSequence", `SQ, `One, false);
0x0072_0010l, ("Hanging Protocol User Group Name", "HangingProtocolUserGroupName", `LO, `One, false);
0x0072_0012l, ("Source Hanging Protocol Sequence", "SourceHangingProtocolSequence", `SQ, `One, false);
0x0072_0014l, ("Number of Priors Referenced", "NumberOfPriorsReferenced", `US, `One, false);
0x0072_0020l, ("Image Sets Sequence", "ImageSetsSequence", `SQ, `One, false);
0x0072_0022l, ("Image Set Selector Sequence", "ImageSetSelectorSequence", `SQ, `One, false);
0x0072_0024l, ("Image Set Selector Usage Flag", "ImageSetSelectorUsageFlag", `CS, `One, false);
0x0072_0026l, ("Selector Attribute", "SelectorAttribute", `AT, `One, false);
0x0072_0028l, ("Selector Value Number", "SelectorValueNumber", `US, `One, false);
0x0072_0030l, ("Time Based Image Sets Sequence", "TimeBasedImageSetsSequence", `SQ, `One, false);
0x0072_0032l, ("Image Set Number", "ImageSetNumber", `US, `One, false);
0x0072_0034l, ("Image Set Selector Category", "ImageSetSelectorCategory", `CS, `One, false);
0x0072_0038l, ("Relative Time", "RelativeTime", `US, `Two, false);
0x0072_003Al, ("Relative Time Units", "RelativeTimeUnits", `CS, `One, false);
0x0072_003Cl, ("Abstract Prior Value", "AbstractPriorValue", `SS, `Two, false);
0x0072_003El, ("Abstract Prior Code Sequence", "AbstractPriorCodeSequence", `SQ, `One, false);
0x0072_0040l, ("Image Set Label", "ImageSetLabel", `LO, `One, false);
0x0072_0050l, ("Selector Attribute VR", "SelectorAttributeVR", `CS, `One, false);
0x0072_0052l, ("Selector Sequence Pointer", "SelectorSequencePointer", `AT, `One_n, false);
0x0072_0054l, ("Selector Sequence Pointer Private Creator", "SelectorSequencePointerPrivateCreator", `LO, `One_n, false);
0x0072_0056l, ("Selector Attribute Private Creator", "SelectorAttributePrivateCreator", `LO, `One, false);
0x0072_0060l, ("Selector AT Value", "SelectorATValue", `AT, `One_n, false);
0x0072_0062l, ("Selector CS Value", "SelectorCSValue", `CS, `One_n, false);
0x0072_0064l, ("Selector IS Value", "SelectorISValue", `IS, `One_n, false);
0x0072_0066l, ("Selector LO Value", "SelectorLOValue", `LO, `One_n, false);
0x0072_0068l, ("Selector LT Value", "SelectorLTValue", `LT, `One, false);
0x0072_006Al, ("Selector PN Value", "SelectorPNValue", `PN, `One_n, false);
0x0072_006Cl, ("Selector SH Value", "SelectorSHValue", `SH, `One_n, false);
0x0072_006El, ("Selector ST Value", "SelectorSTValue", `ST, `One, false);
0x0072_0070l, ("Selector UT Value", "SelectorUTValue", `UT, `One, false);
0x0072_0072l, ("Selector DS Value", "SelectorDSValue", `DS, `One_n, false);
0x0072_0074l, ("Selector FD Value", "SelectorFDValue", `FD, `One_n, false);
0x0072_0076l, ("Selector FL Value", "SelectorFLValue", `FL, `One_n, false);
0x0072_0078l, ("Selector UL Value", "SelectorULValue", `UL, `One_n, false);
0x0072_007Al, ("Selector US Value", "SelectorUSValue", `US, `One_n, false);
0x0072_007Cl, ("Selector SL Value", "SelectorSLValue", `SL, `One_n, false);
0x0072_007El, ("Selector SS Value", "SelectorSSValue", `SS, `One_n, false);
0x0072_0080l, ("Selector Code Sequence Value", "SelectorCodeSequenceValue", `SQ, `One, false);
0x0072_0100l, ("Number of Screens", "NumberOfScreens", `US, `One, false);
0x0072_0102l, ("Nominal Screen Definition Sequence", "NominalScreenDefinitionSequence", `SQ, `One, false);
0x0072_0104l, ("Number of Vertical Pixels", "NumberOfVerticalPixels", `US, `One, false);
0x0072_0106l, ("Number of Horizontal Pixels", "NumberOfHorizontalPixels", `US, `One, false);
0x0072_0108l, ("Display Environment Spatial Position", "DisplayEnvironmentSpatialPosition", `FD, `Four, false);
0x0072_010Al, ("Screen Minimum Grayscale Bit Depth", "ScreenMinimumGrayscaleBitDepth", `US, `One, false);
0x0072_010Cl, ("Screen Minimum Color Bit Depth", "ScreenMinimumColorBitDepth", `US, `One, false);
0x0072_010El, ("Application Maximum Repaint Time", "ApplicationMaximumRepaintTime", `US, `One, false);
0x0072_0200l, ("Display Sets Sequence", "DisplaySetsSequence", `SQ, `One, false);
0x0072_0202l, ("Display Set Number", "DisplaySetNumber", `US, `One, false);
0x0072_0203l, ("Display Set Label", "DisplaySetLabel", `LO, `One, false);
0x0072_0204l, ("Display Set Presentation Group", "DisplaySetPresentationGroup", `US, `One, false);
0x0072_0206l, ("Display Set Presentation Group Description", "DisplaySetPresentationGroupDescription", `LO, `One, false);
0x0072_0208l, ("Partial Data Display Handling", "PartialDataDisplayHandling", `CS, `One, false);
0x0072_0210l, ("Synchronized Scrolling Sequence", "SynchronizedScrollingSequence", `SQ, `One, false);
0x0072_0212l, ("Display Set Scrolling Group", "DisplaySetScrollingGroup", `US, `Two_n, false);
0x0072_0214l, ("Navigation Indicator Sequence", "NavigationIndicatorSequence", `SQ, `One, false);
0x0072_0216l, ("Navigation Display Set", "NavigationDisplaySet", `US, `One, false);
0x0072_0218l, ("Reference Display Sets", "ReferenceDisplaySets", `US, `One_n, false);
0x0072_0300l, ("Image Boxes Sequence", "ImageBoxesSequence", `SQ, `One, false);
0x0072_0302l, ("Image Box Number", "ImageBoxNumber", `US, `One, false);
0x0072_0304l, ("Image Box Layout Type", "ImageBoxLayoutType", `CS, `One, false);
0x0072_0306l, ("Image Box Tile Horizontal Dimension", "ImageBoxTileHorizontalDimension", `US, `One, false);
0x0072_0308l, ("Image Box Tile Vertical Dimension", "ImageBoxTileVerticalDimension", `US, `One, false);
0x0072_0310l, ("Image Box Scroll Direction", "ImageBoxScrollDirection", `CS, `One, false);
0x0072_0312l, ("Image Box Small Scroll Type", "ImageBoxSmallScrollType", `CS, `One, false);
0x0072_0314l, ("Image Box Small Scroll Amount", "ImageBoxSmallScrollAmount", `US, `One, false);
0x0072_0316l, ("Image Box Large Scroll Type", "ImageBoxLargeScrollType", `CS, `One, false);
0x0072_0318l, ("Image Box Large Scroll Amount", "ImageBoxLargeScrollAmount", `US, `One, false);
0x0072_0320l, ("Image Box Overlap Priority", "ImageBoxOverlapPriority", `US, `One, false);
0x0072_0330l, ("Cine Relative to Real-Time", "CineRelativeToRealTime", `FD, `One, false);
0x0072_0400l, ("Filter Operations Sequence", "FilterOperationsSequence", `SQ, `One, false);
0x0072_0402l, ("Filter-by Category", "FilterByCategory", `CS, `One, false);
0x0072_0404l, ("Filter-by Attribute Presence", "FilterByAttributePresence", `CS, `One, false);
0x0072_0406l, ("Filter-by Operator", "FilterByOperator", `CS, `One, false);
0x0072_0420l, ("Structured Display Background CIELab Value", "StructuredDisplayBackgroundCIELabValue", `US, `Three, false);
0x0072_0421l, ("Empty Image Box CIELab Value", "EmptyImageBoxCIELabValue", `US, `Three, false);
0x0072_0422l, ("Structured Display Image Box Sequence", "StructuredDisplayImageBoxSequence", `SQ, `One, false);
0x0072_0424l, ("Structured Display Text Box Sequence", "StructuredDisplayTextBoxSequence", `SQ, `One, false);
0x0072_0427l, ("Referenced First Frame Sequence", "ReferencedFirstFrameSequence", `SQ, `One, false);
0x0072_0430l, ("Image Box Synchronization Sequence", "ImageBoxSynchronizationSequence", `SQ, `One, false);
0x0072_0432l, ("Synchronized Image Box List", "SynchronizedImageBoxList", `US, `Two_n, false);
0x0072_0434l, ("Type of Synchronization", "TypeOfSynchronization", `CS, `One, false);
0x0072_0500l, ("Blending Operation Type", "BlendingOperationType", `CS, `One, false);
0x0072_0510l, ("Reformatting Operation Type", "ReformattingOperationType", `CS, `One, false);
0x0072_0512l, ("Reformatting Thickness", "ReformattingThickness", `FD, `One, false);
0x0072_0514l, ("Reformatting Interval", "ReformattingInterval", `FD, `One, false);
0x0072_0516l, ("Reformatting Operation Initial View Direction", "ReformattingOperationInitialViewDirection", `CS, `One, false);
0x0072_0520l, ("3D Rendering Type", "ThreeDRenderingType", `CS, `One_n, false);
0x0072_0600l, ("Sorting Operations Sequence", "SortingOperationsSequence", `SQ, `One, false);
0x0072_0602l, ("Sort-by Category", "SortByCategory", `CS, `One, false);
0x0072_0604l, ("Sorting Direction", "SortingDirection", `CS, `One, false);
0x0072_0700l, ("Display Set Patient Orientation", "DisplaySetPatientOrientation", `CS, `Two, false);
0x0072_0702l, ("VOI Type", "VOIType", `CS, `One, false);
0x0072_0704l, ("Pseudo-Color Type", "PseudoColorType", `CS, `One, false);
0x0072_0705l, ("Pseudo-Color Palette Instance Reference Sequence", "PseudoColorPaletteInstanceReferenceSequence", `SQ, `One, false);
0x0072_0706l, ("Show Grayscale Inverted", "ShowGrayscaleInverted", `CS, `One, false);
0x0072_0710l, ("Show Image True Size Flag", "ShowImageTrueSizeFlag", `CS, `One, false);
0x0072_0712l, ("Show Graphic Annotation Flag", "ShowGraphicAnnotationFlag", `CS, `One, false);
0x0072_0714l, ("Show Patient Demographics Flag", "ShowPatientDemographicsFlag", `CS, `One, false);
0x0072_0716l, ("Show Acquisition Techniques Flag", "ShowAcquisitionTechniquesFlag", `CS, `One, false);
0x0072_0717l, ("Display Set Horizontal Justification", "DisplaySetHorizontalJustification", `CS, `One, false);
0x0072_0718l, ("Display Set Vertical Justification", "DisplaySetVerticalJustification", `CS, `One, false);
0x0074_0120l, ("Continuation Start Meterset", "ContinuationStartMeterset", `FD, `One, false);
0x0074_0121l, ("Continuation End Meterset", "ContinuationEndMeterset", `FD, `One, false);
0x0074_1000l, ("Procedure Step State", "ProcedureStepState", `CS, `One, false);
0x0074_1002l, ("Procedure Step Progress Information Sequence", "ProcedureStepProgressInformationSequence", `SQ, `One, false);
0x0074_1004l, ("Procedure Step Progress", "ProcedureStepProgress", `DS, `One, false);
0x0074_1006l, ("Procedure Step Progress Description", "ProcedureStepProgressDescription", `ST, `One, false);
0x0074_1008l, ("Procedure Step Communications URI Sequence", "ProcedureStepCommunicationsURISequence", `SQ, `One, false);
0x0074_100al, ("Contact URI", "ContactURI", `ST, `One, false);
0x0074_100cl, ("Contact Display Name", "ContactDisplayName", `LO, `One, false);
0x0074_100el, ("Procedure Step Discontinuation Reason Code Sequence", "ProcedureStepDiscontinuationReasonCodeSequence", `SQ, `One, false);
0x0074_1020l, ("Beam Task Sequence", "BeamTaskSequence", `SQ, `One, false);
0x0074_1022l, ("Beam Task Type", "BeamTaskType", `CS, `One, false);
0x0074_1024l, ("Beam Order Index (Trial)", "BeamOrderIndexTrial", `IS, `One, true);
0x0074_1026l, ("Table Top Vertical Adjusted Position", "TableTopVerticalAdjustedPosition", `FD, `One, false);
0x0074_1027l, ("Table Top Longitudinal Adjusted Position", "TableTopLongitudinalAdjustedPosition", `FD, `One, false);
0x0074_1028l, ("Table Top Lateral Adjusted Position", "TableTopLateralAdjustedPosition", `FD, `One, false);
0x0074_102Al, ("Patient Support Adjusted Angle", "PatientSupportAdjustedAngle", `FD, `One, false);
0x0074_102Bl, ("Table Top Eccentric Adjusted Angle", "TableTopEccentricAdjustedAngle", `FD, `One, false);
0x0074_102Cl, ("Table Top Pitch Adjusted Angle", "TableTopPitchAdjustedAngle", `FD, `One, false);
0x0074_102Dl, ("Table Top Roll Adjusted Angle", "TableTopRollAdjustedAngle", `FD, `One, false);
0x0074_1030l, ("Delivery Verification Image Sequence", "DeliveryVerificationImageSequence", `SQ, `One, false);
0x0074_1032l, ("Verification Image Timing", "VerificationImageTiming", `CS, `One, false);
0x0074_1034l, ("Double Exposure Flag", "DoubleExposureFlag", `CS, `One, false);
0x0074_1036l, ("Double Exposure Ordering", "DoubleExposureOrdering", `CS, `One, false);
0x0074_1038l, ("Double Exposure Meterset (Trial)", "DoubleExposureMetersetTrial", `DS, `One, true);
0x0074_103Al, ("Double Exposure Field Delta (Trial)", "DoubleExposureFieldDeltaTrial", `DS, `Four, true);
0x0074_1040l, ("Related Reference RT Image Sequence", "RelatedReferenceRTImageSequence", `SQ, `One, false);
0x0074_1042l, ("General Machine Verification Sequence", "GeneralMachineVerificationSequence", `SQ, `One, false);
0x0074_1044l, ("Conventional Machine Verification Sequence", "ConventionalMachineVerificationSequence", `SQ, `One, false);
0x0074_1046l, ("Ion Machine Verification Sequence", "IonMachineVerificationSequence", `SQ, `One, false);
0x0074_1048l, ("Failed Attributes Sequence", "FailedAttributesSequence", `SQ, `One, false);
0x0074_104Al, ("Overridden Attributes Sequence", "OverriddenAttributesSequence", `SQ, `One, false);
0x0074_104Cl, ("Conventional Control Point Verification Sequence", "ConventionalControlPointVerificationSequence", `SQ, `One, false);
0x0074_104El, ("Ion Control Point Verification Sequence", "IonControlPointVerificationSequence", `SQ, `One, false);
0x0074_1050l, ("Attribute Occurrence Sequence", "AttributeOccurrenceSequence", `SQ, `One, false);
0x0074_1052l, ("Attribute Occurrence Pointer", "AttributeOccurrencePointer", `AT, `One, false);
0x0074_1054l, ("Attribute Item Selector", "AttributeItemSelector", `UL, `One, false);
0x0074_1056l, ("Attribute Occurrence Private Creator", "AttributeOccurrencePrivateCreator", `LO, `One, false);
0x0074_1057l, ("Selector Sequence Pointer Items", "SelectorSequencePointerItems", `IS, `One_n, false);
0x0074_1200l, ("Scheduled Procedure Step Priority", "ScheduledProcedureStepPriority", `CS, `One, false);
0x0074_1202l, ("Worklist Label", "WorklistLabel", `LO, `One, false);
0x0074_1204l, ("Procedure Step Label", "ProcedureStepLabel", `LO, `One, false);
0x0074_1210l, ("Scheduled Processing Parameters Sequence", "ScheduledProcessingParametersSequence", `SQ, `One, false);
0x0074_1212l, ("Performed Processing Parameters Sequence", "PerformedProcessingParametersSequence", `SQ, `One, false);
0x0074_1216l, ("Unified Procedure Step Performed Procedure Sequence", "UnifiedProcedureStepPerformedProcedureSequence", `SQ, `One, false);
0x0074_1220l, ("Related Procedure Step Sequence", "RelatedProcedureStepSequence", `SQ, `One, true);
0x0074_1222l, ("Procedure Step Relationship Type", "ProcedureStepRelationshipType", `LO, `One, true);
0x0074_1224l, ("Replaced Procedure Step Sequence", "ReplacedProcedureStepSequence", `SQ, `One, false);
0x0074_1230l, ("Deletion Lock", "DeletionLock", `LO, `One, false);
0x0074_1234l, ("Receiving AE", "ReceivingAE", `AE, `One, false);
0x0074_1236l, ("Requesting AE", "RequestingAE", `AE, `One, false);
0x0074_1238l, ("Reason for Cancellation", "ReasonForCancellation", `LT, `One, false);
0x0074_1242l, ("SCP Status", "SCPStatus", `CS, `One, false);
0x0074_1244l, ("Subscription List Status", "SubscriptionListStatus", `CS, `One, false);
0x0074_1246l, ("Unified Procedure Step List Status", "UnifiedProcedureStepListStatus", `CS, `One, false);
0x0074_1324l, ("Beam Order Index", "BeamOrderIndex", `UL, `One, false);
0x0074_1338l, ("Double Exposure Meterset", "DoubleExposureMeterset", `FD, `One, false);
0x0074_133Al, ("Double Exposure Field Delta", "DoubleExposureFieldDelta", `FD, `Four, false);
0x0076_0001l, ("Implant Assembly Template Name", "ImplantAssemblyTemplateName", `LO, `One, false);
0x0076_0003l, ("Implant Assembly Template Issuer", "ImplantAssemblyTemplateIssuer", `LO, `One, false);
0x0076_0006l, ("Implant Assembly Template Version", "ImplantAssemblyTemplateVersion", `LO, `One, false);
0x0076_0008l, ("Replaced Implant Assembly Template Sequence", "ReplacedImplantAssemblyTemplateSequence", `SQ, `One, false);
0x0076_000Al, ("Implant Assembly Template Type", "ImplantAssemblyTemplateType", `CS, `One, false);
0x0076_000Cl, ("Original Implant Assembly Template Sequence", "OriginalImplantAssemblyTemplateSequence", `SQ, `One, false);
0x0076_000El, ("Derivation Implant Assembly Template Sequence", "DerivationImplantAssemblyTemplateSequence", `SQ, `One, false);
0x0076_0010l, ("Implant Assembly Template Target Anatomy Sequence", "ImplantAssemblyTemplateTargetAnatomySequence", `SQ, `One, false);
0x0076_0020l, ("Procedure Type Code Sequence", "ProcedureTypeCodeSequence", `SQ, `One, false);
0x0076_0030l, ("Surgical Technique", "SurgicalTechnique", `LO, `One, false);
0x0076_0032l, ("Component Types Sequence", "ComponentTypesSequence", `SQ, `One, false);
0x0076_0034l, ("Component Type Code Sequence", "ComponentTypeCodeSequence", `CS, `One, false);
0x0076_0036l, ("Exclusive Component Type", "ExclusiveComponentType", `CS, `One, false);
0x0076_0038l, ("Mandatory Component Type", "MandatoryComponentType", `CS, `One, false);
0x0076_0040l, ("Component Sequence", "ComponentSequence", `SQ, `One, false);
0x0076_0055l, ("Component ID", "ComponentID", `US, `One, false);
0x0076_0060l, ("Component Assembly Sequence", "ComponentAssemblySequence", `SQ, `One, false);
0x0076_0070l, ("Component 1 Referenced ID", "Component1ReferencedID", `US, `One, false);
0x0076_0080l, ("Component 1 Referenced Mating Feature Set ID", "Component1ReferencedMatingFeatureSetID", `US, `One, false);
0x0076_0090l, ("Component 1 Referenced Mating Feature ID", "Component1ReferencedMatingFeatureID", `US, `One, false);
0x0076_00A0l, ("Component 2 Referenced ID", "Component2ReferencedID", `US, `One, false);
0x0076_00B0l, ("Component 2 Referenced Mating Feature Set ID", "Component2ReferencedMatingFeatureSetID", `US, `One, false);
0x0076_00C0l, ("Component 2 Referenced Mating Feature ID", "Component2ReferencedMatingFeatureID", `US, `One, false);
0x0078_0001l, ("Implant Template Group Name", "ImplantTemplateGroupName", `LO, `One, false);
0x0078_0010l, ("Implant Template Group Description", "ImplantTemplateGroupDescription", `ST, `One, false);
0x0078_0020l, ("Implant Template Group Issuer", "ImplantTemplateGroupIssuer", `LO, `One, false);
0x0078_0024l, ("Implant Template Group Version", "ImplantTemplateGroupVersion", `LO, `One, false);
0x0078_0026l, ("Replaced Implant Template Group Sequence", "ReplacedImplantTemplateGroupSequence", `SQ, `One, false);
0x0078_0028l, ("Implant Template Group Target Anatomy Sequence", "ImplantTemplateGroupTargetAnatomySequence", `SQ, `One, false);
0x0078_002Al, ("Implant Template Group Members Sequence", "ImplantTemplateGroupMembersSequence", `SQ, `One, false);
0x0078_002El, ("Implant Template Group Member ID", "ImplantTemplateGroupMemberID", `US, `One, false);
0x0078_0050l, ("3D Implant Template Group Member Matching Point", "ThreeDImplantTemplateGroupMemberMatchingPoint", `FD, `Three, false);
0x0078_0060l, ("3D Implant Template Group Member Matching Axes", "ThreeDImplantTemplateGroupMemberMatchingAxes", `FD, `Nine, false);
0x0078_0070l, ("Implant Template Group Member Matching 2D Coordinates Sequence", "ImplantTemplateGroupMemberMatching2DCoordinatesSequence", `SQ, `One, false);
0x0078_0090l, ("2D Implant Template Group Member Matching Point", "TwoDImplantTemplateGroupMemberMatchingPoint", `FD, `Two, false);
0x0078_00A0l, ("2D Implant Template Group Member Matching Axes", "TwoDImplantTemplateGroupMemberMatchingAxes", `FD, `Four, false);
0x0078_00B0l, ("Implant Template Group Variation Dimension Sequence", "ImplantTemplateGroupVariationDimensionSequence", `SQ, `One, false);
0x0078_00B2l, ("Implant Template Group Variation Dimension Name", "ImplantTemplateGroupVariationDimensionName", `LO, `One, false);
0x0078_00B4l, ("Implant Template Group Variation Dimension Rank Sequence", "ImplantTemplateGroupVariationDimensionRankSequence", `SQ, `One, false);
0x0078_00B6l, ("Referenced Implant Template Group Member ID", "ReferencedImplantTemplateGroupMemberID", `US, `One, false);
0x0078_00B8l, ("Implant Template Group Variation Dimension Rank", "ImplantTemplateGroupVariationDimensionRank", `US, `One, false);
0x0088_0130l, ("Storage Media File-set ID", "StorageMediaFileSetID", `SH, `One, false);
0x0088_0140l, ("Storage Media File-set UID", "StorageMediaFileSetUID", `UI, `One, false);
0x0088_0200l, ("Icon Image Sequence", "IconImageSequence", `SQ, `One, false);
0x0088_0904l, ("Topic Title", "TopicTitle", `LO, `One, true);
0x0088_0906l, ("Topic Subject", "TopicSubject", `ST, `One, true);
0x0088_0910l, ("Topic Author", "TopicAuthor", `LO, `One, true);
0x0088_0912l, ("Topic Keywords", "TopicKeywords", `LO, `One_32, true);
0x0100_0410l, ("SOP Instance Status", "SOPInstanceStatus", `CS, `One, false);
0x0100_0420l, ("SOP Authorization DateTime", "SOPAuthorizationDateTime", `DT, `One, false);
0x0100_0424l, ("SOP Authorization Comment", "SOPAuthorizationComment", `LT, `One, false);
0x0100_0426l, ("Authorization Equipment Certification Number", "AuthorizationEquipmentCertificationNumber", `LO, `One, false);
0x0400_0005l, ("MAC ID Number", "MACIDNumber", `US, `One, false);
0x0400_0010l, ("MAC Calculation Transfer Syntax UID", "MACCalculationTransferSyntaxUID", `UI, `One, false);
0x0400_0015l, ("MAC Algorithm", "MACAlgorithm", `CS, `One, false);
0x0400_0020l, ("Data Elements Signed", "DataElementsSigned", `AT, `One_n, false);
0x0400_0100l, ("Digital Signature UID", "DigitalSignatureUID", `UI, `One, false);
0x0400_0105l, ("Digital Signature DateTime", "DigitalSignatureDateTime", `DT, `One, false);
0x0400_0110l, ("Certificate Type", "CertificateType", `CS, `One, false);
0x0400_0115l, ("Certificate of Signer", "CertificateOfSigner", `OB, `One, false);
0x0400_0120l, ("Signature", "Signature", `OB, `One, false);
0x0400_0305l, ("Certified Timestamp Type", "CertifiedTimestampType", `CS, `One, false);
0x0400_0310l, ("Certified Timestamp", "CertifiedTimestamp", `OB, `One, false);
0x0400_0401l, ("Digital Signature Purpose Code Sequence", "DigitalSignaturePurposeCodeSequence", `SQ, `One, false);
0x0400_0402l, ("Referenced Digital Signature Sequence", "ReferencedDigitalSignatureSequence", `SQ, `One, false);
0x0400_0403l, ("Referenced SOP Instance MAC Sequence", "ReferencedSOPInstanceMACSequence", `SQ, `One, false);
0x0400_0404l, ("MAC", "MAC", `OB, `One, false);
0x0400_0500l, ("Encrypted Attributes Sequence", "EncryptedAttributesSequence", `SQ, `One, false);
0x0400_0510l, ("Encrypted Content Transfer Syntax UID", "EncryptedContentTransferSyntaxUID", `UI, `One, false);
0x0400_0520l, ("Encrypted Content", "EncryptedContent", `OB, `One, false);
0x0400_0550l, ("Modified Attributes Sequence", "ModifiedAttributesSequence", `SQ, `One, false);
0x0400_0561l, ("Original Attributes Sequence", "OriginalAttributesSequence", `SQ, `One, false);
0x0400_0562l, ("Attribute Modification DateTime", "AttributeModificationDateTime", `DT, `One, false);
0x0400_0563l, ("Modifying System", "ModifyingSystem", `LO, `One, false);
0x0400_0564l, ("Source of Previous Values", "SourceOfPreviousValues", `LO, `One, false);
0x0400_0565l, ("Reason for the Attribute Modification", "ReasonForTheAttributeModification", `CS, `One, false);
0x1000_0000l, ("Escape Triplet", "EscapeTriplet", `US, `Three, true);
0x1000_0001l, ("Run Length Triplet", "RunLengthTriplet", `US, `Three, true);
0x1000_0002l, ("Huffman Table Size", "HuffmanTableSize", `US, `One, true);
0x1000_0003l, ("Huffman Table Triplet", "HuffmanTableTriplet", `US, `Three, true);
0x1000_0004l, ("Shift Table Size", "ShiftTableSize", `US, `One, true);
0x1000_0005l, ("Shift Table Triplet", "ShiftTableTriplet", `US, `Three, true);
0x1010_0000l, ("Zonal Map", "ZonalMap", `US, `One_n, true);
0x2000_0010l, ("Number of Copies", "NumberOfCopies", `IS, `One, false);
0x2000_001El, ("Printer Configuration Sequence", "PrinterConfigurationSequence", `SQ, `One, false);
0x2000_0020l, ("Print Priority", "PrintPriority", `CS, `One, false);
0x2000_0030l, ("Medium Type", "MediumType", `CS, `One, false);
0x2000_0040l, ("Film Destination", "FilmDestination", `CS, `One, false);
0x2000_0050l, ("Film Session Label", "FilmSessionLabel", `LO, `One, false);
0x2000_0060l, ("Memory Allocation", "MemoryAllocation", `IS, `One, false);
0x2000_0061l, ("Maximum Memory Allocation", "MaximumMemoryAllocation", `IS, `One, false);
0x2000_0062l, ("Color Image Printing Flag", "ColorImagePrintingFlag", `CS, `One, true);
0x2000_0063l, ("Collation Flag", "CollationFlag", `CS, `One, true);
0x2000_0065l, ("Annotation Flag", "AnnotationFlag", `CS, `One, true);
0x2000_0067l, ("Image Overlay Flag", "ImageOverlayFlag", `CS, `One, true);
0x2000_0069l, ("Presentation LUT Flag", "PresentationLUTFlag", `CS, `One, true);
0x2000_006Al, ("Image Box Presentation LUT Flag", "ImageBoxPresentationLUTFlag", `CS, `One, true);
0x2000_00A0l, ("Memory Bit Depth", "MemoryBitDepth", `US, `One, false);
0x2000_00A1l, ("Printing Bit Depth", "PrintingBitDepth", `US, `One, false);
0x2000_00A2l, ("Media Installed Sequence", "MediaInstalledSequence", `SQ, `One, false);
0x2000_00A4l, ("Other Media Available Sequence", "OtherMediaAvailableSequence", `SQ, `One, false);
0x2000_00A8l, ("Supported Image Display Formats Sequence", "SupportedImageDisplayFormatsSequence", `SQ, `One, false);
0x2000_0500l, ("Referenced Film Box Sequence", "ReferencedFilmBoxSequence", `SQ, `One, false);
0x2000_0510l, ("Referenced Stored Print Sequence", "ReferencedStoredPrintSequence", `SQ, `One, true);
0x2010_0010l, ("Image Display Format", "ImageDisplayFormat", `ST, `One, false);
0x2010_0030l, ("Annotation Display Format ID", "AnnotationDisplayFormatID", `CS, `One, false);
0x2010_0040l, ("Film Orientation", "FilmOrientation", `CS, `One, false);
0x2010_0050l, ("Film Size ID", "FilmSizeID", `CS, `One, false);
0x2010_0052l, ("Printer Resolution ID", "PrinterResolutionID", `CS, `One, false);
0x2010_0054l, ("Default Printer Resolution ID", "DefaultPrinterResolutionID", `CS, `One, false);
0x2010_0060l, ("Magnification Type", "MagnificationType", `CS, `One, false);
0x2010_0080l, ("Smoothing Type", "SmoothingType", `CS, `One, false);
0x2010_00A6l, ("Default Magnification Type", "DefaultMagnificationType", `CS, `One, false);
0x2010_00A7l, ("Other Magnification Types Available", "OtherMagnificationTypesAvailable", `CS, `One_n, false);
0x2010_00A8l, ("Default Smoothing Type", "DefaultSmoothingType", `CS, `One, false);
0x2010_00A9l, ("Other Smoothing Types Available", "OtherSmoothingTypesAvailable", `CS, `One_n, false);
0x2010_0100l, ("Border Density", "BorderDensity", `CS, `One, false);
0x2010_0110l, ("Empty Image Density", "EmptyImageDensity", `CS, `One, false);
0x2010_0120l, ("Min Density", "MinDensity", `US, `One, false);
0x2010_0130l, ("Max Density", "MaxDensity", `US, `One, false);
0x2010_0140l, ("Trim", "Trim", `CS, `One, false);
0x2010_0150l, ("Configuration Information", "ConfigurationInformation", `ST, `One, false);
0x2010_0152l, ("Configuration Information Description", "ConfigurationInformationDescription", `LT, `One, false);
0x2010_0154l, ("Maximum Collated Films", "MaximumCollatedFilms", `IS, `One, false);
0x2010_015El, ("Illumination", "Illumination", `US, `One, false);
0x2010_0160l, ("Reflected Ambient Light", "ReflectedAmbientLight", `US, `One, false);
0x2010_0376l, ("Printer Pixel Spacing", "PrinterPixelSpacing", `DS, `Two, false);
0x2010_0500l, ("Referenced Film Session Sequence", "ReferencedFilmSessionSequence", `SQ, `One, false);
0x2010_0510l, ("Referenced Image Box Sequence", "ReferencedImageBoxSequence", `SQ, `One, false);
0x2010_0520l, ("Referenced Basic Annotation Box Sequence", "ReferencedBasicAnnotationBoxSequence", `SQ, `One, false);
0x2020_0010l, ("Image Box Position", "ImageBoxPosition", `US, `One, false);
0x2020_0020l, ("Polarity", "Polarity", `CS, `One, false);
0x2020_0030l, ("Requested Image Size", "RequestedImageSize", `DS, `One, false);
0x2020_0040l, ("Requested Decimate/Crop Behavior", "RequestedDecimateCropBehavior", `CS, `One, false);
0x2020_0050l, ("Requested Resolution ID", "RequestedResolutionID", `CS, `One, false);
0x2020_00A0l, ("Requested Image Size Flag", "RequestedImageSizeFlag", `CS, `One, false);
0x2020_00A2l, ("Decimate/Crop Result", "DecimateCropResult", `CS, `One, false);
0x2020_0110l, ("Basic Grayscale Image Sequence", "BasicGrayscaleImageSequence", `SQ, `One, false);
0x2020_0111l, ("Basic Color Image Sequence", "BasicColorImageSequence", `SQ, `One, false);
0x2020_0130l, ("Referenced Image Overlay Box Sequence", "ReferencedImageOverlayBoxSequence", `SQ, `One, true);
0x2020_0140l, ("Referenced VOI LUT Box Sequence", "ReferencedVOILUTBoxSequence", `SQ, `One, true);
0x2030_0010l, ("Annotation Position", "AnnotationPosition", `US, `One, false);
0x2030_0020l, ("Text String", "TextString", `LO, `One, false);
0x2040_0010l, ("Referenced Overlay Plane Sequence", "ReferencedOverlayPlaneSequence", `SQ, `One, true);
0x2040_0011l, ("Referenced Overlay Plane Groups", "ReferencedOverlayPlaneGroups", `US, `One_99, true);
0x2040_0020l, ("Overlay Pixel Data Sequence", "OverlayPixelDataSequence", `SQ, `One, true);
0x2040_0060l, ("Overlay Magnification Type", "OverlayMagnificationType", `CS, `One, true);
0x2040_0070l, ("Overlay Smoothing Type", "OverlaySmoothingType", `CS, `One, true);
0x2040_0072l, ("Overlay or Image Magnification", "OverlayOrImageMagnification", `CS, `One, true);
0x2040_0074l, ("Magnify to Number of Columns", "MagnifyToNumberOfColumns", `US, `One, true);
0x2040_0080l, ("Overlay Foreground Density", "OverlayForegroundDensity", `CS, `One, true);
0x2040_0082l, ("Overlay Background Density", "OverlayBackgroundDensity", `CS, `One, true);
0x2040_0090l, ("Overlay Mode", "OverlayMode", `CS, `One, true);
0x2040_0100l, ("Threshold Density", "ThresholdDensity", `CS, `One, true);
0x2040_0500l, ("Referenced Image Box Sequence (Retired)", "ReferencedImageBoxSequenceRetired", `SQ, `One, true);
0x2050_0010l, ("Presentation LUT Sequence", "PresentationLUTSequence", `SQ, `One, false);
0x2050_0020l, ("Presentation LUT Shape", "PresentationLUTShape", `CS, `One, false);
0x2050_0500l, ("Referenced Presentation LUT Sequence", "ReferencedPresentationLUTSequence", `SQ, `One, false);
0x2100_0010l, ("Print Job ID", "PrintJobID", `SH, `One, true);
0x2100_0020l, ("Execution Status", "ExecutionStatus", `CS, `One, false);
0x2100_0030l, ("Execution Status Info", "ExecutionStatusInfo", `CS, `One, false);
0x2100_0040l, ("Creation Date", "CreationDate", `DA, `One, false);
0x2100_0050l, ("Creation Time", "CreationTime", `TM, `One, false);
0x2100_0070l, ("Originator", "Originator", `AE, `One, false);
0x2100_0140l, ("Destination AE", "DestinationAE", `AE, `One, true);
0x2100_0160l, ("Owner ID", "OwnerID", `SH, `One, false);
0x2100_0170l, ("Number of Films", "NumberOfFilms", `IS, `One, false);
0x2100_0500l, ("Referenced Print Job Sequence (Pull Stored Print)", "ReferencedPrintJobSequencePullStoredPrint", `SQ, `One, true);
0x2110_0010l, ("Printer Status", "PrinterStatus", `CS, `One, false);
0x2110_0020l, ("Printer Status Info", "PrinterStatusInfo", `CS, `One, false);
0x2110_0030l, ("Printer Name", "PrinterName", `LO, `One, false);
0x2110_0099l, ("Print Queue ID", "PrintQueueID", `SH, `One, true);
0x2120_0010l, ("Queue Status", "QueueStatus", `CS, `One, true);
0x2120_0050l, ("Print Job Description Sequence", "PrintJobDescriptionSequence", `SQ, `One, true);
0x2120_0070l, ("Referenced Print Job Sequence", "ReferencedPrintJobSequence", `SQ, `One, true);
0x2130_0010l, ("Print Management Capabilities Sequence", "PrintManagementCapabilitiesSequence", `SQ, `One, true);
0x2130_0015l, ("Printer Characteristics Sequence", "PrinterCharacteristicsSequence", `SQ, `One, true);
0x2130_0030l, ("Film Box Content Sequence", "FilmBoxContentSequence", `SQ, `One, true);
0x2130_0040l, ("Image Box Content Sequence", "ImageBoxContentSequence", `SQ, `One, true);
0x2130_0050l, ("Annotation Content Sequence", "AnnotationContentSequence", `SQ, `One, true);
0x2130_0060l, ("Image Overlay Box Content Sequence", "ImageOverlayBoxContentSequence", `SQ, `One, true);
0x2130_0080l, ("Presentation LUT Content Sequence", "PresentationLUTContentSequence", `SQ, `One, true);
0x2130_00A0l, ("Proposed Study Sequence", "ProposedStudySequence", `SQ, `One, true);
0x2130_00C0l, ("Original Image Sequence", "OriginalImageSequence", `SQ, `One, true);
0x2200_0001l, ("Label Using Information Extracted From Instances", "LabelUsingInformationExtractedFromInstances", `CS, `One, false);
0x2200_0002l, ("Label Text", "LabelText", `UT, `One, false);
0x2200_0003l, ("Label Style Selection", "LabelStyleSelection", `CS, `One, false);
0x2200_0004l, ("Media Disposition", "MediaDisposition", `LT, `One, false);
0x2200_0005l, ("Barcode Value", "BarcodeValue", `LT, `One, false);
0x2200_0006l, ("Barcode Symbology", "BarcodeSymbology", `CS, `One, false);
0x2200_0007l, ("Allow Media Splitting", "AllowMediaSplitting", `CS, `One, false);
0x2200_0008l, ("Include Non-DICOM Objects", "IncludeNonDICOMObjects", `CS, `One, false);
0x2200_0009l, ("Include Display Application", "IncludeDisplayApplication", `CS, `One, false);
0x2200_000Al, ("Preserve Composite Instances After Media Creation", "PreserveCompositeInstancesAfterMediaCreation", `CS, `One, false);
0x2200_000Bl, ("Total Number of Pieces of Media Created", "TotalNumberOfPiecesOfMediaCreated", `US, `One, false);
0x2200_000Cl, ("Requested Media Application Profile", "RequestedMediaApplicationProfile", `LO, `One, false);
0x2200_000Dl, ("Referenced Storage Media Sequence", "ReferencedStorageMediaSequence", `SQ, `One, false);
0x2200_000El, ("Failure Attributes", "FailureAttributes", `AT, `One_n, false);
0x2200_000Fl, ("Allow Lossy Compression", "AllowLossyCompression", `CS, `One, false);
0x2200_0020l, ("Request Priority", "RequestPriority", `CS, `One, false);
0x3002_0002l, ("RT Image Label", "RTImageLabel", `SH, `One, false);
0x3002_0003l, ("RT Image Name", "RTImageName", `LO, `One, false);
0x3002_0004l, ("RT Image Description", "RTImageDescription", `ST, `One, false);
0x3002_000Al, ("Reported Values Origin", "ReportedValuesOrigin", `CS, `One, false);
0x3002_000Cl, ("RT Image Plane", "RTImagePlane", `CS, `One, false);
0x3002_000Dl, ("X-Ray Image Receptor Translation", "XRayImageReceptorTranslation", `DS, `Three, false);
0x3002_000El, ("X-Ray Image Receptor Angle", "XRayImageReceptorAngle", `DS, `One, false);
0x3002_0010l, ("RT Image Orientation", "RTImageOrientation", `DS, `Six, false);
0x3002_0011l, ("Image Plane Pixel Spacing", "ImagePlanePixelSpacing", `DS, `Two, false);
0x3002_0012l, ("RT Image Position", "RTImagePosition", `DS, `Two, false);
0x3002_0020l, ("Radiation Machine Name", "RadiationMachineName", `SH, `One, false);
0x3002_0022l, ("Radiation Machine SAD", "RadiationMachineSAD", `DS, `One, false);
0x3002_0024l, ("Radiation Machine SSD", "RadiationMachineSSD", `DS, `One, false);
0x3002_0026l, ("RT Image SID", "RTImageSID", `DS, `One, false);
0x3002_0028l, ("Source to Reference Object Distance", "SourceToReferenceObjectDistance", `DS, `One, false);
0x3002_0029l, ("Fraction Number", "FractionNumber", `IS, `One, false);
0x3002_0030l, ("Exposure Sequence", "ExposureSequence", `SQ, `One, false);
0x3002_0032l, ("Meterset Exposure", "MetersetExposure", `DS, `One, false);
0x3002_0034l, ("Diaphragm Position", "DiaphragmPosition", `DS, `Four, false);
0x3002_0040l, ("Fluence Map Sequence", "FluenceMapSequence", `SQ, `One, false);
0x3002_0041l, ("Fluence Data Source", "FluenceDataSource", `CS, `One, false);
0x3002_0042l, ("Fluence Data Scale", "FluenceDataScale", `DS, `One, false);
0x3002_0050l, ("Primary Fluence Mode Sequence", "PrimaryFluenceModeSequence", `SQ, `One, false);
0x3002_0051l, ("Fluence Mode", "FluenceMode", `CS, `One, false);
0x3002_0052l, ("Fluence Mode ID", "FluenceModeID", `SH, `One, false);
0x3004_0001l, ("DVH Type", "DVHType", `CS, `One, false);
0x3004_0002l, ("Dose Units", "DoseUnits", `CS, `One, false);
0x3004_0004l, ("Dose Type", "DoseType", `CS, `One, false);
0x3004_0006l, ("Dose Comment", "DoseComment", `LO, `One, false);
0x3004_0008l, ("Normalization Point", "NormalizationPoint", `DS, `Three, false);
0x3004_000Al, ("Dose Summation Type", "DoseSummationType", `CS, `One, false);
0x3004_000Cl, ("Grid Frame Offset Vector", "GridFrameOffsetVector", `DS, `Two_n, false);
0x3004_000El, ("Dose Grid Scaling", "DoseGridScaling", `DS, `One, false);
0x3004_0010l, ("RT Dose ROI Sequence", "RTDoseROISequence", `SQ, `One, false);
0x3004_0012l, ("Dose Value", "DoseValue", `DS, `One, false);
0x3004_0014l, ("Tissue Heterogeneity Correction", "TissueHeterogeneityCorrection", `CS, `One_3, false);
0x3004_0040l, ("DVH Normalization Point", "DVHNormalizationPoint", `DS, `Three, false);
0x3004_0042l, ("DVH Normalization Dose Value", "DVHNormalizationDoseValue", `DS, `One, false);
0x3004_0050l, ("DVH Sequence", "DVHSequence", `SQ, `One, false);
0x3004_0052l, ("DVH Dose Scaling", "DVHDoseScaling", `DS, `One, false);
0x3004_0054l, ("DVH Volume Units", "DVHVolumeUnits", `CS, `One, false);
0x3004_0056l, ("DVH Number of Bins", "DVHNumberOfBins", `IS, `One, false);
0x3004_0058l, ("DVH Data", "DVHData", `DS, `Two_2n, false);
0x3004_0060l, ("DVH Referenced ROI Sequence", "DVHReferencedROISequence", `SQ, `One, false);
0x3004_0062l, ("DVH ROI Contribution Type", "DVHROIContributionType", `CS, `One, false);
0x3004_0070l, ("DVH Minimum Dose", "DVHMinimumDose", `DS, `One, false);
0x3004_0072l, ("DVH Maximum Dose", "DVHMaximumDose", `DS, `One, false);
0x3004_0074l, ("DVH Mean Dose", "DVHMeanDose", `DS, `One, false);
0x3006_0002l, ("Structure Set Label", "StructureSetLabel", `SH, `One, false);
0x3006_0004l, ("Structure Set Name", "StructureSetName", `LO, `One, false);
0x3006_0006l, ("Structure Set Description", "StructureSetDescription", `ST, `One, false);
0x3006_0008l, ("Structure Set Date", "StructureSetDate", `DA, `One, false);
0x3006_0009l, ("Structure Set Time", "StructureSetTime", `TM, `One, false);
0x3006_0010l, ("Referenced Frame of Reference Sequence", "ReferencedFrameOfReferenceSequence", `SQ, `One, false);
0x3006_0012l, ("RT Referenced Study Sequence", "RTReferencedStudySequence", `SQ, `One, false);
0x3006_0014l, ("RT Referenced Series Sequence", "RTReferencedSeriesSequence", `SQ, `One, false);
0x3006_0016l, ("Contour Image Sequence", "ContourImageSequence", `SQ, `One, false);
0x3006_0020l, ("Structure Set ROI Sequence", "StructureSetROISequence", `SQ, `One, false);
0x3006_0022l, ("ROI Number", "ROINumber", `IS, `One, false);
0x3006_0024l, ("Referenced Frame of Reference UID", "ReferencedFrameOfReferenceUID", `UI, `One, false);
0x3006_0026l, ("ROI Name", "ROIName", `LO, `One, false);
0x3006_0028l, ("ROI Description", "ROIDescription", `ST, `One, false);
0x3006_002Al, ("ROI Display Color", "ROIDisplayColor", `IS, `Three, false);
0x3006_002Cl, ("ROI Volume", "ROIVolume", `DS, `One, false);
0x3006_0030l, ("RT Related ROI Sequence", "RTRelatedROISequence", `SQ, `One, false);
0x3006_0033l, ("RT ROI Relationship", "RTROIRelationship", `CS, `One, false);
0x3006_0036l, ("ROI Generation Algorithm", "ROIGenerationAlgorithm", `CS, `One, false);
0x3006_0038l, ("ROI Generation Description", "ROIGenerationDescription", `LO, `One, false);
0x3006_0039l, ("ROI Contour Sequence", "ROIContourSequence", `SQ, `One, false);
0x3006_0040l, ("Contour Sequence", "ContourSequence", `SQ, `One, false);
0x3006_0042l, ("Contour Geometric Type", "ContourGeometricType", `CS, `One, false);
0x3006_0044l, ("Contour Slab Thickness", "ContourSlabThickness", `DS, `One, false);
0x3006_0045l, ("Contour Offset Vector", "ContourOffsetVector", `DS, `Three, false);
0x3006_0046l, ("Number of Contour Points", "NumberOfContourPoints", `IS, `One, false);
0x3006_0048l, ("Contour Number", "ContourNumber", `IS, `One, false);
0x3006_0049l, ("Attached Contours", "AttachedContours", `IS, `One_n, false);
0x3006_0050l, ("Contour Data", "ContourData", `DS, `Three_3n, false);
0x3006_0080l, ("RT ROI Observations Sequence", "RTROIObservationsSequence", `SQ, `One, false);
0x3006_0082l, ("Observation Number", "ObservationNumber", `IS, `One, false);
0x3006_0084l, ("Referenced ROI Number", "ReferencedROINumber", `IS, `One, false);
0x3006_0085l, ("ROI Observation Label", "ROIObservationLabel", `SH, `One, false);
0x3006_0086l, ("RT ROI Identification Code Sequence", "RTROIIdentificationCodeSequence", `SQ, `One, false);
0x3006_0088l, ("ROI Observation Description", "ROIObservationDescription", `ST, `One, false);
0x3006_00A0l, ("Related RT ROI Observations Sequence", "RelatedRTROIObservationsSequence", `SQ, `One, false);
0x3006_00A4l, ("RT ROI Interpreted Type", "RTROIInterpretedType", `CS, `One, false);
0x3006_00A6l, ("ROI Interpreter", "ROIInterpreter", `PN, `One, false);
0x3006_00B0l, ("ROI Physical Properties Sequence", "ROIPhysicalPropertiesSequence", `SQ, `One, false);
0x3006_00B2l, ("ROI Physical Property", "ROIPhysicalProperty", `CS, `One, false);
0x3006_00B4l, ("ROI Physical Property Value", "ROIPhysicalPropertyValue", `DS, `One, false);
0x3006_00B6l, ("ROI Elemental Composition Sequence", "ROIElementalCompositionSequence", `SQ, `One, false);
0x3006_00B7l, ("ROI Elemental Composition Atomic Number", "ROIElementalCompositionAtomicNumber", `US, `One, false);
0x3006_00B8l, ("ROI Elemental Composition Atomic Mass Fraction", "ROIElementalCompositionAtomicMassFraction", `FL, `One, false);
0x3006_00C0l, ("Frame of Reference Relationship Sequence", "FrameOfReferenceRelationshipSequence", `SQ, `One, false);
0x3006_00C2l, ("Related Frame of Reference UID", "RelatedFrameOfReferenceUID", `UI, `One, false);
0x3006_00C4l, ("Frame of Reference Transformation Type", "FrameOfReferenceTransformationType", `CS, `One, false);
0x3006_00C6l, ("Frame of Reference Transformation Matrix", "FrameOfReferenceTransformationMatrix", `DS, `Sixteen, false);
0x3006_00C8l, ("Frame of Reference Transformation Comment", "FrameOfReferenceTransformationComment", `LO, `One, false);
0x3008_0010l, ("Measured Dose Reference Sequence", "MeasuredDoseReferenceSequence", `SQ, `One, false);
0x3008_0012l, ("Measured Dose Description", "MeasuredDoseDescription", `ST, `One, false);
0x3008_0014l, ("Measured Dose Type", "MeasuredDoseType", `CS, `One, false);
0x3008_0016l, ("Measured Dose Value", "MeasuredDoseValue", `DS, `One, false);
0x3008_0020l, ("Treatment Session Beam Sequence", "TreatmentSessionBeamSequence", `SQ, `One, false);
0x3008_0021l, ("Treatment Session Ion Beam Sequence", "TreatmentSessionIonBeamSequence", `SQ, `One, false);
0x3008_0022l, ("Current Fraction Number", "CurrentFractionNumber", `IS, `One, false);
0x3008_0024l, ("Treatment Control Point Date", "TreatmentControlPointDate", `DA, `One, false);
0x3008_0025l, ("Treatment Control Point Time", "TreatmentControlPointTime", `TM, `One, false);
0x3008_002Al, ("Treatment Termination Status", "TreatmentTerminationStatus", `CS, `One, false);
0x3008_002Bl, ("Treatment Termination Code", "TreatmentTerminationCode", `SH, `One, false);
0x3008_002Cl, ("Treatment Verification Status", "TreatmentVerificationStatus", `CS, `One, false);
0x3008_0030l, ("Referenced Treatment Record Sequence", "ReferencedTreatmentRecordSequence", `SQ, `One, false);
0x3008_0032l, ("Specified Primary Meterset", "SpecifiedPrimaryMeterset", `DS, `One, false);
0x3008_0033l, ("Specified Secondary Meterset", "SpecifiedSecondaryMeterset", `DS, `One, false);
0x3008_0036l, ("Delivered Primary Meterset", "DeliveredPrimaryMeterset", `DS, `One, false);
0x3008_0037l, ("Delivered Secondary Meterset", "DeliveredSecondaryMeterset", `DS, `One, false);
0x3008_003Al, ("Specified Treatment Time", "SpecifiedTreatmentTime", `DS, `One, false);
0x3008_003Bl, ("Delivered Treatment Time", "DeliveredTreatmentTime", `DS, `One, false);
0x3008_0040l, ("Control Point Delivery Sequence", "ControlPointDeliverySequence", `SQ, `One, false);
0x3008_0041l, ("Ion Control Point Delivery Sequence", "IonControlPointDeliverySequence", `SQ, `One, false);
0x3008_0042l, ("Specified Meterset", "SpecifiedMeterset", `DS, `One, false);
0x3008_0044l, ("Delivered Meterset", "DeliveredMeterset", `DS, `One, false);
0x3008_0045l, ("Meterset Rate Set", "MetersetRateSet", `FL, `One, false);
0x3008_0046l, ("Meterset Rate Delivered", "MetersetRateDelivered", `FL, `One, false);
0x3008_0047l, ("Scan Spot Metersets Delivered", "ScanSpotMetersetsDelivered", `FL, `One_n, false);
0x3008_0048l, ("Dose Rate Delivered", "DoseRateDelivered", `DS, `One, false);
0x3008_0050l, ("Treatment Summary Calculated Dose Reference Sequence", "TreatmentSummaryCalculatedDoseReferenceSequence", `SQ, `One, false);
0x3008_0052l, ("Cumulative Dose to Dose Reference", "CumulativeDoseToDoseReference", `DS, `One, false);
0x3008_0054l, ("First Treatment Date", "FirstTreatmentDate", `DA, `One, false);
0x3008_0056l, ("Most Recent Treatment Date", "MostRecentTreatmentDate", `DA, `One, false);
0x3008_005Al, ("Number of Fractions Delivered", "NumberOfFractionsDelivered", `IS, `One, false);
0x3008_0060l, ("Override Sequence", "OverrideSequence", `SQ, `One, false);
0x3008_0061l, ("Parameter Sequence Pointer", "ParameterSequencePointer", `AT, `One, false);
0x3008_0062l, ("Override Parameter Pointer", "OverrideParameterPointer", `AT, `One, false);
0x3008_0063l, ("Parameter Item Index", "ParameterItemIndex", `IS, `One, false);
0x3008_0064l, ("Measured Dose Reference Number", "MeasuredDoseReferenceNumber", `IS, `One, false);
0x3008_0065l, ("Parameter Pointer", "ParameterPointer", `AT, `One, false);
0x3008_0066l, ("Override Reason", "OverrideReason", `ST, `One, false);
0x3008_0068l, ("Corrected Parameter Sequence", "CorrectedParameterSequence", `SQ, `One, false);
0x3008_006Al, ("Correction Value", "CorrectionValue", `FL, `One, false);
0x3008_0070l, ("Calculated Dose Reference Sequence", "CalculatedDoseReferenceSequence", `SQ, `One, false);
0x3008_0072l, ("Calculated Dose Reference Number", "CalculatedDoseReferenceNumber", `IS, `One, false);
0x3008_0074l, ("Calculated Dose Reference Description", "CalculatedDoseReferenceDescription", `ST, `One, false);
0x3008_0076l, ("Calculated Dose Reference Dose Value", "CalculatedDoseReferenceDoseValue", `DS, `One, false);
0x3008_0078l, ("Start Meterset", "StartMeterset", `DS, `One, false);
0x3008_007Al, ("End Meterset", "EndMeterset", `DS, `One, false);
0x3008_0080l, ("Referenced Measured Dose Reference Sequence", "ReferencedMeasuredDoseReferenceSequence", `SQ, `One, false);
0x3008_0082l, ("Referenced Measured Dose Reference Number", "ReferencedMeasuredDoseReferenceNumber", `IS, `One, false);
0x3008_0090l, ("Referenced Calculated Dose Reference Sequence", "ReferencedCalculatedDoseReferenceSequence", `SQ, `One, false);
0x3008_0092l, ("Referenced Calculated Dose Reference Number", "ReferencedCalculatedDoseReferenceNumber", `IS, `One, false);
0x3008_00A0l, ("Beam Limiting Device Leaf Pairs Sequence", "BeamLimitingDeviceLeafPairsSequence", `SQ, `One, false);
0x3008_00B0l, ("Recorded Wedge Sequence", "RecordedWedgeSequence", `SQ, `One, false);
0x3008_00C0l, ("Recorded Compensator Sequence", "RecordedCompensatorSequence", `SQ, `One, false);
0x3008_00D0l, ("Recorded Block Sequence", "RecordedBlockSequence", `SQ, `One, false);
0x3008_00E0l, ("Treatment Summary Measured Dose Reference Sequence", "TreatmentSummaryMeasuredDoseReferenceSequence", `SQ, `One, false);
0x3008_00F0l, ("Recorded Snout Sequence", "RecordedSnoutSequence", `SQ, `One, false);
0x3008_00F2l, ("Recorded Range Shifter Sequence", "RecordedRangeShifterSequence", `SQ, `One, false);
0x3008_00F4l, ("Recorded Lateral Spreading Device Sequence", "RecordedLateralSpreadingDeviceSequence", `SQ, `One, false);
0x3008_00F6l, ("Recorded Range Modulator Sequence", "RecordedRangeModulatorSequence", `SQ, `One, false);
0x3008_0100l, ("Recorded Source Sequence", "RecordedSourceSequence", `SQ, `One, false);
0x3008_0105l, ("Source Serial Number", "SourceSerialNumber", `LO, `One, false);
0x3008_0110l, ("Treatment Session Application Setup Sequence", "TreatmentSessionApplicationSetupSequence", `SQ, `One, false);
0x3008_0116l, ("Application Setup Check", "ApplicationSetupCheck", `CS, `One, false);
0x3008_0120l, ("Recorded Brachy Accessory Device Sequence", "RecordedBrachyAccessoryDeviceSequence", `SQ, `One, false);
0x3008_0122l, ("Referenced Brachy Accessory Device Number", "ReferencedBrachyAccessoryDeviceNumber", `IS, `One, false);
0x3008_0130l, ("Recorded Channel Sequence", "RecordedChannelSequence", `SQ, `One, false);
0x3008_0132l, ("Specified Channel Total Time", "SpecifiedChannelTotalTime", `DS, `One, false);
0x3008_0134l, ("Delivered Channel Total Time", "DeliveredChannelTotalTime", `DS, `One, false);
0x3008_0136l, ("Specified Number of Pulses", "SpecifiedNumberOfPulses", `IS, `One, false);
0x3008_0138l, ("Delivered Number of Pulses", "DeliveredNumberOfPulses", `IS, `One, false);
0x3008_013Al, ("Specified Pulse Repetition Interval", "SpecifiedPulseRepetitionInterval", `DS, `One, false);
0x3008_013Cl, ("Delivered Pulse Repetition Interval", "DeliveredPulseRepetitionInterval", `DS, `One, false);
0x3008_0140l, ("Recorded Source Applicator Sequence", "RecordedSourceApplicatorSequence", `SQ, `One, false);
0x3008_0142l, ("Referenced Source Applicator Number", "ReferencedSourceApplicatorNumber", `IS, `One, false);
0x3008_0150l, ("Recorded Channel Shield Sequence", "RecordedChannelShieldSequence", `SQ, `One, false);
0x3008_0152l, ("Referenced Channel Shield Number", "ReferencedChannelShieldNumber", `IS, `One, false);
0x3008_0160l, ("Brachy Control Point Delivered Sequence", "BrachyControlPointDeliveredSequence", `SQ, `One, false);
0x3008_0162l, ("Safe Position Exit Date", "SafePositionExitDate", `DA, `One, false);
0x3008_0164l, ("Safe Position Exit Time", "SafePositionExitTime", `TM, `One, false);
0x3008_0166l, ("Safe Position Return Date", "SafePositionReturnDate", `DA, `One, false);
0x3008_0168l, ("Safe Position Return Time", "SafePositionReturnTime", `TM, `One, false);
0x3008_0200l, ("Current Treatment Status", "CurrentTreatmentStatus", `CS, `One, false);
0x3008_0202l, ("Treatment Status Comment", "TreatmentStatusComment", `ST, `One, false);
0x3008_0220l, ("Fraction Group Summary Sequence", "FractionGroupSummarySequence", `SQ, `One, false);
0x3008_0223l, ("Referenced Fraction Number", "ReferencedFractionNumber", `IS, `One, false);
0x3008_0224l, ("Fraction Group Type", "FractionGroupType", `CS, `One, false);
0x3008_0230l, ("Beam Stopper Position", "BeamStopperPosition", `CS, `One, false);
0x3008_0240l, ("Fraction Status Summary Sequence", "FractionStatusSummarySequence", `SQ, `One, false);
0x3008_0250l, ("Treatment Date", "TreatmentDate", `DA, `One, false);
0x3008_0251l, ("Treatment Time", "TreatmentTime", `TM, `One, false);
0x300A_0002l, ("RT Plan Label", "RTPlanLabel", `SH, `One, false);
0x300A_0003l, ("RT Plan Name", "RTPlanName", `LO, `One, false);
0x300A_0004l, ("RT Plan Description", "RTPlanDescription", `ST, `One, false);
0x300A_0006l, ("RT Plan Date", "RTPlanDate", `DA, `One, false);
0x300A_0007l, ("RT Plan Time", "RTPlanTime", `TM, `One, false);
0x300A_0009l, ("Treatment Protocols", "TreatmentProtocols", `LO, `One_n, false);
0x300A_000Al, ("Plan Intent", "PlanIntent", `CS, `One, false);
0x300A_000Bl, ("Treatment Sites", "TreatmentSites", `LO, `One_n, false);
0x300A_000Cl, ("RT Plan Geometry", "RTPlanGeometry", `CS, `One, false);
0x300A_000El, ("Prescription Description", "PrescriptionDescription", `ST, `One, false);
0x300A_0010l, ("Dose Reference Sequence", "DoseReferenceSequence", `SQ, `One, false);
0x300A_0012l, ("Dose Reference Number", "DoseReferenceNumber", `IS, `One, false);
0x300A_0013l, ("Dose Reference UID", "DoseReferenceUID", `UI, `One, false);
0x300A_0014l, ("Dose Reference Structure Type", "DoseReferenceStructureType", `CS, `One, false);
0x300A_0015l, ("Nominal Beam Energy Unit", "NominalBeamEnergyUnit", `CS, `One, false);
0x300A_0016l, ("Dose Reference Description", "DoseReferenceDescription", `LO, `One, false);
0x300A_0018l, ("Dose Reference Point Coordinates", "DoseReferencePointCoordinates", `DS, `Three, false);
0x300A_001Al, ("Nominal Prior Dose", "NominalPriorDose", `DS, `One, false);
0x300A_0020l, ("Dose Reference Type", "DoseReferenceType", `CS, `One, false);
0x300A_0021l, ("Constraint Weight", "ConstraintWeight", `DS, `One, false);
0x300A_0022l, ("Delivery Warning Dose", "DeliveryWarningDose", `DS, `One, false);
0x300A_0023l, ("Delivery Maximum Dose", "DeliveryMaximumDose", `DS, `One, false);
0x300A_0025l, ("Target Minimum Dose", "TargetMinimumDose", `DS, `One, false);
0x300A_0026l, ("Target Prescription Dose", "TargetPrescriptionDose", `DS, `One, false);
0x300A_0027l, ("Target Maximum Dose", "TargetMaximumDose", `DS, `One, false);
0x300A_0028l, ("Target Underdose Volume Fraction", "TargetUnderdoseVolumeFraction", `DS, `One, false);
0x300A_002Al, ("Organ at Risk Full-volume Dose", "OrganAtRiskFullVolumeDose", `DS, `One, false);
0x300A_002Bl, ("Organ at Risk Limit Dose", "OrganAtRiskLimitDose", `DS, `One, false);
0x300A_002Cl, ("Organ at Risk Maximum Dose", "OrganAtRiskMaximumDose", `DS, `One, false);
0x300A_002Dl, ("Organ at Risk Overdose Volume Fraction", "OrganAtRiskOverdoseVolumeFraction", `DS, `One, false);
0x300A_0040l, ("Tolerance Table Sequence", "ToleranceTableSequence", `SQ, `One, false);
0x300A_0042l, ("Tolerance Table Number", "ToleranceTableNumber", `IS, `One, false);
0x300A_0043l, ("Tolerance Table Label", "ToleranceTableLabel", `SH, `One, false);
0x300A_0044l, ("Gantry Angle Tolerance", "GantryAngleTolerance", `DS, `One, false);
0x300A_0046l, ("Beam Limiting Device Angle Tolerance", "BeamLimitingDeviceAngleTolerance", `DS, `One, false);
0x300A_0048l, ("Beam Limiting Device Tolerance Sequence", "BeamLimitingDeviceToleranceSequence", `SQ, `One, false);
0x300A_004Al, ("Beam Limiting Device Position Tolerance", "BeamLimitingDevicePositionTolerance", `DS, `One, false);
0x300A_004Bl, ("Snout Position Tolerance", "SnoutPositionTolerance", `FL, `One, false);
0x300A_004Cl, ("Patient Support Angle Tolerance", "PatientSupportAngleTolerance", `DS, `One, false);
0x300A_004El, ("Table Top Eccentric Angle Tolerance", "TableTopEccentricAngleTolerance", `DS, `One, false);
0x300A_004Fl, ("Table Top Pitch Angle Tolerance", "TableTopPitchAngleTolerance", `FL, `One, false);
0x300A_0050l, ("Table Top Roll Angle Tolerance", "TableTopRollAngleTolerance", `FL, `One, false);
0x300A_0051l, ("Table Top Vertical Position Tolerance", "TableTopVerticalPositionTolerance", `DS, `One, false);
0x300A_0052l, ("Table Top Longitudinal Position Tolerance", "TableTopLongitudinalPositionTolerance", `DS, `One, false);
0x300A_0053l, ("Table Top Lateral Position Tolerance", "TableTopLateralPositionTolerance", `DS, `One, false);
0x300A_0055l, ("RT Plan Relationship", "RTPlanRelationship", `CS, `One, false);
0x300A_0070l, ("Fraction Group Sequence", "FractionGroupSequence", `SQ, `One, false);
0x300A_0071l, ("Fraction Group Number", "FractionGroupNumber", `IS, `One, false);
0x300A_0072l, ("Fraction Group Description", "FractionGroupDescription", `LO, `One, false);
0x300A_0078l, ("Number of Fractions Planned", "NumberOfFractionsPlanned", `IS, `One, false);
0x300A_0079l, ("Number of Fraction Pattern Digits Per Day", "NumberOfFractionPatternDigitsPerDay", `IS, `One, false);
0x300A_007Al, ("Repeat Fraction Cycle Length", "RepeatFractionCycleLength", `IS, `One, false);
0x300A_007Bl, ("Fraction Pattern", "FractionPattern", `LT, `One, false);
0x300A_0080l, ("Number of Beams", "NumberOfBeams", `IS, `One, false);
0x300A_0082l, ("Beam Dose Specification Point", "BeamDoseSpecificationPoint", `DS, `Three, false);
0x300A_0084l, ("Beam Dose", "BeamDose", `DS, `One, false);
0x300A_0086l, ("Beam Meterset", "BeamMeterset", `DS, `One, false);
0x300A_0088l, ("Beam Dose Point Depth", "BeamDosePointDepth", `FL, `One, false);
0x300A_0089l, ("Beam Dose Point Equivalent Depth", "BeamDosePointEquivalentDepth", `FL, `One, false);
0x300A_008Al, ("Beam Dose Point SSD", "BeamDosePointSSD", `FL, `One, false);
0x300A_00A0l, ("Number of Brachy Application Setups", "NumberOfBrachyApplicationSetups", `IS, `One, false);
0x300A_00A2l, ("Brachy Application Setup Dose Specification Point", "BrachyApplicationSetupDoseSpecificationPoint", `DS, `Three, false);
0x300A_00A4l, ("Brachy Application Setup Dose", "BrachyApplicationSetupDose", `DS, `One, false);
0x300A_00B0l, ("Beam Sequence", "BeamSequence", `SQ, `One, false);
0x300A_00B2l, ("Treatment Machine Name", "TreatmentMachineName", `SH, `One, false);
0x300A_00B3l, ("Primary Dosimeter Unit", "PrimaryDosimeterUnit", `CS, `One, false);
0x300A_00B4l, ("Source-Axis Distance", "SourceAxisDistance", `DS, `One, false);
0x300A_00B6l, ("Beam Limiting Device Sequence", "BeamLimitingDeviceSequence", `SQ, `One, false);
0x300A_00B8l, ("RT Beam Limiting Device Type", "RTBeamLimitingDeviceType", `CS, `One, false);
0x300A_00BAl, ("Source to Beam Limiting Device Distance", "SourceToBeamLimitingDeviceDistance", `DS, `One, false);
0x300A_00BBl, ("Isocenter to Beam Limiting Device Distance", "IsocenterToBeamLimitingDeviceDistance", `FL, `One, false);
0x300A_00BCl, ("Number of Leaf/Jaw Pairs", "NumberOfLeafJawPairs", `IS, `One, false);
0x300A_00BEl, ("Leaf Position Boundaries", "LeafPositionBoundaries", `DS, `Three_n, false);
0x300A_00C0l, ("Beam Number", "BeamNumber", `IS, `One, false);
0x300A_00C2l, ("Beam Name", "BeamName", `LO, `One, false);
0x300A_00C3l, ("Beam Description", "BeamDescription", `ST, `One, false);
0x300A_00C4l, ("Beam Type", "BeamType", `CS, `One, false);
0x300A_00C6l, ("Radiation Type", "RadiationType", `CS, `One, false);
0x300A_00C7l, ("High-Dose Technique Type", "HighDoseTechniqueType", `CS, `One, false);
0x300A_00C8l, ("Reference Image Number", "ReferenceImageNumber", `IS, `One, false);
0x300A_00CAl, ("Planned Verification Image Sequence", "PlannedVerificationImageSequence", `SQ, `One, false);
0x300A_00CCl, ("Imaging Device-Specific Acquisition Parameters", "ImagingDeviceSpecificAcquisitionParameters", `LO, `One_n, false);
0x300A_00CEl, ("Treatment Delivery Type", "TreatmentDeliveryType", `CS, `One, false);
0x300A_00D0l, ("Number of Wedges", "NumberOfWedges", `IS, `One, false);
0x300A_00D1l, ("Wedge Sequence", "WedgeSequence", `SQ, `One, false);
0x300A_00D2l, ("Wedge Number", "WedgeNumber", `IS, `One, false);
0x300A_00D3l, ("Wedge Type", "WedgeType", `CS, `One, false);
0x300A_00D4l, ("Wedge ID", "WedgeID", `SH, `One, false);
0x300A_00D5l, ("Wedge Angle", "WedgeAngle", `IS, `One, false);
0x300A_00D6l, ("Wedge Factor", "WedgeFactor", `DS, `One, false);
0x300A_00D7l, ("Total Wedge Tray Water-Equivalent Thickness", "TotalWedgeTrayWaterEquivalentThickness", `FL, `One, false);
0x300A_00D8l, ("Wedge Orientation", "WedgeOrientation", `DS, `One, false);
0x300A_00D9l, ("Isocenter to Wedge Tray Distance", "IsocenterToWedgeTrayDistance", `FL, `One, false);
0x300A_00DAl, ("Source to Wedge Tray Distance", "SourceToWedgeTrayDistance", `DS, `One, false);
0x300A_00DBl, ("Wedge Thin Edge Position", "WedgeThinEdgePosition", `FL, `One, false);
0x300A_00DCl, ("Bolus ID", "BolusID", `SH, `One, false);
0x300A_00DDl, ("Bolus Description", "BolusDescription", `ST, `One, false);
0x300A_00E0l, ("Number of Compensators", "NumberOfCompensators", `IS, `One, false);
0x300A_00E1l, ("Material ID", "MaterialID", `SH, `One, false);
0x300A_00E2l, ("Total Compensator Tray Factor", "TotalCompensatorTrayFactor", `DS, `One, false);
0x300A_00E3l, ("Compensator Sequence", "CompensatorSequence", `SQ, `One, false);
0x300A_00E4l, ("Compensator Number", "CompensatorNumber", `IS, `One, false);
0x300A_00E5l, ("Compensator ID", "CompensatorID", `SH, `One, false);
0x300A_00E6l, ("Source to Compensator Tray Distance", "SourceToCompensatorTrayDistance", `DS, `One, false);
0x300A_00E7l, ("Compensator Rows", "CompensatorRows", `IS, `One, false);
0x300A_00E8l, ("Compensator Columns", "CompensatorColumns", `IS, `One, false);
0x300A_00E9l, ("Compensator Pixel Spacing", "CompensatorPixelSpacing", `DS, `Two, false);
0x300A_00EAl, ("Compensator Position", "CompensatorPosition", `DS, `Two, false);
0x300A_00EBl, ("Compensator Transmission Data", "CompensatorTransmissionData", `DS, `One_n, false);
0x300A_00ECl, ("Compensator Thickness Data", "CompensatorThicknessData", `DS, `One_n, false);
0x300A_00EDl, ("Number of Boli", "NumberOfBoli", `IS, `One, false);
0x300A_00EEl, ("Compensator Type", "CompensatorType", `CS, `One, false);
0x300A_00F0l, ("Number of Blocks", "NumberOfBlocks", `IS, `One, false);
0x300A_00F2l, ("Total Block Tray Factor", "TotalBlockTrayFactor", `DS, `One, false);
0x300A_00F3l, ("Total Block Tray Water-Equivalent Thickness", "TotalBlockTrayWaterEquivalentThickness", `FL, `One, false);
0x300A_00F4l, ("Block Sequence", "BlockSequence", `SQ, `One, false);
0x300A_00F5l, ("Block Tray ID", "BlockTrayID", `SH, `One, false);
0x300A_00F6l, ("Source to Block Tray Distance", "SourceToBlockTrayDistance", `DS, `One, false);
0x300A_00F7l, ("Isocenter to Block Tray Distance", "IsocenterToBlockTrayDistance", `FL, `One, false);
0x300A_00F8l, ("Block Type", "BlockType", `CS, `One, false);
0x300A_00F9l, ("Accessory Code", "AccessoryCode", `LO, `One, false);
0x300A_00FAl, ("Block Divergence", "BlockDivergence", `CS, `One, false);
0x300A_00FBl, ("Block Mounting Position", "BlockMountingPosition", `CS, `One, false);
0x300A_00FCl, ("Block Number", "BlockNumber", `IS, `One, false);
0x300A_00FEl, ("Block Name", "BlockName", `LO, `One, false);
0x300A_0100l, ("Block Thickness", "BlockThickness", `DS, `One, false);
0x300A_0102l, ("Block Transmission", "BlockTransmission", `DS, `One, false);
0x300A_0104l, ("Block Number of Points", "BlockNumberOfPoints", `IS, `One, false);
0x300A_0106l, ("Block Data", "BlockData", `DS, `Two_2n, false);
0x300A_0107l, ("Applicator Sequence", "ApplicatorSequence", `SQ, `One, false);
0x300A_0108l, ("Applicator ID", "ApplicatorID", `SH, `One, false);
0x300A_0109l, ("Applicator Type", "ApplicatorType", `CS, `One, false);
0x300A_010Al, ("Applicator Description", "ApplicatorDescription", `LO, `One, false);
0x300A_010Cl, ("Cumulative Dose Reference Coefficient", "CumulativeDoseReferenceCoefficient", `DS, `One, false);
0x300A_010El, ("Final Cumulative Meterset Weight", "FinalCumulativeMetersetWeight", `DS, `One, false);
0x300A_0110l, ("Number of Control Points", "NumberOfControlPoints", `IS, `One, false);
0x300A_0111l, ("Control Point Sequence", "ControlPointSequence", `SQ, `One, false);
0x300A_0112l, ("Control Point Index", "ControlPointIndex", `IS, `One, false);
0x300A_0114l, ("Nominal Beam Energy", "NominalBeamEnergy", `DS, `One, false);
0x300A_0115l, ("Dose Rate Set", "DoseRateSet", `DS, `One, false);
0x300A_0116l, ("Wedge Position Sequence", "WedgePositionSequence", `SQ, `One, false);
0x300A_0118l, ("Wedge Position", "WedgePosition", `CS, `One, false);
0x300A_011Al, ("Beam Limiting Device Position Sequence", "BeamLimitingDevicePositionSequence", `SQ, `One, false);
0x300A_011Cl, ("Leaf/Jaw Positions", "LeafJawPositions", `DS, `Two_2n, false);
0x300A_011El, ("Gantry Angle", "GantryAngle", `DS, `One, false);
0x300A_011Fl, ("Gantry Rotation Direction", "GantryRotationDirection", `CS, `One, false);
0x300A_0120l, ("Beam Limiting Device Angle", "BeamLimitingDeviceAngle", `DS, `One, false);
0x300A_0121l, ("Beam Limiting Device Rotation Direction", "BeamLimitingDeviceRotationDirection", `CS, `One, false);
0x300A_0122l, ("Patient Support Angle", "PatientSupportAngle", `DS, `One, false);
0x300A_0123l, ("Patient Support Rotation Direction", "PatientSupportRotationDirection", `CS, `One, false);
0x300A_0124l, ("Table Top Eccentric Axis Distance", "TableTopEccentricAxisDistance", `DS, `One, false);
0x300A_0125l, ("Table Top Eccentric Angle", "TableTopEccentricAngle", `DS, `One, false);
0x300A_0126l, ("Table Top Eccentric Rotation Direction", "TableTopEccentricRotationDirection", `CS, `One, false);
0x300A_0128l, ("Table Top Vertical Position", "TableTopVerticalPosition", `DS, `One, false);
0x300A_0129l, ("Table Top Longitudinal Position", "TableTopLongitudinalPosition", `DS, `One, false);
0x300A_012Al, ("Table Top Lateral Position", "TableTopLateralPosition", `DS, `One, false);
0x300A_012Cl, ("Isocenter Position", "IsocenterPosition", `DS, `Three, false);
0x300A_012El, ("Surface Entry Point", "SurfaceEntryPoint", `DS, `Three, false);
0x300A_0130l, ("Source to Surface Distance", "SourceToSurfaceDistance", `DS, `One, false);
0x300A_0134l, ("Cumulative Meterset Weight", "CumulativeMetersetWeight", `DS, `One, false);
0x300A_0140l, ("Table Top Pitch Angle", "TableTopPitchAngle", `FL, `One, false);
0x300A_0142l, ("Table Top Pitch Rotation Direction", "TableTopPitchRotationDirection", `CS, `One, false);
0x300A_0144l, ("Table Top Roll Angle", "TableTopRollAngle", `FL, `One, false);
0x300A_0146l, ("Table Top Roll Rotation Direction", "TableTopRollRotationDirection", `CS, `One, false);
0x300A_0148l, ("Head Fixation Angle", "HeadFixationAngle", `FL, `One, false);
0x300A_014Al, ("Gantry Pitch Angle", "GantryPitchAngle", `FL, `One, false);
0x300A_014Cl, ("Gantry Pitch Rotation Direction", "GantryPitchRotationDirection", `CS, `One, false);
0x300A_014El, ("Gantry Pitch Angle Tolerance", "GantryPitchAngleTolerance", `FL, `One, false);
0x300A_0180l, ("Patient Setup Sequence", "PatientSetupSequence", `SQ, `One, false);
0x300A_0182l, ("Patient Setup Number", "PatientSetupNumber", `IS, `One, false);
0x300A_0183l, ("Patient Setup Label", "PatientSetupLabel", `LO, `One, false);
0x300A_0184l, ("Patient Additional Position", "PatientAdditionalPosition", `LO, `One, false);
0x300A_0190l, ("Fixation Device Sequence", "FixationDeviceSequence", `SQ, `One, false);
0x300A_0192l, ("Fixation Device Type", "FixationDeviceType", `CS, `One, false);
0x300A_0194l, ("Fixation Device Label", "FixationDeviceLabel", `SH, `One, false);
0x300A_0196l, ("Fixation Device Description", "FixationDeviceDescription", `ST, `One, false);
0x300A_0198l, ("Fixation Device Position", "FixationDevicePosition", `SH, `One, false);
0x300A_0199l, ("Fixation Device Pitch Angle", "FixationDevicePitchAngle", `FL, `One, false);
0x300A_019Al, ("Fixation Device Roll Angle", "FixationDeviceRollAngle", `FL, `One, false);
0x300A_01A0l, ("Shielding Device Sequence", "ShieldingDeviceSequence", `SQ, `One, false);
0x300A_01A2l, ("Shielding Device Type", "ShieldingDeviceType", `CS, `One, false);
0x300A_01A4l, ("Shielding Device Label", "ShieldingDeviceLabel", `SH, `One, false);
0x300A_01A6l, ("Shielding Device Description", "ShieldingDeviceDescription", `ST, `One, false);
0x300A_01A8l, ("Shielding Device Position", "ShieldingDevicePosition", `SH, `One, false);
0x300A_01B0l, ("Setup Technique", "SetupTechnique", `CS, `One, false);
0x300A_01B2l, ("Setup Technique Description", "SetupTechniqueDescription", `ST, `One, false);
0x300A_01B4l, ("Setup Device Sequence", "SetupDeviceSequence", `SQ, `One, false);
0x300A_01B6l, ("Setup Device Type", "SetupDeviceType", `CS, `One, false);
0x300A_01B8l, ("Setup Device Label", "SetupDeviceLabel", `SH, `One, false);
0x300A_01BAl, ("Setup Device Description", "SetupDeviceDescription", `ST, `One, false);
0x300A_01BCl, ("Setup Device Parameter", "SetupDeviceParameter", `DS, `One, false);
0x300A_01D0l, ("Setup Reference Description", "SetupReferenceDescription", `ST, `One, false);
0x300A_01D2l, ("Table Top Vertical Setup Displacement", "TableTopVerticalSetupDisplacement", `DS, `One, false);
0x300A_01D4l, ("Table Top Longitudinal Setup Displacement", "TableTopLongitudinalSetupDisplacement", `DS, `One, false);
0x300A_01D6l, ("Table Top Lateral Setup Displacement", "TableTopLateralSetupDisplacement", `DS, `One, false);
0x300A_0200l, ("Brachy Treatment Technique", "BrachyTreatmentTechnique", `CS, `One, false);
0x300A_0202l, ("Brachy Treatment Type", "BrachyTreatmentType", `CS, `One, false);
0x300A_0206l, ("Treatment Machine Sequence", "TreatmentMachineSequence", `SQ, `One, false);
0x300A_0210l, ("Source Sequence", "SourceSequence", `SQ, `One, false);
0x300A_0212l, ("Source Number", "SourceNumber", `IS, `One, false);
0x300A_0214l, ("Source Type", "SourceType", `CS, `One, false);
0x300A_0216l, ("Source Manufacturer", "SourceManufacturer", `LO, `One, false);
0x300A_0218l, ("Active Source Diameter", "ActiveSourceDiameter", `DS, `One, false);
0x300A_021Al, ("Active Source Length", "ActiveSourceLength", `DS, `One, false);
0x300A_0222l, ("Source Encapsulation Nominal Thickness", "SourceEncapsulationNominalThickness", `DS, `One, false);
0x300A_0224l, ("Source Encapsulation Nominal Transmission", "SourceEncapsulationNominalTransmission", `DS, `One, false);
0x300A_0226l, ("Source Isotope Name", "SourceIsotopeName", `LO, `One, false);
0x300A_0228l, ("Source Isotope Half Life", "SourceIsotopeHalfLife", `DS, `One, false);
0x300A_0229l, ("Source Strength Units", "SourceStrengthUnits", `CS, `One, false);
0x300A_022Al, ("Reference Air Kerma Rate", "ReferenceAirKermaRate", `DS, `One, false);
0x300A_022Bl, ("Source Strength", "SourceStrength", `DS, `One, false);
0x300A_022Cl, ("Source Strength Reference Date", "SourceStrengthReferenceDate", `DA, `One, false);
0x300A_022El, ("Source Strength Reference Time", "SourceStrengthReferenceTime", `TM, `One, false);
0x300A_0230l, ("Application Setup Sequence", "ApplicationSetupSequence", `SQ, `One, false);
0x300A_0232l, ("Application Setup Type", "ApplicationSetupType", `CS, `One, false);
0x300A_0234l, ("Application Setup Number", "ApplicationSetupNumber", `IS, `One, false);
0x300A_0236l, ("Application Setup Name", "ApplicationSetupName", `LO, `One, false);
0x300A_0238l, ("Application Setup Manufacturer", "ApplicationSetupManufacturer", `LO, `One, false);
0x300A_0240l, ("Template Number", "TemplateNumber", `IS, `One, false);
0x300A_0242l, ("Template Type", "TemplateType", `SH, `One, false);
0x300A_0244l, ("Template Name", "TemplateName", `LO, `One, false);
0x300A_0250l, ("Total Reference Air Kerma", "TotalReferenceAirKerma", `DS, `One, false);
0x300A_0260l, ("Brachy Accessory Device Sequence", "BrachyAccessoryDeviceSequence", `SQ, `One, false);
0x300A_0262l, ("Brachy Accessory Device Number", "BrachyAccessoryDeviceNumber", `IS, `One, false);
0x300A_0263l, ("Brachy Accessory Device ID", "BrachyAccessoryDeviceID", `SH, `One, false);
0x300A_0264l, ("Brachy Accessory Device Type", "BrachyAccessoryDeviceType", `CS, `One, false);
0x300A_0266l, ("Brachy Accessory Device Name", "BrachyAccessoryDeviceName", `LO, `One, false);
0x300A_026Al, ("Brachy Accessory Device Nominal Thickness", "BrachyAccessoryDeviceNominalThickness", `DS, `One, false);
0x300A_026Cl, ("Brachy Accessory Device Nominal Transmission", "BrachyAccessoryDeviceNominalTransmission", `DS, `One, false);
0x300A_0280l, ("Channel Sequence", "ChannelSequence", `SQ, `One, false);
0x300A_0282l, ("Channel Number", "ChannelNumber", `IS, `One, false);
0x300A_0284l, ("Channel Length", "ChannelLength", `DS, `One, false);
0x300A_0286l, ("Channel Total Time", "ChannelTotalTime", `DS, `One, false);
0x300A_0288l, ("Source Movement Type", "SourceMovementType", `CS, `One, false);
0x300A_028Al, ("Number of Pulses", "NumberOfPulses", `IS, `One, false);
0x300A_028Cl, ("Pulse Repetition Interval", "PulseRepetitionInterval", `DS, `One, false);
0x300A_0290l, ("Source Applicator Number", "SourceApplicatorNumber", `IS, `One, false);
0x300A_0291l, ("Source Applicator ID", "SourceApplicatorID", `SH, `One, false);
0x300A_0292l, ("Source Applicator Type", "SourceApplicatorType", `CS, `One, false);
0x300A_0294l, ("Source Applicator Name", "SourceApplicatorName", `LO, `One, false);
0x300A_0296l, ("Source Applicator Length", "SourceApplicatorLength", `DS, `One, false);
0x300A_0298l, ("Source Applicator Manufacturer", "SourceApplicatorManufacturer", `LO, `One, false);
0x300A_029Cl, ("Source Applicator Wall Nominal Thickness", "SourceApplicatorWallNominalThickness", `DS, `One, false);
0x300A_029El, ("Source Applicator Wall Nominal Transmission", "SourceApplicatorWallNominalTransmission", `DS, `One, false);
0x300A_02A0l, ("Source Applicator Step Size", "SourceApplicatorStepSize", `DS, `One, false);
0x300A_02A2l, ("Transfer Tube Number", "TransferTubeNumber", `IS, `One, false);
0x300A_02A4l, ("Transfer Tube Length", "TransferTubeLength", `DS, `One, false);
0x300A_02B0l, ("Channel Shield Sequence", "ChannelShieldSequence", `SQ, `One, false);
0x300A_02B2l, ("Channel Shield Number", "ChannelShieldNumber", `IS, `One, false);
0x300A_02B3l, ("Channel Shield ID", "ChannelShieldID", `SH, `One, false);
0x300A_02B4l, ("Channel Shield Name", "ChannelShieldName", `LO, `One, false);
0x300A_02B8l, ("Channel Shield Nominal Thickness", "ChannelShieldNominalThickness", `DS, `One, false);
0x300A_02BAl, ("Channel Shield Nominal Transmission", "ChannelShieldNominalTransmission", `DS, `One, false);
0x300A_02C8l, ("Final Cumulative Time Weight", "FinalCumulativeTimeWeight", `DS, `One, false);
0x300A_02D0l, ("Brachy Control Point Sequence", "BrachyControlPointSequence", `SQ, `One, false);
0x300A_02D2l, ("Control Point Relative Position", "ControlPointRelativePosition", `DS, `One, false);
0x300A_02D4l, ("Control Point 3D Position", "ControlPoint3DPosition", `DS, `Three, false);
0x300A_02D6l, ("Cumulative Time Weight", "CumulativeTimeWeight", `DS, `One, false);
0x300A_02E0l, ("Compensator Divergence", "CompensatorDivergence", `CS, `One, false);
0x300A_02E1l, ("Compensator Mounting Position", "CompensatorMountingPosition", `CS, `One, false);
0x300A_02E2l, ("Source to Compensator Distance", "SourceToCompensatorDistance", `DS, `One_n, false);
0x300A_02E3l, ("Total Compensator Tray Water-Equivalent Thickness", "TotalCompensatorTrayWaterEquivalentThickness", `FL, `One, false);
0x300A_02E4l, ("Isocenter to Compensator Tray Distance", "IsocenterToCompensatorTrayDistance", `FL, `One, false);
0x300A_02E5l, ("Compensator Column Offset", "CompensatorColumnOffset", `FL, `One, false);
0x300A_02E6l, ("Isocenter to Compensator Distances", "IsocenterToCompensatorDistances", `FL, `One_n, false);
0x300A_02E7l, ("Compensator Relative Stopping Power Ratio", "CompensatorRelativeStoppingPowerRatio", `FL, `One, false);
0x300A_02E8l, ("Compensator Milling Tool Diameter", "CompensatorMillingToolDiameter", `FL, `One, false);
0x300A_02EAl, ("Ion Range Compensator Sequence", "IonRangeCompensatorSequence", `SQ, `One, false);
0x300A_02EBl, ("Compensator Description", "CompensatorDescription", `LT, `One, false);
0x300A_0302l, ("Radiation Mass Number", "RadiationMassNumber", `IS, `One, false);
0x300A_0304l, ("Radiation Atomic Number", "RadiationAtomicNumber", `IS, `One, false);
0x300A_0306l, ("Radiation Charge State", "RadiationChargeState", `SS, `One, false);
0x300A_0308l, ("Scan Mode", "ScanMode", `CS, `One, false);
0x300A_030Al, ("Virtual Source-Axis Distances", "VirtualSourceAxisDistances", `FL, `Two, false);
0x300A_030Cl, ("Snout Sequence", "SnoutSequence", `SQ, `One, false);
0x300A_030Dl, ("Snout Position", "SnoutPosition", `FL, `One, false);
0x300A_030Fl, ("Snout ID", "SnoutID", `SH, `One, false);
0x300A_0312l, ("Number of Range Shifters", "NumberOfRangeShifters", `IS, `One, false);
0x300A_0314l, ("Range Shifter Sequence", "RangeShifterSequence", `SQ, `One, false);
0x300A_0316l, ("Range Shifter Number", "RangeShifterNumber", `IS, `One, false);
0x300A_0318l, ("Range Shifter ID", "RangeShifterID", `SH, `One, false);
0x300A_0320l, ("Range Shifter Type", "RangeShifterType", `CS, `One, false);
0x300A_0322l, ("Range Shifter Description", "RangeShifterDescription", `LO, `One, false);
0x300A_0330l, ("Number of Lateral Spreading Devices", "NumberOfLateralSpreadingDevices", `IS, `One, false);
0x300A_0332l, ("Lateral Spreading Device Sequence", "LateralSpreadingDeviceSequence", `SQ, `One, false);
0x300A_0334l, ("Lateral Spreading Device Number", "LateralSpreadingDeviceNumber", `IS, `One, false);
0x300A_0336l, ("Lateral Spreading Device ID", "LateralSpreadingDeviceID", `SH, `One, false);
0x300A_0338l, ("Lateral Spreading Device Type", "LateralSpreadingDeviceType", `CS, `One, false);
0x300A_033Al, ("Lateral Spreading Device Description", "LateralSpreadingDeviceDescription", `LO, `One, false);
0x300A_033Cl, ("Lateral Spreading Device Water Equivalent Thickness", "LateralSpreadingDeviceWaterEquivalentThickness", `FL, `One, false);
0x300A_0340l, ("Number of Range Modulators", "NumberOfRangeModulators", `IS, `One, false);
0x300A_0342l, ("Range Modulator Sequence", "RangeModulatorSequence", `SQ, `One, false);
0x300A_0344l, ("Range Modulator Number", "RangeModulatorNumber", `IS, `One, false);
0x300A_0346l, ("Range Modulator ID", "RangeModulatorID", `SH, `One, false);
0x300A_0348l, ("Range Modulator Type", "RangeModulatorType", `CS, `One, false);
0x300A_034Al, ("Range Modulator Description", "RangeModulatorDescription", `LO, `One, false);
0x300A_034Cl, ("Beam Current Modulation ID", "BeamCurrentModulationID", `SH, `One, false);
0x300A_0350l, ("Patient Support Type", "PatientSupportType", `CS, `One, false);
0x300A_0352l, ("Patient Support ID", "PatientSupportID", `SH, `One, false);
0x300A_0354l, ("Patient Support Accessory Code", "PatientSupportAccessoryCode", `LO, `One, false);
0x300A_0356l, ("Fixation Light Azimuthal Angle", "FixationLightAzimuthalAngle", `FL, `One, false);
0x300A_0358l, ("Fixation Light Polar Angle", "FixationLightPolarAngle", `FL, `One, false);
0x300A_035Al, ("Meterset Rate", "MetersetRate", `FL, `One, false);
0x300A_0360l, ("Range Shifter Settings Sequence", "RangeShifterSettingsSequence", `SQ, `One, false);
0x300A_0362l, ("Range Shifter Setting", "RangeShifterSetting", `LO, `One, false);
0x300A_0364l, ("Isocenter to Range Shifter Distance", "IsocenterToRangeShifterDistance", `FL, `One, false);
0x300A_0366l, ("Range Shifter Water Equivalent Thickness", "RangeShifterWaterEquivalentThickness", `FL, `One, false);
0x300A_0370l, ("Lateral Spreading Device Settings Sequence", "LateralSpreadingDeviceSettingsSequence", `SQ, `One, false);
0x300A_0372l, ("Lateral Spreading Device Setting", "LateralSpreadingDeviceSetting", `LO, `One, false);
0x300A_0374l, ("Isocenter to Lateral Spreading Device Distance", "IsocenterToLateralSpreadingDeviceDistance", `FL, `One, false);
0x300A_0380l, ("Range Modulator Settings Sequence", "RangeModulatorSettingsSequence", `SQ, `One, false);
0x300A_0382l, ("Range Modulator Gating Start Value", "RangeModulatorGatingStartValue", `FL, `One, false);
0x300A_0384l, ("Range Modulator Gating Stop Value", "RangeModulatorGatingStopValue", `FL, `One, false);
0x300A_0386l, ("Range Modulator Gating Start Water Equivalent Thickness", "RangeModulatorGatingStartWaterEquivalentThickness", `FL, `One, false);
0x300A_0388l, ("Range Modulator Gating Stop Water Equivalent Thickness", "RangeModulatorGatingStopWaterEquivalentThickness", `FL, `One, false);
0x300A_038Al, ("Isocenter to Range Modulator Distance", "IsocenterToRangeModulatorDistance", `FL, `One, false);
0x300A_0390l, ("Scan Spot Tune ID", "ScanSpotTuneID", `SH, `One, false);
0x300A_0392l, ("Number of Scan Spot Positions", "NumberOfScanSpotPositions", `IS, `One, false);
0x300A_0394l, ("Scan Spot Position Map", "ScanSpotPositionMap", `FL, `One_n, false);
0x300A_0396l, ("Scan Spot Meterset Weights", "ScanSpotMetersetWeights", `FL, `One_n, false);
0x300A_0398l, ("Scanning Spot Size", "ScanningSpotSize", `FL, `Two, false);
0x300A_039Al, ("Number of Paintings", "NumberOfPaintings", `IS, `One, false);
0x300A_03A0l, ("Ion Tolerance Table Sequence", "IonToleranceTableSequence", `SQ, `One, false);
0x300A_03A2l, ("Ion Beam Sequence", "IonBeamSequence", `SQ, `One, false);
0x300A_03A4l, ("Ion Beam Limiting Device Sequence", "IonBeamLimitingDeviceSequence", `SQ, `One, false);
0x300A_03A6l, ("Ion Block Sequence", "IonBlockSequence", `SQ, `One, false);
0x300A_03A8l, ("Ion Control Point Sequence", "IonControlPointSequence", `SQ, `One, false);
0x300A_03AAl, ("Ion Wedge Sequence", "IonWedgeSequence", `SQ, `One, false);
0x300A_03ACl, ("Ion Wedge Position Sequence", "IonWedgePositionSequence", `SQ, `One, false);
0x300A_0401l, ("Referenced Setup Image Sequence", "ReferencedSetupImageSequence", `SQ, `One, false);
0x300A_0402l, ("Setup Image Comment", "SetupImageComment", `ST, `One, false);
0x300A_0410l, ("Motion Synchronization Sequence", "MotionSynchronizationSequence", `SQ, `One, false);
0x300A_0412l, ("Control Point Orientation", "ControlPointOrientation", `FL, `Three, false);
0x300A_0420l, ("General Accessory Sequence", "GeneralAccessorySequence", `SQ, `One, false);
0x300A_0421l, ("General Accessory ID", "GeneralAccessoryID", `SH, `One, false);
0x300A_0422l, ("General Accessory Description", "GeneralAccessoryDescription", `ST, `One, false);
0x300A_0423l, ("General Accessory Type", "GeneralAccessoryType", `CS, `One, false);
0x300A_0424l, ("General Accessory Number", "GeneralAccessoryNumber", `IS, `One, false);
0x300A_0431l, ("Applicator Geometry Sequence", "ApplicatorGeometrySequence", `SQ, `One, false);
0x300A_0432l, ("Applicator Aperture Shape", "ApplicatorApertureShape", `CS, `One, false);
0x300A_0433l, ("Applicator Opening", "ApplicatorOpening", `FL, `One, false);
0x300A_0434l, ("Applicator Opening X", "ApplicatorOpeningX", `FL, `One, false);
0x300A_0435l, ("Applicator Opening Y", "ApplicatorOpeningY", `FL, `One, false);
0x300A_0436l, ("Source to Applicator Mounting Position Distance", "SourceToApplicatorMountingPositionDistance", `FL, `One, false);
0x300C_0002l, ("Referenced RT Plan Sequence", "ReferencedRTPlanSequence", `SQ, `One, false);
0x300C_0004l, ("Referenced Beam Sequence", "ReferencedBeamSequence", `SQ, `One, false);
0x300C_0006l, ("Referenced Beam Number", "ReferencedBeamNumber", `IS, `One, false);
0x300C_0007l, ("Referenced Reference Image Number", "ReferencedReferenceImageNumber", `IS, `One, false);
0x300C_0008l, ("Start Cumulative Meterset Weight", "StartCumulativeMetersetWeight", `DS, `One, false);
0x300C_0009l, ("End Cumulative Meterset Weight", "EndCumulativeMetersetWeight", `DS, `One, false);
0x300C_000Al, ("Referenced Brachy Application Setup Sequence", "ReferencedBrachyApplicationSetupSequence", `SQ, `One, false);
0x300C_000Cl, ("Referenced Brachy Application Setup Number", "ReferencedBrachyApplicationSetupNumber", `IS, `One, false);
0x300C_000El, ("Referenced Source Number", "ReferencedSourceNumber", `IS, `One, false);
0x300C_0020l, ("Referenced Fraction Group Sequence", "ReferencedFractionGroupSequence", `SQ, `One, false);
0x300C_0022l, ("Referenced Fraction Group Number", "ReferencedFractionGroupNumber", `IS, `One, false);
0x300C_0040l, ("Referenced Verification Image Sequence", "ReferencedVerificationImageSequence", `SQ, `One, false);
0x300C_0042l, ("Referenced Reference Image Sequence", "ReferencedReferenceImageSequence", `SQ, `One, false);
0x300C_0050l, ("Referenced Dose Reference Sequence", "ReferencedDoseReferenceSequence", `SQ, `One, false);
0x300C_0051l, ("Referenced Dose Reference Number", "ReferencedDoseReferenceNumber", `IS, `One, false);
0x300C_0055l, ("Brachy Referenced Dose Reference Sequence", "BrachyReferencedDoseReferenceSequence", `SQ, `One, false);
0x300C_0060l, ("Referenced Structure Set Sequence", "ReferencedStructureSetSequence", `SQ, `One, false);
0x300C_006Al, ("Referenced Patient Setup Number", "ReferencedPatientSetupNumber", `IS, `One, false);
0x300C_0080l, ("Referenced Dose Sequence", "ReferencedDoseSequence", `SQ, `One, false);
0x300C_00A0l, ("Referenced Tolerance Table Number", "ReferencedToleranceTableNumber", `IS, `One, false);
0x300C_00B0l, ("Referenced Bolus Sequence", "ReferencedBolusSequence", `SQ, `One, false);
0x300C_00C0l, ("Referenced Wedge Number", "ReferencedWedgeNumber", `IS, `One, false);
0x300C_00D0l, ("Referenced Compensator Number", "ReferencedCompensatorNumber", `IS, `One, false);
0x300C_00E0l, ("Referenced Block Number", "ReferencedBlockNumber", `IS, `One, false);
0x300C_00F0l, ("Referenced Control Point Index", "ReferencedControlPointIndex", `IS, `One, false);
0x300C_00F2l, ("Referenced Control Point Sequence", "ReferencedControlPointSequence", `SQ, `One, false);
0x300C_00F4l, ("Referenced Start Control Point Index", "ReferencedStartControlPointIndex", `IS, `One, false);
0x300C_00F6l, ("Referenced Stop Control Point Index", "ReferencedStopControlPointIndex", `IS, `One, false);
0x300C_0100l, ("Referenced Range Shifter Number", "ReferencedRangeShifterNumber", `IS, `One, false);
0x300C_0102l, ("Referenced Lateral Spreading Device Number", "ReferencedLateralSpreadingDeviceNumber", `IS, `One, false);
0x300C_0104l, ("Referenced Range Modulator Number", "ReferencedRangeModulatorNumber", `IS, `One, false);
0x300E_0002l, ("Approval Status", "ApprovalStatus", `CS, `One, false);
0x300E_0004l, ("Review Date", "ReviewDate", `DA, `One, false);
0x300E_0005l, ("Review Time", "ReviewTime", `TM, `One, false);
0x300E_0008l, ("Reviewer Name", "ReviewerName", `PN, `One, false);
0x4000_0010l, ("Arbitrary", "Arbitrary", `LT, `One, true);
0x4000_4000l, ("Text Comments", "TextComments", `LT, `One, true);
0x4008_0040l, ("Results ID", "ResultsID", `SH, `One, true);
0x4008_0042l, ("Results ID Issuer", "ResultsIDIssuer", `LO, `One, true);
0x4008_0050l, ("Referenced Interpretation Sequence", "ReferencedInterpretationSequence", `SQ, `One, true);
0x4008_00FFl, ("Report Production Status (Trial)", "ReportProductionStatusTrial", `CS, `One, true);
0x4008_0100l, ("Interpretation Recorded Date", "InterpretationRecordedDate", `DA, `One, true);
0x4008_0101l, ("Interpretation Recorded Time", "InterpretationRecordedTime", `TM, `One, true);
0x4008_0102l, ("Interpretation Recorder", "InterpretationRecorder", `PN, `One, true);
0x4008_0103l, ("Reference to Recorded Sound", "ReferenceToRecordedSound", `LO, `One, true);
0x4008_0108l, ("Interpretation Transcription Date", "InterpretationTranscriptionDate", `DA, `One, true);
0x4008_0109l, ("Interpretation Transcription Time", "InterpretationTranscriptionTime", `TM, `One, true);
0x4008_010Al, ("Interpretation Transcriber", "InterpretationTranscriber", `PN, `One, true);
0x4008_010Bl, ("Interpretation Text", "InterpretationText", `ST, `One, true);
0x4008_010Cl, ("Interpretation Author", "InterpretationAuthor", `PN, `One, true);
0x4008_0111l, ("Interpretation Approver Sequence", "InterpretationApproverSequence", `SQ, `One, true);
0x4008_0112l, ("Interpretation Approval Date", "InterpretationApprovalDate", `DA, `One, true);
0x4008_0113l, ("Interpretation Approval Time", "InterpretationApprovalTime", `TM, `One, true);
0x4008_0114l, ("Physician Approving Interpretation", "PhysicianApprovingInterpretation", `PN, `One, true);
0x4008_0115l, ("Interpretation Diagnosis Description", "InterpretationDiagnosisDescription", `LT, `One, true);
0x4008_0117l, ("Interpretation Diagnosis Code Sequence", "InterpretationDiagnosisCodeSequence", `SQ, `One, true);
0x4008_0118l, ("Results Distribution List Sequence", "ResultsDistributionListSequence", `SQ, `One, true);
0x4008_0119l, ("Distribution Name", "DistributionName", `PN, `One, true);
0x4008_011Al, ("Distribution Address", "DistributionAddress", `LO, `One, true);
0x4008_0200l, ("Interpretation ID", "InterpretationID", `SH, `One, true);
0x4008_0202l, ("Interpretation ID Issuer", "InterpretationIDIssuer", `LO, `One, true);
0x4008_0210l, ("Interpretation Type ID", "InterpretationTypeID", `CS, `One, true);
0x4008_0212l, ("Interpretation Status ID", "InterpretationStatusID", `CS, `One, true);
0x4008_0300l, ("Impressions", "Impressions", `ST, `One, true);
0x4008_4000l, ("Results Comments", "ResultsComments", `ST, `One, true);
0x4010_0001l, ("Low Energy Detectors", "LowEnergyDetectors", `CS, `One, false);
0x4010_0002l, ("High Energy Detectors", "HighEnergyDetectors", `CS, `One, false);
0x4010_0004l, ("Detector Geometry Sequence", "DetectorGeometrySequence", `SQ, `One, false);
0x4010_1001l, ("Threat ROI Voxel Sequence", "ThreatROIVoxelSequence", `SQ, `One, false);
0x4010_1004l, ("Threat ROI Base", "ThreatROIBase", `FL, `Three, false);
0x4010_1005l, ("Threat ROI Extents", "ThreatROIExtents", `FL, `Three, false);
0x4010_1006l, ("Threat ROI Bitmap", "ThreatROIBitmap", `OB, `One, false);
0x4010_1007l, ("Route Segment ID", "RouteSegmentID", `SH, `One, false);
0x4010_1008l, ("Gantry Type", "GantryType", `CS, `One, false);
0x4010_1009l, ("OOI Owner Type", "OOIOwnerType", `CS, `One, false);
0x4010_100Al, ("Route Segment Sequence", "RouteSegmentSequence", `SQ, `One, false);
0x4010_1010l, ("Potential Threat Object ID", "PotentialThreatObjectID", `US, `One, false);
0x4010_1011l, ("Threat Sequence", "ThreatSequence", `SQ, `One, false);
0x4010_1012l, ("Threat Category", "ThreatCategory", `CS, `One, false);
0x4010_1013l, ("Threat Category Description", "ThreatCategoryDescription", `LT, `One, false);
0x4010_1014l, ("ATD Ability Assessment", "ATDAbilityAssessment", `CS, `One, false);
0x4010_1015l, ("ATD Assessment Flag", "ATDAssessmentFlag", `CS, `One, false);
0x4010_1016l, ("ATD Assessment Probability", "ATDAssessmentProbability", `FL, `One, false);
0x4010_1017l, ("Mass", "Mass", `FL, `One, false);
0x4010_1018l, ("Density", "Density", `FL, `One, false);
0x4010_1019l, ("Z Effective", "ZEffective", `FL, `One, false);
0x4010_101Al, ("Boarding Pass ID", "BoardingPassID", `SH, `One, false);
0x4010_101Bl, ("Center of Mass", "CenterOfMass", `FL, `Three, false);
0x4010_101Cl, ("Center of PTO", "CenterOfPTO", `FL, `Three, false);
0x4010_101Dl, ("Bounding Polygon", "BoundingPolygon", `FL, `Six_n, false);
0x4010_101El, ("Route Segment Start Location ID", "RouteSegmentStartLocationID", `SH, `One, false);
0x4010_101Fl, ("Route Segment End Location ID", "RouteSegmentEndLocationID", `SH, `One, false);
0x4010_1020l, ("Route Segment Location ID Type", "RouteSegmentLocationIDType", `CS, `One, false);
0x4010_1021l, ("Abort Reason", "AbortReason", `CS, `One_n, false);
0x4010_1023l, ("Volume of PTO", "VolumeOfPTO", `FL, `One, false);
0x4010_1024l, ("Abort Flag", "AbortFlag", `CS, `One, false);
0x4010_1025l, ("Route Segment Start Time", "RouteSegmentStartTime", `DT, `One, false);
0x4010_1026l, ("Route Segment End Time", "RouteSegmentEndTime", `DT, `One, false);
0x4010_1027l, ("TDR Type", "TDRType", `CS, `One, false);
0x4010_1028l, ("International Route Segment", "InternationalRouteSegment", `CS, `One, false);
0x4010_1029l, ("Threat Detection Algorithm and Version", "ThreatDetectionAlgorithmandVersion", `LO, `One_n, false);
0x4010_102Al, ("Assigned Location", "AssignedLocation", `SH, `One, false);
0x4010_102Bl, ("Alarm Decision Time", "AlarmDecisionTime", `DT, `One, false);
0x4010_1031l, ("Alarm Decision", "AlarmDecision", `CS, `One, false);
0x4010_1033l, ("Number of Total Objects", "NumberOfTotalObjects", `US, `One, false);
0x4010_1034l, ("Number of Alarm Objects", "NumberOfAlarmObjects", `US, `One, false);
0x4010_1037l, ("PTO Representation Sequence", "PTORepresentationSequence", `SQ, `One, false);
0x4010_1038l, ("ATD Assessment Sequence", "ATDAssessmentSequence", `SQ, `One, false);
0x4010_1039l, ("TIP Type", "TIPType", `CS, `One, false);
0x4010_103Al, ("DICOS Version", "DICOSVersion", `CS, `One, false);
0x4010_1041l, ("OOI Owner Creation Time", "OOIOwnerCreationTime", `DT, `One, false);
0x4010_1042l, ("OOI Type", "OOIType", `CS, `One, false);
0x4010_1043l, ("OOI Size", "OOISize", `FL, `Three, false);
0x4010_1044l, ("Acquisition Status", "AcquisitionStatus", `CS, `One, false);
0x4010_1045l, ("Basis Materials Code Sequence", "BasisMaterialsCodeSequence", `SQ, `One, false);
0x4010_1046l, ("Phantom Type", "PhantomType", `CS, `One, false);
0x4010_1047l, ("OOI Owner Sequence", "OOIOwnerSequence", `SQ, `One, false);
0x4010_1048l, ("Scan Type", "ScanType", `CS, `One, false);
0x4010_1051l, ("Itinerary ID", "ItineraryID", `LO, `One, false);
0x4010_1052l, ("Itinerary ID Type", "ItineraryIDType", `SH, `One, false);
0x4010_1053l, ("Itinerary ID Assigning Authority", "ItineraryIDAssigningAuthority", `LO, `One, false);
0x4010_1054l, ("Route ID", "RouteID", `SH, `One, false);
0x4010_1055l, ("Route ID Assigning Authority", "RouteIDAssigningAuthority", `SH, `One, false);
0x4010_1056l, ("Inbound Arrival Type", "InboundArrivalType", `CS, `One, false);
0x4010_1058l, ("Carrier ID", "CarrierID", `SH, `One, false);
0x4010_1059l, ("Carrier ID Assigning Authority", "CarrierIDAssigningAuthority", `CS, `One, false);
0x4010_1060l, ("Source Orientation", "SourceOrientation", `FL, `Three, false);
0x4010_1061l, ("Source Position", "SourcePosition", `FL, `Three, false);
0x4010_1062l, ("Belt Height", "BeltHeight", `FL, `One, false);
0x4010_1064l, ("Algorithm Routing Code Sequence", "AlgorithmRoutingCodeSequence", `SQ, `One, false);
0x4010_1067l, ("Transport Classification", "TransportClassification", `CS, `One, false);
0x4010_1068l, ("OOI Type Descriptor", "OOITypeDescriptor", `LT, `One, false);
0x4010_1069l, ("Total Processing Time", "TotalProcessingTime", `FL, `One, false);
0x4010_106Cl, ("Detector Calibration Data", "DetectorCalibrationData", `OB, `One, false);
0x4FFE_0001l, ("MAC Parameters Sequence", "MACParametersSequence", `SQ, `One, false);
0x5000_0005l, ("Curve Dimensions", "CurveDimensions", `US, `One, true);
0x5000_0010l, ("Number of Points", "NumberOfPoints", `US, `One, true);
0x5000_0020l, ("Type of Data", "TypeOfData", `CS, `One, true);
0x5000_0022l, ("Curve Description", "CurveDescription", `LO, `One, true);
0x5000_0030l, ("Axis Units", "AxisUnits", `SH, `One_n, true);
0x5000_0040l, ("Axis Labels", "AxisLabels", `SH, `One_n, true);
0x5000_0103l, ("Data Value Representation", "DataValueRepresentation", `US, `One, true);
0x5000_0104l, ("Minimum Coordinate Value", "MinimumCoordinateValue", `US, `One_n, true);
0x5000_0105l, ("Maximum Coordinate Value", "MaximumCoordinateValue", `US, `One_n, true);
0x5000_0106l, ("Curve Range", "CurveRange", `SH, `One_n, true);
0x5000_0110l, ("Curve Data Descriptor", "CurveDataDescriptor", `US, `One_n, true);
0x5000_0112l, ("Coordinate Start Value", "CoordinateStartValue", `US, `One_n, true);
0x5000_0114l, ("Coordinate Step Value", "CoordinateStepValue", `US, `One_n, true);
0x5000_1001l, ("Curve Activation Layer", "CurveActivationLayer", `CS, `One, true);
0x5000_2000l, ("Audio Type", "AudioType", `US, `One, true);
0x5000_2002l, ("Audio Sample Format", "AudioSampleFormat", `US, `One, true);
0x5000_2004l, ("Number of Channels", "NumberOfChannels", `US, `One, true);
0x5000_2006l, ("Number of Samples", "NumberOfSamples", `UL, `One, true);
0x5000_2008l, ("Sample Rate", "SampleRate", `UL, `One, true);
0x5000_200Al, ("Total Time", "TotalTime", `UL, `One, true);
0x5000_200Cl, ("Audio Sample Data", "AudioSampleData", `OB_or_OW, `One, true);
0x5000_200El, ("Audio Comments", "AudioComments", `LT, `One, true);
0x5000_2500l, ("Curve Label", "CurveLabel", `LO, `One, true);
0x5000_2600l, ("Curve Referenced Overlay Sequence", "CurveReferencedOverlaySequence", `SQ, `One, true);
0x5000_2610l, ("Curve Referenced Overlay Group", "CurveReferencedOverlayGroup", `US, `One, true);
0x5000_3000l, ("Curve Data", "CurveData", `OB_or_OW, `One, true);
0x5200_9229l, ("Shared Functional Groups Sequence", "SharedFunctionalGroupsSequence", `SQ, `One, false);
0x5200_9230l, ("Per-frame Functional Groups Sequence", "PerFrameFunctionalGroupsSequence", `SQ, `One, false);
0x5400_0100l, ("Waveform Sequence", "WaveformSequence", `SQ, `One, false);
0x5400_0110l, ("Channel Minimum Value", "ChannelMinimumValue", `OB_or_OW, `One, false);
0x5400_0112l, ("Channel Maximum Value", "ChannelMaximumValue", `OB_or_OW, `One, false);
0x5400_1004l, ("Waveform Bits Allocated", "WaveformBitsAllocated", `US, `One, false);
0x5400_1006l, ("Waveform Sample Interpretation", "WaveformSampleInterpretation", `CS, `One, false);
0x5400_100Al, ("Waveform Padding Value", "WaveformPaddingValue", `OB_or_OW, `One, false);
0x5400_1010l, ("Waveform Data", "WaveformData", `OB_or_OW, `One, false);
0x5600_0010l, ("First Order Phase Correction Angle", "FirstOrderPhaseCorrectionAngle", `OF, `One, false);
0x5600_0020l, ("Spectroscopy Data", "SpectroscopyData", `OF, `One, false);
0x6000_0010l, ("Overlay Rows", "OverlayRows", `US, `One, false);
0x6000_0011l, ("Overlay Columns", "OverlayColumns", `US, `One, false);
0x6000_0012l, ("Overlay Planes", "OverlayPlanes", `US, `One, true);
0x6000_0015l, ("Number of Frames in Overlay", "NumberOfFramesInOverlay", `IS, `One, false);
0x6000_0022l, ("Overlay Description", "OverlayDescription", `LO, `One, false);
0x6000_0040l, ("Overlay Type", "OverlayType", `CS, `One, false);
0x6000_0045l, ("Overlay Subtype", "OverlaySubtype", `LO, `One, false);
0x6000_0050l, ("Overlay Origin", "OverlayOrigin", `SS, `Two, false);
0x6000_0051l, ("Image Frame Origin", "ImageFrameOrigin", `US, `One, false);
0x6000_0052l, ("Overlay Plane Origin", "OverlayPlaneOrigin", `US, `One, true);
0x6000_0060l, ("Overlay Compression Code", "OverlayCompressionCode", `CS, `One, true);
0x6000_0061l, ("Overlay Compression Originator", "OverlayCompressionOriginator", `SH, `One, true);
0x6000_0062l, ("Overlay Compression Label", "OverlayCompressionLabel", `SH, `One, true);
0x6000_0063l, ("Overlay Compression Description", "OverlayCompressionDescription", `CS, `One, true);
0x6000_0066l, ("Overlay Compression Step Pointers", "OverlayCompressionStepPointers", `AT, `One_n, true);
0x6000_0068l, ("Overlay Repeat Interval", "OverlayRepeatInterval", `US, `One, true);
0x6000_0069l, ("Overlay Bits Grouped", "OverlayBitsGrouped", `US, `One, true);
0x6000_0100l, ("Overlay Bits Allocated", "OverlayBitsAllocated", `US, `One, false);
0x6000_0102l, ("Overlay Bit Position", "OverlayBitPosition", `US, `One, false);
0x6000_0110l, ("Overlay Format", "OverlayFormat", `CS, `One, true);
0x6000_0200l, ("Overlay Location", "OverlayLocation", `US, `One, true);
0x6000_0800l, ("Overlay Code Label", "OverlayCodeLabel", `CS, `One_n, true);
0x6000_0802l, ("Overlay Number of Tables", "OverlayNumberOfTables", `US, `One, true);
0x6000_0803l, ("Overlay Code Table Location", "OverlayCodeTableLocation", `AT, `One_n, true);
0x6000_0804l, ("Overlay Bits For Code Word", "OverlayBitsForCodeWord", `US, `One, true);
0x6000_1001l, ("Overlay Activation Layer", "OverlayActivationLayer", `CS, `One, false);
0x6000_1100l, ("Overlay Descriptor - Gray", "OverlayDescriptorGray", `US, `One, true);
0x6000_1101l, ("Overlay Descriptor - Red", "OverlayDescriptorRed", `US, `One, true);
0x6000_1102l, ("Overlay Descriptor - Green", "OverlayDescriptorGreen", `US, `One, true);
0x6000_1103l, ("Overlay Descriptor - Blue", "OverlayDescriptorBlue", `US, `One, true);
0x6000_1200l, ("Overlays - Gray", "OverlaysGray", `US, `One_n, true);
0x6000_1201l, ("Overlays - Red", "OverlaysRed", `US, `One_n, true);
0x6000_1202l, ("Overlays - Green", "OverlaysGreen", `US, `One_n, true);
0x6000_1203l, ("Overlays - Blue", "OverlaysBlue", `US, `One_n, true);
0x6000_1301l, ("ROI Area", "ROIArea", `IS, `One, false);
0x6000_1302l, ("ROI Mean", "ROIMean", `DS, `One, false);
0x6000_1303l, ("ROI Standard Deviation", "ROIStandardDeviation", `DS, `One, false);
0x6000_1500l, ("Overlay Label", "OverlayLabel", `LO, `One, false);
0x6000_3000l, ("Overlay Data", "OverlayData", `OB_or_OW, `One, false);
0x6000_4000l, ("Overlay Comments", "OverlayComments", `LT, `One, true);
0x7FE0_0010l, ("Pixel Data", "PixelData", `OB_or_OW, `One, false);
0x7FE0_0020l, ("Coefficients SDVN", "CoefficientsSDVN", `OW, `One, true);
0x7FE0_0030l, ("Coefficients SDHN", "CoefficientsSDHN", `OW, `One, true);
0x7FE0_0040l, ("Coefficients SDDN", "CoefficientsSDDN", `OW, `One, true);
0x7F00_0010l, ("Variable Pixel Data", "VariablePixelData", `OB_or_OW, `One, true);
0x7F00_0011l, ("Variable Next Data Group", "VariableNextDataGroup", `US, `One, true);
0x7F00_0020l, ("Variable Coefficients SDVN", "VariableCoefficientsSDVN", `OW, `One, true);
0x7F00_0030l, ("Variable Coefficients SDHN", "VariableCoefficientsSDHN", `OW, `One, true);
0x7F00_0040l, ("Variable Coefficients SDDN", "VariableCoefficientsSDDN", `OW, `One, true);
0xFFFA_FFFAl, ("Digital Signatures Sequence", "DigitalSignaturesSequence", `SQ, `One, false);
0xFFFC_FFFCl, ("Data Set Trailing Padding", "DataSetTrailingPadding", `OB, `One, false);
]

let element_ranges = [ (* Data element equivalence classes *)
0x0020_3100l, 0xFFFF_FF00l; 
0x0028_0400l, 0xFFFF_FF0Fl;
0x0028_0401l, 0xFFFF_FF0Fl;
0x0028_0402l, 0xFFFF_FF0Fl;
0x0028_0403l, 0xFFFF_FF0Fl;
0x0028_0800l, 0xFFFF_FF0Fl;
0x0028_0802l, 0xFFFF_FF0Fl;
0x0028_0803l, 0xFFFF_FF0Fl;
0x0028_0804l, 0xFFFF_FF0Fl;
0x0028_0808l, 0xFFFF_FF0Fl;
0x1000_0000l, 0xFFFF_000Fl;
0x1000_0001l, 0xFFFF_000Fl;
0x1000_0002l, 0xFFFF_000Fl;
0x1000_0003l, 0xFFFF_000Fl;
0x1000_0004l, 0xFFFF_000Fl;
0x1000_0005l, 0xFFFF_000Fl;
0x1010_0000l, 0xFFFF_0000l;
0x5000_0005l, 0xFF00_FFFFl;
0x5000_0010l, 0xFF00_FFFFl;
0x5000_0020l, 0xFF00_FFFFl;
0x5000_0022l, 0xFF00_FFFFl;
0x5000_0030l, 0xFF00_FFFFl;
0x5000_0040l, 0xFF00_FFFFl;
0x5000_0103l, 0xFF00_FFFFl;
0x5000_0104l, 0xFF00_FFFFl;
0x5000_0105l, 0xFF00_FFFFl;
0x5000_0106l, 0xFF00_FFFFl;
0x5000_0110l, 0xFF00_FFFFl;
0x5000_0112l, 0xFF00_FFFFl;
0x5000_0114l, 0xFF00_FFFFl;
0x5000_1001l, 0xFF00_FFFFl;
0x5000_2000l, 0xFF00_FFFFl;
0x5000_2002l, 0xFF00_FFFFl;
0x5000_2004l, 0xFF00_FFFFl;
0x5000_2006l, 0xFF00_FFFFl;
0x5000_2008l, 0xFF00_FFFFl;
0x5000_200Al, 0xFF00_FFFFl;
0x5000_200Cl, 0xFF00_FFFFl;
0x5000_200El, 0xFF00_FFFFl;
0x5000_2500l, 0xFF00_FFFFl;
0x5000_2600l, 0xFF00_FFFFl;
0x5000_2610l, 0xFF00_FFFFl;
0x5000_3000l, 0xFF00_FFFFl;
0x6000_0010l, 0xFF00_FFFFl;
0x6000_0011l, 0xFF00_FFFFl;
0x6000_0012l, 0xFF00_FFFFl;
0x6000_0015l, 0xFF00_FFFFl;
0x6000_0022l, 0xFF00_FFFFl;
0x6000_0040l, 0xFF00_FFFFl;
0x6000_0045l, 0xFF00_FFFFl;
0x6000_0050l, 0xFF00_FFFFl;
0x6000_0051l, 0xFF00_FFFFl;
0x6000_0052l, 0xFF00_FFFFl;
0x6000_0060l, 0xFF00_FFFFl;
0x6000_0061l, 0xFF00_FFFFl;
0x6000_0062l, 0xFF00_FFFFl;
0x6000_0063l, 0xFF00_FFFFl;
0x6000_0066l, 0xFF00_FFFFl;
0x6000_0068l, 0xFF00_FFFFl;
0x6000_0069l, 0xFF00_FFFFl;
0x6000_0100l, 0xFF00_FFFFl;
0x6000_0102l, 0xFF00_FFFFl;
0x6000_0110l, 0xFF00_FFFFl;
0x6000_0200l, 0xFF00_FFFFl;
0x6000_0800l, 0xFF00_FFFFl;
0x6000_0802l, 0xFF00_FFFFl;
0x6000_0803l, 0xFF00_FFFFl;
0x6000_0804l, 0xFF00_FFFFl;
0x6000_1001l, 0xFF00_FFFFl;
0x6000_1100l, 0xFF00_FFFFl;
0x6000_1101l, 0xFF00_FFFFl;
0x6000_1102l, 0xFF00_FFFFl;
0x6000_1103l, 0xFF00_FFFFl;
0x6000_1200l, 0xFF00_FFFFl;
0x6000_1201l, 0xFF00_FFFFl;
0x6000_1202l, 0xFF00_FFFFl;
0x6000_1203l, 0xFF00_FFFFl;
0x6000_1301l, 0xFF00_FFFFl;
0x6000_1302l, 0xFF00_FFFFl;
0x6000_1303l, 0xFF00_FFFFl;
0x6000_1500l, 0xFF00_FFFFl;
0x6000_3000l, 0xFF00_FFFFl;
0x6000_4000l, 0xFF00_FFFFl;
0x7F00_0010l, 0xFF00_FFFFl;
0x7F00_0011l, 0xFF00_FFFFl;
0x7F00_0020l, 0xFF00_FFFFl;
0x7F00_0030l, 0xFF00_FFFFl;
0x7F00_0040l, 0xFF00_FFFFl; ]


(* UIDs and their names as found in PS 3.6 2011 Annex A *) 
let uid_names = [                        
(* Table A-1 *)
"1.2.840.10008.1.1", "Verification SOP Class";
"1.2.840.10008.1.2", "Implicit VR Little Endian: Default Transfer Syntax for DICOM";
"1.2.840.10008.1.2.1", "Explicit VR Little Endian";
"1.2.840.10008.1.2.1.99", "Deflated Explicit VR Little Endian";
"1.2.840.10008.1.2.2", "Explicit VR Big Endian";
"1.2.840.10008.1.2.4.50", "JPEG Baseline (Process 1): Default Transfer Syntax for Lossy JPEG 8 Bit Image Compression";
"1.2.840.10008.1.2.4.51", "JPEG Extended (Process 2 & 4): Default Transfer Syntax for Lossy JPEG 12 Bit Image Compression (Process 4 only)";
"1.2.840.10008.1.2.4.52", "JPEG Extended (Process 3 & 5) (Retired)";
"1.2.840.10008.1.2.4.53", "JPEG Spectral Selection, Non-Hierarchical (Process 6 & 8) (Retired)";
"1.2.840.10008.1.2.4.54", "JPEG Spectral Selection, Non-Hierarchical (Process 7 & 9) (Retired)";
"1.2.840.10008.1.2.4.55", "JPEG Full Progression, Non-Hierarchical (Process 10 & 12) (Retired)";
"1.2.840.10008.1.2.4.56", "JPEG Full Progression, Non-Hierarchical (Process 11 & 13) (Retired)";
"1.2.840.10008.1.2.4.57", "JPEG Lossless, Non-Hierarchical (Process 14)";
"1.2.840.10008.1.2.4.58", "JPEG Lossless, Non-Hierarchical (Process 15) (Retired)";
"1.2.840.10008.1.2.4.59", "JPEG Extended, Hierarchical (Process 16 & 18) (Retired)";
"1.2.840.10008.1.2.4.60", "JPEG Extended, Hierarchical (Process 17 & 19) (Retired)";
"1.2.840.10008.1.2.4.61", "JPEG Spectral Selection, Hierarchical (Process 20 & 22) (Retired)";
"1.2.840.10008.1.2.4.62", "JPEG Spectral Selection, Hierarchical (Process 21 & 23) (Retired)";
"1.2.840.10008.1.2.4.63", "JPEG Full Progression, Hierarchical (Process 24 & 26) (Retired)";
"1.2.840.10008.1.2.4.64", "JPEG Full Progression, Hierarchical (Process 25 & 27) (Retired)";
"1.2.840.10008.1.2.4.65", "JPEG Lossless, Hierarchical (Process 28) (Retired)";
"1.2.840.10008.1.2.4.66", "JPEG Lossless, Hierarchical (Process 29) (Retired)";
"1.2.840.10008.1.2.4.70", "JPEG Lossless, Non-Hierarchical, First-Order Prediction (Process 14 [Selection Value 1]): Default Transfer Syntax for Lossless JPEG Image Compression";
"1.2.840.10008.1.2.4.80", "JPEG-LS Lossless Image Compression";
"1.2.840.10008.1.2.4.81", "JPEG-LS Lossy (Near-Lossless) Image Compression";
"1.2.840.10008.1.2.4.90", "JPEG 2000 Image Compression (Lossless Only)";
"1.2.840.10008.1.2.4.91", "JPEG 2000 Image Compression";
"1.2.840.10008.1.2.4.92", "JPEG 2000 Part 2 Multi-component Image Compression (Lossless Only)";
"1.2.840.10008.1.2.4.93", "JPEG 2000 Part 2 Multi-component Image Compression";
"1.2.840.10008.1.2.4.94", "JPIP Referenced";
"1.2.840.10008.1.2.4.95", "JPIP Referenced Deflate";
"1.2.840.10008.1.2.4.100", "MPEG2 Main Profile @ Main Level";
"1.2.840.10008.1.2.4.101", "MPEG2 Main Profile @ High Level";
"1.2.840.10008.1.2.4.102", "MPEG-4 AVC/H.264 High Profile / Level 4.1";
"1.2.840.10008.1.2.4.103", "MPEG-4 AVC/H.264 BD-compatible High Profile / Level 4.1";
"1.2.840.10008.1.2.5", "RLE Lossless";
"1.2.840.10008.1.2.6.1", "RFC 2557 MIME encapsulation";
"1.2.840.10008.1.2.6.2", "XML Encoding";
"1.2.840.10008.1.3.10", "Media Storage Directory Storage";
"1.2.840.10008.1.4.1.1", "Talairach Brain Atlas Frame of Reference";
"1.2.840.10008.1.4.1.2", "SPM2 T1 Frame of Reference";
"1.2.840.10008.1.4.1.3", "SPM2 T2 Frame of Reference";
"1.2.840.10008.1.4.1.4", "SPM2 PD Frame of Reference";
"1.2.840.10008.1.4.1.5", "SPM2 EPI Frame of Reference";
"1.2.840.10008.1.4.1.6", "SPM2 FIL T1 Frame of Reference";
"1.2.840.10008.1.4.1.7", "SPM2 PET Frame of Reference";
"1.2.840.10008.1.4.1.8", "SPM2 TRANSM Frame of Reference";
"1.2.840.10008.1.4.1.9", "SPM2 SPECT Frame of Reference";
"1.2.840.10008.1.4.1.10", "SPM2 GRAY Frame of Reference";
"1.2.840.10008.1.4.1.11", "SPM2 WHITE Frame of Reference";
"1.2.840.10008.1.4.1.12", "SPM2 CSF Frame of Reference";
"1.2.840.10008.1.4.1.13", "SPM2 BRAINMASK Frame of Reference";
"1.2.840.10008.1.4.1.14", "SPM2 AVG305T1 Frame of Reference";
"1.2.840.10008.1.4.1.15", "SPM2 AVG152T1 Frame of Reference";
"1.2.840.10008.1.4.1.16", "SPM2 AVG152T2 Frame of Reference";
"1.2.840.10008.1.4.1.17", "SPM2 AVG152PD Frame of Reference";
"1.2.840.10008.1.4.1.18", "SPM2 SINGLESUBJT1 Frame of Reference";
"1.2.840.10008.1.4.2.1", "ICBM 452 T1 Frame of Reference";
"1.2.840.10008.1.4.2.2", "ICBM Single Subject MRI Frame of Reference";
"1.2.840.10008.1.5.1", "Hot Iron Color Palette SOP Instance";
"1.2.840.10008.1.5.2", "PET Color Palette SOP Instance";
"1.2.840.10008.1.5.3", "Hot Metal Blue Color Palette SOP Instance";
"1.2.840.10008.1.5.4", "PET 20 Step Color Palette SOP Instance";
"1.2.840.10008.1.9", "Basic Study Content Notification SOP Class (Retired)";
"1.2.840.10008.1.20.1", "Storage Commitment Push Model SOP Class";
"1.2.840.10008.1.20.1.1", "Storage Commitment Push Model SOP Instance";
"1.2.840.10008.1.20.2", "Storage Commitment Pull Model SOP Class (Retired)";
"1.2.840.10008.1.20.2.1", "Storage Commitment Pull Model SOP Instance (Retired)";
"1.2.840.10008.1.40", "Procedural Event Logging SOP Class";
"1.2.840.10008.1.40.1", "Procedural Event Logging SOP Instance";
"1.2.840.10008.1.42", "Substance Administration Logging SOP Class";
"1.2.840.10008.1.42.1", "Substance Administration Logging SOP Instance";
"1.2.840.10008.2.6.1", "DICOM UID Registry";
"1.2.840.10008.2.16.4", "DICOM Controlled Terminology";
"1.2.840.10008.3.1.1.1", "DICOM Application Context Name";
"1.2.840.10008.3.1.2.1.1", "Detached Patient Management SOP Class (Retired)";
"1.2.840.10008.3.1.2.1.4", "Detached Patient Management Meta SOP Class (Retired)";
"1.2.840.10008.3.1.2.2.1", "Detached Visit Management SOP Class (Retired)";
"1.2.840.10008.3.1.2.3.1", "Detached Study Management SOP Class (Retired)";
"1.2.840.10008.3.1.2.3.2", "Study Component Management SOP Class (Retired)";
"1.2.840.10008.3.1.2.3.3", "Modality Performed Procedure Step SOP Class";
"1.2.840.10008.3.1.2.3.4", "Modality Performed Procedure Step Retrieve SOP Class";
"1.2.840.10008.3.1.2.3.5", "Modality Performed Procedure Step Notification SOP Class";
"1.2.840.10008.3.1.2.5.1", "Detached Results Management SOP Class (Retired)";
"1.2.840.10008.3.1.2.5.4", "Detached Results Management Meta SOP Class (Retired)";
"1.2.840.10008.3.1.2.5.5", "Detached Study Management Meta SOP Class (Retired)";
"1.2.840.10008.3.1.2.6.1", "Detached Interpretation Management SOP Class (Retired)";
"1.2.840.10008.4.2", "Storage Service Class";
"1.2.840.10008.5.1.1.1", "Basic Film Session SOP Class";
"1.2.840.10008.5.1.1.2", "Basic Film Box SOP Class";
"1.2.840.10008.5.1.1.4", "Basic Grayscale Image Box SOP Class";
"1.2.840.10008.5.1.1.4.1", "Basic Color Image Box SOP Class";
"1.2.840.10008.5.1.1.4.2", "Referenced Image Box SOP Class (Retired)";
"1.2.840.10008.5.1.1.9", "Basic Grayscale Print Management Meta SOP Class";
"1.2.840.10008.5.1.1.9.1", "Referenced Grayscale Print Management Meta SOP Class (Retired)";
"1.2.840.10008.5.1.1.14", "Print Job SOP Class";
"1.2.840.10008.5.1.1.15", "Basic Annotation Box SOP Class";
"1.2.840.10008.5.1.1.16", "Printer SOP Class";
"1.2.840.10008.5.1.1.16.376", "Printer Configuration Retrieval SOP Class";
"1.2.840.10008.5.1.1.17", "Printer SOP Instance";
"1.2.840.10008.5.1.1.17.376", "Printer Configuration Retrieval SOP Instance";
"1.2.840.10008.5.1.1.18", "Basic Color Print Management Meta SOP Class";
"1.2.840.10008.5.1.1.18.1", "Referenced Color Print Management Meta SOP Class (Retired)";
"1.2.840.10008.5.1.1.22", "VOI LUT Box SOP Class";
"1.2.840.10008.5.1.1.23", "Presentation LUT SOP Class";
"1.2.840.10008.5.1.1.24", "Image Overlay Box SOP Class (Retired)";
"1.2.840.10008.5.1.1.24.1", "Basic Print Image Overlay Box SOP Class (Retired)";
"1.2.840.10008.5.1.1.25", "Print Queue SOP Instance (Retired)";
"1.2.840.10008.5.1.1.26", "Print Queue Management SOP Class (Retired)";
"1.2.840.10008.5.1.1.27", "Stored Print Storage SOP Class (Retired)";
"1.2.840.10008.5.1.1.29", "Hardcopy Grayscale Image Storage SOP Class (Retired)";
"1.2.840.10008.5.1.1.30", "Hardcopy Color Image Storage SOP Class (Retired)";
"1.2.840.10008.5.1.1.31", "Pull Print Request SOP Class (Retired)";
"1.2.840.10008.5.1.1.32", "Pull Stored Print Management Meta SOP Class (Retired)";
"1.2.840.10008.5.1.1.33", "Media Creation Management SOP Class UID";
"1.2.840.10008.5.1.4.1.1.1", "Computed Radiography Image Storage";
"1.2.840.10008.5.1.4.1.1.1.1", "Digital X-Ray Image Storage - For Presentation";
"1.2.840.10008.5.1.4.1.1.1.1.1", "Digital X-Ray Image Storage - For Processing";
"1.2.840.10008.5.1.4.1.1.1.2", "Digital Mammography X-Ray Image Storage - For Presentation";
"1.2.840.10008.5.1.4.1.1.1.2.1", "Digital Mammography X-Ray Image Storage - For Processing";
"1.2.840.10008.5.1.4.1.1.1.3", "Digital Intra-oral X-Ray Image Storage - For Presentation";
"1.2.840.10008.5.1.4.1.1.1.3.1", "Digital Intra-oral X-Ray Image Storage - For Processing";
"1.2.840.10008.5.1.4.1.1.2", "CT Image Storage";
"1.2.840.10008.5.1.4.1.1.2.1", "Enhanced CT Image Storage";
"1.2.840.10008.5.1.4.1.1.3", "Ultrasound Multi-frame Image Storage (Retired)";
"1.2.840.10008.5.1.4.1.1.3.1", "Ultrasound Multi-frame Image Storage";
"1.2.840.10008.5.1.4.1.1.4", "MR Image Storage";
"1.2.840.10008.5.1.4.1.1.4.1", "Enhanced MR Image Storage";
"1.2.840.10008.5.1.4.1.1.4.2", "MR Spectroscopy Storage";
"1.2.840.10008.5.1.4.1.1.4.3", "Enhanced MR Color Image Storage";
"1.2.840.10008.5.1.4.1.1.5", "Nuclear Medicine Image Storage (Retired)";
"1.2.840.10008.5.1.4.1.1.6", "Ultrasound Image Storage (Retired)";
"1.2.840.10008.5.1.4.1.1.6.1", "Ultrasound Image Storage";
"1.2.840.10008.5.1.4.1.1.6.2", "Enhanced US Volume Storage";
"1.2.840.10008.5.1.4.1.1.7", "Secondary Capture Image Storage";
"1.2.840.10008.5.1.4.1.1.7.1", "Multi-frame Single Bit Secondary Capture Image Storage";
"1.2.840.10008.5.1.4.1.1.7.2", "Multi-frame Grayscale Byte Secondary Capture Image Storage";
"1.2.840.10008.5.1.4.1.1.7.3", "Multi-frame Grayscale Word Secondary Capture Image Storage";
"1.2.840.10008.5.1.4.1.1.7.4", "Multi-frame True Color Secondary Capture Image Storage";
"1.2.840.10008.5.1.4.1.1.8", "Standalone Overlay Storage (Retired)";
"1.2.840.10008.5.1.4.1.1.9", "Standalone Curve Storage (Retired)";
"1.2.840.10008.5.1.4.1.1.9.1", "Waveform Storage - Trial (Retired)";
"1.2.840.10008.5.1.4.1.1.9.1.1", "12-lead ECG Waveform Storage";
"1.2.840.10008.5.1.4.1.1.9.1.2", "General ECG Waveform Storage";
"1.2.840.10008.5.1.4.1.1.9.1.3", "Ambulatory ECG Waveform Storage";
"1.2.840.10008.5.1.4.1.1.9.2.1", "Hemodynamic Waveform Storage";
"1.2.840.10008.5.1.4.1.1.9.3.1", "Cardiac Electrophysiology Waveform Storage";
"1.2.840.10008.5.1.4.1.1.9.4.1", "Basic Voice Audio Waveform Storage";
"1.2.840.10008.5.1.4.1.1.9.4.2", "General Audio Waveform Storage";
"1.2.840.10008.5.1.4.1.1.9.5.1", "Arterial Pulse Waveform Storage";
"1.2.840.10008.5.1.4.1.1.9.6.1", "Respiratory Waveform Storage";
"1.2.840.10008.5.1.4.1.1.10", "Standalone Modality LUT Storage (Retired)";
"1.2.840.10008.5.1.4.1.1.11", "Standalone VOI LUT Storage (Retired)";
"1.2.840.10008.5.1.4.1.1.11.1", "Grayscale Softcopy Presentation State Storage SOP Class";
"1.2.840.10008.5.1.4.1.1.11.2", "Color Softcopy Presentation State Storage SOP Class";
"1.2.840.10008.5.1.4.1.1.11.3", "Pseudo-Color Softcopy Presentation State Storage SOP Class";
"1.2.840.10008.5.1.4.1.1.11.4", "Blending Softcopy Presentation State Storage SOP Class";
"1.2.840.10008.5.1.4.1.1.11.5", "XA/XRF Grayscale Softcopy Presentation State Storage";
"1.2.840.10008.5.1.4.1.1.12.1", "X-Ray Angiographic Image Storage";
"1.2.840.10008.5.1.4.1.1.12.1.1", "Enhanced XA Image Storage";
"1.2.840.10008.5.1.4.1.1.12.2", "X-Ray Radiofluoroscopic Image Storage";
"1.2.840.10008.5.1.4.1.1.12.2.1", "Enhanced XRF Image Storage";
"1.2.840.10008.5.1.4.1.1.12.3", "X-Ray Angiographic Bi-Plane Image Storage (Retired)";
"1.2.840.10008.5.1.4.1.1.13.1.1", "X-Ray 3D Angiographic Image Storage";
"1.2.840.10008.5.1.4.1.1.13.1.2", "X-Ray 3D Craniofacial Image Storage";
"1.2.840.10008.5.1.4.1.1.13.1.3", "Breast Tomosynthesis Image Storage";
"1.2.840.10008.5.1.4.1.1.14.1", "Intravascular Optical Coherence Tomography Image Storage - For Presentation";
"1.2.840.10008.5.1.4.1.1.14.2", "Intravascular Optical Coherence Tomography Image Storage - For Processing";
"1.2.840.10008.5.1.4.1.1.20", "Nuclear Medicine Image Storage";
"1.2.840.10008.5.1.4.1.1.66", "Raw Data Storage";
"1.2.840.10008.5.1.4.1.1.66.1", "Spatial Registration Storage";
"1.2.840.10008.5.1.4.1.1.66.2", "Spatial Fiducials Storage";
"1.2.840.10008.5.1.4.1.1.66.3", "Deformable Spatial Registration Storage";
"1.2.840.10008.5.1.4.1.1.66.4", "Segmentation Storage";
"1.2.840.10008.5.1.4.1.1.66.5", "Surface Segmentation Storage";
"1.2.840.10008.5.1.4.1.1.67", "Real World Value Mapping Storage";
"1.2.840.10008.5.1.4.1.1.77.1", "VL Image Storage - Trial (Retired)";
"1.2.840.10008.5.1.4.1.1.77.2", "VL Multi-frame Image Storage - Trial (Retired)";
"1.2.840.10008.5.1.4.1.1.77.1.1", "VL Endoscopic Image Storage";
"1.2.840.10008.5.1.4.1.1.77.1.1.1", "Video Endoscopic Image Storage";
"1.2.840.10008.5.1.4.1.1.77.1.2", "VL Microscopic Image Storage";
"1.2.840.10008.5.1.4.1.1.77.1.2.1", "Video Microscopic Image Storage";
"1.2.840.10008.5.1.4.1.1.77.1.3", "VL Slide-Coordinates Microscopic Image Storage";
"1.2.840.10008.5.1.4.1.1.77.1.4", "VL Photographic Image Storage";
"1.2.840.10008.5.1.4.1.1.77.1.4.1", "Video Photographic Image Storage";
"1.2.840.10008.5.1.4.1.1.77.1.5.1", "Ophthalmic Photography 8 Bit Image Storage";
"1.2.840.10008.5.1.4.1.1.77.1.5.2", "Ophthalmic Photography 16 Bit Image Storage";
"1.2.840.10008.5.1.4.1.1.77.1.5.3", "Stereometric Relationship Storage";
"1.2.840.10008.5.1.4.1.1.77.1.5.4", "Ophthalmic Tomography Image Storage";
"1.2.840.10008.5.1.4.1.1.77.1.6", "VL Whole Slide Microscopy Image Storage";
"1.2.840.10008.5.1.4.1.1.78.1", "Lensometry Measurements Storage";
"1.2.840.10008.5.1.4.1.1.78.2", "Autorefraction Measurements Storage";
"1.2.840.10008.5.1.4.1.1.78.3", "Keratometry Measurements Storage";
"1.2.840.10008.5.1.4.1.1.78.4", "Subjective Refraction Measurements Storage";
"1.2.840.10008.5.1.4.1.1.78.5", "Visual Acuity Measurements Storage";
"1.2.840.10008.5.1.4.1.1.78.6", "Spectacle Prescription Report Storage";
"1.2.840.10008.5.1.4.1.1.78.7", "Ophthalmic Axial Measurements Storage";
"1.2.840.10008.5.1.4.1.1.78.8", "Intraocular Lens Calculations Storage";
"1.2.840.10008.5.1.4.1.1.79.1", "Macular Grid Thickness and Volume Report Storage";
"1.2.840.10008.5.1.4.1.1.80.1", "Ophthalmic Visual Field Static Perimetry Measurements Storage";
"1.2.840.10008.5.1.4.1.1.88.1", "Text SR Storage - Trial (Retired)";
"1.2.840.10008.5.1.4.1.1.88.2", "Audio SR Storage - Trial (Retired)";
"1.2.840.10008.5.1.4.1.1.88.3", "Detail SR Storage - Trial (Retired)";
"1.2.840.10008.5.1.4.1.1.88.4", "Comprehensive SR Storage - Trial (Retired)";
"1.2.840.10008.5.1.4.1.1.88.11", "Basic Text SR Storage";
"1.2.840.10008.5.1.4.1.1.88.22", "Enhanced SR Storage";
"1.2.840.10008.5.1.4.1.1.88.33", "Comprehensive SR Storage";
"1.2.840.10008.5.1.4.1.1.88.40", "Procedure Log Storage";
"1.2.840.10008.5.1.4.1.1.88.50", "Mammography CAD SR Storage";
"1.2.840.10008.5.1.4.1.1.88.59", "Key Object Selection Document Storage";
"1.2.840.10008.5.1.4.1.1.88.65", "Chest CAD SR Storage";
"1.2.840.10008.5.1.4.1.1.88.67", "X-Ray Radiation Dose SR Storage";
"1.2.840.10008.5.1.4.1.1.88.69", "Colon CAD SR Storage";
"1.2.840.10008.5.1.4.1.1.88.70", "Implantation Plan SR Storage";
"1.2.840.10008.5.1.4.1.1.104.1", "Encapsulated PDF Storage";
"1.2.840.10008.5.1.4.1.1.104.2", "Encapsulated CDA Storage";
"1.2.840.10008.5.1.4.1.1.128", "Positron Emission Tomography Image Storage";
"1.2.840.10008.5.1.4.1.1.129", "Standalone PET Curve Storage (Retired)";
"1.2.840.10008.5.1.4.1.1.130", "Enhanced PET Image Storage";
"1.2.840.10008.5.1.4.1.1.131", "Basic Structured Display Storage";
"1.2.840.10008.5.1.4.1.1.481.1", "RT Image Storage";
"1.2.840.10008.5.1.4.1.1.481.2", "RT Dose Storage";
"1.2.840.10008.5.1.4.1.1.481.3", "RT Structure Set Storage";
"1.2.840.10008.5.1.4.1.1.481.4", "RT Beams Treatment Record Storage";
"1.2.840.10008.5.1.4.1.1.481.5", "RT Plan Storage";
"1.2.840.10008.5.1.4.1.1.481.6", "RT Brachy Treatment Record Storage";
"1.2.840.10008.5.1.4.1.1.481.7", "RT Treatment Summary Record Storage";
"1.2.840.10008.5.1.4.1.1.481.8", "RT Ion Plan Storage";
"1.2.840.10008.5.1.4.1.1.481.9", "RT Ion Beams Treatment Record Storage";
"1.2.840.10008.5.1.4.1.1.501.1", "DICOS CT Image Storage";
"1.2.840.10008.5.1.4.1.1.501.2.1", "DICOS Digital X-Ray Image Storage - For Presentation";
"1.2.840.10008.5.1.4.1.1.501.2.2", "DICOS Digital X-Ray Image Storage - For Processing";
"1.2.840.10008.5.1.4.1.1.501.3", "DICOS Threat Detection Report Storage";
"1.2.840.10008.5.1.4.1.1.601.1", "Eddy Current Image Storage";
"1.2.840.10008.5.1.4.1.1.601.2", "Eddy Current Multi-frame Image Storage";
"1.2.840.10008.5.1.4.1.2.1.1", "Patient Root Query/Retrieve Information Model - FIND";
"1.2.840.10008.5.1.4.1.2.1.2", "Patient Root Query/Retrieve Information Model - MOVE";
"1.2.840.10008.5.1.4.1.2.1.3", "Patient Root Query/Retrieve Information Model - GET";
"1.2.840.10008.5.1.4.1.2.2.1", "Study Root Query/Retrieve Information Model - FIND";
"1.2.840.10008.5.1.4.1.2.2.2", "Study Root Query/Retrieve Information Model - MOVE";
"1.2.840.10008.5.1.4.1.2.2.3", "Study Root Query/Retrieve Information Model - GET";
"1.2.840.10008.5.1.4.1.2.3.1", "Patient/Study Only Query/Retrieve Information Model - FIND (Retired)";
"1.2.840.10008.5.1.4.1.2.3.2", "Patient/Study Only Query/Retrieve Information Model - MOVE (Retired)";
"1.2.840.10008.5.1.4.1.2.3.3", "Patient/Study Only Query/Retrieve Information Model - GET (Retired)";
"1.2.840.10008.5.1.4.1.2.4.2", "Composite Instance Root Retrieve - MOVE";
"1.2.840.10008.5.1.4.1.2.4.3", "Composite Instance Root Retrieve - GET";
"1.2.840.10008.5.1.4.1.2.5.3", "Composite Instance Retrieve Without Bulk Data - GET";
"1.2.840.10008.5.1.4.31", "Modality Worklist Information Model - FIND";
"1.2.840.10008.5.1.4.32.1", "General Purpose Worklist Information Model - FIND";
"1.2.840.10008.5.1.4.32.2", "General Purpose Scheduled Procedure Step SOP Class";
"1.2.840.10008.5.1.4.32.3", "General Purpose Performed Procedure Step SOP Class";
"1.2.840.10008.5.1.4.32", "General Purpose Worklist Management Meta SOP Class";
"1.2.840.10008.5.1.4.33", "Instance Availability Notification SOP Class";
"1.2.840.10008.5.1.4.34.1", "RT Beams Delivery Instruction Storage - Trial (Retired)";
"1.2.840.10008.5.1.4.34.2", "RT Conventional Machine Verification - Trial (Retired)";
"1.2.840.10008.5.1.4.34.3", "RT Ion Machine Verification - Trial (Retired)";
"1.2.840.10008.5.1.4.34.4", "Unified Worklist and Procedure Step Service Class - Trial (Retired)";
"1.2.840.10008.5.1.4.34.4.1", "Unified Procedure Step - Push SOP Class - Trial (Retired)";
"1.2.840.10008.5.1.4.34.4.2", "Unified Procedure Step - Watch SOP Class - Trial (Retired)";
"1.2.840.10008.5.1.4.34.4.3", "Unified Procedure Step - Pull SOP Class - Trial (Retired)";
"1.2.840.10008.5.1.4.34.4.4", "Unified Procedure Step - Event SOP Class - Trial (Retired)";
"1.2.840.10008.5.1.4.34.5", "Unified Worklist and Procedure Step SOP Instance";
"1.2.840.10008.5.1.4.34.6", "Unified Worklist and Procedure Step Service Class";
"1.2.840.10008.5.1.4.34.6.1", "Unified Procedure Step - Push SOP Class";
"1.2.840.10008.5.1.4.34.6.2", "Unified Procedure Step - Watch SOP Class";
"1.2.840.10008.5.1.4.34.6.3", "Unified Procedure Step - Pull SOP Class";
"1.2.840.10008.5.1.4.34.6.4", "Unified Procedure Step - Event SOP Class";
"1.2.840.10008.5.1.4.34.7", "RT Beams Delivery Instruction Storage";
"1.2.840.10008.5.1.4.34.8", "RT Conventional Machine Verification";
"1.2.840.10008.5.1.4.34.9", "RT Ion Machine Verification";
"1.2.840.10008.5.1.4.37.1", "General Relevant Patient Information Query";
"1.2.840.10008.5.1.4.37.2", "Breast Imaging Relevant Patient Information Query";
"1.2.840.10008.5.1.4.37.3", "Cardiac Relevant Patient Information Query";
"1.2.840.10008.5.1.4.38.1", "Hanging Protocol Storage";
"1.2.840.10008.5.1.4.38.2", "Hanging Protocol Information Model - FIND";
"1.2.840.10008.5.1.4.38.3", "Hanging Protocol Information Model - MOVE";
"1.2.840.10008.5.1.4.38.4", "Hanging Protocol Information Model - GET";
"1.2.840.10008.5.1.4.39.1", "Color Palette Storage";
"1.2.840.10008.5.1.4.39.2", "Color Palette Information Model - FIND";
"1.2.840.10008.5.1.4.39.3", "Color Palette Information Model - MOVE";
"1.2.840.10008.5.1.4.39.4", "Color Palette Information Model - GET";
"1.2.840.10008.5.1.4.41", "Product Characteristics Query SOP Class";
"1.2.840.10008.5.1.4.42", "Substance Approval Query SOP Class";
"1.2.840.10008.5.1.4.43.1", "Generic Implant Template Storage";
"1.2.840.10008.5.1.4.43.2", "Generic Implant Template Information Model - FIND";
"1.2.840.10008.5.1.4.43.3", "Generic Implant Template Information Model - MOVE";
"1.2.840.10008.5.1.4.43.4", "Generic Implant Template Information Model - GET";
"1.2.840.10008.5.1.4.44.1", "Implant Assembly Template Storage";
"1.2.840.10008.5.1.4.44.2", "Implant Assembly Template Information Model - FIND";
"1.2.840.10008.5.1.4.44.3", "Implant Assembly Template Information Model - MOVE";
"1.2.840.10008.5.1.4.44.4", "Implant Assembly Template Information Model - GET";
"1.2.840.10008.5.1.4.45.1", "Implant Template Group Storage";
"1.2.840.10008.5.1.4.45.2", "Implant Template Group Information Model - FIND";
"1.2.840.10008.5.1.4.45.3", "Implant Template Group Information Model - MOVE";
"1.2.840.10008.5.1.4.45.4", "Implant Template Group Information Model - GET";
"1.2.840.10008.7.1.1", "Native DICOM Model";
"1.2.840.10008.7.1.2", "Abstract Multi-Dimensional Image Model";
"1.2.840.10008.15.0.3.1", "dicomDeviceName";
"1.2.840.10008.15.0.3.2", "dicomDescription";
"1.2.840.10008.15.0.3.3", "dicomManufacturer";
"1.2.840.10008.15.0.3.4", "dicomManufacturerModelName";
"1.2.840.10008.15.0.3.5", "dicomSoftwareVersion";
"1.2.840.10008.15.0.3.6", "dicomVendorData";
"1.2.840.10008.15.0.3.7", "dicomAETitle";
"1.2.840.10008.15.0.3.8", "dicomNetworkConnectionReference";
"1.2.840.10008.15.0.3.9", "dicomApplicationCluster";
"1.2.840.10008.15.0.3.10", "dicomAssociationInitiator";
"1.2.840.10008.15.0.3.11", "dicomAssociationAcceptor";
"1.2.840.10008.15.0.3.12", "dicomHostname";
"1.2.840.10008.15.0.3.13", "dicomPort";
"1.2.840.10008.15.0.3.14", "dicomSOPClass";
"1.2.840.10008.15.0.3.15", "dicomTransferRole";
"1.2.840.10008.15.0.3.16", "dicomTransferSyntax";
"1.2.840.10008.15.0.3.17", "dicomPrimaryDeviceType";
"1.2.840.10008.15.0.3.18", "dicomRelatedDeviceReference";
"1.2.840.10008.15.0.3.19", "dicomPreferredCalledAETitle";
"1.2.840.10008.15.0.3.20", "dicomTLSCyphersuite";
"1.2.840.10008.15.0.3.21", "dicomAuthorizedNodeCertificateReference";
"1.2.840.10008.15.0.3.22", "dicomThisNodeCertificateReference";
"1.2.840.10008.15.0.3.23", "dicomInstalled";
"1.2.840.10008.15.0.3.24", "dicomStationName";
"1.2.840.10008.15.0.3.25", "dicomDeviceSerialNumber";
"1.2.840.10008.15.0.3.26", "dicomInstitutionName";
"1.2.840.10008.15.0.3.27", "dicomInstitutionAddress";
"1.2.840.10008.15.0.3.28", "dicomInstitutionDepartmentName";
"1.2.840.10008.15.0.3.29", "dicomIssuerOfPatientID";
"1.2.840.10008.15.0.3.30", "dicomPreferredCallingAETitle";
"1.2.840.10008.15.0.3.31", "dicomSupportedCharacterSet";
"1.2.840.10008.15.0.4.1", "dicomConfigurationRoot";
"1.2.840.10008.15.0.4.2", "dicomDevicesRoot";
"1.2.840.10008.15.0.4.3", "dicomUniqueAETitlesRegistryRoot";
"1.2.840.10008.15.0.4.4", "dicomDevice";
"1.2.840.10008.15.0.4.5", "dicomNetworkAE";
"1.2.840.10008.15.0.4.6", "dicomNetworkConnection";
"1.2.840.10008.15.0.4.7", "dicomUniqueAETitle";
"1.2.840.10008.15.0.4.8", "dicomTransferCapability";
"1.2.840.10008.15.1.1", "Universal Coordinated Time"; 

(* Table A-3 *)
"1.2.840.10008.1.4.1.1", "Talairach Brain Atlas Frame of Reference";
"1.2.840.10008.1.4.1.2", "SPM2 T1 Frame of Reference";
"1.2.840.10008.1.4.1.3", "SPM2 T2 Frame of Reference";
"1.2.840.10008.1.4.1.4", "SPM2 PD Frame of Reference";
"1.2.840.10008.1.4.1.5", "SPM2 EPI Frame of Reference";
"1.2.840.10008.1.4.1.6", "SPM2 FIL T1 Frame of Reference";
"1.2.840.10008.1.4.1.7", "SPM2 PET Frame of Reference";
"1.2.840.10008.1.4.1.8", "SPM2 TRANSM Frame of Reference";
"1.2.840.10008.1.4.1.9", "SPM2 SPECT Frame of Reference";
"1.2.840.10008.1.4.1.10", "SPM2 GRAY Frame of Reference";
"1.2.840.10008.1.4.1.11", "SPM2 WHITE Frame of Reference";
"1.2.840.10008.1.4.1.12", "SPM2 CSF Frame of Reference";
"1.2.840.10008.1.4.1.13", "SPM2 BRAINMASK Frame of Reference";
"1.2.840.10008.1.4.1.14", "SPM2 AVG305T1 Frame of Reference";
"1.2.840.10008.1.4.1.15", "SPM2 AVG152T1 Frame of Reference";
"1.2.840.10008.1.4.1.16", "SPM2 AVG152T2 Frame of Reference";
"1.2.840.10008.1.4.1.17", "SPM2 AVG152PD Frame of Reference";
"1.2.840.10008.1.4.1.18", "SPM2 SINGLESUBJT1 Frame of Reference";
"1.2.840.10008.1.4.2.1", "ICBM 452 T1 Frame of Reference";
"1.2.840.10008.1.4.2.2", "ICBM Single Subject MRI Frame of Reference";

(* Table A-3 *)
"1.2.840.10008.6.1.1", "Anatomic Modifier";
"1.2.840.10008.6.1.2", "Anatomic Region";
"1.2.840.10008.6.1.3", "Transducer Approach";
"1.2.840.10008.6.1.4", "Transducer Orientation";
"1.2.840.10008.6.1.5", "Ultrasound Beam Path";
"1.2.840.10008.6.1.6", "Angiographic Interventional Devices";
"1.2.840.10008.6.1.7", "Image Guided Therapeutic Procedures";
"1.2.840.10008.6.1.8", "Interventional Drug";
"1.2.840.10008.6.1.9", "Route of Administration";
"1.2.840.10008.6.1.10", "Radiographic Contrast Agent";
"1.2.840.10008.6.1.11", "Radiographic Contrast Agent Ingredient";
"1.2.840.10008.6.1.12", "Isotopes in Radiopharmaceuticals";
"1.2.840.10008.6.1.13", "Patient Orientation";
"1.2.840.10008.6.1.14", "Patient Orientation Modifier";
"1.2.840.10008.6.1.15", "Patient Gantry Relationship";
"1.2.840.10008.6.1.16", "Cranio-caudad Angulation";
"1.2.840.10008.6.1.17", "Radiopharmaceuticals";
"1.2.840.10008.6.1.18", "Nuclear Medicine Projections";
"1.2.840.10008.6.1.19", "Acquisition Modality";
"1.2.840.10008.6.1.20", "DICOM Devices";
"1.2.840.10008.6.1.21", "Abstract Priors";
"1.2.840.10008.6.1.22", "Numeric Value Qualifier";
"1.2.840.10008.6.1.23", "Units of Measurement";
"1.2.840.10008.6.1.24", "Units for Real World Value Mapping";
"1.2.840.10008.6.1.25", "Level of Significance";
"1.2.840.10008.6.1.26", "Measurement Range Concepts";
"1.2.840.10008.6.1.27", "Normality Codes";
"1.2.840.10008.6.1.28", "Normal Range Values";
"1.2.840.10008.6.1.29", "Selection Method";
"1.2.840.10008.6.1.30", "Measurement Uncertainty Concepts";
"1.2.840.10008.6.1.31", "Population Statistical Descriptors";
"1.2.840.10008.6.1.32", "Sample Statistical Descriptors";
"1.2.840.10008.6.1.33", "Equation or Table";
"1.2.840.10008.6.1.34", "Yes-No";
"1.2.840.10008.6.1.35", "Present-Absent";
"1.2.840.10008.6.1.36", "Normal-Abnormal";
"1.2.840.10008.6.1.37", "Laterality";
"1.2.840.10008.6.1.38", "Positive-Negative";
"1.2.840.10008.6.1.39", "Severity of Complication";
"1.2.840.10008.6.1.40", "Observer Type";
"1.2.840.10008.6.1.41", "Observation Subject Class";
"1.2.840.10008.6.1.42", "Audio Channel Source";
"1.2.840.10008.6.1.43", "ECG Leads";
"1.2.840.10008.6.1.44", "Hemodynamic Waveform Sources";
"1.2.840.10008.6.1.45", "Cardiovascular Anatomic Locations";
"1.2.840.10008.6.1.46", "Electrophysiology Anatomic Locations";
"1.2.840.10008.6.1.47", "Coronary Artery Segments";
"1.2.840.10008.6.1.48", "Coronary Arteries";
"1.2.840.10008.6.1.49", "Cardiovascular Anatomic Location Modifiers";
"1.2.840.10008.6.1.50", "Cardiology Units of Measurement";
"1.2.840.10008.6.1.51", "Time Synchronization Channel Types";
"1.2.840.10008.6.1.52", "NM Procedural State Values";
"1.2.840.10008.6.1.53", "Electrophysiology Measurement Functions and Techniques";
"1.2.840.10008.6.1.54", "Hemodynamic Measurement Techniques";
"1.2.840.10008.6.1.55", "Catheterization Procedure Phase";
"1.2.840.10008.6.1.56", "Electrophysiology Procedure Phase";
"1.2.840.10008.6.1.57", "Stress Protocols";
"1.2.840.10008.6.1.58", "ECG Patient State Values";
"1.2.840.10008.6.1.59", "Electrode Placement Values";
"1.2.840.10008.6.1.60", "XYZ Electrode Placement Values";
"1.2.840.10008.6.1.61", "Hemodynamic Physiological Challenges";
"1.2.840.10008.6.1.62", "ECG Annotations";
"1.2.840.10008.6.1.63", "Hemodynamic Annotations";
"1.2.840.10008.6.1.64", "Electrophysiology Annotations";
"1.2.840.10008.6.1.65", "Procedure Log Titles";
"1.2.840.10008.6.1.66", "Types of Log Notes";
"1.2.840.10008.6.1.67", "Patient Status and Events";
"1.2.840.10008.6.1.68", "Percutaneous Entry";
"1.2.840.10008.6.1.69", "Staff Actions";
"1.2.840.10008.6.1.70", "Procedure Action Values";
"1.2.840.10008.6.1.71", "Non-Coronary Transcatheter Interventions";
"1.2.840.10008.6.1.72", "Purpose of Reference to Object";
"1.2.840.10008.6.1.73", "Actions with Consumables";
"1.2.840.10008.6.1.74", "Administration of Drugs/Contrast";
"1.2.840.10008.6.1.75", "Numeric Parameters of Drugs/Contrast";
"1.2.840.10008.6.1.76", "Intracoronary Devices";
"1.2.840.10008.6.1.77", "Intervention Actions and Status";
"1.2.840.10008.6.1.78", "Adverse Outcomes";
"1.2.840.10008.6.1.79", "Procedure Urgency";
"1.2.840.10008.6.1.80", "Cardiac Rhythms";
"1.2.840.10008.6.1.81", "Respiration Rhythms";
"1.2.840.10008.6.1.82", "Lesion Risk";
"1.2.840.10008.6.1.83", "Findings Titles";
"1.2.840.10008.6.1.84", "Procedure Action";
"1.2.840.10008.6.1.85", "Device Use Actions";
"1.2.840.10008.6.1.86", "Numeric Device Characteristics";
"1.2.840.10008.6.1.87", "Intervention Parameters";
"1.2.840.10008.6.1.88", "Consumables Parameters";
"1.2.840.10008.6.1.89", "Equipment Events";
"1.2.840.10008.6.1.90", "Imaging Procedures";
"1.2.840.10008.6.1.91", "Catheterization Devices";
"1.2.840.10008.6.1.92", "DateTime Qualifiers";
"1.2.840.10008.6.1.93", "Peripheral Pulse Locations";
"1.2.840.10008.6.1.94", "Patient assessments";
"1.2.840.10008.6.1.95", "Peripheral Pulse Methods";
"1.2.840.10008.6.1.96", "Skin Condition";
"1.2.840.10008.6.1.97", "Airway Assessment";
"1.2.840.10008.6.1.98", "Calibration Objects";
"1.2.840.10008.6.1.99", "Calibration Methods";
"1.2.840.10008.6.1.100", "Cardiac Volume Methods";
"1.2.840.10008.6.1.101", "Index Methods";
"1.2.840.10008.6.1.102", "Sub-segment Methods";
"1.2.840.10008.6.1.103", "Contour Realignment";
"1.2.840.10008.6.1.104", "Circumferential ExtenT";
"1.2.840.10008.6.1.105", "Regional Extent";
"1.2.840.10008.6.1.106", "Chamber Identification";
"1.2.840.10008.6.1.107", "QA Reference MethodS";
"1.2.840.10008.6.1.108", "Plane Identification";
"1.2.840.10008.6.1.109", "Ejection Fraction";
"1.2.840.10008.6.1.110", "ED Volume";
"1.2.840.10008.6.1.111", "ES Volume";
"1.2.840.10008.6.1.112", "Vessel Lumen Cross-Sectional Area Calculation Methods";
"1.2.840.10008.6.1.113", "Estimated Volumes";
"1.2.840.10008.6.1.114", "Cardiac Contraction Phase";
"1.2.840.10008.6.1.115", "IVUS Procedure Phases";
"1.2.840.10008.6.1.116", "IVUS Distance Measurements";
"1.2.840.10008.6.1.117", "IVUS Area Measurements";
"1.2.840.10008.6.1.118", "IVUS Longitudinal Measurements";
"1.2.840.10008.6.1.119", "IVUS Indices and Ratios";
"1.2.840.10008.6.1.120", "IVUS Volume Measurements";
"1.2.840.10008.6.1.121", "Vascular Measurement Sites";
"1.2.840.10008.6.1.122", "Intravascular Volumetric Regions";
"1.2.840.10008.6.1.123", "Min/Max/Mean";
"1.2.840.10008.6.1.124", "Calcium Distribution";
"1.2.840.10008.6.1.125", "IVUS Lesion Morphologies";
"1.2.840.10008.6.1.126", "Vascular Dissection Classifications";
"1.2.840.10008.6.1.127", "IVUS Relative Stenosis Severities";
"1.2.840.10008.6.1.128", "IVUS Non Morphological Findings";
"1.2.840.10008.6.1.129", "IVUS Plaque Composition";
"1.2.840.10008.6.1.130", "IVUS Fiducial Points";
"1.2.840.10008.6.1.131", "IVUS Arterial Morphology";
"1.2.840.10008.6.1.132", "Pressure Units";
"1.2.840.10008.6.1.133", "Hemodynamic Resistance Units";
"1.2.840.10008.6.1.134", "Indexed Hemodynamic Resistance Units";
"1.2.840.10008.6.1.135", "Catheter Size Units";
"1.2.840.10008.6.1.136", "Specimen Collection";
"1.2.840.10008.6.1.137", "Blood Source Type";
"1.2.840.10008.6.1.138", "Blood Gas Pressures";
"1.2.840.10008.6.1.139", "Blood Gas Content";
"1.2.840.10008.6.1.140", "Blood Gas Saturation";
"1.2.840.10008.6.1.141", "Blood Base Excess";
"1.2.840.10008.6.1.142", "Blood pH";
"1.2.840.10008.6.1.143", "Arterial / Venous Content";
"1.2.840.10008.6.1.144", "Oxygen Administration Actions";
"1.2.840.10008.6.1.145", "Oxygen Administration";
"1.2.840.10008.6.1.146", "Circulatory Support Actions";
"1.2.840.10008.6.1.147", "Ventilation Actions";
"1.2.840.10008.6.1.148", "Pacing Actions";
"1.2.840.10008.6.1.149", "Circulatory Support";
"1.2.840.10008.6.1.150", "Ventilation";
"1.2.840.10008.6.1.151", "Pacing";
"1.2.840.10008.6.1.152", "Blood Pressure Methods";
"1.2.840.10008.6.1.153", "Relative times";
"1.2.840.10008.6.1.154", "Hemodynamic Patient State";
"1.2.840.10008.6.1.155", "Arterial lesion locations";
"1.2.840.10008.6.1.156", "Arterial source locations";
"1.2.840.10008.6.1.157", "Venous Source locations";
"1.2.840.10008.6.1.158", "Atrial source locations";
"1.2.840.10008.6.1.159", "Ventricular source locations";
"1.2.840.10008.6.1.160", "Gradient Source Locations";
"1.2.840.10008.6.1.161", "Pressure Measurements";
"1.2.840.10008.6.1.162", "Blood Velocity Measurements";
"1.2.840.10008.6.1.163", "Hemodynamic Time Measurements";
"1.2.840.10008.6.1.164", "Valve Areas, non-Mitral";
"1.2.840.10008.6.1.165", "Valve Areas";
"1.2.840.10008.6.1.166", "Hemodynamic Period Measurements";
"1.2.840.10008.6.1.167", "Valve Flows";
"1.2.840.10008.6.1.168", "Hemodynamic Flows";
"1.2.840.10008.6.1.169", "Hemodynamic Resistance Measurements";
"1.2.840.10008.6.1.170", "Hemodynamic Ratios";
"1.2.840.10008.6.1.171", "Fractional Flow Reserve";
"1.2.840.10008.6.1.172", "Measurement Type";
"1.2.840.10008.6.1.173", "Cardiac Output Methods";
"1.2.840.10008.6.1.174", "Procedure Intent";
"1.2.840.10008.6.1.175", "Cardiovascular Anatomic Locations";
"1.2.840.10008.6.1.176", "Hypertension";
"1.2.840.10008.6.1.177", "Hemodynamic Assessments";
"1.2.840.10008.6.1.178", "Degree Findings";
"1.2.840.10008.6.1.179", "Hemodynamic Measurement Phase";
"1.2.840.10008.6.1.180", "Body Surface Area Equations";
"1.2.840.10008.6.1.181", "Oxygen Consumption Equations and Tables";
"1.2.840.10008.6.1.182", "P50 Equations";
"1.2.840.10008.6.1.183", "Framingham Scores";
"1.2.840.10008.6.1.184", "Framingham Tables";
"1.2.840.10008.6.1.185", "ECG Procedure Types";
"1.2.840.10008.6.1.186", "Reason for ECG Exam";
"1.2.840.10008.6.1.187", "Pacemakers";
"1.2.840.10008.6.1.188", "Diagnosis";
"1.2.840.10008.6.1.189", "Other Filters";
"1.2.840.10008.6.1.190", "Lead Measurement Technique";
"1.2.840.10008.6.1.191", "Summary Codes ECG";
"1.2.840.10008.6.1.192", "QT Correction Algorithms";
"1.2.840.10008.6.1.193", "ECG Morphology Descriptions";
"1.2.840.10008.6.1.194", "ECG Lead Noise Descriptions";
"1.2.840.10008.6.1.195", "ECG Lead Noise Modifiers";
"1.2.840.10008.6.1.196", "Probability";
"1.2.840.10008.6.1.197", "Modifiers";
"1.2.840.10008.6.1.198", "Trend";
"1.2.840.10008.6.1.199", "Conjunctive Terms";
"1.2.840.10008.6.1.200", "ECG Interpretive Statements";
"1.2.840.10008.6.1.201", "Electrophysiology Waveform Durations";
"1.2.840.10008.6.1.202", "Electrophysiology Waveform Voltages";
"1.2.840.10008.6.1.203", "Cath Diagnosis";
"1.2.840.10008.6.1.204", "Cardiac Valves and Tracts";
"1.2.840.10008.6.1.205", "Wall Motion";
"1.2.840.10008.6.1.206", "Myocardium Wall Morphology Findings";
"1.2.840.10008.6.1.207", "Chamber Size";
"1.2.840.10008.6.1.208", "Overall Contractility";
"1.2.840.10008.6.1.209", "VSD Description";
"1.2.840.10008.6.1.210", "Aortic Root Description";
"1.2.840.10008.6.1.211", "Coronary Dominance";
"1.2.840.10008.6.1.212", "Valvular Abnormalities";
"1.2.840.10008.6.1.213", "Vessel Descriptors";
"1.2.840.10008.6.1.214", "TIMI Flow Characteristics";
"1.2.840.10008.6.1.215", "Thrombus";
"1.2.840.10008.6.1.216", "Lesion Margin";
"1.2.840.10008.6.1.217", "Severity";
"1.2.840.10008.6.1.218", "Myocardial Wall Segments";
"1.2.840.10008.6.1.219", "Myocardial Wall Segments in Projection";
"1.2.840.10008.6.1.220", "Canadian Clinical Classification";
"1.2.840.10008.6.1.221", "Cardiac History Dates (Retired)";
"1.2.840.10008.6.1.222", "Cardiovascular Surgeries";
"1.2.840.10008.6.1.223", "Diabetic Therapy";
"1.2.840.10008.6.1.224", "MI Types";
"1.2.840.10008.6.1.225", "Smoking History";
"1.2.840.10008.6.1.226", "Indications for Coronary Intervention";
"1.2.840.10008.6.1.227", "Indications for Catheterization";
"1.2.840.10008.6.1.228", "Cath Findings";
"1.2.840.10008.6.1.229", "Admission Status";
"1.2.840.10008.6.1.230", "Insurance Payor";
"1.2.840.10008.6.1.231", "Primary Cause of Death";
"1.2.840.10008.6.1.232", "Acute Coronary Syndrome Time Period";
"1.2.840.10008.6.1.233", "NYHA Classification";
"1.2.840.10008.6.1.234", "Non-Invasive Test - Ischemia";
"1.2.840.10008.6.1.235", "Pre-Cath Angina Type";
"1.2.840.10008.6.1.236", "Cath Procedure Type";
"1.2.840.10008.6.1.237", "Thrombolytic Administration";
"1.2.840.10008.6.1.238", "Medication Administration, Lab Visit";
"1.2.840.10008.6.1.239", "Medication Administration, PCI";
"1.2.840.10008.6.1.240", "Clopidogrel/Ticlopidine Administration";
"1.2.840.10008.6.1.241", "EF Testing Method";
"1.2.840.10008.6.1.242", "Calculation Method";
"1.2.840.10008.6.1.243", "Percutaneous Entry Site";
"1.2.840.10008.6.1.244", "Percutaneous Closure";
"1.2.840.10008.6.1.245", "Angiographic EF Testing Method";
"1.2.840.10008.6.1.246", "PCI Procedure Result";
"1.2.840.10008.6.1.247", "Previously Dilated Lesion";
"1.2.840.10008.6.1.248", "Guidewire Crossing";
"1.2.840.10008.6.1.249", "Vascular Complications";
"1.2.840.10008.6.1.250", "Cath Complications";
"1.2.840.10008.6.1.251", "Cardiac Patient Risk Factors";
"1.2.840.10008.6.1.252", "Cardiac Diagnostic Procedures";
"1.2.840.10008.6.1.253", "Cardiovascular Family History";
"1.2.840.10008.6.1.254", "Hypertension Therapy";
"1.2.840.10008.6.1.255", "Antilipemic agents";
"1.2.840.10008.6.1.256", "Antiarrhythmic agents";
"1.2.840.10008.6.1.257", "Myocardial Infarction Therapies";
"1.2.840.10008.6.1.258", "Concern Types";
"1.2.840.10008.6.1.259", "Problem Status";
"1.2.840.10008.6.1.260", "Health Status";
"1.2.840.10008.6.1.261", "Use Status";
"1.2.840.10008.6.1.262", "Social History";
"1.2.840.10008.6.1.263", "Implanted Devices";
"1.2.840.10008.6.1.264", "Plaque Structures";
"1.2.840.10008.6.1.265", "Stenosis Measurement Methods";
"1.2.840.10008.6.1.266", "Stenosis Types";
"1.2.840.10008.6.1.267", "Stenosis Shape";
"1.2.840.10008.6.1.268", "Volume Measurement Methods";
"1.2.840.10008.6.1.269", "Aneurysm Types";
"1.2.840.10008.6.1.270", "Associated Conditions";
"1.2.840.10008.6.1.271", "Vascular Morphology";
"1.2.840.10008.6.1.272", "Stent Findings";
"1.2.840.10008.6.1.273", "Stent Composition";
"1.2.840.10008.6.1.274", "Source of Vascular Finding";
"1.2.840.10008.6.1.275", "Vascular Sclerosis Types";
"1.2.840.10008.6.1.276", "Non-invasive Vascular Procedures";
"1.2.840.10008.6.1.277", "Papillary Muscle Included/Excluded";
"1.2.840.10008.6.1.278", "Respiratory Status";
"1.2.840.10008.6.1.279", "Heart Rhythm";
"1.2.840.10008.6.1.280", "Vessel Segments";
"1.2.840.10008.6.1.281", "Pulmonary Arteries";
"1.2.840.10008.6.1.282", "Stenosis Length";
"1.2.840.10008.6.1.283", "Stenosis Grade";
"1.2.840.10008.6.1.284", "Cardiac Ejection Fraction";
"1.2.840.10008.6.1.285", "Cardiac Volume Measurements";
"1.2.840.10008.6.1.286", "Time-based Perfusion Measurements";
"1.2.840.10008.6.1.287", "Fiducial Feature";
"1.2.840.10008.6.1.288", "Diameter Derivation";
"1.2.840.10008.6.1.289", "Coronary Veins";
"1.2.840.10008.6.1.290", "Pulmonary Veins";
"1.2.840.10008.6.1.291", "Myocardial Subsegment";
"1.2.840.10008.6.1.292", "Partial View Section for Mammography";
"1.2.840.10008.6.1.293", "DX Anatomy Imaged";
"1.2.840.10008.6.1.294", "DX View";
"1.2.840.10008.6.1.295", "DX View Modifier";
"1.2.840.10008.6.1.296", "Projection Eponymous Name";
"1.2.840.10008.6.1.297", "Anatomic Region for Mammography";
"1.2.840.10008.6.1.298", "View for Mammography";
"1.2.840.10008.6.1.299", "View Modifier for Mammography";
"1.2.840.10008.6.1.300", "Anatomic Region for Intra-oral Radiography";
"1.2.840.10008.6.1.301", "Anatomic Region Modifier for Intra-oral Radiography";
"1.2.840.10008.6.1.302", "Primary Anatomic Structure for Intra-oral Radiography (Permanent Dentition - Designation of Teeth)";
"1.2.840.10008.6.1.303", "Primary Anatomic Structure for Intra-oral Radiography (Deciduous Dentition - Designation of Teeth)";
"1.2.840.10008.6.1.304", "PET Radionuclide";
"1.2.840.10008.6.1.305", "PET Radiopharmaceutical";
"1.2.840.10008.6.1.306", "Craniofacial Anatomic Regions";
"1.2.840.10008.6.1.307", "CT and MR Anatomy Imaged";
"1.2.840.10008.6.1.308", "Common Anatomic Regions";
"1.2.840.10008.6.1.309", "MR Spectroscopy Metabolites";
"1.2.840.10008.6.1.310", "MR Proton Spectroscopy Metabolites";
"1.2.840.10008.6.1.311", "Endoscopy Anatomic Regions";
"1.2.840.10008.6.1.312", "XA/XRF Anatomy Imaged";
"1.2.840.10008.6.1.313", "Drug or Contrast Agent Characteristics";
"1.2.840.10008.6.1.314", "General Devices";
"1.2.840.10008.6.1.315", "Phantom Devices";
"1.2.840.10008.6.1.316", "Ophthalmic Imaging Agent";
"1.2.840.10008.6.1.317", "Patient Eye Movement Command";
"1.2.840.10008.6.1.318", "Ophthalmic Photography Acquisition Device";
"1.2.840.10008.6.1.319", "Ophthalmic Photography Illumination";
"1.2.840.10008.6.1.320", "Ophthalmic Filter";
"1.2.840.10008.6.1.321", "Ophthalmic Lens";
"1.2.840.10008.6.1.322", "Ophthalmic Channel Description";
"1.2.840.10008.6.1.323", "Ophthalmic Image Position";
"1.2.840.10008.6.1.324", "Mydriatic Agent";
"1.2.840.10008.6.1.325", "Ophthalmic Anatomic Structure Imaged";
"1.2.840.10008.6.1.326", "Ophthalmic Tomography Acquisition Device";
"1.2.840.10008.6.1.327", "Ophthalmic OCT Anatomic Structure Imaged";
"1.2.840.10008.6.1.328", "Languages";
"1.2.840.10008.6.1.329", "Countries";
"1.2.840.10008.6.1.330", "Overall Breast Composition";
"1.2.840.10008.6.1.331", "Overall Breast Composition from BI-RADS®";
"1.2.840.10008.6.1.332", "Change Since Last Mammogram or Prior Surgery";
"1.2.840.10008.6.1.333", "Change Since Last Mammogram or Prior Surgery from BI-RADS®";
"1.2.840.10008.6.1.334", "Mammography Characteristics of Shape";
"1.2.840.10008.6.1.335", "Characteristics of Shape from BI-RADS®";
"1.2.840.10008.6.1.336", "Mammography Characteristics of Margin";
"1.2.840.10008.6.1.337", "Characteristics of Margin from BI-RADS®";
"1.2.840.10008.6.1.338", "Density Modifier";
"1.2.840.10008.6.1.339", "Density Modifier from BI-RADS®";
"1.2.840.10008.6.1.340", "Mammography Calcification Types";
"1.2.840.10008.6.1.341", "Calcification Types from BI-RADS®";
"1.2.840.10008.6.1.342", "Calcification Distribution Modifier";
"1.2.840.10008.6.1.343", "Calcification Distribution Modifier from BI-RADS®";
"1.2.840.10008.6.1.344", "Mammography Single Image Finding";
"1.2.840.10008.6.1.345", "Single Image Finding from BI-RADS®";
"1.2.840.10008.6.1.346", "Mammography Composite Feature";
"1.2.840.10008.6.1.347", "Composite Feature from BI-RADS®";
"1.2.840.10008.6.1.348", "Clockface Location or Region";
"1.2.840.10008.6.1.349", "Clockface Location or Region from BI-RADS®";
"1.2.840.10008.6.1.350", "Quadrant Location";
"1.2.840.10008.6.1.351", "Quadrant Location from BI-RADS®";
"1.2.840.10008.6.1.352", "Side";
"1.2.840.10008.6.1.353", "Side from BI-RADS®";
"1.2.840.10008.6.1.354", "Depth";
"1.2.840.10008.6.1.355", "Depth from BI-RADS®";
"1.2.840.10008.6.1.356", "Mammography Assessment";
"1.2.840.10008.6.1.357", "Assessment from BI-RADS®";
"1.2.840.10008.6.1.358", "Mammography Recommended Follow-up";
"1.2.840.10008.6.1.359", "Recommended Follow-up from BI-RADS®";
"1.2.840.10008.6.1.360", "Mammography Pathology Codes";
"1.2.840.10008.6.1.361", "Benign Pathology Codes from BI-RADS®";
"1.2.840.10008.6.1.362", "High Risk Lesions Pathology Codes from BI-RADS®";
"1.2.840.10008.6.1.363", "Malignant Pathology Codes from BI-RADS®";
"1.2.840.10008.6.1.364", "Intended Use of CAD Output";
"1.2.840.10008.6.1.365", "Composite Feature Relations";
"1.2.840.10008.6.1.366", "Scope of Feature";
"1.2.840.10008.6.1.367", "Mammography Quantitative Temporal Difference Type";
"1.2.840.10008.6.1.368", "Mammography Qualitative Temporal Difference Type";
"1.2.840.10008.6.1.369", "Nipple Characteristic";
"1.2.840.10008.6.1.370", "Non-Lesion Object Type";
"1.2.840.10008.6.1.371", "Mammography Image Quality Finding";
"1.2.840.10008.6.1.372", "Status of Results";
"1.2.840.10008.6.1.373", "Types of Mammography CAD Analysis";
"1.2.840.10008.6.1.374", "Types of Image Quality Assessment";
"1.2.840.10008.6.1.375", "Mammography Types of Quality Control Standard";
"1.2.840.10008.6.1.376", "Units of Follow-up Interval";
"1.2.840.10008.6.1.377", "CAD Processing and Findings Summary";
"1.2.840.10008.6.1.378", "CAD Operating Point Axis Label";
"1.2.840.10008.6.1.379", "Breast Procedure Reported";
"1.2.840.10008.6.1.380", "Breast Procedure Reason";
"1.2.840.10008.6.1.381", "Breast Imaging Report section title";
"1.2.840.10008.6.1.382", "Breast Imaging Report Elements";
"1.2.840.10008.6.1.383", "Breast Imaging Findings";
"1.2.840.10008.6.1.384", "Breast Clinical Finding or Indicated Problem";
"1.2.840.10008.6.1.385", "Associated Findings for Breast";
"1.2.840.10008.6.1.386", "Ductography Findings for Breast";
"1.2.840.10008.6.1.387", "Procedure Modifiers for Breast";
"1.2.840.10008.6.1.388", "Breast Implant Types";
"1.2.840.10008.6.1.389", "Breast Biopsy Techniques";
"1.2.840.10008.6.1.390", "Breast Imaging Procedure Modifiers";
"1.2.840.10008.6.1.391", "Interventional Procedure Complications";
"1.2.840.10008.6.1.392", "Interventional Procedure Results";
"1.2.840.10008.6.1.393", "Ultrasound Findings for Breast";
"1.2.840.10008.6.1.394", "Instrument Approach";
"1.2.840.10008.6.1.395", "Target Confirmation";
"1.2.840.10008.6.1.396", "Fluid Color";
"1.2.840.10008.6.1.397", "Tumor Stages from AJCC";
"1.2.840.10008.6.1.398", "Nottingham Combined Histologic Grade";
"1.2.840.10008.6.1.399", "Bloom-Richardson Histologic Grade";
"1.2.840.10008.6.1.400", "Histologic Grading Method";
"1.2.840.10008.6.1.401", "Breast Implant Findings";
"1.2.840.10008.6.1.402", "Gynecological Hormones";
"1.2.840.10008.6.1.403", "Breast Cancer Risk Factors";
"1.2.840.10008.6.1.404", "Gynecological Procedures";
"1.2.840.10008.6.1.405", "Procedures for Breast";
"1.2.840.10008.6.1.406", "Mammoplasty Procedures";
"1.2.840.10008.6.1.407", "Therapies for Breast";
"1.2.840.10008.6.1.408", "Menopausal Phase";
"1.2.840.10008.6.1.409", "General Risk Factors";
"1.2.840.10008.6.1.410", "OB-GYN Maternal Risk Factors";
"1.2.840.10008.6.1.411", "Substances";
"1.2.840.10008.6.1.412", "Relative Usage, Exposure Amount";
"1.2.840.10008.6.1.413", "Relative Frequency of Event Values";
"1.2.840.10008.6.1.414", "Quantitative Concepts for Usage, Exposure";
"1.2.840.10008.6.1.415", "Qualitative Concepts for Usage, Exposure Amount";
"1.2.840.10008.6.1.416", "QuaLItative Concepts for Usage, Exposure Frequency";
"1.2.840.10008.6.1.417", "Numeric Properties of Procedures";
"1.2.840.10008.6.1.418", "Pregnancy Status";
"1.2.840.10008.6.1.419", "Side of Family";
"1.2.840.10008.6.1.420", "Chest Component Categories";
"1.2.840.10008.6.1.421", "Chest Finding or Feature";
"1.2.840.10008.6.1.422", "Chest Finding or Feature Modifier";
"1.2.840.10008.6.1.423", "Abnormal Lines Finding or Feature";
"1.2.840.10008.6.1.424", "Abnormal Opacity Finding or Feature";
"1.2.840.10008.6.1.425", "Abnormal Lucency Finding or Feature";
"1.2.840.10008.6.1.426", "Abnormal Texture Finding or Feature";
"1.2.840.10008.6.1.427", "Width Descriptor";
"1.2.840.10008.6.1.428", "Chest Anatomic Structure Abnormal Distribution";
"1.2.840.10008.6.1.429", "Radiographic Anatomy Finding or Feature";
"1.2.840.10008.6.1.430", "Lung Anatomy Finding or Feature";
"1.2.840.10008.6.1.431", "Bronchovascular Anatomy Finding or Feature";
"1.2.840.10008.6.1.432", "Pleura Anatomy Finding or Feature";
"1.2.840.10008.6.1.433", "Mediastinum Anatomy Finding or Feature";
"1.2.840.10008.6.1.434", "Osseous Anatomy Finding or Feature";
"1.2.840.10008.6.1.435", "Osseous Anatomy Modifiers";
"1.2.840.10008.6.1.436", "Muscular Anatomy";
"1.2.840.10008.6.1.437", "Vascular Anatomy";
"1.2.840.10008.6.1.438", "Size Descriptor";
"1.2.840.10008.6.1.439", "Chest Border Shape";
"1.2.840.10008.6.1.440", "Chest Border Definition";
"1.2.840.10008.6.1.441", "Chest Orientation Descriptor";
"1.2.840.10008.6.1.442", "Chest Content Descriptor";
"1.2.840.10008.6.1.443", "Chest Opacity Descriptor";
"1.2.840.10008.6.1.444", "Location in Chest";
"1.2.840.10008.6.1.445", "General Chest Location";
"1.2.840.10008.6.1.446", "Location in Lung";
"1.2.840.10008.6.1.447", "Segment Location in Lung";
"1.2.840.10008.6.1.448", "Chest Distribution Descriptor";
"1.2.840.10008.6.1.449", "Chest Site Involvement";
"1.2.840.10008.6.1.450", "Severity Descriptor";
"1.2.840.10008.6.1.451", "Chest Texture Descriptor";
"1.2.840.10008.6.1.452", "Chest Calcification Descriptor";
"1.2.840.10008.6.1.453", "Chest Quantitative Temporal Difference Type";
"1.2.840.10008.6.1.454", "Qualitative Temporal Difference Type";
"1.2.840.10008.6.1.455", "Image Quality Finding";
"1.2.840.10008.6.1.456", "Chest Types of Quality Control Standard";
"1.2.840.10008.6.1.457", "Types of CAD Analysis";
"1.2.840.10008.6.1.458", "Chest Non-Lesion Object Type";
"1.2.840.10008.6.1.459", "Non-Lesion Modifiers";
"1.2.840.10008.6.1.460", "Calculation Methods";
"1.2.840.10008.6.1.461", "Attenuation Coefficient Measurements";
"1.2.840.10008.6.1.462", "Calculated Value";
"1.2.840.10008.6.1.463", "Response Criteria";
"1.2.840.10008.6.1.464", "RECIST Response Criteria";
"1.2.840.10008.6.1.465", "Baseline Category";
"1.2.840.10008.6.1.466", "Background echotexture";
"1.2.840.10008.6.1.467", "Orientation";
"1.2.840.10008.6.1.468", "Lesion boundary";
"1.2.840.10008.6.1.469", "Echo pattern";
"1.2.840.10008.6.1.470", "Posterior acoustic features";
"1.2.840.10008.6.1.471", "Vascularity";
"1.2.840.10008.6.1.472", "Correlation to Other Findings";
"1.2.840.10008.6.1.473", "Malignancy Type";
"1.2.840.10008.6.1.474", "Breast Primary Tumor Assessment from AJCC";
"1.2.840.10008.6.1.475", "Clinical Regional Lymph Node Assessment for Breast";
"1.2.840.10008.6.1.476", "Assessment of Metastasis for Breast";
"1.2.840.10008.6.1.477", "Menstrual Cycle Phase";
"1.2.840.10008.6.1.478", "Time Intervals";
"1.2.840.10008.6.1.479", "Breast Linear Measurements";
"1.2.840.10008.6.1.480", "CAD Geometry Secondary Graphical Representation";
"1.2.840.10008.6.1.481", "Diagnostic Imaging Report Document Titles";
"1.2.840.10008.6.1.482", "Diagnostic Imaging Report Headings";
"1.2.840.10008.6.1.483", "Diagnostic Imaging Report Elements";
"1.2.840.10008.6.1.484", "Diagnostic Imaging Report Purposes of Reference";
"1.2.840.10008.6.1.485", "Waveform Purposes of Reference";
"1.2.840.10008.6.1.486", "Contributing Equipment Purposes of Reference";
"1.2.840.10008.6.1.487", "SR Document Purposes of Reference";
"1.2.840.10008.6.1.488", "Signature Purpose";
"1.2.840.10008.6.1.489", "Media Import";
"1.2.840.10008.6.1.490", "Key Object Selection Document Title";
"1.2.840.10008.6.1.491", "Rejected for Quality Reasons";
"1.2.840.10008.6.1.492", "Best In Set";
"1.2.840.10008.6.1.493", "Document Titles";
"1.2.840.10008.6.1.494", "RCS Registration Method Type";
"1.2.840.10008.6.1.495", "Brain Atlas Fiducials";
"1.2.840.10008.6.1.496", "Segmentation Property Categories";
"1.2.840.10008.6.1.497", "Segmentation Property Types";
"1.2.840.10008.6.1.498", "Cardiac Structure Segmentation Types";
"1.2.840.10008.6.1.499", "Brain Tissue Segmentation Types";
"1.2.840.10008.6.1.500", "Abdominal Organ Segmentation Types";
"1.2.840.10008.6.1.501", "Thoracic Tissue Segmentation Types";
"1.2.840.10008.6.1.502", "Vascular Tissue Segmentation Types";
"1.2.840.10008.6.1.503", "Device Segmentation Types";
"1.2.840.10008.6.1.504", "Artifact Segmentation Types";
"1.2.840.10008.6.1.505", "Lesion Segmentation Types";
"1.2.840.10008.6.1.506", "Pelvic Organ Segmentation Types";
"1.2.840.10008.6.1.507", "Physiology Segmentation Types";
"1.2.840.10008.6.1.508", "Referenced Image Purposes of Reference";
"1.2.840.10008.6.1.509", "Source Image Purposes of Reference";
"1.2.840.10008.6.1.510", "Image Derivation";
"1.2.840.10008.6.1.511", "Purpose Of Reference to Alternate Representation";
"1.2.840.10008.6.1.512", "Related Series Purposes Of Reference";
"1.2.840.10008.6.1.513", "Multi-frame Subset Type";
"1.2.840.10008.6.1.514", "Person Roles";
"1.2.840.10008.6.1.515", "Family Member";
"1.2.840.10008.6.1.516", "Organizational Roles";
"1.2.840.10008.6.1.517", "Performing Roles";
"1.2.840.10008.6.1.518", "Species";
"1.2.840.10008.6.1.519", "Sex";
"1.2.840.10008.6.1.520", "Units of Measure for Age";
"1.2.840.10008.6.1.521", "Units of Linear Measurement";
"1.2.840.10008.6.1.522", "Units of Area Measurement";
"1.2.840.10008.6.1.523", "Units of Volume Measurement";
"1.2.840.10008.6.1.524", "Linear Measurements";
"1.2.840.10008.6.1.525", "Area Measurements";
"1.2.840.10008.6.1.526", "Volume Measurements";
"1.2.840.10008.6.1.527", "General Area Calculation Methods";
"1.2.840.10008.6.1.528", "General Volume Calculation Methods";
"1.2.840.10008.6.1.529", "Breed";
"1.2.840.10008.6.1.530", "Breed Registry";
"1.2.840.10008.6.1.531", "General Purpose Workitem Definition";
"1.2.840.10008.6.1.532", "Non-DICOM Output Types";
"1.2.840.10008.6.1.533", "Procedure Discontinuation Reasons";
"1.2.840.10008.6.1.534", "Scope of Accumulation";
"1.2.840.10008.6.1.535", "UID Types";
"1.2.840.10008.6.1.536", "Irradiation Event Types";
"1.2.840.10008.6.1.537", "Equipment Plane Identification";
"1.2.840.10008.6.1.538", "Fluoro Modes";
"1.2.840.10008.6.1.539", "X-Ray Filter Materials";
"1.2.840.10008.6.1.540", "X-Ray Filter Types";
"1.2.840.10008.6.1.541", "Dose Related Distance Measurements";
"1.2.840.10008.6.1.542", "Measured/Calculated";
"1.2.840.10008.6.1.543", "Dose Measurement Devices";
"1.2.840.10008.6.1.544", "Effective Dose Evaluation Method";
"1.2.840.10008.6.1.545", "CT Acquisition Type";
"1.2.840.10008.6.1.546", "Contrast Imaging Technique";
"1.2.840.10008.6.1.547", "CT Dose Reference Authorities";
"1.2.840.10008.6.1.548", "Anode Target Material";
"1.2.840.10008.6.1.549", "X-Ray Grid";
"1.2.840.10008.6.1.550", "Ultrasound Protocol Types";
"1.2.840.10008.6.1.551", "Ultrasound Protocol Stage Types";
"1.2.840.10008.6.1.552", "OB-GYN Dates";
"1.2.840.10008.6.1.553", "Fetal Biometry Ratios";
"1.2.840.10008.6.1.554", "Fetal Biometry Measurements";
"1.2.840.10008.6.1.555", "Fetal Long Bones Biometry Measurements";
"1.2.840.10008.6.1.556", "Fetal Cranium";
"1.2.840.10008.6.1.557", "OB-GYN Amniotic Sac";
"1.2.840.10008.6.1.558", "Early Gestation Biometry Measurements";
"1.2.840.10008.6.1.559", "Ultrasound Pelvis and Uterus";
"1.2.840.10008.6.1.560", "OB Equations and Tables";
"1.2.840.10008.6.1.561", "Gestational Age Equations and Tables";
"1.2.840.10008.6.1.562", "OB Fetal Body Weight Equations and Tables";
"1.2.840.10008.6.1.563", "Fetal Growth Equations and Tables";
"1.2.840.10008.6.1.564", "Estimated Fetal Weight Percentile Equations and Tables";
"1.2.840.10008.6.1.565", "Growth Distribution Rank";
"1.2.840.10008.6.1.566", "OB-GYN Summary";
"1.2.840.10008.6.1.567", "OB-GYN Fetus Summary";
"1.2.840.10008.6.1.568", "Vascular Summary";
"1.2.840.10008.6.1.569", "Temporal Periods Relating to Procedure or Therapy";
"1.2.840.10008.6.1.570", "Vascular Ultrasound Anatomic Location";
"1.2.840.10008.6.1.571", "Extracranial Arteries";
"1.2.840.10008.6.1.572", "Intracranial Cerebral Vessels";
"1.2.840.10008.6.1.573", "Intracranial Cerebral Vessels (unilateral)";
"1.2.840.10008.6.1.574", "Upper Extremity Arteries";
"1.2.840.10008.6.1.575", "Upper Extremity Veins";
"1.2.840.10008.6.1.576", "Lower Extremity Arteries";
"1.2.840.10008.6.1.577", "Lower Extremity Veins";
"1.2.840.10008.6.1.578", "Abdominal Arteries (lateral)";
"1.2.840.10008.6.1.579", "Abdominal Arteries (unilateral)";
"1.2.840.10008.6.1.580", "Abdominal Veins (lateral)";
"1.2.840.10008.6.1.581", "Abdominal Veins (unilateral)";
"1.2.840.10008.6.1.582", "Renal Vessels";
"1.2.840.10008.6.1.583", "Vessel Segment Modifiers";
"1.2.840.10008.6.1.584", "Vessel Branch Modifiers";
"1.2.840.10008.6.1.585", "Vascular Ultrasound Property";
"1.2.840.10008.6.1.586", "Blood Velocity Measurements by Ultrasound";
"1.2.840.10008.6.1.587", "Vascular Indices and Ratios";
"1.2.840.10008.6.1.588", "Other Vascular Properties";
"1.2.840.10008.6.1.589", "Carotid Ratios";
"1.2.840.10008.6.1.590", "Renal Ratios";
"1.2.840.10008.6.1.591", "Pelvic Vasculature Anatomical Location";
"1.2.840.10008.6.1.592", "Fetal Vasculature Anatomical Location";
"1.2.840.10008.6.1.593", "Echocardiography Left Ventricle";
"1.2.840.10008.6.1.594", "Left Ventricle Linear";
"1.2.840.10008.6.1.595", "Left Ventricle Volume";
"1.2.840.10008.6.1.596", "Left Ventricle Other";
"1.2.840.10008.6.1.597", "Echocardiography Right Ventricle";
"1.2.840.10008.6.1.598", "Echocardiography Left Atrium";
"1.2.840.10008.6.1.599", "Echocardiography Right Atrium";
"1.2.840.10008.6.1.600", "Echocardiography Mitral Valve";
"1.2.840.10008.6.1.601", "Echocardiography Tricuspid Valve";
"1.2.840.10008.6.1.602", "Echocardiography Pulmonic Valve";
"1.2.840.10008.6.1.603", "Echocardiography Pulmonary Artery";
"1.2.840.10008.6.1.604", "Echocardiography Aortic Valve";
"1.2.840.10008.6.1.605", "Echocardiography Aorta";
"1.2.840.10008.6.1.606", "Echocardiography Pulmonary Veins";
"1.2.840.10008.6.1.607", "Echocardiography Vena Cavae";
"1.2.840.10008.6.1.608", "Echocardiography Hepatic Veins";
"1.2.840.10008.6.1.609", "Echocardiography Cardiac Shunt";
"1.2.840.10008.6.1.610", "Echocardiography Congenital";
"1.2.840.10008.6.1.611", "Pulmonary Vein Modifiers";
"1.2.840.10008.6.1.612", "Echocardiography Common Measurements";
"1.2.840.10008.6.1.613", "Flow Direction";
"1.2.840.10008.6.1.614", "Orifice Flow Properties";
"1.2.840.10008.6.1.615", "Echocardiography Stroke Volume Origin";
"1.2.840.10008.6.1.616", "Ultrasound Image Modes";
"1.2.840.10008.6.1.617", "Echocardiography Image View";
"1.2.840.10008.6.1.618", "Echocardiography Measurement Method";
"1.2.840.10008.6.1.619", "Echocardiography Volume Methods";
"1.2.840.10008.6.1.620", "Echocardiography Area Methods";
"1.2.840.10008.6.1.621", "Gradient Methods";
"1.2.840.10008.6.1.622", "Volume Flow Methods";
"1.2.840.10008.6.1.623", "Myocardium Mass Methods";
"1.2.840.10008.6.1.624", "Cardiac Phase";
"1.2.840.10008.6.1.625", "Respiration State";
"1.2.840.10008.6.1.626", "Mitral Valve Anatomic Sites";
"1.2.840.10008.6.1.627", "Echo Anatomic Sites";
"1.2.840.10008.6.1.628", "Echocardiography Anatomic Site Modifiers";
"1.2.840.10008.6.1.629", "Wall Motion Scoring Schemes";
"1.2.840.10008.6.1.630", "Cardiac Output Properties";
"1.2.840.10008.6.1.631", "Left Ventricle Area";
"1.2.840.10008.6.1.632", "Tricuspid Valve Finding Sites";
"1.2.840.10008.6.1.633", "Aortic Valve Finding Sites";
"1.2.840.10008.6.1.634", "Left Ventricle Finding Sites";
"1.2.840.10008.6.1.635", "Congenital Finding Sites";
"1.2.840.10008.6.1.636", "Surface Processing Algorithm Families";
"1.2.840.10008.6.1.637", "Stress Test Procedure Phases";
"1.2.840.10008.6.1.638", "Stages";
"1.2.840.10008.6.1.735", "S-M-L Size Descriptor";
"1.2.840.10008.6.1.736", "Major Coronary Arteries";
"1.2.840.10008.6.1.737", "Units of Radioactivity";
"1.2.840.10008.6.1.738", "Rest-Stress";
"1.2.840.10008.6.1.739", "PET Cardiology Protocols";
"1.2.840.10008.6.1.740", "PET Cardiology Radiopharmaceuticals";
"1.2.840.10008.6.1.741", "NM/PET Procedures";
"1.2.840.10008.6.1.742", "Nuclear Cardiology Protocols";
"1.2.840.10008.6.1.743", "Nuclear Cardiology Radiopharmaceuticals";
"1.2.840.10008.6.1.744", "Attenuation Correction";
"1.2.840.10008.6.1.745", "Types of Perfusion Defects";
"1.2.840.10008.6.1.746", "Study Quality";
"1.2.840.10008.6.1.747", "Stress Imaging Quality Issues";
"1.2.840.10008.6.1.748", "NM Extracardiac Findings";
"1.2.840.10008.6.1.749", "Attenuation Correction Methods";
"1.2.840.10008.6.1.750", "Level of Risk";
"1.2.840.10008.6.1.751", "LV Function";
"1.2.840.10008.6.1.752", "Perfusion Findings";
"1.2.840.10008.6.1.753", "Perfusion Morphology";
"1.2.840.10008.6.1.754", "Ventricular Enlargement";
"1.2.840.10008.6.1.755", "Stress Test Procedure";
"1.2.840.10008.6.1.756", "Indications for Stress Test";
"1.2.840.10008.6.1.757", "Chest Pain";
"1.2.840.10008.6.1.758", "Exerciser Device";
"1.2.840.10008.6.1.759", "Stress Agents";
"1.2.840.10008.6.1.760", "Indications for Pharmacological Stress Test";
"1.2.840.10008.6.1.761", "Non-invasive Cardiac Imaging Procedures";
"1.2.840.10008.6.1.763", "Summary Codes Exercise ECG";
"1.2.840.10008.6.1.764", "Summary Codes Stress Imaging";
"1.2.840.10008.6.1.765", "Speed of Response";
"1.2.840.10008.6.1.766", "BP Response";
"1.2.840.10008.6.1.767", "Treadmill Speed";
"1.2.840.10008.6.1.768", "Stress Hemodynamic Findings";
"1.2.840.10008.6.1.769", "Perfusion Finding Method";
"1.2.840.10008.6.1.770", "Comparison Finding";
"1.2.840.10008.6.1.771", "Stress Symptoms";
"1.2.840.10008.6.1.772", "Stress Test Termination Reasons";
"1.2.840.10008.6.1.773", "QTc Measurements";
"1.2.840.10008.6.1.774", "ECG Timing Measurements";
"1.2.840.10008.6.1.775", "ECG Axis Measurements";
"1.2.840.10008.6.1.776", "ECG Findings";
"1.2.840.10008.6.1.777", "ST Segment Findings";
"1.2.840.10008.6.1.778", "ST Segment Location";
"1.2.840.10008.6.1.779", "ST Segment Morphology";
"1.2.840.10008.6.1.780", "Ectopic Beat Morphology";
"1.2.840.10008.6.1.781", "Perfusion Comparison Findings";
"1.2.840.10008.6.1.782", "Tolerance Comparison Findings";
"1.2.840.10008.6.1.783", "Wall Motion Comparison Findings";
"1.2.840.10008.6.1.784", "Stress Scoring Scales";
"1.2.840.10008.6.1.785", "Perceived Exertion Scales";
"1.2.840.10008.6.1.786", "Ventricle Identification";
"1.2.840.10008.6.1.787", "Colon Overall Assessment";
"1.2.840.10008.6.1.788", "Colon Finding or Feature";
"1.2.840.10008.6.1.789", "Colon Finding or Feature Modifier";
"1.2.840.10008.6.1.790", "Colon Non-Lesion Object Type";
"1.2.840.10008.6.1.791", "Anatomic Non-Colon Findings";
"1.2.840.10008.6.1.792", "Clockface Location for Colon";
"1.2.840.10008.6.1.793", "Recumbent Patient Orientation for Colon";
"1.2.840.10008.6.1.794", "Colon Quantitative Temporal Difference Type";
"1.2.840.10008.6.1.795", "Colon Types of Quality Control Standard";
"1.2.840.10008.6.1.796", "Colon Morphology Descriptor";
"1.2.840.10008.6.1.797", "Location in Intestinal Tract";
"1.2.840.10008.6.1.798", "Attenuation Coefficient Descriptors";
"1.2.840.10008.6.1.799", "Calculated Value for Colon Findings";
"1.2.840.10008.6.1.800", "Ophthalmic Horizontal Directions";
"1.2.840.10008.6.1.801", "Ophthalmic Vertical Directions";
"1.2.840.10008.6.1.802", "Ophthalmic Visual Acuity Type";
"1.2.840.10008.6.1.803", "Arterial Pulse Waveform";
"1.2.840.10008.6.1.804", "Respiration Waveform";
"1.2.840.10008.6.1.805", "Ultrasound Contrast/Bolus Agents";
"1.2.840.10008.6.1.806", "Protocol Interval Events";
"1.2.840.10008.6.1.807", "Transducer Scan Pattern";
"1.2.840.10008.6.1.808", "Ultrasound Transducer Geometry";
"1.2.840.10008.6.1.809", "Ultrasound Transducer Beam Steering";
"1.2.840.10008.6.1.810", "Ultrasound Transducer Application";
"1.2.840.10008.6.1.811", "Instance Availability Status";
"1.2.840.10008.6.1.812", "Modality PPS Discontinuation Reasons";
"1.2.840.10008.6.1.813", "Media Import PPS Discontinuation Reasons";
"1.2.840.10008.6.1.814", "DX Anatomy Imaged for Animals";
"1.2.840.10008.6.1.815", "Common Anatomic Regions for Animals";
"1.2.840.10008.6.1.816", "DX View for Animals";
"1.2.840.10008.6.1.817", "Institutional Departments, Units and Services";
"1.2.840.10008.6.1.818", "Purpose Of Reference to Predecessor Report";
"1.2.840.10008.6.1.819", "Visual Fixation Quality During Acquisition";
"1.2.840.10008.6.1.820", "Visual Fixation Quality Problem";
"1.2.840.10008.6.1.821", "Ophthalmic Macular Grid Problem";
"1.2.840.10008.6.1.822", "Organizations";
"1.2.840.10008.6.1.823", "Mixed Breeds";
"1.2.840.10008.6.1.824", "Broselow-Luten Pediatric Size Categories";
"1.2.840.10008.6.1.825", "Calcium Scoring Patient Size Categories";
"1.2.840.10008.6.1.826", "Cardiac Ultrasound Report Titles";
"1.2.840.10008.6.1.827", "Cardiac Ultrasound Indication for Study";
"1.2.840.10008.6.1.828", "Pediatric, Fetal and Congenital Cardiac Surgical Interventions";
"1.2.840.10008.6.1.829", "Cardiac Ultrasound Summary Codes";
"1.2.840.10008.6.1.830", "Cardiac Ultrasound Fetal Summary Codes";
"1.2.840.10008.6.1.831", "Cardiac Ultrasound Common Linear Measurements";
"1.2.840.10008.6.1.832", "Cardiac Ultrasound Linear Valve Measurements";
"1.2.840.10008.6.1.833", "Cardiac Ultrasound Cardiac Function";
"1.2.840.10008.6.1.834", "Cardiac Ultrasound Area Measurements";
"1.2.840.10008.6.1.835", "Cardiac Ultrasound Hemodynamic Measurements";
"1.2.840.10008.6.1.836", "Cardiac Ultrasound Myocardium Measurements";
"1.2.840.10008.6.1.837", "Cardiac Ultrasound Common Linear Flow Measurements";
"1.2.840.10008.6.1.838", "Cardiac Ultrasound Left Ventricle";
"1.2.840.10008.6.1.839", "Cardiac Ultrasound Right Ventricle";
"1.2.840.10008.6.1.840", "Cardiac Ultrasound Ventricles Measurements";
"1.2.840.10008.6.1.841", "Cardiac Ultrasound Pulmonary Artery";
"1.2.840.10008.6.1.842", "Cardiac Ultrasound Pulmonary Vein";
"1.2.840.10008.6.1.843", "Cardiac Ultrasound Pulmonary Valve";
"1.2.840.10008.6.1.844", "Cardiac Ultrasound Venous Return Pulmonary Measurements";
"1.2.840.10008.6.1.845", "Cardiac Ultrasound Venous Return Systemic Measurements";
"1.2.840.10008.6.1.846", "Cardiac Ultrasound Atria and Atrial Septum Measurements";
"1.2.840.10008.6.1.847", "Cardiac Ultrasound Mitral Valve";
"1.2.840.10008.6.1.848", "Cardiac Ultrasound Tricuspid Valve";
"1.2.840.10008.6.1.849", "Cardiac Ultrasound Atrioventricular Valves Measurements";
"1.2.840.10008.6.1.850", "Cardiac Ultrasound Interventricular Septum Measurements";
"1.2.840.10008.6.1.851", "Cardiac Ultrasound Aortic Valve";
"1.2.840.10008.6.1.852", "Cardiac Ultrasound Outflow Tracts Measurements";
"1.2.840.10008.6.1.853", "Cardiac Ultrasound Semilunar Valves, Annulus and Sinuses Measurements";
"1.2.840.10008.6.1.854", "Cardiac Ultrasound Aortic Sinotubular Junction";
"1.2.840.10008.6.1.855", "Cardiac Ultrasound Aorta Measurements";
"1.2.840.10008.6.1.856", "Cardiac Ultrasound Coronary Arteries Measurements";
"1.2.840.10008.6.1.857", "Cardiac Ultrasound Aorto Pulmonary Connections Measurements";
"1.2.840.10008.6.1.858", "Cardiac Ultrasound Pericardium and Pleura Measurements";
"1.2.840.10008.6.1.859", "Cardiac Ultrasound Fetal General Measurements";
"1.2.840.10008.6.1.860", "Cardiac Ultrasound Target Sites";
"1.2.840.10008.6.1.861", "Cardiac Ultrasound Target Site Modifiers";
"1.2.840.10008.6.1.862", "Cardiac Ultrasound Venous Return Systemic Finding Sites";
"1.2.840.10008.6.1.863", "Cardiac Ultrasound Venous Return Pulmonary Finding Sites";
"1.2.840.10008.6.1.864", "Cardiac Ultrasound Atria and Atrial Septum Finding Sites";
"1.2.840.10008.6.1.865", "Cardiac Ultrasound Atrioventricular Valves Findiing Sites";
"1.2.840.10008.6.1.866", "Cardiac Ultrasound Interventricular Septum Finding Sites";
"1.2.840.10008.6.1.867", "Cardiac Ultrasound Ventricles Finding Sites";
"1.2.840.10008.6.1.868", "Cardiac Ultrasound Outflow Tracts Finding Sites";
"1.2.840.10008.6.1.869", "Cardiac Ultrasound Semilunar Valves, Annulus and Sinuses Finding Sites";
"1.2.840.10008.6.1.870", "Cardiac Ultrasound Pulmonary Arteries Finding Sites";
"1.2.840.10008.6.1.871", "Cardiac Ultrasound Aorta Finding Sites";
"1.2.840.10008.6.1.872", "Cardiac Ultrasound Coronary Arteries Finding Sites";
"1.2.840.10008.6.1.873", "Cardiac Ultrasound Aorto Pulmonary Connections Finding Sites";
"1.2.840.10008.6.1.874", "Cardiac Ultrasound Pericardium and Pleura Finding Sites";
"1.2.840.10008.6.1.876", "Ophthalmic Ultrasound Axial Measurements Type";
"1.2.840.10008.6.1.877", "Lens Status";
"1.2.840.10008.6.1.878", "Vitreous Status";
"1.2.840.10008.6.1.879", "Ophthalmic Axial Length Measurements Segment Names";
"1.2.840.10008.6.1.880", "Refractive Surgery Types";
"1.2.840.10008.6.1.881", "Keratometry Descriptors";
"1.2.840.10008.6.1.882", "IOL Calculation Formula";
"1.2.840.10008.6.1.883", "Lens Constant Type";
"1.2.840.10008.6.1.884", "Refractive Error Types";
"1.2.840.10008.6.1.885", "Anterior Chamber Depth Definition";
"1.2.840.10008.6.1.886", "Ophthalmic Measurement or Calculation Data Source";
"1.2.840.10008.6.1.887", "Ophthalmic Axial Length Selection Method";
"1.2.840.10008.6.1.888", "";
"1.2.840.10008.6.1.889", "Ophthalmic Axial Length Quality Metric Type";
"1.2.840.10008.6.1.890", "Ophthalmic Agent Concentration Units";
"1.2.840.10008.6.1.891", "Functional condition present during acquisition";
"1.2.840.10008.6.1.892", "Joint position during acquisition";
"1.2.840.10008.6.1.893", "Joint positioning method";
"1.2.840.10008.6.1.894", "Physical force applied during acquisition";
"1.2.840.10008.6.1.895", "ECG Control Variables Numeric";
"1.2.840.10008.6.1.896", "ECG Control Variables Text";
"1.2.840.10008.6.1.897", "WSI Referenced Image Purposes of Reference";
"1.2.840.10008.6.1.898", "WSI Microscopy Lens Type";
"1.2.840.10008.6.1.899", "Microscopy Illuminator and Sensor Color";
"1.2.840.10008.6.1.900", "Microscopy Illumination Method";
"1.2.840.10008.6.1.901", "Microscopy Filter";
"1.2.840.10008.6.1.902", "Microscopy Illuminator Type";
"1.2.840.10008.6.1.903", "Audit Event ID";
"1.2.840.10008.6.1.904", "Audit Event Type Code";
"1.2.840.10008.6.1.905", "Audit Active Participant Role ID Code";
"1.2.840.10008.6.1.906", "Security Alert Type Code";
"1.2.840.10008.6.1.907", "Audit Participant Object ID Type Code";
"1.2.840.10008.6.1.908", "Media Type Code";
"1.2.840.10008.6.1.909", "Visual Field Static Perimetry Test Patterns";
"1.2.840.10008.6.1.910", "Visual Field Static Perimetry Test Strategies";
"1.2.840.10008.6.1.911", "Visual Field Static Perimetry Screening Test Modes";
"1.2.840.10008.6.1.912", "Visual Field Static Perimetry Fixation Strategy";
"1.2.840.10008.6.1.913", "Visual Field Static Perimetry Test Analysis Results";
"1.2.840.10008.6.1.914", "Visual Field Illumination Color";
"1.2.840.10008.6.1.915", "Visual Field Procedure Modifier";
"1.2.840.10008.6.1.916", "Visual Field Global Index Name";
"1.2.840.10008.6.1.917", "Abstract Multi-Dimensional Image Model Component Semantics";
"1.2.840.10008.6.1.918", "Abstract Multi-Dimensional Image Model Component Units";
"1.2.840.10008.6.1.919", "Abstract Multi-Dimensional Image Model Dimension Semantics";
"1.2.840.10008.6.1.920", "Abstract Multi-Dimensional Image Model Dimension Units";
"1.2.840.10008.6.1.921", "Abstract Multi-Dimensional Image Model Axis Direction";
"1.2.840.10008.6.1.922", "Abstract Multi-Dimensional Image Model Axis Orientation";
"1.2.840.10008.6.1.923", "Abstract Multi-Dimensional Image Model Qualitative Dimension Sample Semantics";
"1.2.840.10008.6.1.924", "Planning Methods";
"1.2.840.10008.6.1.925", "De-identification Method";
"1.2.840.10008.6.1.926", "Measurement Orientation";
"1.2.840.10008.6.1.927", "ECG Global Waveform Durations";
"1.2.840.10008.6.1.930", "ICDs";
"1.2.840.10008.6.1.931", "Radiotherapy General Workitem Definition";
"1.2.840.10008.6.1.932", "Radiotherapy Acquisition Workitem Definition";
"1.2.840.10008.6.1.933", "Radiotherapy Registration Workitem Definition";
"1.2.840.10008.6.1.934", "Intravascular OCT Flush Agent";
]


module Tag_constants = struct
let command_group_length = 0x0000_0000l
let affected_sop_class_uid = 0x0000_0002l
let requested_sopclass_uid = 0x0000_0003l
let command_field = 0x0000_0100l
let message_id = 0x0000_0110l
let message_id_being_responded_to = 0x0000_0120l
let move_destination = 0x0000_0600l
let priority = 0x0000_0700l
let command_data_set_type = 0x0000_0800l
let status = 0x0000_0900l
let offending_element = 0x0000_0901l
let error_comment = 0x0000_0902l
let error_id = 0x0000_0903l
let affected_sop_instance_uid = 0x0000_1000l
let requested_sop_instance_uid = 0x0000_1001l
let event_type_id = 0x0000_1002l
let attribute_identifier_list = 0x0000_1005l
let action_type_id = 0x0000_1008l
let number_of_remaining_suboperations = 0x0000_1020l
let number_of_completed_suboperations = 0x0000_1021l
let number_of_failed_suboperations = 0x0000_1022l
let number_of_warning_suboperations = 0x0000_1023l
let move_originator_application_entity_title = 0x0000_1030l
let move_originator_message_id = 0x0000_1031l
let command_length_to_end = 0x0000_0001l
let command_recognition_code = 0x0000_0010l
let initiator = 0x0000_0200l
let receiver = 0x0000_0300l
let find_location = 0x0000_0400l
let number_of_matches = 0x0000_0850l
let response_sequence_number = 0x0000_0860l
let dialog_receiver = 0x0000_4000l
let terminal_type = 0x0000_4010l
let message_set_id = 0x0000_5010l
let end_message_id = 0x0000_5020l
let display_format = 0x0000_5110l
let page_position_id = 0x0000_5120l
let text_format_id = 0x0000_5130l
let normal_reverse = 0x0000_5140l
let add_gray_scale = 0x0000_5150l
let borders = 0x0000_5160l
let copies = 0x0000_5170l
let command_magnification_type = 0x0000_5180l
let erase = 0x0000_5190l
let print = 0x0000_51a0l
let overlays = 0x0000_51b0l
let file_meta_information_group_length = 0x0002_0000l
let file_meta_information_version = 0x0002_0001l
let media_storage_sop_class_uid = 0x0002_0002l
let media_storage_sop_instance_uid = 0x0002_0003l
let transfer_syntax_uid = 0x0002_0010l
let implementation_class_uid = 0x0002_0012l
let implementation_version_name = 0x0002_0013l
let source_application_entity_title = 0x0002_0016l
let private_information_creator_uid = 0x0002_0100l
let private_information = 0x0002_0102l
let file_set_id = 0x0004_1130l
let file_set_descriptor_file_id = 0x0004_1141l
let specific_character_set_of_file_set_descriptor_file = 0x0004_1142l
let offset_of_the_first_directory_record_of_the_root_directory_entity = 0x0004_1200l
let offset_of_the_last_directory_record_of_the_root_directory_entity = 0x0004_1202l
let file_set_consistency_flag = 0x0004_1212l
let directory_record_sequence = 0x0004_1220l
let offset_of_the_next_directory_record = 0x0004_1400l
let record_in_use_flag = 0x0004_1410l
let offset_of_referenced_lower_level_directory_entity = 0x0004_1420l
let directory_record_type = 0x0004_1430l
let private_record_uid = 0x0004_1432l
let referenced_file_id = 0x0004_1500l
let mrdr_directory_record_offset = 0x0004_1504l
let referenced_sop_class_uid_in_file = 0x0004_1510l
let referenced_sop_instance_uid_in_file = 0x0004_1511l
let referenced_transfer_syntax_uid_in_file = 0x0004_1512l
let referenced_related_general_sop_class_uid_in_file = 0x0004_151al
let number_of_references = 0x0004_1600l
let length_to_end = 0x0008_0001l
let specific_character_set = 0x0008_0005l
let language_code_sequence = 0x0008_0006l
let image_type = 0x0008_0008l
let recognition_code = 0x0008_0010l
let instance_creation_date = 0x0008_0012l
let instance_creation_time = 0x0008_0013l
let instance_creator_uid = 0x0008_0014l
let sop_class_uid = 0x0008_0016l
let sop_instance_uid = 0x0008_0018l
let related_general_sop_class_uid = 0x0008_001al
let original_specialized_sop_class_uid = 0x0008_001bl
let study_date = 0x0008_0020l
let series_date = 0x0008_0021l
let acquisition_date = 0x0008_0022l
let content_date = 0x0008_0023l
let overlay_date = 0x0008_0024l
let curve_date = 0x0008_0025l
let acquisition_date_time = 0x0008_002al
let study_time = 0x0008_0030l
let series_time = 0x0008_0031l
let acquisition_time = 0x0008_0032l
let content_time = 0x0008_0033l
let overlay_time = 0x0008_0034l
let curve_time = 0x0008_0035l
let data_set_type = 0x0008_0040l
let data_set_subtype = 0x0008_0041l
let nuclear_medicine_series_type = 0x0008_0042l
let accession_number = 0x0008_0050l
let issuer_of_accession_number_sequence = 0x0008_0051l
let query_retrieve_level = 0x0008_0052l
let retrieve_ae_title = 0x0008_0054l
let instance_availability = 0x0008_0056l
let failed_sop_instance_uid_list = 0x0008_0058l
let modality = 0x0008_0060l
let modalities_in_study = 0x0008_0061l
let sop_classes_in_study = 0x0008_0062l
let conversion_type = 0x0008_0064l
let presentation_intent_type = 0x0008_0068l
let manufacturer = 0x0008_0070l
let institution_name = 0x0008_0080l
let institution_address = 0x0008_0081l
let institution_code_sequence = 0x0008_0082l
let referring_physician_name = 0x0008_0090l
let referring_physician_address = 0x0008_0092l
let referring_physician_telephone_numbers = 0x0008_0094l
let referring_physician_identification_sequence = 0x0008_0096l
let code_value = 0x0008_0100l
let coding_scheme_designator = 0x0008_0102l
let coding_scheme_version = 0x0008_0103l
let code_meaning = 0x0008_0104l
let mapping_resource = 0x0008_0105l
let context_group_version = 0x0008_0106l
let context_group_local_version = 0x0008_0107l
let context_group_extension_flag = 0x0008_010bl
let coding_scheme_uid = 0x0008_010cl
let context_group_extension_creator_uid = 0x0008_010dl
let context_identifier = 0x0008_010fl
let coding_scheme_identification_sequence = 0x0008_0110l
let coding_scheme_registry = 0x0008_0112l
let coding_scheme_external_id = 0x0008_0114l
let coding_scheme_name = 0x0008_0115l
let coding_scheme_responsible_organization = 0x0008_0116l
let context_uid = 0x0008_0117l
let timezone_offset_from_utc = 0x0008_0201l
let network_id = 0x0008_1000l
let station_name = 0x0008_1010l
let study_description = 0x0008_1030l
let procedure_code_sequence = 0x0008_1032l
let series_description = 0x0008_103el
let series_description_code_sequence = 0x0008_103fl
let institutional_department_name = 0x0008_1040l
let physicians_of_record = 0x0008_1048l
let physicians_of_record_identification_sequence = 0x0008_1049l
let performing_physician_name = 0x0008_1050l
let performing_physician_identification_sequence = 0x0008_1052l
let name_of_physicians_reading_study = 0x0008_1060l
let physicians_reading_study_identification_sequence = 0x0008_1062l
let operators_name = 0x0008_1070l
let operator_identification_sequence = 0x0008_1072l
let admitting_diagnoses_description = 0x0008_1080l
let admitting_diagnoses_code_sequence = 0x0008_1084l
let manufacturer_model_name = 0x0008_1090l
let referenced_results_sequence = 0x0008_1100l
let referenced_study_sequence = 0x0008_1110l
let referenced_performed_procedure_step_sequence = 0x0008_1111l
let referenced_series_sequence = 0x0008_1115l
let referenced_patient_sequence = 0x0008_1120l
let referenced_visit_sequence = 0x0008_1125l
let referenced_overlay_sequence = 0x0008_1130l
let referenced_stereometric_instance_sequence = 0x0008_1134l
let referenced_waveform_sequence = 0x0008_113al
let referenced_image_sequence = 0x0008_1140l
let referenced_curve_sequence = 0x0008_1145l
let referenced_instance_sequence = 0x0008_114al
let referenced_real_world_value_mapping_instance_sequence = 0x0008_114bl
let referenced_sop_class_uid = 0x0008_1150l
let referenced_sop_instance_uid = 0x0008_1155l
let sop_classes_supported = 0x0008_115al
let referenced_frame_number = 0x0008_1160l
let simple_frame_list = 0x0008_1161l
let calculated_frame_list = 0x0008_1162l
let time_range = 0x0008_1163l
let frame_extraction_sequence = 0x0008_1164l
let multi_frame_source_sop_instance_uid = 0x0008_1167l
let transaction_uid = 0x0008_1195l
let failure_reason = 0x0008_1197l
let failed_sop_sequence = 0x0008_1198l
let referenced_sop_sequence = 0x0008_1199l
let studies_containing_other_referenced_instances_sequence = 0x0008_1200l
let related_series_sequence = 0x0008_1250l
let lossy_image_compression_retired = 0x0008_2110l
let derivation_description = 0x0008_2111l
let source_image_sequence = 0x0008_2112l
let stage_name = 0x0008_2120l
let stage_number = 0x0008_2122l
let number_of_stages = 0x0008_2124l
let view_name = 0x0008_2127l
let view_number = 0x0008_2128l
let number_of_event_timers = 0x0008_2129l
let number_of_views_in_stage = 0x0008_212al
let event_elapsed_times = 0x0008_2130l
let event_timer_names = 0x0008_2132l
let event_timer_sequence = 0x0008_2133l
let event_time_offset = 0x0008_2134l
let event_code_sequence = 0x0008_2135l
let start_trim = 0x0008_2142l
let stop_trim = 0x0008_2143l
let recommended_display_frame_rate = 0x0008_2144l
let transducer_position = 0x0008_2200l
let transducer_orientation = 0x0008_2204l
let anatomic_structure = 0x0008_2208l
let anatomic_region_sequence = 0x0008_2218l
let anatomic_region_modifier_sequence = 0x0008_2220l
let primary_anatomic_structure_sequence = 0x0008_2228l
let anatomic_structure_space_or_region_sequence = 0x0008_2229l
let primary_anatomic_structure_modifier_sequence = 0x0008_2230l
let transducer_position_sequence = 0x0008_2240l
let transducer_position_modifier_sequence = 0x0008_2242l
let transducer_orientation_sequence = 0x0008_2244l
let transducer_orientation_modifier_sequence = 0x0008_2246l
let anatomic_structure_space_or_region_code_sequence_trial = 0x0008_2251l
let anatomic_portal_of_entrance_code_sequence_trial = 0x0008_2253l
let anatomic_approach_direction_code_sequence_trial = 0x0008_2255l
let anatomic_perspective_description_trial = 0x0008_2256l
let anatomic_perspective_code_sequence_trial = 0x0008_2257l
let anatomic_location_of_examining_instrument_description_trial = 0x0008_2258l
let anatomic_location_of_examining_instrument_code_sequence_trial = 0x0008_2259l
let anatomic_structure_space_or_region_modifier_code_sequence_trial = 0x0008_225Al
let on_axis_background_anatomic_structure_code_sequence_trial = 0x0008_225Cl
let alternate_representation_sequence = 0x0008_3001l
let irradiation_event_uid = 0x0008_3010l
let identifying_comments = 0x0008_4000l
let frame_type = 0x0008_9007l
let referenced_image_evidence_sequence = 0x0008_9092l
let referenced_raw_data_sequence = 0x0008_9121l
let creator_version_uid = 0x0008_9123l
let derivation_image_sequence = 0x0008_9124l
let source_image_evidence_sequence = 0x0008_9154l
let pixel_presentation = 0x0008_9205l
let volumetric_properties = 0x0008_9206l
let volume_based_calculation_technique = 0x0008_9207l
let complex_image_component = 0x0008_9208l
let acquisition_contrast = 0x0008_9209l
let derivation_code_sequence = 0x0008_9215l
let referenced_presentation_state_sequence = 0x0008_9237l
let referenced_other_plane_sequence = 0x0008_9410l
let frame_display_sequence = 0x0008_9458l
let recommended_display_frame_rate_in_float = 0x0008_9459l
let skip_frame_range_flag = 0x0008_9460l
let patient_name = 0x0010_0010l
let patient_id = 0x0010_0020l
let issuer_of_patient_id = 0x0010_0021l
let type_of_patient_id = 0x0010_0022l
let issuer_of_patient_id_qualifiers_sequence = 0x0010_0024l
let patient_birth_date = 0x0010_0030l
let patient_birth_time = 0x0010_0032l
let patient_sex = 0x0010_0040l
let patient_insurance_plan_code_sequence = 0x0010_0050l
let patient_primary_language_code_sequence = 0x0010_0101l
let patient_primary_language_modifier_code_sequence = 0x0010_0102l
let other_patient_ids = 0x0010_1000l
let other_patient_names = 0x0010_1001l
let other_patient_ids_sequence = 0x0010_1002l
let patient_birth_name = 0x0010_1005l
let patient_age = 0x0010_1010l
let patient_size = 0x0010_1020l
let patient_size_code_sequence = 0x0010_1021l
let patient_weight = 0x0010_1030l
let patient_address = 0x0010_1040l
let insurance_plan_identification = 0x0010_1050l
let patient_mother_birth_name = 0x0010_1060l
let military_rank = 0x0010_1080l
let branch_of_service = 0x0010_1081l
let medical_record_locator = 0x0010_1090l
let medical_alerts = 0x0010_2000l
let allergies = 0x0010_2110l
let country_of_residence = 0x0010_2150l
let region_of_residence = 0x0010_2152l
let patient_telephone_numbers = 0x0010_2154l
let ethnic_group = 0x0010_2160l
let occupation = 0x0010_2180l
let smoking_status = 0x0010_21A0l
let additional_patient_history = 0x0010_21B0l
let pregnancy_status = 0x0010_21C0l
let last_menstrual_date = 0x0010_21D0l
let patient_religious_preference = 0x0010_21F0l
let patient_species_description = 0x0010_2201l
let patient_species_code_sequence = 0x0010_2202l
let patient_sex_neutered = 0x0010_2203l
let anatomical_orientation_type = 0x0010_2210l
let patient_breed_description = 0x0010_2292l
let patient_breed_code_sequence = 0x0010_2293l
let breed_registration_sequence = 0x0010_2294l
let breed_registration_number = 0x0010_2295l
let breed_registry_code_sequence = 0x0010_2296l
let responsible_person = 0x0010_2297l
let responsible_person_role = 0x0010_2298l
let responsible_organization = 0x0010_2299l
let patient_comments = 0x0010_4000l
let examined_body_thickness = 0x0010_9431l
let clinical_trial_sponsor_name = 0x0012_0010l
let clinical_trial_protocol_id = 0x0012_0020l
let clinical_trial_protocol_name = 0x0012_0021l
let clinical_trial_site_id = 0x0012_0030l
let clinical_trial_site_name = 0x0012_0031l
let clinical_trial_subject_id = 0x0012_0040l
let clinical_trial_subject_reading_id = 0x0012_0042l
let clinical_trial_time_point_id = 0x0012_0050l
let clinical_trial_time_point_description = 0x0012_0051l
let clinical_trial_coordinating_center_name = 0x0012_0060l
let patient_identity_removed = 0x0012_0062l
let deidentification_method = 0x0012_0063l
let deidentification_method_code_sequence = 0x0012_0064l
let clinical_trial_series_id = 0x0012_0071l
let clinical_trial_series_description = 0x0012_0072l
let clinical_trial_protocol_ethics_committee_name = 0x0012_0081l
let clinical_trial_protocol_ethics_committee_approval_number = 0x0012_0082l
let consent_for_clinical_trial_use_sequence = 0x0012_0083l
let distribution_type = 0x0012_0084l
let consent_for_distribution_flag = 0x0012_0085l
let cad_file_format = 0x0014_0023l
let component_reference_system = 0x0014_0024l
let component_manufacturing_procedure = 0x0014_0025l
let component_manufacturer = 0x0014_0028l
let material_thickness = 0x0014_0030l
let material_pipe_diameter = 0x0014_0032l
let material_isolation_diameter = 0x0014_0034l
let material_grade = 0x0014_0042l
let material_properties_file_id = 0x0014_0044l
let material_properties_file_format = 0x0014_0045l
let material_notes = 0x0014_0046l
let component_shape = 0x0014_0050l
let curvature_type = 0x0014_0052l
let outer_diameter = 0x0014_0054l
let inner_diameter = 0x0014_0056l
let actual_environmental_conditions = 0x0014_1010l
let expiry_date = 0x0014_1020l
let environmental_conditions = 0x0014_1040l
let evaluator_sequence = 0x0014_2002l
let evaluator_number = 0x0014_2004l
let evaluator_name = 0x0014_2006l
let evaluation_attempt = 0x0014_2008l
let indication_sequence = 0x0014_2012l
let indication_number = 0x0014_2014l
let indication_label = 0x0014_2016l
let indication_description = 0x0014_2018l
let indication_type = 0x0014_201Al
let indication_disposition = 0x0014_201Cl
let indication_roisequence = 0x0014_201El
let indication_physical_property_sequence = 0x0014_2030l
let property_label = 0x0014_2032l
let coordinate_system_number_of_axes = 0x0014_2202l
let coordinate_system_axes_sequence = 0x0014_2204l
let coordinate_system_axis_description = 0x0014_2206l
let coordinate_system_data_set_mapping = 0x0014_2208l
let coordinate_system_axis_number = 0x0014_220Al
let coordinate_system_axis_type = 0x0014_220Cl
let coordinate_system_axis_units = 0x0014_220El
let coordinate_system_axis_values = 0x0014_2210l
let coordinate_system_transform_sequence = 0x0014_2220l
let transform_description = 0x0014_2222l
let transform_number_of_axes = 0x0014_2224l
let transform_order_of_axes = 0x0014_2226l
let transformed_axis_units = 0x0014_2228l
let coordinate_system_transform_rotation_and_scale_matrix = 0x0014_222Al
let coordinate_system_transform_translation_matrix = 0x0014_222Cl
let internal_detector_frame_time = 0x0014_3011l
let number_of_frames_integrated = 0x0014_3012l
let detector_temperature_sequence = 0x0014_3020l
let sensor_name = 0x0014_3022l
let horizontal_offset_of_sensor = 0x0014_3024l
let vertical_offset_of_sensor = 0x0014_3026l
let sensor_temperature = 0x0014_3028l
let dark_current_sequence = 0x0014_3040l
let dark_current_counts = 0x0014_3050l
let gain_correction_reference_sequence = 0x0014_3060l
let air_counts = 0x0014_3070l
let kv_used_in_gain_calibration = 0x0014_3071l
let ma_used_in_gain_calibration = 0x0014_3072l
let number_of_frames_used_for_integration = 0x0014_3073l
let filter_material_used_in_gain_calibration = 0x0014_3074l
let filter_thickness_used_in_gain_calibration = 0x0014_3075l
let date_of_gain_calibration = 0x0014_3076l
let time_of_gain_calibration = 0x0014_3077l
let bad_pixel_image = 0x0014_3080l
let calibration_notes = 0x0014_3099l
let pulser_equipment_sequence = 0x0014_4002l
let pulser_type = 0x0014_4004l
let pulser_notes = 0x0014_4006l
let receiver_equipment_sequence = 0x0014_4008l
let amplifier_type = 0x0014_400Al
let receiver_notes = 0x0014_400Cl
let pre_amplifier_equipment_sequence = 0x0014_400El
let pre_amplifier_notes = 0x0014_400Fl
let transmit_transducer_sequence = 0x0014_4010l
let receive_transducer_sequence = 0x0014_4011l
let number_of_elements = 0x0014_4012l
let element_shape = 0x0014_4013l
let element_dimension_a = 0x0014_4014l
let element_dimension_b = 0x0014_4015l
let element_pitch = 0x0014_4016l
let measured_beam_dimension_a = 0x0014_4017l
let measured_beam_dimension_b = 0x0014_4018l
let location_of_measured_beam_diameter = 0x0014_4019l
let nominal_frequency = 0x0014_401Al
let measured_center_frequency = 0x0014_401Bl
let measured_bandwidth = 0x0014_401Cl
let pulser_settings_sequence = 0x0014_4020l
let pulse_width = 0x0014_4022l
let excitation_frequency = 0x0014_4024l
let modulation_type = 0x0014_4026l
let damping = 0x0014_4028l
let receiver_settings_sequence = 0x0014_4030l
let acquired_soundpath_length = 0x0014_4031l
let acquisition_compression_type = 0x0014_4032l
let acquisition_sample_size = 0x0014_4033l
let rectifier_smoothing = 0x0014_4034l
let dacsequence = 0x0014_4035l
let dactype = 0x0014_4036l
let dacgainpoints = 0x0014_4038l
let dactimepoints = 0x0014_403Al
let dacamplitude = 0x0014_403Cl
let pre_amplifier_settings_sequence = 0x0014_4040l
let transmit_transducer_settings_sequence = 0x0014_4050l
let receive_transducer_settings_sequence = 0x0014_4051l
let incident_angle = 0x0014_4052l
let coupling_technique = 0x0014_4054l
let coupling_medium = 0x0014_4056l
let coupling_velocity = 0x0014_4057l
let crystal_center_location_x = 0x0014_4058l
let crystal_center_location_z = 0x0014_4059l
let sound_path_length = 0x0014_405Al
let delay_law_identifier = 0x0014_405Cl
let gate_settings_sequence = 0x0014_4060l
let gate_threshold = 0x0014_4062l
let velocity_of_sound = 0x0014_4064l
let calibration_settings_sequence = 0x0014_4070l
let calibration_procedure = 0x0014_4072l
let procedure_version = 0x0014_4074l
let procedure_creation_date = 0x0014_4076l
let procedure_expiration_date = 0x0014_4078l
let procedure_last_modified_date = 0x0014_407Al
let calibration_time = 0x0014_407Cl
let calibration_date = 0x0014_407El
let linacenergy = 0x0014_5002l
let linacoutput = 0x0014_5004l
let contrast_bolus_agent = 0x0018_0010l
let contrast_bolus_agent_sequence = 0x0018_0012l
let contrast_bolus_administration_route_sequence = 0x0018_0014l
let body_part_examined = 0x0018_0015l
let scanning_sequence = 0x0018_0020l
let sequence_variant = 0x0018_0021l
let scan_options = 0x0018_0022l
let mr_acquisition_type = 0x0018_0023l
let sequence_name = 0x0018_0024l
let angio_flag = 0x0018_0025l
let intervention_drug_information_sequence = 0x0018_0026l
let intervention_drug_stop_time = 0x0018_0027l
let intervention_drug_dose = 0x0018_0028l
let intervention_drug_code_sequence = 0x0018_0029l
let additional_drug_sequence = 0x0018_002Al
let radionuclide = 0x0018_0030l
let radiopharmaceutical = 0x0018_0031l
let energy_window_centerline = 0x0018_0032l
let energy_window_total_width = 0x0018_0033l
let intervention_drug_name = 0x0018_0034l
let intervention_drug_start_time = 0x0018_0035l
let intervention_sequence = 0x0018_0036l
let therapy_type = 0x0018_0037l
let intervention_status = 0x0018_0038l
let therapy_description = 0x0018_0039l
let intervention_description = 0x0018_003Al
let cine_rate = 0x0018_0040l
let initial_cine_run_state = 0x0018_0042l
let slice_thickness = 0x0018_0050l
let kvp = 0x0018_0060l
let counts_accumulated = 0x0018_0070l
let acquisition_termination_condition = 0x0018_0071l
let effective_duration = 0x0018_0072l
let acquisition_start_condition = 0x0018_0073l
let acquisition_start_condition_data = 0x0018_0074l
let acquisition_termination_condition_data = 0x0018_0075l
let repetition_time = 0x0018_0080l
let echo_time = 0x0018_0081l
let inversion_time = 0x0018_0082l
let number_of_averages = 0x0018_0083l
let imaging_frequency = 0x0018_0084l
let imaged_nucleus = 0x0018_0085l
let echo_numbers = 0x0018_0086l
let magnetic_field_strength = 0x0018_0087l
let spacing_between_slices = 0x0018_0088l
let number_of_phase_encoding_steps = 0x0018_0089l
let data_collection_diameter = 0x0018_0090l
let echo_train_length = 0x0018_0091l
let percent_sampling = 0x0018_0093l
let percent_phase_field_of_view = 0x0018_0094l
let pixel_bandwidth = 0x0018_0095l
let device_serial_number = 0x0018_1000l
let device_uid = 0x0018_1002l
let device_id = 0x0018_1003l
let plate_id = 0x0018_1004l
let generator_id = 0x0018_1005l
let grid_id = 0x0018_1006l
let cassette_id = 0x0018_1007l
let gantry_id = 0x0018_1008l
let secondary_capture_device_id = 0x0018_1010l
let hardcopy_creation_device_id = 0x0018_1011l
let date_of_secondary_capture = 0x0018_1012l
let time_of_secondary_capture = 0x0018_1014l
let secondary_capture_device_manufacturer = 0x0018_1016l
let hardcopy_device_manufacturer = 0x0018_1017l
let secondary_capture_device_manufacturer_model_name = 0x0018_1018l
let secondary_capture_device_software_versions = 0x0018_1019l
let hardcopy_device_software_version = 0x0018_101Al
let hardcopy_device_manufacturer_model_name = 0x0018_101Bl
let software_versions = 0x0018_1020l
let video_image_format_acquired = 0x0018_1022l
let digital_image_format_acquired = 0x0018_1023l
let protocol_name = 0x0018_1030l
let contrast_bolus_route = 0x0018_1040l
let contrast_bolus_volume = 0x0018_1041l
let contrast_bolus_start_time = 0x0018_1042l
let contrast_bolus_stop_time = 0x0018_1043l
let contrast_bolus_total_dose = 0x0018_1044l
let syringe_counts = 0x0018_1045l
let contrast_flow_rate = 0x0018_1046l
let contrast_flow_duration = 0x0018_1047l
let contrast_bolus_ingredient = 0x0018_1048l
let contrast_bolus_ingredient_concentration = 0x0018_1049l
let spatial_resolution = 0x0018_1050l
let trigger_time = 0x0018_1060l
let trigger_source_or_type = 0x0018_1061l
let nominal_interval = 0x0018_1062l
let frame_time = 0x0018_1063l
let cardiac_framing_type = 0x0018_1064l
let frame_time_vector = 0x0018_1065l
let frame_delay = 0x0018_1066l
let image_trigger_delay = 0x0018_1067l
let multiplex_group_time_offset = 0x0018_1068l
let trigger_time_offset = 0x0018_1069l
let synchronization_trigger = 0x0018_106Al
let synchronization_channel = 0x0018_106Cl
let trigger_sample_position = 0x0018_106El
let radiopharmaceutical_route = 0x0018_1070l
let radiopharmaceutical_volume = 0x0018_1071l
let radiopharmaceutical_start_time = 0x0018_1072l
let radiopharmaceutical_stop_time = 0x0018_1073l
let radionuclide_total_dose = 0x0018_1074l
let radionuclide_half_life = 0x0018_1075l
let radionuclide_positron_fraction = 0x0018_1076l
let radiopharmaceutical_specific_activity = 0x0018_1077l
let radiopharmaceutical_start_date_time = 0x0018_1078l
let radiopharmaceutical_stop_date_time = 0x0018_1079l
let beat_rejection_flag = 0x0018_1080l
let low_rr_value = 0x0018_1081l
let high_rr_value = 0x0018_1082l
let intervals_acquired = 0x0018_1083l
let intervals_rejected = 0x0018_1084l
let p_vcrejection = 0x0018_1085l
let skip_beats = 0x0018_1086l
let heart_rate = 0x0018_1088l
let cardiac_number_of_images = 0x0018_1090l
let trigger_window = 0x0018_1094l
let reconstruction_diameter = 0x0018_1100l
let distance_source_to_detector = 0x0018_1110l
let distance_source_to_patient = 0x0018_1111l
let estimated_radiographic_magnification_factor = 0x0018_1114l
let gantry_detector_tilt = 0x0018_1120l
let gantry_detector_slew = 0x0018_1121l
let table_height = 0x0018_1130l
let table_traverse = 0x0018_1131l
let table_motion = 0x0018_1134l
let table_vertical_increment = 0x0018_1135l
let table_lateral_increment = 0x0018_1136l
let table_longitudinal_increment = 0x0018_1137l
let table_angle = 0x0018_1138l
let table_type = 0x0018_113Al
let rotation_direction = 0x0018_1140l
let angular_position = 0x0018_1141l
let radial_position = 0x0018_1142l
let scan_arc = 0x0018_1143l
let angular_step = 0x0018_1144l
let center_of_rotation_offset = 0x0018_1145l
let rotation_offset = 0x0018_1146l
let field_of_view_shape = 0x0018_1147l
let field_of_view_dimensions = 0x0018_1149l
let exposure_time = 0x0018_1150l
let x_ray_tube_current = 0x0018_1151l
let exposure = 0x0018_1152l
let exposure_inu_as = 0x0018_1153l
let average_pulse_width = 0x0018_1154l
let radiation_setting = 0x0018_1155l
let rectification_type = 0x0018_1156l
let radiation_mode = 0x0018_115Al
let image_and_fluoroscopy_area_dose_product = 0x0018_115El
let filter_type = 0x0018_1160l
let type_of_filters = 0x0018_1161l
let intensifier_size = 0x0018_1162l
let imager_pixel_spacing = 0x0018_1164l
let grid = 0x0018_1166l
let generator_power = 0x0018_1170l
let collimator_grid_name = 0x0018_1180l
let collimator_type = 0x0018_1181l
let focal_distance = 0x0018_1182l
let x_focus_center = 0x0018_1183l
let y_focus_center = 0x0018_1184l
let focal_spots = 0x0018_1190l
let anode_target_material = 0x0018_1191l
let body_part_thickness = 0x0018_11A0l
let compression_force = 0x0018_11A2l
let date_of_last_calibration = 0x0018_1200l
let time_of_last_calibration = 0x0018_1201l
let convolution_kernel = 0x0018_1210l
let upper_lower_pixel_values = 0x0018_1240l
let actual_frame_duration = 0x0018_1242l
let count_rate = 0x0018_1243l
let preferred_playback_sequencing = 0x0018_1244l
let receive_coil_name = 0x0018_1250l
let transmit_coil_name = 0x0018_1251l
let plate_type = 0x0018_1260l
let phosphor_type = 0x0018_1261l
let scan_velocity = 0x0018_1300l
let whole_body_technique = 0x0018_1301l
let scan_length = 0x0018_1302l
let acquisition_matrix = 0x0018_1310l
let in_plane_phase_encoding_direction = 0x0018_1312l
let flip_angle = 0x0018_1314l
let variable_flip_angle_flag = 0x0018_1315l
let sat = 0x0018_1316l
let dbdt = 0x0018_1318l
let acquisition_device_processing_description = 0x0018_1400l
let acquisition_device_processing_code = 0x0018_1401l
let cassette_orientation = 0x0018_1402l
let cassette_size = 0x0018_1403l
let exposures_on_plate = 0x0018_1404l
let relative_x_ray_exposure = 0x0018_1405l
let exposure_index = 0x0018_1411l
let target_exposure_index = 0x0018_1412l
let deviation_index = 0x0018_1413l
let column_angulation = 0x0018_1450l
let tomo_layer_height = 0x0018_1460l
let tomo_angle = 0x0018_1470l
let tomo_time = 0x0018_1480l
let tomo_type = 0x0018_1490l
let tomo_class = 0x0018_1491l
let number_of_tomosynthesis_source_images = 0x0018_1495l
let positioner_motion = 0x0018_1500l
let positioner_type = 0x0018_1508l
let positioner_primary_angle = 0x0018_1510l
let positioner_secondary_angle = 0x0018_1511l
let positioner_primary_angle_increment = 0x0018_1520l
let positioner_secondary_angle_increment = 0x0018_1521l
let detector_primary_angle = 0x0018_1530l
let detector_secondary_angle = 0x0018_1531l
let shutter_shape = 0x0018_1600l
let shutter_left_vertical_edge = 0x0018_1602l
let shutter_right_vertical_edge = 0x0018_1604l
let shutter_upper_horizontal_edge = 0x0018_1606l
let shutter_lower_horizontal_edge = 0x0018_1608l
let center_of_circular_shutter = 0x0018_1610l
let radius_of_circular_shutter = 0x0018_1612l
let vertices_of_the_polygonal_shutter = 0x0018_1620l
let shutter_presentation_value = 0x0018_1622l
let shutter_overlay_group = 0x0018_1623l
let shutter_presentation_color_cielab_value = 0x0018_1624l
let collimator_shape = 0x0018_1700l
let collimator_left_vertical_edge = 0x0018_1702l
let collimator_right_vertical_edge = 0x0018_1704l
let collimator_upper_horizontal_edge = 0x0018_1706l
let collimator_lower_horizontal_edge = 0x0018_1708l
let center_of_circular_collimator = 0x0018_1710l
let radius_of_circular_collimator = 0x0018_1712l
let vertices_of_the_polygonal_collimator = 0x0018_1720l
let acquisition_time_synchronized = 0x0018_1800l
let time_source = 0x0018_1801l
let time_distribution_protocol = 0x0018_1802l
let ntp_source_address = 0x0018_1803l
let page_number_vector = 0x0018_2001l
let frame_label_vector = 0x0018_2002l
let frame_primary_angle_vector = 0x0018_2003l
let frame_secondary_angle_vector = 0x0018_2004l
let slice_location_vector = 0x0018_2005l
let display_window_label_vector = 0x0018_2006l
let nominal_scanned_pixel_spacing = 0x0018_2010l
let digitizing_device_transport_direction = 0x0018_2020l
let rotation_of_scanned_film = 0x0018_2030l
let ivus_acquisition = 0x0018_3100l
let ivus_pullback_rate = 0x0018_3101l
let ivus_gated_rate = 0x0018_3102l
let ivus_pullback_start_frame_number = 0x0018_3103l
let ivus_pullback_stop_frame_number = 0x0018_3104l
let lesion_number = 0x0018_3105l
let acquisition_comments = 0x0018_4000l
let output_power = 0x0018_5000l
let transducer_data = 0x0018_5010l
let focus_depth = 0x0018_5012l
let processing_function = 0x0018_5020l
let postprocessing_function = 0x0018_5021l
let mechanical_index = 0x0018_5022l
let bone_thermal_index = 0x0018_5024l
let cranial_thermal_index = 0x0018_5026l
let soft_tissue_thermal_index = 0x0018_5027l
let soft_tissue_focus_thermal_index = 0x0018_5028l
let soft_tissue_surface_thermal_index = 0x0018_5029l
let dynamic_range = 0x0018_5030l
let total_gain = 0x0018_5040l
let depth_of_scan_field = 0x0018_5050l
let patient_position = 0x0018_5100l
let view_position = 0x0018_5101l
let projection_eponymous_name_code_sequence = 0x0018_5104l
let image_transformation_matrix = 0x0018_5210l
let image_translation_vector = 0x0018_5212l
let sensitivity = 0x0018_6000l
let sequence_of_ultrasound_regions = 0x0018_6011l
let region_spatial_format = 0x0018_6012l
let region_data_type = 0x0018_6014l
let region_flags = 0x0018_6016l
let region_location_min_x0 = 0x0018_6018l
let region_location_min_y0 = 0x0018_601Al
let region_location_max_x1 = 0x0018_601Cl
let region_location_max_y1 = 0x0018_601El
let reference_pixel_x0 = 0x0018_6020l
let reference_pixel_y0 = 0x0018_6022l
let physical_units_xdirection = 0x0018_6024l
let physical_units_ydirection = 0x0018_6026l
let reference_pixel_physical_value_x = 0x0018_6028l
let reference_pixel_physical_value_y = 0x0018_602Al
let physical_delta_x = 0x0018_602Cl
let physical_delta_y = 0x0018_602El
let transducer_frequency = 0x0018_6030l
let transducer_type = 0x0018_6031l
let pulse_repetition_frequency = 0x0018_6032l
let doppler_correction_angle = 0x0018_6034l
let steering_angle = 0x0018_6036l
let doppler_sample_volume_xposition_retired = 0x0018_6038l
let doppler_sample_volume_xposition = 0x0018_6039l
let doppler_sample_volume_yposition_retired = 0x0018_603Al
let doppler_sample_volume_yposition = 0x0018_603Bl
let tm_line_position_x0_retired = 0x0018_603Cl
let tm_line_position_x0 = 0x0018_603Dl
let tm_line_position_y0_retired = 0x0018_603El
let tm_line_position_y0 = 0x0018_603Fl
let tm_line_position_x1_retired = 0x0018_6040l
let tm_line_position_x1 = 0x0018_6041l
let tm_line_position_y1_retired = 0x0018_6042l
let tm_line_position_y1 = 0x0018_6043l
let pixel_component_organization = 0x0018_6044l
let pixel_component_mask = 0x0018_6046l
let pixel_component_range_start = 0x0018_6048l
let pixel_component_range_stop = 0x0018_604Al
let pixel_component_physical_units = 0x0018_604Cl
let pixel_component_data_type = 0x0018_604El
let number_of_table_break_points = 0x0018_6050l
let table_of_xbreak_points = 0x0018_6052l
let table_of_ybreak_points = 0x0018_6054l
let number_of_table_entries = 0x0018_6056l
let table_of_pixel_values = 0x0018_6058l
let table_of_parameter_values = 0x0018_605Al
let r_wave_time_vector = 0x0018_6060l
let detector_conditions_nominal_flag = 0x0018_7000l
let detector_temperature = 0x0018_7001l
let detector_type = 0x0018_7004l
let detector_configuration = 0x0018_7005l
let detector_description = 0x0018_7006l
let detector_mode = 0x0018_7008l
let detector_id = 0x0018_700Al
let date_of_last_detector_calibration = 0x0018_700Cl
let time_of_last_detector_calibration = 0x0018_700El
let exposures_on_detector_since_last_calibration = 0x0018_7010l
let exposures_on_detector_since_manufactured = 0x0018_7011l
let detector_time_since_last_exposure = 0x0018_7012l
let detector_active_time = 0x0018_7014l
let detector_activation_offset_from_exposure = 0x0018_7016l
let detector_binning = 0x0018_701Al
let detector_element_physical_size = 0x0018_7020l
let detector_element_spacing = 0x0018_7022l
let detector_active_shape = 0x0018_7024l
let detector_active_dimensions = 0x0018_7026l
let detector_active_origin = 0x0018_7028l
let detector_manufacturer_name = 0x0018_702Al
let detector_manufacturer_model_name = 0x0018_702Bl
let field_of_view_origin = 0x0018_7030l
let field_of_view_rotation = 0x0018_7032l
let field_of_view_horizontal_flip = 0x0018_7034l
let pixel_data_area_origin_relative_to_fov = 0x0018_7036l
let pixel_data_area_rotation_angle_relative_to_fov = 0x0018_7038l
let grid_absorbing_material = 0x0018_7040l
let grid_spacing_material = 0x0018_7041l
let grid_thickness = 0x0018_7042l
let grid_pitch = 0x0018_7044l
let grid_aspect_ratio = 0x0018_7046l
let grid_period = 0x0018_7048l
let grid_focal_distance = 0x0018_704Cl
let filter_material = 0x0018_7050l
let filter_thickness_minimum = 0x0018_7052l
let filter_thickness_maximum = 0x0018_7054l
let filter_beam_path_length_minimum = 0x0018_7056l
let filter_beam_path_length_maximum = 0x0018_7058l
let exposure_control_mode = 0x0018_7060l
let exposure_control_mode_description = 0x0018_7062l
let exposure_status = 0x0018_7064l
let phototimer_setting = 0x0018_7065l
let exposure_time_inu_s = 0x0018_8150l
let x_ray_tube_current_inu_a = 0x0018_8151l
let content_qualification = 0x0018_9004l
let pulse_sequence_name = 0x0018_9005l
let m_rimaging_modifier_sequence = 0x0018_9006l
let echo_pulse_sequence = 0x0018_9008l
let inversion_recovery = 0x0018_9009l
let flow_compensation = 0x0018_9010l
let multiple_spin_echo = 0x0018_9011l
let multi_planar_excitation = 0x0018_9012l
let phase_contrast = 0x0018_9014l
let time_of_flight_contrast = 0x0018_9015l
let spoiling = 0x0018_9016l
let steady_state_pulse_sequence = 0x0018_9017l
let echo_planar_pulse_sequence = 0x0018_9018l
let tag_angle_first_axis = 0x0018_9019l
let magnetization_transfer = 0x0018_9020l
let t2_preparation = 0x0018_9021l
let blood_signal_nulling = 0x0018_9022l
let saturation_recovery = 0x0018_9024l
let spectrally_selected_suppression = 0x0018_9025l
let spectrally_selected_excitation = 0x0018_9026l
let spatial_presaturation = 0x0018_9027l
let tagging = 0x0018_9028l
let oversampling_phase = 0x0018_9029l
let tag_spacing_first_dimension = 0x0018_9030l
let geometry_of_kspace_traversal = 0x0018_9032l
let segmented_kspace_traversal = 0x0018_9033l
let rectilinear_phase_encode_reordering = 0x0018_9034l
let tag_thickness = 0x0018_9035l
let partial_fourier_direction = 0x0018_9036l
let cardiac_synchronization_technique = 0x0018_9037l
let receive_coil_manufacturer_name = 0x0018_9041l
let m_rreceive_coil_sequence = 0x0018_9042l
let receive_coil_type = 0x0018_9043l
let quadrature_receive_coil = 0x0018_9044l
let multi_coil_definition_sequence = 0x0018_9045l
let multi_coil_configuration = 0x0018_9046l
let multi_coil_element_name = 0x0018_9047l
let multi_coil_element_used = 0x0018_9048l
let mr_transmit_coil_sequence = 0x0018_9049l
let transmit_coil_manufacturer_name = 0x0018_9050l
let transmit_coil_type = 0x0018_9051l
let spectral_width = 0x0018_9052l
let chemical_shift_reference = 0x0018_9053l
let volume_localization_technique = 0x0018_9054l
let mr_acquisition_frequency_encoding_steps = 0x0018_9058l
let decoupling = 0x0018_9059l
let decoupled_nucleus = 0x0018_9060l
let decoupling_frequency = 0x0018_9061l
let decoupling_method = 0x0018_9062l
let decoupling_chemical_shift_reference = 0x0018_9063l
let kspace_filtering = 0x0018_9064l
let time_domain_filtering = 0x0018_9065l
let number_of_zero_fills = 0x0018_9066l
let baseline_correction = 0x0018_9067l
let parallel_reduction_factor_in_plane = 0x0018_9069l
let cardiac_rr_interval_specified = 0x0018_9070l
let acquisition_duration = 0x0018_9073l
let frame_acquisition_date_time = 0x0018_9074l
let diffusion_directionality = 0x0018_9075l
let diffusion_gradient_direction_sequence = 0x0018_9076l
let parallel_acquisition = 0x0018_9077l
let parallel_acquisition_technique = 0x0018_9078l
let inversion_times = 0x0018_9079l
let metabolite_map_description = 0x0018_9080l
let partial_fourier = 0x0018_9081l
let effective_echo_time = 0x0018_9082l
let metabolite_map_code_sequence = 0x0018_9083l
let chemical_shift_sequence = 0x0018_9084l
let cardiac_signal_source = 0x0018_9085l
let diffusion_bvalue = 0x0018_9087l
let diffusion_gradient_orientation = 0x0018_9089l
let velocity_encoding_direction = 0x0018_9090l
let velocity_encoding_minimum_value = 0x0018_9091l
let velocity_encoding_acquisition_sequence = 0x0018_9092l
let number_of_kspace_trajectories = 0x0018_9093l
let coverage_of_kspace = 0x0018_9094l
let spectroscopy_acquisition_phase_rows = 0x0018_9095l
let parallel_reduction_factor_in_plane_retired = 0x0018_9096l
let transmitter_frequency = 0x0018_9098l
let resonant_nucleus = 0x0018_9100l
let frequency_correction = 0x0018_9101l
let mr_spectroscopy_fovgeometry_sequence = 0x0018_9103l
let slab_thickness = 0x0018_9104l
let slab_orientation = 0x0018_9105l
let mid_slab_position = 0x0018_9106l
let mrspatialsaturationsequence = 0x0018_9107l
let mrtimingandrelatedparameterssequence = 0x0018_9112l
let mrechosequence = 0x0018_9114l
let mrmodifiersequence = 0x0018_9115l
let mrdiffusionsequence = 0x0018_9117l
let cardiac_synchronization_sequence = 0x0018_9118l
let mr_averages_sequence = 0x0018_9119l
let mr_fovgeometry_sequence = 0x0018_9125l
let volume_localization_sequence = 0x0018_9126l
let spectroscopy_acquisition_data_columns = 0x0018_9127l
let diffusion_anisotropy_type = 0x0018_9147l
let frame_reference_date_time = 0x0018_9151l
let mr_metabolite_map_sequence = 0x0018_9152l
let parallel_reduction_factor_out_of_plane = 0x0018_9155l
let spectroscopy_acquisition_out_of_plane_phase_steps = 0x0018_9159l
let bulk_motion_status = 0x0018_9166l
let parallel_reduction_factor_second_in_plane = 0x0018_9168l
let cardiac_beat_rejection_technique = 0x0018_9169l
let respiratory_motion_compensation_technique = 0x0018_9170l
let respiratory_signal_source = 0x0018_9171l
let bulk_motion_compensation_technique = 0x0018_9172l
let bulk_motion_signal_source = 0x0018_9173l
let applicable_safety_standard_agency = 0x0018_9174l
let applicable_safety_standard_description = 0x0018_9175l
let operating_mode_sequence = 0x0018_9176l
let operating_mode_type = 0x0018_9177l
let operating_mode = 0x0018_9178l
let specific_absorption_rate_definition = 0x0018_9179l
let gradient_output_type = 0x0018_9180l
let specific_absorption_rate_value = 0x0018_9181l
let gradient_output = 0x0018_9182l
let flow_compensation_direction = 0x0018_9183l
let tagging_delay = 0x0018_9184l
let respiratory_motion_compensation_technique_description = 0x0018_9185l
let respiratory_signal_source_id = 0x0018_9186l
let chemical_shift_minimum_integration_limit_in_hz = 0x0018_9195l
let chemical_shift_maximum_integration_limit_in_hz = 0x0018_9196l
let mrvelocityencodingsequence = 0x0018_9197l
let first_order_phase_correction = 0x0018_9198l
let water_referenced_phase_correction = 0x0018_9199l
let mr_spectroscopy_acquisition_type = 0x0018_9200l
let respiratory_cycle_position = 0x0018_9214l
let velocity_encoding_maximum_value = 0x0018_9217l
let tag_spacing_second_dimension = 0x0018_9218l
let tag_angle_second_axis = 0x0018_9219l
let frame_acquisition_duration = 0x0018_9220l
let mr_image_frame_type_sequence = 0x0018_9226l
let mr_spectroscopy_frame_type_sequence = 0x0018_9227l
let mr_acquisition_phase_encoding_steps_in_plane = 0x0018_9231l
let mr_acquisition_phase_encoding_steps_out_of_plane = 0x0018_9232l
let spectroscopy_acquisition_phase_columns = 0x0018_9234l
let cardiac_cycle_position = 0x0018_9236l
let specific_absorption_rate_sequence = 0x0018_9239l
let rf_echo_train_length = 0x0018_9240l
let gradient_echo_train_length = 0x0018_9241l
let arterial_spin_labeling_contrast = 0x0018_9250l
let mr_arterial_spin_labeling_sequence = 0x0018_9251l
let asl_technique_description = 0x0018_9252l
let asl_slab_number = 0x0018_9253l
let asl_slab_thickness = 0x0018_9254l
let asl_slab_orientation = 0x0018_9255l
let asl_mid_slab_position = 0x0018_9256l
let asl_context = 0x0018_9257l
let asl_pulse_train_duration = 0x0018_9258l
let asl_crusher_flag = 0x0018_9259l
let asl_crusher_flow = 0x0018_925Al
let asl_crusher_description = 0x0018_925Bl
let asl_bolus_cutoff_flag = 0x0018_925Cl
let asl_bolus_cutoff_timing_sequence = 0x0018_925Dl
let asl_bolus_cutoff_technique = 0x0018_925El
let asl_bolus_cutoff_delay_time = 0x0018_925Fl
let asl_slab_sequence = 0x0018_9260l
let chemical_shift_minimum_integration_limit_inppm = 0x0018_9295l
let chemical_shift_maximum_integration_limit_inppm = 0x0018_9296l
let ct_acquisition_type_sequence = 0x0018_9301l
let acquisition_type = 0x0018_9302l
let tube_angle = 0x0018_9303l
let ct_acquisition_details_sequence = 0x0018_9304l
let revolution_time = 0x0018_9305l
let single_collimation_width = 0x0018_9306l
let total_collimation_width = 0x0018_9307l
let ct_table_dynamics_sequence = 0x0018_9308l
let table_speed = 0x0018_9309l
let table_feed_per_rotation = 0x0018_9310l
let spiral_pitch_factor = 0x0018_9311l
let ct_geometry_sequence = 0x0018_9312l
let data_collection_center_patient = 0x0018_9313l
let ct_reconstruction_sequence = 0x0018_9314l
let reconstruction_algorithm = 0x0018_9315l
let convolution_kernel_group = 0x0018_9316l
let reconstruction_field_of_view = 0x0018_9317l
let reconstruction_target_center_patient = 0x0018_9318l
let reconstruction_angle = 0x0018_9319l
let image_filter = 0x0018_9320l
let ct_exposure_sequence = 0x0018_9321l
let reconstruction_pixel_spacing = 0x0018_9322l
let exposure_modulation_type = 0x0018_9323l
let estimated_dose_saving = 0x0018_9324l
let ct_x_ray_details_sequence = 0x0018_9325l
let ct_position_sequence = 0x0018_9326l
let table_position = 0x0018_9327l
let exposure_time_inms = 0x0018_9328l
let ct_image_frame_type_sequence = 0x0018_9329l
let x_ray_tube_current_inm_a = 0x0018_9330l
let exposure_inm_as = 0x0018_9332l
let constant_volume_flag = 0x0018_9333l
let fluoroscopy_flag = 0x0018_9334l
let distance_source_to_data_collection_center = 0x0018_9335l
let contrast_bolus_agent_number = 0x0018_9337l
let contrast_bolus_ingredient_code_sequence = 0x0018_9338l
let contrast_administration_profile_sequence = 0x0018_9340l
let contrast_bolus_usage_sequence = 0x0018_9341l
let contrast_bolus_agent_administered = 0x0018_9342l
let contrast_bolus_agent_detected = 0x0018_9343l
let contrast_bolus_agent_phase = 0x0018_9344l
let ctdi_vol = 0x0018_9345l
let ctdi_phantom_type_code_sequence = 0x0018_9346l
let calcium_scoring_mass_factor_patient = 0x0018_9351l
let calcium_scoring_mass_factor_device = 0x0018_9352l
let energy_weighting_factor = 0x0018_9353l
let ct_additional_xray_source_sequence = 0x0018_9360l
let projection_pixel_calibration_sequence = 0x0018_9401l
let distance_source_to_isocenter = 0x0018_9402l
let distance_object_to_table_top = 0x0018_9403l
let object_pixel_spacing_in_center_of_beam = 0x0018_9404l
let positioner_position_sequence = 0x0018_9405l
let table_position_sequence = 0x0018_9406l
let collimator_shape_sequence = 0x0018_9407l
let planes_in_acquisition = 0x0018_9410l
let xaxrf_frame_characteristics_sequence = 0x0018_9412l
let frame_acquisition_sequence = 0x0018_9417l
let x_ray_receptor_type = 0x0018_9420l
let acquisition_protocol_name = 0x0018_9423l
let acquisition_protocol_description = 0x0018_9424l
let contrast_bolus_ingredient_opaque = 0x0018_9425l
let distance_receptor_plane_to_detector_housing = 0x0018_9426l
let intensifier_active_shape = 0x0018_9427l
let intensifier_active_dimensions = 0x0018_9428l
let physical_detector_size = 0x0018_9429l
let position_of_isocenter_projection = 0x0018_9430l
let field_of_view_sequence = 0x0018_9432l
let field_of_view_description = 0x0018_9433l
let exposure_control_sensing_regions_sequence = 0x0018_9434l
let exposure_control_sensing_region_shape = 0x0018_9435l
let exposure_control_sensing_region_left_vertical_edge = 0x0018_9436l
let exposure_control_sensing_region_right_vertical_edge = 0x0018_9437l
let exposure_control_sensing_region_upper_horizontal_edge = 0x0018_9438l
let exposure_control_sensing_region_lower_horizontal_edge = 0x0018_9439l
let center_of_circular_exposure_control_sensing_region = 0x0018_9440l
let radius_of_circular_exposure_control_sensing_region = 0x0018_9441l
let vertices_of_the_polygonal_exposure_control_sensing_region = 0x0018_9442l
let column_angulation_patient = 0x0018_9447l
let beam_angle = 0x0018_9449l
let frame_detector_parameters_sequence = 0x0018_9451l
let calculated_anatomy_thickness = 0x0018_9452l
let calibration_sequence = 0x0018_9455l
let object_thickness_sequence = 0x0018_9456l
let plane_identification = 0x0018_9457l
let field_of_view_dimensions_in_float = 0x0018_9461l
let isocenter_reference_system_sequence = 0x0018_9462l
let positioner_isocenter_primary_angle = 0x0018_9463l
let positioner_isocenter_secondary_angle = 0x0018_9464l
let positioner_isocenter_detector_rotation_angle = 0x0018_9465l
let table_xposition_to_isocenter = 0x0018_9466l
let table_yposition_to_isocenter = 0x0018_9467l
let table_zposition_to_isocenter = 0x0018_9468l
let table_horizontal_rotation_angle = 0x0018_9469l
let table_head_tilt_angle = 0x0018_9470l
let table_cradle_tilt_angle = 0x0018_9471l
let frame_display_shutter_sequence = 0x0018_9472l
let acquired_image_area_dose_product = 0x0018_9473l
let c_arm_positioner_tabletop_relationship = 0x0018_9474l
let x_ray_geometry_sequence = 0x0018_9476l
let irradiation_event_identification_sequence = 0x0018_9477l
let x_ray_3d_frame_type_sequence = 0x0018_9504l
let contributing_sources_sequence = 0x0018_9506l
let x_ray_3d_acquisition_sequence = 0x0018_9507l
let primary_positioner_scan_arc = 0x0018_9508l
let secondary_positioner_scan_arc = 0x0018_9509l
let primary_positioner_scan_start_angle = 0x0018_9510l
let secondary_positioner_scan_start_angle = 0x0018_9511l
let primary_positioner_increment = 0x0018_9514l
let secondary_positioner_increment = 0x0018_9515l
let start_acquisition_date_time = 0x0018_9516l
let end_acquisition_date_time = 0x0018_9517l
let application_name = 0x0018_9524l
let application_version = 0x0018_9525l
let application_manufacturer = 0x0018_9526l
let algorithm_type = 0x0018_9527l
let algorithm_description = 0x0018_9528l
let x_ray_3dreconstruction_sequence = 0x0018_9530l
let reconstruction_description = 0x0018_9531l
let per_projection_acquisition_sequence = 0x0018_9538l
let diffusion_bmatrix_sequence = 0x0018_9601l
let diffusion_b_value_xx = 0x0018_9602l
let diffusion_b_value_xy = 0x0018_9603l
let diffusion_b_value_xz = 0x0018_9604l
let diffusion_b_value_yy = 0x0018_9605l
let diffusion_b_value_yz = 0x0018_9606l
let diffusion_b_value_zz = 0x0018_9607l
let decay_correction_date_time = 0x0018_9701l
let start_density_threshold = 0x0018_9715l
let start_relative_density_difference_threshold = 0x0018_9716l
let start_cardiac_trigger_count_threshold = 0x0018_9717l
let start_respiratory_trigger_count_threshold = 0x0018_9718l
let termination_counts_threshold = 0x0018_9719l
let termination_density_threshold = 0x0018_9720l
let termination_relative_density_threshold = 0x0018_9721l
let termination_time_threshold = 0x0018_9722l
let termination_cardiac_trigger_count_threshold = 0x0018_9723l
let termination_respiratory_trigger_count_threshold = 0x0018_9724l
let detector_geometry = 0x0018_9725l
let transverse_detector_separation = 0x0018_9726l
let axial_detector_dimension = 0x0018_9727l
let radiopharmaceutical_agent_number = 0x0018_9729l
let pet_frame_acquisition_sequence = 0x0018_9732l
let pet_detector_motion_details_sequence = 0x0018_9733l
let pettabledynamicssequence = 0x0018_9734l
let petpositionsequence = 0x0018_9735l
let petframecorrectionfactorssequence = 0x0018_9736l
let radiopharmaceutical_usage_sequence = 0x0018_9737l
let attenuation_correction_source = 0x0018_9738l
let number_of_iterations = 0x0018_9739l
let number_of_subsets = 0x0018_9740l
let pet_reconstruction_sequence = 0x0018_9749l
let pet_frame_type_sequence = 0x0018_9751l
let time_of_flight_information_used = 0x0018_9755l
let reconstruction_type = 0x0018_9756l
let decay_corrected = 0x0018_9758l
let attenuation_corrected = 0x0018_9759l
let scatter_corrected = 0x0018_9760l
let dead_time_corrected = 0x0018_9761l
let gantry_motion_corrected = 0x0018_9762l
let patient_motion_corrected = 0x0018_9763l
let count_loss_normalization_corrected = 0x0018_9764l
let randoms_corrected = 0x0018_9765l
let non_uniform_radial_sampling_corrected = 0x0018_9766l
let sensitivity_calibrated = 0x0018_9767l
let detector_normalization_correction = 0x0018_9768l
let iterative_reconstruction_method = 0x0018_9769l
let attenuation_correction_temporal_relationship = 0x0018_9770l
let patient_physiological_state_sequence = 0x0018_9771l
let patient_physiological_state_code_sequence = 0x0018_9772l
let depths_of_focus = 0x0018_9801l
let excluded_intervals_sequence = 0x0018_9803l
let exclusion_start_datetime = 0x0018_9804l
let exclusion_duration = 0x0018_9805l
let u_simage_description_sequence = 0x0018_9806l
let image_data_type_sequence = 0x0018_9807l
let data_type = 0x0018_9808l
let transducer_scan_pattern_code_sequence = 0x0018_9809l
let aliased_data_type = 0x0018_980Bl
let position_measuring_device_used = 0x0018_980Cl
let transducer_geometry_code_sequence = 0x0018_980Dl
let transducer_beam_steering_code_sequence = 0x0018_980El
let transducer_application_code_sequence = 0x0018_980Fl
let contributing_equipment_sequence = 0x0018_A001l
let contribution_date_time = 0x0018_A002l
let contribution_description = 0x0018_A003l
let study_instance_uid = 0x0020_000Dl
let series_instance_uid = 0x0020_000El
let study_id = 0x0020_0010l
let series_number = 0x0020_0011l
let acquisition_number = 0x0020_0012l
let instance_number = 0x0020_0013l
let isotope_number = 0x0020_0014l
let phase_number = 0x0020_0015l
let interval_number = 0x0020_0016l
let time_slot_number = 0x0020_0017l
let angle_number = 0x0020_0018l
let item_number = 0x0020_0019l
let patient_orientation = 0x0020_0020l
let overlay_number = 0x0020_0022l
let curve_number = 0x0020_0024l
let lut_number = 0x0020_0026l
let image_position = 0x0020_0030l
let image_position_patient = 0x0020_0032l
let image_orientation = 0x0020_0035l
let image_orientation_patient = 0x0020_0037l
let location = 0x0020_0050l
let frame_of_reference_uid = 0x0020_0052l
let laterality = 0x0020_0060l
let image_laterality = 0x0020_0062l
let image_geometry_type = 0x0020_0070l
let masking_image = 0x0020_0080l
let report_number = 0x0020_00AAl
let temporal_position_identifier = 0x0020_0100l
let number_of_temporal_positions = 0x0020_0105l
let temporal_resolution = 0x0020_0110l
let synchronization_frame_of_reference_uid = 0x0020_0200l
let sop_instance_uidofconcatenationsource = 0x0020_0242l
let series_in_study = 0x0020_1000l
let acquisitions_in_series = 0x0020_1001l
let images_in_acquisition = 0x0020_1002l
let images_in_series = 0x0020_1003l
let acquisitions_in_study = 0x0020_1004l
let images_in_study = 0x0020_1005l
let reference = 0x0020_1020l
let position_reference_indicator = 0x0020_1040l
let slice_location = 0x0020_1041l
let other_study_numbers = 0x0020_1070l
let number_of_patient_related_studies = 0x0020_1200l
let number_of_patient_related_series = 0x0020_1202l
let number_of_patient_related_instances = 0x0020_1204l
let number_of_study_related_series = 0x0020_1206l
let number_of_study_related_instances = 0x0020_1208l
let number_of_series_related_instances = 0x0020_1209l
let source_image_ids = 0x0020_3100l
let modifying_device_id = 0x0020_3401l
let modified_image_id = 0x0020_3402l
let modified_image_date = 0x0020_3403l
let modifying_device_manufacturer = 0x0020_3404l
let modified_image_time = 0x0020_3405l
let modified_image_description = 0x0020_3406l
let image_comments = 0x0020_4000l
let original_image_identification = 0x0020_5000l
let original_image_identification_nomenclature = 0x0020_5002l
let stack_id = 0x0020_9056l
let in_stack_position_number = 0x0020_9057l
let frame_anatomy_sequence = 0x0020_9071l
let frame_laterality = 0x0020_9072l
let frame_content_sequence = 0x0020_9111l
let plane_position_sequence = 0x0020_9113l
let plane_orientation_sequence = 0x0020_9116l
let temporal_position_index = 0x0020_9128l
let nominal_cardiac_trigger_delay_time = 0x0020_9153l
let nominal_cardiac_trigger_time_prior_to_rpeak = 0x0020_9154l
let actual_cardiac_trigger_time_prior_to_rpeak = 0x0020_9155l
let frame_acquisition_number = 0x0020_9156l
let dimension_index_values = 0x0020_9157l
let frame_comments = 0x0020_9158l
let concatenation_uid = 0x0020_9161l
let in_concatenation_number = 0x0020_9162l
let in_concatenation_total_number = 0x0020_9163l
let dimension_organization_uid = 0x0020_9164l
let dimension_index_pointer = 0x0020_9165l
let functional_group_pointer = 0x0020_9167l
let dimension_index_private_creator = 0x0020_9213l
let dimension_organization_sequence = 0x0020_9221l
let dimension_index_sequence = 0x0020_9222l
let concatenation_frame_offset_number = 0x0020_9228l
let functional_group_private_creator = 0x0020_9238l
let nominal_percentage_of_cardiac_phase = 0x0020_9241l
let nominal_percentage_of_respiratory_phase = 0x0020_9245l
let starting_respiratory_amplitude = 0x0020_9246l
let starting_respiratory_phase = 0x0020_9247l
let ending_respiratory_amplitude = 0x0020_9248l
let ending_respiratory_phase = 0x0020_9249l
let respiratory_trigger_type = 0x0020_9250l
let rr_interval_time_nominal = 0x0020_9251l
let actual_cardiac_trigger_delay_time = 0x0020_9252l
let respiratory_synchronization_sequence = 0x0020_9253l
let respiratory_interval_time = 0x0020_9254l
let nominal_respiratory_trigger_delay_time = 0x0020_9255l
let respiratory_trigger_delay_threshold = 0x0020_9256l
let actual_respiratory_trigger_delay_time = 0x0020_9257l
let image_position_volume = 0x0020_9301l
let image_orientation_volume = 0x0020_9302l
let ultrasound_acquisition_geometry = 0x0020_9307l
let apex_position = 0x0020_9308l
let volume_to_transducer_mapping_matrix = 0x0020_9309l
let volume_to_table_mapping_matrix = 0x0020_930Al
let patient_frame_of_reference_source = 0x0020_930Cl
let temporal_position_time_offset = 0x0020_930Dl
let plane_position_volume_sequence = 0x0020_930El
let plane_orientation_volume_sequence = 0x0020_930Fl
let temporal_position_sequence = 0x0020_9310l
let dimension_organization_type = 0x0020_9311l
let volume_frame_of_reference_uid = 0x0020_9312l
let table_frame_of_reference_uid = 0x0020_9313l
let dimension_description_label = 0x0020_9421l
let patient_orientation_in_frame_sequence = 0x0020_9450l
let frame_label = 0x0020_9453l
let acquisition_index = 0x0020_9518l
let contributing_sop_instances_reference_sequence = 0x0020_9529l
let reconstruction_index = 0x0020_9536l
let light_path_filter_pass_through_wavelength = 0x0022_0001l
let light_path_filter_pass_band = 0x0022_0002l
let image_path_filter_pass_through_wavelength = 0x0022_0003l
let image_path_filter_pass_band = 0x0022_0004l
let patient_eye_movement_commanded = 0x0022_0005l
let patient_eye_movement_command_code_sequence = 0x0022_0006l
let spherical_lens_power = 0x0022_0007l
let cylinder_lens_power = 0x0022_0008l
let cylinder_axis = 0x0022_0009l
let emmetropic_magnification = 0x0022_000Al
let intra_ocular_pressure = 0x0022_000Bl
let horizontal_field_of_view = 0x0022_000Cl
let pupil_dilated = 0x0022_000Dl
let degree_of_dilation = 0x0022_000El
let stereo_baseline_angle = 0x0022_0010l
let stereo_baseline_displacement = 0x0022_0011l
let stereo_horizontal_pixel_offset = 0x0022_0012l
let stereo_vertical_pixel_offset = 0x0022_0013l
let stereo_rotation = 0x0022_0014l
let acquisition_device_type_code_sequence = 0x0022_0015l
let illumination_type_code_sequence = 0x0022_0016l
let light_path_filter_type_stack_code_sequence = 0x0022_0017l
let image_path_filter_type_stack_code_sequence = 0x0022_0018l
let lenses_code_sequence = 0x0022_0019l
let channel_description_code_sequence = 0x0022_001Al
let refractive_state_sequence = 0x0022_001Bl
let mydriatic_agent_code_sequence = 0x0022_001Cl
let relative_image_position_code_sequence = 0x0022_001Dl
let camera_angle_of_view = 0x0022_001El
let stereo_pairs_sequence = 0x0022_0020l
let left_image_sequence = 0x0022_0021l
let right_image_sequence = 0x0022_0022l
let axial_length_of_the_eye = 0x0022_0030l
let ophthalmic_frame_location_sequence = 0x0022_0031l
let reference_coordinates = 0x0022_0032l
let depth_spatial_resolution = 0x0022_0035l
let maximum_depth_distortion = 0x0022_0036l
let along_scan_spatial_resolution = 0x0022_0037l
let maximum_along_scan_distortion = 0x0022_0038l
let ophthalmic_image_orientation = 0x0022_0039l
let depth_of_transverse_image = 0x0022_0041l
let mydriatic_agent_concentration_units_sequence = 0x0022_0042l
let across_scan_spatial_resolution = 0x0022_0048l
let maximum_across_scan_distortion = 0x0022_0049l
let mydriatic_agent_concentration = 0x0022_004El
let illumination_wave_length = 0x0022_0055l
let illumination_power = 0x0022_0056l
let illumination_bandwidth = 0x0022_0057l
let mydriatic_agent_sequence = 0x0022_0058l
let ophthalmic_axial_measurements_right_eye_sequence = 0x0022_1007l
let ophthalmic_axial_measurements_left_eye_sequence = 0x0022_1008l
let ophthalmic_axial_length_measurements_type = 0x0022_1010l
let ophthalmic_axial_length = 0x0022_1019l
let lens_status_code_sequence = 0x0022_1024l
let vitreous_status_code_sequence = 0x0022_1025l
let iol_formula_code_sequence = 0x0022_1028l
let iol_formula_detail = 0x0022_1029l
let keratometer_index = 0x0022_1033l
let source_of_ophthalmic_axial_length_code_sequence = 0x0022_1035l
let target_refraction = 0x0022_1037l
let refractive_procedure_occurred = 0x0022_1039l
let refractive_surgery_type_code_sequence = 0x0022_1040l
let ophthalmic_ultrasound_axial_measurements_type_code_sequence = 0x0022_1044l
let ophthalmic_axial_length_measurements_sequence = 0x0022_1050l
let iol_power = 0x0022_1053l
let predicted_refractive_error = 0x0022_1054l
let ophthalmic_axial_length_velocity = 0x0022_1059l
let lens_status_description = 0x0022_1065l
let vitreous_status_description = 0x0022_1066l
let iol_power_sequence = 0x0022_1090l
let lens_constant_sequence = 0x0022_1092l
let iol_manufacturer = 0x0022_1093l
let lens_constant_description = 0x0022_1094l
let keratometry_measurement_type_code_sequence = 0x0022_1096l
let referenced_ophthalmic_axial_measurements_sequence = 0x0022_1100l
let ophthalmic_axial_length_measurements_segment_name_code_sequence = 0x0022_1101l
let refractive_error_before_refractive_surgery_code_sequence = 0x0022_1103l
let iol_power_for_exact_emmetropia = 0x0022_1121l
let iol_power_for_exact_target_refraction = 0x0022_1122l
let anterior_chamber_depth_definition_code_sequence = 0x0022_1125l
let lens_thickness = 0x0022_1130l
let anterior_chamber_depth = 0x0022_1131l
let source_of_lens_thickness_data_code_sequence = 0x0022_1132l
let source_of_anterior_chamber_depth_data_code_sequence = 0x0022_1133l
let source_of_refractive_error_data_code_sequence = 0x0022_1135l
let ophthalmic_axial_length_measurement_modified = 0x0022_1140l
let ophthalmic_axial_length_data_source_code_sequence = 0x0022_1150l
let ophthalmic_axial_length_acquisition_method_code_sequence = 0x0022_1153l
let signal_to_noise_ratio = 0x0022_1155l
let ophthalmic_axial_length_data_source_description = 0x0022_1159l
let ophthalmic_axial_length_measurements_total_length_sequence = 0x0022_1210l
let ophthalmic_axial_length_measurements_segmental_length_sequence = 0x0022_1211l
let ophthalmic_axial_length_measurements_length_summation_sequence = 0x0022_1212l
let ultrasound_ophthalmic_axial_length_measurements_sequence = 0x0022_1220l
let optical_ophthalmic_axial_length_measurements_sequence = 0x0022_1225l
let ultrasound_selected_ophthalmic_axial_length_sequence = 0x0022_1230l
let ophthalmic_axial_length_selection_method_code_sequence = 0x0022_1250l
let optical_selected_ophthalmic_axial_length_sequence = 0x0022_1255l
let selected_segmental_ophthalmic_axial_length_sequence = 0x0022_1257l
let selected_total_ophthalmic_axial_length_sequence = 0x0022_1260l
let ophthalmic_axial_length_quality_metric_sequence = 0x0022_1262l
let ophthalmic_axial_length_quality_metric_type_description = 0x0022_1273l
let intraocular_lens_calculations_right_eye_sequence = 0x0022_1300l
let intraocular_lens_calculations_left_eye_sequence = 0x0022_1310l
let referenced_ophthalmic_axial_length_measurement_qcimage_sequence = 0x0022_1330l
let visual_field_horizontal_extent = 0x0024_0010l
let visual_field_vertical_extent = 0x0024_0011l
let visual_field_shape = 0x0024_0012l
let screening_test_mode_code_sequence = 0x0024_0016l
let maximum_stimulus_luminance = 0x0024_0018l
let background_luminance = 0x0024_0020l
let stimulus_color_code_sequence = 0x0024_0021l
let background_illumination_color_code_sequence = 0x0024_0024l
let stimulus_area = 0x0024_0025l
let stimulus_presentation_time = 0x0024_0028l
let fixation_sequence = 0x0024_0032l
let fixation_monitoring_code_sequence = 0x0024_0033l
let visual_field_catch_trial_sequence = 0x0024_0034l
let fixation_checked_quantity = 0x0024_0035l
let patient_not_properly_fixated_quantity = 0x0024_0036l
let presented_visual_stimuli_data_flag = 0x0024_0037l
let number_of_visual_stimuli = 0x0024_0038l
let excessive_fixation_losses_data_flag = 0x0024_0039l
let excessive_fixation_losses = 0x0024_0040l
let stimuli_retesting_quantity = 0x0024_0042l
let comments_on_patient_performance_of_visual_field = 0x0024_0044l
let false_negatives_estimate_flag = 0x0024_0045l
let false_negatives_estimate = 0x0024_0046l
let negative_catch_trials_quantity = 0x0024_0048l
let false_negatives_quantity = 0x0024_0050l
let excessive_false_negatives_data_flag = 0x0024_0051l
let excessive_false_negatives = 0x0024_0052l
let false_positives_estimate_flag = 0x0024_0053l
let false_positives_estimate = 0x0024_0054l
let catch_trials_data_flag = 0x0024_0055l
let positive_catch_trials_quantity = 0x0024_0056l
let test_point_normals_data_flag = 0x0024_0057l
let test_point_normals_sequence = 0x0024_0058l
let global_deviation_probability_normals_flag = 0x0024_0059l
let false_positives_quantity = 0x0024_0060l
let excessive_false_positives_data_flag = 0x0024_0061l
let excessive_false_positives = 0x0024_0062l
let visual_field_test_normals_flag = 0x0024_0063l
let results_normals_sequence = 0x0024_0064l
let age_corrected_sensitivity_deviation_algorithm_sequence = 0x0024_0065l
let global_deviation_from_normal = 0x0024_0066l
let generalized_defect_sensitivity_deviation_algorithm_sequence = 0x0024_0067l
let localized_deviationfrom_normal = 0x0024_0068l
let patient_reliability_indicator = 0x0024_0069l
let visual_field_mean_sensitivity = 0x0024_0070l
let global_deviation_probability = 0x0024_0071l
let local_deviation_probability_normals_flag = 0x0024_0072l
let localized_deviation_probability = 0x0024_0073l
let short_term_fluctuation_calculated = 0x0024_0074l
let short_term_fluctuation = 0x0024_0075l
let short_term_fluctuation_probability_calculated = 0x0024_0076l
let short_term_fluctuation_probability = 0x0024_0077l
let corrected_localized_deviation_from_normal_calculated = 0x0024_0078l
let corrected_localized_deviation_from_normal = 0x0024_0079l
let corrected_localized_deviation_from_normal_probability_calculated = 0x0024_0080l
let corrected_localized_deviation_from_normal_probability = 0x0024_0081l
let global_deviation_probability_sequence = 0x0024_0083l
let localized_deviation_probability_sequence = 0x0024_0085l
let foveal_sensitivity_measured = 0x0024_0086l
let foveal_sensitivity = 0x0024_0087l
let visual_field_test_duration = 0x0024_0088l
let visual_field_test_point_sequence = 0x0024_0089l
let visual_field_test_point_xcoordinate = 0x0024_0090l
let visual_field_test_point_ycoordinate = 0x0024_0091l
let age_corrected_sensitivity_deviation_value = 0x0024_0092l
let stimulus_results = 0x0024_0093l
let sensitivity_value = 0x0024_0094l
let retest_stimulus_seen = 0x0024_0095l
let retest_sensitivity_value = 0x0024_0096l
let visual_field_test_point_normals_sequence = 0x0024_0097l
let quantified_defect = 0x0024_0098l
let age_corrected_sensitivity_deviation_probability_value = 0x0024_0100l
let generalized_defect_corrected_sensitivity_deviation_flag = 0x0024_0102l
let generalized_defect_corrected_sensitivity_deviation_value = 0x0024_0103l
let generalized_defect_corrected_sensitivity_deviation_probability_value = 0x0024_0104l
let minimum_sensitivity_value = 0x0024_0105l
let blind_spot_localized = 0x0024_0106l
let blind_spot_xcoordinate = 0x0024_0107l
let blind_spot_ycoordinate = 0x0024_0108l
let visual_acuity_measurement_sequence = 0x0024_0110l
let refractive_parameters_used_on_patient_sequence = 0x0024_0112l
let measurement_laterality = 0x0024_0113l
let ophthalmic_patient_clinical_information_left_eye_sequence = 0x0024_0114l
let ophthalmic_patient_clinical_information_right_eye_sequence = 0x0024_0115l
let foveal_point_normative_data_flag = 0x0024_0117l
let foveal_point_probability_value = 0x0024_0118l
let screening_baseline_measured = 0x0024_0120l
let screening_baseline_measured_sequence = 0x0024_0122l
let screening_baseline_type = 0x0024_0124l
let screening_baseline_value = 0x0024_0126l
let algorithm_source = 0x0024_0202l
let data_set_name = 0x0024_0306l
let data_set_version = 0x0024_0307l
let data_set_source = 0x0024_0308l
let data_set_description = 0x0024_0309l
let visual_field_test_reliability_global_index_sequence = 0x0024_0317l
let visual_field_global_results_index_sequence = 0x0024_0320l
let data_observation_sequence = 0x0024_0325l
let index_normals_flag = 0x0024_0338l
let index_probability = 0x0024_0341l
let index_probability_sequence = 0x0024_0344l
let samples_per_pixel = 0x0028_0002l
let samples_per_pixel_used = 0x0028_0003l
let photometric_interpretation = 0x0028_0004l
let image_dimensions = 0x0028_0005l
let planar_configuration = 0x0028_0006l
let number_of_frames = 0x0028_0008l
let frame_increment_pointer = 0x0028_0009l
let frame_dimension_pointer = 0x0028_000Al
let rows = 0x0028_0010l
let columns = 0x0028_0011l
let planes = 0x0028_0012l
let ultrasound_color_data_present = 0x0028_0014l
let pixel_spacing = 0x0028_0030l
let zoom_factor = 0x0028_0031l
let zoom_center = 0x0028_0032l
let pixel_aspect_ratio = 0x0028_0034l
let image_format = 0x0028_0040l
let manipulated_image = 0x0028_0050l
let corrected_image = 0x0028_0051l
let compression_recognition_code = 0x0028_005Fl
let compression_code = 0x0028_0060l
let compression_originator = 0x0028_0061l
let compression_label = 0x0028_0062l
let compression_description = 0x0028_0063l
let compression_sequence = 0x0028_0065l
let compression_step_pointers = 0x0028_0066l
let repeat_interval = 0x0028_0068l
let bits_grouped = 0x0028_0069l
let perimeter_table = 0x0028_0070l
let perimeter_value = 0x0028_0071l
let predictor_rows = 0x0028_0080l
let predictor_columns = 0x0028_0081l
let predictor_constants = 0x0028_0082l
let blocked_pixels = 0x0028_0090l
let block_rows = 0x0028_0091l
let block_columns = 0x0028_0092l
let row_overlap = 0x0028_0093l
let column_overlap = 0x0028_0094l
let bits_allocated = 0x0028_0100l
let bits_stored = 0x0028_0101l
let high_bit = 0x0028_0102l
let pixel_representation = 0x0028_0103l
let smallest_valid_pixel_value = 0x0028_0104l
let largest_valid_pixel_value = 0x0028_0105l
let smallest_image_pixel_value = 0x0028_0106l
let largest_image_pixel_value = 0x0028_0107l
let smallest_pixel_value_in_series = 0x0028_0108l
let largest_pixel_value_in_series = 0x0028_0109l
let smallest_image_pixel_value_in_plane = 0x0028_0110l
let largest_image_pixel_value_in_plane = 0x0028_0111l
let pixel_padding_value = 0x0028_0120l
let pixel_padding_range_limit = 0x0028_0121l
let image_location = 0x0028_0200l
let quality_control_image = 0x0028_0300l
let burned_in_annotation = 0x0028_0301l
let recognizable_visual_features = 0x0028_0302l
let longitudinal_temporal_information_modified = 0x0028_0303l
let transform_label = 0x0028_0400l
let transform_version_number = 0x0028_0401l
let number_of_transform_steps = 0x0028_0402l
let sequence_of_compressed_data = 0x0028_0403l
let details_of_coefficients = 0x0028_0404l
let rows_for_nth_order_coefficients = 0x0028_0400l
let columns_for_nth_order_coefficients = 0x0028_0401l
let coefficient_coding = 0x0028_0402l
let coefficient_coding_pointers = 0x0028_0403l
let dct_label = 0x0028_0700l
let data_block_description = 0x0028_0701l
let data_block = 0x0028_0702l
let normalization_factor_format = 0x0028_0710l
let zonal_map_number_format = 0x0028_0720l
let zonal_map_location = 0x0028_0721l
let zonal_map_format = 0x0028_0722l
let adaptive_map_format = 0x0028_0730l
let code_number_format = 0x0028_0740l
let code_label = 0x0028_0800l
let number_of_tables = 0x0028_0802l
let code_table_location = 0x0028_0803l
let bits_for_code_word = 0x0028_0804l
let image_data_location = 0x0028_0808l
let pixel_spacing_calibration_type = 0x0028_0A02l
let pixel_spacing_calibration_description = 0x0028_0A04l
let pixel_intensity_relationship = 0x0028_1040l
let pixel_intensity_relationship_sign = 0x0028_1041l
let window_center = 0x0028_1050l
let window_width = 0x0028_1051l
let rescale_intercept = 0x0028_1052l
let rescale_slope = 0x0028_1053l
let rescale_type = 0x0028_1054l
let window_center_width_explanation = 0x0028_1055l
let voi_lut_function = 0x0028_1056l
let gray_scale = 0x0028_1080l
let recommended_viewing_mode = 0x0028_1090l
let gray_lookup_table_descriptor = 0x0028_1100l
let red_palette_color_lookup_table_descriptor = 0x0028_1101l
let green_palette_color_lookup_table_descriptor = 0x0028_1102l
let blue_palette_color_lookup_table_descriptor = 0x0028_1103l
let alpha_palette_color_lookup_table_descriptor = 0x0028_1104l
let large_red_palette_color_lookup_table_descriptor = 0x0028_1111l
let large_green_palette_color_lookup_table_descriptor = 0x0028_1112l
let large_blue_palette_color_lookup_table_descriptor = 0x0028_1113l
let palette_color_lookup_table_uid = 0x0028_1199l
let gray_lookup_table_data = 0x0028_1200l
let red_palette_color_lookup_table_data = 0x0028_1201l
let green_palette_color_lookup_table_data = 0x0028_1202l
let blue_palette_color_lookup_table_data = 0x0028_1203l
let alpha_palette_color_lookup_table_data = 0x0028_1204l
let large_red_palette_color_lookup_table_data = 0x0028_1211l
let large_green_palette_color_lookup_table_data = 0x0028_1212l
let large_blue_palette_color_lookup_table_data = 0x0028_1213l
let large_palette_color_lookup_table_uid = 0x0028_1214l
let segmented_red_palette_color_lookup_table_data = 0x0028_1221l
let segmented_green_palette_color_lookup_table_data = 0x0028_1222l
let segmented_blue_palette_color_lookup_table_data = 0x0028_1223l
let breast_implant_present = 0x0028_1300l
let partial_view = 0x0028_1350l
let partial_view_description = 0x0028_1351l
let partial_view_code_sequence = 0x0028_1352l
let spatial_locations_preserved = 0x0028_135Al
let data_frame_assignment_sequence = 0x0028_1401l
let data_path_assignment = 0x0028_1402l
let bits_mapped_to_color_lookup_table = 0x0028_1403l
let blending_lut1_sequence = 0x0028_1404l
let blending_lut1_transfer_function = 0x0028_1405l
let blending_weight_constant = 0x0028_1406l
let blending_lookup_table_descriptor = 0x0028_1407l
let blending_lookup_table_data = 0x0028_1408l
let enhanced_palette_color_lookup_table_sequence = 0x0028_140Bl
let blending_lut2_sequence = 0x0028_140Cl
let blending_lut2_transfer_function = 0x0028_140Dl
let data_path_id = 0x0028_140El
let rgb_lut_transfer_function = 0x0028_140Fl
let alpha_lut_transfer_function = 0x0028_1410l
let icc_profile = 0x0028_2000l
let lossy_image_compression = 0x0028_2110l
let lossy_image_compression_ratio = 0x0028_2112l
let lossy_image_compression_method = 0x0028_2114l
let modality_lut_sequence = 0x0028_3000l
let lut_descriptor = 0x0028_3002l
let lut_explanation = 0x0028_3003l
let modality_lut_type = 0x0028_3004l
let lut_data = 0x0028_3006l
let voi_lut_sequence = 0x0028_3010l
let soft_copy_void_lut_sequence = 0x0028_3110l
let image_presentation_comments = 0x0028_4000l
let bi_plane_acquisition_sequence = 0x0028_5000l
let representative_frame_number = 0x0028_6010l
let frame_numbers_of_interest = 0x0028_6020l
let frame_of_interest_description = 0x0028_6022l
let frame_of_interest_type = 0x0028_6023l
let mask_pointers = 0x0028_6030l
let r_wave_pointer = 0x0028_6040l
let mask_subtraction_sequence = 0x0028_6100l
let mask_operation = 0x0028_6101l
let applicable_frame_range = 0x0028_6102l
let mask_frame_numbers = 0x0028_6110l
let contrast_frame_averaging = 0x0028_6112l
let mask_sub_pixel_shift = 0x0028_6114l
let tid_offset = 0x0028_6120l
let mask_operation_explanation = 0x0028_6190l
let pixel_data_provider_url = 0x0028_7FE0l
let data_point_rows = 0x0028_9001l
let data_point_columns = 0x0028_9002l
let signal_domain_columns = 0x0028_9003l
let largest_monochrome_pixel_value = 0x0028_9099l
let data_representation = 0x0028_9108l
let pixel_measures_sequence = 0x0028_9110l
let frame_voi_lut_sequence = 0x0028_9132l
let pixel_value_transformation_sequence = 0x0028_9145l
let signal_domain_rows = 0x0028_9235l
let display_filter_percentage = 0x0028_9411l
let frame_pixel_shift_sequence = 0x0028_9415l
let subtraction_item_id = 0x0028_9416l
let pixel_intensity_relationship_lutsequence = 0x0028_9422l
let frame_pixel_data_properties_sequence = 0x0028_9443l
let geometrical_properties = 0x0028_9444l
let geometric_maximum_distortion = 0x0028_9445l
let image_processing_applied = 0x0028_9446l
let mask_selection_mode = 0x0028_9454l
let lut_function = 0x0028_9474l
let mask_visibility_percentage = 0x0028_9478l
let pixel_shift_sequence = 0x0028_9501l
let region_pixel_shift_sequence = 0x0028_9502l
let vertices_of_the_region = 0x0028_9503l
let multi_frame_presentation_sequence = 0x0028_9505l
let pixel_shift_frame_range = 0x0028_9506l
let lut_frame_range = 0x0028_9507l
let image_to_equipment_mapping_matrix = 0x0028_9520l
let equipment_coordinate_system_identification = 0x0028_9537l
let study_status_id = 0x0032_000Al
let study_priority_id = 0x0032_000Cl
let study_id_issuer = 0x0032_0012l
let study_verified_date = 0x0032_0032l
let study_verified_time = 0x0032_0033l
let study_read_date = 0x0032_0034l
let study_read_time = 0x0032_0035l
let scheduled_study_start_date = 0x0032_1000l
let scheduled_study_start_time = 0x0032_1001l
let scheduled_study_stop_date = 0x0032_1010l
let scheduled_study_stop_time = 0x0032_1011l
let scheduled_study_location = 0x0032_1020l
let scheduled_study_location_aetitle = 0x0032_1021l
let reason_for_study = 0x0032_1030l
let requesting_physician_identification_sequence = 0x0032_1031l
let requesting_physician = 0x0032_1032l
let requesting_service = 0x0032_1033l
let requesting_service_code_sequence = 0x0032_1034l
let study_arrival_date = 0x0032_1040l
let study_arrival_time = 0x0032_1041l
let study_completion_date = 0x0032_1050l
let study_completion_time = 0x0032_1051l
let study_component_status_id = 0x0032_1055l
let requested_procedure_description = 0x0032_1060l
let requested_procedure_code_sequence = 0x0032_1064l
let requested_contrast_agent = 0x0032_1070l
let study_comments = 0x0032_4000l
let referenced_patient_alias_sequence = 0x0038_0004l
let visit_status_id = 0x0038_0008l
let admission_id = 0x0038_0010l
let issuer_of_admission_id = 0x0038_0011l
let issuer_of_admission_id_sequence = 0x0038_0014l
let route_of_admissions = 0x0038_0016l
let scheduled_admission_date = 0x0038_001Al
let scheduled_admission_time = 0x0038_001Bl
let scheduled_discharge_date = 0x0038_001Cl
let scheduled_discharge_time = 0x0038_001Dl
let scheduled_patient_institution_residence = 0x0038_001El
let admitting_date = 0x0038_0020l
let admitting_time = 0x0038_0021l
let discharge_date = 0x0038_0030l
let discharge_time = 0x0038_0032l
let discharge_diagnosis_description = 0x0038_0040l
let discharge_diagnosis_code_sequence = 0x0038_0044l
let special_needs = 0x0038_0050l
let service_episode_id = 0x0038_0060l
let issuer_of_service_episode_id = 0x0038_0061l
let service_episode_description = 0x0038_0062l
let issuer_of_service_episode_id_sequence = 0x0038_0064l
let pertinent_documents_sequence = 0x0038_0100l
let current_patient_location = 0x0038_0300l
let patient_institution_residence = 0x0038_0400l
let patient_state = 0x0038_0500l
let patient_clinical_trial_participation_sequence = 0x0038_0502l
let visit_comments = 0x0038_4000l
let waveform_originality = 0x003A_0004l
let number_of_waveform_channels = 0x003A_0005l
let number_of_waveform_samples = 0x003A_0010l
let sampling_frequency = 0x003A_001Al
let multiplex_group_label = 0x003A_0020l
let channel_definition_sequence = 0x003A_0200l
let waveform_channel_number = 0x003A_0202l
let channel_label = 0x003A_0203l
let channel_status = 0x003A_0205l
let channel_source_sequence = 0x003A_0208l
let channel_source_modifiers_sequence = 0x003A_0209l
let source_waveform_sequence = 0x003A_020Al
let channel_derivation_description = 0x003A_020Cl
let channel_sensitivity = 0x003A_0210l
let channel_sensitivity_units_sequence = 0x003A_0211l
let channel_sensitivity_correction_factor = 0x003A_0212l
let channel_baseline = 0x003A_0213l
let channel_time_skew = 0x003A_0214l
let channel_sample_skew = 0x003A_0215l
let channel_offset = 0x003A_0218l
let waveform_bits_stored = 0x003A_021Al
let filter_low_frequency = 0x003A_0220l
let filter_high_frequency = 0x003A_0221l
let notch_filter_frequency = 0x003A_0222l
let notch_filter_bandwidth = 0x003A_0223l
let waveform_data_display_scale = 0x003A_0230l
let waveform_display_background_cielab_value = 0x003A_0231l
let waveform_presentation_group_sequence = 0x003A_0240l
let presentation_group_number = 0x003A_0241l
let channel_display_sequence = 0x003A_0242l
let channel_recommended_display_cielab_value = 0x003A_0244l
let channel_position = 0x003A_0245l
let display_shading_flag = 0x003A_0246l
let fractional_channel_display_scale = 0x003A_0247l
let absolute_channel_display_scale = 0x003A_0248l
let multiplexed_audio_channels_description_code_sequence = 0x003A_0300l
let channel_identification_code = 0x003A_0301l
let channel_mode = 0x003A_0302l
let scheduled_station_aetitle = 0x0040_0001l
let scheduled_procedure_step_start_date = 0x0040_0002l
let scheduled_procedure_step_start_time = 0x0040_0003l
let scheduled_procedure_step_end_date = 0x0040_0004l
let scheduled_procedure_step_end_time = 0x0040_0005l
let scheduled_performing_physician_name = 0x0040_0006l
let scheduled_procedure_step_description = 0x0040_0007l
let scheduled_protocol_code_sequence = 0x0040_0008l
let scheduled_procedure_step_id = 0x0040_0009l
let stage_code_sequence = 0x0040_000Al
let scheduled_performing_physician_identification_sequence = 0x0040_000Bl
let scheduled_station_name = 0x0040_0010l
let scheduled_procedure_step_location = 0x0040_0011l
let pre_medication = 0x0040_0012l
let scheduled_procedure_step_status = 0x0040_0020l
let order_placer_identifier_sequence = 0x0040_0026l
let order_filler_identifier_sequence = 0x0040_0027l
let local_namespace_entity_id = 0x0040_0031l
let universal_entity_id = 0x0040_0032l
let universal_entity_id_type = 0x0040_0033l
let identifier_type_code = 0x0040_0035l
let assigning_facility_sequence = 0x0040_0036l
let assigning_jurisdiction_code_sequence = 0x0040_0039l
let assigning_agency_or_department_code_sequence = 0x0040_003Al
let scheduled_procedure_step_sequence = 0x0040_0100l
let referenced_non_image_composite_sop_instance_sequence = 0x0040_0220l
let performed_station_aetitle = 0x0040_0241l
let performed_station_name = 0x0040_0242l
let performed_location = 0x0040_0243l
let performed_procedure_step_start_date = 0x0040_0244l
let performed_procedure_step_start_time = 0x0040_0245l
let performed_procedure_step_end_date = 0x0040_0250l
let performed_procedure_step_end_time = 0x0040_0251l
let performed_procedure_step_status = 0x0040_0252l
let performed_procedure_step_id = 0x0040_0253l
let performed_procedure_step_description = 0x0040_0254l
let performed_procedure_type_description = 0x0040_0255l
let performed_protocol_code_sequence = 0x0040_0260l
let performed_protocol_type = 0x0040_0261l
let scheduled_step_attributes_sequence = 0x0040_0270l
let request_attributes_sequence = 0x0040_0275l
let comments_on_the_performed_procedure_step = 0x0040_0280l
let performed_procedure_step_discontinuation_reason_code_sequence = 0x0040_0281l
let quantity_sequence = 0x0040_0293l
let quantity = 0x0040_0294l
let measuring_units_sequence = 0x0040_0295l
let billing_item_sequence = 0x0040_0296l
let total_time_of_fluoroscopy = 0x0040_0300l
let total_number_of_exposures = 0x0040_0301l
let entrance_dose = 0x0040_0302l
let exposed_area = 0x0040_0303l
let distance_source_to_entrance = 0x0040_0306l
let distance_source_to_support = 0x0040_0307l
let exposure_dose_sequence = 0x0040_030El
let comments_on_radiation_dose = 0x0040_0310l
let x_ray_output = 0x0040_0312l
let half_value_layer = 0x0040_0314l
let organ_dose = 0x0040_0316l
let organ_exposed = 0x0040_0318l
let billing_procedure_step_sequence = 0x0040_0320l
let film_consumption_sequence = 0x0040_0321l
let billing_supplies_and_devices_sequence = 0x0040_0324l
let referenced_procedure_step_sequence = 0x0040_0330l
let performed_series_sequence = 0x0040_0340l
let comments_on_the_scheduled_procedure_step = 0x0040_0400l
let protocol_context_sequence = 0x0040_0440l
let content_item_modifier_sequence = 0x0040_0441l
let scheduled_specimen_sequence = 0x0040_0500l
let specimen_accession_number = 0x0040_050Al
let container_identifier = 0x0040_0512l
let issuer_of_the_container_identifier_sequence = 0x0040_0513l
let alternate_container_identifier_sequence = 0x0040_0515l
let container_type_code_sequence = 0x0040_0518l
let container_description = 0x0040_051Al
let container_component_sequence = 0x0040_0520l
let specimen_sequence = 0x0040_0550l
let specimen_identifier = 0x0040_0551l
let specimen_description_sequence_trial = 0x0040_0552l
let specimen_description_trial = 0x0040_0553l
let specimen_uid = 0x0040_0554l
let acquisition_context_sequence = 0x0040_0555l
let acquisition_context_description = 0x0040_0556l
let specimen_type_code_sequence = 0x0040_059Al
let specimen_description_sequence = 0x0040_0560l
let issuer_of_the_specimen_identifier_sequence = 0x0040_0562l
let specimen_short_description = 0x0040_0600l
let specimen_detailed_description = 0x0040_0602l
let specimen_preparation_sequence = 0x0040_0610l
let specimen_preparation_step_content_item_sequence = 0x0040_0612l
let specimen_localization_content_item_sequence = 0x0040_0620l
let slide_identifier = 0x0040_06FAl
let image_center_point_coordinates_sequence = 0x0040_071Al
let x_offset_in_slide_coordinate_system = 0x0040_072Al
let y_offset_in_slide_coordinate_system = 0x0040_073Al
let z_offset_in_slide_coordinate_system = 0x0040_074Al
let pixel_spacing_sequence = 0x0040_08D8l
let coordinate_system_axis_code_sequence = 0x0040_08DAl
let measurement_units_code_sequence = 0x0040_08EAl
let vital_stain_code_sequence_trial = 0x0040_09F8l
let requested_procedure_id = 0x0040_1001l
let reason_for_the_requested_procedure = 0x0040_1002l
let requested_procedure_priority = 0x0040_1003l
let patient_transport_arrangements = 0x0040_1004l
let requested_procedure_location = 0x0040_1005l
let placer_order_number_procedure = 0x0040_1006l
let filler_order_number_procedure = 0x0040_1007l
let confidentiality_code = 0x0040_1008l
let reporting_priority = 0x0040_1009l
let reason_for_requested_procedure_code_sequence = 0x0040_100Al
let names_of_intended_recipients_of_results = 0x0040_1010l
let intended_recipients_of_results_identification_sequence = 0x0040_1011l
let reason_for_performed_procedure_code_sequence = 0x0040_1012l
let requested_procedure_description_trial = 0x0040_1060l
let person_identification_code_sequence = 0x0040_1101l
let person_address = 0x0040_1102l
let person_telephone_numbers = 0x0040_1103l
let requested_procedure_comments = 0x0040_1400l
let reason_for_the_imaging_service_request = 0x0040_2001l
let issue_date_of_imaging_service_request = 0x0040_2004l
let issue_time_of_imaging_service_request = 0x0040_2005l
let placer_order_number_imaging_service_request_retired = 0x0040_2006l
let filler_order_number_imaging_service_request_retired = 0x0040_2007l
let order_entered_by = 0x0040_2008l
let order_enterer_location = 0x0040_2009l
let order_callback_phone_number = 0x0040_2010l
let placer_order_number_imaging_service_request = 0x0040_2016l
let filler_order_number_imaging_service_request = 0x0040_2017l
let imaging_service_request_comments = 0x0040_2400l
let confidentiality_constraint_on_patient_data_description = 0x0040_3001l
let general_purpose_scheduled_procedure_step_status = 0x0040_4001l
let general_purpose_performed_procedure_step_status = 0x0040_4002l
let general_purpose_scheduled_procedure_step_priority = 0x0040_4003l
let scheduled_processing_applications_code_sequence = 0x0040_4004l
let scheduled_procedure_step_start_date_time = 0x0040_4005l
let multiple_copies_flag = 0x0040_4006l
let performed_processing_applications_code_sequence = 0x0040_4007l
let human_performer_code_sequence = 0x0040_4009l
let scheduled_procedure_step_modification_date_time = 0x0040_4010l
let expected_completion_date_time = 0x0040_4011l
let resulting_general_purpose_performed_procedure_steps_sequence = 0x0040_4015l
let referenced_general_purpose_scheduled_procedure_step_sequence = 0x0040_4016l
let scheduled_workitem_code_sequence = 0x0040_4018l
let performed_workitem_code_sequence = 0x0040_4019l
let input_availability_flag = 0x0040_4020l
let input_information_sequence = 0x0040_4021l
let relevant_information_sequence = 0x0040_4022l
let referenced_general_purpose_scheduled_procedure_step_transaction_uid = 0x0040_4023l
let scheduled_station_name_code_sequence = 0x0040_4025l
let scheduled_station_class_code_sequence = 0x0040_4026l
let scheduled_station_geographic_location_code_sequence = 0x0040_4027l
let performed_station_name_code_sequence = 0x0040_4028l
let performed_station_class_code_sequence = 0x0040_4029l
let performed_station_geographic_location_code_sequence = 0x0040_4030l
let requested_subsequent_workitem_code_sequence = 0x0040_4031l
let non_dicomoutput_code_sequence = 0x0040_4032l
let output_information_sequence = 0x0040_4033l
let scheduled_human_performers_sequence = 0x0040_4034l
let actual_human_performers_sequence = 0x0040_4035l
let human_performer_organization = 0x0040_4036l
let human_performer_name = 0x0040_4037l
let raw_data_handling = 0x0040_4040l
let input_readiness_state = 0x0040_4041l
let performed_procedure_step_start_date_time = 0x0040_4050l
let performed_procedure_step_end_date_time = 0x0040_4051l
let procedure_step_cancellation_date_time = 0x0040_4052l
let entrance_dose_inm_gy = 0x0040_8302l
let referenced_image_real_world_value_mapping_sequence = 0x0040_9094l
let real_world_value_mapping_sequence = 0x0040_9096l
let pixel_value_mapping_code_sequence = 0x0040_9098l
let lut_label = 0x0040_9210l
let real_world_value_last_value_mapped = 0x0040_9211l
let real_world_value_lut_data = 0x0040_9212l
let real_world_value_first_value_mapped = 0x0040_9216l
let real_world_value_intercept = 0x0040_9224l
let real_world_value_slope = 0x0040_9225l
let findings_flag_trial = 0x0040_A007l
let relationship_type = 0x0040_A010l
let findings_sequence_trial = 0x0040_A020l
let findings_group_uid_trial = 0x0040_A021l
let referenced_findings_group_uid_trial = 0x0040_A022l
let findings_group_recording_date_trial = 0x0040_A023l
let findings_group_recording_time_trial = 0x0040_A024l
let findings_source_category_code_sequence_trial = 0x0040_A026l
let verifying_organization = 0x0040_A027l
let documenting_organization_identifier_code_sequence_trial = 0x0040_A028l
let verification_date_time = 0x0040_A030l
let observation_date_time = 0x0040_A032l
let value_type = 0x0040_A040l
let concept_name_code_sequence = 0x0040_A043l
let measurement_precision_description_trial = 0x0040_A047l
let continuity_of_content = 0x0040_A050l
let urgency_or_priority_alerts_trial = 0x0040_A057l
let sequencing_indicator_trial = 0x0040_A060l
let document_identifier_code_sequence_trial = 0x0040_A066l
let document_author_trial = 0x0040_A067l
let document_author_identifier_code_sequence_trial = 0x0040_A068l
let identifier_code_sequence_trial = 0x0040_A070l
let verifying_observer_sequence = 0x0040_A073l
let object_binary_identifier_trial = 0x0040_A074l
let verifying_observer_name = 0x0040_A075l
let documenting_observer_identifier_code_sequence_trial = 0x0040_A076l
let author_observer_sequence = 0x0040_A078l
let participant_sequence = 0x0040_A07Al
let custodial_organization_sequence = 0x0040_A07Cl
let participation_type = 0x0040_A080l
let participation_date_time = 0x0040_A082l
let observer_type = 0x0040_A084l
let procedure_identifier_code_sequence_trial = 0x0040_A085l
let verifying_observer_identification_code_sequence = 0x0040_A088l
let object_directory_binary_identifier_trial = 0x0040_A089l
let equivalent_cda_document_sequence = 0x0040_A090l
let referenced_waveform_channels = 0x0040_A0B0l
let date_of_document_or_verbal_transaction_trial = 0x0040_A110l
let time_of_document_creation_or_verbal_transaction_trial = 0x0040_A112l
let date_time = 0x0040_A120l
let date = 0x0040_A121l
let time = 0x0040_A122l
let person_name = 0x0040_A123l
let uid = 0x0040_A124l
let report_status_id_trial = 0x0040_A125l
let temporal_range_type = 0x0040_A130l
let referenced_sample_positions = 0x0040_A132l
let referenced_frame_numbers = 0x0040_A136l
let referenced_time_offsets = 0x0040_A138l
let referenced_date_time = 0x0040_A13Al
let text_value = 0x0040_A160l
let observation_category_code_sequence_trial = 0x0040_A167l
let concept_code_sequence = 0x0040_A168l
let bibliographic_citation_trial = 0x0040_A16Al
let purpose_of_reference_code_sequence = 0x0040_A170l
let observation_uid_trial = 0x0040_A171l
let referenced_observation_uid_trial = 0x0040_A172l
let referenced_observation_class_trial = 0x0040_A173l
let referenced_object_observation_class_trial = 0x0040_A174l
let annotation_group_number = 0x0040_A180l
let observation_date_trial = 0x0040_A192l
let observation_time_trial = 0x0040_A193l
let measurement_automation_trial = 0x0040_A194l
let modifier_code_sequence = 0x0040_A195l
let identification_description_trial = 0x0040_A224l
let coordinates_set_geometric_type_trial = 0x0040_A290l
let algorithm_code_sequence_trial = 0x0040_A296l
let algorithm_description_trial = 0x0040_A297l
let pixel_coordinates_set_trial = 0x0040_A29Al
let measured_value_sequence = 0x0040_A300l
let numeric_value_qualifier_code_sequence = 0x0040_A301l
let current_observer_trial = 0x0040_A307l
let numeric_value = 0x0040_A30Al
let referenced_accession_sequence_trial = 0x0040_A313l
let report_status_comment_trial = 0x0040_A33Al
let procedure_context_sequence_trial = 0x0040_A340l
let verbal_source_trial = 0x0040_A352l
let address_trial = 0x0040_A353l
let telephone_number_trial = 0x0040_A354l
let verbal_source_identifier_code_sequence_trial = 0x0040_A358l
let predecessor_documents_sequence = 0x0040_A360l
let referenced_request_sequence = 0x0040_A370l
let performed_procedure_code_sequence = 0x0040_A372l
let current_requested_procedure_evidence_sequence = 0x0040_A375l
let report_detail_sequence_trial = 0x0040_A380l
let pertinent_other_evidence_sequence = 0x0040_A385l
let hl7_structured_document_reference_sequence = 0x0040_A390l
let observation_subject_uid_trial = 0x0040_A402l
let observation_subject_class_trial = 0x0040_A403l
let observation_subject_type_code_sequence_trial = 0x0040_A404l
let completion_flag = 0x0040_A491l
let completion_flag_description = 0x0040_A492l
let verification_flag = 0x0040_A493l
let archive_requested = 0x0040_A494l
let preliminary_flag = 0x0040_A496l
let content_template_sequence = 0x0040_A504l
let identical_documents_sequence = 0x0040_A525l
let observation_subject_context_flag_trial = 0x0040_A600l
let observer_context_flag_trial = 0x0040_A601l
let procedure_context_flag_trial = 0x0040_A603l
let content_sequence = 0x0040_A730l
let relationship_sequence_trial = 0x0040_A731l
let relationship_type_code_sequence_trial = 0x0040_A732l
let language_code_sequence_trial = 0x0040_A744l
let uniform_resource_locator_trial = 0x0040_A992l
let waveform_annotation_sequence = 0x0040_B020l
let template_identifier = 0x0040_DB00l
let template_version = 0x0040_DB06l
let template_local_version = 0x0040_DB07l
let template_extension_flag = 0x0040_DB0Bl
let template_extension_organization_uid = 0x0040_DB0Cl
let template_extension_creator_uid = 0x0040_DB0Dl
let referenced_content_item_identifier = 0x0040_DB73l
let hl7_instance_identifier = 0x0040_E001l
let hl7_document_effective_time = 0x0040_E004l
let hl7_document_type_code_sequence = 0x0040_E006l
let document_class_code_sequence = 0x0040_E008l
let retrieve_uri = 0x0040_E010l
let retrieve_location_uid = 0x0040_E011l
let type_of_instances = 0x0040_E020l
let dicomretrievalsequence = 0x0040_E021l
let dicommediaretrievalsequence = 0x0040_E022l
let wado_retrieval_sequence = 0x0040_E023l
let xds_retrieval_sequence = 0x0040_E024l
let repository_unique_id = 0x0040_E030l
let home_community_id = 0x0040_E031l
let document_title = 0x0042_0010l
let encapsulated_document = 0x0042_0011l
let mime_type_of_encapsulated_document = 0x0042_0012l
let source_instance_sequence = 0x0042_0013l
let list_of_mime_types = 0x0042_0014l
let product_package_identifier = 0x0044_0001l
let substance_administration_approval = 0x0044_0002l
let approval_status_further_description = 0x0044_0003l
let approval_status_date_time = 0x0044_0004l
let product_type_code_sequence = 0x0044_0007l
let product_name = 0x0044_0008l
let product_description = 0x0044_0009l
let product_lot_identifier = 0x0044_000Al
let product_expiration_date_time = 0x0044_000Bl
let substance_administration_date_time = 0x0044_0010l
let substance_administration_notes = 0x0044_0011l
let substance_administration_device_id = 0x0044_0012l
let product_parameter_sequence = 0x0044_0013l
let substance_administration_parameter_sequence = 0x0044_0019l
let lens_description = 0x0046_0012l
let right_lens_sequence = 0x0046_0014l
let left_lens_sequence = 0x0046_0015l
let unspecified_laterality_lens_sequence = 0x0046_0016l
let cylinder_sequence = 0x0046_0018l
let prism_sequence = 0x0046_0028l
let horizontal_prism_power = 0x0046_0030l
let horizontal_prism_base = 0x0046_0032l
let vertical_prism_power = 0x0046_0034l
let vertical_prism_base = 0x0046_0036l
let lens_segment_type = 0x0046_0038l
let optical_transmittance = 0x0046_0040l
let channel_width = 0x0046_0042l
let pupil_size = 0x0046_0044l
let corneal_size = 0x0046_0046l
let autorefraction_right_eye_sequence = 0x0046_0050l
let autorefraction_left_eye_sequence = 0x0046_0052l
let distance_pupillary_distance = 0x0046_0060l
let near_pupillary_distance = 0x0046_0062l
let intermediate_pupillary_distance = 0x0046_0063l
let other_pupillary_distance = 0x0046_0064l
let keratometry_right_eye_sequence = 0x0046_0070l
let keratometry_left_eye_sequence = 0x0046_0071l
let steep_keratometric_axis_sequence = 0x0046_0074l
let radius_of_curvature = 0x0046_0075l
let keratometric_power = 0x0046_0076l
let keratometric_axis = 0x0046_0077l
let flat_keratometric_axis_sequence = 0x0046_0080l
let background_color = 0x0046_0092l
let optotype = 0x0046_0094l
let optotype_presentation = 0x0046_0095l
let subjective_refraction_right_eye_sequence = 0x0046_0097l
let subjective_refraction_left_eye_sequence = 0x0046_0098l
let add_near_sequence = 0x0046_0100l
let add_intermediate_sequence = 0x0046_0101l
let add_other_sequence = 0x0046_0102l
let add_power = 0x0046_0104l
let viewing_distance = 0x0046_0106l
let visual_acuity_type_code_sequence = 0x0046_0121l
let visual_acuity_right_eye_sequence = 0x0046_0122l
let visual_acuity_left_eye_sequence = 0x0046_0123l
let visual_acuity_both_eyes_open_sequence = 0x0046_0124l
let viewing_distance_type = 0x0046_0125l
let visual_acuity_modifiers = 0x0046_0135l
let decimal_visual_acuity = 0x0046_0137l
let optotype_detailed_definition = 0x0046_0139l
let referenced_refractive_measurements_sequence = 0x0046_0145l
let sphere_power = 0x0046_0146l
let cylinder_power = 0x0046_0147l
let imaged_volume_width = 0x0048_0001l
let imaged_volume_height = 0x0048_0002l
let imaged_volume_depth = 0x0048_0003l
let total_pixel_matrix_columns = 0x0048_0006l
let total_pixel_matrix_rows = 0x0048_0007l
let total_pixel_matrix_origin_sequence = 0x0048_0008l
let specimen_label_in_image = 0x0048_0010l
let focus_method = 0x0048_0011l
let extended_depth_of_field = 0x0048_0012l
let number_of_focal_planes = 0x0048_0013l
let distance_between_focal_planes = 0x0048_0014l
let recommended_absent_pixel_cielab_value = 0x0048_0015l
let illuminator_type_code_sequence = 0x0048_0100l
let image_orientation_slide = 0x0048_0102l
let optical_path_sequence = 0x0048_0105l
let optical_path_identifier = 0x0048_0106l
let optical_path_description = 0x0048_0107l
let illumination_color_code_sequence = 0x0048_0108l
let specimen_reference_sequence = 0x0048_0110l
let condenser_lens_power = 0x0048_0111l
let objective_lens_power = 0x0048_0112l
let objective_lens_numerical_aperture = 0x0048_0113l
let palette_color_lookup_table_sequence = 0x0048_0120l
let referenced_image_navigation_sequence = 0x0048_0200l
let top_left_hand_corner_of_localizer_area = 0x0048_0201l
let bottom_right_hand_corner_of_localizer_area = 0x0048_0202l
let optical_path_identification_sequence = 0x0048_0207l
let plane_position_slide_sequence = 0x0048_021Al
let row_position_in_total_image_pixel_matrix = 0x0048_021El
let column_position_in_total_image_pixel_matrix = 0x0048_021Fl
let pixel_origin_interpretation = 0x0048_0301l
let calibration_image = 0x0050_0004l
let device_sequence = 0x0050_0010l
let container_component_type_code_sequence = 0x0050_0012l
let container_component_thickness = 0x0050_0013l
let device_length = 0x0050_0014l
let container_component_width = 0x0050_0015l
let device_diameter = 0x0050_0016l
let device_diameter_units = 0x0050_0017l
let device_volume = 0x0050_0018l
let inter_marker_distance = 0x0050_0019l
let container_component_material = 0x0050_001Al
let container_component_id = 0x0050_001Bl
let container_component_length = 0x0050_001Cl
let container_component_diameter = 0x0050_001Dl
let container_component_description = 0x0050_001El
let device_description = 0x0050_0020l
let contrast_bolus_ingredient_percent_by_volume = 0x0052_0001l
let oct_focal_distance = 0x0052_0002l
let beam_spot_size = 0x0052_0003l
let effective_refractive_index = 0x0052_0004l
let oct_acquisition_domain = 0x0052_0006l
let oct_optical_center_wavelength = 0x0052_0007l
let axial_resolution = 0x0052_0008l
let ranging_depth = 0x0052_0009l
let a_line_rate = 0x0052_0011l
let a_lines_per_frame = 0x0052_0012l
let catheter_rotational_rate = 0x0052_0013l
let a_line_pixel_spacing = 0x0052_0014l
let mode_of_percutaneous_access_sequence = 0x0052_0016l
let intravascular_oct_frame_type_sequence = 0x0052_0025l
let oct_zoffset_applied = 0x0052_0026l
let intravascular_frame_content_sequence = 0x0052_0027l
let intravascular_longitudinal_distance = 0x0052_0028l
let intravascular_oct_frame_content_sequence = 0x0052_0029l
let oct_zoffset_correction = 0x0052_0030l
let catheter_direction_of_rotation = 0x0052_0031l
let seam_line_location = 0x0052_0033l
let first_aline_location = 0x0052_0034l
let seam_line_index = 0x0052_0036l
let number_of_padded_alines = 0x0052_0038l
let interpolation_type = 0x0052_0039l
let refractive_index_applied = 0x0052_003Al
let energy_window_vector = 0x0054_0010l
let number_of_energy_windows = 0x0054_0011l
let energy_window_information_sequence = 0x0054_0012l
let energy_window_range_sequence = 0x0054_0013l
let energy_window_lower_limit = 0x0054_0014l
let energy_window_upper_limit = 0x0054_0015l
let radiopharmaceutical_information_sequence = 0x0054_0016l
let residual_syringe_counts = 0x0054_0017l
let energy_window_name = 0x0054_0018l
let detector_vector = 0x0054_0020l
let number_of_detectors = 0x0054_0021l
let detector_information_sequence = 0x0054_0022l
let phase_vector = 0x0054_0030l
let number_of_phases = 0x0054_0031l
let phase_information_sequence = 0x0054_0032l
let number_of_frames_in_phase = 0x0054_0033l
let phase_delay = 0x0054_0036l
let pause_between_frames = 0x0054_0038l
let phase_description = 0x0054_0039l
let rotation_vector = 0x0054_0050l
let number_of_rotations = 0x0054_0051l
let rotation_information_sequence = 0x0054_0052l
let number_of_frames_in_rotation = 0x0054_0053l
let r_rinterval_vector = 0x0054_0060l
let number_of_rrintervals = 0x0054_0061l
let gated_information_sequence = 0x0054_0062l
let data_information_sequence = 0x0054_0063l
let time_slot_vector = 0x0054_0070l
let number_of_time_slots = 0x0054_0071l
let time_slot_information_sequence = 0x0054_0072l
let time_slot_time = 0x0054_0073l
let slice_vector = 0x0054_0080l
let number_of_slices = 0x0054_0081l
let angular_view_vector = 0x0054_0090l
let time_slice_vector = 0x0054_0100l
let number_of_time_slices = 0x0054_0101l
let start_angle = 0x0054_0200l
let type_of_detector_motion = 0x0054_0202l
let trigger_vector = 0x0054_0210l
let number_of_triggers_in_phase = 0x0054_0211l
let view_code_sequence = 0x0054_0220l
let view_modifier_code_sequence = 0x0054_0222l
let radionuclide_code_sequence = 0x0054_0300l
let administration_route_code_sequence = 0x0054_0302l
let radiopharmaceutical_code_sequence = 0x0054_0304l
let calibration_data_sequence = 0x0054_0306l
let energy_window_number = 0x0054_0308l
let image_id = 0x0054_0400l
let patient_orientation_code_sequence = 0x0054_0410l
let patient_orientation_modifier_code_sequence = 0x0054_0412l
let patient_gantry_relationship_code_sequence = 0x0054_0414l
let slice_progression_direction = 0x0054_0500l
let series_type = 0x0054_1000l
let units = 0x0054_1001l
let counts_source = 0x0054_1002l
let reprojection_method = 0x0054_1004l
let suv_type = 0x0054_1006l
let randoms_correction_method = 0x0054_1100l
let attenuation_correction_method = 0x0054_1101l
let decay_correction = 0x0054_1102l
let reconstruction_method = 0x0054_1103l
let detector_lines_of_response_used = 0x0054_1104l
let scatter_correction_method = 0x0054_1105l
let axial_acceptance = 0x0054_1200l
let axial_mash = 0x0054_1201l
let transverse_mash = 0x0054_1202l
let detector_element_size = 0x0054_1203l
let coincidence_window_width = 0x0054_1210l
let secondary_counts_type = 0x0054_1220l
let frame_reference_time = 0x0054_1300l
let primary_prompts_counts_accumulated = 0x0054_1310l
let secondary_counts_accumulated = 0x0054_1311l
let slice_sensitivity_factor = 0x0054_1320l
let decay_factor = 0x0054_1321l
let dose_calibration_factor = 0x0054_1322l
let scatter_fraction_factor = 0x0054_1323l
let dead_time_factor = 0x0054_1324l
let image_index = 0x0054_1330l
let counts_included = 0x0054_1400l
let dead_time_correction_flag = 0x0054_1401l
let histogram_sequence = 0x0060_3000l
let histogram_number_of_bins = 0x0060_3002l
let histogram_first_bin_value = 0x0060_3004l
let histogram_last_bin_value = 0x0060_3006l
let histogram_bin_width = 0x0060_3008l
let histogram_explanation = 0x0060_3010l
let histogram_data = 0x0060_3020l
let segmentation_type = 0x0062_0001l
let segment_sequence = 0x0062_0002l
let segmented_property_category_code_sequence = 0x0062_0003l
let segment_number = 0x0062_0004l
let segment_label = 0x0062_0005l
let segment_description = 0x0062_0006l
let segment_algorithm_type = 0x0062_0008l
let segment_algorithm_name = 0x0062_0009l
let segment_identification_sequence = 0x0062_000Al
let referenced_segment_number = 0x0062_000Bl
let recommended_display_grayscale_value = 0x0062_000Cl
let recommended_display_cie_lab_value = 0x0062_000Dl
let maximum_fractional_value = 0x0062_000El
let segmented_property_type_code_sequence = 0x0062_000Fl
let segmentation_fractional_type = 0x0062_0010l
let deformable_registration_sequence = 0x0064_0002l
let source_frame_of_reference_uid = 0x0064_0003l
let deformable_registration_grid_sequence = 0x0064_0005l
let grid_dimensions = 0x0064_0007l
let grid_resolution = 0x0064_0008l
let vector_grid_data = 0x0064_0009l
let pre_deformation_matrix_registration_sequence = 0x0064_000Fl
let post_deformation_matrix_registration_sequence = 0x0064_0010l
let number_of_surfaces = 0x0066_0001l
let surface_sequence = 0x0066_0002l
let surface_number = 0x0066_0003l
let surface_comments = 0x0066_0004l
let surface_processing = 0x0066_0009l
let surface_processing_ratio = 0x0066_000Al
let surface_processing_description = 0x0066_000Bl
let recommended_presentation_opacity = 0x0066_000Cl
let recommended_presentation_type = 0x0066_000Dl
let finite_volume = 0x0066_000El
let manifold = 0x0066_0010l
let surface_points_sequence = 0x0066_0011l
let surface_points_normals_sequence = 0x0066_0012l
let surface_mesh_primitives_sequence = 0x0066_0013l
let number_of_surface_points = 0x0066_0015l
let point_coordinates_data = 0x0066_0016l
let point_position_accuracy = 0x0066_0017l
let mean_point_distance = 0x0066_0018l
let maximum_point_distance = 0x0066_0019l
let points_bounding_box_coordinates = 0x0066_001Al
let axis_of_rotation = 0x0066_001Bl
let center_of_rotation = 0x0066_001Cl
let number_of_vectors = 0x0066_001El
let vector_dimensionality = 0x0066_001Fl
let vector_accuracy = 0x0066_0020l
let vector_coordinate_data = 0x0066_0021l
let triangle_point_index_list = 0x0066_0023l
let edge_point_index_list = 0x0066_0024l
let vertex_point_index_list = 0x0066_0025l
let triangle_strip_sequence = 0x0066_0026l
let triangle_fan_sequence = 0x0066_0027l
let line_sequence = 0x0066_0028l
let primitive_point_index_list = 0x0066_0029l
let surface_count = 0x0066_002Al
let referenced_surface_sequence = 0x0066_002Bl
let referenced_surface_number = 0x0066_002Cl
let segment_surface_generation_algorithm_identification_sequence = 0x0066_002Dl
let segment_surface_source_instance_sequence = 0x0066_002El
let algorithm_family_code_sequence = 0x0066_002Fl
let algorithm_name_code_sequence = 0x0066_0030l
let algorithm_version = 0x0066_0031l
let algorithm_parameters = 0x0066_0032l
let facet_sequence = 0x0066_0034l
let surface_processing_algorithm_identification_sequence = 0x0066_0035l
let algorithm_name = 0x0066_0036l
let implant_size = 0x0068_6210l
let implant_template_version = 0x0068_6221l
let replaced_implant_template_sequence = 0x0068_6222l
let implant_type = 0x0068_6223l
let derivation_implant_template_sequence = 0x0068_6224l
let original_implant_template_sequence = 0x0068_6225l
let effective_date_time = 0x0068_6226l
let implant_target_anatomy_sequence = 0x0068_6230l
let information_from_manufacturer_sequence = 0x0068_6260l
let notification_from_manufacturer_sequence = 0x0068_6265l
let information_issue_date_time = 0x0068_6270l
let information_summary = 0x0068_6280l
let implant_regulatory_disapproval_code_sequence = 0x0068_62A0l
let overall_template_spatial_tolerance = 0x0068_62A5l
let hpgldocumentsequence = 0x0068_62C0l
let hpgldocument_id = 0x0068_62D0l
let hpgldocumentlabel = 0x0068_62D5l
let view_orientation_code_sequence = 0x0068_62E0l
let view_orientation_modifier = 0x0068_62F0l
let hpgl_document_scaling = 0x0068_62F2l
let hpgl_document = 0x0068_6300l
let hpgl_contour_pen_number = 0x0068_6310l
let hpgl_pen_sequence = 0x0068_6320l
let hpgl_pen_number = 0x0068_6330l
let hpgl_pen_label = 0x0068_6340l
let hpgl_pen_description = 0x0068_6345l
let recommended_rotation_point = 0x0068_6346l
let bounding_rectangle = 0x0068_6347l
let implant_template3_dmodel_surface_number = 0x0068_6350l
let surface_model_description_sequence = 0x0068_6360l
let surface_model_label = 0x0068_6380l
let surface_model_scaling_factor = 0x0068_6390l
let materials_code_sequence = 0x0068_63A0l
let coating_materials_code_sequence = 0x0068_63A4l
let implant_type_code_sequence = 0x0068_63A8l
let fixation_method_code_sequence = 0x0068_63ACl
let mating_feature_sets_sequence = 0x0068_63B0l
let mating_feature_set_id = 0x0068_63C0l
let mating_feature_set_label = 0x0068_63D0l
let mating_feature_sequence = 0x0068_63E0l
let mating_feature_id = 0x0068_63F0l
let mating_feature_degree_of_freedom_sequence = 0x0068_6400l
let degree_of_freedom_id = 0x0068_6410l
let degree_of_freedom_type = 0x0068_6420l
let two_dmating_feature_coordinates_sequence = 0x0068_6430l
let referenced_hpgl_document_id = 0x0068_6440l
let two_d_mating_point = 0x0068_6450l
let two_d_mating_axes = 0x0068_6460l
let two_d_degree_of_freedom_sequence = 0x0068_6470l
let three_d_degree_of_freedom_axis = 0x0068_6490l
let range_of_freedom = 0x0068_64A0l
let three_d_mating_point = 0x0068_64C0l
let three_d_mating_axes = 0x0068_64D0l
let two_d_degree_of_freedom_axis = 0x0068_64F0l
let planning_landmark_point_sequence = 0x0068_6500l
let planning_landmark_line_sequence = 0x0068_6510l
let planning_landmark_plane_sequence = 0x0068_6520l
let planning_landmark_id = 0x0068_6530l
let planning_landmark_description = 0x0068_6540l
let planning_landmark_identification_code_sequence = 0x0068_6545l
let two_d_point_coordinates_sequence = 0x0068_6550l
let two_d_point_coordinates = 0x0068_6560l
let three_d_point_coordinates = 0x0068_6590l
let two_d_line_coordinates_sequence = 0x0068_65A0l
let two_d_line_coordinates = 0x0068_65B0l
let three_d_line_coordinates = 0x0068_65D0l
let two_d_plane_coordinates_sequence = 0x0068_65E0l
let two_d_plane_intersection = 0x0068_65F0l
let three_d_plane_origin = 0x0068_6610l
let three_d_plane_normal = 0x0068_6620l
let graphic_annotation_sequence = 0x0070_0001l
let graphic_layer = 0x0070_0002l
let bounding_box_annotation_units = 0x0070_0003l
let anchor_point_annotation_units = 0x0070_0004l
let graphic_annotation_units = 0x0070_0005l
let unformatted_text_value = 0x0070_0006l
let text_object_sequence = 0x0070_0008l
let graphic_object_sequence = 0x0070_0009l
let bounding_box_top_left_hand_corner = 0x0070_0010l
let bounding_box_bottom_right_hand_corner = 0x0070_0011l
let bounding_box_text_horizontal_justification = 0x0070_0012l
let anchor_point = 0x0070_0014l
let anchor_point_visibility = 0x0070_0015l
let graphic_dimensions = 0x0070_0020l
let number_of_graphic_points = 0x0070_0021l
let graphic_data = 0x0070_0022l
let graphic_type = 0x0070_0023l
let graphic_filled = 0x0070_0024l
let image_rotation_retired = 0x0070_0040l
let image_horizontal_flip = 0x0070_0041l
let image_rotation = 0x0070_0042l
let displayed_area_top_left_hand_corner_trial = 0x0070_0050l
let displayed_area_bottom_right_hand_corner_trial = 0x0070_0051l
let displayed_area_top_left_hand_corner = 0x0070_0052l
let displayed_area_bottom_right_hand_corner = 0x0070_0053l
let displayed_area_selection_sequence = 0x0070_005Al
let graphic_layer_sequence = 0x0070_0060l
let graphic_layer_order = 0x0070_0062l
let graphic_layer_recommended_display_grayscale_value = 0x0070_0066l
let graphic_layer_recommended_display_rgbvalue = 0x0070_0067l
let graphic_layer_description = 0x0070_0068l
let content_label = 0x0070_0080l
let content_description = 0x0070_0081l
let presentation_creation_date = 0x0070_0082l
let presentation_creation_time = 0x0070_0083l
let content_creator_name = 0x0070_0084l
let content_creator_identification_code_sequence = 0x0070_0086l
let alternate_content_description_sequence = 0x0070_0087l
let presentation_size_mode = 0x0070_0100l
let presentation_pixel_spacing = 0x0070_0101l
let presentation_pixel_aspect_ratio = 0x0070_0102l
let presentation_pixel_magnification_ratio = 0x0070_0103l
let graphic_group_label = 0x0070_0207l
let graphic_group_description = 0x0070_0208l
let compound_graphic_sequence = 0x0070_0209l
let compound_graphic_instance_id = 0x0070_0226l
let font_name = 0x0070_0227l
let font_name_type = 0x0070_0228l
let css_font_name = 0x0070_0229l
let rotation_angle = 0x0070_0230l
let text_style_sequence = 0x0070_0231l
let line_style_sequence = 0x0070_0232l
let fill_style_sequence = 0x0070_0233l
let graphic_group_sequence = 0x0070_0234l
let text_color_cie_lab_value = 0x0070_0241l
let horizontal_alignment = 0x0070_0242l
let vertical_alignment = 0x0070_0243l
let shadow_style = 0x0070_0244l
let shadow_offset_x = 0x0070_0245l
let shadow_offset_y = 0x0070_0246l
let shadow_color_cie_lab_value = 0x0070_0247l
let underlined = 0x0070_0248l
let bold = 0x0070_0249l
let italic = 0x0070_0250l
let pattern_on_color_cie_lab_value = 0x0070_0251l
let pattern_off_color_cie_lab_value = 0x0070_0252l
let line_thickness = 0x0070_0253l
let line_dashing_style = 0x0070_0254l
let line_pattern = 0x0070_0255l
let fill_pattern = 0x0070_0256l
let fill_mode = 0x0070_0257l
let shadow_opacity = 0x0070_0258l
let gap_length = 0x0070_0261l
let diameter_of_visibility = 0x0070_0262l
let rotation_point = 0x0070_0273l
let tick_alignment = 0x0070_0274l
let show_tick_label = 0x0070_0278l
let tick_label_alignment = 0x0070_0279l
let compound_graphic_units = 0x0070_0282l
let pattern_on_opacity = 0x0070_0284l
let pattern_off_opacity = 0x0070_0285l
let major_ticks_sequence = 0x0070_0287l
let tick_position = 0x0070_0288l
let tick_label = 0x0070_0289l
let compound_graphic_type = 0x0070_0294l
let graphic_group_id = 0x0070_0295l
let shape_type = 0x0070_0306l
let registration_sequence = 0x0070_0308l
let matrix_registration_sequence = 0x0070_0309l
let matrix_sequence = 0x0070_030Al
let frame_of_reference_transformation_matrix_type = 0x0070_030Cl
let registration_type_code_sequence = 0x0070_030Dl
let fiducial_description = 0x0070_030Fl
let fiducial_identifier = 0x0070_0310l
let fiducial_identifier_code_sequence = 0x0070_0311l
let contour_uncertainty_radius = 0x0070_0312l
let used_fiducials_sequence = 0x0070_0314l
let graphic_coordinates_data_sequence = 0x0070_0318l
let fiducial_uid = 0x0070_031Al
let fiducial_set_sequence = 0x0070_031Cl
let fiducial_sequence = 0x0070_031El
let graphic_layer_recommended_display_cielab_value = 0x0070_0401l
let blending_sequence = 0x0070_0402l
let relative_opacity = 0x0070_0403l
let referenced_spatial_registration_sequence = 0x0070_0404l
let blending_position = 0x0070_0405l
let hanging_protocol_name = 0x0072_0002l
let hanging_protocol_description = 0x0072_0004l
let hanging_protocol_level = 0x0072_0006l
let hanging_protocol_creator = 0x0072_0008l
let hanging_protocol_creation_date_time = 0x0072_000Al
let hanging_protocol_definition_sequence = 0x0072_000Cl
let hanging_protocol_user_identification_code_sequence = 0x0072_000El
let hanging_protocol_user_group_name = 0x0072_0010l
let source_hanging_protocol_sequence = 0x0072_0012l
let number_of_priors_referenced = 0x0072_0014l
let image_sets_sequence = 0x0072_0020l
let image_set_selector_sequence = 0x0072_0022l
let image_set_selector_usage_flag = 0x0072_0024l
let selector_attribute = 0x0072_0026l
let selector_value_number = 0x0072_0028l
let time_based_image_sets_sequence = 0x0072_0030l
let image_set_number = 0x0072_0032l
let image_set_selector_category = 0x0072_0034l
let relative_time = 0x0072_0038l
let relative_time_units = 0x0072_003Al
let abstract_prior_value = 0x0072_003Cl
let abstract_prior_code_sequence = 0x0072_003El
let image_set_label = 0x0072_0040l
let selector_attribute_vr = 0x0072_0050l
let selector_sequence_pointer = 0x0072_0052l
let selector_sequence_pointer_private_creator = 0x0072_0054l
let selector_attribute_private_creator = 0x0072_0056l
let selector_at_value = 0x0072_0060l
let selector_cs_value = 0x0072_0062l
let selector_is_value = 0x0072_0064l
let selector_lo_value = 0x0072_0066l
let selector_lt_value = 0x0072_0068l
let selector_pn_value = 0x0072_006Al
let selector_sh_value = 0x0072_006Cl
let selector_st_value = 0x0072_006El
let selector_ut_value = 0x0072_0070l
let selector_ds_value = 0x0072_0072l
let selector_fd_value = 0x0072_0074l
let selector_fl_value = 0x0072_0076l
let selector_ul_value = 0x0072_0078l
let selector_us_value = 0x0072_007Al
let selector_sl_value = 0x0072_007Cl
let selector_ss_value = 0x0072_007El
let selector_code_sequence_value = 0x0072_0080l
let number_of_screens = 0x0072_0100l
let nominal_screen_definition_sequence = 0x0072_0102l
let number_of_vertical_pixels = 0x0072_0104l
let number_of_horizontal_pixels = 0x0072_0106l
let display_environment_spatial_position = 0x0072_0108l
let screen_minimum_grayscale_bit_depth = 0x0072_010Al
let screen_minimum_color_bit_depth = 0x0072_010Cl
let application_maximum_repaint_time = 0x0072_010El
let display_sets_sequence = 0x0072_0200l
let display_set_number = 0x0072_0202l
let display_set_label = 0x0072_0203l
let display_set_presentation_group = 0x0072_0204l
let display_set_presentation_group_description = 0x0072_0206l
let partial_data_display_handling = 0x0072_0208l
let synchronized_scrolling_sequence = 0x0072_0210l
let display_set_scrolling_group = 0x0072_0212l
let navigation_indicator_sequence = 0x0072_0214l
let navigation_display_set = 0x0072_0216l
let reference_display_sets = 0x0072_0218l
let image_boxes_sequence = 0x0072_0300l
let image_box_number = 0x0072_0302l
let image_box_layout_type = 0x0072_0304l
let image_box_tile_horizontal_dimension = 0x0072_0306l
let image_box_tile_vertical_dimension = 0x0072_0308l
let image_box_scroll_direction = 0x0072_0310l
let image_box_small_scroll_type = 0x0072_0312l
let image_box_small_scroll_amount = 0x0072_0314l
let image_box_large_scroll_type = 0x0072_0316l
let image_box_large_scroll_amount = 0x0072_0318l
let image_box_overlap_priority = 0x0072_0320l
let cine_relative_to_real_time = 0x0072_0330l
let filter_operations_sequence = 0x0072_0400l
let filter_by_category = 0x0072_0402l
let filter_by_attribute_presence = 0x0072_0404l
let filter_by_operator = 0x0072_0406l
let structured_display_background_cielab_value = 0x0072_0420l
let empty_image_box_cie_lab_value = 0x0072_0421l
let structured_display_image_box_sequence = 0x0072_0422l
let structured_display_text_box_sequence = 0x0072_0424l
let referenced_first_frame_sequence = 0x0072_0427l
let image_box_synchronization_sequence = 0x0072_0430l
let synchronized_image_box_list = 0x0072_0432l
let type_of_synchronization = 0x0072_0434l
let blending_operation_type = 0x0072_0500l
let reformatting_operation_type = 0x0072_0510l
let reformatting_thickness = 0x0072_0512l
let reformatting_interval = 0x0072_0514l
let reformatting_operation_initial_view_direction = 0x0072_0516l
let three_drendering_type = 0x0072_0520l
let sorting_operations_sequence = 0x0072_0600l
let sort_by_category = 0x0072_0602l
let sorting_direction = 0x0072_0604l
let display_set_patient_orientation = 0x0072_0700l
let voi_type = 0x0072_0702l
let pseudo_color_type = 0x0072_0704l
let pseudo_color_palette_instance_reference_sequence = 0x0072_0705l
let show_grayscale_inverted = 0x0072_0706l
let show_image_true_size_flag = 0x0072_0710l
let show_graphic_annotation_flag = 0x0072_0712l
let show_patient_demographics_flag = 0x0072_0714l
let show_acquisition_techniques_flag = 0x0072_0716l
let display_set_horizontal_justification = 0x0072_0717l
let display_set_vertical_justification = 0x0072_0718l
let continuation_start_meterset = 0x0074_0120l
let continuation_end_meterset = 0x0074_0121l
let procedure_step_state = 0x0074_1000l
let procedure_step_progress_information_sequence = 0x0074_1002l
let procedure_step_progress = 0x0074_1004l
let procedure_step_progress_description = 0x0074_1006l
let procedure_step_communications_urisequence = 0x0074_1008l
let contact_uri = 0x0074_100al
let contact_display_name = 0x0074_100cl
let procedure_step_discontinuation_reason_code_sequence = 0x0074_100el
let beam_task_sequence = 0x0074_1020l
let beam_task_type = 0x0074_1022l
let beam_order_index_trial = 0x0074_1024l
let table_top_vertical_adjusted_position = 0x0074_1026l
let table_top_longitudinal_adjusted_position = 0x0074_1027l
let table_top_lateral_adjusted_position = 0x0074_1028l
let patient_support_adjusted_angle = 0x0074_102Al
let table_top_eccentric_adjusted_angle = 0x0074_102Bl
let table_top_pitch_adjusted_angle = 0x0074_102Cl
let table_top_roll_adjusted_angle = 0x0074_102Dl
let delivery_verification_image_sequence = 0x0074_1030l
let verification_image_timing = 0x0074_1032l
let double_exposure_flag = 0x0074_1034l
let double_exposure_ordering = 0x0074_1036l
let double_exposure_meterset_trial = 0x0074_1038l
let double_exposure_field_delta_trial = 0x0074_103Al
let related_reference_rtimage_sequence = 0x0074_1040l
let general_machine_verification_sequence = 0x0074_1042l
let conventional_machine_verification_sequence = 0x0074_1044l
let ion_machine_verification_sequence = 0x0074_1046l
let failed_attributes_sequence = 0x0074_1048l
let overridden_attributes_sequence = 0x0074_104Al
let conventional_control_point_verification_sequence = 0x0074_104Cl
let ion_control_point_verification_sequence = 0x0074_104El
let attribute_occurrence_sequence = 0x0074_1050l
let attribute_occurrence_pointer = 0x0074_1052l
let attribute_item_selector = 0x0074_1054l
let attribute_occurrence_private_creator = 0x0074_1056l
let selector_sequence_pointer_items = 0x0074_1057l
let scheduled_procedure_step_priority = 0x0074_1200l
let worklist_label = 0x0074_1202l
let procedure_step_label = 0x0074_1204l
let scheduled_processing_parameters_sequence = 0x0074_1210l
let performed_processing_parameters_sequence = 0x0074_1212l
let unified_procedure_step_performed_procedure_sequence = 0x0074_1216l
let related_procedure_step_sequence = 0x0074_1220l
let procedure_step_relationship_type = 0x0074_1222l
let replaced_procedure_step_sequence = 0x0074_1224l
let deletion_lock = 0x0074_1230l
let receiving_ae = 0x0074_1234l
let requesting_ae = 0x0074_1236l
let reason_for_cancellation = 0x0074_1238l
let scp_status = 0x0074_1242l
let subscription_list_status = 0x0074_1244l
let unified_procedure_step_list_status = 0x0074_1246l
let beam_order_index = 0x0074_1324l
let double_exposure_meterset = 0x0074_1338l
let double_exposure_field_delta = 0x0074_133Al
let implant_assembly_template_name = 0x0076_0001l
let implant_assembly_template_issuer = 0x0076_0003l
let implant_assembly_template_version = 0x0076_0006l
let replaced_implant_assembly_template_sequence = 0x0076_0008l
let implant_assembly_template_type = 0x0076_000Al
let original_implant_assembly_template_sequence = 0x0076_000Cl
let derivation_implant_assembly_template_sequence = 0x0076_000El
let implant_assembly_template_target_anatomy_sequence = 0x0076_0010l
let procedure_type_code_sequence = 0x0076_0020l
let surgical_technique = 0x0076_0030l
let component_types_sequence = 0x0076_0032l
let component_type_code_sequence = 0x0076_0034l
let exclusive_component_type = 0x0076_0036l
let mandatory_component_type = 0x0076_0038l
let component_sequence = 0x0076_0040l
let component_id = 0x0076_0055l
let component_assembly_sequence = 0x0076_0060l
let component1_referenced_id = 0x0076_0070l
let component1_referenced_mating_feature_set_id = 0x0076_0080l
let component1_referenced_mating_feature_id = 0x0076_0090l
let component2_referenced_id = 0x0076_00A0l
let component2_referenced_mating_feature_set_id = 0x0076_00B0l
let component2_referenced_mating_feature_id = 0x0076_00C0l
let implant_template_group_name = 0x0078_0001l
let implant_template_group_description = 0x0078_0010l
let implant_template_group_issuer = 0x0078_0020l
let implant_template_group_version = 0x0078_0024l
let replaced_implant_template_group_sequence = 0x0078_0026l
let implant_template_group_target_anatomy_sequence = 0x0078_0028l
let implant_template_group_members_sequence = 0x0078_002Al
let implant_template_group_member_id = 0x0078_002El
let three_d_implant_template_group_member_matching_point = 0x0078_0050l
let three_d_implant_template_group_member_matching_axes = 0x0078_0060l
let implant_template_group_member_matching2_dcoordinates_sequence = 0x0078_0070l
let two_d_implant_template_group_member_matching_point = 0x0078_0090l
let two_d_implant_template_group_member_matching_axes = 0x0078_00A0l
let implant_template_group_variation_dimension_sequence = 0x0078_00B0l
let implant_template_group_variation_dimension_name = 0x0078_00B2l
let implant_template_group_variation_dimension_rank_sequence = 0x0078_00B4l
let referenced_implant_template_group_member_id = 0x0078_00B6l
let implant_template_group_variation_dimension_rank = 0x0078_00B8l
let storage_media_file_set_id = 0x0088_0130l
let storage_media_file_set_uid = 0x0088_0140l
let icon_image_sequence = 0x0088_0200l
let topic_title = 0x0088_0904l
let topic_subject = 0x0088_0906l
let topic_author = 0x0088_0910l
let topic_keywords = 0x0088_0912l
let sop_instance_status = 0x0100_0410l
let sop_authorization_date_time = 0x0100_0420l
let sop_authorization_comment = 0x0100_0424l
let authorization_equipment_certification_number = 0x0100_0426l
let mac_id_number = 0x0400_0005l
let mac_calculation_transfer_syntax_uid = 0x0400_0010l
let mac_algorithm = 0x0400_0015l
let data_elements_signed = 0x0400_0020l
let digital_signature_uid = 0x0400_0100l
let digital_signature_date_time = 0x0400_0105l
let certificate_type = 0x0400_0110l
let certificate_of_signer = 0x0400_0115l
let signature = 0x0400_0120l
let certified_timestamp_type = 0x0400_0305l
let certified_timestamp = 0x0400_0310l
let digital_signature_purpose_code_sequence = 0x0400_0401l
let referenced_digital_signature_sequence = 0x0400_0402l
let referenced_sop_instance_mac_sequence = 0x0400_0403l
let mac = 0x0400_0404l
let encrypted_attributes_sequence = 0x0400_0500l
let encrypted_content_transfer_syntax_uid = 0x0400_0510l
let encrypted_content = 0x0400_0520l
let modified_attributes_sequence = 0x0400_0550l
let original_attributes_sequence = 0x0400_0561l
let attribute_modification_date_time = 0x0400_0562l
let modifying_system = 0x0400_0563l
let source_of_previous_values = 0x0400_0564l
let reason_for_the_attribute_modification = 0x0400_0565l
let escape_triplet = 0x1000_0000l
let run_length_triplet = 0x1000_0001l
let huffman_table_size = 0x1000_0002l
let huffman_table_triplet = 0x1000_0003l
let shift_table_size = 0x1000_0004l
let shift_table_triplet = 0x1000_0005l
let zonal_map = 0x1010_0000l
let number_of_copies = 0x2000_0010l
let printer_configuration_sequence = 0x2000_001El
let print_priority = 0x2000_0020l
let medium_type = 0x2000_0030l
let film_destination = 0x2000_0040l
let film_session_label = 0x2000_0050l
let memory_allocation = 0x2000_0060l
let maximum_memory_allocation = 0x2000_0061l
let color_image_printing_flag = 0x2000_0062l
let collation_flag = 0x2000_0063l
let annotation_flag = 0x2000_0065l
let image_overlay_flag = 0x2000_0067l
let presentation_lut_flag = 0x2000_0069l
let image_box_presentation_lutflag = 0x2000_006Al
let memory_bit_depth = 0x2000_00A0l
let printing_bit_depth = 0x2000_00A1l
let media_installed_sequence = 0x2000_00A2l
let other_media_available_sequence = 0x2000_00A4l
let supported_image_display_formats_sequence = 0x2000_00A8l
let referenced_film_box_sequence = 0x2000_0500l
let referenced_stored_print_sequence = 0x2000_0510l
let image_display_format = 0x2010_0010l
let annotation_display_format_id = 0x2010_0030l
let film_orientation = 0x2010_0040l
let film_size_id = 0x2010_0050l
let printer_resolution_id = 0x2010_0052l
let default_printer_resolution_id = 0x2010_0054l
let magnification_type = 0x2010_0060l
let smoothing_type = 0x2010_0080l
let default_magnification_type = 0x2010_00A6l
let other_magnification_types_available = 0x2010_00A7l
let default_smoothing_type = 0x2010_00A8l
let other_smoothing_types_available = 0x2010_00A9l
let border_density = 0x2010_0100l
let empty_image_density = 0x2010_0110l
let min_density = 0x2010_0120l
let max_density = 0x2010_0130l
let trim = 0x2010_0140l
let configuration_information = 0x2010_0150l
let configuration_information_description = 0x2010_0152l
let maximum_collated_films = 0x2010_0154l
let illumination = 0x2010_015El
let reflected_ambient_light = 0x2010_0160l
let printer_pixel_spacing = 0x2010_0376l
let referenced_film_session_sequence = 0x2010_0500l
let referenced_image_box_sequence = 0x2010_0510l
let referenced_basic_annotation_box_sequence = 0x2010_0520l
let image_box_position = 0x2020_0010l
let polarity = 0x2020_0020l
let requested_image_size = 0x2020_0030l
let requested_decimate_crop_behavior = 0x2020_0040l
let requested_resolution_id = 0x2020_0050l
let requested_image_size_flag = 0x2020_00A0l
let decimate_crop_result = 0x2020_00A2l
let basic_grayscale_image_sequence = 0x2020_0110l
let basic_color_image_sequence = 0x2020_0111l
let referenced_image_overlay_box_sequence = 0x2020_0130l
let referenced_voilutbox_sequence = 0x2020_0140l
let annotation_position = 0x2030_0010l
let text_string = 0x2030_0020l
let referenced_overlay_plane_sequence = 0x2040_0010l
let referenced_overlay_plane_groups = 0x2040_0011l
let overlay_pixel_data_sequence = 0x2040_0020l
let overlay_magnification_type = 0x2040_0060l
let overlay_smoothing_type = 0x2040_0070l
let overlay_or_image_magnification = 0x2040_0072l
let magnify_to_number_of_columns = 0x2040_0074l
let overlay_foreground_density = 0x2040_0080l
let overlay_background_density = 0x2040_0082l
let overlay_mode = 0x2040_0090l
let threshold_density = 0x2040_0100l
let referenced_image_box_sequence_retired = 0x2040_0500l
let presentation_lutsequence = 0x2050_0010l
let presentation_lutshape = 0x2050_0020l
let referenced_presentation_lutsequence = 0x2050_0500l
let print_job_id = 0x2100_0010l
let execution_status = 0x2100_0020l
let execution_status_info = 0x2100_0030l
let creation_date = 0x2100_0040l
let creation_time = 0x2100_0050l
let originator = 0x2100_0070l
let destination_ae = 0x2100_0140l
let owner_id = 0x2100_0160l
let number_of_films = 0x2100_0170l
let referenced_print_job_sequence_pull_stored_print = 0x2100_0500l
let printer_status = 0x2110_0010l
let printer_status_info = 0x2110_0020l
let printer_name = 0x2110_0030l
let print_queue_id = 0x2110_0099l
let queue_status = 0x2120_0010l
let print_job_description_sequence = 0x2120_0050l
let referenced_print_job_sequence = 0x2120_0070l
let print_management_capabilities_sequence = 0x2130_0010l
let printer_characteristics_sequence = 0x2130_0015l
let film_box_content_sequence = 0x2130_0030l
let image_box_content_sequence = 0x2130_0040l
let annotation_content_sequence = 0x2130_0050l
let image_overlay_box_content_sequence = 0x2130_0060l
let presentation_lut_content_sequence = 0x2130_0080l
let proposed_study_sequence = 0x2130_00A0l
let original_image_sequence = 0x2130_00C0l
let label_using_information_extracted_from_instances = 0x2200_0001l
let label_text = 0x2200_0002l
let label_style_selection = 0x2200_0003l
let media_disposition = 0x2200_0004l
let barcode_value = 0x2200_0005l
let barcode_symbology = 0x2200_0006l
let allow_media_splitting = 0x2200_0007l
let include_non_dicomobjects = 0x2200_0008l
let include_display_application = 0x2200_0009l
let preserve_composite_instances_after_media_creation = 0x2200_000Al
let total_number_of_pieces_of_media_created = 0x2200_000Bl
let requested_media_application_profile = 0x2200_000Cl
let referenced_storage_media_sequence = 0x2200_000Dl
let failure_attributes = 0x2200_000El
let allow_lossy_compression = 0x2200_000Fl
let request_priority = 0x2200_0020l
let rt_image_label = 0x3002_0002l
let rt_image_name = 0x3002_0003l
let rt_image_description = 0x3002_0004l
let reported_values_origin = 0x3002_000Al
let rt_image_plane = 0x3002_000Cl
let x_ray_image_receptor_translation = 0x3002_000Dl
let x_ray_image_receptor_angle = 0x3002_000El
let rt_image_orientation = 0x3002_0010l
let image_plane_pixel_spacing = 0x3002_0011l
let rt_image_position = 0x3002_0012l
let radiation_machine_name = 0x3002_0020l
let radiation_machine_sad = 0x3002_0022l
let radiation_machine_ssd = 0x3002_0024l
let rt_image_sid = 0x3002_0026l
let source_to_reference_object_distance = 0x3002_0028l
let fraction_number = 0x3002_0029l
let exposure_sequence = 0x3002_0030l
let meterset_exposure = 0x3002_0032l
let diaphragm_position = 0x3002_0034l
let fluence_map_sequence = 0x3002_0040l
let fluence_data_source = 0x3002_0041l
let fluence_data_scale = 0x3002_0042l
let primary_fluence_mode_sequence = 0x3002_0050l
let fluence_mode = 0x3002_0051l
let fluence_mode_id = 0x3002_0052l
let dvh_type = 0x3004_0001l
let dose_units = 0x3004_0002l
let dose_type = 0x3004_0004l
let dose_comment = 0x3004_0006l
let normalization_point = 0x3004_0008l
let dose_summation_type = 0x3004_000Al
let grid_frame_offset_vector = 0x3004_000Cl
let dose_grid_scaling = 0x3004_000El
let rt_dose_roi_sequence = 0x3004_0010l
let dose_value = 0x3004_0012l
let tissue_heterogeneity_correction = 0x3004_0014l
let dvh_normalization_point = 0x3004_0040l
let dvh_normalization_dose_value = 0x3004_0042l
let dvh_sequence = 0x3004_0050l
let dvh_dose_scaling = 0x3004_0052l
let dvh_volume_units = 0x3004_0054l
let dvh_number_of_bins = 0x3004_0056l
let dvh_data = 0x3004_0058l
let dvh_referenced_roisequence = 0x3004_0060l
let dvh_roicontribution_type = 0x3004_0062l
let dvh_minimum_dose = 0x3004_0070l
let dvh_maximum_dose = 0x3004_0072l
let dvh_mean_dose = 0x3004_0074l
let structure_set_label = 0x3006_0002l
let structure_set_name = 0x3006_0004l
let structure_set_description = 0x3006_0006l
let structure_set_date = 0x3006_0008l
let structure_set_time = 0x3006_0009l
let referenced_frame_of_reference_sequence = 0x3006_0010l
let rt_referenced_study_sequence = 0x3006_0012l
let rt_referenced_series_sequence = 0x3006_0014l
let contour_image_sequence = 0x3006_0016l
let structure_set_roisequence = 0x3006_0020l
let roi_number = 0x3006_0022l
let referenced_frame_of_reference_uid = 0x3006_0024l
let roiname = 0x3006_0026l
let roidescription = 0x3006_0028l
let roidisplaycolor = 0x3006_002Al
let roivolume = 0x3006_002Cl
let rtrelatedroisequence = 0x3006_0030l
let rtroirelationship = 0x3006_0033l
let roigenerationalgorithm = 0x3006_0036l
let roigenerationdescription = 0x3006_0038l
let roicontoursequence = 0x3006_0039l
let contour_sequence = 0x3006_0040l
let contour_geometric_type = 0x3006_0042l
let contour_slab_thickness = 0x3006_0044l
let contour_offset_vector = 0x3006_0045l
let number_of_contour_points = 0x3006_0046l
let contour_number = 0x3006_0048l
let attached_contours = 0x3006_0049l
let contour_data = 0x3006_0050l
let rt_roi_observations_sequence = 0x3006_0080l
let observation_number = 0x3006_0082l
let referenced_roinumber = 0x3006_0084l
let roi_observation_label = 0x3006_0085l
let rt_roi_identification_code_sequence = 0x3006_0086l
let roi_observation_description = 0x3006_0088l
let related_rt_roi_observations_sequence = 0x3006_00A0l
let rt_roi_interpreted_type = 0x3006_00A4l
let roi_interpreter = 0x3006_00A6l
let roi_physical_properties_sequence = 0x3006_00B0l
let roi_physical_property = 0x3006_00B2l
let roi_physical_property_value = 0x3006_00B4l
let roi_elemental_composition_sequence = 0x3006_00B6l
let roi_elemental_composition_atomic_number = 0x3006_00B7l
let roi_elemental_composition_atomic_mass_fraction = 0x3006_00B8l
let frame_of_reference_relationship_sequence = 0x3006_00C0l
let related_frame_of_reference_uid = 0x3006_00C2l
let frame_of_reference_transformation_type = 0x3006_00C4l
let frame_of_reference_transformation_matrix = 0x3006_00C6l
let frame_of_reference_transformation_comment = 0x3006_00C8l
let measured_dose_reference_sequence = 0x3008_0010l
let measured_dose_description = 0x3008_0012l
let measured_dose_type = 0x3008_0014l
let measured_dose_value = 0x3008_0016l
let treatment_session_beam_sequence = 0x3008_0020l
let treatment_session_ion_beam_sequence = 0x3008_0021l
let current_fraction_number = 0x3008_0022l
let treatment_control_point_date = 0x3008_0024l
let treatment_control_point_time = 0x3008_0025l
let treatment_termination_status = 0x3008_002Al
let treatment_termination_code = 0x3008_002Bl
let treatment_verification_status = 0x3008_002Cl
let referenced_treatment_record_sequence = 0x3008_0030l
let specified_primary_meterset = 0x3008_0032l
let specified_secondary_meterset = 0x3008_0033l
let delivered_primary_meterset = 0x3008_0036l
let delivered_secondary_meterset = 0x3008_0037l
let specified_treatment_time = 0x3008_003Al
let delivered_treatment_time = 0x3008_003Bl
let control_point_delivery_sequence = 0x3008_0040l
let ion_control_point_delivery_sequence = 0x3008_0041l
let specified_meterset = 0x3008_0042l
let delivered_meterset = 0x3008_0044l
let meterset_rate_set = 0x3008_0045l
let meterset_rate_delivered = 0x3008_0046l
let scan_spot_metersets_delivered = 0x3008_0047l
let dose_rate_delivered = 0x3008_0048l
let treatment_summary_calculated_dose_reference_sequence = 0x3008_0050l
let cumulative_dose_to_dose_reference = 0x3008_0052l
let first_treatment_date = 0x3008_0054l
let most_recent_treatment_date = 0x3008_0056l
let number_of_fractions_delivered = 0x3008_005Al
let override_sequence = 0x3008_0060l
let parameter_sequence_pointer = 0x3008_0061l
let override_parameter_pointer = 0x3008_0062l
let parameter_item_index = 0x3008_0063l
let measured_dose_reference_number = 0x3008_0064l
let parameter_pointer = 0x3008_0065l
let override_reason = 0x3008_0066l
let corrected_parameter_sequence = 0x3008_0068l
let correction_value = 0x3008_006Al
let calculated_dose_reference_sequence = 0x3008_0070l
let calculated_dose_reference_number = 0x3008_0072l
let calculated_dose_reference_description = 0x3008_0074l
let calculated_dose_reference_dose_value = 0x3008_0076l
let start_meterset = 0x3008_0078l
let end_meterset = 0x3008_007Al
let referenced_measured_dose_reference_sequence = 0x3008_0080l
let referenced_measured_dose_reference_number = 0x3008_0082l
let referenced_calculated_dose_reference_sequence = 0x3008_0090l
let referenced_calculated_dose_reference_number = 0x3008_0092l
let beam_limiting_device_leaf_pairs_sequence = 0x3008_00A0l
let recorded_wedge_sequence = 0x3008_00B0l
let recorded_compensator_sequence = 0x3008_00C0l
let recorded_block_sequence = 0x3008_00D0l
let treatment_summary_measured_dose_reference_sequence = 0x3008_00E0l
let recorded_snout_sequence = 0x3008_00F0l
let recorded_range_shifter_sequence = 0x3008_00F2l
let recorded_lateral_spreading_device_sequence = 0x3008_00F4l
let recorded_range_modulator_sequence = 0x3008_00F6l
let recorded_source_sequence = 0x3008_0100l
let source_serial_number = 0x3008_0105l
let treatment_session_application_setup_sequence = 0x3008_0110l
let application_setup_check = 0x3008_0116l
let recorded_brachy_accessory_device_sequence = 0x3008_0120l
let referenced_brachy_accessory_device_number = 0x3008_0122l
let recorded_channel_sequence = 0x3008_0130l
let specified_channel_total_time = 0x3008_0132l
let delivered_channel_total_time = 0x3008_0134l
let specified_number_of_pulses = 0x3008_0136l
let delivered_number_of_pulses = 0x3008_0138l
let specified_pulse_repetition_interval = 0x3008_013Al
let delivered_pulse_repetition_interval = 0x3008_013Cl
let recorded_source_applicator_sequence = 0x3008_0140l
let referenced_source_applicator_number = 0x3008_0142l
let recorded_channel_shield_sequence = 0x3008_0150l
let referenced_channel_shield_number = 0x3008_0152l
let brachy_control_point_delivered_sequence = 0x3008_0160l
let safe_position_exit_date = 0x3008_0162l
let safe_position_exit_time = 0x3008_0164l
let safe_position_return_date = 0x3008_0166l
let safe_position_return_time = 0x3008_0168l
let current_treatment_status = 0x3008_0200l
let treatment_status_comment = 0x3008_0202l
let fraction_group_summary_sequence = 0x3008_0220l
let referenced_fraction_number = 0x3008_0223l
let fraction_group_type = 0x3008_0224l
let beam_stopper_position = 0x3008_0230l
let fraction_status_summary_sequence = 0x3008_0240l
let treatment_date = 0x3008_0250l
let treatment_time = 0x3008_0251l
let rt_plan_label = 0x300A_0002l
let rt_plan_name = 0x300A_0003l
let rt_plan_description = 0x300A_0004l
let rt_plan_date = 0x300A_0006l
let rt_plan_time = 0x300A_0007l
let treatment_protocols = 0x300A_0009l
let plan_intent = 0x300A_000Al
let treatment_sites = 0x300A_000Bl
let r_tplan_geometry = 0x300A_000Cl
let prescription_description = 0x300A_000El
let dose_reference_sequence = 0x300A_0010l
let dose_reference_number = 0x300A_0012l
let dose_reference_uid = 0x300A_0013l
let dose_reference_structure_type = 0x300A_0014l
let nominal_beam_energy_unit = 0x300A_0015l
let dose_reference_description = 0x300A_0016l
let dose_reference_point_coordinates = 0x300A_0018l
let nominal_prior_dose = 0x300A_001Al
let dose_reference_type = 0x300A_0020l
let constraint_weight = 0x300A_0021l
let delivery_warning_dose = 0x300A_0022l
let delivery_maximum_dose = 0x300A_0023l
let target_minimum_dose = 0x300A_0025l
let target_prescription_dose = 0x300A_0026l
let target_maximum_dose = 0x300A_0027l
let target_underdose_volume_fraction = 0x300A_0028l
let organ_at_risk_full_volume_dose = 0x300A_002Al
let organ_at_risk_limit_dose = 0x300A_002Bl
let organ_at_risk_maximum_dose = 0x300A_002Cl
let organ_at_risk_overdose_volume_fraction = 0x300A_002Dl
let tolerance_table_sequence = 0x300A_0040l
let tolerance_table_number = 0x300A_0042l
let tolerance_table_label = 0x300A_0043l
let gantry_angle_tolerance = 0x300A_0044l
let beam_limiting_device_angle_tolerance = 0x300A_0046l
let beam_limiting_device_tolerance_sequence = 0x300A_0048l
let beam_limiting_device_position_tolerance = 0x300A_004Al
let snout_position_tolerance = 0x300A_004Bl
let patient_support_angle_tolerance = 0x300A_004Cl
let table_top_eccentric_angle_tolerance = 0x300A_004El
let table_top_pitch_angle_tolerance = 0x300A_004Fl
let table_top_roll_angle_tolerance = 0x300A_0050l
let table_top_vertical_position_tolerance = 0x300A_0051l
let table_top_longitudinal_position_tolerance = 0x300A_0052l
let table_top_lateral_position_tolerance = 0x300A_0053l
let rt_plan_relationship = 0x300A_0055l
let fraction_group_sequence = 0x300A_0070l
let fraction_group_number = 0x300A_0071l
let fraction_group_description = 0x300A_0072l
let number_of_fractions_planned = 0x300A_0078l
let number_of_fraction_pattern_digits_per_day = 0x300A_0079l
let repeat_fraction_cycle_length = 0x300A_007Al
let fraction_pattern = 0x300A_007Bl
let number_of_beams = 0x300A_0080l
let beam_dose_specification_point = 0x300A_0082l
let beam_dose = 0x300A_0084l
let beam_meterset = 0x300A_0086l
let beam_dose_point_depth = 0x300A_0088l
let beam_dose_point_equivalent_depth = 0x300A_0089l
let beam_dose_point_ssd = 0x300A_008Al
let number_of_brachy_application_setups = 0x300A_00A0l
let brachy_application_setup_dose_specification_point = 0x300A_00A2l
let brachy_application_setup_dose = 0x300A_00A4l
let beam_sequence = 0x300A_00B0l
let treatment_machine_name = 0x300A_00B2l
let primary_dosimeter_unit = 0x300A_00B3l
let source_axis_distance = 0x300A_00B4l
let beam_limiting_device_sequence = 0x300A_00B6l
let r_tbeam_limiting_device_type = 0x300A_00B8l
let source_to_beam_limiting_device_distance = 0x300A_00BAl
let isocenter_to_beam_limiting_device_distance = 0x300A_00BBl
let number_of_leaf_jaw_pairs = 0x300A_00BCl
let leaf_position_boundaries = 0x300A_00BEl
let beam_number = 0x300A_00C0l
let beam_name = 0x300A_00C2l
let beam_description = 0x300A_00C3l
let beam_type = 0x300A_00C4l
let radiation_type = 0x300A_00C6l
let high_dose_technique_type = 0x300A_00C7l
let reference_image_number = 0x300A_00C8l
let planned_verification_image_sequence = 0x300A_00CAl
let imaging_device_specific_acquisition_parameters = 0x300A_00CCl
let treatment_delivery_type = 0x300A_00CEl
let number_of_wedges = 0x300A_00D0l
let wedge_sequence = 0x300A_00D1l
let wedge_number = 0x300A_00D2l
let wedge_type = 0x300A_00D3l
let wedge_id = 0x300A_00D4l
let wedge_angle = 0x300A_00D5l
let wedge_factor = 0x300A_00D6l
let total_wedge_tray_water_equivalent_thickness = 0x300A_00D7l
let wedge_orientation = 0x300A_00D8l
let isocenter_to_wedge_tray_distance = 0x300A_00D9l
let source_to_wedge_tray_distance = 0x300A_00DAl
let wedge_thin_edge_position = 0x300A_00DBl
let bolus_id = 0x300A_00DCl
let bolus_description = 0x300A_00DDl
let number_of_compensators = 0x300A_00E0l
let material_id = 0x300A_00E1l
let total_compensator_tray_factor = 0x300A_00E2l
let compensator_sequence = 0x300A_00E3l
let compensator_number = 0x300A_00E4l
let compensator_id = 0x300A_00E5l
let source_to_compensator_tray_distance = 0x300A_00E6l
let compensator_rows = 0x300A_00E7l
let compensator_columns = 0x300A_00E8l
let compensator_pixel_spacing = 0x300A_00E9l
let compensator_position = 0x300A_00EAl
let compensator_transmission_data = 0x300A_00EBl
let compensator_thickness_data = 0x300A_00ECl
let number_of_boli = 0x300A_00EDl
let compensator_type = 0x300A_00EEl
let number_of_blocks = 0x300A_00F0l
let total_block_tray_factor = 0x300A_00F2l
let total_block_tray_water_equivalent_thickness = 0x300A_00F3l
let block_sequence = 0x300A_00F4l
let block_tray_id = 0x300A_00F5l
let source_to_block_tray_distance = 0x300A_00F6l
let isocenter_to_block_tray_distance = 0x300A_00F7l
let block_type = 0x300A_00F8l
let accessory_code = 0x300A_00F9l
let block_divergence = 0x300A_00FAl
let block_mounting_position = 0x300A_00FBl
let block_number = 0x300A_00FCl
let block_name = 0x300A_00FEl
let block_thickness = 0x300A_0100l
let block_transmission = 0x300A_0102l
let block_number_of_points = 0x300A_0104l
let block_data = 0x300A_0106l
let applicator_sequence = 0x300A_0107l
let applicator_id = 0x300A_0108l
let applicator_type = 0x300A_0109l
let applicator_description = 0x300A_010Al
let cumulative_dose_reference_coefficient = 0x300A_010Cl
let final_cumulative_meterset_weight = 0x300A_010El
let number_of_control_points = 0x300A_0110l
let control_point_sequence = 0x300A_0111l
let control_point_index = 0x300A_0112l
let nominal_beam_energy = 0x300A_0114l
let dose_rate_set = 0x300A_0115l
let wedge_position_sequence = 0x300A_0116l
let wedge_position = 0x300A_0118l
let beam_limiting_device_position_sequence = 0x300A_011Al
let leaf_jaw_positions = 0x300A_011Cl
let gantry_angle = 0x300A_011El
let gantry_rotation_direction = 0x300A_011Fl
let beam_limiting_device_angle = 0x300A_0120l
let beam_limiting_device_rotation_direction = 0x300A_0121l
let patient_support_angle = 0x300A_0122l
let patient_support_rotation_direction = 0x300A_0123l
let table_top_eccentric_axis_distance = 0x300A_0124l
let table_top_eccentric_angle = 0x300A_0125l
let table_top_eccentric_rotation_direction = 0x300A_0126l
let table_top_vertical_position = 0x300A_0128l
let table_top_longitudinal_position = 0x300A_0129l
let table_top_lateral_position = 0x300A_012Al
let isocenter_position = 0x300A_012Cl
let surface_entry_point = 0x300A_012El
let source_to_surface_distance = 0x300A_0130l
let cumulative_meterset_weight = 0x300A_0134l
let table_top_pitch_angle = 0x300A_0140l
let table_top_pitch_rotation_direction = 0x300A_0142l
let table_top_roll_angle = 0x300A_0144l
let table_top_roll_rotation_direction = 0x300A_0146l
let head_fixation_angle = 0x300A_0148l
let gantry_pitch_angle = 0x300A_014Al
let gantry_pitch_rotation_direction = 0x300A_014Cl
let gantry_pitch_angle_tolerance = 0x300A_014El
let patient_setup_sequence = 0x300A_0180l
let patient_setup_number = 0x300A_0182l
let patient_setup_label = 0x300A_0183l
let patient_additional_position = 0x300A_0184l
let fixation_device_sequence = 0x300A_0190l
let fixation_device_type = 0x300A_0192l
let fixation_device_label = 0x300A_0194l
let fixation_device_description = 0x300A_0196l
let fixation_device_position = 0x300A_0198l
let fixation_device_pitch_angle = 0x300A_0199l
let fixation_device_roll_angle = 0x300A_019Al
let shielding_device_sequence = 0x300A_01A0l
let shielding_device_type = 0x300A_01A2l
let shielding_device_label = 0x300A_01A4l
let shielding_device_description = 0x300A_01A6l
let shielding_device_position = 0x300A_01A8l
let setup_technique = 0x300A_01B0l
let setup_technique_description = 0x300A_01B2l
let setup_device_sequence = 0x300A_01B4l
let setup_device_type = 0x300A_01B6l
let setup_device_label = 0x300A_01B8l
let setup_device_description = 0x300A_01BAl
let setup_device_parameter = 0x300A_01BCl
let setup_reference_description = 0x300A_01D0l
let table_top_vertical_setup_displacement = 0x300A_01D2l
let table_top_longitudinal_setup_displacement = 0x300A_01D4l
let table_top_lateral_setup_displacement = 0x300A_01D6l
let brachy_treatment_technique = 0x300A_0200l
let brachy_treatment_type = 0x300A_0202l
let treatment_machine_sequence = 0x300A_0206l
let source_sequence = 0x300A_0210l
let source_number = 0x300A_0212l
let source_type = 0x300A_0214l
let source_manufacturer = 0x300A_0216l
let active_source_diameter = 0x300A_0218l
let active_source_length = 0x300A_021Al
let source_encapsulation_nominal_thickness = 0x300A_0222l
let source_encapsulation_nominal_transmission = 0x300A_0224l
let source_isotope_name = 0x300A_0226l
let source_isotope_half_life = 0x300A_0228l
let source_strength_units = 0x300A_0229l
let reference_air_kerma_rate = 0x300A_022Al
let source_strength = 0x300A_022Bl
let source_strength_reference_date = 0x300A_022Cl
let source_strength_reference_time = 0x300A_022El
let application_setup_sequence = 0x300A_0230l
let application_setup_type = 0x300A_0232l
let application_setup_number = 0x300A_0234l
let application_setup_name = 0x300A_0236l
let application_setup_manufacturer = 0x300A_0238l
let template_number = 0x300A_0240l
let template_type = 0x300A_0242l
let template_name = 0x300A_0244l
let total_reference_air_kerma = 0x300A_0250l
let brachy_accessory_device_sequence = 0x300A_0260l
let brachy_accessory_device_number = 0x300A_0262l
let brachy_accessory_device_id = 0x300A_0263l
let brachy_accessory_device_type = 0x300A_0264l
let brachy_accessory_device_name = 0x300A_0266l
let brachy_accessory_device_nominal_thickness = 0x300A_026Al
let brachy_accessory_device_nominal_transmission = 0x300A_026Cl
let channel_sequence = 0x300A_0280l
let channel_number = 0x300A_0282l
let channel_length = 0x300A_0284l
let channel_total_time = 0x300A_0286l
let source_movement_type = 0x300A_0288l
let number_of_pulses = 0x300A_028Al
let pulse_repetition_interval = 0x300A_028Cl
let source_applicator_number = 0x300A_0290l
let source_applicator_id = 0x300A_0291l
let source_applicator_type = 0x300A_0292l
let source_applicator_name = 0x300A_0294l
let source_applicator_length = 0x300A_0296l
let source_applicator_manufacturer = 0x300A_0298l
let source_applicator_wall_nominal_thickness = 0x300A_029Cl
let source_applicator_wall_nominal_transmission = 0x300A_029El
let source_applicator_step_size = 0x300A_02A0l
let transfer_tube_number = 0x300A_02A2l
let transfer_tube_length = 0x300A_02A4l
let channel_shield_sequence = 0x300A_02B0l
let channel_shield_number = 0x300A_02B2l
let channel_shield_id = 0x300A_02B3l
let channel_shield_name = 0x300A_02B4l
let channel_shield_nominal_thickness = 0x300A_02B8l
let channel_shield_nominal_transmission = 0x300A_02BAl
let final_cumulative_time_weight = 0x300A_02C8l
let brachy_control_point_sequence = 0x300A_02D0l
let control_point_relative_position = 0x300A_02D2l
let control_point_3d_position = 0x300A_02D4l
let cumulative_time_weight = 0x300A_02D6l
let compensator_divergence = 0x300A_02E0l
let compensator_mounting_position = 0x300A_02E1l
let source_to_compensator_distance = 0x300A_02E2l
let total_compensator_tray_water_equivalent_thickness = 0x300A_02E3l
let isocenter_to_compensator_tray_distance = 0x300A_02E4l
let compensator_column_offset = 0x300A_02E5l
let isocenter_to_compensator_distances = 0x300A_02E6l
let compensator_relative_stopping_power_ratio = 0x300A_02E7l
let compensator_milling_tool_diameter = 0x300A_02E8l
let ion_range_compensator_sequence = 0x300A_02EAl
let compensator_description = 0x300A_02EBl
let radiation_mass_number = 0x300A_0302l
let radiation_atomic_number = 0x300A_0304l
let radiation_charge_state = 0x300A_0306l
let scan_mode = 0x300A_0308l
let virtual_source_axis_distances = 0x300A_030Al
let snout_sequence = 0x300A_030Cl
let snout_position = 0x300A_030Dl
let snout_id = 0x300A_030Fl
let number_of_range_shifters = 0x300A_0312l
let range_shifter_sequence = 0x300A_0314l
let range_shifter_number = 0x300A_0316l
let range_shifter_id = 0x300A_0318l
let range_shifter_type = 0x300A_0320l
let range_shifter_description = 0x300A_0322l
let number_of_lateral_spreading_devices = 0x300A_0330l
let lateral_spreading_device_sequence = 0x300A_0332l
let lateral_spreading_device_number = 0x300A_0334l
let lateral_spreading_device_id = 0x300A_0336l
let lateral_spreading_device_type = 0x300A_0338l
let lateral_spreading_device_description = 0x300A_033Al
let lateral_spreading_device_water_equivalent_thickness = 0x300A_033Cl
let number_of_range_modulators = 0x300A_0340l
let range_modulator_sequence = 0x300A_0342l
let range_modulator_number = 0x300A_0344l
let range_modulator_id = 0x300A_0346l
let range_modulator_type = 0x300A_0348l
let range_modulator_description = 0x300A_034Al
let beam_current_modulation_id = 0x300A_034Cl
let patient_support_type = 0x300A_0350l
let patient_support_id = 0x300A_0352l
let patient_support_accessory_code = 0x300A_0354l
let fixation_light_azimuthal_angle = 0x300A_0356l
let fixation_light_polar_angle = 0x300A_0358l
let meterset_rate = 0x300A_035Al
let range_shifter_settings_sequence = 0x300A_0360l
let range_shifter_setting = 0x300A_0362l
let isocenter_to_range_shifter_distance = 0x300A_0364l
let range_shifter_water_equivalent_thickness = 0x300A_0366l
let lateral_spreading_device_settings_sequence = 0x300A_0370l
let lateral_spreading_device_setting = 0x300A_0372l
let isocenter_to_lateral_spreading_device_distance = 0x300A_0374l
let range_modulator_settings_sequence = 0x300A_0380l
let range_modulator_gating_start_value = 0x300A_0382l
let range_modulator_gating_stop_value = 0x300A_0384l
let range_modulator_gating_start_water_equivalent_thickness = 0x300A_0386l
let range_modulator_gating_stop_water_equivalent_thickness = 0x300A_0388l
let isocenter_to_range_modulator_distance = 0x300A_038Al
let scan_spot_tune_id = 0x300A_0390l
let number_of_scan_spot_positions = 0x300A_0392l
let scan_spot_position_map = 0x300A_0394l
let scan_spot_meterset_weights = 0x300A_0396l
let scanning_spot_size = 0x300A_0398l
let number_of_paintings = 0x300A_039Al
let ion_tolerance_table_sequence = 0x300A_03A0l
let ion_beam_sequence = 0x300A_03A2l
let ion_beam_limiting_device_sequence = 0x300A_03A4l
let ion_block_sequence = 0x300A_03A6l
let ion_control_point_sequence = 0x300A_03A8l
let ion_wedge_sequence = 0x300A_03AAl
let ion_wedge_position_sequence = 0x300A_03ACl
let referenced_setup_image_sequence = 0x300A_0401l
let setup_image_comment = 0x300A_0402l
let motion_synchronization_sequence = 0x300A_0410l
let control_point_orientation = 0x300A_0412l
let general_accessory_sequence = 0x300A_0420l
let general_accessory_id = 0x300A_0421l
let general_accessory_description = 0x300A_0422l
let general_accessory_type = 0x300A_0423l
let general_accessory_number = 0x300A_0424l
let applicator_geometry_sequence = 0x300A_0431l
let applicator_aperture_shape = 0x300A_0432l
let applicator_opening = 0x300A_0433l
let applicator_opening_x = 0x300A_0434l
let applicator_opening_y = 0x300A_0435l
let source_to_applicator_mounting_position_distance = 0x300A_0436l
let referenced_rt_plan_sequence = 0x300C_0002l
let referenced_beam_sequence = 0x300C_0004l
let referenced_beam_number = 0x300C_0006l
let referenced_reference_image_number = 0x300C_0007l
let start_cumulative_meterset_weight = 0x300C_0008l
let end_cumulative_meterset_weight = 0x300C_0009l
let referenced_brachy_application_setup_sequence = 0x300C_000Al
let referenced_brachy_application_setup_number = 0x300C_000Cl
let referenced_source_number = 0x300C_000El
let referenced_fraction_group_sequence = 0x300C_0020l
let referenced_fraction_group_number = 0x300C_0022l
let referenced_verification_image_sequence = 0x300C_0040l
let referenced_reference_image_sequence = 0x300C_0042l
let referenced_dose_reference_sequence = 0x300C_0050l
let referenced_dose_reference_number = 0x300C_0051l
let brachy_referenced_dose_reference_sequence = 0x300C_0055l
let referenced_structure_set_sequence = 0x300C_0060l
let referenced_patient_setup_number = 0x300C_006Al
let referenced_dose_sequence = 0x300C_0080l
let referenced_tolerance_table_number = 0x300C_00A0l
let referenced_bolus_sequence = 0x300C_00B0l
let referenced_wedge_number = 0x300C_00C0l
let referenced_compensator_number = 0x300C_00D0l
let referenced_block_number = 0x300C_00E0l
let referenced_control_point_index = 0x300C_00F0l
let referenced_control_point_sequence = 0x300C_00F2l
let referenced_start_control_point_index = 0x300C_00F4l
let referenced_stop_control_point_index = 0x300C_00F6l
let referenced_range_shifter_number = 0x300C_0100l
let referenced_lateral_spreading_device_number = 0x300C_0102l
let referenced_range_modulator_number = 0x300C_0104l
let approval_status = 0x300E_0002l
let review_date = 0x300E_0004l
let review_time = 0x300E_0005l
let reviewer_name = 0x300E_0008l
let arbitrary = 0x4000_0010l
let text_comments = 0x4000_4000l
let results_id = 0x4008_0040l
let results_id_issuer = 0x4008_0042l
let referenced_interpretation_sequence = 0x4008_0050l
let report_production_status_trial = 0x4008_00FFl
let interpretation_recorded_date = 0x4008_0100l
let interpretation_recorded_time = 0x4008_0101l
let interpretation_recorder = 0x4008_0102l
let reference_to_recorded_sound = 0x4008_0103l
let interpretation_transcription_date = 0x4008_0108l
let interpretation_transcription_time = 0x4008_0109l
let interpretation_transcriber = 0x4008_010Al
let interpretation_text = 0x4008_010Bl
let interpretation_author = 0x4008_010Cl
let interpretation_approver_sequence = 0x4008_0111l
let interpretation_approval_date = 0x4008_0112l
let interpretation_approval_time = 0x4008_0113l
let physician_approving_interpretation = 0x4008_0114l
let interpretation_diagnosis_description = 0x4008_0115l
let interpretation_diagnosis_code_sequence = 0x4008_0117l
let results_distribution_list_sequence = 0x4008_0118l
let distribution_name = 0x4008_0119l
let distribution_address = 0x4008_011Al
let interpretation_id = 0x4008_0200l
let interpretation_id_issuer = 0x4008_0202l
let interpretation_type_id = 0x4008_0210l
let interpretation_status_id = 0x4008_0212l
let impressions = 0x4008_0300l
let results_comments = 0x4008_4000l
let low_energy_detectors = 0x4010_0001l
let high_energy_detectors = 0x4010_0002l
let detector_geometry_sequence = 0x4010_0004l
let threat_roi_voxel_sequence = 0x4010_1001l
let threat_roi_base = 0x4010_1004l
let threat_roi_extents = 0x4010_1005l
let threat_roi_bitmap = 0x4010_1006l
let route_segment_id = 0x4010_1007l
let gantry_type = 0x4010_1008l
let ooi_owner_type = 0x4010_1009l
let route_segment_sequence = 0x4010_100Al
let potential_threat_object_id = 0x4010_1010l
let threat_sequence = 0x4010_1011l
let threat_category = 0x4010_1012l
let threat_category_description = 0x4010_1013l
let atd_ability_assessment = 0x4010_1014l
let atd_assessment_flag = 0x4010_1015l
let atd_assessment_probability = 0x4010_1016l
let mass = 0x4010_1017l
let density = 0x4010_1018l
let z_effective = 0x4010_1019l
let boarding_pass_id = 0x4010_101Al
let center_of_mass = 0x4010_101Bl
let center_of_pto = 0x4010_101Cl
let bounding_polygon = 0x4010_101Dl
let route_segment_start_location_id = 0x4010_101El
let route_segment_end_location_id = 0x4010_101Fl
let route_segment_location_id_type = 0x4010_1020l
let abort_reason = 0x4010_1021l
let volume_of_pto = 0x4010_1023l
let abort_flag = 0x4010_1024l
let route_segment_start_time = 0x4010_1025l
let route_segment_end_time = 0x4010_1026l
let tdr_type = 0x4010_1027l
let international_route_segment = 0x4010_1028l
let threat_detection_algorithmand_version = 0x4010_1029l
let assigned_location = 0x4010_102Al
let alarm_decision_time = 0x4010_102Bl
let alarm_decision = 0x4010_1031l
let number_of_total_objects = 0x4010_1033l
let number_of_alarm_objects = 0x4010_1034l
let pto_representation_sequence = 0x4010_1037l
let atd_assessment_sequence = 0x4010_1038l
let tip_type = 0x4010_1039l
let dicos_version = 0x4010_103Al
let ooi_owner_creation_time = 0x4010_1041l
let ooi_type = 0x4010_1042l
let ooi_size = 0x4010_1043l
let acquisition_status = 0x4010_1044l
let basis_materials_code_sequence = 0x4010_1045l
let phantom_type = 0x4010_1046l
let ooi_owner_sequence = 0x4010_1047l
let scan_type = 0x4010_1048l
let itinerary_id = 0x4010_1051l
let itinerary_id_type = 0x4010_1052l
let itinerary_id_assigning_authority = 0x4010_1053l
let route_id = 0x4010_1054l
let route_id_assigning_authority = 0x4010_1055l
let inbound_arrival_type = 0x4010_1056l
let carrier_id = 0x4010_1058l
let carrier_id_assigning_authority = 0x4010_1059l
let source_orientation = 0x4010_1060l
let source_position = 0x4010_1061l
let belt_height = 0x4010_1062l
let algorithm_routing_code_sequence = 0x4010_1064l
let transport_classification = 0x4010_1067l
let ooi_type_descriptor = 0x4010_1068l
let total_processing_time = 0x4010_1069l
let detector_calibration_data = 0x4010_106Cl
let macparameterssequence = 0x4FFE_0001l
let curve_dimensions = 0x5000_0005l
let number_of_points = 0x5000_0010l
let type_of_data = 0x5000_0020l
let curve_description = 0x5000_0022l
let axis_units = 0x5000_0030l
let axis_labels = 0x5000_0040l
let data_value_representation = 0x5000_0103l
let minimum_coordinate_value = 0x5000_0104l
let maximum_coordinate_value = 0x5000_0105l
let curve_range = 0x5000_0106l
let curve_data_descriptor = 0x5000_0110l
let coordinate_start_value = 0x5000_0112l
let coordinate_step_value = 0x5000_0114l
let curve_activation_layer = 0x5000_1001l
let audio_type = 0x5000_2000l
let audio_sample_format = 0x5000_2002l
let number_of_channels = 0x5000_2004l
let number_of_samples = 0x5000_2006l
let sample_rate = 0x5000_2008l
let total_time = 0x5000_200Al
let audio_sample_data = 0x5000_200Cl
let audio_comments = 0x5000_200El
let curve_label = 0x5000_2500l
let curve_referenced_overlay_sequence = 0x5000_2600l
let curve_referenced_overlay_group = 0x5000_2610l
let curve_data = 0x5000_3000l
let shared_functional_groups_sequence = 0x5200_9229l
let per_frame_functional_groups_sequence = 0x5200_9230l
let waveform_sequence = 0x5400_0100l
let channel_minimum_value = 0x5400_0110l
let channel_maximum_value = 0x5400_0112l
let waveform_bits_allocated = 0x5400_1004l
let waveform_sample_interpretation = 0x5400_1006l
let waveform_padding_value = 0x5400_100Al
let waveform_data = 0x5400_1010l
let first_order_phase_correction_angle = 0x5600_0010l
let spectroscopy_data = 0x5600_0020l
let overlay_rows = 0x6000_0010l
let overlay_columns = 0x6000_0011l
let overlay_planes = 0x6000_0012l
let number_of_frames_in_overlay = 0x6000_0015l
let overlay_description = 0x6000_0022l
let overlay_type = 0x6000_0040l
let overlay_subtype = 0x6000_0045l
let overlay_origin = 0x6000_0050l
let image_frame_origin = 0x6000_0051l
let overlay_plane_origin = 0x6000_0052l
let overlay_compression_code = 0x6000_0060l
let overlay_compression_originator = 0x6000_0061l
let overlay_compression_label = 0x6000_0062l
let overlay_compression_description = 0x6000_0063l
let overlay_compression_step_pointers = 0x6000_0066l
let overlay_repeat_interval = 0x6000_0068l
let overlay_bits_grouped = 0x6000_0069l
let overlay_bits_allocated = 0x6000_0100l
let overlay_bit_position = 0x6000_0102l
let overlay_format = 0x6000_0110l
let overlay_location = 0x6000_0200l
let overlay_code_label = 0x6000_0800l
let overlay_number_of_tables = 0x6000_0802l
let overlay_code_table_location = 0x6000_0803l
let overlay_bits_for_code_word = 0x6000_0804l
let overlay_activation_layer = 0x6000_1001l
let overlay_descriptor_gray = 0x6000_1100l
let overlay_descriptor_red = 0x6000_1101l
let overlay_descriptor_green = 0x6000_1102l
let overlay_descriptor_blue = 0x6000_1103l
let overlays_gray = 0x6000_1200l
let overlays_red = 0x6000_1201l
let overlays_green = 0x6000_1202l
let overlays_blue = 0x6000_1203l
let roi_area = 0x6000_1301l
let roi_mean = 0x6000_1302l
let roi_standard_deviation = 0x6000_1303l
let overlay_label = 0x6000_1500l
let overlay_data = 0x6000_3000l
let overlay_comments = 0x6000_4000l
let pixel_data = 0x7FE0_0010l
let coefficients_sdvn = 0x7FE0_0020l
let coefficients_sdhn = 0x7FE0_0030l
let coefficients_sddn = 0x7FE0_0040l
let variable_pixel_data = 0x7F00_0010l
let variable_next_data_group = 0x7F00_0011l
let variable_coefficients_sdvn = 0x7F00_0020l
let variable_coefficients_sdhn = 0x7F00_0030l
let variable_coefficients_sddn = 0x7F00_0040l
let digital_signatures_sequence = 0xFFFA_FFFAl
let data_set_trailing_padding = 0xFFFC_FFFCl
end





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



