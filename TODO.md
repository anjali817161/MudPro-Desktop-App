# TODO List for Table and Dropdown Fixes

## Task 1: Remove Border from Text Fields in Editable Table
- [x] Edit lib/modules/dashboard/widgets/editable_table.dart to remove the border from TextFormField containers when unlocked

## Task 2: Investigate and Fix Dropdown Behavior
- [x] Analyze dropdown components in table sections (e.g., pump_dopdown_Cell.dart, well_tab_content.dart)
- [x] Identify why dropdowns are not working as expected
- [x] Implement fixes for dropdown functionality

## Task 3: Convert Specific Dropdowns to Text Fields
- [x] Convert "Operator Rep.", "Contractor Rep.", "FIT", "Formation" dropdowns to text fields in well_tab_content.dart

## Task 4: Make Middle and Right Section Tables Editable
- [x] Fix CasedHoleSection, OpenHoleSection, DrillStringSection tables to be editable when unlocked
- [x] Fix BitSection, NozzleSection, TimeDistributionSection tables to be editable when unlocked

## Task 5: Fix Empty Rows Functionality
- [ ] Ensure empty rows in all tables can be edited and new data can be added
