************************************************************
* 01. IMPORTAR MÓDULO DE EDUCACIÓN
* ENAHO 2019
************************************************************

clear all
set more off

global root "C:\Users\ACER\Desktop\STATA 2026\FINAL"


************************************************************
* 1. IMPORTAR BASE ORIGINAL EN FORMATO SPSS
************************************************************

import spss using ///
"$root\BASE DE DATOS\687-Modulo03\Enaho01A-2019-300.sav", ///
clear


************************************************************
* 2. CONVERTIR NOMBRES DE VARIABLES A MINÚSCULAS
************************************************************

rename *, lower


************************************************************
* 3. VERIFICAR BASE Y VARIABLES PRINCIPALES
************************************************************

count

describe p204 p207 p208a p302 factor07 factora07


************************************************************
* 4. GUARDAR BASE EN FORMATO STATA
************************************************************

save ///
"$root\BASE DE DATOS\687-Modulo03\Enaho01A-2019-300.dta", ///
replace

display as result ///
"01_importar_educacion.do ejecutado correctamente"