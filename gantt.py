
# Illustrate the Gantt chart of Brandimarate data

import random
import numpy as np

import matplotlib.pyplot as plt
import matplotlib.font_manager as font_manager
from matplotlib import colors as mcolors

colors = []

for name, hex in mcolors.cnames.items():
    colors.append(name)


def parse_data(file):
    try:
        textlist = open(file).readlines()
    except:
        return

    data = {}

    for tx in textlist:
        if not tx.startswith('#'):
            splitted_line = tx.split(',')
            machine = splitted_line[0]
            operations = []

            for op in splitted_line[1::]:
                label = op.split(':')[0].strip()
                l = op.split(':')[1].strip().split('-')
                start = int(l[0])
                end = int(l[1])
                operations.append([start, end, label])

            data[machine] = operations
    return data


def draw_chart(data):
    nb_row = len(data.keys())

    pos = np.arange(0.5, nb_row * 0.5 + 0.5, 0.5)

    fig = plt.figure(figsize=(20, 8))
    ax = fig.add_subplot(111)

    index = 0
    max_len = []

    for machine, operations in sorted(data.items()):
        for op in operations:
            max_len.append(op[1])
            c = random.choice(colors)
            rect = ax.barh((index * 0.5) + 0.5, op[1] - op[0], left=op[0], height=0.3, align='center',
                           edgecolor=c, color=c, alpha=0.8)

            # adding label
            width = int(rect[0].get_width())
            Str = "OP_{}".format(op[2])
            xloc = op[0] + 0.50 * width
            clr = 'black'
            align = 'center'

            yloc = rect[0].get_y() + rect[0].get_height() / 2.0
            ax.text(xloc, yloc, Str, horizontalalignment=align,
                            verticalalignment='center', color=clr, weight='bold',
                            clip_on=True)
        index += 1

    ax.set_ylim(ymin=-0.1, ymax=nb_row * 0.5 + 0.5)
    ax.grid(color='gray', linestyle=':')
    ax.set_xlim(0, max(10, max(max_len)))

    labelsx = ax.get_xticklabels()
    plt.setp(labelsx, rotation=0, fontsize=10)

    locsy, labelsy = plt.yticks(pos, data.keys())
    plt.setp(labelsy, fontsize=14)

    font = font_manager.FontProperties(size='small')
    ax.legend(loc=1, prop=font)

    ax.invert_yaxis()

    plt.title("Flexible Job Shop Solution")
    plt.savefig('gantt.svg')
    plt.show()


if __name__ == '__main__':
    fname = r"test.txt"
    draw_chart(parse_data(fname))
