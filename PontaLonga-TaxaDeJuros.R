library(GetTDData)
library(xts)
library(highcharter)
library(widgetframe)


ntnb   <- download.TD.data('NTN-B')

ntnb50 <- read.TD.files(dl.folder = 'TD Files', 
                        maturity = '150850')

### Data.frame da NTN-B 2050 em XTS
dates50          <- as.Date(ntnb50$ref.date, format = "%YY/%m/%d") 
ntnb50_ytm_xts   <- as.xts(ntnb50[,2]*100, order.by = dates50)
ntnb50_preco_xts <- as.xts(ntnb50[,3], order.by = dates50)

### Plot da YTM e Preço da NTN-B 2050 
frameWidget(hchart(ntnb50_ytm_xts, color = "blue", 
                   name = "Taxa de Juros Prefixada da NTN-B") %>%
              hc_yAxis_multiples(
                list(lineWidth = 3),
                list(showLastLabel = FALSE, opposite = TRUE)) %>%
              hc_add_series(ntnb50_preco_xts, color = "black", 
                            name = "Preço da NTN-B", yAxis = 1) %>%
              hc_title(text = "Preço e Yield to Maturity (YTM) | NTN-B 2050", margin = 10, 
                       style = list(fontSize= "14px")) %>%
              hc_subtitle(text = "Dados Diários: Jun/12 a Jun/21")) 