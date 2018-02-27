# Data
# library(googlesheets)
# DB <- gs_title("14INV458DB")
# DF <- gs_read(DB, "14INV458DB")

library(readxl)
DF <- read_excel("data/14INV458DB.xlsx")

library(dplyr)
library(forcats)

# stringsAsFactors = TRUE
chrcols <- sapply(DF, is.character)
DF[ , chrcols] <- lapply(DF[ , chrcols], factor)

DF <- DF %>% 
    select(
        edad,
        ciudad,
        menarca,
        menstrual,
        embarazos,
        anticonceptivo,
        previo_pap,
        previo_meses,
        previo_resultado,
        irs,
        parejas,
        ets,
        fumadora,
        ducha,
        colpo_calidad,
        colpo_insatisfactoria,
        colpo_evaluacion,
        colpo_normal,
        colpo_anormal,
        colpo_indicaciones,
        pap_calidad,
        pap_categoria,
        pap_micro,
        pap_reactivo,
        pap_epitelial,
        pap_indicaciones,
        tto,
        bx,
        leep,
        bx_dx,
        lec_dx,
        leep_dx,
        leep_margen
    ) %>% 
    mutate(
        hijos = factor(ifelse(embarazos > 1, "Sí", "No")),
        anticonceptivo_uso = factor(ifelse(anticonceptivo == "Ninguno", "No", "Sí")),
        anticonceptivo_tipo = fct_recode(anticonceptivo, NULL = "Ninguno"),
        anticonceptivo_tipo = fct_lump(anticonceptivo_tipo, other_level = "Otro tipo")
    )

save(DF, file = "DF.Rdata")
