EXPLAIN create table edm_stage.ticket_intake_date as
select cpn.* from 
(select cpn.* ,rank() over (partition by cpn.document_number, cpn.coupon_number, cpn.ticket_issue_date order by cpn.effective_from_ts ) rnk from  edm.fact_ticket_coupon_snapshot cpn
inner join ref_history.ref_coupon_status_hist sts
on case when cpn.coupon_status_code='VOID' then 'OK' else cpn.coupon_status_code end = sts.coupon_status_code---to handle VOID and create a history for sale record
where sts.revenue_released_yn = 'N'
and sts.elf_end_dt = '9999-12-31 23:59:59'
) cpn
where cpn.rnk=1 ;
