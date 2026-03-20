
# Parkinson's Disease Data Preprocessing

Este proyecto forma parte de mi portafolio de Machine Learning y Ciencia de Datos. Consiste en un pipeline completo y riguroso de limpieza, exploración y preprocesado de un dataset clínico de 2.105 pacientes para la predicción de la Enfermedad de Parkinson.

**[HAZ CLIC AQUÍ PARA VER EL INFORME COMPLETO E INTERACTIVO](https://enriquealgar.github.io/parkinsons-disease-data-preprocessing/)**

## Tecnologías y Técnicas Aplicadas
El proyecto está desarrollado en **R** utilizando enfoques multivariantes para garantizar un *Data Leakage* cero (cero fuga de datos entre Train y Test):

* **Análisis Exploratorio (EDA):** Evaluación estadística y gráfica (bivariante y univariante) de factores de riesgo y sintomatología clínica.
* **Imputación de Nulos (KNN):** Uso de *K-Nearest Neighbors* estandarizado (`preProcess`) para variables continuas y moda para categóricas, aprendiendo reglas estrictamente sobre el conjunto de entrenamiento.
* **Detección de Anomalías (Isolation Forest):** Identificación de valores atípicos multivariantes mediante algoritmos no supervisados, justificando su retención por criterio médico clínico.
* **Balanceo de Clases (SMOTE):** Aplicación de sobremuestreo sintético en el *Train split* utilizando la métrica de distancia **HEOM** (*Heterogeneous Euclidean-Overlap Metric*) para lidiar correctamente con espacios multidimensionales mixtos (factores y números).

## Estructura del Repositorio
* `parkinsons_disease_data.parquet`: Dataset original bruto.
* `funciones.R`: Script modular con funciones auxiliares personalizadas (gráficos, detección de outliers univariantes).
* `analisis_preprocesado.Rmd`: Código fuente estructurado del análisis.
* `reporte_final.html`: Renderización interactiva de resultados y justificaciones metodológicas.

---
*Desarrollado para asegurar datos íntegros, estandarizados y balanceados, listos para la fase de modelización predictiva.*
