************************************************************
* 06. ESTADÍSTICAS DESCRIPTIVAS
* ENAHO 2019
************************************************************

clear all
set more off
set varabbrev off

global root "C:\Users\ACER\Desktop\STATA 2026\FINAL"


************************************************************
* 1. ABRIR BASE DEL MODELO
************************************************************

use ///
"$root\BASE DE DATOS\base_modelo_analfabetismo_2019.dta", ///
clear

count if !missing(analfabeto)


************************************************************
* 2. TASA NACIONAL DE ANALFABETISMO
************************************************************

mean analfabeto [pw=factora07] ///
    if !missing(analfabeto)

tab analfabeto [iw=factora07] ///
    if !missing(analfabeto)


************************************************************
* 3. ANALFABETISMO SEGÚN SEXO
************************************************************

mean analfabeto [pw=factora07] ///
    if !missing(analfabeto), over(mujer)

tab mujer analfabeto [iw=factora07], row


************************************************************
* 4. ANALFABETISMO SEGÚN ÁREA DE RESIDENCIA
************************************************************

mean analfabeto [pw=factora07] ///
    if !missing(analfabeto), over(rural)

tab rural analfabeto [iw=factora07], row


************************************************************
* 5. ANALFABETISMO SEGÚN POBREZA
************************************************************

mean analfabeto [pw=factora07] ///
    if !missing(analfabeto), over(pobre)

tab pobre analfabeto [iw=factora07], row


************************************************************
* 6. DESCRIPTIVOS DE VARIABLES CONTINUAS
************************************************************

summarize edad ingreso_pc_mensual ln_ingreso_pc ///
    if !missing(analfabeto)

mean edad ingreso_pc_mensual ln_ingreso_pc ///
    [pw=factora07] if !missing(analfabeto)


************************************************************
* 7. TABLA CRUZADA SEXO Y ÁREA
************************************************************

mean analfabeto [pw=factora07] ///
    if !missing(analfabeto), over(mujer rural)


************************************************************
* 8. GUARDAR RESULTADOS EN LOG
************************************************************

display as result ///
"06_descriptivos.do ejecutado correctamente"