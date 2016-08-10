rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(httr)

orgURL1 = 'http://www.liontravel.com/webhl/webhtse01.aspx?sLine=9&sCountry=TW&sCity=TPE&sCityzone=&sAdate=20161108&sDays=1&sHtlName=&sAllotment=1&sPriceRangeChecked=&sHotelTypeChecked=&sOrderBy=3&sPageIndex='
orgURL2 = '&sAdultQty=&sChildQty=&sChild1Age=&sChild2Age=&sChild3Age=&sRoomQty=&sPayKind='
#orgURL = 'https://www.ptt.cc/bbs/StupidClown/index.html'

startPage = 1
endPage = 1
alldata = data.frame()
for( i in startPage:endPage)
{
  pttURL <- paste(orgURL1, i, orgURL2, sep='')
  urlExists = url.exists(pttURL)
  
  if(urlExists)
  {
    html = getURL(pttURL, ssl.verifypeer = FALSE)
    xml = htmlParse(html, encoding ='utf-8')
    hotelname = xpathSApply(xml, "//span[@class='title fsxl']/a", xmlValue)
    price = xpathSApply(xml, "//span[@class='red fwb hRght']", xmlValue)
#    //span[@class="item_text"]/span
#    title = xpathSApply(xml, "//div[@class='title']/a//text()", xmlValue)
#    author = xpathSApply(xml, "//div[@class='author']", xmlValue)
#    path = xpathSApply(xml, "//div[@class='title']/a//@href")
#    date = xpathSApply(xml, "//div[@class='date']", xmlValue)
#    response = xpathSApply(xml, "//div[@class='nrec']", xmlValue)
    tempdata = data.frame(hotelname)
  }
  alldata = rbind(alldata, tempdata)
}

allDate = levels(alldata$date)
#res = hist(as.numeric(alldata$date), nclass=length(allDate), axes=F) 
#axis(1, at=1:length(allDate), labels=allDate)
#axis(2, at=1:max(res$counts), labels=1:max(res$counts))

write.csv(alldata,"alldata.csv")

