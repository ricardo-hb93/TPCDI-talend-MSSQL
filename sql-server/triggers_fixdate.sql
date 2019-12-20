use tpcdi
go

create trigger t_DimSecurity_fix_enddate
on DimSecurity
after INSERT, UPDATE
as
if exists (
	select * 
	from Inserted I 
	where I.EndDate = '9999-01-01')
begin
	update DimSecurity
	set EndDate = '9999-12-31'
	where SK_SecurityID in (select SK_SecurityID from Inserted)
end
go

create trigger t_DimCompany_fix_enddate
on DimCompany
after INSERT, UPDATE
as
if exists (
	select * 
	from Inserted I 
	where I.EndDate = '9999-01-01')
begin
	update DimCompany
	set EndDate = '9999-12-31'
	where SK_CompanyID in (select SK_CompanyID from Inserted)
end
go

create trigger t_DimAccount_fix_enddate
on DimAccount
after INSERT, UPDATE
as
if exists (
	select * 
	from Inserted I 
	where I.EndDate = '9999-01-01')
begin
	update DimAccount
	set EndDate = '9999-12-31'
	where SK_AccountID in (select SK_AccountID from Inserted)
end
go