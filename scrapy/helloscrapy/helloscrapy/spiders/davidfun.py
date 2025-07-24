import scrapy


class DavidfunSpider(scrapy.Spider):
    name = "davidfun"
    allowed_domains = ["davelee-fun.github.io"]
    start_urls = ["https://davelee-fun.github.io/"]

    def parse(self, response):
        # CSS Selector
        title = response.css("h1.sitetitle::text").get()
        # XPATH
        description = response.xpath("//p[@class='lead']/text()").get()
        yield {
            "title":title,
            "description": description.strip()
        }