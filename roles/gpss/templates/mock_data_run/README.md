### Generating mock data for json
https://medium.com/@rahulsmtauti/mock-data-generation-for-data-projects-3999865cb82c

~~~
$ brew install pyenv
$ mkdir mock_data_run
$ cd mock_data_run
$ pyenv install 3.10
$ pip install mock-data-generator
~~~

~~~
Create a subfolder under mock_data_run and place below employee.json and department.json under schemas directory.
The data generator is using standard providers from Faker. Hence, we can specify the column types which are more close to real world datasets.
Support field types are:
Note: The data types are case insensitive.
~~~

~~~
"STRING","INT","INTEGER","NUMBER","FLOAT","DATE","BOOLEAN","BOOL","TIMESTAMP",
"ADDRESS","CITY","COUNTRY","COUNTRY_CODE","POSTCODE","LICENSE_PLATE","SWIFT",
"COMPANY","COMPANY_SUFFIX","CREDIT_CARD","CREDIT_CARD_PROVIDER",
"CREDIT_CARD_NUMBER","CURRENCY","DAY_NUM","DAY_NAME","MONTH_NUM",
"MONTH_NAME","YEAR","COORDINATE","LATITUDE","LONGITUDE","EMAIL",
"HOSTNAME","IPV4","IPV6","URI","URL","JOB","TEXT","PASSWORD",
"SHA1","SHA256","UUID","PASSPORT_NUMBER","NAME","LANGUAGE_NAME",
"LAST_NAME","FIRST_NAME","PHONE_NUMBER","SSN"
~~~


$ generate --input_json_schema_path=./woori_mock_data.json --output_file_format=json --output_path=./data

$ head -n +1 woori_mock_data_data_source.json/data.json 
~~~
{"ebnk_utzp":"Foreign gas left whole. Operation natural debate assume but quickly. Issue section lawyer scientist continue interesting choice let.","ebnk_ctr_stcd":"Form stay amount. Wear be receive necessary. History realize there day ball though forward. Mention exactly blue during.","itcsno text":"Would parent hotel carry house source. Rich and letter Mr surface star.","user_dscd":"Bar book production. Like state above hear though. Feeling question often.\nWear government skill million for gas. Able get court often.\nState down hear. Call head see past.","ebnk_ctr_dt":"Area part that. Face really tax suffer.\nReport less war throw believe. Special participant heavy onto.\nLate instead which future. Maybe half option water.","ebnk_ctr_canc_dt":"Near produce guess read. Team performance type mouth. Fish which improve outside place man first.","pwno_rgs_dt":"Step life then book. Now if line officer. Happen purpose debate truth friend.\nRisk often together citizen camera until city car. Court city write at wait rule.","ebnk_fst_usg_dt":"Southern view live until less TV history. Moment example throw street will final.\nPolice team money cup give hold fight. Most safe little money go report hour.","ebnk_fst_ctr_mng_brcd":"Save so money source. Statement full community interesting physical all.","ebnk_ctr_mng_brcd":"Two start despite condition step sort want usually.\nData bar different admit ever. Either one site police.\nFactor you process upon down of sell. Describe more serious of inside table catch effort.","spms_utzpe_yn":"Positive nothing since south. Wait property them benefit cup safe.\nFall society common first general officer toward. Issue else them lot rock lay simple.","ebnk_fst_usg_trn_cd":"Half him history attorney garden bill. Board stand out argue. Run trip help sometimes. Always compare president.","lst_trn_dtm":"Successful walk popular writer treat. Price radio kitchen child natural carry.\nGirl year budget minute lose. True figure exist receive attorney commercial discussion.","trn_log_srno":"Fall have free debate south customer. Sea ago else garden including life. Usually risk several firm.","lst_db_chg_id":"Off stand imagine ago yourself. Despite wall girl house most. Walk doctor news subject.\nEnter board investment future lead pick serve. Expert eye agent bed phone.","lst_db_chg_dtm":"Water act financial party maintain. Reason attention he sometimes.\nIncrease adult life daughter fall glass military."}
~~~

