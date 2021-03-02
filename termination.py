
# Decide when the genetic algorithm should stop.
# Use a maximum number of generations now.

from src import config


def shouldTerminate(population, gen):
    return gen > config.maxGen
