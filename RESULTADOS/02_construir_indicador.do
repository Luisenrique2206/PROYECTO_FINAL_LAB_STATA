************************************************************
* 02. CONSTRUCCIÓN DEL INDICADOR DE ANALFABETISMO
* ENAHO 2019
************************************************************

clear all
set more off

global root "C:\Users\ACER\Desktop\STATA 2026\FINAL"


************************************************************
* 1. ABRIR BASE DE EDUCACIÓN
************************************************************

use ///
"$root\BASE DE DATOS\687-Modulo03\Enaho01A-2019-300.dta", ///
clear


************************************************************
* 2. VERIFICAR VARIABLES NECESARIAS
************************************************************

count

describe p204 p208a p302 factora07


************************************************************
* 3. CONSTRUIR INDICADOR
************************************************************

capture drop analfabeto

gen analfabeto = 0 if p208a >= 15 & p204 == 1

replace analfabeto = 1 if ///
    p208a >= 15 & ///
    p204 == 1 & ///
    p302 == 2


************************************************************
* 4. ETIQUETAS
************************************************************

label define analfabeto_lbl ///
    0 "Sabe leer y escribir" ///
    1 "No sabe leer ni escribir", replace

label values analfabeto analfabeto_lbl

label variable analfabeto ///
"Condición de analfabetismo de la población de 15 años a más"


************************************************************
* 5. VERIFICACIÓN DEL INDICADOR
************************************************************

count if !missing(analfabeto)

tab analfabeto

tab analfabeto [iw=factora07]

mean analfabeto [pw=factora07]


************************************************************
* 6. GUARDAR BASE
************************************************************

save ///
"$root\BASE DE DATOS\687-Modulo03\base_analfabetismo_2019.dta", ///
replace

display as result ///
"02_construir_indicador.do ejecutado correctamente"