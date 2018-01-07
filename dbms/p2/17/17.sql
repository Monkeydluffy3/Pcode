/*
    17. Database Trigger (All Types: Row level and Statement level triggers,
    Before and After Triggers). Write a database trigger on Library table.
     The System should keep track of the records that are being updated or deleted. 
     The old value of updated or deleted records should be added in Library_Audit table. 



 PL/SQL trigger define using CREATE TRIGGER statement.

CREATE [OR REPLACE] TRIGGER trigger_name		
	BEFORE | AFTER
	[INSERT, UPDATE, DELETE [COLUMN NAME..]
	ON table_name

	Referencing [ OLD AS OLD | NEW AS NEW ]
	FOR EACH ROW | FOR EACH STATEMENT [ WHEN Condition ]

DECLARE
    [declaration_section
	    variable declarations;
	    constant declarations;
    ]

BEGIN
	[executable_section
		PL/SQL execute/subprogram body
    ]

EXCEPTION
    [exception_section
		PL/SQL Exception block
    ]

END;

Syntax Description

    CREATE [OR REPLACE] TRIGGER trigger_name : Create a trigger with the given name. If already have overwrite the existing trigger with defined same name.

    BEFORE | AFTER : Indicates when the trigger get fire. BEFORE trigger execute before when statement execute before. AFTER trigger execute after the statement execute.

    [INSERT, UPDATE, DELETE [COLUMN NAME..] : Determines the performing trigger event. You can define more then one triggering event separated by OR keyword.

    ON table_name : Define the table name to performing trigger event.

    Referencing [ OLD AS OLD | NEW AS NEW ] : Give referencing to a old and new values of the data. :old means use existing row to perform event and :new means use executing new row to perform event. You can set referencing names user define name from old (or new).
    You can't referencing old values when inserting a record, or new values when deleting a record, because It's does not exist.

    FOR EACH ROW | FOR EACH STATEMENT : Trigger must fire when each row gets Affected (ROW Trigger). and fire only once when the entire sql statement is execute (STATEMENT Trigger).

    WHEN Condition : Optional. Use only for row level trigger. Trigger fire when specified condition is satisfy.

*/




create table Library(bno number(5), bname varchar(15), author varchar(15), allowed_days number(5));

insert into Library values(1,'phy','tks',10);
insert into Library values(2,'chem','pradeep',7);
insert into Library values(3,'gk','arihant',7);

create table library_audit(bno number(5), old_allowed_days number(5), new_allowed_days number(5));



CREATE OR REPLACE TRIGGER tr
 before INSERT or UPDATE or DELETE on Library
 for each row
BEGIN
 insert into library_audit values(:new.bno, :old.allowed_days, :new.allowed_days);
END;
/