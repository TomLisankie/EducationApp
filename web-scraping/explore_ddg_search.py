from bs4 import BeautifulSoup
from scraping_tools import simple_get
import urllib
raw_html = simple_get("https://duckduckgo.com/html/?q=what%20is%20a%20function%20in%20python")
html = BeautifulSoup(raw_html, "html.parser")
for a in html.find_all("a", href=True):
    print(urllib.parse.unquote(a["href"]))