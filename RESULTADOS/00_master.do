************************************************************
* 00. ARCHIVO MAESTRO
* PROYECTO FINAL - ANALFABETISMO EN EL PERÚ
* ENAHO 2019
************************************************************

clear all
set more off
set varabbrev off

global root "C:\Users\ACER\Desktop\STATA 2026\FINAL" // Cambiar esta ruta por la ruta local de tu equipo
global do "$root\RESULTADOS"


************************************************************
* EJECUTAR TODOS LOS ARCHIVOS
************************************************************

do "$do\01_importar_educacion.do"

do "$do\02_construir_indicador.do"

do "$do\03_preparar_sumaria.do"

do "$do\04_merge_bases.do"

do "$do\05_construir_variables.do"

do "$do\06_descriptivos.do"

do "$do\07_modelo_logit.do"

do "$do\08_modelos_svy.do"


************************************************************
* FINALIZAR
************************************************************

display as result ///
"PROYECTO COMPLETO EJECUTADO CORRECTAMENTE"
