rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(httr)

orgURL1 = 'https://buy.housefun.com.tw/%E8%B2%B7%E5%B1%8B/%E5%8F%B0%E5%8C%97%E5%B8%82_%E4%BF%A1%E7%BE%A9%E5%8D%80?hd_CityID=0000&hd_AreaID=7&hd_Purpose=K&hd_Sequence=Sequp&hd_Brand=1&hd_SearchGroup=Group01&hd_PM='
orgURL2 = '&hd_Tab=1&dmcode=20141200g06ks0000u0000&gclid=CPvrvNbvs84CFRMIvAodDrQMpg'
#orgURL = 'https://www.ptt.cc/bbs/StupidClown/index.html'

startPage = 1
endPage = 10
alldata = data.frame()
for( i in startPage:endPage)
{
  pttURL <- paste(orgURL1, i, orgURL2, sep='')
  urlExists = url.exists(pttURL)
  
  if(urlExists)
  {
    html = getURL(pttURL, ssl.verifypeer = FALSE)
    xml = htmlParse(html, encoding ='utf-8')
    address = xpathSApply(xml, "//address[@class='address']", xmlValue)
    price = xpathSApply(xml, "//em[@class='wording']", xmlValue)
#    title = xpathSApply(xml, "//div[@class='title']/a//text()", xmlValue)
#    author = xpathSApply(xml, "//div[@class='author']", xmlValue)
#    path = xpathSApply(xml, "//div[@class='title']/a//@href")
#    date = xpathSApply(xml, "//div[@class='date']", xmlValue)
#    response = xpathSApply(xml, "//div[@class='nrec']", xmlValue)
    tempdata = data.frame(address, price)
  }
  alldata = rbind(alldata, tempdata)
}

allDate = levels(alldata$date)
#res = hist(as.numeric(alldata$date), nclass=length(allDate), axes=F) 
#axis(1, at=1:length(allDate), labels=allDate)
#axis(2, at=1:max(res$counts), labels=1:max(res$counts))

write.csv(alldata,"alldata1.csv")

