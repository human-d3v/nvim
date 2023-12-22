import requests as r 
import sys

def fetchDef(wrd):
    response = r.get("https://api.dictionaryapi.dev/api/v2/entries/en/" + wrd)
    if response.status_code == 200:
        data = response.json()
        return data[0]['meanings'][0]['definitions'][0]['definition']

if __name__ == "__main__":
    if len(sys.argv) > 1:
        wrd = sys.argv[1]
        lua_table_string = "{word = '" + str(wrd) + "', definition = '" + str(fetchDef(wrd)) + "'}"
        print(lua_table_string)
    else:
        ValueError("No value provided")
