************************************************************
* 08. MODELO FINAL CON DISEÑO MUESTRAL COMPLEJO
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
* 2. DEFINIR EL DISEÑO MUESTRAL
************************************************************

svyset conglome [pweight=factora07], strata(estrato)

svydescribe


************************************************************
* 3. MODELO LOGÍSTICO FINAL
************************************************************

svy: logistic analfabeto ///
    i.mujer ///
    c.edad ///
    c.edad#c.edad ///
    i.rural ///
    i.pobre ///
    c.ln_ingreso_pc ///
    if !missing(analfabeto)


************************************************************
* 4. EFECTOS MARGINALES PROMEDIO
************************************************************

margins, dydx(mujer rural pobre ln_ingreso_pc)


************************************************************
* 5. MODELO CON INTERACCIÓN MUJER Y ÁREA RURAL
************************************************************

svy: logistic analfabeto ///
    i.mujer##i.rural ///
    c.edad ///
    c.edad#c.edad ///
    i.pobre ///
    c.ln_ingreso_pc ///
    if !missing(analfabeto)


************************************************************
* 6. PROBABILIDADES AJUSTADAS
************************************************************

margins mujer#rural

marginsplot, ///
    title("Probabilidad ajustada de analfabetismo") ///
    subtitle("Modelo logístico con diseño muestral ENAHO 2019") ///
    ytitle("Probabilidad estimada") ///
    xtitle("Sexo y área de residencia") ///
    name(grafico_svy, replace)


************************************************************
* 7. EXPORTAR GRÁFICO
************************************************************

graph export ///
"$root\BASE DE DATOS\probabilidad_svy_mujer_rural.png", ///
replace


************************************************************
* 8. FINALIZAR
************************************************************

display as result ///
"08_modelo_final_svy.do ejecutado correctamente"