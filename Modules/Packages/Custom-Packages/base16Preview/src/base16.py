#!/usr/bin/env python

from flask import Flask, render_template
import yaml
import os


def loadThemes():
    r_val = {}
    script_path = os.path.realpath(__file__)
    dir_path = os.path.dirname(script_path)
    theme_path = os.path.join(dir_path, 'themes')
    for file in os.listdir(theme_path):
        f_path = os.path.join(theme_path, file)

        with open(f_path, 'r') as f:
            theme = yaml.load(f, Loader=yaml.SafeLoader)

        key = theme['scheme'].replace(' ', '-').lower()

        r_val[key] = theme

    return r_val


THEMES = loadThemes()
THM_IDX = list(THEMES.keys())
THM_IDX.sort()
OPT_LBL = [{'label': THEMES[val]['scheme'], 'option': val} for val in THM_IDX]


app = Flask(__name__)


@app.route('/')
@app.route('/<string:curr_theme>')
def default(curr_theme='3024'):
    theme = THEMES[curr_theme]
    curr_idx = THM_IDX.index(curr_theme)
    next_idx = (curr_idx + 1) % 251
    prev_idx = curr_idx - 1

    next_theme = THM_IDX[next_idx]
    prev_theme = THM_IDX[prev_idx]

    return render_template('default.html.j2',
                           themes=OPT_LBL,
                           curr_theme=theme['scheme'],
                           next_theme=next_theme,
                           prev_theme=prev_theme,
                           **theme)


@app.route('/favicon.ico')
def favicon():
    return '', 204


if __name__ == '__main__':
    app.run()
