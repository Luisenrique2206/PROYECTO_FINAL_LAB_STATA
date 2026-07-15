************************************************************
* 03. PREPARACIÓN DE LA BASE SUMARIA
* ENAHO 2019
************************************************************

clear all
set more off
set varabbrev off

global root "C:\Users\ACER\Desktop\STATA 2026\FINAL"


************************************************************
* 1. IMPORTAR BASE SUMARIA EN FORMATO SPSS
************************************************************

import spss using ///
"$root\BASE DE DATOS\687-Modulo34\Sumaria-2019.sav", ///
clear


************************************************************
* 2. CONVERTIR NOMBRES DE VARIABLES A MINÚSCULAS
************************************************************

rename *, lower


************************************************************
* 3. VERIFICAR BASE Y VARIABLES PRINCIPALES
************************************************************

count

describe conglome vivienda hogar ubigeo dominio estrato ///
    mieperho totmieho pobreza inghog2d gashog2d factor07

tab pobreza, nolabel


************************************************************
* 4. CREAR VARIABLE BINARIA DE POBREZA
************************************************************

gen pobre = inlist(pobreza, 1, 2) if !missing(pobreza)

label define pobre_lbl ///
    0 "No pobre" ///
    1 "Pobre", replace

label values pobre pobre_lbl
label variable pobre "Condición de pobreza monetaria"

tab pobre


************************************************************
* 5. CREAR INGRESO Y GASTO PER CÁPITA MENSUAL
************************************************************

gen ingreso_pc_mensual = ///
    (inghog2d / mieperho) / 12 ///
    if inghog2d >= 0 & mieperho > 0

gen gasto_pc_mensual = ///
    (gashog2d / mieperho) / 12 ///
    if gashog2d >= 0 & mieperho > 0

label variable ingreso_pc_mensual ///
    "Ingreso neto per cápita mensual del hogar"

label variable gasto_pc_mensual ///
    "Gasto per cápita mensual del hogar"


************************************************************
* 6. CONSERVAR VARIABLES NECESARIAS
************************************************************

keep conglome vivienda hogar ubigeo dominio estrato ///
    mieperho totmieho pobreza pobre ///
    inghog2d gashog2d ///
    ingreso_pc_mensual gasto_pc_mensual factor07


************************************************************
* 7. VERIFICAR IDENTIFICADOR ÚNICO DEL HOGAR
************************************************************

isid conglome vivienda hogar

duplicates report conglome vivienda hogar


************************************************************
* 8. REVISAR VARIABLES CREADAS
************************************************************

describe pobreza pobre ingreso_pc_mensual gasto_pc_mensual

tab pobreza, nolabel
tab pobre

summarize ingreso_pc_mensual gasto_pc_mensual, detail


************************************************************
* 9. GUARDAR BASE REDUCIDA
************************************************************

save ///
"$root\BASE DE DATOS\687-Modulo34\sumaria_2019_reducida.dta", ///
replace

display as result ///
"03_preparar_sumaria.do ejecutado correctamente"