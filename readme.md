Queries against ArchivesSpace
=============================
Queries in this repository are for 1.yale versions of ArchivesSpace with container management and accessions plug-ins installed, 1.4.2 with the same plug-ins, and 1.5. We've also written a handful of queries for non-Yale users using pre-1.5 versions without container management plug-ins

Queries against 1.yale
----------------------
 * AccessNotes.sql -- see all conditions governing access notes, plus machine-actionable restriction information
 * AccessionsFiscalYear.sql -- A report of all the accessions from a given fiscal year
 * Components4Display.sql -- oh hell. People encoded for display. 
 * ContainerProfiles.sql -- one way to see the given container profiles in a resource in csv format
 * CountAgentsCountSubjects.sql -- See resources with most agents and subjects associated (was more important before recent ASpace fix)
 * FindRangesAfterContainerMigration.sql -- See which containers have a dash (should indicate container range)
 * FrequentUsers.sql -- Counts of who created, updated records
 * MSSAAccessionWorkReport.sql -- see accessions that are new or in process

Queries against pre-1.5, no container management plug-in
--------------------------------------------------------
 * FindRangesBeforeContainerMigration.sql -- See which containers have a dash (should indicate container range)

Queries against 1.5
-------------------

Data monitoring reports
-----------------------
 * false top container report
 * date expression where normalize works
 * date expression != normalized
 * date not normalized
 * series unitid -- series string
 * series unitid -- arabic numeral
 * bibid -- present?
 * bibid -- check against Voyager for accuracy 
 * extent -- arabic numeral
 * extent -- check against preferred terms
 * date certainty attribute (report and/or nuke immediately)
 * filing title present
 * what's marked unpublished?
 * is the restrictions checkbox checked?
 * conditions governing access -- date or non-time-bound -- not both
 * ID for names/subjects
 * report on processing notes
 * container ranges?
 * finding aid status
 * resource type (nuke if present + remind any offenders not to use)
 * who's using archivesspace?