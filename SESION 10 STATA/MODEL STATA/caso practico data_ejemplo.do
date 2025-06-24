*================================================================================
***************Modelos 1 y 2 - Base de datos EGP**************************
*MSc. Ciro Ivan Machacuay Meza
*================================================================================

*================================================================================
* 1. Estadísticas descriptivas básicas
*================================================================================
summarize
summarize EGP ESC_AL EDAD_AL GEN_AL PROF_AL EFP_AL DYS_AL
*Generar bucles de summarize para variables de regidor 1

* Gráficos de distribución
histogram EGP, frequency title("Distribución de EGP%")
graph export "hist_egp.png", replace

* Gráficos de Box
graph box EGP 
graph box EDAD_AL 

**Generar bucles de graficos de box segun la naturaleza de la variable y del regidor 1

*para variables categoricas, transformar y luego genrar graficos
recode GEN_AL (1 = 1 "Femenino") (2 = 2 "Masculino"), gen(GEN_AL_cat)
graph box EGP, over(GEN_AL)
graph box EGP, over(GEN_AL_cat)
graph box EGP, over(Departamento)
graph box EGP, over(Años)

**Generar bucles de recodificacion y graficos de box segun la naturaleza de la variable y del regidor 1

*=================================================================================
*2. prueba de normalidad
*================================================================================
*prueba de kolgomorov de smirnov <50 observaciones
* Instalar el comando ksnorm (si no está instalado)
*Kolmogorov-Smirnov (para n ≥ 50)

*Si el valor p ≤ α: Se rechaza la hipótesis nula. Se concluye que los datos no siguen una distribución normal . 
*Si el valor p > α: No se rechaza la hipótesis nula. Se concluye que los datos siguen una distribuidos normal.

summarize    

*ksmirnov EGP = normal((EGP - r(mean))/r(sd))

ksmirnov EGP = normal((EGP - 78.12909)/14.129523)
*p ≤ α: Se rechaza la hipótesis nula. Se concluye que los datos no siguen una distribución normal. 

**Generar bucles de prueba segun la naturaleza de la variable y del regidor 1

*Gráfico básico de distribución normal
histogram EGP, normal title("Ejecución del gasto público") xtitle("EGP") ytitle("Densidad")
**Generar bucles de graficos segun la naturaleza de la variable y del regidor 1

*=================================================================================
* 3. Matriz de correlación
*================================================================================

correlate EGP ESC_AL EDAD_AL GEN_AL PROF_AL EFP_AL DYS_AL

**Generar bucles de correlación para el regidor 1

* Gráfico de dispersión EGP vs EDAD_AL
twoway (scatter EGP EDAD_AL) (lfit EGP EDAD_AL), ///
       title("EGP% vs Edad del Alcalde") ///
       ytitle("EGP%") xtitle("Edad del Alcalde")
graph export "scatter_edad.png", replace

* Gráfico de dispersión EGP vs ESC_AL
twoway (scatter EGP ESC_AL) (lfit EGP ESC_AL), ///
       title("EGP% vs Escolaridad del Alcalde") ///
       ytitle("EGP%") xtitle("Años de Escolaridad")
graph export "scatter_esc.png", replace

**Generar bucles de graficos segun la naturaleza de la variable y del regidor 1

* Gráfico de matriz de dispersión para varias variables
graph matrix EGP ESC_AL EDAD_AL GEN_AL, half ///
       title("Matriz de Dispersión de Variables Seleccionadas")
graph export "matrix_plot.png", replace
**Generar bucles de graficos segun la naturaleza de la variable y del regidor 1

*=================================================================================
*3. Regresion lineal
*================================================================================

* Modelo de regresión lineal básico
regress EGP ESC_AL EDAD_AL GEN_AL PROF_AL EFP_AL DYS_AL
**Generar bucles de regresión para el regidor 1

*pruebas
*a.Test de heterocedasticidad
*Si el valor p es menor que el nivel de significancia (generalmente 0.05), se rechaza la hipótesis nula, indicando heterocedasticidad. Esto significa que hay evidencia de que la varianza de los errores no es constante. 
*Si el valor p es mayor o igual al nivel de significancia, no se rechaza la hipótesis nula, indicando homocedasticidad. En este caso, no hay evidencia suficiente para afirmar que la varianza de los errores no es constante. 

estat hettest

**Generar bucles de prueba para el regidor 1


*b.Test de Multicolinealidad
*VIF < 5: Multicolinealidad baja.
*VIF ≥ 5 y < 10: Multicolinealidad moderada.
*VIF ≥ 10: Problema grave (considera eliminar variables).

regress EGP ESC_AL EDAD_AL GEN_AL PROF_AL EFP_AL DYS_AL
vif
**Generar bucles de prueba para el regidor 1

