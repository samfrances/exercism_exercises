from functools import cached_property


class Cell:

    @cached_property
    def _callbacks(self):
        return set([])

    def _notify_callbacks(self):
        for callback in self._callbacks:
            callback(self.value)

    def add_callback(self, callback):
        self._callbacks.add(callback)

    def remove_callback(self, callback):
        self._callbacks.discard(callback)


class InputCell(Cell):
    def __init__(self, initial_value):
        self._value = initial_value

    @property
    def value(self):
        return self._value

    @value.setter
    def value(self, val):
        if val != self._value:
            self._value = val
            self._notify_callbacks()


class ComputeCell(Cell):
    def __init__(self, inputs, compute_function):
        self._inputs = inputs
        self._compute_function = compute_function
        for input_ in self._inputs:
            input_.add_callback(self._maybe_notify)
        self._previous_value = self.value

    def _maybe_notify(self, value=None):
        new_value = self.value
        if new_value != self._previous_value:
            self._previous_value = new_value
            self._notify_callbacks()

    @property
    def value(self):
        return self._compute_function([
            input_.value for input_ in self._inputs
        ])
