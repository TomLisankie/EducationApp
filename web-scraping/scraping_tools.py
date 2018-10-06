# from requests import get
# from requests.exceptions import RequestException
import requests
from contextlib import closing
from bs4 import BeautifulSoup

USER_AGENT = {"User-Agent" : "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36"}

def fetch_google_results(search_term, num_results, language_code):
    assert isinstance(search_term, str), "Search term must be a string."
    assert isinstance(num_results, int), "Number of results must be an integer."
    escaped_search_term = search_term.replace(" ", "+")

    google_url = "https://google.com/search?q={}&num={}&hl={}".format(escaped_search_term, num_results, language_code)
    response = requests.get(google_url, headers = USER_AGENT)
    response.raise_for_status()

    print(google_url)
    return search_term, response.text

def parse_google_results(html, keyword):
    raw_html = BeautifulSoup(html, "html.parser")
    found_results = []
    result_block = raw_html.find_all("div", attrs = {"class" : "g"})
    for result in result_block:
        link = result.find("a", href = True)
        title = result.find("h3", attrs = {"class" : "r"})
        if link and title:
            link = link["href"]
            title = title.get_text()
            if link != "#":
                found_results.append({"title" : title, "link": link})
    return found_results

def simple_get(url):
    """
    Attempts to get the content at `url` by making an HTTP GET request. If the content-type is some kind of HTML/XML, return the text content. Otherwise, return None.
    """
    try:
        with closing(requests.get(url, stream = True)) as response:
            if is_good_response(response):
                return response.content
            else:
                return None
    except requests.RequestException as e:
        log_error("Error during requests to {0} : {1}".format(url, str(e)))
        return None
    
def is_good_response(response):
    """
    Returns True if the response seems to be HTML. Returns False otherwise.
    """
    content_type = response.headers["Content-Type"].lower()
    return ((response.status_code == 200) and (content_type is not None) and content_type.find("html") > -1)

def log_error(e):
    """
    Just prints the error for now.
    """
    print(e)