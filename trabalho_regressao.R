#aluno: PRISCILA CASTILHO PALAZZO
#RA: 619202237
#e-mail: pripalazzo@gmail.com

getwd()

#carregando a biblioteca ggplot2
library(ggplot2)

  #Importando os dados de housing.csv
housing <- read.csv("housing.csv")

#tipo de arquivo: data frame
class(housing)

#conhecendo os dados
head(housing)
dim(housing)
summary(housing)
str(housing)


#carregando as bibliotecas: tidyverse / dplyr / MASS
library(tidyverse)

library(dplyr)

library(MASS)


#****************************EXERC�CIOS*******************************************

# 1a) 
# Os novos nomes dever�o ser: Neighborhood, Class, Units, YearBuilt, SqFt, Income, 
# IncomePerSqFt, Expense, ExpensePerSqFt, NetIncome, Value, ValuePerSqFt e Boro.
# Salve os nomes novos em um vetor de caracteres nomes_novos. Salve este vetor em 
# colnames(housing). renomeando os nomes das colunas

#Vetor de caracteres
nomes_novos <- c("Neighborhood", "Class", "Units", "YearBuilt",
                 "SqFt", "Income", "IncomePerSqFt", "Expense",
                 "ExpensePerSqFt", "NetIncome", "Value",
                 "ValuePerSqFt","Boro")

colnames(housing) <- nomes_novos

# 1b-1) 
# Fa�a um histograma colocando no eixo x ValuePerSqFt. Este histograma possui a 
# caracter�stica de bimodalidade. Pesquise sobre o que pode significar um histograma 
# bimodal e o que isso pode implicar para o Cientista de dados a respeito do conjunto 
# de dados.

#Histograma com eixo x ValuePerSqFt

ggplot(data = housing)+
  geom_histogram(mapping = aes(x = ValuePerSqFt),
                 colour = "black", fill = "blue", bins = 20)+
  ggtitle("Distribui��o Value Per Square Foot")+
  theme(plot.title = element_text(hjust = 0.5))

### An�lise: Percebe-se no histograma bimodal plotado com 2 picos (2 modas) e assim�trico. 
# Pode ser conveniente dividir a amostra em por��es para uma melhor an�lise. Como recomendado 
# pelo excerc�cio, dividiu-se a amostra por distritos, o que melhorou a an�lise dos dados,
# uma vez que cada regi�o possui valores por p� quadrado.
# Histogramas assim�tricos n�o possuem distribui��o normal, o que faz que t�cnicas de ajustes 
# sejam empregadas na busca de um melhor grau de acur�cia para as predi��es. 

# 1b-2) 
# Plote um histograma para cada um dos bairros: Manhatan, Brooklyn, Queens, Bronx e Staten
# Island. Produza uma breve an�lise sobre o que � poss�vel concluir a respeito desses 
# histogramas. Os histogramas apresentam forte assimetria? Em que isto pode afetar a 
# regress�o?
## Histogramas referem-se a valor por p� quadrado X quantidade de im�veis

# Manhatan
ggplot(data = housing%>%filter(Boro=="Manhattan"))+
  geom_histogram(mapping = aes(x = ValuePerSqFt),
                 colour = "black", fill = "yellow", bins = 15)+
  ggtitle("Manhattan")+
  theme(plot.title = element_text(hjust = 0.5))

## Observa��o Manhatan: boa distribui��o de dados (forte simetria). � um histograma que apresenta 2 
## modas entre os valores de 175 e 225, com frequ�ncia superior nestes 2 picos a quantidade 
## de 275. Comparado as demais localiza��es, � um local bem populoso e o local mais bem avaliado.

# Brooklyn
ggplot(data = housing%>%filter(Boro=="Brooklyn"))+
  geom_histogram(mapping = aes(x = ValuePerSqFt),
                 colour = "black", fill = "gray", bins = 15)+
  ggtitle("Brooklyn")+
  theme(plot.title = element_text(hjust = 0.5))

## Observa��o Brooklin: forte assimetria na distribui��o de dados. � um histograma que apresenta
## outliers acima dos valores de 175, o que pode interferir caso utilize-se a m�dia em alguma 
## an�lise. Comparado as demais localiza��es, � segundo local mais bem avaliado e tamb�m o segundo mais populoso.

# Queens
ggplot(data = housing%>%filter(Boro=="Queens"))+
  geom_histogram(mapping = aes(x = ValuePerSqFt),
                 colour = "black", fill = "blue", bins = 15)+
  ggtitle("Queens")+
  theme(plot.title = element_text(hjust = 0.5))

## Observa��o Queens: forte assimetria na distribui��o de dados, apresentando 2 picos. 
# Apresenta outlier no valor acima de 300.

# Bronx
ggplot(data = housing%>%filter(Boro=="Bronx"))+
  geom_histogram(mapping = aes(x = ValuePerSqFt),
                 colour = "black", fill = "red", bins = 10)+
  ggtitle("Bronx")+
  theme(plot.title = element_text(hjust = 0.5))

## Observa��o Bronx: forte assimetria na distribui��o de dados, apresentando 2 picos (2 modas). 
# Os valores dos im�veis s�o baixo comparados as outras localiza��es.

# Staten Island
ggplot(data = housing%>%filter(Boro=="Staten Island"))+
  geom_histogram(mapping = aes(x = ValuePerSqFt),
                 colour = "black", fill = "pink")+
  ggtitle("Staten Island")+
  theme(plot.title = element_text(hjust = 1))

## observa��o Staten Island: forte assimetria nos dados. As 2 maiores frequ�ncias est�o para
#os valores entre 20 a 40 (valor por p� quadrado). Quando analisado reduzindo o intervalo da 
#escala do eixo (x), pode-se notar uma curva com n�o assim�trica. 


# 1b-3) 
# Investigue NA�s (Not Available = missing data = dados ausentes)

#i) Fa�a summary(housing). Voc� identifica valores ausentes?

summary(housing)

# Existem 96 valores NA's na coluna YearBuilt

#ii) Fa�a sum(is.na(housing) para contar quantos s�o os valores ausentes.

sum(is.na(housing))

# Resultado: 96 valores

#iii) Eles est�o espalhados por mais de uma vari�vel?
#Os valores ausentes est�o concentrados em uma vari�vel que � YearBuilt.

#iv) Pesquise sobre os comandos na.omit e complete.cases.

dados_omit <- na.omit(housing)
summary(dados_omit)

#O comando na.omit removeu todos os casos incompletos de um objeto de dados (foi criada 
# uma vari�vel chamada de dados_omint para observa��o do comando). 

complete.cases(housing)

# O comando complete.cases indica linhas que est�o completas como TRUE e linhas incompletas 
# (NA�s) como FALSE.


#v) Fa�a a tabela de dupla entrada tabela_Boro_class<-xtabs (~Boro + Class, data = housing). 
#Algo chama a aten��o?

tabela_Boro_class<-xtabs (~Boro + Class, data = housing)
tabela_Boro_class

# Na tabela de dupla entrada tabela_Boro_class o que me chamou a aten��o foi a alta frequ�ncia
# para os dados R4-condominium em Manhattam e a baixa frequencia de dados para Staten Island, 
# de somente 26 im�veis concentrados tamb�m na classifica��o de R4-condominium.


#iv)Fa�a prop.table(tabela_Boro_class)

prop.table(tabela_Boro_class)
tabela_Boro_class

# Com o comando prop.table consegue-se verificar a distribui��o das frequencias de cada 
# local e subdivis�o considerando 100% dos dados (soma de 2626 conforme comando dim).
# � poss�vel verificar a frequencia de distribui��o como: Manhattan (R4-condominium) em 
# primeiro lugar, Brooklin (R4-condominium) em segundo lugar e Queens (R4-condominium) em 
# terceiro lugar


# Execu��o do "data Preprocessing" para corre��o de dados ausentes(NA�s), com a substitui��o pela m�dia obtida pelo summary.


housing$YearBuilt[which(is.na(housing$YearBuilt))] = 1967


# Codifica��o de vari�veis categ�ricas nas colunas Class e Boro
housing$Class <- factor(housing$Class, 
                        levels = c("R2-CONDOMINIUM", "R4-CONDOMINIUM",
                                   "R9-CONDOMINIUM", "RR-CONDOMINIUM"),
                        labels = c(1, 2, 3, 4))

housing$Boro <- factor(housing$Boro,
                       levels = c("Bronx", "Brooklyn", "Manhattan",
                                  "Queens", "Staten Island"),
                       labels = c(1, 2, 3, 4, 5))

#c) Construa os modelos de regress�o 

#Modelo 1 - house1

house1 <- lm(formula = ValuePerSqFt ~ Units + SqFt + YearBuilt +
               Income + Boro, 
             data = housing)

summary(house1)

# O modelo house1 apresenta o R-Quadrado Ajustado em 66,79% (modelo explica a propor��o da
# varia��o da vari�vel dependente na taxa mencionada), e com vari�veis independentes com 
# baixa signific�ncia estat�stica: Units(p=0.329) e Boro5 (p=0.220)
# O F-statistic como p < 2.2e-16, indica que o modelo possui boa qualidade.

#Modelo 2 - house2

house2 <- lm(formula = ValuePerSqFt ~ Units*SqFt + YearBuilt +
               IncomePerSqFt + Income + Boro, 
             data = housing)

summary(house2)

# O modelo house2 apresenta o R-Quadrado Ajustado em 93,26% (modelo explica a propor��o da
# varia��o da vari�vel dependente na taxa mencionada), mas apresenta apresenta vari�veis 
# independentes com baixa signific�ncia estat�stica: Units(p=0.1706), SqFt(p=0.7995), Income
# (p=0.9506) e Boros.
# As vari�veis quando multiplicadas Unit Sqft apresentam um baixo grau de relev�ncia (p = 0.0536).
# O F-statistic como p < 2.2e-16, indica que o modelo possui boa qualidade.


#Modelo 3 - house3

house3 <- lm(formula = ValuePerSqFt ~ log(Units) + log(SqFt) + Boro, 
             data = housing)

summary(house3)

# O modelo house3 apresenta o R-Quadrado Ajustado em 59,6%  mas apresenta vari�veis independentes
# com baixa signific�ncia estat�stica para os Boros.
# O F-statistic como p < 2.2e-16, indica que o modelo possui boa qualidade.

#Modelo 4 - house4

house4 <- lm(formula = log(ValuePerSqFt) ~ log(Units)+log(SqFt)+Boro, 
             data = housing)

summary(house4)

# O modelo house4 explica a varia��o da vari�vel ValuePerSqFt em apro-
# ximadamente 60%, apresenta vari�veis independentes com signific�ncia
# estat�stica. A �nica vari�vel independente que possui baixa signific�ncia
# � a Boro5 com p = 22.36%.
# O F-statistic como p < 2.2e-16, indica que o modelo possui boa qualidade.

## Os 4 modelos apresentaram o mesmo F-statistic.


### Compara��o dos modelos atrav�s do Akaike Information Criteria

AIC(house1, house2, house3, house4)

# Comparando modelos utilizando o Akaike Information Criteria (indica qual modelo est� mais
# ajustado. Quanto menor o valor de AIC melhor � o modelo. Segue os valores dos modelos:

#house1 10 26771.382
#house2 12 22587.293
#house3  8 27285.516
#house4  8  2108.935

# Como o modelo house4 apresenta o menor valor para AIC, indico que o modelo house 4 � o 
# mais ajustado.


#d)	Apresente os gr�ficos de res�duos x fitted para cada um dos modelos. O que eles sugerem? 

# Modelo house1
# Gr�fico Res�duos X Fitted

plot(fitted(house1), residuals(house1), 
     xlab = "fitted", ylab = "Res�duos",
     main = "house1 model", col = "blue")
abline(h=0, col = "red", lwd = 3)


# Modelo house2
# Gr�fico Res�duos X Fitted 

plot(fitted(house2), residuals(house2), 
     xlab = "fitted", ylab = "Res�duos",
     main = "house2 model", col = 'red')
abline(h=0, col = "blue", lwd = 3)

# Modelo house3
# Gr�fico Res�duos X Fitted 

plot(fitted(house3), residuals(house3), 
     xlab = "fitted", ylab = "Res�duos",
     main = "house3 model")
abline(h=0, col = "blue", lwd = 3)

# Modelo house4
# Gr�fico Res�duos X Fitted 

plot(fitted(house4), residuals(house4), 
     xlab = "fitted", ylab = "Res�duos",
     main = "house4 model", col = "green")
abline(h=0, col = "blue", lwd = 3)


# Os gr�ficos de res�duos X fitted plotados apresentam caracteristicas de heterocedasticidade. 
# Os gr�ficos apresentam forte dispers�o dos dados e varia��o da vari�ncia. Todos apresentaram
# outliers.
# O modelo que melhor representaria em rela��o a homocedasticidade/heterocedasticidade
# � o modelo house4. 


# e)	Fa�a o correspondente teste de Hip�tese. Qual sua conclus�o para cada modelo?

# Instala��o da biblioteca car

library(car)

##Teste de Hip�tese para Heterocedasticidade


# house1 

ncvTest(house1)

# house2 

ncvTest(house2)

# house3 

ncvTest(house3)

# house4

ncvTest(house4) 


# O Teste de Hip�tese para Heterocedasticidade apresentou para todos os modelos p-value 
# abaixo no n�vel de signific�ncia alfa de 0.05.
# Os modelos house1, house2 e house3 apresentaram p = < 2.22e-16, devendo-se rejeitar H0


# f) Apresente os gr�ficos qqPlot para cada modelo. O que eles sugerem?


# house1
qqnorm(residuals(house1), ylab = "Res�duos house1", col = "red")
qqline(residuals(house1), lwd = 4, col = "blue")


# house2
qqnorm(residuals(house2), ylab = "Res�duos house2", col = "dark green")
qqline(residuals(house2), lwd = 4, col = "blue")


# house3
qqnorm(residuals(house3), ylab = "Res�duos house3", col = "purple")
qqline(residuals(house3), lwd = 4, col = "blue")

# house4
qqnorm(residuals(house4), ylab = "Res�duos house4", col = "orange")
qqline(residuals(house4), lwd = 3, col = "blue")

# Em todos os gr�ficos de res�duos n�o notou-se uma distribui��o normal. 
# Os pontos apresentaram-se distantes em v�rios momentos da reta.


# g) Fa�a o correspondente teste de hip�tese. Qual sua conclus�o? 


# house1
shapiro.test(residuals(house1))

# house2
shapiro.test(residuals(house2))

# house3
shapiro.test(residuals(house3))

# house4
shapiro.test(residuals(house4))


# Com o teste shapiro.wilk todos osmodelos apresentaram os valores de p-value < 2.2e-16
# Em todos os modelos H0 foi descartado, ou seja, as amostras n�o seguiram uma distribui��o 
# normal.


# h) Algum dos modelos apresenta problemas de multicolinearidade?  

library(rms)

# Teste Multicolinearidade house1
vif(house1)
sqrt(vif(house1)) > 2 

# Teste Multicolinearidade house2
vif(house2)
sqrt(vif(house2)) > 2 

# Teste Multicolinearidade house3
vif(house3)
sqrt(vif(house3)) > 2 

# Teste Multicolinearidade house4
vif(house4)
sqrt(vif(house4)) > 2 

# Todos os modelos analisados apresentaram problemas de multicolinearidade

# Todos os modelos trabalhados apresentaram problemas de heterocedasticidade, multicolinearidade 
# e distribui��o n�o normal.