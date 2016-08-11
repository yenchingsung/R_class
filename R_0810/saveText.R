rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(NLP)
library(httr)

#Sys.setlocale("LC_ALL", "cht")
#https://www.settour.com.tw/ec/prodline/hdp/step1.html?prodNo=HDP0000020572&pst=&ped=&termCd1=

alldata = read.csv('./R_class/R_0810/alldata.csv')
orgURL1 = 'https://www.settour.com.tw/ec/prodline/hdp/step1.html?prodNo='
orgURL2 = '&pst=&ped=&termCd1='
for( i in 1:length(alldata$X))
{
  pttURL <- paste(orgURL1, alldata$url[i], orgURL2, sep='')
  urlExists = url.exists(pttURL)
  
  if(urlExists)
  {
    html = getURL(pttURL, ssl.verifypeer = FALSE, encoding='UTF-8')
    xml = htmlParse(html, encoding='UTF-8')
    text = xpathSApply(xml, "//li[@itemprop='description']", xmlValue)
    name <- paste('./R_class/R_0810/allText/c', i, '.txt', sep='')
    write(text, name)
  }
}
