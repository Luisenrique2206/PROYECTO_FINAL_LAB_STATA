************************************************************
* 05. CONSTRUCCIÓN DE VARIABLES PARA EL MODELO
* ENAHO 2019
************************************************************

clear all
set more off
set varabbrev off

global root "C:\Users\ACER\Desktop\STATA 2026\FINAL"


************************************************************
* 1. ABRIR BASE FINAL UNIDA
************************************************************

use ///
"$root\BASE DE DATOS\base_final_analfabetismo_2019.dta", ///
clear

count


************************************************************
* 2. CREAR VARIABLE MUJER
************************************************************

gen mujer = (p207 == 2) if !missing(p207)

label define mujer_lbl ///
    0 "Hombre" ///
    1 "Mujer", replace

label values mujer mujer_lbl
label variable mujer "Sexo de la persona"


************************************************************
* 3. CREAR EDAD Y EDAD AL CUADRADO
************************************************************

gen edad = p208a if !missing(p208a)

gen edad2 = edad^2 if !missing(edad)

label variable edad "Edad en años cumplidos"
label variable edad2 "Edad al cuadrado"


************************************************************
* 4. CREAR VARIABLE DE ÁREA RURAL
************************************************************

gen rural = inrange(estrato, 6, 8) if !missing(estrato)

label define rural_lbl ///
    0 "Urbano" ///
    1 "Rural", replace

label values rural rural_lbl
label variable rural "Área de residencia"


************************************************************
* 5. CREAR LOGARITMO DEL INGRESO PER CÁPITA
************************************************************

gen ln_ingreso_pc = ln(ingreso_pc_mensual) ///
    if ingreso_pc_mensual > 0

label variable ln_ingreso_pc ///
    "Logaritmo del ingreso per cápita mensual"


************************************************************
* 6. CREAR CÓDIGO DE DEPARTAMENTO
************************************************************

gen dpto = real(substr(ubigeo, 1, 2))

label variable dpto "Código de departamento"


************************************************************
* 7. VERIFICAR VARIABLES CREADAS
************************************************************

describe analfabeto mujer edad edad2 rural pobre ///
    ingreso_pc_mensual ln_ingreso_pc dpto

tab mujer
tab rural
tab pobre

summarize edad edad2 ingreso_pc_mensual ln_ingreso_pc


************************************************************
* 8. VERIFICAR MUESTRA DEL MODELO
************************************************************

count if !missing(analfabeto, mujer, edad, rural, pobre, ln_ingreso_pc)

misstable summarize ///
    analfabeto mujer edad rural pobre ln_ingreso_pc


************************************************************
* 9. GUARDAR BASE PARA EL MODELO
************************************************************

save ///
"$root\BASE DE DATOS\base_modelo_analfabetismo_2019.dta", ///
replace

display as result ///
"05_construir_variables.do ejecutado correctamente"