# funciones.R -----------------------------------------------------------
# Este script contiene funciones auxiliares para el preprocesado de datos.

library(ggplot2)
library(dplyr)
library(rlang)

# 1. Histograma Univariante
histogram_plot <- function(data, var, bins = 40){
  if (!var %in% colnames(data)) {
    stop("La variable especificada no existe en el dataframe")
  }
  
  var_sym <- as.symbol(var)
  
  # Filtrar NAs
  data_na_omit <- data %>% select(!!var_sym) %>% filter(!is.na(!!var_sym))
  
  # Calcular media y sd
  media <- mean(data_na_omit[[1]])
  desv <- sd(data_na_omit[[1]])
  
  # Crear histograma + línea de normalidad
  ggplot(data_na_omit, aes(x = !!var_sym)) +
    geom_histogram(aes(y = after_stat(density)), bins = bins, fill = "lightblue", color = "white") +
    stat_function(fun = dnorm, args = list(mean = media, sd = desv), color = "red", linewidth = 1) +
    ggtitle(paste("Histograma de", var)) +
    ylab("Densidad") +
    theme_minimal() +
    theme(axis.text.y = element_text(size = 8))  # Evitar apelotonamiento
}

# 2. Histograma Bivariante (según Diagnosis)
histogram_var_target_plot <- function(data, var, target_var = "Diagnosis", bins = 40){
  if (!(var %in% colnames(data)) || !(target_var %in% colnames(data))) {
    stop("Una o ambas variables especificadas no existen en el dataframe")
  }
  
  var_sym <- as.symbol(var)
  target_sym <- as.symbol(target_var)
  
  data_na_omit <- data %>% select(!!var_sym, !!target_sym) %>% filter(!is.na(!!var_sym))
  
  ggplot(data_na_omit, aes(x = !!var_sym, fill = !!target_sym)) +
    geom_histogram(bins = bins, position = "identity", alpha = 0.6) +
    scale_fill_manual(values = c("#1D3557", "#FFC300")) +
    ggtitle(paste("Histograma de", var, "según", target_var)) +
    ylab("Frecuencia") +
    theme_minimal()
}

# 3. Boxplot Bivariante (según Diagnosis)
boxplot_var_target_plot <- function(data, var, target_var = "Diagnosis"){
  if (!(var %in% colnames(data)) || !(target_var %in% colnames(data))) {
    stop("Una o ambas variables especificadas no existen en el dataframe")
  }
  
  var_sym <- as.symbol(var)
  target_sym <- as.symbol(target_var)
  
  data_na_omit <- data %>% select(!!var_sym, !!target_sym) %>% filter(!is.na(!!var_sym))
  
  ggplot(data_na_omit, aes(x = !!target_sym, y = !!var_sym, fill = !!target_sym)) +
    geom_boxplot(alpha = 0.85, outlier.colour = "red", outlier.size = 2) +
    # COLORES CORPORATIVOS: Azul Marino y Amarillo
    scale_fill_manual(values = c("#1D3557", "#FFC300")) +
    ggtitle(paste("Cajas y bigotes de", var, "según", target_var)) +
    ylab(var) +
    xlab("Diagnóstico") +
    theme_minimal() +
    theme(legend.position = "none", plot.title = element_text(size = 10, face = "bold"))
}

# 4. Detección de Outliers Univariantes
outliers_univariantes <- function(data, var) {
  if (!var %in% colnames(data)) {
    stop("La variable especificada no existe en el dataframe")
  }
  
  # Identificación de outliers univariantes
  outliers <- boxplot.stats(data[[var]])$out
  
  # Crear columna de outliers SÍ / NO
  outlier_col_name <- paste0("outlier_", var)
  data[[outlier_col_name]] <- ifelse(data[[var]] %in% outliers, 1, 0)
  
  return(data)
}

# 5. Conteo de valores distintos y porcentajes
distinct_function_count <- function(data, var){
  var <- as.symbol(var)
  counts_values_var <- data %>% group_by(!!var) %>% count %>% arrange(desc(n))
  
  total <- sum(counts_values_var$n)
  counts_values_var <- counts_values_var %>% mutate(percentage = round(n / total * 100, 3))
  
  return(counts_values_var)
}



