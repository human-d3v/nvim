import requests as r 
import sys

def fetchDefs(wrd):
    response = r.get("https://api.dictionaryapi.dev/api/v2/entries/en/" + wrd)
    if response.status_code == 200:
        data = response.json()
        definitions = [definition['definition'] for item in data for meaning in item['meanings'] for definition in meaning['definitions']]
        return str(definitions).replace('[','{').replace(']','}')

def fetchSyns(wrd):
    key = 'pYW4F6bAUVtjVyN2yoRI'
    url = "http://thesaurus.altervista.org/thesaurus/v1?word=" + wrd + \
        "&language=en_US&output=json&key=" + key + "&calback=process"
    response = r.get(url)
    if response.status_code == 200:
        data = response.json()
        syns = [synonym.replace(" (generic term)","") for item in 
                data['response'] for synonym in item['list']['synonyms'].split('|')]
        return str(syns).replace('[','{').replace(']','}')

def render_def(wrd):
    lua_table_string = '{word = "' + str(wrd) + '", definition = ' + str(fetchDefs(wrd)) + '}'
    print(lua_table_string)

def render_syn(wrd):
    lua_table_string = '{word = "' + str(wrd) + '", definition = ' + str(fetchSyns(wrd)) + '}'
    print(lua_table_string)

