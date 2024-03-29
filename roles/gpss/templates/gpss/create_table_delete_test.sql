CREATE TABLE ibl.iiblcect001tm (
    ebnk_utzpe_no text NOT NULL,
    cdp_onld_dtm text NOT NULL,
    ebnk_ctr_stcd text NOT NULL,
    itcsno text,
    user_dscd text NOT NULL,
    ebnk_ctr_srno numeric,
    ebnk_ctr_dt text NOT NULL,
    ebnk_ctr_canc_dt text NOT NULL,
    pwno_rgs_dt text NOT NULL,
    ebnk_fst_usg_dt text NOT NULL,
    ebnk_fst_ctr_mng_brcd text NOT NULL,
    ebnk_ctr_mng_brcd text NOT NULL,
    bfch_mng_brcd text NOT NULL,
    mnbr_chg_dt text NOT NULL,
    ebnk_mnbr_chg_rncd text NOT NULL,
    pwno_ver text,
    ency_tp_txt text,
    ebnk_scrt_gdcd text NOT NULL,
    ebnk_twoch_crtf_yn text NOT NULL,
    splt_cerd_usg_yn text NOT NULL,
    pwno_ppad_rgs_yn text NOT NULL,
    pwno_ppad_rgs_dt text NOT NULL,
    pwno_ppad_chg_dt text NOT NULL,
    utzpe_pwno_chg_dt text NOT NULL,
    pwno_pst_rgs_tgt_yn text NOT NULL,
    chnl_act_rgs_uabl_yn text NOT NULL,
    mo_cop_ebnk_utzpe_no text,
    rgs_chnl_dscd text NOT NULL,
    anex_bnkg_yn text NOT NULL,
    ts_sms_crtf_dscd text NOT NULL,
    usg_tm_dscd text NOT NULL,
    scrt_md_dscd text NOT NULL,
    psn_bzpe_itcsno text,
    fee_dfpm_levy_yn text NOT NULL,
    ts_lmt_rdcm_yn text NOT NULL,
    psn_bzpe_yn text NOT NULL,
    bat_dfpm_levy_yn text NOT NULL,
    ebnk_rcv_dgn_dscd text NOT NULL,
    ebnk_inq_user_yn text NOT NULL,
    ltm_nuse_lim_yn text NOT NULL,
    spms_utzpe_yn text NOT NULL,
    ebnk_fst_usg_trn_cd text NOT NULL,
    lst_trn_dtm text NOT NULL,
    trn_log_srno text NOT NULL,
    lst_db_chg_id text NOT NULL,
    lst_db_chg_dtm text NOT NULL
)
WITH (appendonly='true', compresstype=zstd, compresslevel='7')
 DISTRIBUTED BY (ebnk_utzpe_no);
