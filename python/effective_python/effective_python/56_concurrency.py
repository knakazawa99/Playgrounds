from itertools import count
from operator import ge, ne
from re import S
from sre_parse import State


ALIVE = '-'
EMPTY = '*'


class Grid:
    def __init__(self, height, width) -> None:
        self.height = height
        self.width = width
        self.rows = []
        for _ in range(self.height):
            self.rows.append([EMPTY] * self.width)
    
    def get(self, y, x):
        return self.rows[y % self.height][x % self.width]
    
    def set(self, y, x, state):
        self.rows[y % self.height][x % self.width] = state
    
    def __str__(self):
        print("....")

def count_neighbor(y, x, get):
    n_ = get(y -1, x + 0)
    ne = get(y - 1, x + 1)
    e_ = get(y + 0, x + 1)
    se = get(y + 1, x + 1)
    s_ = get(y + 1, x + 0)
    sw = get(y + 1, x - 1)
    w_ = get(y + 0, x - 1)
    nw = get(y - 1, x - 1)
    neighbor_states = [n_, ne, e_, se, s_, sw, w_, nw]
    count = 0
    for state in neighbor_states:
        if state == ALIVE:
            count += 1
    return count

def game_logic(state, neighbor):
    if state == ALIVE:
        if neighbor < 2:
            return EMPTY
        elif neighbor > 3:
            return EMPTY
    else:
        if neighbor == 3:
            return ALIVE
    return state

def step_cell(y, x, get, set):
    state = get(y, x)
    neighbors = count_neighbor(y, x, get)
    next_state = game_logic(state, neighbors)
    set(y, x, next_state)

def simulate(grid: Grid):
    next_grid = Grid(grid.height, grid.width)
    for y in range(grid.height):
        for x in range(grid.width):
            step_cell(y, x, grid.get, next_grid.set)
    return next_grid

grid = Grid(5, 9)
grid.set(0, 3, ALIVE)
grid.set(1, 4, ALIVE)
grid.set(2, 2, ALIVE)
