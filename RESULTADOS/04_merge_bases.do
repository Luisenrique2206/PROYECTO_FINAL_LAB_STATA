************************************************************
* 04. UNIÓN DEL MÓDULO DE EDUCACIÓN CON SUMARIA
* ENAHO 2019
************************************************************

clear all
set more off
set varabbrev off

global root "C:\Users\ACER\Desktop\STATA 2026\FINAL" // Cambiar esta ruta por la ruta local de tu equipo


************************************************************
* 1. ABRIR BASE INDIVIDUAL DE EDUCACIÓN
************************************************************

use ///
"$root\BASE DE DATOS\687-Modulo03\base_analfabetismo_2019.dta", ///
clear

count

isid conglome vivienda hogar codperso


************************************************************
* 2. UNIR CON LA BASE SUMARIA
************************************************************

merge m:1 conglome vivienda hogar using ///
"$root\BASE DE DATOS\687-Modulo34\sumaria_2019_reducida.dta", ///
keepusing(ubigeo dominio estrato mieperho totmieho ///
          pobreza pobre inghog2d gashog2d ///
          ingreso_pc_mensual gasto_pc_mensual)


************************************************************
* 3. VERIFICAR RESULTADO DEL MERGE
************************************************************

tab _merge

count if _merge == 1
count if _merge == 2
count if _merge == 3


************************************************************
* 4. CONSERVAR ÚNICAMENTE OBSERVACIONES UNIDAS
************************************************************

keep if _merge == 3
drop _merge


************************************************************
* 5. CORREGIR ETIQUETAS DE POBREZA
************************************************************

label define pobreza_hogar_lbl ///
    1 "Pobre extremo" ///
    2 "Pobre no extremo" ///
    3 "No pobre", replace

label values pobreza pobreza_hogar_lbl

label define pobre_lbl ///
    0 "No pobre" ///
    1 "Pobre", replace

label values pobre pobre_lbl


************************************************************
* 6. VERIFICAR VARIABLES RESULTANTES
************************************************************

count

describe analfabeto pobreza pobre ///
    ingreso_pc_mensual gasto_pc_mensual ///
    dominio estrato ubigeo

tab pobreza
tab pobre
tab analfabeto


************************************************************
* 7. GUARDAR BASE FINAL UNIDA
************************************************************

save ///
"$root\BASE DE DATOS\base_final_analfabetismo_2019.dta", ///
replace

display as result ///
"04_merge_bases.do ejecutado correctamente"
