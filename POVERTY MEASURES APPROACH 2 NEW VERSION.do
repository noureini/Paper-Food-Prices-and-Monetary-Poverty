************* Approche 2 : Structures et fonctions calés sur toute l'année et par région*************


***************///***********************///****************
*******************************AVEC PRIX MIN****************
***************///***********************///****************

***************** Variable de niveau des vies************

*****Annuel 

gen depr_min_ae_an = dep_min_menage_an/(indice_prix_min_an*ae)
gen depr_min_ae_jr = (depr_min_ae_an)/365

******* ssf 
gen depr_min_ae_ssf = dep_min_menage_ssf/(indice_prix_min_ssf_new*ae)
gen depr_min_ae_jr_ssf = (depr_min_ae_ssf*3)/365

****** ssc
gen depr_min_ae_ssc = dep_min_menage_ssc/(indice_prix_min_ssc_new*ae)
gen depr_min_ae_jr_ssc = (depr_min_ae_ssc*3)/365

**** sp
gen depr_min_ae_sp = dep_min_menage_sp/(indice_prix_min_sp_new*ae)
gen depr_min_ae_jr_sp = (depr_min_ae_sp*3)/365

************* Structure : Groupe de référence ****** 
sum depr_min_ae_an  [aw=weight_ae_nat],d 
scalar pauvr_min_an=r(p50)

gen group_ref_min_menage=(depr_min_ae_an<pauvr_min_an)

****** Strucutre : Caractéristiques du groupe de référence******

sum taille_menage if group_ref_min_menage==1 [aw=weight_hh],d
scalar moy_tail_menage_nat_mingr=r(mean)

sum ae if group_ref_min_menage==1 [aw=weight_hh],d
scalar moy_ae_menage_nat_mingr=r(mean)

sum taille_menage if group_ref_min_menage==1 & dummy_sud==0 [aw=weight_hh],d
scalar moy_tail_menage_nord_mingr=r(mean)

sum ae if group_ref_min_menage==1 & dummy_sud==0 [aw=weight_hh],d
scalar moy_ae_menage_nord_mingr=r(mean)

sum taille_menage if group_ref_min_menage==1 & dummy_sud==1 [aw=weight_hh],d
scalar moy_tail_menage_sud_mingr=r(mean)

sum ae if group_ref_min_menage==1 & dummy_sud==1 [aw=weight_hh],d
scalar moy_ae_menage_sud_mingr=r(mean)


*********Dépense alimentaire par jour pour les groupes de référence

******** Annuel 

gen depr_min_alim_an=dep_min_alim_pl1_an/indice_prix_min_an

gen depr_min_alim_jr =depr_min_alim_an/365

sum depr_min_alim_jr if group_ref_min_menage==1 [aw=weight_hh],d
scalar moy_depr_min_alim_nat_an=r(mean)

sum depr_min_alim_jr if group_ref_min_menage==1 & dummy_sud==0 [aw=weight_hh],d
scalar moy_depr_min_alim_nord_an=r(mean)

sum depr_min_alim_jr if group_ref_min_menage==1 & dummy_sud==1 [aw=weight_hh],d
scalar moy_depr_min_alim_sud_an=r(mean)

********* ssf

gen depr_min_alim_ssf=dep_min_alim_pl1_ssf/indice_prix_min_ssf_new

gen depr_min_alim_jr_ssf =(depr_min_alim_ssf*3)/365

sum depr_min_alim_jr_ssf if group_ref_min_menage==1 [aw=weight_hh],d
scalar moy_depr_min_alim_nat_ssf=r(mean)

sum depr_min_alim_jr_ssf if group_ref_min_menage==1 & dummy_sud==0 [aw=weight_hh],d
scalar moy_depr_min_alim_nord_ssf=r(mean)

sum depr_min_alim_jr_ssf if group_ref_min_menage==1 & dummy_sud==1 [aw=weight_hh],d
scalar moy_depr_min_alim_sud_ssf=r(mean)


********* ssc

gen depr_min_alim_ssc=dep_min_alim_pl1_ssc/indice_prix_min_ssc_new

gen depr_min_alim_jr_ssc =(depr_min_alim_ssc*3)/365

sum depr_min_alim_jr_ssc if group_ref_min_menage==1 [aw=weight_hh],d
scalar moy_depr_min_alim_nat_ssc=r(mean)

sum depr_min_alim_jr_ssc if group_ref_min_menage==1 & dummy_sud==0 [aw=weight_hh],d
scalar moy_depr_min_alim_nord_ssc=r(mean)

sum depr_min_alim_jr_ssc if group_ref_min_menage==1 & dummy_sud==1 [aw=weight_hh],d
scalar moy_depr_min_alim_sud_ssc=r(mean)


********* sp

gen depr_min_alim_sp=dep_min_alim_pl1_sp/indice_prix_min_sp_new

gen depr_min_alim_jr_sp =(depr_min_alim_sp*3)/365

sum depr_min_alim_jr_sp if group_ref_min_menage==1 [aw=weight_hh],d
scalar moy_depr_min_alim_nat_sp=r(mean)

sum depr_min_alim_jr_sp if group_ref_min_menage==1 & dummy_sud==0 [aw=weight_hh],d
scalar moy_depr_min_alim_nord_sp=r(mean)

sum depr_min_alim_jr_sp if group_ref_min_menage==1 & dummy_sud==1 [aw=weight_hh],d
scalar moy_depr_min_alim_sud_sp=r(mean)


********* Montant calorique moyen du groupe de référence 

gen eng_calo_tot_jr =eng_calo_tot/365

sum eng_calo_tot_jr if group_ref_min_menage==1 [aw=weight_hh],d
scalar eng_calo_tot_nat_mingr_jr=r(mean)

sum eng_calo_tot_jr if group_ref_min_menage==1 & dummy_sud==0 [aw=weight_hh],d
scalar eng_calo_tot_nord_mingr_jr=r(mean)

sum eng_calo_tot_jr if group_ref_min_menage==1 & dummy_sud==1 [aw=weight_hh],d
scalar eng_calo_tot_sud_mingr_jr=r(mean)

************ Seuil de pauvreté alimentaire 

scalar mincal=2700

*********** Annuel et saisons (ssf, ssc et sp)

******** Niveau National********* 

gen za_min_nat_an =(mincal*(moy_depr_min_alim_nat_an/eng_calo_tot_nat_mingr_jr))*(moy_ae_menage_nat_mingr/moy_tail_menage_nat_mingr)

gen za_min_nat_ssf =(mincal*(moy_depr_min_alim_nat_ssf/eng_calo_tot_nat_mingr_jr))*(moy_ae_menage_nat_mingr/moy_tail_menage_nat_mingr)

gen za_min_nat_ssc =(mincal*(moy_depr_min_alim_nat_ssc/eng_calo_tot_nat_mingr_jr))*(moy_ae_menage_nat_mingr/moy_tail_menage_nat_mingr)

gen za_min_nat_sp =(mincal*(moy_depr_min_alim_nat_sp/eng_calo_tot_nat_mingr_jr))*(moy_ae_menage_nat_mingr/moy_tail_menage_nat_mingr)

********** Nord********

gen za_min_nord_an =(mincal*(moy_depr_min_alim_nord_an/eng_calo_tot_nord_mingr_jr))*(moy_ae_menage_nord_mingr/moy_tail_menage_nord_mingr)

gen za_min_nord_ssf =(mincal*(moy_depr_min_alim_nord_ssf/eng_calo_tot_nord_mingr_jr))*(moy_ae_menage_nord_mingr/moy_tail_menage_nord_mingr)

gen za_min_nord_ssc =(mincal*(moy_depr_min_alim_nord_ssc/eng_calo_tot_nord_mingr_jr))*(moy_ae_menage_nord_mingr/moy_tail_menage_nord_mingr)

gen za_min_nord_sp =(mincal*(moy_depr_min_alim_nord_sp/eng_calo_tot_nord_mingr_jr))*(moy_ae_menage_nord_mingr/moy_tail_menage_nord_mingr)


********** Sud********

gen za_min_sud_an =(mincal*(moy_depr_min_alim_sud_an/eng_calo_tot_sud_mingr_jr))*(moy_ae_menage_sud_mingr/moy_tail_menage_sud_mingr)

gen za_min_sud_ssf =(mincal*(moy_depr_min_alim_sud_ssf/eng_calo_tot_sud_mingr_jr))*(moy_ae_menage_sud_mingr/moy_tail_menage_sud_mingr)

gen za_min_sud_ssc =(mincal*(moy_depr_min_alim_sud_ssc/eng_calo_tot_sud_mingr_jr))*(moy_ae_menage_sud_mingr/moy_tail_menage_sud_mingr)

gen za_min_sud_sp =(mincal*(moy_depr_min_alim_sud_sp/eng_calo_tot_sud_mingr_jr))*(moy_ae_menage_sud_mingr/moy_tail_menage_sud_mingr)



****** Extrapolation de la ligne de pauvreté alimentaire

******************Estimation de la courbe courbe d'Engel annuel et au niveau national 

gen part_dep_alim_min_an=dep_min_alim_pl1_an/dep_min_menage_an
gen lae=ln(ae)

**** Pour l'ensemble des ménages et par an et au niveau national

gen depr_min_menage_an=dep_min_menage_an/indice_prix_min_an

gen depr_min_menage_jr = depr_min_menage_an/365
gen lxi_za_min = ln(depr_min_menage_jr)
gen lxi_za_min2 = lxi_za_min^2

********** POUR LE NIVEAU NATIONAL*************

reg part_dep_alim_min_an lxi_za_min lxi_za_min2 lae dummy_sud [aw=weight_hh], vce(robust)

gen z_b_min_nat=_b[lxi_za_min]

gen z_b_min_nat2=_b[lxi_za_min2]

margins,at(lxi_za_min=0 lxi_za_min2=0) atmeans post

margins,coeflegend

gen aj_min_nat=_b[_cons]
 

********* La méthode bisection pour trouver la ligne de pauvreté absolue. 

***** Pour l'année

program define myz_min_an 
scalar A=za_min_nat_an*moy_tail_menage_nat_mingr
scalar f_z= z_b_min_nat*ln(`1')+aj_min_nat+z_b_min_nat2*[ln(`1')]^2 -(A/`1')
end 

bisect myz_min_an X returns exp f_z=0 from 200 to 2000

**** La solution est : 1021.065 que l'on divisera par moy_ae_menage_nat_mingr, ce qui donne z_min_nat=242.17

gen z_min_nat=242.17


****** Pour SSF

program define myz_min_ssf 
scalar A_ssf=za_min_nat_ssf*moy_tail_menage_nat_mingr
scalar f_z= z_b_min_nat*ln(`1')+aj_min_nat+z_b_min_nat2*[ln(`1')]^2 -(A_ssf/`1')
end 

bisect myz_min_ssf X returns exp f_z=0 from 200 to 2000

**** La solution est : 464.7448 que l'on divisera par moy_ae_menage_nat_mingr, ce qui donne z_min_nat_ssf=110.23

gen z_min_nat_ssf=110.23


******** Pour SSC

program define myz_min_ssc 
scalar A_ssc=za_min_nat_ssc*moy_tail_menage_nat_mingr
scalar f_z= z_b_min_nat*ln(`1')+aj_min_nat+z_b_min_nat2*[ln(`1')]^2 -(A_ssc/`1')
end 

bisect myz_min_ssc X returns exp f_z=0 from 200 to 2000

**** La solution est : 489.7129 que l'on divisera par moy_ae_menage_nat_mingr, ce qui donne z_min_nat_ssc=116.14

gen z_min_nat_ssc=116.14


******** Pour SP

program define myz_min_sp 
scalar A_sp=za_min_nat_sp*moy_tail_menage_nat_mingr
scalar f_z= z_b_min_nat*ln(`1')+aj_min_nat+z_b_min_nat2*[ln(`1')]^2 -(A_sp/`1')
end 

bisect myz_min_sp X returns exp f_z=0 from 200 to 2000

**** La solution est :  493.5049 que l'on divisera par moy_ae_menage_nat_mingr, ce qui donne z_min_nat_sp=117.05

gen z_min_nat_sp=117.05


********** POUR LE NORD*************

reg part_dep_alim_min_an lxi_za_min lxi_za_min2 lae if dummy_sud==0 [aw=weight_hh], vce(robust)

gen z_b_min_nord=_b[lxi_za_min]

gen z_b_min_nord2=_b[lxi_za_min2]

margins,at(lxi_za_min=0 lxi_za_min2=0) atmeans post

margins,coeflegend

gen aj_min_nord=_b[_cons]

********* Pour l'ANNEE 

program define myz_min_nord_an 
scalar A_nord=za_min_nord_an*moy_tail_menage_nord_mingr
scalar f_z= z_b_min_nord*ln(`1')+aj_min_nord+z_b_min_nord2*[ln(`1')]^2 -(A_nord/`1')
end 

bisect myz_min_nord_an X returns exp f_z=0 from 200 to 2000

**** La solution est : 922.1708 que l'on divisera par moy_ae_menage_nord_mingr, ce qui donne z_min_nord=239.58

gen z_min_nord=239.58


****** Pour SSF

program define myz_min_nord_ssf 
scalar A_nord_ssf=za_min_nord_ssf*moy_tail_menage_nord_mingr
scalar f_z= z_b_min_nord*ln(`1')+aj_min_nord+z_b_min_nord2*[ln(`1')]^2 -(A_nord_ssf/`1')
end 

bisect myz_min_nord_ssf X returns exp f_z=0 from 200 to 2000

**** La solution est : 845.74 que l'on divisera par moy_ae_menage_nord_mingr, ce qui donne z_min_nord_ssf=219.72

gen z_min_nord_ssf=219.72


******** Pour SSC

program define myz_min_nord_ssc 
scalar A_nord_ssc=za_min_nord_ssc*moy_tail_menage_nord_mingr
scalar f_z= z_b_min_nord*ln(`1')+aj_min_nord+z_b_min_nord2*[ln(`1')]^2 -(A_nord_ssc/`1')
end 

bisect myz_min_nord_ssc X returns exp f_z=0 from 200 to 2000

**** La solution est : 1003.276 que l'on divisera par moy_ae_menage_nord_mingr, ce qui donne z_min_nord_ssc=260.65

gen z_min_nord_ssc=260.65


******** Pour SP

program define myz_min_nord_sp 
scalar A_nord_sp=za_min_nord_sp*moy_tail_menage_nord_mingr
scalar f_z= z_b_min_nord*ln(`1')+aj_min_nord+z_b_min_nord2*[ln(`1')]^2 -(A_nord_sp/`1')
end 

bisect myz_min_nord_sp X returns exp f_z=0 from 200 to 2000

**** La solution est : 1007.378 que l'on divisera par moy_ae_menage_nord_mingr, ce qui donne z_min_nord_sp=261.71

gen z_min_nord_sp=261.71


********** POUR LE SUD*************

reg part_dep_alim_min_an lxi_za_min lxi_za_min2 lae if dummy_sud==1 [aw=weight_hh], vce(robust)

gen z_b_min_sud=_b[lxi_za_min]

gen z_b_min_sud2=_b[lxi_za_min2]

margins,at(lxi_za_min=0 lxi_za_min2=0) atmeans post

margins,coeflegend

gen aj_min_sud=_b[_cons]

********* Pour l'ANNEE 

program define myz_min_sud_an 
scalar A_sud=za_min_sud_an*moy_tail_menage_sud_mingr
scalar f_z= z_b_min_sud*ln(`1')+aj_min_sud+z_b_min_sud2*[ln(`1')]^2 -(A_sud/`1')
end 

bisect myz_min_sud_an X returns exp f_z=0 from 200 to 2000

**** La solution est :  1103.306 que l'on divisera par moy_ae_menage_sud_mingr, ce qui donne z_min_sud=244.50

gen z_min_sud=244.50


****** Pour SSF

program define myz_min_sud_ssf 
scalar A_sud_ssf=za_min_sud_ssf*moy_tail_menage_sud_mingr
scalar f_z= z_b_min_sud*ln(`1')+aj_min_sud+z_b_min_sud2*[ln(`1')]^2 -(A_sud_ssf/`1')
end 

bisect myz_min_sud_ssf X returns exp f_z=0 from 200 to 2000

**** La solution est : 1091.244 que l'on divisera par moy_ae_menage_sud_mingr, ce qui donne z_min_sud_ssf=241.83

gen z_min_sud_ssf=241.83


******** Pour SSC

program define myz_min_sud_ssc 
scalar A_sud_ssc=za_min_sud_ssc*moy_tail_menage_sud_mingr
scalar f_z= z_b_min_sud*ln(`1')+aj_min_sud+z_b_min_sud2*[ln(`1')]^2 -(A_sud_ssc/`1')
end 

bisect myz_min_sud_ssc X returns exp f_z=0 from 200 to 2000

**** La solution est : 1083.124 que l'on divisera par moy_ae_menage_sud_mingr, ce qui donne z_min_sud_ssc=240.03

gen z_min_sud_ssc=240.03


******** Pour SP

program define myz_min_sud_sp 
scalar A_sud_sp=za_min_sud_sp*moy_tail_menage_sud_mingr
scalar f_z= z_b_min_sud*ln(`1')+aj_min_sud+z_b_min_sud2*[ln(`1')]^2 -(A_sud_sp/`1')
end 

bisect myz_min_sud_sp X returns exp f_z=0 from 200 to 2000

**** La solution est : 1246.41 que l'on divisera par moy_ae_menage_sud_mingr, ce qui donne z_min_sud_sp=276.21

gen z_min_sud_sp=276.21


*******************************///************************////***********

***************************AVEC PRIX MAX*********************************

*******************************///************************////***********

***************** Variable de niveau des vies************

*****Annuel 

gen depr_max_ae_an = dep_max_menage_an/(indice_prix_max_an*ae)
gen depr_max_ae_jr = (depr_max_ae_an)/365

******* ssf 
gen depr_max_ae_ssf = dep_max_menage_ssf/(indice_prix_max_ssf_new*ae)
gen depr_max_ae_jr_ssf = (depr_max_ae_ssf*3)/365

****** ssc
gen depr_max_ae_ssc = dep_max_menage_ssc/(indice_prix_max_ssc_new*ae)
gen depr_max_ae_jr_ssc = (depr_max_ae_ssc*3)/365

**** sp
gen depr_max_ae_sp = dep_max_menage_sp/(indice_prix_max_sp_new*ae)
gen depr_max_ae_jr_sp = (depr_max_ae_sp*3)/365

************* Structure : Groupe de référence ****** 
sum depr_max_ae_an  [aw=weight_ae_nat],d 
scalar pauvr_max_an=r(p50)

gen group_ref_max_menage=(depr_max_ae_an<pauvr_max_an)

****** Strucutre : Caractéristiques du groupe de référence******

sum taille_menage if group_ref_max_menage==1 [aw=weight_hh],d
scalar moy_tail_menage_nat_maxgr=r(mean)

sum ae if group_ref_max_menage==1 [aw=weight_hh],d
scalar moy_ae_menage_nat_maxgr=r(mean)

sum taille_menage if group_ref_max_menage==1 & dummy_sud==0 [aw=weight_hh],d
scalar moy_tail_menage_nord_maxgr=r(mean)

sum ae if group_ref_max_menage==1 & dummy_sud==0 [aw=weight_hh],d
scalar moy_ae_menage_nord_maxgr=r(mean)

sum taille_menage if group_ref_max_menage==1 & dummy_sud==1 [aw=weight_hh],d
scalar moy_tail_menage_sud_maxgr=r(mean)

sum ae if group_ref_max_menage==1 & dummy_sud==1 [aw=weight_hh],d
scalar moy_ae_menage_sud_maxgr=r(mean)


*********Dépense alimentaire par jour pour les groupes de référence

******** Annuel 

gen depr_max_alim_an=dep_max_alim_pl1_an/indice_prix_max_an

gen depr_max_alim_jr =depr_max_alim_an/365

sum depr_max_alim_jr if group_ref_max_menage==1 [aw=weight_hh],d
scalar moy_depr_max_alim_nat_an=r(mean)

sum depr_max_alim_jr if group_ref_max_menage==1 & dummy_sud==0 [aw=weight_hh],d
scalar moy_depr_max_alim_nord_an=r(mean)

sum depr_max_alim_jr if group_ref_max_menage==1 & dummy_sud==1 [aw=weight_hh],d
scalar moy_depr_max_alim_sud_an=r(mean)

********* ssf

gen depr_max_alim_ssf=dep_max_alim_pl1_ssf/indice_prix_max_ssf_new

gen depr_max_alim_jr_ssf =(depr_max_alim_ssf*3)/365

sum depr_max_alim_jr_ssf if group_ref_max_menage==1 [aw=weight_hh],d
scalar moy_depr_max_alim_nat_ssf=r(mean)

sum depr_max_alim_jr_ssf if group_ref_max_menage==1 & dummy_sud==0 [aw=weight_hh],d
scalar moy_depr_max_alim_nord_ssf=r(mean)

sum depr_max_alim_jr_ssf if group_ref_max_menage==1 & dummy_sud==1 [aw=weight_hh],d
scalar moy_depr_max_alim_sud_ssf=r(mean)


********* ssc

gen depr_max_alim_ssc=dep_max_alim_pl1_ssc/indice_prix_max_ssc_new

gen depr_max_alim_jr_ssc =(depr_max_alim_ssc*3)/365

sum depr_max_alim_jr_ssc if group_ref_max_menage==1 [aw=weight_hh],d
scalar moy_depr_max_alim_nat_ssc=r(mean)

sum depr_max_alim_jr_ssc if group_ref_max_menage==1 & dummy_sud==0 [aw=weight_hh],d
scalar moy_depr_max_alim_nord_ssc=r(mean)

sum depr_max_alim_jr_ssc if group_ref_max_menage==1 & dummy_sud==1 [aw=weight_hh],d
scalar moy_depr_max_alim_sud_ssc=r(mean)


********* sp

gen depr_max_alim_sp=dep_max_alim_pl1_sp/indice_prix_max_sp_new

gen depr_max_alim_jr_sp =(depr_max_alim_sp*3)/365

sum depr_max_alim_jr_sp if group_ref_max_menage==1 [aw=weight_hh],d
scalar moy_depr_max_alim_nat_sp=r(mean)

sum depr_max_alim_jr_sp if group_ref_max_menage==1 & dummy_sud==0 [aw=weight_hh],d
scalar moy_depr_max_alim_nord_sp=r(mean)

sum depr_max_alim_jr_sp if group_ref_max_menage==1 & dummy_sud==1 [aw=weight_hh],d
scalar moy_depr_max_alim_sud_sp=r(mean)


********* Montant calorique moyen du groupe de référence 

*gen eng_calo_tot_jr =eng_calo_tot/365

sum eng_calo_tot_jr if group_ref_max_menage==1 [aw=weight_hh],d
scalar eng_calo_tot_nat_maxgr_jr=r(mean)

sum eng_calo_tot_jr if group_ref_max_menage==1 & dummy_sud==0 [aw=weight_hh],d
scalar eng_calo_tot_nord_maxgr_jr=r(mean)

sum eng_calo_tot_jr if group_ref_max_menage==1 & dummy_sud==1 [aw=weight_hh],d
scalar eng_calo_tot_sud_maxgr_jr=r(mean)

************ Seuil de pauvreté alimentaire 

scalar maxcal=2700

*********** Annuel et saisons (ssf, ssc et sp)

******** Niveau National********* 

gen za_max_nat_an =(maxcal*(moy_depr_max_alim_nat_an/eng_calo_tot_nat_maxgr_jr))*(moy_ae_menage_nat_maxgr/moy_tail_menage_nat_maxgr)

gen za_max_nat_ssf =(maxcal*(moy_depr_max_alim_nat_ssf/eng_calo_tot_nat_maxgr_jr))*(moy_ae_menage_nat_maxgr/moy_tail_menage_nat_maxgr)

gen za_max_nat_ssc =(maxcal*(moy_depr_max_alim_nat_ssc/eng_calo_tot_nat_maxgr_jr))*(moy_ae_menage_nat_maxgr/moy_tail_menage_nat_maxgr)

gen za_max_nat_sp =(maxcal*(moy_depr_max_alim_nat_sp/eng_calo_tot_nat_maxgr_jr))*(moy_ae_menage_nat_maxgr/moy_tail_menage_nat_maxgr)

********** Nord********

gen za_max_nord_an =(maxcal*(moy_depr_max_alim_nord_an/eng_calo_tot_nord_maxgr_jr))*(moy_ae_menage_nord_maxgr/moy_tail_menage_nord_maxgr)

gen za_max_nord_ssf =(maxcal*(moy_depr_max_alim_nord_ssf/eng_calo_tot_nord_maxgr_jr))*(moy_ae_menage_nord_maxgr/moy_tail_menage_nord_maxgr)

gen za_max_nord_ssc =(maxcal*(moy_depr_max_alim_nord_ssc/eng_calo_tot_nord_maxgr_jr))*(moy_ae_menage_nord_maxgr/moy_tail_menage_nord_maxgr)

gen za_max_nord_sp =(maxcal*(moy_depr_max_alim_nord_sp/eng_calo_tot_nord_maxgr_jr))*(moy_ae_menage_nord_maxgr/moy_tail_menage_nord_maxgr)


********** Sud********

gen za_max_sud_an =(maxcal*(moy_depr_max_alim_sud_an/eng_calo_tot_sud_maxgr_jr))*(moy_ae_menage_sud_maxgr/moy_tail_menage_sud_maxgr)

gen za_max_sud_ssf =(maxcal*(moy_depr_max_alim_sud_ssf/eng_calo_tot_sud_maxgr_jr))*(moy_ae_menage_sud_maxgr/moy_tail_menage_sud_maxgr)

gen za_max_sud_ssc =(maxcal*(moy_depr_max_alim_sud_ssc/eng_calo_tot_sud_maxgr_jr))*(moy_ae_menage_sud_maxgr/moy_tail_menage_sud_maxgr)

gen za_max_sud_sp =(maxcal*(moy_depr_max_alim_sud_sp/eng_calo_tot_sud_maxgr_jr))*(moy_ae_menage_sud_maxgr/moy_tail_menage_sud_maxgr)



****** Extrapolation de la ligne de pauvreté alimentaire

******************Estimation d'une seule courbe d'Engel annuel et national 

gen part_dep_alim_max_an=dep_max_alim_pl1_an/dep_max_menage_an
*gen lae=ln(ae)

**** Pour l'ensemble des ménages et par an et au niveau national

gen depr_max_menage_an=dep_max_menage_an/indice_prix_max_an

gen depr_max_menage_jr = depr_max_menage_an/365
gen lxi_za_max = ln(depr_max_menage_jr)
gen lxi_za_max2 = lxi_za_max^2

********** POUR LE NIVEAU NATIONAL*************

reg part_dep_alim_max_an lxi_za_max lxi_za_max2 lae dummy_sud [aw=weight_hh], vce(robust)

gen z_b_max_nat=_b[lxi_za_max]

gen z_b_max_nat2=_b[lxi_za_max2]

margins,at(lxi_za_max=0 lxi_za_max2=0) atmeans post

margins,coeflegend

gen aj_max_nat=_b[_cons]

********* Pour l'ANNEE

program define myz_max_an 
scalar A_max=za_max_nat_an*moy_tail_menage_nat_maxgr
scalar f_z= z_b_max_nat*ln(`1')+aj_max_nat+z_b_max_nat2*[ln(`1')]^2 -(A_max/`1')
end 

bisect myz_max_an X returns exp f_z=0 from 200 to 2000

**** La solution est :  1162.656 que l'on divisera par moy_ae_menage_nat_maxgr, ce qui donne z_max_nat=275.13

gen z_max_nat=275.13


****** Pour SSF

program define myz_max_ssf 
scalar A_max_ssf=za_max_nat_ssf*moy_tail_menage_nat_maxgr
scalar f_z= z_b_max_nat*ln(`1')+aj_max_nat+z_b_max_nat2*[ln(`1')]^2 -(A_max_ssf/`1')
end 

bisect myz_max_ssf X returns exp f_z=0 from 200 to 2000

**** La solution est : 527.3531 que l'on divisera par moy_ae_menage_nat_maxgr, ce qui donne z_max_nat_ssf=124.79

gen z_max_nat_ssf=124.79


******** Pour SSC

program define myz_max_ssc 
scalar A_max_ssc=za_max_nat_ssc*moy_tail_menage_nat_maxgr
scalar f_z= z_b_max_nat*ln(`1')+aj_max_nat+z_b_max_nat2*[ln(`1')]^2 -(A_max_ssc/`1')
end 

bisect myz_max_ssc X returns exp f_z=0 from 200 to 2000

**** La solution est :  560.6606 que l'on divisera par moy_ae_menage_nat_maxgr, ce qui donne z_max_nat_ssc=132.67

gen z_max_nat_ssc=132.67


******** Pour SP

program define myz_max_sp 
scalar A_max_sp=za_max_nat_sp*moy_tail_menage_nat_maxgr
scalar f_z= z_b_max_nat*ln(`1')+aj_max_nat+z_b_max_nat2*[ln(`1')]^2 -(A_max_sp/`1')
end 

bisect myz_max_sp X returns exp f_z=0 from 200 to 2000

**** La solution est :  582.9628 que l'on divisera par moy_ae_menage_nat_maxgr, ce qui donne z_max_nat_sp=137.96

gen z_max_nat_sp=137.96


********** POUR LE NORD*************

reg part_dep_alim_max_an lxi_za_max lxi_za_max2 lae if dummy_sud==0 [aw=weight_hh], vce(robust)

gen z_b_max_nord=_b[lxi_za_max]

gen z_b_max_nord2=_b[lxi_za_max2]

margins,at(lxi_za_max=0 lxi_za_max2=0) atmeans post

margins,coeflegend

gen aj_max_nord=_b[_cons]

********* Pour l'ANNEE 

program define myz_max_nord_an 
scalar A_nord_max=za_max_nord_an*moy_tail_menage_nord_maxgr
scalar f_z= z_b_max_nord*ln(`1')+aj_max_nord+z_b_max_nord2*[ln(`1')]^2 -(A_nord_max/`1')
end 

bisect myz_max_nord_an X returns exp f_z=0 from 200 to 2000

**** La solution est :  1043.427 que l'on divisera par moy_ae_menage_nord_maxgr, ce qui donne z_max_nord=270.89

gen z_max_nord=270.89


****** Pour SSF

program define myz_max_nord_ssf 
scalar A_max_nord_ssf=za_max_nord_ssf*moy_tail_menage_nord_maxgr
scalar f_z= z_b_max_nord*ln(`1')+aj_max_nord+z_b_max_nord2*[ln(`1')]^2 -(A_max_nord_ssf/`1')
end 

bisect myz_max_nord_ssf X returns exp f_z=0 from 200 to 2000

**** La solution est :  950.82 que l'on divisera par moy_ae_menage_nord_maxgr, ce qui donne z_max_nord_ssf=246.85

gen z_max_nord_ssf=246.85


******** Pour SSC

program define myz_max_nord_ssc 
scalar A_max_nord_ssc=za_max_nord_ssc*moy_tail_menage_nord_maxgr
scalar f_z= z_b_max_nord*ln(`1')+aj_max_nord+z_b_max_nord2*[ln(`1')]^2 -(A_max_nord_ssc/`1')
end 

bisect myz_max_nord_ssc X returns exp f_z=0 from 200 to 2000

**** La solution est :  1095.818 que l'on divisera par moy_ae_menage_nord_maxgr, ce qui donne z_max_nord_ssc=284.50

gen z_max_nord_ssc=284.50


******** Pour SP

program define myz_max_nord_sp 
scalar A_max_nord_sp=za_max_nord_sp*moy_tail_menage_nord_maxgr
scalar f_z= z_b_max_nord*ln(`1')+aj_max_nord+z_b_max_nord2*[ln(`1')]^2 -(A_max_nord_sp/`1')
end 

bisect myz_max_nord_sp X returns exp f_z=0 from 200 to 2000

**** La solution est :  1162.2 que l'on divisera par moy_ae_menage_nord_maxgr, ce qui donne z_max_nord_sp=301.73

gen z_max_nord_sp=301.73


********** POUR LE SUD*************

reg part_dep_alim_max_an lxi_za_max lxi_za_max2 lae if dummy_sud==1 [aw=weight_hh], vce(robust)

gen z_b_max_sud=_b[lxi_za_max]

gen z_b_max_sud2=_b[lxi_za_max2]

margins,at(lxi_za_max=0 lxi_za_max2=0) atmeans post

margins,coeflegend

gen aj_max_sud=_b[_cons]

********* Pour l'ANNEE 

program define myz_max_sud_an 
scalar A_sud_max=za_max_sud_an*moy_tail_menage_sud_maxgr
scalar f_z= z_b_max_sud*ln(`1')+aj_max_sud+z_b_max_sud2*[ln(`1')]^2 -(A_sud_max/`1')
end 

bisect myz_max_sud_an X returns exp f_z=0 from 200 to 2000

**** La solution est :  1263.404 que l'on divisera par moy_ae_menage_sud_maxgr, ce qui donne z_max_sud=278.75

gen z_max_sud=278.75


****** Pour SSF

program define myz_max_sud_ssf 
scalar A_max_sud_ssf=za_max_sud_ssf*moy_tail_menage_sud_maxgr
scalar f_z= z_b_max_sud*ln(`1')+aj_max_sud+z_b_max_sud2*[ln(`1')]^2 -(A_max_sud_ssf/`1')
end 

bisect myz_max_sud_ssf X returns exp f_z=0 from 200 to 2000

**** La solution est :  1176.966 que l'on divisera par moy_ae_menage_sud_maxgr, ce qui donne z_max_sud_ssf=259.68

gen z_max_sud_ssf=259.68


******** Pour SSC

program define myz_max_sud_ssc 
scalar A_max_sud_ssc=za_max_sud_ssc*moy_tail_menage_sud_maxgr
scalar f_z= z_b_max_sud*ln(`1')+aj_max_sud+z_b_max_sud2*[ln(`1')]^2 -(A_max_sud_ssc/`1')
end 

bisect myz_max_sud_ssc X returns exp f_z=0 from 200 to 2000

**** La solution est :   1181.017 que l'on divisera par moy_ae_menage_sud_maxgr, ce qui donne z_max_sud_ssc=260.57

gen z_max_sud_ssc=260.57


******** Pour SP

program define myz_max_sud_sp 
scalar A_max_sud_sp=za_max_sud_sp*moy_tail_menage_sud_maxgr
scalar f_z= z_b_max_sud*ln(`1')+aj_max_sud+z_b_max_sud2*[ln(`1')]^2 -(A_max_sud_sp/`1')
end 

bisect myz_max_sud_sp X returns exp f_z=0 from 200 to 2000

**** La solution est :  1510.298 que l'on divisera par moy_ae_menage_sud_maxgr, ce qui donne z_max_sud_sp=333.22

gen z_max_sud_sp=333.22



*******************************FOR NATIONAL LEVEL************************************

*********************//// POVERTY INDICES /////*************************

********** CHRONIC POVERTY INDICES****************************************

gen pov_min_indicator_nat=(depr_min_ae_jr<z_min_nat)

gen pov_min_noyau_nat=1-(depr_min_ae_jr/z_min_nat)

gen p0_min_nat_estimator=(pov_min_noyau_nat)^0

gen p1_min_nat_estimator=(pov_min_noyau_nat)^1

gen p2_min_nat_estimator=(pov_min_noyau_nat)^2


gen pov_max_indicator_nat=(depr_max_ae_jr<z_max_nat)

gen pov_max_noyau_nat=1-(depr_max_ae_jr/z_max_nat)

gen p0_max_nat_estimator=(pov_max_noyau_nat)^0

gen p1_max_nat_estimator=(pov_max_noyau_nat)^1

gen p2_max_nat_estimator=(pov_max_noyau_nat)^2


gen menage_p0_max_nat=p0_max_nat_estimator*pov_max_indicator_nat

gen menage_p1_max_nat=p1_max_nat_estimator*pov_max_indicator_nat

gen menage_p2_max_nat=p2_max_nat_estimator*pov_max_indicator_nat


gen menage_p0_min_nat=p0_min_nat_estimator*pov_min_indicator_nat

gen menage_p1_min_nat=p1_min_nat_estimator*pov_min_indicator_nat

gen menage_p2_min_nat=p2_min_nat_estimator*pov_min_indicator_nat


gen diff_menage_p0max_min_nat=menage_p0_max_nat-menage_p0_min_nat

gen diff_menage_p1max_min_nat=menage_p1_max_nat-menage_p1_min_nat

gen diff_menage_p2max_min_nat=menage_p2_max_nat-menage_p2_min_nat

*******************************************************************************

sum menage_p0_min_nat [aw=weight_ind_nat]

sum menage_p1_min_nat [aw=weight_ind_nat]

sum menage_p2_min_nat [aw=weight_ind_nat]


sum menage_p0_max_nat [aw=weight_ind_nat]

sum menage_p1_max_nat [aw=weight_ind_nat]

sum menage_p2_max_nat [aw=weight_ind_nat]


sum diff_menage_p0max_min_nat [aw=weight_ind_nat]

sum diff_menage_p1max_min_nat [aw=weight_ind_nat]

sum diff_menage_p2max_min_nat [aw=weight_ind_nat]


********** SEASONAL AND ANNUAL POVERTY INDICES****************************************

*************** SSF

gen pov_min_indicator_nat_ssf=(depr_min_ae_jr_ssf<z_min_nat_ssf)

gen pov_min_noyau_nat_ssf=1-(depr_min_ae_jr_ssf/z_min_nat_ssf)

gen p0_min_nat_estimator_ssf=(pov_min_noyau_nat_ssf)^0

gen p1_min_nat_estimator_ssf=(pov_min_noyau_nat_ssf)^1

gen p2_min_nat_estimator_ssf=(pov_min_noyau_nat_ssf)^2


gen pov_max_indicator_nat_ssf=(depr_max_ae_jr_ssf<z_max_nat_ssf)

gen pov_max_noyau_nat_ssf=1-(depr_max_ae_jr_ssf/z_max_nat_ssf)

gen p0_max_nat_estimator_ssf=(pov_max_noyau_nat_ssf)^0

gen p1_max_nat_estimator_ssf=(pov_max_noyau_nat_ssf)^1

gen p2_max_nat_estimator_ssf=(pov_max_noyau_nat_ssf)^2


gen menage_p0_max_nat_ssf=p0_max_nat_estimator_ssf*pov_max_indicator_nat_ssf

gen menage_p1_max_nat_ssf=p1_max_nat_estimator_ssf*pov_max_indicator_nat_ssf

gen menage_p2_max_nat_ssf=p2_max_nat_estimator_ssf*pov_max_indicator_nat_ssf


gen menage_p0_min_nat_ssf=p0_min_nat_estimator_ssf*pov_min_indicator_nat_ssf

gen menage_p1_min_nat_ssf=p1_min_nat_estimator_ssf*pov_min_indicator_nat_ssf

gen menage_p2_min_nat_ssf=p2_min_nat_estimator_ssf*pov_min_indicator_nat_ssf


gen diff_menage_p0max_min_nat_ssf=menage_p0_max_nat_ssf-menage_p0_min_nat_ssf

gen diff_menage_p1max_min_nat_ssf=menage_p1_max_nat_ssf-menage_p1_min_nat_ssf

gen diff_menage_p2max_min_nat_ssf=menage_p2_max_nat_ssf-menage_p2_min_nat_ssf

*********************************************************************************************

sum menage_p0_min_nat_ssf [aw=weight_ind_nat]

sum menage_p1_min_nat_ssf [aw=weight_ind_nat]

sum menage_p2_min_nat_ssf [aw=weight_ind_nat]


sum menage_p0_max_nat_ssf [aw=weight_ind_nat]

sum menage_p1_max_nat_ssf [aw=weight_ind_nat]

sum menage_p2_max_nat_ssf [aw=weight_ind_nat]


sum diff_menage_p0max_min_nat_ssf [aw=weight_ind_nat]

sum diff_menage_p1max_min_nat_ssf [aw=weight_ind_nat]

sum diff_menage_p2max_min_nat_ssf [aw=weight_ind_nat]


*************** SSC

gen pov_min_indicator_nat_ssc=(depr_min_ae_jr_ssc<z_min_nat_ssc)

gen pov_min_noyau_nat_ssc=1-(depr_min_ae_jr_ssc/z_min_nat_ssc)

gen p0_min_nat_estimator_ssc=(pov_min_noyau_nat_ssc)^0

gen p1_min_nat_estimator_ssc=(pov_min_noyau_nat_ssc)^1

gen p2_min_nat_estimator_ssc=(pov_min_noyau_nat_ssc)^2


gen pov_max_indicator_nat_ssc=(depr_max_ae_jr_ssc<z_max_nat_ssc)

gen pov_max_noyau_nat_ssc=1-(depr_max_ae_jr_ssc/z_max_nat_ssc)

gen p0_max_nat_estimator_ssc=(pov_max_noyau_nat_ssc)^0

gen p1_max_nat_estimator_ssc=(pov_max_noyau_nat_ssc)^1

gen p2_max_nat_estimator_ssc=(pov_max_noyau_nat_ssc)^2


gen menage_p0_max_nat_ssc=p0_max_nat_estimator_ssc*pov_max_indicator_nat_ssc

gen menage_p1_max_nat_ssc=p1_max_nat_estimator_ssc*pov_max_indicator_nat_ssc

gen menage_p2_max_nat_ssc=p2_max_nat_estimator_ssc*pov_max_indicator_nat_ssc


gen menage_p0_min_nat_ssc=p0_min_nat_estimator_ssc*pov_min_indicator_nat_ssc

gen menage_p1_min_nat_ssc=p1_min_nat_estimator_ssc*pov_min_indicator_nat_ssc

gen menage_p2_min_nat_ssc=p2_min_nat_estimator_ssc*pov_min_indicator_nat_ssc


gen diff_menage_p0max_min_nat_ssc=menage_p0_max_nat_ssc-menage_p0_min_nat_ssc

gen diff_menage_p1max_min_nat_ssc=menage_p1_max_nat_ssc-menage_p1_min_nat_ssc

gen diff_menage_p2max_min_nat_ssc=menage_p2_max_nat_ssc-menage_p2_min_nat_ssc

*********************************************************************************************

sum menage_p0_min_nat_ssc [aw=weight_ind_nat]

sum menage_p1_min_nat_ssc [aw=weight_ind_nat]

sum menage_p2_min_nat_ssc [aw=weight_ind_nat]


sum menage_p0_max_nat_ssc [aw=weight_ind_nat]

sum menage_p1_max_nat_ssc [aw=weight_ind_nat]

sum menage_p2_max_nat_ssc [aw=weight_ind_nat]


sum diff_menage_p0max_min_nat_ssc [aw=weight_ind_nat]

sum diff_menage_p1max_min_nat_ssc [aw=weight_ind_nat]

sum diff_menage_p2max_min_nat_ssc [aw=weight_ind_nat]


*************** sp

gen pov_min_indicator_nat_sp=(depr_min_ae_jr_sp<z_min_nat_sp)

gen pov_min_noyau_nat_sp=1-(depr_min_ae_jr_sp/z_min_nat_sp)

gen p0_min_nat_estimator_sp=(pov_min_noyau_nat_sp)^0

gen p1_min_nat_estimator_sp=(pov_min_noyau_nat_sp)^1

gen p2_min_nat_estimator_sp=(pov_min_noyau_nat_sp)^2


gen pov_max_indicator_nat_sp=(depr_max_ae_jr_sp<z_max_nat_sp)

gen pov_max_noyau_nat_sp=1-(depr_max_ae_jr_sp/z_max_nat_sp)

gen p0_max_nat_estimator_sp=(pov_max_noyau_nat_sp)^0

gen p1_max_nat_estimator_sp=(pov_max_noyau_nat_sp)^1

gen p2_max_nat_estimator_sp=(pov_max_noyau_nat_sp)^2


gen menage_p0_max_nat_sp=p0_max_nat_estimator_sp*pov_max_indicator_nat_sp

gen menage_p1_max_nat_sp=p1_max_nat_estimator_sp*pov_max_indicator_nat_sp

gen menage_p2_max_nat_sp=p2_max_nat_estimator_sp*pov_max_indicator_nat_sp


gen menage_p0_min_nat_sp=p0_min_nat_estimator_sp*pov_min_indicator_nat_sp

gen menage_p1_min_nat_sp=p1_min_nat_estimator_sp*pov_min_indicator_nat_sp

gen menage_p2_min_nat_sp=p2_min_nat_estimator_sp*pov_min_indicator_nat_sp


gen diff_menage_p0max_min_nat_sp=menage_p0_max_nat_sp-menage_p0_min_nat_sp

gen diff_menage_p1max_min_nat_sp=menage_p1_max_nat_sp-menage_p1_min_nat_sp

gen diff_menage_p2max_min_nat_sp=menage_p2_max_nat_sp-menage_p2_min_nat_sp

*********************************************************************************************

sum menage_p0_min_nat_sp [aw=weight_ind_nat]

sum menage_p1_min_nat_sp [aw=weight_ind_nat]

sum menage_p2_min_nat_sp [aw=weight_ind_nat]


sum menage_p0_max_nat_sp [aw=weight_ind_nat]

sum menage_p1_max_nat_sp [aw=weight_ind_nat]

sum menage_p2_max_nat_sp [aw=weight_ind_nat]


sum diff_menage_p0max_min_nat_sp [aw=weight_ind_nat]

sum diff_menage_p1max_min_nat_sp [aw=weight_ind_nat]

sum diff_menage_p2max_min_nat_sp [aw=weight_ind_nat]


******************* ANNUAL POVERTY INDICES***********************

sum menage_p1_min_nat_sp menage_p0_min_nat_sp menage_p2_min_nat_sp [aw=weight_ind_nat]
gen menage_p0_min_nat_annual=(menage_p0_min_nat_ssf + menage_p0_min_nat_ssc + menage_p0_min_nat_sp)/3
gen menage_p1_min_nat_annual=(menage_p1_min_nat_ssf + menage_p1_min_nat_ssc + menage_p1_min_nat_sp)/3
gen menage_p2_min_nat_annual=(menage_p2_min_nat_ssf + menage_p2_min_nat_ssc + menage_p2_min_nat_sp)/3
sum menage_p0_min_nat_annual menage_p1_min_nat_annual menage_p2_min_nat_annual [aw=weight_ind_nat]
gen menage_p0_max_nat_annual=(menage_p0_max_nat_ssf + menage_p0_max_nat_ssc + menage_p0_max_nat_sp)/3
gen menage_p1_max_nat_annual=(menage_p1_max_nat_ssf + menage_p1_max_nat_ssc + menage_p1_max_nat_sp)/3
gen menage_p2_max_nat_annual=(menage_p2_max_nat_ssf + menage_p2_max_nat_ssc + menage_p2_max_nat_sp)/3
sum menage_p0_max_nat_annual menage_p1_max_nat_annual menage_p2_max_nat_annual [aw=weight_ind_nat]
gen diff_menage_p0_maxmin_nat_annual=menage_p0_max_nat_annual-menage_p0_min_nat_annual
gen diff_menage_p1_maxmin_nat_annual=menage_p1_max_nat_annual-menage_p1_min_nat_annual
gen diff_menage_p2_maxmin_nat_annual=menage_p2_max_nat_annual-menage_p2_min_nat_annual
sum diff_menage_p0_maxmin_nat_annual diff_menage_p1_maxmin_nat_annual diff_menage_p2_maxmin_nat_annual [aw=weight_ind_nat]

******************* TRANSIENT POVERTY INDICES********************************

sum menage_p0_min_nat menage_p0_min_nat_annual [aw=weight_ind_nat]
gen menage_p0_min_nat_trans=menage_p0_min_nat_annual-menage_p0_min_nat
sum menage_p0_min_nat_trans [aw=weight_ind_nat]
gen menage_p1_min_nat_trans=menage_p1_min_nat_annual-menage_p1_min_nat
gen menage_p2_min_nat_trans=menage_p2_min_nat_annual-menage_p2_min_nat
gen menage_p0_max_nat_trans=menage_p0_max_nat_annual-menage_p0_max_nat
gen menage_p1_max_nat_trans=menage_p1_max_nat_annual-menage_p1_max_nat
gen menage_p2_max_nat_trans=menage_p2_max_nat_annual-menage_p2_max_nat
sum menage_p0_min_nat_trans menage_p1_min_nat_trans menage_p2_min_nat_trans [aw=weight_ind_nat]
sum menage_p0_max_nat_trans menage_p1_max_nat_trans menage_p2_max_nat_trans [aw=weight_ind_nat]
gen dif_menage_p0maxmin_nat_trans=menage_p0_max_nat_trans-menage_p0_min_nat_trans
gen dif_menage_p1maxmin_nat_trans=menage_p1_max_nat_trans-menage_p1_min_nat_trans
gen dif_menage_p2maxmin_nat_trans=menage_p2_max_nat_trans-menage_p2_min_nat_trans



*******************************FOR THE NORTH************************************

*********************//// POVERTY INDICES /////*************************

********** CHRONIC POVERTY INDICES****************************************

gen pov_min_indicator_nord=(depr_min_ae_jr<z_min_nord) if dummy_sud==0

gen pov_min_noyau_nord=1-(depr_min_ae_jr/z_min_nord) if dummy_sud==0

gen p0_min_nord_estimator=(pov_min_noyau_nord)^0 if dummy_sud==0

gen p1_min_nord_estimator=(pov_min_noyau_nord)^1 if dummy_sud==0

gen p2_min_nord_estimator=(pov_min_noyau_nord)^2 if dummy_sud==0


gen pov_max_indicator_nord=(depr_max_ae_jr<z_max_nord) if dummy_sud==0 

gen pov_max_noyau_nord=1-(depr_max_ae_jr/z_max_nord) if dummy_sud==0

gen p0_max_nord_estimator=(pov_max_noyau_nord)^0 if dummy_sud==0

gen p1_max_nord_estimator=(pov_max_noyau_nord)^1 if dummy_sud==0

gen p2_max_nord_estimator=(pov_max_noyau_nord)^2 if dummy_sud==0


*************************************************************************************

gen menage_p0_max_nord=p0_max_nord_estimator*pov_max_indicator_nord if dummy_sud==0

gen menage_p1_max_nord=p1_max_nord_estimator*pov_max_indicator_nord if dummy_sud==0

gen menage_p2_max_nord=p2_max_nord_estimator*pov_max_indicator_nord if dummy_sud==0


gen menage_p0_min_nord=p0_min_nord_estimator*pov_min_indicator_nord if dummy_sud==0

gen menage_p1_min_nord=p1_min_nord_estimator*pov_min_indicator_nord if dummy_sud==0

gen menage_p2_min_nord=p2_min_nord_estimator*pov_min_indicator_nord if dummy_sud==0


gen diff_menage_p0max_min_nord=menage_p0_max_nord-menage_p0_min_nord if dummy_sud==0

gen diff_menage_p1max_min_nord=menage_p1_max_nord-menage_p1_min_nord if dummy_sud==0

gen diff_menage_p2max_min_nord=menage_p2_max_nord-menage_p2_min_nord if dummy_sud==0


************************************************************************************

sum menage_p0_min_nord [aw=weight_ind_nat] if dummy_sud==0

sum menage_p1_min_nord [aw=weight_ind_nat] if dummy_sud==0

sum menage_p2_min_nord [aw=weight_ind_nat] if dummy_sud==0


sum menage_p0_max_nord [aw=weight_ind_nat] if dummy_sud==0

sum menage_p1_max_nord [aw=weight_ind_nat] if dummy_sud==0

sum menage_p2_max_nord [aw=weight_ind_nat] if dummy_sud==0


sum diff_menage_p0max_min_nord [aw=weight_ind_nat] if dummy_sud==0

sum diff_menage_p1max_min_nord [aw=weight_ind_nat] if dummy_sud==0

sum diff_menage_p2max_min_nord [aw=weight_ind_nat] if dummy_sud==0



********** SEASONAL AND ANNUAL POVERTY INDICES****************************************

*************** SSF

gen pov_min_indicator_nord_ssf=(depr_min_ae_jr_ssf<z_min_nord_ssf) if dummy_sud==0

gen pov_min_noyau_nord_ssf=1-(depr_min_ae_jr_ssf/z_min_nord_ssf) if dummy_sud==0

gen p0_min_nord_estimator_ssf=(pov_min_noyau_nord_ssf)^0 if dummy_sud==0

gen p1_min_nord_estimator_ssf=(pov_min_noyau_nord_ssf)^1 if dummy_sud==0

gen p2_min_nord_estimator_ssf=(pov_min_noyau_nord_ssf)^2 if dummy_sud==0

***************************************************************************************

gen pov_max_indicator_nord_ssf=(depr_max_ae_jr_ssf<z_max_nord_ssf) if dummy_sud==0 

gen pov_max_noyau_nord_ssf=1-(depr_max_ae_jr_ssf/z_max_nord_ssf) if dummy_sud==0

gen p0_max_nord_estimator_ssf=(pov_max_noyau_nord_ssf)^0 if dummy_sud==0

gen p1_max_nord_estimator_ssf=(pov_max_noyau_nord_ssf)^1 if dummy_sud==0

gen p2_max_nord_estimator_ssf=(pov_max_noyau_nord_ssf)^2 if dummy_sud==0


*********************************************

gen menage_p0_max_nord_ssf=p0_max_nord_estimator_ssf*pov_max_indicator_nord_ssf if dummy_sud==0

gen menage_p1_max_nord_ssf=p1_max_nord_estimator_ssf*pov_max_indicator_nord_ssf if dummy_sud==0

gen menage_p2_max_nord_ssf=p2_max_nord_estimator_ssf*pov_max_indicator_nord_ssf if dummy_sud==0


gen menage_p0_min_nord_ssf=p0_min_nord_estimator_ssf*pov_min_indicator_nord_ssf if dummy_sud==0

gen menage_p1_min_nord_ssf=p1_min_nord_estimator_ssf*pov_min_indicator_nord_ssf if dummy_sud==0

gen menage_p2_min_nord_ssf=p2_min_nord_estimator_ssf*pov_min_indicator_nord_ssf if dummy_sud==0


gen diff_menage_p0max_min_nord_ssf=menage_p0_max_nord_ssf-menage_p0_min_nord_ssf if dummy_sud==0

gen diff_menage_p1max_min_nord_ssf=menage_p1_max_nord_ssf-menage_p1_min_nord_ssf if dummy_sud==0

gen diff_menage_p2max_min_nord_ssf=menage_p2_max_nord_ssf-menage_p2_min_nord_ssf if dummy_sud==0

***********************************************************************************************
sum menage_p0_min_nord_ssf [aw=weight_ind_nat] if dummy_sud==0

sum menage_p1_min_nord_ssf [aw=weight_ind_nat] if dummy_sud==0

sum menage_p2_min_nord_ssf [aw=weight_ind_nat] if dummy_sud==0


sum menage_p0_max_nord_ssf [aw=weight_ind_nat] if dummy_sud==0

sum menage_p1_max_nord_ssf [aw=weight_ind_nat] if dummy_sud==0

sum menage_p2_max_nord_ssf [aw=weight_ind_nat] if dummy_sud==0


sum diff_menage_p0max_min_nord_ssf [aw=weight_ind_nat] if dummy_sud==0

sum diff_menage_p1max_min_nord_ssf [aw=weight_ind_nat] if dummy_sud==0

sum diff_menage_p2max_min_nord_ssf [aw=weight_ind_nat] if dummy_sud==0


*************** ssc

gen pov_min_indicator_nord_ssc=(depr_min_ae_jr_ssc<z_min_nord_ssc) if dummy_sud==0

gen pov_min_noyau_nord_ssc=1-(depr_min_ae_jr_ssc/z_min_nord_ssc) if dummy_sud==0

gen p0_min_nord_estimator_ssc=(pov_min_noyau_nord_ssc)^0 if dummy_sud==0

gen p1_min_nord_estimator_ssc=(pov_min_noyau_nord_ssc)^1 if dummy_sud==0

gen p2_min_nord_estimator_ssc=(pov_min_noyau_nord_ssc)^2 if dummy_sud==0

***************************************************************************************

gen pov_max_indicator_nord_ssc=(depr_max_ae_jr_ssc<z_max_nord_ssc) if dummy_sud==0 

gen pov_max_noyau_nord_ssc=1-(depr_max_ae_jr_ssc/z_max_nord_ssc) if dummy_sud==0

gen p0_max_nord_estimator_ssc=(pov_max_noyau_nord_ssc)^0 if dummy_sud==0

gen p1_max_nord_estimator_ssc=(pov_max_noyau_nord_ssc)^1 if dummy_sud==0

gen p2_max_nord_estimator_ssc=(pov_max_noyau_nord_ssc)^2 if dummy_sud==0


*********************************************

gen menage_p0_max_nord_ssc=p0_max_nord_estimator_ssc*pov_max_indicator_nord_ssc if dummy_sud==0

gen menage_p1_max_nord_ssc=p1_max_nord_estimator_ssc*pov_max_indicator_nord_ssc if dummy_sud==0

gen menage_p2_max_nord_ssc=p2_max_nord_estimator_ssc*pov_max_indicator_nord_ssc if dummy_sud==0


gen menage_p0_min_nord_ssc=p0_min_nord_estimator_ssc*pov_min_indicator_nord_ssc if dummy_sud==0

gen menage_p1_min_nord_ssc=p1_min_nord_estimator_ssc*pov_min_indicator_nord_ssc if dummy_sud==0

gen menage_p2_min_nord_ssc=p2_min_nord_estimator_ssc*pov_min_indicator_nord_ssc if dummy_sud==0


gen diff_menage_p0max_min_nord_ssc=menage_p0_max_nord_ssc-menage_p0_min_nord_ssc if dummy_sud==0

gen diff_menage_p1max_min_nord_ssc=menage_p1_max_nord_ssc-menage_p1_min_nord_ssc if dummy_sud==0

gen diff_menage_p2max_min_nord_ssc=menage_p2_max_nord_ssc-menage_p2_min_nord_ssc if dummy_sud==0

***********************************************************************************************
sum menage_p0_min_nord_ssc [aw=weight_ind_nat] if dummy_sud==0

sum menage_p1_min_nord_ssc [aw=weight_ind_nat] if dummy_sud==0

sum menage_p2_min_nord_ssc [aw=weight_ind_nat] if dummy_sud==0


sum menage_p0_max_nord_ssc [aw=weight_ind_nat] if dummy_sud==0

sum menage_p1_max_nord_ssc [aw=weight_ind_nat] if dummy_sud==0

sum menage_p2_max_nord_ssc [aw=weight_ind_nat] if dummy_sud==0


sum diff_menage_p0max_min_nord_ssc [aw=weight_ind_nat] if dummy_sud==0

sum diff_menage_p1max_min_nord_ssc [aw=weight_ind_nat] if dummy_sud==0

sum diff_menage_p2max_min_nord_ssc [aw=weight_ind_nat] if dummy_sud==0


*************** sp

gen pov_min_indicator_nord_sp=(depr_min_ae_jr_sp<z_min_nord_sp) if dummy_sud==0

gen pov_min_noyau_nord_sp=1-(depr_min_ae_jr_sp/z_min_nord_sp) if dummy_sud==0

gen p0_min_nord_estimator_sp=(pov_min_noyau_nord_sp)^0 if dummy_sud==0

gen p1_min_nord_estimator_sp=(pov_min_noyau_nord_sp)^1 if dummy_sud==0

gen p2_min_nord_estimator_sp=(pov_min_noyau_nord_sp)^2 if dummy_sud==0

***************************************************************************************

gen pov_max_indicator_nord_sp=(depr_max_ae_jr_sp<z_max_nord_sp) if dummy_sud==0 

gen pov_max_noyau_nord_sp=1-(depr_max_ae_jr_sp/z_max_nord_sp) if dummy_sud==0

gen p0_max_nord_estimator_sp=(pov_max_noyau_nord_sp)^0 if dummy_sud==0

gen p1_max_nord_estimator_sp=(pov_max_noyau_nord_sp)^1 if dummy_sud==0

gen p2_max_nord_estimator_sp=(pov_max_noyau_nord_sp)^2 if dummy_sud==0


*********************************************

gen menage_p0_max_nord_sp=p0_max_nord_estimator_sp*pov_max_indicator_nord_sp if dummy_sud==0

gen menage_p1_max_nord_sp=p1_max_nord_estimator_sp*pov_max_indicator_nord_sp if dummy_sud==0

gen menage_p2_max_nord_sp=p2_max_nord_estimator_sp*pov_max_indicator_nord_sp if dummy_sud==0


gen menage_p0_min_nord_sp=p0_min_nord_estimator_sp*pov_min_indicator_nord_sp if dummy_sud==0

gen menage_p1_min_nord_sp=p1_min_nord_estimator_sp*pov_min_indicator_nord_sp if dummy_sud==0

gen menage_p2_min_nord_sp=p2_min_nord_estimator_sp*pov_min_indicator_nord_sp if dummy_sud==0


gen diff_menage_p0max_min_nord_sp=menage_p0_max_nord_sp-menage_p0_min_nord_sp if dummy_sud==0

gen diff_menage_p1max_min_nord_sp=menage_p1_max_nord_sp-menage_p1_min_nord_sp if dummy_sud==0

gen diff_menage_p2max_min_nord_sp=menage_p2_max_nord_sp-menage_p2_min_nord_sp if dummy_sud==0

***********************************************************************************************
sum menage_p0_min_nord_sp [aw=weight_ind_nat] if dummy_sud==0

sum menage_p1_min_nord_sp [aw=weight_ind_nat] if dummy_sud==0

sum menage_p2_min_nord_sp [aw=weight_ind_nat] if dummy_sud==0


sum menage_p0_max_nord_sp [aw=weight_ind_nat] if dummy_sud==0

sum menage_p1_max_nord_sp [aw=weight_ind_nat] if dummy_sud==0

sum menage_p2_max_nord_sp [aw=weight_ind_nat] if dummy_sud==0


sum diff_menage_p0max_min_nord_sp [aw=weight_ind_nat] if dummy_sud==0

sum diff_menage_p1max_min_nord_sp [aw=weight_ind_nat] if dummy_sud==0

sum diff_menage_p2max_min_nord_sp [aw=weight_ind_nat] if dummy_sud==0

******************* ANNUAL POVERTY INDICES***********************

gen menage_p0_min_nord_annual=(menage_p0_min_nord_ssf + menage_p0_min_nord_ssc + menage_p0_min_nord_sp)/3
gen menage_p1_min_nord_annual=(menage_p1_min_nord_ssf + menage_p1_min_nord_ssc + menage_p1_min_nord_sp)/3
gen menage_p2_min_nord_annual=(menage_p2_min_nord_ssf + menage_p2_min_nord_ssc + menage_p2_min_nord_sp)/3
gen menage_p0_max_nord_annual=(menage_p0_max_nord_ssf + menage_p0_max_nord_ssc + menage_p0_max_nord_sp)/3
gen menage_p1_max_nord_annual=(menage_p1_max_nord_ssf + menage_p1_max_nord_ssc + menage_p1_max_nord_sp)/3
gen menage_p2_max_nord_annual=(menage_p2_max_nord_ssf + menage_p2_max_nord_ssc + menage_p2_max_nord_sp)/3
sum menage_p0_min_nord_annual menage_p1_min_nord_annual menage_p2_min_nord_annual [aw=weight_ind_nat]
sum menage_p0_max_nord_annual menage_p1_max_nord_annual menage_p2_max_nord_annual [aw=weight_ind_nat]
gen dif_menage_p0_maxmin_nord_annual=menage_p0_max_nord_annual-menage_p0_min_nord_annual
gen dif_menage_p1_maxmin_nord_annual=menage_p1_max_nord_annual-menage_p1_min_nord_annual
gen dif_menage_p2_maxmin_nord_annual=menage_p2_max_nord_annual-menage_p2_min_nord_annual
sum dif_menage_p0_maxmin_nord_annual dif_menage_p1_maxmin_nord_annual dif_menage_p2_maxmin_nord_annual [aw=weight_ind_nat]

******************* TRANSIENT POVERTY INDICES********************************

gen menage_p0_min_nord_trans=menage_p0_min_nord_annual-menage_p0_min_nord
gen menage_p1_min_nord_trans=menage_p1_min_nord_annual-menage_p1_min_nord
gen menage_p2_min_nord_trans=menage_p2_min_nord_annual-menage_p2_min_nord
gen menage_p0_max_nord_trans=menage_p0_max_nord_annual-menage_p0_max_nord
gen menage_p1_max_nord_trans=menage_p1_max_nord_annual-menage_p1_max_nord
gen menage_p2_max_nord_trans=menage_p2_max_nord_annual-menage_p2_max_nord
sum  menage_p0_min_nord_trans  menage_p1_min_nord_trans  menage_p2_min_nord_trans [aw=weight_ind_nat]
sum  menage_p0_max_nord_trans  menage_p1_max_nord_trans  menage_p2_max_nord_trans [aw=weight_ind_nat]
gen dif_menage_p0maxmin_nord_trans=menage_p0_max_nord_trans-menage_p0_min_nord_trans
gen dif_menage_p1maxmin_nord_trans=menage_p1_max_nord_trans-menage_p1_min_nord_trans
gen dif_menage_p2maxmin_nord_trans=menage_p2_max_nord_trans-menage_p2_min_nord_trans
sum dif_menage_p0maxmin_nord_trans dif_menage_p1maxmin_nord_trans dif_menage_p2maxmin_nord_trans [aw=weight_ind_nat]


*******************************FOR THE SOUTH************************************

*********************//// POVERTY INDICES /////*************************

********** CHRONIC POVERTY INDICES****************************************

gen pov_min_indicator_sud=(depr_min_ae_jr<z_min_sud) if dummy_sud==1

gen pov_min_noyau_sud=1-(depr_min_ae_jr/z_min_sud) if dummy_sud==1

gen p0_min_sud_estimator=(pov_min_noyau_sud)^0 if dummy_sud==1

gen p1_min_sud_estimator=(pov_min_noyau_sud)^1 if dummy_sud==1

gen p2_min_sud_estimator=(pov_min_noyau_sud)^2 if dummy_sud==1


gen pov_max_indicator_sud=(depr_max_ae_jr<z_max_sud) if dummy_sud==1 

gen pov_max_noyau_sud=1-(depr_max_ae_jr/z_max_sud) if dummy_sud==1

gen p0_max_sud_estimator=(pov_max_noyau_sud)^0 if dummy_sud==1

gen p1_max_sud_estimator=(pov_max_noyau_sud)^1 if dummy_sud==1

gen p2_max_sud_estimator=(pov_max_noyau_sud)^2 if dummy_sud==1


*************************************************************************************

gen menage_p0_max_sud=p0_max_sud_estimator*pov_max_indicator_sud if dummy_sud==1

gen menage_p1_max_sud=p1_max_sud_estimator*pov_max_indicator_sud if dummy_sud==1

gen menage_p2_max_sud=p2_max_sud_estimator*pov_max_indicator_sud if dummy_sud==1


gen menage_p0_min_sud=p0_min_sud_estimator*pov_min_indicator_sud if dummy_sud==1

gen menage_p1_min_sud=p1_min_sud_estimator*pov_min_indicator_sud if dummy_sud==1

gen menage_p2_min_sud=p2_min_sud_estimator*pov_min_indicator_sud if dummy_sud==1


gen diff_menage_p0max_min_sud=menage_p0_max_sud-menage_p0_min_sud if dummy_sud==1

gen diff_menage_p1max_min_sud=menage_p1_max_sud-menage_p1_min_sud if dummy_sud==1

gen diff_menage_p2max_min_sud=menage_p2_max_sud-menage_p2_min_sud if dummy_sud==1


************************************************************************************

sum menage_p0_min_sud [aw=weight_ind_nat] if dummy_sud==1

sum menage_p1_min_sud [aw=weight_ind_nat] if dummy_sud==1

sum menage_p2_min_sud [aw=weight_ind_nat] if dummy_sud==1


sum menage_p0_max_sud [aw=weight_ind_nat] if dummy_sud==1

sum menage_p1_max_sud [aw=weight_ind_nat] if dummy_sud==1

sum menage_p2_max_sud [aw=weight_ind_nat] if dummy_sud==1


sum diff_menage_p0max_min_sud [aw=weight_ind_nat] if dummy_sud==1

sum diff_menage_p1max_min_sud [aw=weight_ind_nat] if dummy_sud==1

sum diff_menage_p2max_min_sud [aw=weight_ind_nat] if dummy_sud==1



********** SEASONAL AND ANNUAL POVERTY INDICES****************************************

*************** SSF

gen pov_min_indicator_sud_ssf=(depr_min_ae_jr_ssf<z_min_sud_ssf) if dummy_sud==1

gen pov_min_noyau_sud_ssf=1-(depr_min_ae_jr_ssf/z_min_sud_ssf) if dummy_sud==1

gen p0_min_sud_estimator_ssf=(pov_min_noyau_sud_ssf)^0 if dummy_sud==1

gen p1_min_sud_estimator_ssf=(pov_min_noyau_sud_ssf)^1 if dummy_sud==1

gen p2_min_sud_estimator_ssf=(pov_min_noyau_sud_ssf)^2 if dummy_sud==1

***************************************************************************************

gen pov_max_indicator_sud_ssf=(depr_max_ae_jr_ssf<z_max_sud_ssf) if dummy_sud==1 

gen pov_max_noyau_sud_ssf=1-(depr_max_ae_jr_ssf/z_max_sud_ssf) if dummy_sud==1

gen p0_max_sud_estimator_ssf=(pov_max_noyau_sud_ssf)^0 if dummy_sud==1

gen p1_max_sud_estimator_ssf=(pov_max_noyau_sud_ssf)^1 if dummy_sud==1

gen p2_max_sud_estimator_ssf=(pov_max_noyau_sud_ssf)^2 if dummy_sud==1


*********************************************

gen menage_p0_max_sud_ssf=p0_max_sud_estimator_ssf*pov_max_indicator_sud_ssf if dummy_sud==1

gen menage_p1_max_sud_ssf=p1_max_sud_estimator_ssf*pov_max_indicator_sud_ssf if dummy_sud==1

gen menage_p2_max_sud_ssf=p2_max_sud_estimator_ssf*pov_max_indicator_sud_ssf if dummy_sud==1


gen menage_p0_min_sud_ssf=p0_min_sud_estimator_ssf*pov_min_indicator_sud_ssf if dummy_sud==1

gen menage_p1_min_sud_ssf=p1_min_sud_estimator_ssf*pov_min_indicator_sud_ssf if dummy_sud==1

gen menage_p2_min_sud_ssf=p2_min_sud_estimator_ssf*pov_min_indicator_sud_ssf if dummy_sud==1


gen diff_menage_p0max_min_sud_ssf=menage_p0_max_sud_ssf-menage_p0_min_sud_ssf if dummy_sud==1

gen diff_menage_p1max_min_sud_ssf=menage_p1_max_sud_ssf-menage_p1_min_sud_ssf if dummy_sud==1

gen diff_menage_p2max_min_sud_ssf=menage_p2_max_sud_ssf-menage_p2_min_sud_ssf if dummy_sud==1

***********************************************************************************************
sum menage_p0_min_sud_ssf [aw=weight_ind_nat] if dummy_sud==1

sum menage_p1_min_sud_ssf [aw=weight_ind_nat] if dummy_sud==1

sum menage_p2_min_sud_ssf [aw=weight_ind_nat] if dummy_sud==1


sum menage_p0_max_sud_ssf [aw=weight_ind_nat] if dummy_sud==1

sum menage_p1_max_sud_ssf [aw=weight_ind_nat] if dummy_sud==1

sum menage_p2_max_sud_ssf [aw=weight_ind_nat] if dummy_sud==1


sum diff_menage_p0max_min_sud_ssf [aw=weight_ind_nat] if dummy_sud==1

sum diff_menage_p1max_min_sud_ssf [aw=weight_ind_nat] if dummy_sud==1

sum diff_menage_p2max_min_sud_ssf [aw=weight_ind_nat] if dummy_sud==1


*************** ssc

gen pov_min_indicator_sud_ssc=(depr_min_ae_jr_ssc<z_min_sud_ssc) if dummy_sud==1

gen pov_min_noyau_sud_ssc=1-(depr_min_ae_jr_ssc/z_min_sud_ssc) if dummy_sud==1

gen p0_min_sud_estimator_ssc=(pov_min_noyau_sud_ssc)^0 if dummy_sud==1

gen p1_min_sud_estimator_ssc=(pov_min_noyau_sud_ssc)^1 if dummy_sud==1

gen p2_min_sud_estimator_ssc=(pov_min_noyau_sud_ssc)^2 if dummy_sud==1

***************************************************************************************

gen pov_max_indicator_sud_ssc=(depr_max_ae_jr_ssc<z_max_sud_ssc) if dummy_sud==1 

gen pov_max_noyau_sud_ssc=1-(depr_max_ae_jr_ssc/z_max_sud_ssc) if dummy_sud==1

gen p0_max_sud_estimator_ssc=(pov_max_noyau_sud_ssc)^0 if dummy_sud==1

gen p1_max_sud_estimator_ssc=(pov_max_noyau_sud_ssc)^1 if dummy_sud==1

gen p2_max_sud_estimator_ssc=(pov_max_noyau_sud_ssc)^2 if dummy_sud==1


*********************************************

gen menage_p0_max_sud_ssc=p0_max_sud_estimator_ssc*pov_max_indicator_sud_ssc if dummy_sud==1

gen menage_p1_max_sud_ssc=p1_max_sud_estimator_ssc*pov_max_indicator_sud_ssc if dummy_sud==1

gen menage_p2_max_sud_ssc=p2_max_sud_estimator_ssc*pov_max_indicator_sud_ssc if dummy_sud==1


gen menage_p0_min_sud_ssc=p0_min_sud_estimator_ssc*pov_min_indicator_sud_ssc if dummy_sud==1

gen menage_p1_min_sud_ssc=p1_min_sud_estimator_ssc*pov_min_indicator_sud_ssc if dummy_sud==1

gen menage_p2_min_sud_ssc=p2_min_sud_estimator_ssc*pov_min_indicator_sud_ssc if dummy_sud==1


gen diff_menage_p0max_min_sud_ssc=menage_p0_max_sud_ssc-menage_p0_min_sud_ssc if dummy_sud==1

gen diff_menage_p1max_min_sud_ssc=menage_p1_max_sud_ssc-menage_p1_min_sud_ssc if dummy_sud==1

gen diff_menage_p2max_min_sud_ssc=menage_p2_max_sud_ssc-menage_p2_min_sud_ssc if dummy_sud==1

***********************************************************************************************
sum menage_p0_min_sud_ssc [aw=weight_ind_nat] if dummy_sud==1

sum menage_p1_min_sud_ssc [aw=weight_ind_nat] if dummy_sud==1

sum menage_p2_min_sud_ssc [aw=weight_ind_nat] if dummy_sud==1


sum menage_p0_max_sud_ssc [aw=weight_ind_nat] if dummy_sud==1

sum menage_p1_max_sud_ssc [aw=weight_ind_nat] if dummy_sud==1

sum menage_p2_max_sud_ssc [aw=weight_ind_nat] if dummy_sud==1


sum diff_menage_p0max_min_sud_ssc [aw=weight_ind_nat] if dummy_sud==1

sum diff_menage_p1max_min_sud_ssc [aw=weight_ind_nat] if dummy_sud==1

sum diff_menage_p2max_min_sud_ssc [aw=weight_ind_nat] if dummy_sud==1


*************** sp

gen pov_min_indicator_sud_sp=(depr_min_ae_jr_sp<z_min_sud_sp) if dummy_sud==1

gen pov_min_noyau_sud_sp=1-(depr_min_ae_jr_sp/z_min_sud_sp) if dummy_sud==1

gen p0_min_sud_estimator_sp=(pov_min_noyau_sud_sp)^0 if dummy_sud==1

gen p1_min_sud_estimator_sp=(pov_min_noyau_sud_sp)^1 if dummy_sud==1

gen p2_min_sud_estimator_sp=(pov_min_noyau_sud_sp)^2 if dummy_sud==1

***************************************************************************************

gen pov_max_indicator_sud_sp=(depr_max_ae_jr_sp<z_max_sud_sp) if dummy_sud==1 

gen pov_max_noyau_sud_sp=1-(depr_max_ae_jr_sp/z_max_sud_sp) if dummy_sud==1

gen p0_max_sud_estimator_sp=(pov_max_noyau_sud_sp)^0 if dummy_sud==1

gen p1_max_sud_estimator_sp=(pov_max_noyau_sud_sp)^1 if dummy_sud==1

gen p2_max_sud_estimator_sp=(pov_max_noyau_sud_sp)^2 if dummy_sud==1


*********************************************

gen menage_p0_max_sud_sp=p0_max_sud_estimator_sp*pov_max_indicator_sud_sp if dummy_sud==1

gen menage_p1_max_sud_sp=p1_max_sud_estimator_sp*pov_max_indicator_sud_sp if dummy_sud==1

gen menage_p2_max_sud_sp=p2_max_sud_estimator_sp*pov_max_indicator_sud_sp if dummy_sud==1


gen menage_p0_min_sud_sp=p0_min_sud_estimator_sp*pov_min_indicator_sud_sp if dummy_sud==1

gen menage_p1_min_sud_sp=p1_min_sud_estimator_sp*pov_min_indicator_sud_sp if dummy_sud==1

gen menage_p2_min_sud_sp=p2_min_sud_estimator_sp*pov_min_indicator_sud_sp if dummy_sud==1


gen diff_menage_p0max_min_sud_sp=menage_p0_max_sud_sp-menage_p0_min_sud_sp if dummy_sud==1

gen diff_menage_p1max_min_sud_sp=menage_p1_max_sud_sp-menage_p1_min_sud_sp if dummy_sud==1

gen diff_menage_p2max_min_sud_sp=menage_p2_max_sud_sp-menage_p2_min_sud_sp if dummy_sud==1

***********************************************************************************************
sum menage_p0_min_sud_sp [aw=weight_ind_nat] if dummy_sud==1

sum menage_p1_min_sud_sp [aw=weight_ind_nat] if dummy_sud==1

sum menage_p2_min_sud_sp [aw=weight_ind_nat] if dummy_sud==1


sum menage_p0_max_sud_sp [aw=weight_ind_nat] if dummy_sud==1

sum menage_p1_max_sud_sp [aw=weight_ind_nat] if dummy_sud==1

sum menage_p2_max_sud_sp [aw=weight_ind_nat] if dummy_sud==1


sum diff_menage_p0max_min_sud_sp [aw=weight_ind_nat] if dummy_sud==1

sum diff_menage_p1max_min_sud_sp [aw=weight_ind_nat] if dummy_sud==1

sum diff_menage_p2max_min_sud_sp [aw=weight_ind_nat] if dummy_sud==1

******************* ANNUAL POVERTY INDICES***********************

gen menage_p0_min_sud_annual=(menage_p0_min_sud_ssf + menage_p0_min_sud_ssc + menage_p0_min_sud_sp)/3
gen menage_p1_min_sud_annual=(menage_p1_min_sud_ssf + menage_p1_min_sud_ssc + menage_p1_min_sud_sp)/3
gen menage_p2_min_sud_annual=(menage_p2_min_sud_ssf + menage_p2_min_sud_ssc + menage_p2_min_sud_sp)/3
gen menage_p0_max_sud_annual=(menage_p0_max_sud_ssf + menage_p0_max_sud_ssc + menage_p0_max_sud_sp)/3
gen menage_p1_max_sud_annual=(menage_p1_max_sud_ssf + menage_p1_max_sud_ssc + menage_p1_max_sud_sp)/3
gen menage_p2_max_sud_annual=(menage_p2_max_sud_ssf + menage_p2_max_sud_ssc + menage_p2_max_sud_sp)/3
sum menage_p0_min_sud_annual menage_p1_min_sud_annual menage_p2_min_sud_annual [aw=weight_ind_nat]
sum menage_p0_max_sud_annual menage_p1_max_sud_annual menage_p2_max_sud_annual [aw=weight_ind_nat]
gen dif_menage_p0_maxmin_sud_annual=menage_p0_max_sud_annual-menage_p0_min_sud_annual
gen dif_menage_p1_maxmin_sud_annual=menage_p1_max_sud_annual-menage_p1_min_sud_annual
gen dif_menage_p2_maxmin_sud_annual=menage_p2_max_sud_annual-menage_p2_min_sud_annual
sum dif_menage_p0_maxmin_sud_annual dif_menage_p1_maxmin_sud_annual dif_menage_p2_maxmin_sud_annual [aw=weight_ind_nat]

******************* TRANSIENT POVERTY INDICES********************************

gen menage_p0_min_sud_trans=menage_p0_min_sud_annual-menage_p0_min_sud
gen menage_p1_min_sud_trans=menage_p1_min_sud_annual-menage_p1_min_sud
gen menage_p2_min_sud_trans=menage_p2_min_sud_annual-menage_p2_min_sud
gen menage_p0_max_sud_trans=menage_p0_max_sud_annual-menage_p0_max_sud
gen menage_p1_max_sud_trans=menage_p1_max_sud_annual-menage_p1_max_sud
gen menage_p2_max_sud_trans=menage_p2_max_sud_annual-menage_p2_max_sud
sum  menage_p0_min_sud_trans  menage_p1_min_sud_trans  menage_p2_min_sud_trans [aw=weight_ind_nat]
sum  menage_p0_max_sud_trans  menage_p1_max_sud_trans  menage_p2_max_sud_trans [aw=weight_ind_nat]
gen dif_menage_p0maxmin_sud_trans=menage_p0_max_sud_trans-menage_p0_min_sud_trans
gen dif_menage_p1maxmin_sud_trans=menage_p1_max_sud_trans-menage_p1_min_sud_trans
gen dif_menage_p2maxmin_sud_trans=menage_p2_max_sud_trans-menage_p2_min_sud_trans
sum dif_menage_p0maxmin_sud_trans dif_menage_p1maxmin_sud_trans dif_menage_p2maxmin_sud_trans [aw=weight_ind_nat]


