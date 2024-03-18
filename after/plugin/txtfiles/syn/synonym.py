import funcs
import sys


if __name__ == "__main__":
    if len(sys.argv) > 1:
        wrd = sys.argv[1]
        lua_table_string = funcs.render_syn(wrd)
    else: 
        ValueError("No Value Provided")
