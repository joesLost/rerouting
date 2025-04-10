/*Allaint Customer Reroute Listing*/ 
DECLARE @52WeekBegin DATE, @52WeekEnd Date
SET @52WeekBegin = DATEADD(week, -52, CURRENT_TIMESTAMP)
SET @52WeekEnd = CURRENT_TIMESTAMP
SELECT
	ricustmr.cu_id, 
	ricustmr.cu_branch [Branch], 
	ricustmr.cu_route [Current Route], 
	CASE WHEN cu_mon_route > 0 THEN 'M' ELSE '' END + 
	CASE WHEN cu_tue_route > 0 THEN 'T' ELSE '' END + 
	CASE WHEN cu_wed_route > 0 THEN 'W' ELSE '' END + 
	CASE WHEN cu_thu_route > 0 THEN 'R' ELSE '' END + 
	CASE WHEN cu_fri_route > 0 THEN 'F' ELSE '' END +
	CASE WHEN cu_sat_route > 0 THEN 'S' ELSE '' END +
	CASE WHEN cu_sun_route > 0 THEN 'U' ELSE '' END [Current Delivery Day],
	ricustmr.cu_account [Account], 
	ricustmr.cu_dept [Customer], 
	ricustmr.cu_name [Customer Name], 
	ricustmr.cu_addr1 [Street Address 1], 
	ricustmr.cu_addr2 [Street Address 2], 
	ricustmr.cu_city [City], 
	ricustmr.cu_state [State], 
	ricustmr.cu_zip [Zip], 
	TRIM(ricustmr.cu_freq) [Frequency],
	NULLIF(cu_monseq,0) [Mon Stop Seq], 
	NULLIF(cu_tueseq,0) [Tue Stop Seq], 
	NULLIF(cu_wedseq,0) [Wed Stop Seq], 
	NULLIF(cu_thuseq,0) [Thu Stop Seq], 
	NULLIF(cu_friseq,0) [Fri Stop Seq], 
	revenue.[Invoice Count] [Invoice Count], 
	garments.[Garment Inventory],
	CASE WHEN revenue.[Invoice Count] <> 0 THEN scans.[Garment Soil Scans] / revenue.[Invoice Count] ELSE 0 END[Average Weekly Garment Soil Scans],
	assigned.[Wearer Count],
	assigned.[Total Assigned Garments]
				
FROM            ricustmr LEFT OUTER JOIN
(
	-- Customer revenue
	SELECT			cu_ID, COUNT(hh_invoice) [Invoice Count]
	FROM            rainvhhd INNER JOIN
						ricustmr ON rainvhhd.hh_cuid = ricustmr.cu_ID
	WHERE			cu_stopdt = '1/1/1900' 
					AND cu_branch = @Branch
					AND hh_date BETWEEN @52WeekBegin AND @52WeekEnd
					AND rainvhhd.hh_redtdt IS NULL
					AND Dbo.ipcfn_inv_ttl(hh_invoice, hh_date, 0, 1) > 0
	GROUP BY		ricustmr.cu_id
			
) revenue on ricustmr.cu_id = revenue.cu_ID LEFT OUTER JOIN
(
	-- Garment inventory
	SELECT			ricustmr.cu_ID, 
					SUM(riempitm.ei_ras_qty) [Garment Inventory]
	FROM            ricustmr INNER JOIN
						riempitm ON ricustmr.cu_ID = riempitm.ei_CUID INNER JOIN
						riskugrp ON riempitm.ei_skugrup = riskugrp.sg_skugrup
	WHERE			ricustmr.cu_stopdt = '1/1/1900' 
					AND riempitm.ei_stop_dt = '1/1/1900' 
					AND sg_garment = 1 
					AND cu_branch = @Branch
	GROUP BY		ricustmr.cu_ID
) garments ON ricustmr.cu_id = garments.cu_ID LEFT OUTER JOIN
(
	--Garment Soil Scans
	SELECT			cu_id, COUNT(scanhist.as_barcode) [Garment Soil Scans]
	FROM			riskugrp INNER JOIN
							scanhist LEFT OUTER JOIN
							ingarmis ON ingarmis.is_garment = scanhist.as_barcode AND ingarmis.is_rfid = scanhist.as_rfid ON riskugrp.sg_skugrup = scanhist.as_sku INNER JOIN
							instatus ON scanhist.as_proc_st = instatus.st_code INNER JOIN
							riemploy ON scanhist.as_cuid = riemploy.em_cuid AND scanhist.as_empl = riemploy.em_empl INNER JOIN
							ricustmr ON scanhist.as_cuid = ricustmr.cu_ID AND scanhist.as_cuid = ricustmr.cu_ID INNER JOIN
							riempitm ON scanhist.as_cuid = riempitm.ei_CUID AND scanhist.as_empl = riempitm.ei_empl AND scanhist.as_sku = riempitm.ei_skugrup AND 
							scanhist.as_size_a = riempitm.ei_size_a AND scanhist.as_size_b = riempitm.ei_size_b
	WHERE			(scanhist.as_type = 'Count Station' OR
					scanhist.as_type LIKE 'Sorting System%' OR
					scanhist.as_type = 'Soil Count Posting') AND 
					scanhist.as_stat_dt BETWEEN @52WeekBegin AND @52WeekEnd
					AND scanhist.as_proc_st = 'I'
					AND cu_branch = @Branch
	GROUP BY		cu_id
) scans ON ricustmr.cu_id = scans.cu_ID LEFT OUTER JOIN
(
-- Pieces assigned and # of wearers
	SELECT			cu_id,
					COUNT(DISTINCT em_empl) [Wearer Count],
					COUNT(ingarmis.is_garment) [Total Assigned Garments]
	FROM            ricustmr INNER JOIN
						riempitm ON ricustmr.cu_ID = riempitm.ei_CUID INNER JOIN
						riskugrp ON riempitm.ei_skugrup = riskugrp.sg_skugrup INNER JOIN
						ingarmis ON riempitm.ei_CUID = ingarmis.is_CUID AND riempitm.ei_empl = ingarmis.is_empl AND riempitm.ei_skugrup = ingarmis.is_skugrup AND 
						riempitm.ei_size_a = ingarmis.is_size_a AND riempitm.ei_size_b = ingarmis.is_size_b AND riempitm.ei_duid = ingarmis.is_duid INNER JOIN
						riemploy ON ricustmr.cu_ID = riemploy.em_cuid AND riempitm.ei_CUID = riemploy.em_cuid AND riempitm.ei_empl = riemploy.em_empl AND 
						riempitm.ei_duid = riemploy.em_duid
	WHERE			cu_stopdt = '1/1/1900' 
					AND em_stop_dt = '1/1/1900' 
					AND ei_stop_dt = '1/1/1900' 
					AND is_proc_st != 'c' 
					AND cu_branch = @Branch
	GROUP BY		cu_id
) assigned ON ricustmr.cu_id = assigned.cu_ID
WHERE			cu_stopdt = '1/1/1900' 
				AND cu_branch = @Branch 
				AND cu_route IN (SELECT value FROM STRING_SPLIT(@routes, ','))
ORDER BY		cu_account, 
				cu_dept