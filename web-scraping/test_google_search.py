import scraping_tools
search, html = scraping_tools.fetch_google_results("what is a function in python", 10, "en")
print(scraping_tools.parse_google_results(html, search))