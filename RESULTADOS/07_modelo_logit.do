************************************************************
* 07. MODELO LOGIT DE ANALFABETISMO
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
* 2. MODELO LOGIT BASE
************************************************************

logit analfabeto ///
    i.mujer ///
    c.edad ///
    c.edad#c.edad ///
    i.rural ///
    i.pobre ///
    c.ln_ingreso_pc ///
    if !missing(analfabeto), vce(robust)


************************************************************
* 3. MOSTRAR ODDS RATIOS
************************************************************

logistic analfabeto ///
    i.mujer ///
    c.edad ///
    c.edad#c.edad ///
    i.rural ///
    i.pobre ///
    c.ln_ingreso_pc ///
    if !missing(analfabeto), vce(robust)


************************************************************
* 4. EFECTOS MARGINALES PROMEDIO
************************************************************

margins, dydx(mujer rural pobre ln_ingreso_pc)


************************************************************
* 5. MODELO CON INTERACCIÓN MUJER Y ÁREA RURAL
************************************************************

logit analfabeto ///
    i.mujer##i.rural ///
    c.edad ///
    c.edad#c.edad ///
    i.pobre ///
    c.ln_ingreso_pc ///
    if !missing(analfabeto), vce(robust)


************************************************************
* 6. PROBABILIDADES AJUSTADAS POR SEXO Y ÁREA
************************************************************

margins mujer#rural

marginsplot, ///
    title("Probabilidad estimada de analfabetismo") ///
    ytitle("Probabilidad estimada") ///
    xtitle("Sexo y área de residencia") ///
    name(grafico_logit, replace)


************************************************************
* 7. EXPORTAR GRÁFICO
************************************************************

graph export ///
"$root\BASE DE DATOS\probabilidad_logit_mujer_rural.png", ///
replace


************************************************************
* 8. MODELO PROBIT COMO ROBUSTEZ
************************************************************

probit analfabeto ///
    i.mujer ///
    c.edad ///
    c.edad#c.edad ///
    i.rural ///
    i.pobre ///
    c.ln_ingreso_pc ///
    if !missing(analfabeto), vce(robust)

margins, dydx(mujer rural pobre ln_ingreso_pc)


************************************************************
* 9. FINALIZAR
************************************************************

display as result ///
"07_modelo_logit.do ejecutado correctamente"