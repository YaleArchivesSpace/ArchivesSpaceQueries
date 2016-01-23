Queries against ArchivesSpace
=============================
Queries in this repository are for 1.yale versions of ArchivesSpace with container management and accessions plug-ins installed, 1.4.2 with the same plug-ins, and 1.5. We've also written a handful of queries for non-Yale users using pre-1.5 versions without container management plug-ins

Queries against pre-1.5, no container management plug-in
--------------------------------------------------------
 * [CreateCandidates.sql](https://github.com/YaleArchivesSpace/ArchivesSpaceQueries/blob/master/ContainerConversion/CreateCandidates.sql) -- The first step for checking problems with barcodes and locations before converting to top container model
 * [ProblemBarcodes.sql](https://github.com/YaleArchivesSpace/ArchivesSpaceQueries/blob/master/ContainerConversion/ProblemBarcodes.sql) -- This report will reveal which barcodes have been assigned to more than one container. These must be fixed before conversion. CreateCandidates.sql needs to be run to create a temporary table before this report will work.
 * [QuantumContainers.sql](https://github.com/YaleArchivesSpace/ArchivesSpaceQueries/blob/master/ContainerConversion/QuantumContainers.sql) -- This report will reveal cases where the same container has been assigned to more than one location. This isn't physically possible! These need to be fixed before conversion. CreateCandidates.sql needs to be run to create a temporary table before this report will work.
 * [FindRangesBeforeContainerMigration.sql](https://github.com/YaleArchivesSpace/ArchivesSpaceQueries/blob/master/1.4.2/FindRangesBeforeContainerMigration.sql) -- See which containers have a dash (should indicate container range)

Queries against 1.yale
----------------------
 * [AccessNotes.sql](https://github.com/YaleArchivesSpace/ArchivesSpaceQueries/blob/master/1.yale/AccessNotes.sql) -- see all conditions governing access notes, plus machine-actionable restriction information
 * [AccessionsFiscalYear.sql](https://github.com/YaleArchivesSpace/ArchivesSpaceQueries/blob/master/1.yale/AccessionsFiscalYear.sql) -- A report of all the accessions from a given fiscal year
 * Components4Display.sql -- oh hell. People encoded for display. 
 * ContainerProfiles.sql -- one way to see the given container profiles in a resource in csv format
 * CountAgentsCountSubjects.sql -- See resources with most agents and subjects associated (was more important before recent ASpace fix)
 * FindRangesAfterContainerMigration.sql -- See which containers have a dash (should indicate container range)
 * MSSAAccessionWorkReport.sql -- see accessions that are new or in process

Queries against 1.5
-------------------

Data monitoring reports
-----------------------
 * [TopContainers2Merge.sql](https://github.com/YaleArchivesSpace/ArchivesSpaceQueries/blob/master/Data%20Monitoring/TopContainers2Merge.sql) false top container report
 * date expression where normalize works
 * date expression != normalized
 * date not normalized
 * [SeriesStringInUnitid.sql](https://github.com/YaleArchivesSpace/ArchivesSpaceQueries/blob/master/Data%20Monitoring/SeriesStringInUnitid.sql) -- report of all series unitids that have the string "series"
 * [UnitidNotArabic.sql](https://github.com/YaleArchivesSpace/ArchivesSpaceQueries/blob/master/Data%20Monitoring/UnitidNotArabic.sql) -- UnitID at series level is not an Arabic numeral
 * [NoBIBID.sql](https://github.com/YaleArchivesSpace/ArchivesSpaceQueries/blob/master/Data%20Monitoring/NoBIBID.sql) -- No bibid resent in resource record
 * bibid -- check against Voyager for accuracy 
 * extent -- arabic numeral
 * extent -- check against preferred terms
 * [Certainty.sql](https://github.com/YaleArchivesSpace/ArchivesSpaceQueries/blob/master/Data%20Monitoring/Certainty.sql) We don't want date certainty attributes
 * filing title present
 * what's marked unpublished?
 * is the restrictions checkbox checked?
 * conditions governing access -- date or non-time-bound -- not both
 * [NamesSubjectsNoIDs.sql](https://github.com/YaleArchivesSpace/ArchivesSpaceQueries/blob/master/Data%20Monitoring/NamesSubjectsNoIDs.sql) We want for all of our names and subjects to be reconciled to authorities -- these ones don't have an authority link
 * report on processing notes
 * container ranges?
 * finding aid status
 * resource type (nuke if present + remind any offenders not to use) 
 * [FrequentUsers.sql](https://github.com/YaleArchivesSpace/ArchivesSpaceQueries/blob/master/Data%20Monitoring/FrequentUsers.sql) -- Counts of who created, updated records
